PROGRAM_NAME='Master'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/10/2019  AT: 13:51:01        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    HDMI Port to Vaddio Feed??
    Serial Connection for Vaddio ?? Use Port 3
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster 		=			0:1:0	//DVX Master
dvTP_MAIN   	= 			10001:1:0
dvTP_Table =				10002:1:0

dvTP1_RMS           =  			10001:7:0  // RMS Touch Panels (Device Port for RMS TP pages)
dvTP2_RMS           =  			10002:7:0  //  (RMS uses port 7 by default)

dvDvxSwitcher =			5002:1:0 //DVX 3255HD - T

dvVIDEOIN_1   = 			5002:1:0 //DVI 1
dvVIDEOIN_2  = 			5002:2:0 //DVI 2
dvVIDEOIN_3   = 			5002:3:0 //DVI 3
dvVIDEOIN_4   = 			5002:4:0 //DVI 4
dvVIDEOIN_5   = 			5002:5:0 //HDMI 1
dvVIDEOIN_6   = 			5002:6:0 //HDMI 2
dvVIDEOIN_7  = 			5002:7:0 //HDMI 3
dvVIDEOIN_8   = 			5002:8:0 //HDMI 4
dvVIDEOIN_9  = 			5002:9:0 //DxLink 1
dvVIDEOIN_10  = 			5002:10:0 //DxLink 2

dvAUDIOIN_11 =			5002:11:0 //Analog Audio Input 11
dvAUDIOIN_12 =			5002:12:0 //Analog Audio Input 12
dvAUDIOIN_13 =			5002:13:0 //Analog Audio Input 13
dvAUDIOIN_14 =			5002:14:0 //Analog Audio Input 14

dvAVOUTPUT1 = 			5002:1:0 //Projector
dvAVOUTPUT2 = 			5002:2:0 //Audio Out to DSP
dvAVOUTPUT3 = 			5002:3:0 //Monitor
dvAVOUTPUT4 = 			5002:4:0 //AVB Send

dvRS232_1 =				5001:1:0 //Front Cam Control
dvRS232_2 =				5001:2:0 //Rear Cam Control
dvRS232_3 =				5001:3:0 //Biamp
dvRS232_4 =				5001:4:0
dvRS232_5 =				5001:5:0
dvRS232_6 =				5001:6:0

dvIR_1 =					5001:9:0
dvIR_2 =					5001:10:0
dvIR_3 =					5001:11:0
dvIR_4 =					5001:12:0
dvIR_5 =					5001:13:0
dvIR_6 =					5001:14:0
dvIR_7 =					5001:15:0
dvIR_8 =					5001:16:0

dvRelays =					5001:8:0 //Relays
dvIO =					5001:17:0 //IO's

vdvProjector_left = 			35010:1:0  // NEC NP-PA653U-41ZL
dvProjector_left 	=			6001:1:0 // 
dvDxlink_left		=		6001:6:0	//


vdvRMS              =  			41001:1:0  // RMS Client Engine VDV      (Duet Module)
vdvRMSGui           =  			41002:1:0  // RMS User Interface VDV     (Duet Module)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR mainPanelPage[] = 'Presentation';

OSENSOR_ 						= 1 //Occupancy Sensor Connection

//Relays...
SCREEN_LEFT_UP					= 1
SCREEN_LEFT_DN					= 2
SCREEN_RIGHT_UP				= 3
SCREEN_RIGHT_DN				= 4

//DVX Inputs...
VIDINPUT_1					= 'Vaddio Cam Front'
VIDINPUT_2					= 'Vaddio Cam Rear'
VIDINPUT_3					= 'Not Used'
VIDINPUT_4					= 'Not Used'
VIDINPUT_5					= 'Mersive POD'
VIDINPUT_6					= 'Desktop'
VIDINPUT_7					= 'Not Used'
VIDINPUT_8					= 'Not Used'
VIDINPUT_9					= 'Presenter'
VIDINPUT_10					= 'Table Source'

//DVX Channels
VIDEO_PC_MAIN 				=  6//HDMI
VIDEO_CAM_FRONT			= 1 //Mounted on Front Wall
VIDEO_CAM_REAR				= 2//
VIDEO_MERSIVE				= 5 //
VIDEO_DXLINK_9				= 9 //Presenter
VIDEO_TABLE					= 10 //Mounted Under Table

