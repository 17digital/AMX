PROGRAM_NAME='Master'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/11/2020  AT: 23:15:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
       
    
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

DGX_CONN =			1 //System

dvMaster =				0:1:0 //NX 4200
dvDGX =				5002:1:DGX_CONN
dvTP_Main =			10001:1:0 //MST -701i

dvRS232_1 =			5001:1:0 //Contemporary Research Tuner
dvRS232_2 =			5001:2:0 //Biamp Tesira (Leave Default Baud Rate @ 115200
dvRS232_3 =			5001:3:0 //Extron SMP
dvRS232_4 =			5001:4:0 //Ceiling Camera
dvRS232_5 =			5001:5:0 //Vaddio Rear Camera
dvRS232_6 =			5001:6:0 //
dvRS232_7 =			5001:7:0 //
dvRS232_8 =			5001:8:0 //

dvIR_1 =				5001:11:0
dvIR_2 =				5001:12:0
dvIR_3 =				5001:13:0
dvIR_4 =				5001:14:0
dvIR_5 =				5001:15:0
dvIR_6 =				5001:16:0
dvIR_7 =				5001:17:0
dvIR_8 =				5001:18:0
 
dvRelays =				5001:21:0 //
dvIOs =					5001:22:0 //+

dvVIDEOIN_1   = 			5002:1:DGX_CONN 
dvVIDEOIN_2   = 			5002:2:DGX_CONN 
dvVIDEOIN_3   = 			5002:3:DGX_CONN 
dvVIDEOIN_4   = 			5002:4:DGX_CONN 
dvVIDEOIN_5   = 			5002:5:DGX_CONN 
dvVIDEOIN_6  = 			5002:6:DGX_CONN 
dvVIDEOIN_7  = 			5002:7:DGX_CONN 
dvVIDEOIN_8  = 			5002:8:DGX_CONN 
dvVIDEOIN_9   = 			5002:9:DGX_CONN 
dvVIDEOIN_10  = 		5002:10:DGX_CONN 
dvVIDEOIN_11 =			5002:11:DGX_CONN 
dvVIDEOIN_12 =				5002:12:DGX_CONN 
dvVIDEOIN_13 =				5002:13:DGX_CONN 
dvVIDEOIN_14 =				5002:14:DGX_CONN 
dvVIDEOIN_15 =				5002:15:DGX_CONN 
dvVIDEOIN_16 =				5002:16:DGX_CONN 

dvAUDIOOUT =				5002:16:DGX_CONN //

dvProjector_Left =			46001:1:DGX_CONN
dvProjector_dxLeft =			46001:6:DGX_CONN

dvProjector_Right =			46002:1:DGX_CONN
dvProjector_dxRight =			46002:6:DGX_CONN

dvDisplay_Left =				46003:1:DGX_CONN //Sony FW85BZ
dvDisplay_dxLeft =			46003:6:DGX_CONN

dvDisplay_Right =				46004:1:DGX_CONN //Sony FW85BZ
dvDisplay_dxRight =				46004:6:DGX_CONN

vdvProjector_Left =			35011:1:0
vdvProjector_Right =			35012:1:0
vdvDisplay_Left =			35013:1:0
vdvDisplay_Right =			35014:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

MY_ROOM				= 'Howey L1'
MY_HELP_PHONE			= '404-894-4669'

//DGX Input Labels....
INPUT_NAME_1			= 'PC Main'
INPUT_NAME_2			= 'PC Extended'
INPUT_NAME_3			= 'Doc Camera'
INPUT_NAME_4			= 'External Lectern'

INPUT_NAME_5			= 'Mersive'
INPUT_NAME_6			= 'TV Tuner'
INPUT_NAME_7			= 'Ceiling Camera'
INPUT_NAME_8			= 'Rear Camera'

INPUT_NAME_9			= 'Board Camera 1'
INPUT_NAME_10			= 'Board Camera 2'
INPUT_NAME_11			= 'Board Camera 3'
INPUT_NAME_12			= 'Board Camera 4'

