PROGRAM_NAME='DVX3150'
(***********************************************************)
(*  FILE CREATED ON: 04/18/2012  AT: 17:49:32              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/16/2019  AT: 15:12:51        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Chris Robinson
    Standard DVX Code for DVX 3155
    

*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


dvMaster 		=		0:1:0	//DVX Master
dvTP_MAIN   	= 		10001:1:0

dvDvxSwitcher =			5002:1:0 //DVX Switcher

dvVIDEOIN_1   = 			5002:1:0 //PC Main
dvVIDEOIN_2  = 			5002:2:0 //PC Extended Desktop
dvVIDEOIN_3   = 			5002:3:0 //VGA Laptop
dvVIDEOIN_4   = 			5002:4:0 //DVI Laptop
dvVIDEOIN_5   = 			5002:5:0 //Document Camera
dvVIDEOIN_6   = 			5002:6:0 //BluRay
dvVIDEOIN_7  = 			5002:7:0 //Not used
dvVIDEOIN_8   = 			5002:8:0 //Not used
dvVIDEOIN_9  = 			5002:9:0 //Not used
dvVIDEOIN_10  = 		5002:10:0 //Not used

dvAVOUTPUT1 = 			5002:1:0 //DXLink + HDMI -- House Left
dvAVOUTPUT2 = 			5002:2:0 //HDMI - Send to DL Room
dvAVOUTPUT3 = 			5002:3:0 //DXLink + HDMI -- House Right (if Dual Proj)
dvAVOUTPUT4 = 			5002:4:0 //HDMI - Confidence Monitor

dvProgram =			5002:2:0 //Device for Proprogram Mixing!
dvMicrophone1 =			5002:1:0 //Device for Mic 1 Mixing
dvMicrophone2 =			5002:2:0 //Device for Mic 2 Mixing

dvRS232_1 =				5001:1:0	
dvRS232_2 =				5001:2:0 	
dvRS232_3 =				5001:3:0	
dvRS232_4	= 			5001:4:0	
dvRS232_5	= 			5001:5:0
dvRS232_6	= 			5001:6:0

dvRelays =				5001:8:0
dvIO =				5001:17:0 //IO's

vdvProjector_left =		35011:1:0  //
vdvProjector_right =		35012:1:0 // 


dvProjector_left 		=	6001:1:0 // Ties in Duet Module
dvProjector_dxLeft		=	6001:6:0	//DxLink Left -commands use Port 6

dvProjector_right		=	6002:1:0 // Ties in Duet Modules
dvProjector_dxRight		=	6002:6:0	//DxLink Right - connected to Right Projector


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Screens
screen_up_left				= 2
screen_down_left				= 1

screen_up_right				= 4
screen_down_right			= 3
screen_up_center			= 6
screen_down_center			= 5 

// Volume Adjustment Values
Volume_Up_Single			= 1
Volume_Up_Multiple			= 3
Volume_Down_Single			= -1
Volume_Down_Multiple			= -3

//DVX Video Channels
VIDEO_PC_MAIN 				= 1 
VIDEO_PC_EXT    			= 2 
VIDEO_VGA				= 3 
VIDEO_DOC_CAM				= 4 
VIDEO_HDMI				= 5 
VIDEO_MERSIVE				= 6 
VIDEO_TUNER				= 7 
VIDEO_DL_1				= 8 
VIDEO_DL_2				= 9 
VIDEO_DL_3				= 10 

//DVX Audio Channels
AUDIO_INPUT_11				= 11 //Input 11
AUDIO_INPUT_12				= 12 //Input 11
AUDIO_INPUT_13				= 13 //Input 11
AUDIO_INPUT_14				= 14 //Input 11

OUTPUT_VOLUME				= 1 //Output Volume Mixing
PROGRAM_MIX				= 41 //Program Mix
MICROPHONE_MIX_1			= 42
MICROPHONE_MIX_2			= 43
MAX_LEVEL_OUT				= 80 //Output Audio Level (0-100)

OUT_PROJECTOR_LEFT			= 1
OUT_PROJECTOR_RIGHT			= 3
OUT_AUDIO_MIX				= 2

//DXLink Calls...
SET_MUTE_ON				= 'ENABLE'
SET_MUTE_OFF				= 'DISABLE'
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
POWER_ON					= 27
POWER_OFF				= 28
WARMING					= 253
COOLING					= 254
ON_LINE					= 251
POWER					= 255
BLANK					= 211

//Times..
ONE_SECOND				= 10 
ONE_MINUTE				= 60*ONE_SECOND
ONE_HOUR					= 60*ONE_MINUTE

//Misc..
CR 						= 13
LF 						= 10

TXT_PRGM					= 31
TXT_MIC_1					= 32
TXT_MIC_2					= 33
TXT_HELP					= 99
TXT_RM					= 100
TXT_PHONE				= '404-894-4669'
TXT_LOCATION				= 'COB 436'

// Time Lines
TL_FLASH					= 2
TL_FEEDBACK 				= 1
TIME_REBOOT				= '06:00:00'
TIME_KILL					= '22:00:00'

// Buttons...
BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L				= 12
BTN_VGA_L					= 13
BTN_HDMI_L				= 14
BTN_DOCCAM_L				= 15
BTN_MERSIVE_L				= 16
BTN_SX80_L				= 17

BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R				= 112
BTN_VGA_R				= 113
BTN_HDMI_R				= 114
BTN_DOCCAM_R				= 115
BTN_MERSIVE_R				= 116
BTN_SX80_R				= 117

BTN_PRGM_MUTE				= 301
BTN_PRGM_UP				= 302
BTN_PRGM_DN				= 303
BTN_PRGM_PRESET			= 304

BTN_MIC_MUTE				= 305
BTN_MIC_UP				= 306
BTN_MIC_DN				= 307
BTN_MIC_PRESET				= 308

BTN_PWR_ON_L				= 1
BTN_PWR_OFF_L				= 2
BTN_MUTE_PROJ_L			= 3
BTN_SCREEN_UP_L			= 4
BTN_SCREEN_DN_L			= 5

BTN_PWR_ON_R				= 101
BTN_PWR_OFF_R				= 102
BTN_MUTE_PROJ_R			= 103
BTN_SCREEN_UP_R			= 104
BTN_SCREEN_DN_R			= 105

BTN_CLOSE_PG				= 1006

BTN_AUDIO_PC			= 511
BTN_AUDIO_VGA			= 513
BTN_AUDIO_HDMI			= 514
BTN_AUDIO_MERSIVE		= 516

BTN_ONLINE_L			= 601
BTN_ONLINE_R			= 611

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nSourceLeft
VOLATILE INTEGER nSourceRight
VOLATILE INTEGER nSourceAudio
VOLATILE INTEGER nBootup_

VOLATILE SINTEGER nProgram_Level
VOLATILE SINTEGER nProgram_Level_Preset = -40
VOLATILE SINTEGER nProgram_Hold

VOLATILE SINTEGER nMicrophone_Level
VOLATILE SINTEGER nMicrophone_Level_Preset = -40
VOLATILE SINTEGER nMicrophone_Hold

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000} 
VOLATILE INTEGER iFLASH 

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE INTEGER nVideoSources[] = 
{
    VIDEO_PC_MAIN, 
    VIDEO_PC_EXTENDED, 
    VIDEO_HDMI, 
    VIDEO_DOC_CAM,
    VIDEO_MERSIVE
}
VOLATILE INTEGER nVideoLeftBtns[] =
{
    BTN_PC_MAIN_L, 
    BTN_PC_EXT_L,
    BTN_HDMI_L,  
    BTN_DOCCAM_L, 
    BTN_MERSIVE_L
}
VOLATILE INTEGER nVideoRightBtns[] = 
{
    BTN_PC_MAIN_R, 
    BTN_PC_EXT_R,
    BTN_HDMI_R,  
    BTN_DOCCAM_R, 
    BTN_MERSIVE_R
}
VOLATILE INTEGER nAudioBtns[] = 
{
    BTN_PRGM_MUTE,
    BTN_PRGM_UP,
    BTN_PRGM_DN,
    BTN_PRGM_PRESET,
    
    BTN_MIC_MUTE,
    BTN_MIC_UP,
    BTN_MIC_DN,
    BTN_MIC_PRESET
}
VOLATILE INTEGER nAudioFBBtns[] =
{
    BTN_AUDIO_PC,			
    BTN_AUDIO_VGA,			
    BTN_AUDIO_HDMI,			
    BTN_AUDIO_MERSIVE
}   
VOLATILE CHAR nDvxInputNames[10][31] =
{
    'Not Used',
    'Not Used',
    'Mersive Pod',
    'Desktop',
    'Table Source',
    'Not Used',
    'Input 7',
    'Input 8',
    'Input 9',
    'Input 10'
}
VOLATILE DEV dcDVXVideoSlots[] =
{
    dvVIDEOIN_1,
    dvVIDEOIN_2,
    dvVIDEOIN_3,
    dvVIDEOIN_4,
    dvVIDEOIN_5,
    dvVIDEOIN_6,
    dvVIDEOIN_7,
    dvVIDEOIN_8,
    dvVIDEOIN_9,
    dvVIDEOIN_10
}
VOLATILE CHAR nDvxInputEDID[10][15] =
{ 
    '1920x1080,60',
    '1920x1080,60',
    '1920x1080,60',
    '1920x1080,60',
    '1920x1080p,60',
    '1280x720,60',
    '1280x720,60',
    '1280x720p,60',
    '1920x1080p,60',
    '1920x1080,60'
}

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvIO,nTimelineIO[1]]..[dvIO,nTimelineIO[8]])
([dvTP_Main, nVideoLeftBtns[1]]..[dvTP_Main, nVideoLeftBtns[5]])
([dvTP_Main, nVideoRightBtns[1]]..[dvTP_Main, nVideoRightBtns[5]])