OUT_PROJ_LEFT				= 1
OUT_MONITOR				= 3
OUT_AVB					= 2
OUT_AMP_MAIN				= 2

//Mix Levels...
OUTPUT_VOLUME				= 1 //Output 
PROGRAM_MIX				= 41
MICROPHONE_MIX_1			= 42 
MICROPHONE_MIX_2			= 43 

//Common Projector Channels..
POWER_CYCLE					= 9
POWER_ON					= 27
POWER_OFF					= 28
WARMING						= 253
COOLING						= 254
ON_LINE						= 251
POWER						= 255
BLANK							= 211

// Times
TL_FEEDBACK					= 1
TL_FLASH						= 2


ONE_SECOND					= 10 //may have to set to 1000
ONE_MINUTE					= 60*ONE_SECOND
ONE_HOUR						= 60*ONE_MINUTE

//Misc
CR 								= 13
LF 								= 10
MAX_LENGTH 					= 10

SET_MUTE_ON					= 'ENABLE'
SET_MUTE_OFF				= 'DISABLE'

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100

//Set DxLinks...
//Uncomment the Desired Scaling...
#DEFINE AUTO
//#DEFINE MANUAL 
//#DEFINE BYPASS

#IF_DEFINED AUTO
SET_SCALE					= 'AUTO'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

#IF_DEFINED MANUAL
SET_RESOLUTION			= '1920x1080p,60'
SET_SCALE					= 'MANUAL'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

#IF_DEFINED BYPASS
SET_SCALE					= 'BYPASS'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

//Preferred EDID...
EDID_PC					= '1280x720,60'
EDID_MERSIVE				= '1280x720p,60'
EDID_TABLE				= '1280x720p,60'
EDID_VADDIO				= '1280x720p,60'



