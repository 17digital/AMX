PROGRAM_NAME='Epiphan_Pearl_V1'
(***********************************************************)
(*  FILE CREATED ON: 02/15/2017  AT: 09:10:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/25/2020  AT: 22:58:57        *)
(***********************************************************)

(**
    Notes...
    No Feedback or API for USB Transfer...
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
CHANNEL_AV_SERVICES		= 3 //Active Channel # Created inside Pearl! Important for anything to work correctly
CHANNEL_LIBRARY			= 3

//Layouts..Defined within Pearl...
LAYOUT_FULL_CAMERA		= 1
LAYOUT_FULL_CONTENT		= 2
LAYOUT_CAM_PIP			= 3
LAYOUT_EQUAL			= 5
LAYOUT_CHROMA_KEY 		= 6

//Buttons...
BTN_START_REC			= 1
BTN_STOP_REC			= 2
BTN_START_STREAM		= 3
BTN_STOP_STREAM			= 4
BTN_LAYOUT_FULL_CAM		= 9 //No Chroma Key
BTN_LAYOUT_FULL_CONT		= 10
BTN_LAYOUT_CAM_PIP		= 12
BTN_LAYOUT_EQUAL		= 11 //Side by Side
BTN_LAYOUT_CHROMA_KEY		= 13 //Key on Full Camera

TXT_REC_STATUS			= 10
TXT_TIMER			= 12

#IF_NOT_DEFINED 		CR 
CR 					= 13
#END_IF

#IF_NOT_DEFINED		LF 
LF 					= 10
#END_IF

DEFINE_VARIABLE

VOLATILE CHAR nPearlBuffer[500]
VOLATILE LONG lRecordTimer[] = {1000} //1 Second Pull...

VOLATILE LONG lSecondTimer
VOLATILE INTEGER nMinuteStamp
VOLATILE INTEGER nHourStamp

DEV vdvTP_Capture[] = {dvTP_Recorder, dvTP_RecBooth}

VOLATILE INTEGER nLayoutBtns[] =
{ 
    BTN_LAYOUT_FULL_CAM,
    BTN_LAYOUT_FULL_CONT,
    BTN_LAYOUT_EQUAL,    
    BTN_LAYOUT_CAM_PIP,				
    BTN_LAYOUT_CHROMA_KEY		
}
VOLATILE INTEGER nLayoutSends[] =
{
    LAYOUT_FULL_CAMERA,		
    LAYOUT_FULL_CONTENT,
    LAYOUT_EQUAL,
    LAYOUT_CAM_PIP,			
    LAYOUT_CHROMA_KEY 		
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Recorder, BTN_START_REC],[dvTP_Recorder, BTN_STOP_REC])
([dvTP_Recorder, BTN_START_STREAM],[dvTP_Recorder, BTN_STOP_STREAM])
([dvTP_Recorder, BTN_LAYOUT_FULL_CAM]..[dvTP_Recorder, BTN_LAYOUT_CHROMA_KEY])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnQueryStatus()
{
    SEND_STRING dvPearlRec, "'STATUS.',ITOA(CHANNEL_AV_SERVICES),CR"
    WAIT 20 SEND_STRING dvPearlRec, "'GET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled',CR"

}
DEFINE_FUNCTION fnSwitchLayout(INTEGER cLayout)
{
    SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.active_layout=',ITOA(cLayout),CR"
    
    SWITCH (cLayout)
    {
	CASE LAYOUT_FULL_CAMERA : ON [dvTP_Recorder, BTN_LAYOUT_FULL_CAM]
	CASE LAYOUT_FULL_CONTENT : ON [dvTP_Recorder, BTN_LAYOUT_FULL_CONT]
	CASE LAYOUT_EQUAL : ON [dvTP_Recorder, BTN_LAYOUT_EQUAL]
	CASE LAYOUT_CAM_PIP : ON [dvTP_Recorder, BTN_LAYOUT_CAM_PIP]
	CASE LAYOUT_CHROMA_KEY : ON [dvTP_Recorder, BTN_LAYOUT_CHROMA_KEY]
    }
    
    WAIT 10
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
    
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsgs,"'Status.',ITOA(CHANNEL_AV_SERVICES),' '",1)):
	    {
		cDbug = cMsgs
		REMOVE_STRING(cMsgs,"'Status.',ITOA(CHANNEL_AV_SERVICES),' '",1)
		nRecState = cMsgs
		
		
		IF(FIND_STRING(nRecState,'Stopped',1))
		    {
			ON [dvTP_Recorder, BTN_STOP_REC]
			    SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Stopped'" 
			    
			    IF(TIMELINE_ACTIVE(TL_TIMER))
			    {
				TIMELINE_KILL(TL_TIMER)
			    }
		    }
		    IF(FIND_STRING(nRecState,'Running',1))
		    {
			ON [dvTP_Recorder, BTN_START_REC]
			    SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Started'" 
			    
			    
			fnResetTimerToZero()
			    TIMELINE_CREATE(TL_TIMER,lRecordTimer,LENGTH_ARRAY(lRecordTimer),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
		    } 
	    
	    }
//	    ACTIVE(FIND_STRING(cMsgs,"'Rectime.',ITOA(CHANNEL_AV_SERVICES),' '",1)):
//	    {
//		REMOVE_STRING(cMsgs,"'Rectime.',ITOA(CHANNEL_AV_SERVICES),' '",1)
//		cTimer = cMsgs
//		    //Convert seconds...
//		    SEND_COMMAND dvTP_Recorder, "'^TXT-',ITOA(TXT_DISPLAY_TIME),',0,',cTimer,' Seconds'"
//	    }
	    ACTIVE(FIND_STRING(cMsgs,'off',1)):
	    {
		ON [vdvTP_Capture, BTN_STOP_STREAM]
	    }
	    ACTIVE(FIND_STRING(cMsgs,'on',1)):
	    {
		ON [vdvTP_Capture, BTN_START_STREAM]
	    }
	}
}
DEFINE_FUNCTION fnStartTimer()
{
    lSecondTimer = (GET_TIMER / 10)
    
    IF (lSecondTimer = 60)
    {
	nMinuteStamp = (nMinuteStamp + 1)
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 00'"
	
	IF (nMinuteStamp = 60)
	{
	    nHourStamp = (nHourStamp + 1)
	    nMinuteStamp = 0
	}
	SET_TIMER (0)
    }
    ELSE IF (lSecondTimer <10)
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 0',ITOA(lSecondTimer)"
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : ',ITOA(lSecondTimer)"
    }
}
DEFINE_FUNCTION fnResetTimerToZero()
{
    nMinuteStamp = 0
    nHourStamp = 0
    SET_TIMER (0)
   SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 00'"
}
DEFINE_FUNCTION fnPausedTimer()
{
    SET_TIMER (lSecondTimer * 10)
    
    IF (lSecondTimer < 10)
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 0',ITOA(lSecondTimer)"
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : ',ITOA(lSecondTimer)"
    }
    
}

DEFINE_START

CREATE_BUFFER dvPearlRec,nPearlBuffer;

WAIT 200
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
	    }
	    CASE BTN_STOP_REC :
	    {
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.rec_enabled=off',CR"
	    }
	    CASE BTN_START_STREAM : 
	    {
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=on',CR" 
		    ON [dvTP_Recorder, BTN_START_STREAM]
	    }
	    CASE BTN_STOP_STREAM :
	    {
		SEND_STRING dvPearlRec, "'SET.',ITOA(CHANNEL_AV_SERVICES),'.Publish_enabled=off',CR" 
		    ON [dvTP_Recorder, BTN_STOP_STREAM]
	    }
	}
    }
    RELEASE :
    {
	WAIT 10
	{
	    SEND_STRING dvPearlRec, "'SAVECFG',CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Capture, nLayoutBtns]
{
    PUSH :
    {
	fnSwitchLayout(nLayoutSends[GET_LAST(nLayoutBtns)])
    }
}
TIMELINE_EVENT [TL_TIMER]
{
    fnStartTimer() //Record Timer...
}




