PROGRAM_NAME='Klaus1447_2456'

(***********************************************************)
(*  FILE CREATED ON: 04/18/2012  AT: 17:49:32              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/04/2019  AT: 13:20:52        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Chris Robinson

    Need to Implement Modes - If - room has 3 projectors!
    Need to Implement Blank Screen Timeout - 10Second Wait after blank is pushed
    Surround Sound for BluRay
    //
    Dual Room Projector
    

*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster 		=				0:1:0	//DVX Master
dvTP_MAIN   	= 				10001:1:0

dvDvxSwitcher =				5002:1:0 //DVX Switcher

dvVIDEOIN_1   = 				5002:1:0 //PC Main
dvVIDEOIN_2  = 				5002:2:0 //PC Extended Desktop
dvVIDEOIN_3   = 				5002:3:0 //VGA Laptop
dvVIDEOIN_4   = 				5002:4:0 //DVI Laptop
dvVIDEOIN_5   = 				5002:5:0 //Document Camera
dvVIDEOIN_6   = 				5002:6:0 //BluRay
dvVIDEOIN_7  = 				5002:7:0 //Not used
dvVIDEOIN_8   = 				5002:8:0 //Not used
dvVIDEOIN_9  = 				5002:9:0 //Not used
dvVIDEOIN_10  = 				5002:10:0 //Not used

dvAVOUTPUT1 = 				5002:1:0 //DXLink + HDMI -- House Left
dvAVOUTPUT2 = 				5002:2:0 //HDMI
dvAVOUTPUT3 = 				5002:3:0 //DXLink + HDMI -- House Right (if Dual Proj)
dvAVOUTPUT4 = 				5002:4:0 //HDMI

dvSurround	= 				5001:2:0		// RS2, B&K Reference 50 Surround Processor

dvBluRay =						5001:4:0	//Sharp BDHP 
dvTuner =						5001:5:0	//Contemporary Research
dvLights	= 					5001:6:0	// RS7, Lutron Lights Graphic 6000 - unknown system areas and scenes
dvRelays =						5001:8:0
dvIO =							5001:17:0 //IO's

vdvProjector_left =				35011:1:0  // Duet Module for Left Projector
vdvProjector_right =			35012:1:0 // Duet Module for Right Projector

dvProjector_left 		=		6001:1:0 // Ties in Duet Module
dvDxlink_left		=			6001:6:0	//DxLink Left -commands use Port 6

dvProjector_right		=		6002:1:0 // 
dvDxlink_right		=			6002:6:0	//


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Screens
screen_up_left					= 2
screen_down_left				= 1
screen_up_right				= 4
screen_down_right				= 3
screen_up_center				= 6
screen_down_center			= 5 

// Volume Adjustment Values
Volume_Up_Single				= 1
Volume_Up_Multiple			= 3
Volume_Down_Single			= -1
Volume_Down_Multiple		= -3

//DVX Video Channels
VIDEO_PC_MAIN 				= 1 //Input 1 DVI
VIDEO_PC_EXTENDED 			= 2 //Input 2 DVI
VIDEO_VGA					= 3 //Input 3 DVI
VIDEO_DOC_CAM				= 4 //Input 4 DVI
VIDEO_HDMI					= 5 //Input 5 HDMI
VIDEO_DVD					= 6 //input 6 HDMI
VIDEO_TUNER					= 7 //Input 7 HDMI
VIDEO_CODEC_R				= 8 //Input 8 HDMI
VIDEO_EXTRA_1				= 9 //Input 9 DxLink
VIDEO_EXTRA_2				= 10 //Input 10 DxLink

//DVX Audio Channels
AUDIO_INPUT_11				= 11 //Input 11
AUDIO_INPUT_12				= 12
AUDIO_INPUT_13				= 13 
AUDIO_INPUT_14				= 14

OUTPUT_VOLUME				= 1 //Output Volume
PROGRAM_MIX				= 41 //Program Mix
MICROPHONE_MIX_1			= 42
MICROPHONE_MIX_2			= 43

//DVX Outputs..
OUT_PROJECTOR_LEFT			= 1
OUT_PROJECTOR_RIGHT		= 3
OUT_AUDIO_MIX				= 2

//DVX Inputs...
VIDINPUT_1				= 'Desktop Main'
VIDINPUT_2				= 'Desktop Ext'
VIDINPUT_3				= 'Source VGA'
VIDINPUT_4				= 'Doc Cam'
VIDINPUT_5				= 'Source HDMI'
VIDINPUT_6				= 'Blu Ray'
VIDINPUT_7				= 'TV Tuner'
VIDINPUT_8				= 'Not Used'
VIDINPUT_9				= 'Not Used'
VIDINPUT_10				= 'Not Used'

//DXLink Calls...
SET_MUTE_ON				= 'ENABLE'
SET_MUTE_OFF			= 'DISABLE'
MAX_VAL 					= 8

//Set DxLinks...
//Uncomment the Desired Scaling...
//#DEFINE AUTO
#DEFINE MANUAL 
//#DEFINE BYPASS

#IF_DEFINED AUTO
SET_SCALE					= 'AUTO'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

#IF_DEFINED MANUAL
SET_RESOLUTION			= '1280x800,60'
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

//Common Feedback Projector
POWER_CYCLE				= 9
POWER_ON				= 27
POWER_OFF				= 28
WARMING					= 253
COOLING					= 254
ON_LINE					= 251
POWER					= 255
BLANK						= 211

//Lighting Values...
LIGHTS_AREA				= 31
LIGHTS_SCENE1			= 143
LIGHTS_SCENE2			= 144
LIGHTS_SCENE3			= 145
LIGHTS_SCENE4			= 146
LIGHTS_OFF				= 159

TL_FLASH					= 2
TL_FEEDBACK 				= 1

//Times..
ONE_SECOND				= 10 //may have to set to 1000
ONE_MINUTE				= 60*ONE_SECOND
ONE_HOUR				= 60*ONE_MINUTE

//Misc..
CR 							= 13
LF 							= 10

TXT_PRGM					= 31
TXT_MIC_1					= 32
TXT_MIC_2					= 33
TXT_HELP					= 99
TXT_RM					= 100

MAX_LEVEL_OUT				= 80

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR nHelp[15] = '404-894-4669'
VOLATILE CHAR nRoomInfo[30] = 'KLAUS 1447'

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE INTEGER nSourceLeft
VOLATILE INTEGER nSourceRight
VOLATILE INTEGER nSourceAudio

VOLATILE SINTEGER nProgram_Level
VOLATILE SINTEGER nProgram_Level_Preset = -40
VOLATILE INTEGER nProgram_Mute
VOLATILE SINTEGER nProgram_Hold

VOLATILE SINTEGER nMicrophone_Level
VOLATILE SINTEGER nMicrophone_Level_Preset = -40
VOLATILE INTEGER nMicrophone_Mute
VOLATILE SINTEGER nMicrophone_Hold

VOLATILE INTEGER nMute_left //Mute DxLink Left
VOLATILE INTEGER nMute_right //Mute DxLink Right
 
VOLATILE INTEGER nPop
VOLATILE INTEGER nCurrentLightsScene

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000} 
VOLATILE INTEGER iFLASH //For Blinky Buttons