(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR nHelp[15] = '404-894-4669'
VOLATILE CHAR nRoomInfo[30] = 'CODA C1315'

VOLATILE INTEGER nSourceLeft
VOLATILE INTEGER nSourceRight
VOLATILE INTEGER nSourceAudio

VOLATILE SINTEGER nLevelMicMix = -100
VOLATILE SINTEGER nLevelProgMix = -10 
VOLATILE INTEGER nLevelMixOut = 85 //Mix to Amp

VOLATILE INTEGER nPop //Popup Tracking...
VOLATILE INTEGER nLockout
VOLATILE INTEGER nMute_left 
VOLATILE INTEGER nMute_right 
VOLATILE INTEGER nTPOnline

VOLATILE LONG lTLFeedback[] = {250}
VOLATILE LONG lTLFlash[] = {500}
VOLATILE INTEGER iFLASH //For Blinky Buttons

DEV vdvTP_Main[] = {dvTP_MAIN, dvTP_Table}

VOLATILE DEV dvRMSTP[] =
{
   dvTP1_RMS,
   dvTP2_RMS
}
VOLATILE DEV dvRMSTP_Base[] =
{
   dvTP_Main,
   dvTP_Table
}

VOLATILE INTEGER nProjectorLeft[] = 
{
    1, //On
    2, //Off
    3, //Mute
    4, //Up
    5,  //Down
    
    11, //PC
    13, //Presenter
    14, //Table
    15  //Mersive
}
VOLATILE INTEGER nMonitorBtns[] = 
{
    101, //On
    102, //Off
    103, //Mute
    104, //Up
    105,  //Down
    
    111, //PC
    113, //Presenter
    114, //Table
    115  //Mersive
}

//#INCLUDE 'System_Setup_' 
#INCLUDE 'Vaddio_Connect'
#INCLUDE 'Tesira_Phone2'

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
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJ_LEFT)" //Get INput of 1
    WAIT 20 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_MONITOR)" //Get Input of 3
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-AUDIO,',ITOA(OUT_AMP_MAIN)" //Get Input of Sound
}
DEFINE_FUNCTION fnSCREEN(INTEGER cRelay) //Function Screen Up or Down
{
    PULSE [dvRelays, cRelay]
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '22:00:00')
    {
	fnPowerDisplays('LEFT OFF')
	fnPowerDisplays('RIGHT OFF')
    }
    ELSE IF (TIME = '22:30:00')
    {
	fnPowerDisplays('LEFT OFF')
	fnPowerDisplays('RIGHT OFF')
    }
}
DEFINE_FUNCTION fnPowerDisplays(CHAR cPWR[MAX_LENGTH])
{
    SWITCH (cPWR)
    {
	CASE 'LEFT ON':
	{
	    PULSE [vdvProjector_left, POWER_ON] 
	    fnSCREEN (SCREEN_LEFT_DN)
	}
	CASE 'LEFT OFF':
	{
	    PULSE [vdvProjector_left, POWER_OFF]
	    WAIT 30
	    {
		fnSCREEN(SCREEN_LEFT_UP)
	    }
	}
    }
}
DEFINE_FUNCTION fnMuteProjector(DEV cDevice, CHAR cMuteState[MAX_LENGTH])
{
    SEND_COMMAND cDevice, "'VIDOUT_MUTE-',cMuteState"
    WAIT 5
    {
	SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
    }
}
DEFINE_FUNCTION fnMuteStatus(DEV cDevice)
{
    SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
}
DEFINE_FUNCTION fnSetAudioLevels() //Set DVX Audio Levels
{
    WAIT 10 SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,nLevelMicMix
    WAIT 20 SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,nLevelMicMix
    WAIT 30 SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nLevelProgMix
    WAIT 40 SEND_LEVEL dvAVOUTPUT2,OUTPUT_VOLUME,nLevelMixOut
}
DEFINE_CALL 'DVX INPUT SETUP' //Setup Input Names...
{
    SEND_COMMAND dvVIDEOIN_1, "'VIDIN_NAME-',VIDINPUT_1"
    SEND_COMMAND dvVIDEOIN_2, "'VIDIN_NAME-',VIDINPUT_2"
    SEND_COMMAND dvVIDEOIN_3, "'VIDIN_NAME-',VIDINPUT_3"
    SEND_COMMAND dvVIDEOIN_4, "'VIDIN_NAME-',VIDINPUT_4"
    SEND_COMMAND dvVIDEOIN_5, "'VIDIN_NAME-',VIDINPUT_5"
    SEND_COMMAND dvVIDEOIN_6, "'VIDIN_NAME-',VIDINPUT_6"
    SEND_COMMAND dvVIDEOIN_7, "'VIDIN_NAME-',VIDINPUT_7"
    SEND_COMMAND dvVIDEOIN_8, "'VIDIN_NAME-',VIDINPUT_8"
    SEND_COMMAND dvVIDEOIN_9, "'VIDIN_NAME-',VIDINPUT_9"
    SEND_COMMAND dvVIDEOIN_10, "'VIDIN_NAME-',VIDINPUT_10"
    
    WAIT 20
    {
    //Preferred Edid...
    SEND_COMMAND dvVIDEOIN_1, "'VIDIN_PREF_EDID-',EDID_VADDIO"
    SEND_COMMAND dvVIDEOIN_2, "'VIDIN_PREF_EDID-',EDID_VADDIO"
    SEND_COMMAND dvVIDEOIN_5, "'VIDIN_PREF_EDID-',EDID_MERSIVE"
    SEND_COMMAND dvVIDEOIN_6, "'VIDIN_PREF_EDID-',EDID_PC"
    SEND_COMMAND dvVIDEOIN_9, "'VIDIN_PREF_EDID-',EDID_TABLE" //Podium
    SEND_COMMAND dvVIDEOIN_10, "'VIDIN_PREF_EDID-',EDID_TABLE" //Table
    }
    
    WAIT 40
    {
            //Turn on Network Traffic...
    SEND_COMMAND dvVIDEOIN_9, "'DXLINK_IN_ETH-auto'"
    SEND_COMMAND dvVIDEOIN_10, "'DXLINK_IN_ETH-auto'"
    SEND_COMMAND dvAVOUTPUT1, "'DXLINK_ETH-auto'"
    SEND_COMMAND dvAVOUTPUT3, "'DXLINK_ETH-auto'"
    }
    
    WAIT 80
    {
	fnSetAudioLevels()
    }
    
    
}
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
DEFINE_FUNCTION fnRouteVideoLeft (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJ_LEFT)"
    nSourceLeft = cIn 
}
DEFINE_FUNCTION fnRouteVideoRight (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_MONITOR)"
    nSourceRight = cIn 
}
DEFINE_FUNCTION fnRouteAudio (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(OUT_AMP_MAIN)"
    nSourceAudio = cIn 
}
DEFINE_FUNCTION fnRouteCamera(INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_AVB)"
}