([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_MERSIVE])

([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main, BTN_PWR_OFF_L])
([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main, BTN_PWR_OFF_R])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnLoadDVXVideoLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDVXVideoSlots); cLoop++)
    {
	SEND_COMMAND dcDVXVideoSlots[cLoop], "'VIDIN_NAME-',nDvxInputNames[cLoop]"

    }
}
DEFINE_FUNCTION fnLoadDVXEdids()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(nDvxInputEDID); cLoop++)
    {
	SEND_COMMAND dcDVXVideoSlots[cLoop], "'VIDIN_PREF_EDID-',nDvxInputEDID[cLoop]"
    }
}
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_LEFT)" 
    WAIT 20 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_RIGHT)"
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-AUDIO,',ITOA(AUDIO_OUT_MAIN)"
}
DEFINE_FUNCTION fnSetAudioLevels()
{
    WAIT 10 SEND_LEVEL dvProgram,OUTPUT_VOLUME,MAX_LEVEL_OUT
    WAIT 20 SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level_Preset
    WAIT 30 SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level_Preset
    WAIT 40 SEND_LEVEL dvMicrophone2,MICROPHONE_MIX_2,-100 //Turn Off to Front
    
    //Set Audio Out to Vaddio Bridge...
    WAIT 50 SEND_LEVEL dvAVOUTPUT3,OUTPUT_VOLUME,MAX_LEVEL_OUT
    WAIT 60 SEND_LEVEL dvAVOUTPUT3,PROGRAM_MIX,-100
    WAIT 70 SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_1,-15 
    WAIT 80 SEND_LEVEL dvAVOUTPUT3,MICROPHONE_MIX_2,-100
}
DEFINE_CALL 'DVX INPUT SETUP' //Setup Input Names...
{
    fnDVXPull()
    
    WAIT 50
    {
	fnSetAudioLevels()
    }
    WAIT 150
    {
	fnLoadDVXEdids()
    }
    //Turn on Network Traffic...
    WAIT 250
    {
	SEND_COMMAND dvVIDEOIN_9, "'DXLINK_IN_ETH-auto'"
	SEND_COMMAND dvVIDEOIN_10, "'DXLINK_IN_ETH-auto'"
	SEND_COMMAND dvAVOUTPUT1, "'DXLINK_ETH-auto'"
	SEND_COMMAND dvAVOUTPUT3, "'DXLINK_ETH-auto'"
    }
    WAIT 300
    {
	fnLoadDVXVideoLabels()
    }
}   
DEFINE_FUNCTION fnKill()
{
    IF (TIME = TIME_KILL)
    {
    	IF ([vdvProjector_Left, POWER] || [vdvProjector_Right, POWER])
	{
	    fnPowerDisplays (BTN_PWR_OFF_L)
		fnPowerDisplays (BTN_PWR_OFF_R)
	}
    }
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = TIME_REBOOT)
    {
	REBOOT (dvMaster)
    }
}
DEFINE_FUNCTION fnSCREEN(INTEGER nToggle) //Function Screen Up or Down
{
    PULSE [dvRelays, nToggle]
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
DEFINE_CALL 'PROGRAM MUTE'
{
    IF (![vdvTP_Main, BTN_PRGM_MUTE]) 
    {
	nProgram_Hold = nProgram_Level
	SEND_LEVEL dvProgram,PROGRAM_MIX,-100
    }
    ELSE IF (nProgram_Hold = 0)
    {
	SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level_Preset
    }
    ELSE
    {
	nProgram_Level = nProgram_Hold
	SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level
    }
}
DEFINE_CALL 'MICROPHONE MUTE'
{
	IF (![vdvTP_Main, BTN_MIC_MUTE])
	{
	    nMicrophone_Hold = nMicrophone_Level
	    SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,-100
	}
	ELSE IF (nMicrophone_Hold = 0)
	{
	    SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level_Preset
	}
	ELSE
	{
	    nMicrophone_Level = nMicrophone_Hold
	    SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level
	}
}
DEFINE_FUNCTION fnRouteVideoLeft(INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_LEFT)" 
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_VGA :
	CASE VIDEO_HDMI :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
    }
}
DEFINE_FUNCTION fnRouteVideoRight(INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_RIGHT)" 
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_VGA :
	CASE VIDEO_HDMI :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
    }
}
DEFINE_FUNCTION fnPowerDisplays(INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    PULSE [vdvProjector_left, POWER_ON] 
		fnSCREEN (SCREEN_LEFT_DN)
	}
	CASE BTN_PWR_OFF_L :
	{
	    PULSE [vdvProjector_left, POWER_OFF]
	    WAIT 30
	    {
		fnSCREEN (SCREEN_LEFT_UP)
	    }
	}
	CASE BTN_PWR_ON_R :
	{
	    PULSE [vdvProjector_right, POWER_ON]
	    fnSCREEN (SCREEN_RIGHT_DN)
	}
	CASE BTN_PWR_OFF_R :
	{
	    PULSE [vdvProjector_right, POWER_OFF]
	    WAIT 30
	    {
		fnSCREEN (SCREEN_RIGHT_UP)
	    }
	}
    }
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
DEFINE_FUNCTION fnToggleChannels()
{
    ON [vdvProjector_Left, POWER]
	ON [vdvProjector_Right, POWER]
	
	    OFF [vdvProjector_Left, ON_LINE]
	OFF [vdvProjector_Right, ON_LINE]

}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [nBootup_]
WAIT 250
{
    TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,LENGTH_ARRAY(lTLFeedback),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    //TIMELINE_CREATE (TL_FLASH,lTLFlash,LENGTH_ARRAY(lTLFlash),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    
    fnToggleChannels()
}
WAIT ONE_MINUTE
{
    OFF [nBootup_]
}
(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

//DEFINE_MODULE 'Sony_FHZ65' ProjLeft(vdvProjector_left, dvProjector_left);
//DEFINE_MODULE 'Sony_FHZ65' ProjRight(vdvProjector_right, dvProjector_right);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_L]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_L]
BUTTON_EVENT [vdvTP_Main, BTN_MUTE_PROJ_L] //Left Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L : fnPowerDisplays(BTN_PWR_ON_L)
	    CASE BTN_PWR_OFF_L : fnPowerDisplays(BTN_PWR_OFF_L)
	    
	    CASE BTN_MUTE_PROJ_L :
	    {
		IF (![vdvTP_Main, BTN_MUTE_PROJ_L])
		{
		    fnMuteProjector(dvProjector_dxLeft, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvProjector_dxLeft, SET_MUTE_OFF)
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_R]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_R]
BUTTON_EVENT [vdvTP_Main, BTN_MUTE_PROJ_R] //Right Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R : fnPowerDisplays(BTN_PWR_ON_R)
	    CASE BTN_PWR_OFF_R : fnPowerDisplays(BTN_PWR_OFF_R)
	    
	    CASE BTN_MUTE_PROJ_R :
	    {
		IF (![vdvTP_Main, BTN_MUTE_PROJ_R])
		{
		    fnMuteProjector(dvProjector_dxRight, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvProjector_dxRight, SET_MUTE_OFF)
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nProjectorLeftVidBtns]
{
    PUSH :
    {
	fnRouteVideoLeft(nVideoSources[GET_LAST(nProjectorLeftVidBtns)])
    }
}
BUTTON_EVENT [vdvTP_Main, nProjectorRightVidBtns]
{
    PUSH :
    {
	fnRouteVideoRight(nVideoSources[GET_LAST(nProjectorRightVidBtns)])
    }
}
BUTTON_EVENT [vdvTp_Main, nAudioBtns] //Audio Controls for Classroom!
{
    PUSH:
    {
	    STACK_VAR INTEGER nVolumeIdx
	    
	    nVolumeIdx = GET_LAST (nAudioBtns)
	    SWITCH (nVolumeIdx)
	    {
		CASE 1: CALL 'PROGRAM MUTE'
		CASE 2: SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level + Volume_Up_Single
		CASE 3: SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level + Volume_Down_Single
		CASE 4: SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level_Preset
		
		CASE 5: CALL 'MICROPHONE MUTE'
		CASE 6: SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Up_Single
		CASE 7: SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Down_Single
		CASE 8: SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level_Preset
	    }
    }
    HOLD [2,REPEAT]: //If you hold the Volume Change Buttons
    {
	STACK_VAR INTEGER nVolumeIdx
	
	nVolumeIdx = GET_LAST (nAudioBtns)
	SWITCH (nVolumeIdx)
	{
	    CASE 2: SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level + Volume_Up_Multiple
	    CASE 3: SEND_LEVEL dvProgram,PROGRAM_MIX,nProgram_Level + Volume_Down_Multiple
	    CASE 6: SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Up_Multiple
	    CASE 7: SEND_LEVEL dvMicrophone1,MICROPHONE_MIX_1,nMicrophone_Level + Volume_Down_Multiple
	}
    }
}
BUTTON_EVENT [vdvTp_Main, BTN_CLOSE_PG]
{
    PUSH:
    {
	SEND_COMMAND vdvTP_Main, "'@PPX'"
	TO [BUTTON.INPUT.CHANNEL]
    }
}

DEFINE_EVENT
LEVEL_EVENT [dvProgram, PROGRAM_MIX]
{
    nProgram_Level = LEVEL.VALUE
    SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + 100),'%'"
    
    IF (nProgram_Level <= -100)
    {
	ON [vdvTP_Main, BTN_PRGM_MUTE]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
    }
    ELSE
    {
	OFF [vdvTP_Main, BTN_PRGM_MUTE]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + 100),'%'"
    }
}
LEVEL_EVENT [dvMicrophone1, MICROPHONE_MIX_1]
{
    nMicrophone_Level = LEVEL.VALUE
    SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nMicrophone_Level + 100),'%'"
    
    IF (nMicrophone_Level <= -100)
    {
	ON [vdvTP_Main, BTN_MIC_MUTE]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,Muted'"
    }
    ELSE
    {
	OFF [vdvTP_Main, BTN_MIC_MUTE]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nMicrophone_Level + 100),'%'"
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_left, ON_LINE]
CHANNEL_EVENT [vdvProjector_left, WARMING] 
CHANNEL_EVENT [vdvProjector_left, COOLING] 
CHANNEL_EVENT [vdvProjector_left, POWER] 
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
		ON [vdvTP_Main, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_L]
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
		OFF [vdvTP_Main, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_L]
	    }
	}
    }
}
CHANNEL_EVENT [vdvProjector_right,ON_LINE]
CHANNEL_EVENT [vdvProjector_right, WARMING] 
CHANNEL_EVENT [vdvProjector_right,COOLING] 
CHANNEL_EVENT [vdvProjector_Right, POWER]
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
		ON [vdvTP_Main, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_R]
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
		OFF [vdvTP_Main, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	    	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_R]
	    }
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvDvxSwitcher] //DVX SWitcher Online / Offline Events
{
    ONLINE:
    {
	WAIT 80
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
		    
		    SWITCH (nSourceLeft)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_MAIN, BTN_PC_MAIN_L]
			CASE VIDEO_PC_EXTENDED : ON [vdvTP_MAIN, BTN_PC_EXT_L]
			CASE VIDEO_VGA : ON [vdvTP_MAIN, BTN_VGA_L]
			CASE VIDEO_DOC_CAM : ON [vdvTP_MAIN, BTN_DOCCAM_L]
			CASE VIDEO_HDMI : ON [vdvTP_MAIN, BTN_HDMI_L]
		    }
		}
    		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_PROJECTOR_RIGHT)",1))
		{
		    cRightTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    nSourceRight = ATOI(cRightTmp)
		    
		    SWITCH (nSourceRight)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_MAIN, BTN_PC_MAIN_R]
			CASE VIDEO_PC_EXTENDED : ON [vdvTP_MAIN, BTN_PC_EXT_R]
			CASE VIDEO_VGA : ON [vdvTP_MAIN, BTN_VGA_R]
			CASE VIDEO_DOC_CAM : ON [vdvTP_MAIN, BTN_DOCCAM_R]
			CASE VIDEO_HDMI : ON [vdvTP_MAIN, BTN_HDMI_R]
		    }
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
		    
		    SWITCH (nSourceAudio)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_AUDIO_PC]
			CASE VIDEO_VGA : ON [vdvTP_Main, BTN_AUDIO_VGA]
			CASE VIDEO_HDMI : ON [vdvTP_Main, BTN_AUDIO_HDMI]
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvTp_Main] //TouchPanel Online
{
    ONLINE:
    {
	SEND_COMMAND data.device, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',MY_ROOM"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',MY_HELP_PHONE"
	
	IF (!nBootup_)
	{
	    fnToggleChannels()
	    fnDVXPull()
	}
    }
}
DATA_EVENT [dvDxlink_left]
{
    ONLINE:
    {
	WAIT 80 fnSetScale(dvProjector_dxLeft)
	WAIT 120 SEND_COMMAND dvProjector_dxLeft, "'?VIDOUT_MUTE'"
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
			ON [vdvTP_Main, BTN_MUTE_PROJ_L]
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [vdvTP_Main, BTN_MUTE_PROJ_L]
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
	WAIT 80 fnSetScale(dvProjector_dxRight)
	WAIT 120 SEND_COMMAND dvProjector_dxRight, "'?VIDOUT_MUTE'"
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
			ON [vdvTP_Main, BTN_MUTE_PROJ_R]
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [vdvTP_Main, BTN_MUTE_PROJ_R]
		    }
		}
	    }
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFlash = !iFLASH
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnKill()
    fnReboot()
    
    IF([vdvProjector_left,WARMING])
    {
	[dvTP_MAIN, 602] = iFLASH
    }
    ELSE IF ([vdvProjector_left, COOLING]) 
    {
	[dvTP_MAIN, 603] = iFLASH
    }
    ELSE
    {
	[dvTP_MAIN, 602] = [vdvProjector_left, WARMING]
	[dvTP_MAIN, 603] = [vdvProjector_left, COOLING]
    }

    
    IF([vdvProjector_right,WARMING]) 
    {
	[dvTP_MAIN, 612] = iFLASH
    }
    ELSE IF ([vdvProjector_right, COOLING]) 
    {
	[dvTP_MAIN, 613] = iFLASH
    }
    ELSE
    {
	[dvTP_MAIN, 612] = [vdvProjector_right, WARMING]
	[dvTP_MAIN, 613] = [vdvProjector_right, COOLING]
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

