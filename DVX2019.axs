PROGRAM_NAME='Master-Small-Conf'
(***********************************************************)
(*  FILE CREATED ON: 03/14/2019  AT: 08:22:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/20/2019  AT: 06:49:20        *)
(***********************************************************)

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
dvDvxSwitcher =			5002:1:0 //DVX 2255HD - T

dvTP1_RMS           =  			10001:7:0  // RMS Touch Panels (Device Port for RMS TP pages)

dvVIDEOIN_1   = 			5002:1:0 //DVI 1
dvVIDEOIN_2  = 			5002:2:0 //DVI 2
dvVIDEOIN_3   = 			5002:3:0 //HDMI 
dvVIDEOIN_4   = 			5002:4:0 //HDMI
dvVIDEOIN_5   = 			5002:5:0 //DXLINK 1
dvVIDEOIN_6   = 			5002:6:0 //DXLINK2


dvAUDIOIN_11 =			5002:11:0 //Analog Audio Input 11
dvAUDIOIN_12 =			5002:12:0 //Analog Audio Input 12
dvAUDIOIN_13 =			5002:13:0 //Analog Audio Input 13
dvAUDIOIN_14 =			5002:14:0 //Analog Audio Input 14

dvAVOUTPUT1 = 			5002:1:0 //AVB 
dvAVOUTPUT2 = 			5002:2:0 //Audio Out to DSP
dvAVOUTPUT3 = 			5002:3:0 //TV

dvRS232_1 =				5001:1:0 //Biamp
dvRS232_2 =				5001:2:0 //Vaddio Cam
dvRS232_3 =				5001:3:0 //
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

dvRelays =					5001:21:0 //Relays
dvIO =						5001:22:0 //IO's

vdvProjector_left = 			35010:1:0  // NEC C981Q [98"]

dvProjector_left 	=		6001:1:0 // 
dvDxlink_left		=		6001:6:0	//

vdvRMS              =  			41001:1:0  // RMS Client Engine VDV      (Duet Module)
vdvRMSGui           =  			41002:1:0  // RMS User Interface VDV     (Duet Module)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR mainPanelPage[] = 'Presentation';

OSENSOR_ 						= 1


//DVX Inputs...
VIDINPUT_1					= 'Not Used'
VIDINPUT_2					= 'Not Used'
VIDINPUT_3					= 'Mersive Pod'
VIDINPUT_4					= 'Desktop'
VIDINPUT_5					= 'Table Source'
VIDINPUT_6					= 'Not Used'

//DVX Channels
VIDEO_PC_MAIN 				= 4//
VIDEO_MERSIVE				= 3 //
VIDEO_TABLE					= 5 //Mounted Under Table

OUT_PROJ_LEFT				= 3
OUT_AVB						= 1
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
ONE_HOUR					= 60*ONE_MINUTE

//Misc
CR 								= 13
LF 								= 10
MAX_LENGTH 					= 10
DVX_SLEEP						= 100 //Power Save State

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
EDID_PC					= '1920x1080,60'
EDID_MERSIVE				= '1280x720p,60'
EDID_TABLE				= '1920x1080p,60'

//#INCLUDE 'System_Setup_' 
#INCLUDE 'Vaddio_Connect'
#INCLUDE 'Tesira_Phone2'

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR nHelp[15] = '404-894-4669'
VOLATILE CHAR nRoomInfo[30] = 'CODA C1106'

VOLATILE INTEGER nSourceLeft
VOLATILE INTEGER nSourceRight
VOLATILE INTEGER nSourceAudio

VOLATILE SINTEGER nLevelMicMix = -100
VOLATILE SINTEGER nLevelProgMix = -10 
VOLATILE INTEGER nLevelMixOut = 85 //Mix to Amp

VOLATILE INTEGER nPop //Popup Tracking...
VOLATILE INTEGER nLockout
VOLATILE INTEGER nMute_left 
VOLATILE INTEGER nTPOnline

VOLATILE LONG lTLFeedback[] = {250}
VOLATILE LONG lTLFlash[] = {500}
VOLATILE INTEGER iFLASH 

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE DEV dvRMSTP[] =
{
   dvTP1_RMS
}
VOLATILE DEV dvRMSTP_Base[] =
{
   dvTP_Main
}

