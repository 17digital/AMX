PROGRAM_NAME='Timeout'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Please Load "Warning message" to Logo Slot 1 on DVX via web Interface to display
    screen warning!!
    
    Ensure touchpanel popups are loaded to display warning and reset button!!!
    
    Add -Call 'Reset Time' on Button Pushes on Button Switches
    Add -Call 'Timeline Friends' on Projector start Definitions
    
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)

DEFINE_DEVICE

#IF_NOT_DEFINED dvIO
dvIO =						5001:17:0
#END_IF

#IF_NOT_DEFINED dvTP_Main
dvTP_Main =					10001:1:0
#END_IF

#IF_NOT_DEFINED dvAVOUTPUT1
dvAVOUTPUT1 =					5002:1:0
#END_IF

#IF_NOT_DEFINED dvAVOUTPUT3
dvAVOUTPUT3 =					5002:3:0
#END_IF

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Times
TLRESTART				= 0
TLABSOLUTE			= 1 //ID

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nTimelineIO[] =
{
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
}
VOLATILE LONG TIMEARRAY[] =  //Array to hold times
{
    1000,		// 1 Second
    300000,  	// 5 Minutes
    600000,  	// 10 Minutes
    1200000, 	// 20 Minutes
    1800000, 	// 30 Minutes
    3600000, 	// 60 Minutes
    6900000, 	// 115 Minutes (5 Minute Warning Before Shutdown)
    7200000  	// 120 Minutes (Max)
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvIO,nTimelineIO[1]]..[dvIO,nTimelineIO[8]])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 

DEFINE_CALL 'TIMELINE FRIENDS' // Starts and RUNS TIMELINE ONCE
{
    IF(TIMELINE_ACTIVE(TLABSOLUTE))
    {
	TIMELINE_SET (TLABSOLUTE, TLRESTART) //If its already active then just restart
    }
    ELSE
    {    
    //TIMELINE_CREATE(TLABSOLUTE,TIMEARRAY,9,TIMELINE_ABSOLUTE,TIMELINE_ONCE) //9 is equal to the length of th tl_array (I could also place this in a variable
    TIMELINE_CREATE(TLABSOLUTE,TIMEARRAY,LENGTH_ARRAY(TIMEARRAY),TIMELINE_ABSOLUTE,TIMELINE_ONCE) //-->This Works the same way
    }
} 
DEFINE_CALL 'RESET TIMER'
{
    IF(TIMELINE_ACTIVE(TLABSOLUTE)) 
    {
	TIMELINE_SET (TLABSOLUTE, TLRESTART) //start it over again
	SEND_COMMAND dvTp_Main,"'@PPX'" //Close All PopUps
	SEND_COMMAND dvAVOUTPUT1,"'VIDOUT_TESTPAT-off'"
	SEND_COMMAND dvAVOUTPUT3,"'VIDOUT_TESTPAT-off'"
    }
}
DEFINE_CALL 'TIMER WARNING'
{
	SEND_COMMAND dvTp_Main,"'@PPX'" //Close All PopUps
	WAIT 20
	SEND_COMMAND dvTP_Main,"'@PPG-Warning'"
	SEND_COMMAND dvAVOUTPUT1,"'VIDOUT_TESTPAT-Logo 1'"
	SEND_COMMAND dvAVOUTPUT3,"'VIDOUT_TESTPAT-Logo 1'"
}
DEFINE_CALL 'SET DEFAULT ROOM'
{
	    SEND_COMMAND dvTp_Main,"'@PPX'" //Close All PopUps
    	    SEND_COMMAND dvAVOUTPUT1,"'VIDOUT_TESTPAT-off'"
	    SEND_COMMAND dvAVOUTPUT3,"'VIDOUT_TESTPAT-off'"
	    DO_PUSH (dvTp_Main, 11)
	    DO_PUSH (dvTp_Main, 111)
	    CALL 'PROGRAM VOLUME PRESET'
	    SEND_COMMAND dvTP_MAIN,"'PAGE-Main'" //--> Take me to Home Page for Default
}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTp_Main, 500]
{
    PUSH:
    {
	CALL 'RESET TIMER'
    }
}
TIMELINE_EVENT[TLABSOLUTE]    // EVENTS FOR TIMELINE
{  
  SWITCH(Timeline.Sequence)
  {
    case 1: ON [dvIO,1] // First Event
    case 2: ON [dvIO,2] 
    case 3: ON [dvIO,3] 
    case 4: ON [dvIO,4]
    case 5: ON [dvIO,5]
    case 6: ON [dvIO,6]
    case 7: ON [dvIO,7]
    {
	CALL 'TIMER WARNING'
    }
    CASE 8: //10 Minutes
	{
	    OFF[dvIO,7]
	    CALL 'SET DEFAULT ROOM'
	    CALL 'POWER OFF LEFT'
	}
  }
}