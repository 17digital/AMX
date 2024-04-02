PROGRAM_NAME='Epiphan_Pearl_V1'
(***********************************************************)
(*  FILE CREATED ON: 02/15/2017  AT: 09:10:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/16/2020  AT: 16:52:41        *)
(***********************************************************)

(**
    Notes...
	This Include file is for Serial Port Only...
    Pearl API does not support USB Feedback on Serial Port. Transfer complete, etc
    Pearl API does not provide Verbose Modes - so feedback do not have headers to distiguish certain reponses.
    Example, when querying the Active Preset Layout, it simply responds with a number. Not very helpful
    
    The work-around is to use "VAR.SET" and "VAR.GET" this allows you to store variables into the Pearl2 and read them back.
    The Data can be up to 31Char
    
    So when I recall I Layout Preset - I can send the "VAR.SET" to the Pearl and recall the param response later.
        
**)
    

DEFINE_DEVICE


dvTP_Recorder =		10001:4:0
dvTP_RecBooth =		10004:4:0


dvPearlRec =			5001:3:0



DEFINE_CONSTANT

TL_TIMER		= 15

CHAR PEARL_MODEL[]		= 'Pearl-2'

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
BTN_LAYOUT_CONT_PRO	= 14 //Production

BTN_REC_TOGGLE			= 101

TXT_REC_STATUS			= 10
TXT_USB_STATUS			= 11
TXT_TIMER				= 12


#IF_NOT_DEFINED CR
CHAR CR					= $0D;
#END_IF

#IF_NOT_DEFINED	LF 
CHAR LF					= $0A;
#END_IF

DEFINE_TYPE

STRUCTURE _PearlStruct
{
    CHAR bOnline;
    CHAR bStatus[15];
    INTEGER bLayout;
    INTEGER bChannel;
    INTEGER bUsbConnected;
    CHAR bMacAddress[17];
    CHAR bFirmware[6]
    CHAR bModel[7];
    CHAR bFormat[4];
}

DEFINE_VARIABLE

_PearlStruct PearlDevice;

VOLATILE CHAR nPearlBuffer[500]
VOLATILE LONG lRecordTimer[] = {1000} //1 Second Pull...

