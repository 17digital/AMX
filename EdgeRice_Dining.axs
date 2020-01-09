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

//DGX Stuff...
dvVIDEOIN_1   = 			5002:1:DGX_CONN //Computer
dvVIDEOIN_2   = 			5002:2:DGX_CONN //Mersive 1
dvVIDEOIN_3   = 			5002:3:DGX_CONN //Mersive 2
dvVIDEOIN_4   = 			5002:4:DGX_CONN //Mersive 3

dvVIDEOIN_5   = 			5002:5:DGX_CONN //Tuner 1
dvVIDEOIN_6  = 			5002:6:DGX_CONN //Tuner 2
dvVIDEOIN_7  = 			5002:7:DGX_CONN //Tuner 3
dvVIDEOIN_8  = 			5002:8:DGX_CONN //Tuner 4

dvVIDEOIN_9   = 			5002:9:DGX_CONN //DxLink Front Column 1
dvVIDEOIN_10  = 			5002:10:DGX_CONN //DxLink Front Column 2
dvVIDEOIN_11 =			5002:11:DGX_CONN //DxLink From ??
dvVIDEOIN_12 =			5002:12:DGX_CONN //DxLink From ??

dvVIDEOIN_13 =			5002:13:DGX_CONN //Not Used
dvVIDEOIN_14 =			5002:14:DGX_CONN //Not Used
dvVIDEOIN_15 =			5002:15:DGX_CONN //Not Used
dvVIDEOIN_16 =			5002:16:DGX_CONN //Not Used

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

//DGX...
//Naming - Max Char = 31
INPUT_NAME_1			= 'Desktop'
INPUT_NAME_2			= 'Mersive 001'
INPUT_NAME_3			= 'Mersive 002'
INPUT_NAME_4			= 'Mersive 003'

INPUT_NAME_5			= 'TVTuner 001'
INPUT_NAME_6			= 'TVTuner 002'
INPUT_NAME_7			= 'TVTuner 003'
INPUT_NAME_8			= 'TVTuner 004'

INPUT_NAME_9			= 'Wall Plate'
INPUT_NAME_10			= 'Not Used'
INPUT_NAME_11			= 'Not Used'
INPUT_NAME_12			= 'Not Used'

INPUT_NAME_13			= 'Not Used'
INPUT_NAME_14			= 'Not Used'
INPUT_NAME_15			= 'Not Used'
INPUT_NAME_16			= 'Not Used'

//Conference room Connections...

OUTPUT_NAME_1			= 'TV NEC 001'
OUTPUT_NAME_2			= 'TV NEC 002'
OUTPUT_NAME_3			= 'TV NEC 003'
OUTPUT_NAME_4			= 'TV NEC 004'
                                                                                 
OUTPUT_NAME_5			= 'TV NEC 005'
OUTPUT_NAME_6			= 'TV NEC 006'
OUTPUT_NAME_7			= 'TV NEC 007'
OUTPUT_NAME_8			= 'TV NEC 008'
                                                                                 
OUTPUT_NAME_9			= 'TV NEC 009'
OUTPUT_NAME_10		= 'Not Used'
OUTPUT_NAME_11		= 'Not Used'
OUTPUT_NAME_12		= 'Not Used'
                     
OUTPUT_NAME_13		= 'Not Used'
OUTPUT_NAME_14		= 'Not Used'
OUTPUT_NAME_15		= 'Not Used'
OUTPUT_NAME_16		= 'Not Used'

IN_DESKTOP				= 1 
IN_MERSIVE_001			= 2
IN_MERSIVE_002			= 3
IN_MERSIVE_003			= 4

IN_TVTUNER_1				= 5
IN_TVTUNER_2				= 6
IN_TVTUNER_3				= 7
IN_TVTUNER_4				= 8

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

//Preferred EDID...
EDID_PC					= '1920x1080,60'
EDID_MERSIVE				= '1920x1080p,60'
EDID_TUNER				= '1920x1080,60'
EDID_WALL					= '1280x720,60'

//Common Feedback...
POWER_CYCLE				= 9
POWER_ON				= 27
POWER_OFF				= 28
WARMING					= 253
COOLING					= 254
ON_LINE					= 251
POWER					= 255
BLANK						= 211

MODE_PRESENTATION		= 1
MODE_GAME				= 2
MODE_PRESENTATION_ZONE = 3