VOLATILE INTEGER nProjectorLeft[] = 
{
    1, //On
    2, //Off
    3, //Mute
    4, //Up
    5,  //Down
    
    11, //PC
    13, //Table
    15  //Mersive
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvIO, OSENSOR_ON], [dvIO, OSENSOR_OFF])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJ_LEFT)" //Get INput of 1
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-AUDIO,',ITOA(OUT_AMP_MAIN)" //Get Input of Sound
}
DEFINE_FUNCTION fnSCREEN(INTEGER cRelay) //Function Screen Up or Down
{
    PULSE [dvRelays, cRelay]
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '19:00:00')
    {
	fnPowerDisplays('OFF')
    }
    ELSE IF (TIME = '22:30:00')
    {
	fnPowerDisplays('OFF')
    }
}
DEFINE_FUNCTION fnPowerDisplays(CHAR cPWR[MAX_LENGTH])
{
    SWITCH (cPWR)
    {
	CASE 'ON':
	{
	    PULSE [vdvProjector_left, POWER_ON] 
	    //fnSCREEN (SCREEN_LEFT_DN)
	}
	CASE 'OFF':
	{
	    PULSE [vdvProjector_left, POWER_OFF]
//	    WAIT 30
//	    {
//		fnSCREEN(SCREEN_LEFT_UP)
//	    }
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
    
    //Turn on Network Traffic...
    WAIT 30
    {
    SEND_COMMAND dvVIDEOIN_5, "'DXLINK_IN_ETH-auto'"
    SEND_COMMAND dvAVOUTPUT3, "'DXLINK_ETH-auto'"
    }
    WAIT 50
    {
    //Preferred Edid...
    SEND_COMMAND dvVIDEOIN_3, "'VIDIN_PREF_EDID-',EDID_MERSIVE"
    SEND_COMMAND dvVIDEOIN_4, "'VIDIN_PREF_EDID-',EDID_PC"
    SEND_COMMAND dvVIDEOIN_5, "'VIDIN_PREF_EDID-',EDID_TABLE"
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
DEFINE_FUNCTION fnRouteAudio (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(OUT_AMP_MAIN)"
    nSourceAudio = cIn 
}
DEFINE_FUNCTION fnSetScale(DEV cDevice)
{
    WAIT 80
    {
      #IF_DEFINED AUTO 
      SEND_COMMAND cDevice, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDevice, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      #END_IF
	
      #IF_DEFINED MANUAL
      SEND_COMMAND cDevice, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDevice, "'VIDOUT_RES_REF-',SET_RESOLUTION" 
      SEND_COMMAND cDevice, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      #END_IF
	
      #IF_DEFINED BYPASS
      SEND_COMMAND cDevice, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDevice, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      #END_IF
    }
}

DEFINE_MODULE 'RmsNetLinxAdapter_dr4_0_0' mdlRMSNetLinx(vdvRMS);
DEFINE_MODULE 'RmsClientGui_dr4_0_0' mdlRMSGUI(vdvRMSGui,dvRMSTP,dvRMSTP_Base);
DEFINE_MODULE 'RmsControlSystemMonitor' mdlRmsControlSystemMonitorMod(vdvRMS,dvMaster);
DEFINE_MODULE 'RmsNlTVMonitor' mdlRmsTVMonitorMod(vdvRMS, vdvProjector_left, dvProjector_left);
    
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);


DEFINE_MODULE 'NEC_E656' LeftMON(vdvProjector_left, dvProjector_left);


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
	    CASE 1: fnPowerDisplays ('ON')
	    CASE 2: fnPowerDisplays ('OFF')
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
	   // CASE 4: fnSCREEN(SCREEN_LEFT_UP)
	   // CASE 5: fnSCREEN(SCREEN_LEFT_DN)

	    //Video Switching...
	    CASE 6: //PC MAIN LEFT
	    {
		fnRouteVideoLeft(VIDEO_PC_MAIN)
		fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 7: //Presetner
	    {
		fnRouteVideoLeft(VIDEO_TABLE)
		fnRouteAudio(VIDEO_TABLE)
	    }
	    CASE 8: //Mersive...
	    {
		fnRouteVideoLeft(VIDEO_MERSIVE)
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
	WAIT 150 'ENGAGE TIMER'  //15 seconds
	{
	    fnPowerDisplays('OFF') 
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
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI5O3',1)): 
	    {
        nSourceLeft = VIDEO_TABLE
        nSourceAudio = VIDEO_TABLE
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI4O3',1)):
	    {
        nSourceLeft = VIDEO_PC_MAIN
        nSourceAudio = VIDEO_PC_MAIN
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI3O3',1)):
	    {
        nSourceLeft = VIDEO_MERSIVE
        nSourceAudio = VIDEO_MERSIVE
	    }
	  }
  }
}
DATA_EVENT [dvTp_Main]
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
	    fnSetScale(dvDxlink_left)
	
      WAIT 150 
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
DATA_EVENT[vdvRMS]
{
    ONLINE:
    {
	    SEND_COMMAND data.device, 'CONFIG.DEVICE.AUTO.REGISTER.FILTER-6001,6002'
    }
}
DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    //fnKill() 
	  fnReboot()
	
    // Left, 
    [vdvTP_MAIN,11] = nSourceLeft = VIDEO_PC_MAIN
    [vdvTP_MAIN,13] = nSourceLeft = VIDEO_TABLE
    [vdvTP_MAIN,15] = nSourceLeft = VIDEO_MERSIVE
    
    [vdvTP_MAIN,511] = nSourceAudio = VIDEO_PC_MAIN
    [vdvTP_MAIN,513] = nSourceAudio = VIDEO_TABLE
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