INPUT_NAME_13			= 'Not Used'
INPUT_NAME_14			= 'Not Used'
INPUT_NAME_15			= 'Not Used'
INPUT_NAME_16			= 'Not Used'
//DGX Output Labels...
OUTPUT_NAME_1			= 'Projector Left'
OUTPUT_NAME_2			= 'Projector Right'
OUTPUT_NAME_3			= 'Display Left' 
OUTPUT_NAME_4			= 'Display Right'

OUTPUT_NAME_5			= 'Lectern Left'
OUTPUT_NAME_6			= 'Lectern Right'
OUTPUT_NAME_7			= 'Not Used'
OUTPUT_NAME_8			= 'Not Used'

OUTPUT_NAME_9			= 'Camera SMP'
OUTPUT_NAME_10		= 'Content SMP'
OUTPUT_NAME_11		= 'Camera AVB'
OUTPUT_NAME_12		= 'Not Used'
                     
OUTPUT_NAME_13		= 'Not Used'
OUTPUT_NAME_14		= 'Not Used'
OUTPUT_NAME_15		= 'Not Used'
OUTPUT_NAME_16		= 'Not Used'

//DGX Input Channels
VIDEO_EXTERNAL			= 4 //Podium
VIDEO_PC_MAIN 			= 1 //
VIDEO_PC_EXT			= 2
VIDEO_DOC_CAM			= 3
VIDEO_MERSIVE			= 5
VIDEO_TV_TUNER		= 6
VIDEO_CAMERA_CEILING	= 7
VIDEO_CAMERA_REAR		= 8
VIDEO_CAM_BOARD_1		= 9
VIDEO_CAM_BOARD_2		= 10
VIDEO_CAM_BOARD_3		= 11
VIDEO_CAM_BOARD_4		= 12
VIDEO_REC_PREVIEW		= 13 //ExtronSMP

OUT_LECTERN_MON_LEFT	= 5
OUT_LECTERN_MON_RIGHT	= 6
OUT_PROJECTOR_LEFT		= 1
OUT_PROJECTOR_RIGHT	= 2
OUT_DISPLAY_LEFT		= 3
OUT_DISPLAY_RIGHT		= 4
OUT_AVB				= 11
OUT_SMP_CAMERA		= 9
OUT_SMP_CONTENT		= 10

OUT_AMP_MAIN			= 17

//More DGX Stuff...
//Preferred EDIDs...
EDID_PC					= '1920x1080,60'
EDID_MERSIVE				= '1920x1080,60'
EDID_CAMERA				= '1920x1080,60'
EDID_TUNER				= '1920x1080i,60'

//Set DxLinks...
//Uncomment the Desired Scaling...
//#DEFINE AUTO
#DEFINE MANUAL 
//#DEFINE BYPASS

#IF_DEFINED AUTO
SET_SCALE					= 'AUTO'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
#END_IF

#IF_DEFINED MANUAL
SET_RESOLUTION			= '1920x1080,60'
SET_SCALE					= 'MANUAL'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
#END_IF

#IF_DEFINED BYPASS
SET_SCALE					= 'BYPASS'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF


//Common Netlinx Feedback...
POWER_CYCLE				= 9
POWER_ON					= 27
POWER_OFF				= 28
WARMING					= 253
COOLING					= 254
ON_LINE					= 251
DATA_INIT					= 252 
POWER					= 255
BLANK					= 211
VOLUME_UP				= 24
VOLUME_DN 				= 25
VOLUME_MUTE				= 26

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100

//Misc
CR 						= 13
LF						= 10
TL_FEEDBACK				= 1
TL_FLASH					= 2
MAX_LENGTH 				= 10
SET_MUTE_ON				= 'ENABLE'
SET_MUTE_OFF				= 'DISABLE'

ONE_SECOND				= 10 
TEN_SECONDS				= 10 * ONE_SECOND
ONE_MINUTE				= 60 * ONE_SECOND
ONE_HOUR					= 60 * ONE_MINUTE

