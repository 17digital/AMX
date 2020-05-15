PROGRAM_NAME='Master'
(***********************************************************)
(*  FILE CREATED ON: 05/11/2019  AT: 10:04:59              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/20/2019  AT: 11:52:31        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    //dBX
    1 = iPod
    2 = DGX
    
    Mic 1 = Wireless
    
    AUDOUT_FORMAT-ANALOG
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

DGX_CONN	=			17

dvMaster =				0:1:0 //NX-4200
dvDGX =					5002:1:DGX_CONN

dvTP_Main =				10001:1:0 //MST 10"
dvAUDIOOUT_24 =			5002:24:DGX_CONN //

dvMonitor_1 =				46001:1:DGX_CONN //NEC TV
dvMonitor_2 =				46002:1:DGX_CONN //NEC TV
dvMonitor_3 =				46003:1:DGX_CONN //NEC TV
dvMonitor_4 =				46004:1:DGX_CONN //NEC TV
dvMonitor_5 =				46005:1:DGX_CONN //NEC TV
dvMonitor_6 =				46006:1:DGX_CONN //NEC TV
dvMonitor_7 =				46007:1:DGX_CONN //NEC TV
dvMonitor_8 =				46008:1:DGX_CONN //NEC TV
dvMonitor_9 =				46009:1:DGX_CONN //NEC TV

vdvMonitor_1 =			35011:1:0 //NEC TV Control
vdvMonitor_2 =			35012:1:0 //NEC TV Control
vdvMonitor_3 =			35013:1:0 //NEC TV Control
vdvMonitor_4 =			35014:1:0 //NEC TV Control
vdvMonitor_5 =			35015:1:0 //NEC TV Control
vdvMonitor_6 =			35016:1:0 //NEC TV Control
vdvMonitor_7 =			35017:1:0 //NEC TV Control
vdvMonitor_8 =			35018:1:0 //NEC TV Control
vdvMonitor_9 =			35019:1:0 //NEC TV Control

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Misc
CR 							= 13
LF							= 10
POWER_ON					= 27
POWER_OFF					= 28


IN_WALL_1					= 9 

OUT_TV_1					= 1
OUT_TV_2					= 2
OUT_TV_3					= 3
OUT_TV_4					= 4
OUT_TV_5					= 5
OUT_TV_6					= 6
OUT_TV_7					= 7
OUT_TV_8					= 8
OUT_TV_9					= 9
OUT_AUDIO_MIX			= 24


TECH_PASSWORD			= '8324'


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Main[] = { dvTP_Main }

VOLATILE INTEGER nTPOnline

VOLATILE INTEGER cPWR
NON_VOLATILE INTEGER nMode_
NON_VOLATILE INTEGER nSourceVid 
VOLATILE INTEGER nTVCount = 9 //Number of TV's in Room

VOLATILE DEV dcProjectorDevices[] =
{
    vdvMonitor_1, 
    vdvMonitor_2,
    vdvMonitor_3, 
    vdvMonitor_4,
    vdvMonitor_5,
    vdvMonitor_6,
    vdvMonitor_7,
    vdvMonitor_8,
    vdvMonitor_9
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnPWRDisplaysON()
{
    STACK_VAR INTEGER nLoop
	    
	FOR(nLoop=1; nLoop<=MAX_LENGTH_ARRAY(dcProjectorDevices); nLoop++)
	{
	    PULSE [dcProjectorDevices[nLoop], POWER_ON]
	}
}
DEFINE_FUNCTION fnPWRDisplaysOFF()
{
    STACK_VAR INTEGER nLoop
	    
    FOR(nLoop=1; nLoop<=MAX_LENGTH_ARRAY(dcProjectorDevices); nLoop++)
    {
	PULSE [dcProjectorDevices[nLoop], POWER_OFF]
    }
}
DEFINE_FUNCTION fnSWITCHDisplaySource()
{
    STACK_VAR INTEGER nLoop
	    
    FOR(nLoop=1; nLoop<=MAX_LENGTH_ARRAY(dcProjectorDevices); nLoop++)
    {
	SEND_COMMAND dcProjectorDevices[nLoop], "'INPUT-HDMI,1'"
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, nZoneBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nZoneIDX
	
	nZoneIDX = GET_LAST(nZoneBtns)
	SWITCH (nZoneIDX)
	{
	    //Zone 1
	    CASE 1 : //Local Mersive...
	    {
		fnSetDGXRouteAV(IN_MERSIVE_002, OUT_TV_1)
		SEND_COMMAND vdvMonitor_1, "'INPUT-HDMI,1'"
	    }
	    CASE 2 : //Local Input
	    {
		SEND_COMMAND vdvMonitor_1, "'INPUT-DISPLAY,1'"
	    }
	    CASE 3 : //Follow Source
	    {
		fnSetDGXRouteAV(nSourceVid, OUT_TV_1)
		SEND_COMMAND vdvMonitor_1, "'INPUT-HDMI,1'"
	    }
	}
    }
}


DEFINE_EVENT
DATA_EVENT [dvDGX]
{
    ONLINE :
    {
	//
    }
}
	
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	//Set Password...
	    //SEND_COMMAND DATA.DEVICE, "'^PWD-2,',TECH_PASSWORD"
    }
    STRING :
    {
	CHAR sTmp[10]
	sTmp = DATA.TEXT
	
	IF (FIND_STRING(sTmp, 'KEYB-8324',1))
	{
	    SEND_COMMAND vdvTP_Main, "'@PPX'"
	    SEND_COMMAND vdvTP_Main, "'PAGE-Home'"
	}
    }
}
	
(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See Differences in DEFINE_PROGRAM Program Execution section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


