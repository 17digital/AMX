PROGRAM_NAME='RecordTimer'
(***********************************************************)
(*  FILE CREATED ON: 05/24/2020  AT: 07:23:26              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/24/2020  AT: 07:35:00        *)
(***********************************************************)


DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Shure
dvTP_Shure =			10002:5:0
#END_IF

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Buttons

BTN_START_TIMER		= 1010
BTN_STOP_TIMER		= 1011
BTN_UNPAUSE_TIMER		= 1012

//Address
TXT_TIMER 			= 1002

//Timelines
TL_FEEDBACK			= 1

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE LONG lHourTimer
VOLATILE LONG lMinuteTimer
VOLATILE LONG lSecondTimer
VOLATILE LONG lMinuteStamp //To Caputre Minute Mark
VOLATILE LONG lHourStamp //To Capture Hour Mark


VOLATILE LONG lFeedback[] = {1000}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartTimer()
{
    lSecondTimer = (GET_TIMER /10)
    lMinuteTimer = (GET_TIMER / 600)
    lHourTimer = (GET_TIMER / 36000) 
    
    lMinuteStamp = (lMinuteStamp + lMinuteTimer)
    lHourStamp = (lHourStamp + lHourTimer)
    
    IF (lSecondTimer = 60) //MUst be a minute to capture lMinuteTimer!
    {
	SET_TIMER (10)
	IF (lMinuteStamp = 60)
	{
	    lMinuteStamp = 0
	}
    }
    ELSE IF (lSecondTimer < 60) //Timer Started
    {
	SEND_COMMAND dvTP_Shure, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(lHourStamp),' Hr(s) : ',ITOA(lMinuteStamp),' Min : ',ITOA(lSecondTimer),' Second(s)'"
    }
}
DEFINE_FUNCTION fnResetTimerToZero()
{
    lMinuteStamp = 0
    lHourStamp = 0
    SET_TIMER (0)
    SEND_COMMAND dvTP_Shure, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(lHourStamp),' Hr(s) : ',ITOA(lMinuteStamp),' Min : ',ITOA(lSecondTimer),' Second(s)'"
}
DEFINE_FUNCTION fnPausedTimer()
{
    SET_TIMER (lSecondTimer * 10)
    SEND_COMMAND dvTP_Shure, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(lHourStamp),' Hr(s) : ',ITOA(lMinuteStamp),' Min : ',ITOA(lSecondTimer),' Second(s)'"
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Shure, BTN_START_TIMER]
{
    PUSH :
    {
	fnResetTimerToZero()
	
	IF(TIMELINE_ACTIVE(TL_FEEDBACK))
	{
	    TIMELINE_RESTART(TL_FEEDBACK)
	}
	ELSE
	{
	    TIMELINE_CREATE(TL_FEEDBACK,lFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	}
    }
}
BUTTON_EVENT [dvTP_Shure, BTN_STOP_TIMER]
{
    PUSH :
    {
	IF (TIMELINE_ACTIVE(TL_FEEDBACK))
	{
	    TIMELINE_KILL(TL_FEEDBACK)
	}
    }
}
BUTTON_EVENT [dvTP_Shure, BTN_UNPAUSE_TIMER]
{
    PUSH :
    {
	fnPausedTimer()
	
	IF(TIMELINE_ACTIVE(TL_FEEDBACK))
	{
	    TIMELINE_RESTART(TL_FEEDBACK)
	}
	ELSE
	{
	    TIMELINE_CREATE(TL_FEEDBACK,lFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	}
    } 
}

TIMELINE_EVENT [TL_FEEDBACK]
{
    fnStartTimer()
}