DEFINE_MODULE 'RmsNetLinxAdapter_dr4_0_0' mdlRMSNetLinx(vdvRMS);
DEFINE_MODULE 'RmsClientGui_dr4_0_0' mdlRMSGUI(vdvRMSGui,dvRMSTP,dvRMSTP_Base);
DEFINE_MODULE 'RmsControlSystemMonitor' mdlRmsControlSystemMonitorMod(vdvRMS,dvMaster);
DEFINE_MODULE 'RmsNlVideoProjectorMonitor' mdlRmsVideoProjectorMonitorMod(vdvRMS, vdvProjector_left, dvProjector_left);


    
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

DEFINE_MODULE 'NEC_Generic_Laser' LeftMON(vdvProjector_left, dvProjector_left);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTp_Main,nProjectorLeft] //Projector Power / Muting
{
    PUSH:
    {
	STACK_VAR INTEGER nProjLeftIdx
	
	nProjLeftIdx = GET_LAST (nProjectorLeft)
	SWITCH (nProjLeftIdx)
	{
	    CASE 1: fnPowerDisplays ('LEFT ON')
	    CASE 2: fnPowerDisplays ('LEFT OFF')
	    CASE 3:
	    {
		IF (!nMute_left)
		{
		    fnMuteProjector(dvDxlink_left, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvDxlink_left, SET_MUTE_OFF)
		}
	    }
	    CASE 4: fnSCREEN(SCREEN_LEFT_UP)
	    CASE 5: fnSCREEN(SCREEN_LEFT_DN)

	    //Video Switching...
	    CASE 6: //PC MAIN LEFT
	    {
		fnRouteVideoLeft(VIDEO_PC_MAIN)
		fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 7: //Presetner
	    {
		fnRouteVideoLeft(VIDEO_DXLINK_9)
		fnRouteAudio(VIDEO_DXLINK_9)
	    }
	    CASE 8: //TAble
	    {
		fnRouteVideoLeft(VIDEO_TABLE)
		fnRouteAudio(VIDEO_TABLE)
	    }
	    CASE 9: //HDMI LEFT
	    {
		fnRouteVideoLeft(VIDEO_MERSIVE)
		fnRouteAudio(VIDEO_MERSIVE)
	    }
	}
    }
}
BUTTON_EVENT [vdvTp_Main,nMonitorBtns] //Projector Power / Muting
{
    PUSH:
    {
	STACK_VAR INTEGER nProjRightIdx
	nProjRightIdx = GET_LAST (nMonitorBtns)

	SWITCH (nProjRightIdx)
	{
	    
	    CASE 6: //PC MAIN LEFT
	    {
		fnRouteVideoRight(VIDEO_PC_MAIN)
		fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 7: //PC EXTENDED LEFT
	    {
		fnRouteVideoRight(VIDEO_DXLINK_9)
		fnRouteAudio(VIDEO_DXLINK_9)
	    }
	    CASE 8: //VGA LEFT
	    {
		fnRouteVideoRight(VIDEO_TABLE)
		fnRouteAudio(VIDEO_TABLE)
	    }
	    CASE 9: //HDMI LEFT
	    {
		fnRouteVideoRight(VIDEO_MERSIVE)
		fnRouteAudio(VIDEO_MERSIVE)
	    }
	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [dvIO, OSENSOR_] //Sensor..
{
    ON :
    {
	WAIT 150 'ENGAGE TIMER'  
	{
	    IF ([vdvProjector_left,POWER])
	    {
		   fnPowerDisplays ('LEFT OFF')
	    }
	}
	
    }
    OFF :
    {
	CANCEL_WAIT 'ENGAGE TIMER'
    }
}
CHANNEL_EVENT [vdvProjector_Left, ON_LINE]
CHANNEL_EVENT [vdvProjector_Left, WARMING]
CHANNEL_EVENT [vdvProjector_Left, COOLING]
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
	}
    }
}


DEFINE_EVENT
DATA_EVENT [dvDvxSwitcher] 
{
    ONLINE:
    {
	WAIT 80
	{
	    CALL 'DVX INPUT SETUP'
	    WAIT 40
	    {
		fnDVXPull()
	    }
	}
    }
    COMMAND:
    {
	CHAR cTmp[20]
	cTmp = DATA.TEXT
	
	SELECT
	{
	    //Left Source...
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI6O1',1)): 
	    {
		nSourceLeft = VIDEO_PC_MAIN
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI5O1',1)):
	    {
		nSourceLeft = VIDEO_MERSIVE
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI9O1',1)):
	    {
		nSourceLeft = VIDEO_DXLINK_9
		
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI10O1',1)):
	    {
		nSourceLeft = VIDEO_TABLE
	    }
	    //Audio Feedback...
	    ACTIVE(FIND_STRING(cTmp,'SWITCH-LAUDIOI6O2',1)):
	    {
		nSourceAudio = VIDEO_PC_MAIN
	    }
	    ACTIVE(FIND_STRING(cTmp,'SWITCH-LAUDIOI5O2',1)):
	    {
		nSourceAudio = VIDEO_MERSIVE
	    }
	    ACTIVE(FIND_STRING(cTmp,'SWITCH-LAUDIOI9O2',1)):
	    {
		nSourceAudio = VIDEO_DXLINK_9
	    }
	    ACTIVE(FIND_STRING(cTmp,'SWITCH-LAUDIOI10O2',1)):
	    {
		nSourceAudio = VIDEO_TABLE
	    }
	}
    }
}
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoomInfo"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp"
    }
}
DATA_EVENT [dvTP_Table]
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoomInfo"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp"
    }
    OFFLINE :
    {
	OFF [nTPOnline]
    }
}
DATA_EVENT [dvDxlink_left]
{
    ONLINE:
    {
	#IF_DEFINED AUTO 
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	#IF_DEFINED MANUAL
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_RES_REF-',SET_RESOLUTION" 
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	#IF_DEFINED BYPASS
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	WAIT 50 
	{
	    SEND_COMMAND DATA.DEVICE, "'?VIDOUT_MUTE'"
	}
	
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMute_left]
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMute_left]
	    }
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnKill() 
	fnReboot()
    // Left, 
    [vdvTP_MAIN,11] = nSourceLeft = VIDEO_PC_MAIN

    [vdvTP_MAIN,13] = nSourceLeft = VIDEO_DXLINK_9
    [vdvTP_MAIN,14] = nSourceLeft = VIDEO_TABLE
    [vdvTP_MAIN,15] = nSourceLeft = VIDEO_MERSIVE
    
    [vdvTP_MAIN,111] = nSourceRight = VIDEO_PC_MAIN

    [vdvTP_MAIN,113] = nSourceRight = VIDEO_DXLINK_9
    [vdvTP_MAIN,114] = nSourceRight = VIDEO_TABLE
    [vdvTP_MAIN,115] = nSourceRight = VIDEO_MERSIVE
    
    [vdvTP_MAIN,511] = nSourceAudio = VIDEO_PC_MAIN
    [vdvTP_MAIN,513] = nSourceAudio = VIDEO_DXLINK_9
    [vdvTP_MAIN,514] = nSourceAudio = VIDEO_TABLE
    [vdvTP_MAIN,515] = nSourceAudio = VIDEO_MERSIVE
        
    //Left Projector
    [vdvTP_MAIN,1]	= [vdvProjector_left,POWER]
    [vdvTP_MAIN,2]	= ![vdvProjector_left, POWER]
    [vdvTP_MAIN,3]	= nMute_left
    [vdvTP_MAIN, 601] = [vdvProjector_left, ON_LINE] 

    IF ([vdvProjector_left, WARMING])
    {
	[vdvTP_Main, 602] = iFLASH
    }
    ELSE IF ([vdvProjector_left, COOLING])
    {
	[vdvTP_Main, 603] = iFLASH
    }
    ELSE
    {
	[vdvTP_Main, 602] = [vdvProjector_left, WARMING]
	[vdvTP_Main, 603] = [vdvProjector_left, COOLING]
    }

    WAIT ONE_MINUTE
    {
	fnMuteStatus (dvDxlink_left)
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