BTN_PRESENTATION		= 20
BTN_PRESENTATION_ZONE	= 21
BTN_GAME					= 22
BTN_ALL_OFF				= 23

TECH_PASSWORD			= '8324'

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE




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
VOLATILE INTEGER nSourceBtns[] =
{
    11, //Desktop
    12, //Wallplate
    13  //Mersive...
}
VOLATILE INTEGER nZoneBtns[] =
{
    //Zone 1
    31, //Mersive
    32, //Wall Input (Display Port
    33, //Follow Source Video
    
    //Zone 3
    34, //Wall Input (Display Port)
    35, //Follow Source Video
    
    //Zone 4
    36, //Mersive
    37, //Wall Input (Display Port)
    38  //Follow Source Video
}

#INCLUDE 'TVTuner_001'
#INCLUDE 'NexiaCube'
#INCLUDE 'RMSMain'

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = '06:00:00')
    {
	IF (!nTPOnline)
	{
	    REBOOT (dvMaster)
	}
    }
}
DEFINE_CALL 'DGX NAMING'
{
    SEND_COMMAND dvVIDEOIN_1, "'VIDIN_NAME-',INPUT_NAME_1"
    SEND_COMMAND dvVIDEOIN_2, "'VIDIN_NAME-',INPUT_NAME_2"
    SEND_COMMAND dvVIDEOIN_3, "'VIDIN_NAME-',INPUT_NAME_3"
    SEND_COMMAND dvVIDEOIN_4, "'VIDIN_NAME-',INPUT_NAME_4"
    SEND_COMMAND dvVIDEOIN_5, "'VIDIN_NAME-',INPUT_NAME_5"
    SEND_COMMAND dvVIDEOIN_6, "'VIDIN_NAME-',INPUT_NAME_6"
    SEND_COMMAND dvVIDEOIN_7, "'VIDIN_NAME-',INPUT_NAME_7"
    SEND_COMMAND dvVIDEOIN_8, "'VIDIN_NAME-',INPUT_NAME_8"
    SEND_COMMAND dvVIDEOIN_9, "'VIDIN_NAME-',INPUT_NAME_9"
    SEND_COMMAND dvVIDEOIN_10, "'VIDIN_NAME-',INPUT_NAME_10"
    SEND_COMMAND dvVIDEOIN_11, "'VIDIN_NAME-',INPUT_NAME_11"
    SEND_COMMAND dvVIDEOIN_12, "'VIDIN_NAME-',INPUT_NAME_12"
    SEND_COMMAND dvVIDEOIN_13, "'VIDIN_NAME-',INPUT_NAME_13"
    SEND_COMMAND dvVIDEOIN_14, "'VIDIN_NAME-',INPUT_NAME_14"
    SEND_COMMAND dvVIDEOIN_15, "'VIDIN_NAME-',INPUT_NAME_15"
    SEND_COMMAND dvVIDEOIN_16, "'VIDIN_NAME-',INPUT_NAME_16"
    
    WAIT 40
    {
    	SEND_COMMAND dvVIDEOIN_1, "'VIDOUT_NAME-',OUTPUT_NAME_1"
	SEND_COMMAND dvVIDEOIN_2, "'VIDOUT_NAME-',OUTPUT_NAME_2"
	SEND_COMMAND dvVIDEOIN_3, "'VIDOUT_NAME-',OUTPUT_NAME_3"
	SEND_COMMAND dvVIDEOIN_4, "'VIDOUT_NAME-',OUTPUT_NAME_4"
	SEND_COMMAND dvVIDEOIN_5, "'VIDOUT_NAME-',OUTPUT_NAME_5"
	SEND_COMMAND dvVIDEOIN_6, "'VIDOUT_NAME-',OUTPUT_NAME_6"
	SEND_COMMAND dvVIDEOIN_7, "'VIDOUT_NAME-',OUTPUT_NAME_7"
	SEND_COMMAND dvVIDEOIN_8, "'VIDOUT_NAME-',OUTPUT_NAME_8"
	SEND_COMMAND dvVIDEOIN_9, "'VIDOUT_NAME-',OUTPUT_NAME_9"
	SEND_COMMAND dvVIDEOIN_10, "'VIDOUT_NAME-',OUTPUT_NAME_10"
	SEND_COMMAND dvVIDEOIN_11, "'VIDOUT_NAME-',OUTPUT_NAME_11"
	SEND_COMMAND dvVIDEOIN_12, "'VIDOUT_NAME-',OUTPUT_NAME_12"
	SEND_COMMAND dvVIDEOIN_13, "'VIDOUT_NAME-',OUTPUT_NAME_13"
	SEND_COMMAND dvVIDEOIN_14, "'VIDOUT_NAME-',OUTPUT_NAME_14"
	SEND_COMMAND dvVIDEOIN_15, "'VIDOUT_NAME-',OUTPUT_NAME_15"
	SEND_COMMAND dvVIDEOIN_16, "'VIDOUT_NAME-',OUTPUT_NAME_16"
    }
    
    WAIT 80
    {
	//Preferred Edid...
	SEND_COMMAND dvVIDEOIN_1, "'VIDIN_PREF_EDID-',EDID_PC"
	SEND_COMMAND dvVIDEOIN_2, "'VIDIN_PREF_EDID-',EDID_MERSIVE"
	SEND_COMMAND dvVIDEOIN_3, "'VIDIN_PREF_EDID-',EDID_MERSIVE"
	SEND_COMMAND dvVIDEOIN_4, "'VIDIN_PREF_EDID-',EDID_MERSIVE"
	
	SEND_COMMAND dvVIDEOIN_5, "'VIDIN_PREF_EDID-',EDID_TUNER"
	SEND_COMMAND dvVIDEOIN_6, "'VIDIN_PREF_EDID-',EDID_TUNER" 
	SEND_COMMAND dvVIDEOIN_7, "'VIDIN_PREF_EDID-',EDID_TUNER" 
	SEND_COMMAND dvVIDEOIN_8, "'VIDIN_PREF_EDID-',EDID_TUNER"
	
	SEND_COMMAND dvVIDEOIN_9, "'VIDIN_PREF_EDID-',EDID_WALL"
    }
}
DEFINE_FUNCTION fnSetDGXRoutePresentation(INTEGER cIn) //Full Presentation!
{
    nSourceVid = cIn 
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_1)" 
    WAIT 10 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_2)"  
    WAIT 20 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_3)" 
    WAIT 30 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_4)"   
    WAIT 40 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_5)" 
    WAIT 50 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_6)"   
    WAIT 60 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_7)" 
    WAIT 70 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_8)"   
    WAIT 80 SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_9)" 
}
DEFINE_FUNCTION fnSetDGXRouteZone(INTEGER cIn) //Zoned Presentation
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TV_2),',',ITOA(OUT_TV_3)" 
    nSourceVid = cIn 
}
DEFINE_FUNCTION fnSetDGXRouteAV(INTEGER cIn, INTEGER cOut) //Function for Game Day
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(cOut)"
}
DEFINE_FUNCTION fnSetDGXAudio(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(OUT_AUDIO_MIX)"   
}
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
DEFINE_FUNCTION fnPWRZoneON()
{
    PULSE [vdvMonitor_2, POWER_ON]
    PULSE [vdvMonitor_3, POWER_ON]
    

    WAIT 10 PULSE [vdvMonitor_1, POWER_ON]
    WAIT 20 PULSE [vdvMonitor_4, POWER_ON]
    WAIT 30 PULSE [vdvMonitor_5, POWER_OFF]
    WAIT 40 PULSE [vdvMonitor_6, POWER_OFF]
    WAIT 50 PULSE [vdvMonitor_7, POWER_OFF]
    WAIT 60 PULSE [vdvMonitor_8, POWER_OFF]
    WAIT 70 PULSE [vdvMonitor_9, POWER_ON]
}
DEFINE_CALL 'SET MODE' (CHAR cMode[20])
{
    SWITCH (cMode)
    {
	CASE 'Full Presentation' : //All TVS receive Same Source... [Mersive, WallPlate, Desktop]
	{
	    nMode_ = MODE_PRESENTATION
	    fnPWRDisplaysON()
	    
	    fnSetDGXRoutePresentation(IN_DESKTOP) //Default
	    fnSetDGXAudio(IN_DESKTOP)
		fnVolumeMute(TAG_DGX, ID_DGX, SET_MUTE_OFF)
		
		    WAIT 60 //Let TV's Warm...
		    {
			fnSWITCHDisplaySource()
		    }
	}
	CASE 'Zone Presentation' :
	{
	    nMode_ = MODE_PRESENTATION_ZONE
	    fnPWRZoneON()
	    
	    fnSetDGXRouteZone(IN_DESKTOP)
		fnSetDGXAudio(IN_DESKTOP)
		fnVolumeMute(TAG_DGX, ID_DGX, SET_MUTE_OFF)
		
		WAIT 60 //Let TV's Warm...
		{
		    SEND_COMMAND vdvMonitor_2, "'INPUT-HDMI,1'"
		    SEND_COMMAND vdvMonitor_3, "'INPUT-HDMI,1'"
		}
	}
	CASE 'GameDay' :
	{
	    nMode_ = MODE_GAME
	    fnPWRDisplaysON()
	    
	    fnVolumeMute(TAG_DGX, ID_DGX, SET_MUTE_OFF)
	    
	    fnSetDGXRouteAV(IN_TVTUNER_1,OUT_TV_1)
	    fnSetDGXAudio(IN_TVTUNER_1)
	    
	    
	    WAIT 10 fnSetDGXRouteAV(IN_TVTUNER_1,OUT_TV_2)
	    WAIT 20 fnSetDGXRouteAV(IN_TVTUNER_2,OUT_TV_3)
	    WAIT 30 fnSetDGXRouteAV(IN_TVTUNER_3,OUT_TV_4)
	    WAIT 40 fnSetDGXRouteAV(IN_TVTUNER_4,OUT_TV_5)
	    WAIT 50 fnSetDGXRouteAV(IN_TVTUNER_4,OUT_TV_6)
	    WAIT 60 fnSetDGXRouteAV(IN_TVTUNER_3,OUT_TV_7)
	    WAIT 70 fnSetDGXRouteAV(IN_TVTUNER_2,OUT_TV_8)
	    WAIT 80 fnSetDGXRouteAV(IN_TVTUNER_1,OUT_TV_9)
	    
	    WAIT 90 fnSWITCHDisplaySource()
	    
	}
	CASE 'OFF' :
	{
	    OFF [nMode_]
	    
	    fnPWRDisplaysOFF()
	    fnVolumeMute(TAG_DGX, ID_DGX, SET_MUTE_ON)
	    SEND_COMMAND vdvTP_Main, "'PAGE-Locked'"
	}
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
BUTTON_EVENT [vdvTP_Main, BTN_PRESENTATION]
BUTTON_EVENT [vdvTP_Main, BTN_PRESENTATION_ZONE]
BUTTON_EVENT [vdvTP_Main, BTN_GAME]
BUTTON_EVENT [vdvTP_Main, BTN_ALL_OFF]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PRESENTATION : CALL 'SET MODE' ('Full Presentation')
	    CASE BTN_PRESENTATION_ZONE : CALL 'SET MODE' ('Zone Presentation')
	    CASE BTN_GAME : CALL 'SET MODE' ('GameDay')
	    CASE BTN_ALL_OFF : CALL 'SET MODE' ('OFF')
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nSourceIDX
	
	nSourceIDX = GET_LAST (nSourceBtns)
	SWITCH (nSourceIDX)
	{
	    CASE 1 : //Desktop...
	    {
		fnSetDGXAudio(IN_DESKTOP)
		
		IF (nMode_ == MODE_PRESENTATION_ZONE)
		{	
		    fnSetDGXRouteZone(IN_DESKTOP)
			
		}
		ELSE
		{
		    fnSetDGXRoutePresentation(IN_DESKTOP)
		}
	    }
	    CASE 2:
	    {
		fnSetDGXAudio(IN_WALL_1)
		
		IF (nMode_ == MODE_PRESENTATION_ZONE)
		{	
		    fnSetDGXRouteZone(IN_WALL_1)
			
		}
		ELSE
		{
		    fnSetDGXRoutePresentation(IN_WALL_1)
		}
	    }
	    CASE 3:
	    {
		fnSetDGXAudio(IN_MERSIVE_001)
		
		IF (nMode_ == MODE_PRESENTATION_ZONE)
		{	
		    fnSetDGXRouteZone(IN_MERSIVE_001)
			
		}
		ELSE
		{
		    fnSetDGXRoutePresentation(IN_MERSIVE_001)
		}
	    }
	}
    }
}
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
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
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