TIME_REBOOT				= '06:00:00'
TIME_KILL					= '22:00:00'

//Buttons...
BTN_PWR_ON_L				= 1
BTN_PWR_OFF_L				= 2
BTN_MUTE_PROJ_L			= 3

BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L				= 12
BTN_EXTERNAL_L				= 13
BTN_DOC_CAM_L				= 14
BTN_MERSIVE_L				= 15
BTN_TUNER_L				= 16
BTN_CAMERA_CEILING_L		= 17
BTN_BOARD_1_L				= 18
BTN_BOARD_2_L				= 19
BTN_BOARD_3_L				= 20
BTN_BOARD_4_L				= 21

BTN_PWR_ON_R				= 101
BTN_PWR_OFF_R				= 102
BTN_MUTE_PROJ_R			= 103

BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R				= 112
BTN_EXTERNAL_R				= 113
BTN_DOC_CAM_R				= 114
BTN_MERSIVE_R				= 115
BTN_TUNER_R				= 116
BTN_CAMERA_CEILING_R		= 117
BTN_BOARD_1_R				= 118
BTN_BOARD_2_R				= 119
BTN_BOARD_3_R				= 120
BTN_BOARD_4_R				= 121

BTN_PREVIEW_EXT			= 122
BTN_PREVIEW_REC			= 123

BTN_AUDIO_PC				= 511
BTN_AUDIO_LECTERN			= 513
BTN_AUDIO_MERSIVE			= 515
BTN_AUDIO_TUNER			= 516


BTN_ONLINE_L				= 601
BTN_WARMING_L				= 602
BTN_COOLING_L				= 603

BTN_ONLINE_R				= 611
BTN_WARMING_R				= 612
BTN_COOLING_R				= 613



(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE INTEGER iFlash
VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000}

VOLATILE INTEGER nSourceLeft
VOLATILE INTEGER nSourceRight
VOLATILE INTEGER nSourceAudio
VOLATILE INTEGER nTPOnline

VOLATILE INTEGER nVideoSources[] = 
{
    VIDEO_PC_MAIN,
    VIDEO_PC_EXT,
    VIDEO_EXTERNAL,
    VIDEO_DOC_CAM,
    VIDEO_MERSIVE,
    VIDEO_TV_TUNER,
    VIDEO_CAMERA_CEILING,
    VIDEO_CAM_BOARD_1,
    VIDEO_CAM_BOARD_2,
    VIDEO_CAM_BOARD_3,
    VIDEO_CAM_BOARD_4
}
VOLATILE INTEGER nProjectorLeftVidBtns[] = 
{
    BTN_PC_MAIN_L,
    BTN_PC_EXT_L,
    BTN_EXTERNAL_L,
    BTN_DOC_CAM_L,
    BTN_MERSIVE_L,
    BTN_TUNER_L,
    BTN_CAMERA_CEILING_L,
    BTN_BOARD_1_L,
    BTN_BOARD_2_L,
    BTN_BOARD_3_L,
    BTN_BOARD_4_L
}
VOLATILE INTEGER nProjectorRightVidBtns[] = 
{
    BTN_PC_MAIN_R,
    BTN_PC_EXT_R,
    BTN_EXTERNAL_R,
    BTN_DOC_CAM_R,
    BTN_MERSIVE_R,
    BTN_TUNER_R,
    BTN_CAMERA_CEILING_R,
    BTN_BOARD_1_R,
    BTN_BOARD_2_R,
    BTN_BOARD_3_R,
    BTN_BOARD_4_R
}

#INCLUDE 'ExtronSMP'
#INCLUDE 'VaddioCamera'
#INCLUDE 'Tesira'
#INCLUDE 'TVTuner_'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main, BTN_PWR_OFF_L])
([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_BOARD_4_L])

([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main, BTN_PWR_OFF_R])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_BOARD_4_R])

