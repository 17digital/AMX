PROGRAM_NAME='Epiphan_Pearl_V1'
(***********************************************************)
(*  FILE CREATED ON: 02/15/2017  AT: 09:10:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/25/2020  AT: 22:58:57        *)
(***********************************************************)

(**
    Epiphan Pearl2 Notes...
    No Feedback Reading or API for USB Transfer!...
    Needs Verbose Mode for detailed feedback. Example to query layout only sends back interger. Needs detail of Channel, etc.
    Also no detailed feedback for GET rec Status or Stream Status
    
    Recording Timer returns only seconds...
        
**)
    

DEFINE_DEVICE


dvTP_Recorder =			10001:4:0
dvTP_RecBooth =		10004:4:0


dvPearlRec =			5001:2:0


DEFINE_CONSTANT

TL_TIMER		= 15

//Channels....
CHANNEL_AV_SERVICES		= 3
CHANNEL_LIBRARY			= 3

//Layouts..Defined within Pearl...
LAYOUT_FULL_CAMERA		= 1
LAYOUT_FULL_CONTENT		= 2
LAYOUT_EQUAL			= 3
LAYOUT_CAM_PIP			= 4
LAYOUT_CONTENT_PIP		= 5
LAYOUT_PRODUCTION		= 6 //PUll from Ross Video Feed

//Buttons...
BTN_START_REC			= 1
BTN_STOP_REC			= 2
BTN_START_STREAM		= 3
BTN_STOP_STREAM			= 4

BTN_LAYOUT_FULL_CAM		= 9
BTN_LAYOUT_FULL_CON		= 10
BTN_LAYOUT_EQUAL		= 11
BTN_LAYOUT_CAM_PIP		= 12
BTN_LAYOUT_CONT_PIP		= 13
BTN_LAYOUT_CONT_PRO		= 14 //Production

BTN_REC_TOGGLE			= 101

TXT_REC_STATUS			= 10
TXT_USB_STATUS			= 11
TXT_TIMER		= 12


#IF_NOT_DEFINED 		CR 
CR 					= 13
#END_IF

#IF_NOT_DEFINED		LF 
LF 					= 10
#END_IF

DEFINE_VARIABLE

VOLATILE CHAR nPearlBuffer[500]
VOLATILE LONG lRecordTimer[] = {1000} //1 Second Pull...

VOLATILE INTEGER lSecondTimer
VOLATILE INTEGER nMinuteStamp
VOLATILE INTEGER nHourStamp
VOLATILE INTEGER nUsbInUse_

VOLATILE DEV vdvTP_Capture[] = 
{
    dvTP_Recorder, 
    dvTP_RecBooth
}
VOLATILE INTEGER nLayoutBtns[] =
{ 
    BTN_LAYOUT_FULL_CAM,
    BTN_LAYOUT_FULL_CON,
    BTN_LAYOUT_EQUAL,
    BTN_LAYOUT_CAM_PIP,
    BTN_LAYOUT_CONT_PIP,
    BTN_LAYOUT_CONT_PRO		
}
VOLATILE INTEGER nLayoutSends[] =
{
    LAYOUT_FULL_CAMERA,
    LAYOUT_FULL_CONTENT,
    LAYOUT_EQUAL,
    LAYOUT_CAM_PIP,
    LAYOUT_CONTENT_PIP,
    LAYOUT_PRODUCTION		
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Recorder, BTN_START_REC],[dvTP_Recorder, BTN_STOP_REC])
([dvTP_Recorder, BTN_START_STREAM],[dvTP_Recorder, BTN_STOP_STREAM])
([dvTP_Recorder, BTN_LAYOUT_FULL_CAM]..[dvTP_Recorder, BTN_LAYOUT_CONT_PRO])