VOLATILE CHAR cPopup_Names[][16] =
{
    '_help me',
    '_volume',
    '_dvd',
    '_lighting',
    '_screens'
}
VOLATILE INTEGER nPopupBtns[] =
{
    1001, //Help...
    1002, //mics
    1003,  //volume
    1004,  //Combine Outside TVs...
    1005
}
VOLATILE INTEGER nProjectorLeft[] = 
{
    1, //On
    2, //Off
    3, //Mute
    4, //Screen up
    5  //Screen Down
}
VOLATILE INTEGER nProjectorRight[] =
{
    101,
    102,
    103,
    104, //Screen Up
    105  //Screen Down
}
VOLATILE INTEGER nVideoLeftBtns[] = 
{
    11, //PC Left
    12, //PC Extended
    13, //VGA 
    14, //HDMI
    15,  //Doc Cam
    16,  //BluRay
    17  //Tuner
}
VOLATILE INTEGER nVideoRightBtns[] = 
{
    111, //PC Left
    112, //PC Extended
    113, //VGA
    114, //HDMI
    115,  //Doc Cam
    116, //BluRay
    117  //Tuner
}
VOLATILE INTEGER nAudioBtns[] = 
{
    301, //Program Mute
    302, //Program Volume Up
    303, //Program Volume Down
    304, //Program Volume Preset
    
    305, //Microphone Mute
    306, //Microphone Up
    307, //Microphone Down
    308 //Microphone Preset
}
VOLATILE INTEGER nLightsBtns[]=
{
    81,  // Lights Off
    82,  // Lights On (preset 1)
    83,  // (preset 2)
    84,  // (preset 3)
    85   // (preset 4)
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvIO,nTimelineIO[1]]..[dvIO,nTimelineIO[8]])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSCREEN(INTEGER nScreen)
{
    PULSE [dvRelays, nScreen]
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '22:00:00')
    {
	fnProjectorPower('LeftOFF')
	fnProjectorPower('RightOFF')
    }
    ELSE IF (TIME = '23:00:00')
    {
	fnProjectorPower('LeftOFF')
	fnProjectorPower('RightOFF')
    }
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = '06:00:00')
    {
	REBOOT (dvMaster)
    }
}
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_LEFT)" 
    WAIT 20 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_RIGHT)" 
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-AUDIO,',ITOA(OUT_AUDIO_MIX)" 
    
    WAIT 60 SEND_LEVEL dvAVOUTPUT2,OUTPUT_VOLUME,MAX_LEVEL_OUT
    WAIT 70 SEND_LEVEL dvAVOUTPUT3,OUTPUT_VOLUME,MAX_LEVEL_OUT
    WAIT 80 CALL 'PROGRAM PRESET'
    WAIT 90 CALL 'MICROPHONE PRESET'
    WAIT 100 SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,-100 //Turn Off to Front
    WAIT 120 SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,-100 //Turn Off to Front
    WAIT 140 SEND_LEVEL dvAVOUTPUT3, PROGRAM_MIX,-100 //No Prgm to Ceiling
}
DEFINE_FUNCTION fnMuteProjector(DEV cDevice, CHAR cState[MAX_VAL])
{
    SEND_COMMAND cDevice, "'VIDOUT_MUTE-',cState"
    WAIT 5
    {
	SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
    }
}
DEFINE_FUNCTION fnMuteCheck(DEV cDevice)
{
    SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
}
DEFINE_FUNCTION fnProjectorPower(CHAR cPwr[11])
{
    SWITCH (cPwr)
    {
	CASE 'LeftON' :
	{
	    fnSCREEN(Screen_Down_Left)
		PULSE [vdvProjector_left, POWER_ON]
	}
	CASE 'LeftOFF' :
	{
	    PULSE [vdvProjector_left, POWER_OFF] 
		WAIT 30
		{
		    fnSCREEN(Screen_Up_Left)	
		}
	}
	CASE 'RightON' :
	{
	    PULSE [vdvProjector_right, POWER_ON]
		fnSCREEN(Screen_Down_Right)	    
	}
	CASE 'RightOFF' :
	{
	    PULSE [vdvProjector_right, POWER_OFF] //Power Off Projector
		WAIT 30
		{
		    fnSCREEN(Screen_Up_Right)
		}
	}
    }
}
DEFINE_CALL 'PROGRAM PRESET'
{
    SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level_Preset
}
DEFINE_CALL 'PROGRAM MUTE'
{
    IF (!nProgram_Mute) 
    {
	nProgram_Hold = nProgram_Level
	SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,-100
    }
    ELSE IF (nProgram_Hold = 0)
    {
	CALL 'PROGRAM PRESET'
    }
    ELSE
    {
	nProgram_Level = nProgram_Hold
	SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level
    }
}
DEFINE_CALL 'MICROPHONE PRESET'
{
    SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,nMicrophone_Level_Preset
}
DEFINE_CALL 'MICROPHONE MUTE'
{
	IF (!nMicrophone_Mute)
	{
	    nMicrophone_Hold = nMicrophone_Level
	    SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,-100
	}
	ELSE IF (nMicrophone_Hold = 0)
	{
	    CALL 'MICROPHONE PRESET'
	}
	ELSE
	{
	    nMicrophone_Level = nMicrophone_Hold
	    SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,nMicrophone_Level
	}
}
DEFINE_CALL 'DVX INPUT SETUP' //Setup Input Names, 
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
    
    WAIT 50
    {
	fnDVXPull()
    }
}
DEFINE_FUNCTION fnRouteVideoLeft (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_LEFT)"
}
DEFINE_FUNCTION fnRouteVideoRight (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_RIGHT)"
}
DEFINE_FUNCTION fnRouteAudio (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(OUT_AUDIO_MIX)"
}
DEFINE_FUNCTION fnSetScale(DEV cDev)
{
    WAIT 80
    {
      #IF_DEFINED AUTO 
      SEND_COMMAND cDev, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDev, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      #END_IF
	
      #IF_DEFINED MANUAL
      SEND_COMMAND cDev, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDev, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      WAIT 20
      {
	SEND_COMMAND cDev, "'VIDOUT_RES_REF-',SET_RESOLUTION" 
	}
      
      #END_IF
	
      #IF_DEFINED BYPASS
      SEND_COMMAND cDev, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDev, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      #END_IF
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START

WAIT 250
{
 TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
  TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
}

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)


DEFINE_MODULE 'Sony_FHZ65' ProjLeft(vdvProjector_left, dvProjector_left)
DEFINE_MODULE 'Sony_FHZ65' ProjRight(vdvProjector_right, dvProjector_right)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, nPopupBtns]
{
    PUSH :
    {
	SEND_COMMAND vdvTP_Main, "'PPON-',cPopup_Names[GET_LAST(nPopupBtns)]"
	nPop = GET_LAST(nPopupBtns)
    }
}
BUTTON_EVENT [vdvTp_Main,nProjectorLeft] //Projector Power / Muting
{
    PUSH:
    {
	STACK_VAR INTEGER nProjLeftIdx
	
	nProjLeftIdx = GET_LAST (nProjectorLeft)
	SWITCH (nProjLeftIdx)
	{
	    CASE 1: fnProjectorPower('LeftON')
	    CASE 2: fnProjectorPower('LeftOFF')
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
	    CASE 4: fnSCREEN(screen_down_left)
	    CASE 5: fnSCREEN(screen_up_left)
	}
    }
}
BUTTON_EVENT [vdvTp_Main,nProjectorRight] //Projector Power / Muting
{
    PUSH:
    {
	STACK_VAR INTEGER nProjRightIdx
	
	nProjRightIdx = GET_LAST (nProjectorRight)
	SWITCH (nProjRightIdx)
	{
	    CASE 1: fnProjectorPower('RightON')
	    CASE 2: fnProjectorPower('RightOFF')
	    CASE 3: 
	    {
		IF (!nMute_right)
		{
		    fnMuteProjector(dvDxlink_right, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvDxlink_right, SET_MUTE_OFF)
		}
	    }
	    CASE 4: fnSCREEN(screen_down_right)
	    CASE 5: fnSCREEN(screen_up_right)
	}
    }
}
BUTTON_EVENT [vdvTP_Main,nVideoLeftBtns] //Video Source Left 
{
    PUSH:
    {
	STACK_VAR INTEGER nVidLeftIdx
	
	nVidLeftIdx = GET_LAST (nVideoLeftBtns)
	SWITCH (nVidLeftIdx)
	{
	    CASE 1: //PC MAIN LEFT
	    {
		fnRouteVideoLeft(VIDEO_PC_MAIN)
		    fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 2: //PC EXTENDED LEFT
	    {
		fnRouteVideoLeft(VIDEO_PC_EXTENDED)
		    fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 3: //VGA LEFT
	    {
		fnRouteVideoLeft(VIDEO_VGA)
		    fnRouteAudio(VIDEO_VGA)
	    }
	    CASE 4: //HDMI LEFT
	    {
		fnRouteVideoLeft(VIDEO_HDMI)
		    fnRouteAudio(VIDEO_HDMI)
	    }
	    CASE 5: //Doc Cam
	    {
		fnRouteVideoLeft(VIDEO_DOC_CAM)
	    }
	    CASE 6: //Blu Ray
	    {
		fnRouteVideoLeft(VIDEO_DVD)
		    fnRouteAudio(VIDEO_DVD)
	    }
	    CASE 7: //Tuner
	    {
		fnRouteVideoLeft(VIDEO_TUNER)
		    fnRouteAudio(VIDEO_TUNER)
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main,nVideoRightBtns] //Video Source Right
{
    PUSH:
    {
	STACK_VAR INTEGER nVidRightIdx
	
	nVidRightIdx = GET_LAST (nVideoRightBtns)
	SWITCH (nVidRightIdx)
	{
	    CASE 1: //PC MAIN Right
	    {
		fnRouteVideoRight(VIDEO_PC_MAIN)
		    fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 2: //PC EXTENDED Right
	    {
		fnRouteVideoRight(VIDEO_PC_EXTENDED)
		    fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 3: //VGA Right
	    {
		fnRouteVideoRight(VIDEO_VGA)
		    fnRouteAudio(VIDEO_VGA)
	    }
	    CASE 4: //HDMI Right
	    {
		fnRouteVideoRight(VIDEO_HDMI)
		    fnRouteAudio(VIDEO_HDMI)
	    }
	    CASE 5: //Doc Cam Right
	    {
		fnRouteVideoRight(VIDEO_DOC_CAM)
	    }
	    CASE 6: //DVD Right
	    {
		fnRouteVideoRight(VIDEO_DVD)
		    fnRouteAudio(VIDEO_DVD)
	    }
	    CASE 7: //TUNER Right
	    {
		fnRouteVideoRight(VIDEO_TUNER)
		    fnRouteAudio(VIDEO_TUNER)
	    }
	}
    }    
}
BUTTON_EVENT [vdvTp_Main, nAudioBtns] //Audio Controls 
{
    PUSH:
    {
	    STACK_VAR INTEGER nVolumeIdx
	    
	    nVolumeIdx = GET_LAST (nAudioBtns)
	    SWITCH (nVolumeIdx)
	    {
		CASE 1: CALL 'PROGRAM MUTE'
		CASE 2: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Up_Single
		CASE 3: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Down_Single
		CASE 4: CALL 'PROGRAM PRESET'
		
		CASE 5: CALL 'MICROPHONE MUTE'
		CASE 6: SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Up_Single
		CASE 7: SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Down_Single
		CASE 8: CALL 'MICROPHONE PRESET'
	    }
    }
    HOLD [2,REPEAT]: 
    {
	STACK_VAR INTEGER nVolumeIdx
	
	nVolumeIdx = GET_LAST (nAudioBtns)
	SWITCH (nVolumeIdx)
	{
	    CASE 2: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Up_Multiple
	    CASE 3: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Down_Multiple
	    CASE 6: SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Up_Multiple
	    CASE 7: SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Down_Multiple
	}
    }
}
BUTTON_EVENT [vdvTp_Main, 1006] //Close
{
    PUSH:
    {
	SEND_COMMAND vdvTP_Main, "'@PPX'"
	TO [BUTTON.INPUT.CHANNEL]
    }
}
BUTTON_EVENT [vdvTP_MAIN, nLightsBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nLightingIdx
	
	nLightingIdx = GET_LAST (nLightsBtns)
	SWITCH (nLightingIdx)
	{
	    CASE 1 : SEND_STRING dvLights, "'~11h 12 ',ITOHEX(LIGHTS_OFF),CR"
	    CASE 2 : SEND_STRING dvLights, "'~11h 12 ',ITOHEX(LIGHTS_SCENE1),CR"
	    CASE 3 : SEND_STRING dvLights, "'~11h 12 ',ITOHEX(LIGHTS_SCENE2),CR"
	    CASE 4 : SEND_STRING dvLights, "'~11h 12 ',ITOHEX(LIGHTS_SCENE3),CR"
	    CASE 5 : SEND_STRING dvLights, "'~11h 12 ',ITOHEX(LIGHTS_SCENE4),CR"
	}
    }
    RELEASE :
    {
	WAIT 10 SEND_STRING dvLights, "'~11h 12 ',ITOHEX(LIGHTS_AREA),CR"
    }
}

DEFINE_EVENT
LEVEL_EVENT [dvAVOUTPUT2, PROGRAM_MIX]
{
    nProgram_Level = LEVEL.VALUE
    SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + 100),'%'"
    
    IF (nProgram_Level <= -100)
    {
	ON [nProgram_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
    }
    ELSE
    {
	OFF [nProgram_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + 100),'%'"
    }
}
LEVEL_EVENT [dvAVOUTPUT3, MICROPHONE_MIX_1]
{
    nMicrophone_Level = LEVEL.VALUE
    SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nMicrophone_Level + 100),'%'"
    
    IF (nMicrophone_Level <= -100)
    {
	ON [nMicrophone_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,Muted'"
    }
    ELSE
    {
	OFF [nMicrophone_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nMicrophone_Level + 100),'%'"
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_left,ON_LINE]
CHANNEL_EVENT [vdvProjector_left, WARMING] 
CHANNEL_EVENT [vdvProjector_left,COOLING] 
{
    ON:
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
    OFF:
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
CHANNEL_EVENT [vdvProjector_right,ON_LINE]
CHANNEL_EVENT [vdvProjector_right, WARMING] 
CHANNEL_EVENT [vdvProjector_right,COOLING] 
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	}
    }
    OFF:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvDvxSwitcher] //DVX SWitcher Online / Offline Events
{
    ONLINE:
    {
	WAIT 150
	{
	    CALL 'DVX INPUT SETUP'
	}
    }
    COMMAND:
    {
	LOCAL_VAR CHAR cAudio[4]
	LOCAL_VAR CHAR cLeftTmp[4]
	LOCAL_VAR CHAR cRightTmp[4]
	
	CHAR cMsg[20]
	cMsg = DATA.TEXT
	
	SELECT
	{
	    //Video Source Parsing...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LVIDEOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LVIDEOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_PROJECTOR_LEFT)",1))
		{
		    cLeftTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		
		    nSourceLeft = ATOI(cLeftTmp)
		}
    		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_PROJECTOR_RIGHT)",1))
		{
		    cRightTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		
		    nSourceRight = ATOI(cRightTmp)
		}
	    }
	    //Audio Feedback...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LAUDIOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LAUDIOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_AUDIO_MIX)",1))
		{
		    cAudio = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)	
		    nSourceAudio = ATOI(cAudio)
		}
	    }
	}
    }
}
DATA_EVENT [dvTp_Main] //TouchPanel Online
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'" 
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_RM),',0,',nRoomInfo"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp"
    }
}
DATA_EVENT [dvDxlink_left]
{
    ONLINE:
    {
	fnSetScale(dvDxlink_left)
	
	WAIT 150
	{
	    SEND_COMMAND dvDxlink_left, "'?VIDOUT_MUTE'"
	}
    }
    COMMAND:
    {
    	LOCAL_VAR CHAR cTmp[8]
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsg,'VIDOUT_MUTE-',1)):
	    {
	    	REMOVE_STRING (cMsg,'VIDOUT_MUTE-',1)
		cTmp = cMsg
		SWITCH (cTmp)
		{
		   CASE 'ENABLE' :
		   {
			ON [nMute_left]
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [nMute_left]
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvDxlink_right]
{
    ONLINE:
    {
	fnSetScale(dvDxlink_right)
	
	WAIT 170
	{
	    SEND_COMMAND dvDxlink_right, "'?VIDOUT_MUTE'"
	}
    }
    COMMAND:
    {
        LOCAL_VAR CHAR cTmp[8]
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsg,'VIDOUT_MUTE-',1)):
	    {
	    	REMOVE_STRING (cMsg,'VIDOUT_MUTE-',1)
		cTmp = cMsg
		SWITCH (cTmp)
		{
		   CASE 'ENABLE' :
		   {
			ON [nMute_right]
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [nMute_right]
		    }
		}
	    }
	}
    }
}
DATA_EVENT[dvLights]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE,"'SET BAUD 9600,N,8,1'"
	SEND_COMMAND DATA.DEVICE,"'HSOFF'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnReboot()
    // Left, Right and Audio Feedback
    [vdvTP_MAIN,11] = nSourceLeft = VIDEO_PC_MAIN
    [vdvTP_MAIN,12] = nSourceLeft = VIDEO_PC_EXTENDED
    [vdvTP_MAIN,13] = nSourceLeft = VIDEO_VGA
    [vdvTP_MAIN,14] = nSourceLeft = VIDEO_HDMI
    [vdvTP_MAIN,15] = nSourceLeft = VIDEO_DOC_CAM
    [vdvTP_MAIN,16] = nSourceLeft = VIDEO_DVD
    [vdvTP_MAIN,17] = nSourceLeft = VIDEO_TUNER
    
    [vdvTP_MAIN,111] = nSourceRight = VIDEO_PC_MAIN
    [vdvTP_MAIN,112] = nSourceRight = VIDEO_PC_EXTENDED
    [vdvTP_MAIN,113] = nSourceRight = VIDEO_VGA
    [vdvTP_MAIN,114] = nSourceRight = VIDEO_HDMI
    [vdvTP_MAIN,115] = nSourceRight = VIDEO_DOC_CAM
    [vdvTP_MAIN,116] = nSourceRight = VIDEO_DVD
    [vdvTP_MAIN,117] = nSourceRight = VIDEO_TUNER
    
    [vdvTP_MAIN,511] = nSourceAudio = VIDEO_PC_MAIN
    [vdvTP_MAIN,513] = nSourceAudio = VIDEO_VGA
    [vdvTP_MAIN,514] = nSourceAudio = VIDEO_HDMI
    [vdvTP_MAIN,517] = nSourceAudio = VIDEO_TUNER
                  
    [vdvTP_MAIN,301] = nProgram_Mute
    [vdvTP_MAIN,305] = nMicrophone_Mute
    
    [vdvTP_MAIN, 81] = nCurrentLightsScene = 1
    [vdvTP_MAIN, 82] = nCurrentLightsScene = 2
    [vdvTP_MAIN, 83] = nCurrentLightsScene = 3
    [vdvTP_MAIN, 84] = nCurrentLightsScene = 4
    [vdvTP_MAIN, 85] = nCurrentLightsScene = 5
    
    
    //Left Projector Feedback
    [vdvTP_MAIN,1]	= [vdvProjector_left,POWER]
    [vdvTP_MAIN,2]	= ![vdvProjector_left, POWER]
    [vdvTP_MAIN,3]	= nMute_left
    
    [vdvTP_MAIN, 601] = [vdvProjector_left, ON_LINE] //Online
    
    IF([vdvProjector_left,WARMING]) //If this is warming up
    {
	[vdvTP_MAIN, 602] = iFLASH
    }
    ELSE IF ([vdvProjector_left, COOLING]) //If this is Cooling
    {
	[vdvTP_MAIN, 603] = iFLASH
    }
    ELSE
    {
	[vdvTP_MAIN, 602] = [vdvProjector_left, WARMING]
	[vdvTP_MAIN, 603] = [vdvProjector_left, COOLING]
    }
    //Right Projector Feedback
    [vdvTP_MAIN,101] = [vdvProjector_right,POWER]
    [vdvTP_MAIN,102] = ![vdvProjector_right,POWER]
    [vdvTP_MAIN,103]	= nMute_right
    
    [vdvTP_MAIN, 611] = [vdvProjector_right, ON_LINE] //Online
    
    IF([vdvProjector_right,WARMING]) //If this is warming up
    {
	[vdvTP_MAIN, 612] = iFLASH
    }
    ELSE IF ([vdvProjector_right, COOLING]) //If this is Cooling
    {
	[vdvTP_MAIN, 613] = iFLASH
    }
    ELSE
    {
	[vdvTP_MAIN, 612] = [vdvProjector_right, WARMING]
	[vdvTP_MAIN, 613] = [vdvProjector_right, COOLING]
    }
    
    WAIT ONE_MINUTE
    {
	fnMuteCheck(dvDxlink_left)
	WAIT 10
	{
	    fnMuteCheck(dvDxlink_right)
	}
    }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