([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_TUNER])
([dvTP_Main, BTN_PREVIEW_EXT],[dvTP_Main, BTN_PREVIEW_REC])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnDGXPull()
{
    WAIT 10 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_LECTERN_MON_LEFT)" 
    WAIT 20 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_LECTERN_MON_RIGHT)"
    WAIT 30 SEND_COMMAND dvDGX, "'?INPUT-AUDIO,',ITOA(OUT_AMP_MAIN)" 
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = TIME_KILL )
    {
	fnPowerDisplays('LEFTOFF')
	fnPowerDisplays('RIGHTOFF')
    }
}
DEFINE_FUNCTION fnPowerDisplays(CHAR cPWR[MAX_LENGTH])
{
    SWITCH (cPWR)
    {
	CASE 'LEFTON':
	{
	    PULSE [vdvProjector_Left, POWER_ON] 
	    WAIT ONE_SECOND
	    {
		PULSE [vdvDisplay_Left, POWER_ON]
	    }
	}
	CASE 'LEFTOFF':
	{
	    PULSE [vdvProjector_Left, POWER_OFF]
	    WAIT ONE_SECOND
	    {
		PULSE [vdvDisplay_Left, POWER_OFF]
	    }
	}
	CASE 'RIGHTON':
	{
	    PULSE [vdvProjector_Right, POWER_ON] 
	    WAIT ONE_SECOND
	    {
		PULSE [vdvDisplay_Right, POWER_ON]
	    }
	}
	CASE 'RIGHTOFF':
	{
	    PULSE [vdvProjector_Right, POWER_OFF]
	    WAIT ONE_SECOND
	    {
		PULSE [vdvDisplay_Right, POWER_OFF]
	    }
	}
    }
}
DEFINE_CALL 'DGX INPUT SETUP' //Setup...
{
    fnDGXPull()
    
    WAIT 60
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
    }
    
    WAIT 90
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
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = TIME_REBOOT)
    {
    
	REBOOT (dvMaster)
    }
}
DEFINE_FUNCTION fnRouteVideoLeft (INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_LEFT),',',ITOA(OUT_DISPLAY_LEFT),',',ITOA(OUT_LECTERN_MON_LEFT),',',ITOA(OUT_SMP_CONTENT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(OUT_AMP_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	CASE VIDEO_TV_TUNER :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(OUT_AMP_MAIN)"
	}
    }
}
DEFINE_FUNCTION fnRouteVideoRight (INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_RIGHT),',',ITOA(OUT_DISPLAY_RIGHT),',',ITOA(OUT_LECTERN_MON_RIGHT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(OUT_AMP_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	CASE VIDEO_TV_TUNER :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(OUT_AMP_MAIN)"
	}
    }
}
DEFINE_FUNCTION fnRouteVideoPreview(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_LECTERN_MON_RIGHT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_EXT :
	{
	    ON [vdvTP_Main, BTN_PREVIEW_EXT]
	}
	CASE VIDEO_REC_PREVIEW :
	{
	    ON [vdvTP_Main, BTN_PREVIEW_REC]
	}
    }
}
DEFINE_FUNCTION fnSetRXScale(DEV cDevice)
{
    WAIT 50
    {
    
    	#IF_DEFINED AUTO 
	SEND_COMMAND cDevice, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND cDevice, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	#IF_DEFINED MANUAL
	SEND_COMMAND cDevice, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND cDevice, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
		WAIT 20
		{
		    SEND_COMMAND cDevice, "'VIDOUT_RES_REF-',SET_RESOLUTION" 
		}
	#END_IF
	
	#IF_DEFINED BYPASS
	SEND_COMMAND cDevice, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND cDevice, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
    }
}
DEFINE_FUNCTION fnMuteProjector(DEV cDevice, CHAR cToggle[])
{
    SEND_COMMAND cDevice, "'VIDOUT_MUTE-',cToggle"
    WAIT 5
    {
	SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
    }
}
DEFINE_FUNCTION fnMuteCheck(DEV cDevice)
{
    SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

DEFINE_MODULE 'Sony_FHZ700L' PROJMODLEFT(vdvProjector_Left, dvProjector_Left);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODRIGHT(vdvProjector_Right, dvProjector_Right);

DEFINE_MODULE 'Sony_FWD65x750D' DISPLAYMODLEFT(vdvDisplay_Left, dvDisplay_Left);
DEFINE_MODULE 'Sony_FWD65x750D' DISPLAYMODRIGHT(vdvDisplay_Right, dvDisplay_Right);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTp_Main, BTN_PWR_ON_L] 
BUTTON_EVENT [vdvTp_Main, BTN_PWR_OFF_L]
BUTTON_EVENT [vdvTp_Main, BTN_MUTE_PROJ_L] //Left Pwr Controls...
{
    PUSH:
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L: fnPowerDisplays('LEFTON')
	    CASE BTN_PWR_OFF_L: fnPowerDisplays('LEFTOFF')
	    
	    CASE BTN_MUTE_PROJ_L: 
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
BUTTON_EVENT [vdvTp_Main, BTN_PWR_ON_R] 
BUTTON_EVENT [vdvTp_Main, BTN_PWR_OFF_R]
BUTTON_EVENT [vdvTp_Main, BTN_MUTE_PROJ_R] //Right Pwr Controls...
{
    PUSH:
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R: fnPowerDisplays('RIGHTON')
	    CASE BTN_PWR_OFF_R: fnPowerDisplays('RIGHTOFF')
	    
	    CASE BTN_MUTE_PROJ_R: 
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
BUTTON_EVENT [vdvTp_Main,nProjectorLeftVidBtns] //Left Routing
{
    PUSH:
    {
	fnRouteVideoLeft(nVideoSources[GET_LAST(nProjectorLeftVidBtns)])
    }
}
BUTTON_EVENT [vdvTp_Main,nProjectorRightVidBtns] //Right Routing
{
    PUSH:
    {
	fnRouteVideoRight(nVideoSources[GET_LAST(nProjectorRightVidBtns)])
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PREVIEW_EXT]
BUTTON_EVENT [vdvTP_Main, BTN_PREVIEW_REC] //Routing Preview
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PREVIEW_EXT :
	    {
		fnRouteVideoPreview(VIDEO_PC_EXT)
	    }
	    CASE BTN_PREVIEW_REC :
	    {
		fnRouteVideoPreview(VIDEO_REC_PREVIEW)
	    }
	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_left, ON_LINE]
CHANNEL_EVENT [vdvProjector_left, WARMING] 
CHANNEL_EVENT [vdvProjector_left, COOLING] 
CHANNEL_EVENT [vdvProjector_Left, POWER]
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
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
		[vdvTP_Main, BTN_WARMING_L] = iFlash
	    }
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
		[vdvTP_Main, BTN_COOLING_L] = iFlash
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_L]
		    PULSE [vdvDisplay_Left, POWER_ON]
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
		OFF [vdvTP_Main, BTN_WARMING_L]
		OFF [vdvTP_Main, BTN_COOLING_L]
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_L]
		PULSE [vdvDisplay_Left, POWER_OFF]
	    }
	}
    }
}
CHANNEL_EVENT [vdvProjector_Right,ON_LINE]
CHANNEL_EVENT [vdvProjector_Right, WARMING] 
CHANNEL_EVENT [vdvProjector_Right,COOLING] 
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
		    PULSE [vdvDisplay_Right, POWER_ON]
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
		    PULSE [vdvDisplay_Right, POWER_OFF]
	    }
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',MY_ROOM"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',MY_HELP_PHONE"
    }
    OFFLINE :
    {
	OFF [nTPOnline]
    }
}
DATA_EVENT [dvDGX]
{
    ONLINE :
    {
	WAIT 80
	{
	    CALL 'DGX INPUT SETUP'
	}
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cAudioIn[4]
	LOCAL_VAR CHAR cLeftTmp[4]
	LOCAL_VAR CHAR cRightTmp[4]
	
	CHAR cMsg[20]
	cMsg = DATA.TEXT
	
	SELECT
	{
	    ACTIVE (FIND_STRING(cMsg,"'SWITCH-LVIDEOI'",1)):
	    {
		REMOVE_STRING (cMsg,"'SWITCH-LVIDEOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_LECTERN_MON_LEFT)",1))
		{
		    cLeftTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    nSourceLeft = ATOI(cLeftTmp)
		    
		    SWITCH (nSourceLeft)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_L]
			CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_L]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_L]
			CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_L]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_L]
			CASE VIDEO_TV_TUNER : ON [vdvTP_Main, BTN_TUNER_L]
			CASE VIDEO_CAMERA_CEILING : ON [vdvTP_Main, BTN_CAMERA_CEILING_L]
			CASE VIDEO_CAM_BOARD_1 : ON [vdvTP_Main, BTN_BOARD_1_L]
			CASE VIDEO_CAM_BOARD_2 : ON [vdvTP_Main, BTN_BOARD_2_L]
			CASE VIDEO_CAM_BOARD_3 : ON [vdvTP_Main, BTN_BOARD_3_L]
			CASE VIDEO_CAM_BOARD_4 : ON [vdvTP_Main, BTN_BOARD_4_L]
		    }
		}
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_LECTERN_MON_RIGHT)",1))
		{
		    cRightTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    nSourceRight = ATOI(cRightTmp)
		    
		    SWITCH (nSourceRight)
		    {
    			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_R]
			CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_R]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_R]
			CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_R]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_R]
			CASE VIDEO_TV_TUNER : ON [vdvTP_Main, BTN_TUNER_R]
			CASE VIDEO_CAMERA_CEILING : ON [vdvTP_Main, BTN_CAMERA_CEILING_R]
			CASE VIDEO_CAM_BOARD_1 : ON [vdvTP_Main, BTN_BOARD_1_R]
			CASE VIDEO_CAM_BOARD_2 : ON [vdvTP_Main, BTN_BOARD_2_R]
			CASE VIDEO_CAM_BOARD_3 : ON [vdvTP_Main, BTN_BOARD_3_R]
			CASE VIDEO_CAM_BOARD_4 : ON [vdvTP_Main, BTN_BOARD_4_R]
		    }
		}
	    }
	    ACTIVE (FIND_STRING(cMsg,"'SWITCH-LAUDIOI'",1)):
	    {
		REMOVE_STRING (cMsg,"'SWITCH-LAUDIOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_AMP_MAIN)",1))
		{
		    cAudioIn = LEFT_STRING (cMsg,LENGTH_STRING(cMsg)-3)
		    nSourceAudio = ATOI(cAudioIn)
		    
		    SWITCH (nSourceAudio)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_AUDIO_PC]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_AUDIO_LECTERN]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_AUDIO_MERSIVE] 
			CASE VIDEO_TV_TUNER : ON [vdvTP_Main, BTN_AUDIO_TUNER] 
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxLeft]
{
    ONLINE:
    {
	fnSetRXScale(dvProjector_dxLeft)
	
	WAIT 250
	{
	    fnMuteCheck(dvProjector_dxLeft)
	}
    }
    COMMAND :
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
			    fnMuteProjector(dvDisplay_dxLeft, SET_MUTE_ON)
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [vdvTP_Main, BTN_MUTE_PROJ_L]
			    fnMuteProjector (dvDisplay_dxLeft, SET_MUTE_OFF)
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxRight]
{
    ONLINE:
    {
	fnSetRXScale(dvProjector_dxRight)
	
	WAIT 250
	{
	    fnMuteCheck(dvProjector_dxRight)
	}
    }
    COMMAND :
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
			    fnMuteProjector(dvDisplay_dxRight, SET_MUTE_ON)
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [vdvTP_Main, BTN_MUTE_PROJ_R]
			    fnMuteProjector (dvDisplay_dxRight, SET_MUTE_OFF)
		    }
		}
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
    fnReboot()
    fnKill()
    
    WAIT ONE_MINUTE
    {
	fnMuteCheck(dvProjector_dxLeft)
	WAIT ONE_SECOND
	{
	    fnMuteCheck(dvProjector_dxRight)
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