([dvTP_RecBooth, BTN_START_REC],[dvTP_RecBooth, BTN_STOP_REC])
([dvTP_RecBooth, BTN_START_STREAM],[dvTP_RecBooth, BTN_STOP_STREAM])
([dvTP_RecBooth, BTN_LAYOUT_FULL_CAM]..[dvTP_RecBooth, BTN_LAYOUT_CONT_PRO])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnQueryStatus()
{
    SEND_STRING dvPearlRec, "'STATUS.',ITOA(CHANNEL_AV_SERVICES),CR"
    WAIT 50 SEND_STRING dvPearlRec, "'GET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled',CR"

}
DEFINE_FUNCTION fnSwitchLayout(INTEGER cLayout)
{
    SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.active_layout=',ITOA(cLayout),CR"
    
    SWITCH (cLayout)
    {
	CASE LAYOUT_FULL_CAMERA : ON [vdvTP_Capture, BTN_LAYOUT_FULL_CAM]
	CASE LAYOUT_FULL_CONTENT : ON [vdvTP_Capture, BTN_LAYOUT_FULL_CON]
	CASE LAYOUT_EQUAL : ON [vdvTP_Capture, BTN_LAYOUT_EQUAL]
	CASE LAYOUT_CAM_PIP : ON [vdvTP_Capture, BTN_LAYOUT_CAM_PIP]
	CASE LAYOUT_CONTENT_PIP : ON [vdvTP_Capture, BTN_LAYOUT_CONT_PIP]
	CASE LAYOUT_PRODUCTION : ON [vdvTP_Capture, BTN_LAYOUT_CONT_PRO]
    }
    
    WAIT 5
    {
	SEND_STRING dvPearlRec, "'SAVECFG',CR"
    }
}
DEFINE_FUNCTION fnParsePearl()
{
    STACK_VAR CHAR cMsgs[100]
    LOCAL_VAR CHAR nRecState[15]
    LOCAL_VAR CHAR cTimer[4]
    LOCAL_VAR CHAR cDbug[20]
    
    cMsgs = DATA.TEXT
    
    IF (FIND_STRING(cMsgs,"'Status.',ITOA(CHANNEL_AV_SERVICES),' '",1))
    {
	cDbug = cMsgs
	REMOVE_STRING(cMsgs,"'Status.',ITOA(CHANNEL_AV_SERVICES),' '",1)
	nRecState = cMsgs
		
		
	IF(FIND_STRING(nRecState,'Stopped',1))
	{
	    ON [vdvTP_Capture, BTN_STOP_REC]
		ON [vdvTP_Capture, BTN_STOP_STREAM]
		    OFF [vdvTP_Capture, BTN_REC_TOGGLE]
			SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Stopped'" 
			    
	    IF(TIMELINE_ACTIVE(TL_TIMER))
	    {
		TIMELINE_KILL(TL_TIMER)
	    }
	    IF (nUsbInUse_)
	    {
		SEND_COMMAND dvTP_Recorder, "'PPON-_Warning'" //Hold for 30sec +
		    SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Status : Finishing / Do not Remove USB!'" 
		    WAIT 300
		    {
			SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Status : Complete'" 
				    OFF [nUsbInUse_]
		    }
	    }
	}
	IF(FIND_STRING(nRecState,'Running',1))
	{
	    ON [vdvTP_Capture, BTN_START_REC]
		ON [vdvTP_Capture, BTN_START_STREAM]
		    ON [vdvTP_Capture, BTN_REC_TOGGLE]
			ON [nUsbInUse_] //Flag USB transfer...
			    SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Started'" 
			    
	    IF (!TIMELINE_ACTIVE(TL_TIMER))
	    {
		fnResetTimerToZero()
		    TIMELINE_CREATE(TL_TIMER,lRecordTimer,LENGTH_ARRAY(lRecordTimer),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	    }
	} 
    }
    IF (FIND_STRING(cMsgs,"'Rectime.',ITOA(CHANNEL_AV_SERVICES),' '",1))
    {
	ON [nUsbInUse_]
		    //Convert seconds...
		    //SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_DISPLAY_TIME),',0,',cTimer,' Seconds'"
    }
    IF (FIND_STRING(cMsgs,'off',1))
    {
	ON [vdvTP_Capture, BTN_STOP_STREAM]
    }
    IF (FIND_STRING(cMsgs,'on',1))
    {
	ON [vdvTP_Capture, BTN_START_STREAM]
    }
}
DEFINE_FUNCTION fnStartTimer()
{
    STACK_VAR CHAR iTimeFormated[20];
    LOCAL_VAR CHAR iTimeResult[20];
    
    lSecondTimer = lSecondTimer + 1
    
    IF (lSecondTimer = 60)
    {
	nMinuteStamp = nMinuteStamp + 1
	
	IF (nMinuteStamp = 60)
	{
	    nHourStamp = nHourStamp + 1
	    nMinuteStamp = 0
	}
	lSecondTimer = 0
    }
    iTimeFormated = FORMAT(': %02d ',lSecondTimer)
	iTimeFormated = "FORMAT(': %02d ',nMinuteStamp),iTimeFormated" //Append the minutes..
	iTimeFormated = "FORMAT(' %02d ', nHourStamp), iTimeFormated" 
	    iTimeResult = iTimeFormated
    
    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,',iTimeResult"
}
DEFINE_FUNCTION fnResetTimerToZero()
{
    nMinuteStamp = 0
    nHourStamp = 0
    lSecondTimer = 0
   SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,00 : 00 : 00'"
}


DEFINE_START

CREATE_BUFFER dvPearlRec,nPearlBuffer;

WAIT 200 //set Default Layout on Boot??
{
    fnSwitchLayout(LAYOUT_EQUAL)
}

DEFINE_EVENT
DATA_EVENT [dvPearlRec]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 19200,N,8,1'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 150
	{
	    fnQueryStatus()
	}
    }
    STRING :
    {
	fnParsePearl()
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_START_REC]
BUTTON_EVENT [vdvTP_Capture, BTN_STOP_REC]
BUTTON_EVENT [vdvTP_Capture, BTN_START_STREAM]
BUTTON_EVENT [vdvTP_Capture, BTN_STOP_STREAM] //Start rec/Streams...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_START_REC : 
	    {
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.rec_enabled=on',CR"
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=on',CR"
		    
	    }
	    CASE BTN_STOP_REC :
	    {
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.rec_enabled=off',CR"
		    SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=off',CR" 
	    }
	    CASE BTN_START_STREAM : 
	    {
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=on',CR" 
		    ON [vdvTP_Capture, BTN_START_STREAM]
	    }
	    CASE BTN_STOP_STREAM :
	    {
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=off',CR" 
		    ON [vdvTP_Capture, BTN_STOP_STREAM]
	    }
	}
    }
    RELEASE :
    {
	WAIT 5
	{
	    SEND_STRING dvPearlRec, "'SAVECFG',CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Capture, nLayoutBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nLayIDX;
	nLayIDX = GET_LAST (nLayoutBtns)
	
	fnSwitchLayout(nLayoutSends[nLayIDX])
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_REC_TOGGLE]
{
    PUSH :
    {
	IF (![vdvTP_Capture, BTN_REC_TOGGLE])
	{
	    SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.rec_enabled=on',CR"
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=on',CR"
		    ON [vdvTP_Capture, BTN_REC_TOGGLE]
	}
	ELSE
	{
	    SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.rec_enabled=off',CR"
		    SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=off',CR" 
			OFF [vdvTP_Capture, BTN_REC_TOGGLE]
	}
    }
    RELEASE :
    {
	WAIT 5
	{
	    SEND_STRING dvPearlRec, "'SAVECFG',CR"
	}
    }
}
TIMELINE_EVENT [TL_TIMER]
{
    fnStartTimer()
}


