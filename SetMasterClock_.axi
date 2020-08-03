PROGRAM_NAME='SetMasterClock_'

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Clock Stuff...
CHAR TIME_IP[]				= '130.207.187.195'
CHAR TIME_SERVER[]			= 'ntp1.gatech.edu'
CHAR TIME_LOC[]			= 'NIST, Gatech, ATL'
CHAR TIME_ZONE[]			= 'UTC-05:00' //Eastern
INTEGER TIME_SYNC_PERIOD 	= 60 //1 hour

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSetClock()
{
	WAIT 10 CLKMGR_SET_CLK_SOURCE(CLKMGR_MODE_NETWORK)//1 
	WAIT 30 CLKMGR_SET_TIMEZONE(TIME_ZONE)
	WAIT 60 CLKMGR_SET_RESYNC_PERIOD(TIME_SYNC_PERIOD) 
	WAIT 90 CLKMGR_SET_DAYLIGHTSAVINGS_MODE(TRUE)
	WAIT 110 CLKMGR_ADD_USERDEFINED_TIMESERVER(TIME_IP, TIME_SERVER, TIME_LOC)
	WAIT 140 CLKMGR_SET_ACTIVE_TIMESERVER(TIME_IP) 
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START


WAIT 450
{
    fnSetClock()
}