VOLATILE LONG lSecondTimer
VOLATILE INTEGER nMinuteStamp
VOLATILE INTEGER nHourStamp

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
DEFINE_FUNCTION fnSetPearlVars() {
    
    PearlDevice.bModel = PEARL_MODEL;
    WAIT 20 {
	SEND_STRING dvPearlRec, "'VAR.SET.MODEL=Model-',PearlDevice.bModel,CR"
    }
}
DEFINE_FUNCTION fnQueryStatus()
{
    fnResetTimerToZero();
    fnSetPearlVars()
    
		    SEND_STRING dvPearlRec, "'STATUS.',ITOA(CHANNEL_AV_SERVICES),CR"
    WAIT 20 SEND_STRING dvPearlRec, "'GET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled',CR"
    WAIT 40 SEND_STRING dvPearlRec, "'RECTIME.',ITOA(CHANNEL_AV_SERVICES),CR"
    WAIT 60 SEND_STRING dvPearlRec, "'FREESPACE',CR"
    WAIT 80 SEND_STRING dvPearlRec, "'GET.mac_address',CR"
    WAIT 100 SEND_STRING dvPearlRec, "'VAR.GET.MODEL',CR"
    WAIT 120 SEND_STRING dvPearlRec, "'GET.firmware_version',CR"
    WAIT 140 SEND_STRING dvPearlRec, "'VAR.GET.LAYOUT',CR"
}
DEFINE_FUNCTION fnSwitchLayout(INTEGER cPos)
{
    SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.active_layout=',ITOA(cPos),CR"    
        
    WAIT 10 {
    
	SEND_STRING dvPearlRec, "'SAVECFG',CR"
    }
}
DEFINE_FUNCTION fnParsePearl(CHAR cMsgs[])
{
    STACK_VAR CHAR nRecState[13];
    LOCAL_VAR CHAR cTimer[4]
    LOCAL_VAR CHAR cDbug[20]
    
    PearlDevice.bOnline = TRUE;
    
    SELECT
    {
	ACTIVE(FIND_STRING(cMsgs,"'Status.',ITOA(CHANNEL_AV_SERVICES),' '",1)) :
	{
		REMOVE_STRING(cMsgs,"'Status.',ITOA(CHANNEL_AV_SERVICES),' '",1)
		nRecState = cMsgs;
		
	    IF(FIND_STRING(nRecState,'Stopped',1)) {
	    
		ON [vdvTP_Capture, BTN_STOP_REC]
		SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Stopped'" 
			    
		IF(TIMELINE_ACTIVE(TL_TIMER)) {
			    	TIMELINE_KILL(TL_TIMER)
		}
	    }
	    IF(FIND_STRING(nRecState,'Running',1)) {
		    
		ON [vdvTP_Capture, BTN_START_REC]
		    PearlDevice.bUsbConnected = TRUE;
				SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Started'" 
			    
		IF(!TIMELINE_ACTIVE(TL_TIMER)) {
			    TIMELINE_CREATE(TL_TIMER,lRecordTimer,LENGTH_ARRAY(lRecordTimer),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
		}
	    }
	    IF(FIND_STRING(nRecState,'Uninitialized',1)) {
		    PearlDevice.bUsbConnected = FALSE;
			ON [vdvTP_Capture, BTN_STOP_REC]
	    }
	}
	ACTIVE(FIND_STRING(cMsgs,"'Rectime.',ITOA(CHANNEL_AV_SERVICES),' '",1)):
	{
	    REMOVE_STRING(cMsgs,"'Rectime.',ITOA(CHANNEL_AV_SERVICES),' '",1)
		
		cTimer = LEFT_STRING(cMsgs,LENGTH_STRING(cMsgs) -2); //Remove LF,CR
		
		IF (FIND_STRING(cTimer,'0',1)) {
			PearlDevice.bUsbConnected = FALSE;
		}
		ELSE {
		    PearlDevice.bUsbConnected = TRUE;
		}
	}
	ACTIVE(FIND_STRING(cMsgs,'00:05:b7',1)):
	{
	    PearlDevice.bMacAddress = LEFT_STRING(cMsgs, 17);
	}
	ACTIVE(FIND_STRING(cMsgs,'on',1)):
	{
	    ON [vdvTP_Capture, BTN_START_STREAM]
	}
	ACTIVE(FIND_STRING(cMsgs,'off',1)) :
	{
	    ON [vdvTP_Capture, BTN_STOP_STREAM]
	}
	ACTIVE (FIND_STRING(cMsgs, 'Layout-',1)) :
	{
	    REMOVE_STRING(cMsgs,'-',1)
		PearlDevice.bLayout = ATOI(cMsgs);
		     ON [vdvTP_Capture, nLayoutBtns[PearlDevice.bLayout]];
	}
    }
}
DEFINE_FUNCTION fnStartTimer()
{
    STACK_VAR CHAR iTimeFormated[20];
    LOCAL_VAR CHAR iTimeResult[20];
    
    lSecondTimer = lSecondTimer + 1;
    
    IF (lSecondTimer == 60) {
	    nMinuteStamp = nMinuteStamp + 1;
	
	IF (nMinuteStamp == 60) {
	    nHourStamp = nHourStamp + 1;
		nMinuteStamp = 0;
	}
	lSecondTimer = 0;
    }
    iTimeFormated = FORMAT(': %02d ',lSecondTimer)
	iTimeFormated = "FORMAT(': %02d ',nMinuteStamp),iTimeFormated" //Append the minutes..
	iTimeFormated = "FORMAT(' %02d ', nHourStamp), iTimeFormated" 
	    iTimeResult = iTimeFormated;
    
    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,',iTimeResult"
}
DEFINE_FUNCTION fnResetTimerToZero()
{
    nMinuteStamp = 0;
    nHourStamp = 0;
    lSecondTimer = 0;
    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,00 : 00 : 00'"
}

DEFINE_START

CREATE_BUFFER dvPearlRec,nPearlBuffer;

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
    OFFLINE :
    {
	PearlDevice.bOnline = FALSE;
    }
    STRING :
    {
	STACK_VAR CHAR iResult[50];
	
	WHILE (FIND_STRING(nPearlBuffer, "$0D,$0A",1))
	{
	    iResult = REMOVE_STRING (nPearlBuffer,"$0D,$0A",1);
		fnParsePearl(iResult);
	}
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
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=on',CR" //Added for Catherine..
		    
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
	WAIT 10 {
	    SEND_STRING dvPearlRec, "'SAVECFG',CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Capture, nLayoutBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER b;
	
	    b = GET_LAST (nLayoutBtns)
		fnSwitchLayout(nLayoutSends[b])
		    ON [vdvTP_Capture, nLayoutBtns[b]];
		    
	    SEND_STRING dvPearlRec, "'VAR.SET.LAYOUT=Layout-',ITOA(b),CR"
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
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 450 {
	SEND_STRING dvPearlRec, "'STATUS.',ITOA(CHANNEL_AV_SERVICES),CR"
	
	WAIT 20 {
	    SEND_STRING dvPearlRec, "'RECTIME.',ITOA(CHANNEL_AV_SERVICES),CR"
	}
    }
}



