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

dvRS232_TV1 =				5001:1:0
dvRS232_TV2 =				5001:2:0
dvRS232_TV3 =				5001:3:0
dvRS232_TV4 =				5001:4:0
dvRS232_dBx =				5001:5:0 //dbx 640
dvRS232_6 =				5001:6:0
dvRS232_7 =				5001:7:0
dvRS232_8 =				5001:8:0


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

MY_ROOM					= 'EdgeRice Dining'
MY_HELP					= '404-894-4669'

//TP Addresses
TXT_HELP					= 99
TXT_ROOM				= 100

//Misc
CR 							= 13
LF							= 10
TL_MAINLINE				= 1
TL_FLASH					= 2


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

VOLATILE LONG lTLMainline[] = {250}
VOLATILE LONG lTLFlash[] = {500}
VOLATILE INTEGER iFlash

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

TIMELINE_CREATE (TL_MAINLINE,lTLMainline,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

DEFINE_MODULE 'NEC_E656' TVMonitorModOne (vdvMonitor_1, dvMonitor_1);
DEFINE_MODULE 'NEC_E656' TVMonitorModTwo (vdvMonitor_2, dvMonitor_2);
DEFINE_MODULE 'NEC_E656' TVMonitorModThree (vdvMonitor_3, dvMonitor_3);
DEFINE_MODULE 'NEC_E656' TVMonitorModFour (vdvMonitor_4, dvMonitor_4);
DEFINE_MODULE 'NEC_E656' TVMonitorModFive (vdvMonitor_5, dvMonitor_5);
DEFINE_MODULE 'NEC_E656' TVMonitorModSix (vdvMonitor_6, dvMonitor_6);
DEFINE_MODULE 'NEC_E656' TVMonitorModSeven (vdvMonitor_7, dvMonitor_7);
DEFINE_MODULE 'NEC_E656' TVMonitorModEight (vdvMonitor_8, dvMonitor_8);
DEFINE_MODULE 'NEC_E656' TVMonitorModNine (vdvMonitor_9, dvMonitor_9);

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
	    
	    //Zone 3
	    CASE 4 : //Local Input
	    {
		SEND_COMMAND vdvMonitor_4, "'INPUT-DISPLAY,1'"
	    }
	    CASE 5 : //Follow Source
	    {
		fnSetDGXRouteAV(nSourceVid, OUT_TV_4)
		SEND_COMMAND vdvMonitor_4, "'INPUT-HDMI,1'"
	    }
	    
	    //Zone 4
	    CASE 6 : //Local Mersive...
	    {
		fnSetDGXRouteAV(IN_MERSIVE_003, OUT_TV_9)
		SEND_COMMAND vdvMonitor_9, "'INPUT-HDMI,1'"
	    }
	    CASE 7 : //Local Input
	    {
		SEND_COMMAND vdvMonitor_9, "'INPUT-DISPLAY,1'"
	    }
	    CASE 8 : //Follow Source
	    {
		fnSetDGXRouteAV(nSourceVid, OUT_TV_9)
		SEND_COMMAND vdvMonitor_9, "'INPUT-HDMI,1'"
	    }
	}
    }
}


DEFINE_EVENT
DATA_EVENT [dvDGX]
{
    ONLINE :
    {
	WAIT 100
	{
	    CALL 'DGX NAMING'
	}
    }
}
	
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',MY_ROOM"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',MY_HELP"
	//Set Password...
	    //SEND_COMMAND DATA.DEVICE, "'^PWD-2,',TECH_PASSWORD"
	
    }
    OFFLINE :
    {
	OFF [nTPOnline]
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
//DATA_EVENT [dvTP_Main.NUMBER:1:0]
//{
//
//}
	

DEFINE_EVENT
CHANNEL_EVENT [vdvMonitor_2, ON_LINE]
CHANNEL_EVENT [vdvMonitor_2, WARMING]
CHANNEL_EVENT [vdvMonitor_2, COOLING]
CHANNEL_EVENT [vdvMonitor_2, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE POWER :
	    {
		//
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		    SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		    SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE POWER :
	    {
		OFF [nMode_]
	    }
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFlash = !iFlash
}
TIMELINE_EVENT [TL_MAINLINE]
{
    //Feedback...
    [vdvTP_Main, BTN_PRESENTATION] = nMode_ = MODE_PRESENTATION
    [vdvTP_Main, BTN_PRESENTATION_ZONE] = nMode_ = MODE_PRESENTATION_ZONE
    [vdvTP_Main, BTN_GAME] = nMode_ = MODE_GAME
    [vdvTP_Main, BTN_ALL_OFF] = !nMode_
    
    [vdvTP_Main, 11] = nSourceVid = IN_DESKTOP
    [vdvTP_Main, 12] = nSourceVid = IN_WALL_1
    [vdvTP_Main, 13] = nSourceVid = IN_MERSIVE_001
    
    [vdvTP_Main, 1] = [vdvMonitor_1, POWER]
    [vdvTP_Main, 2] = ![vdvMonitor_1, POWER]
    [vdvTP_Main, 601] = [vdvMonitor_1, ON_LINE]
    
    IF ([vdvMonitor_1, WARMING])
    {
	[vdvTP_Main, 602] = iFlash
    }
    ELSE IF ([vdvMonitor_1, COOLING])
    {
	[vdvTP_Main, 603] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, 602] = [vdvMonitor_1, WARMING]
	[vdvTP_Main, 603] = [vdvMonitor_1, COOLING]
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


