PROGRAM_NAME='Master103'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/26/2020  AT: 13:37:52        *)
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

DGX_CONN =			163 //System

dvMaster =			0:1:0 //NX 4200
dvDebug =			0:0:0 //Send to Diag...
dvDGX =				5002:1:DGX_CONN
dvTP_Main =			10001:1:0 //MST -701i

dvRS232_1 =			5001:1:0 //Vaddio 1
dvRS232_2 =			5001:2:0 //Vaddio 2
dvRS232_3 =			5001:3:0 //Tesira
dvRS232_4 =			5001:4:0 //Extron SMP
dvLighting =			5001:5:0 //Lutron QSE-CI-NWK-E
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
dvIOs =					5001:22:0 //

dvVIDEOIN_1   = 			5002:1:DGX_CONN //Vaddio Cam 1
dvVIDEOIN_2   = 			5002:2:DGX_CONN //Vaddio Cam 2
dvVIDEOIN_3   = 			5002:3:DGX_CONN // Extron SMB 351
dvVIDEOIN_4   = 			5002:4:DGX_CONN //TV Tuner
dvVIDEOIN_5   = 			5002:5:DGX_CONN //Air media
dvVIDEOIN_6  = 			5002:6:DGX_CONN //Smart Kapp IQ Pro (Possible for Future)
dvVIDEOIN_7  = 			5002:7:DGX_CONN //Smart Kapp IQ Pro (Possible for Future)
dvVIDEOIN_8  = 			5002:8:DGX_CONN //Blank
dvVIDEOIN_9   = 			5002:9:DGX_CONN //Desktop Left
dvVIDEOIN_10  = 			5002:10:DGX_CONN //Desktop Right
dvVIDEOIN_11 =			5002:11:DGX_CONN //DxLink TX (AAP Plate)
dvVIDEOIN_12 =			5002:12:DGX_CONN //Doc Cam
dvVIDEOIN_13 =			5002:13:DGX_CONN //Not Used
dvVIDEOIN_14 =			5002:14:DGX_CONN //Not Used
dvVIDEOIN_15 =			5002:15:DGX_CONN //Not Used
dvVIDEOIN_16 =			5002:16:DGX_CONN //Not Used

 
dvAUDIOUT_17 =			5002:17:DGX_CONN //Main Audio Out
dvAUDIOUT_18 =			5002:18:DGX_CONN
dvAUDIOUT_19 =			5002:19:DGX_CONN
dvAUDIOUT_20 =			5002:20:DGX_CONN
dvAUDIOUT_21 =			5002:21:DGX_CONN
dvAUDIOUT_22 =			5002:22:DGX_CONN
dvAUDIOUT_23 =			5002:23:DGX_CONN
dvAUDIOUT_24 =			5002:24:DGX_CONN

dvProjector_Left =			46005:1:DGX_CONN
dvProjector_dxLeft =		46005:6:DGX_CONN

dvProjector_Right =			46006:1:DGX_CONN
dvProjector_dxRight =		46006:6:DGX_CONN

dvTelevision_Left =			46009:1:DGX_CONN //Sony TV
dvTelevision_dxSonyLeft	=	46009:6:DGX_CONN //Sony RX

dvTelevision_Right =		46011:1:DGX_CONN //Sony TV
dvTelevision_dxSonyRight =	46011:6:DGX_CONN //Sony RX

vdvProjector_Left =			35011:1:0
vdvProjector_Right =		35012:1:0
vdvTelevision_Left =		35013:1:0
vdvTelevision_Right =		35014:1:0 

//Define Touch Panel Type
#WARN 'Check correct Panel Type'
//#DEFINE G4PANEL
#DEFINE G5PANEL //Ex..MT-702, MT1002, MXT701

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

SET_OP_LOW				= 30;
SET_OP_MAX				= 255;
SET_OP_OFF				= 0;

//DGX Routing Numbers...
VIDEO_CAMERA_FRONT			= 1 //Camera Front...
VIDEO_CAMERA_REAR			= 2 //Camera Rear
VIDEO_RECORD				= 3 //Extron Input for Preview
VIDEO_MERSIVE				= 4 //Solstice...
VIDEO_PC_MAIN				= 9
VIDEO_PC_EXT				= 10
VIDEO_EXTERNAL				= 11
VIDEO_DOC_CAM				= 12

OUT_AVBRIDGE				= 1 //Camera Send
OUT_REC_CAMERA				= 2 //Camera Send
OUT_REC_CONTENT			= 3
OUT_PROJECTOR_LEFT			= 5
OUT_PROJECTOR_RIGHT			= 6
OUT_LECTERN_MON_LEFT		= 7
OUT_LECTERN_MON_RIGHT		= 8
OUT_DISPLAY_LEFT				= 9 
OUT_DISPLAY_RIGHT			= 11 //Sony Television House Right

AUDIO_OUT_MAIN				= 17 //Extract Card = Temp Connection

//Set DxLinks...
//Uncomment the Desired Scaling...
//#DEFINE AUTO
#DEFINE MANUAL 
//#DEFINE BYPASS

#IF_DEFINED AUTO
SET_SCALE				= 'AUTO'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
#END_IF

#IF_DEFINED MANUAL
SET_RESOLUTION			= '1920x1080,60'
SET_SCALE				= 'MANUAL'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
#END_IF

#IF_DEFINED BYPASS
SET_SCALE				= 'BYPASS'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

//Common Feedback...
POWER_CYCLE				= 9
POWER_ON					= 27
POWER_OFF					= 28
WARMING					= 253
COOLING					= 254
ON_LINE						= 251
POWER						= 255
BLANK						= 211
 
//TP Addresses
TXT_HELP					= 99
TXT_ROOM				= 100

//Misc
CR 							= 13
LF							= 10
// Time Lines
TL_FEEDBACK				= 91;
TL_STATUS_L				= 92;
TL_STATUS_R				= 93;
TL_SHUTDOWN			= 100;
SET_RUN_TIME				= 10 //10 Second Startup/Shutdown..

MAX_LENGTH 				= 10
TIME_REBOOT					= '06:00:00'
TIME_KILL					= '22:00:00'

SET_MUTE_ON				= 'ENABLE'
SET_MUTE_OFF				= 'DISABLE'

//Times..
ONE_SECOND				= 10
ONE_MINUTE				= ONE_SECOND * 60
ONE_HOUR				= ONE_MINUTE * 60

//Buttons...
BTN_PWR_ON_L				= 1
BTN_PWR_OFF_L				= 2
BTN_MUTE_PROJ_L			= 3

BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L				= 12
BTN_EXTERNAL_L				= 13
BTN_DOC_CAM_L				= 14
BTN_MERSIVE_L				= 15
BTN_CAMERA_REAR_L			= 16

BTN_PWR_ON_R				= 101
BTN_PWR_OFF_R				= 102
BTN_MUTE_PROJ_R			= 103

BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R				= 112
BTN_EXTERNAL_R				= 113
BTN_DOC_CAM_R				= 114
BTN_MERSIVE_R				= 115
BTN_CAMERA_REAR_R			= 116

BTN_PREVIEW_EXT		= 117
BTN_PREVIEW_REC			= 118

BTN_AUDIO_PC				= 511
BTN_AUDIO_LECTERN			= 513
BTN_AUDIO_MERSIVE			= 515

BTN_ONLINE_L				= 601
BTN_WARMING_L				= 602
BTN_COOLING_L				= 603

BTN_ONLINE_R				= 611
BTN_WARMING_R				= 612
BTN_COOLING_R				= 613

BTN_CAM_PWR				= 50
BTN_CAM_FRONT				= 51
BTN_CAM_REAR				= 52
BTN_CAM_DOC				= 53

BTN_PRVW_ACTIVE_CAMERA		= 120
BTN_PRVW_PC_EXT				= 121
BTN_PRVW_REC				= 122

BTN_CAMERA_POPUP			= 245

BTN_SET_NUMBER				= 1500
BTN_SET_LOCATION			= 1501
BTN_SET_ALL					= 1502

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

PERSISTENT CHAR nHelp_Phone_[15] //
PERSISTENT CHAR nRoom_Location[30]

VOLATILE INTEGER cLockOutLeft;
VOLATILE INTEGER cLockOutRight;
VOLATILE INTEGER nPwrStateLeft;
VOLATILE INTEGER nPwrStateRight;

VOLATILE INTEGER nTPOnline
VOLATILE INTEGER nBootup_
VOLATILE INTEGER nSource_Left  
VOLATILE INTEGER nSource_Right
VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nSourceCamera
VOLATILE INTEGER nMute_Left
VOLATILE INTEGER nMute_Right

VOLATILE INTEGER cIndexCamera;
VOLATILE INTEGER nLivePreview_ //Is Camera Live or naw..
VOLATILE INTEGER nOnline_Rear //Camera
VOLATILE INTEGER nOnline_Front //Camera

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLPwrStatus[] = {1000}

VOLATILE DEV vdvTP_Main[] = 
{
    dvTP_Main
}
VOLATILE INTEGER nVideoSources[] =
{
    VIDEO_PC_MAIN,
    VIDEO_PC_EXT,
    VIDEO_EXTERNAL,
    VIDEO_DOC_CAM,
    VIDEO_MERSIVE,
    VIDEO_CAMERA_REAR
}
VOLATILE INTEGER nProjectorLeftVidBtns[] =
{
    BTN_PC_MAIN_L,
    BTN_PC_EXT_L,
    BTN_EXTERNAL_L,
    BTN_DOC_CAM_L,
    BTN_MERSIVE_L,
    BTN_CAMERA_REAR_L
}
VOLATILE INTEGER nProjectorRightVidBtns[] =
{
    BTN_PC_MAIN_R,
    BTN_PC_EXT_R,
    BTN_EXTERNAL_R,
    BTN_DOC_CAM_R,
    BTN_MERSIVE_R,
    BTN_CAMERA_REAR_R
}
VOLATILE LONG lTLPwrShutdown[] =
{
    0,
    1000, //Off
    4000, //Screens Up...
    5000, //Video Reset
    30000 //Audio Reset...
}
VOLATILE CHAR nDgxInputNames[16][31] =
{
    'Camera Front',
    'Camera Rear',
    'SMP Preview',
    'Mersive',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Desktop',
    'Desktop Ext',
    'VGA/HDMI Lect',
    'Doc Cam',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used'
}
VOLATILE CHAR nDgxOutputNames[16][31] =
{
    'AVB Camera',
    'SMP Camera',
    'SMP Content',
    'Not Used',
    'Projector Left',
    'Projector Right',
    'Monitor Left',
    'Monitor Right',
    'Sony Left',
    'Has Problems', //??
    'Sony Right',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used'
}
VOLATILE CHAR nDgxAudioOutName[8][31] =
{
    'Audio Mix Out',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used'
}
VOLATILE DEV dcDGXVideoSlots[] =
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
    dvVIDEOIN_10,
    dvVIDEOIN_11,
    dvVIDEOIN_12,
    dvVIDEOIN_13,
    dvVIDEOIN_14,
    dvVIDEOIN_15,
    dvVIDEOIN_16
}
VOLATILE DEV dcDGXAudioSlots[] =
{
    dvAUDIOUT_17,
    dvAUDIOUT_18,
    dvAUDIOUT_19,
    dvAUDIOUT_20,
    dvAUDIOUT_21,
    dvAUDIOUT_22,
    dvAUDIOUT_23,
    dvAUDIOUT_24
}
VOLATILE INTEGER nCameraButtons[] =
{
    BTN_CAM_FRONT,
    BTN_CAM_REAR,
    BTN_CAM_DOC
}
VOLATILE INTEGER nSourceCameraIn[] =
{
    VIDEO_CAMERA_FRONT,
    VIDEO_CAMERA_REAR,
    VIDEO_DOC_CAM
}
VOLATILE CHAR nCameraPages[3][20] =
{
    '_Camera',
    '_Camera',
    '_Camera_DocCam'
}
VOLATILE CHAR nCameraPageTitles[3][30] =
{
    'Front Camera',
    'Rear Camera',
    'Lectern Doc Camera'
}
VOLATILE INTEGER nVideoPrvwBtns[] =
{
    BTN_PRVW_PC_EXT,
    BTN_PRVW_REC
}

#INCLUDE 'LutronLighting103_'
#INCLUDE 'ExtronSMP_103'
#INCLUDE 'VaddioCamera_103'
#INCLUDE 'Biamp_Tesira_103'
#INCLUDE 'Shure_WM_Quad'
#INCLUDE 'SetMasterClock_'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main, BTN_PWR_OFF_L])
([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_CAMERA_REAR_L])

([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main, BTN_PWR_OFF_R])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_CAMERA_REAR_R])

([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_MERSIVE])

([dvTP_Main, BTN_PREVIEW_EXT],[dvTP_Main, BTN_PREVIEW_REC])

([dvTP_Main, BTN_CAM_FRONT]..[dvTP_Main, BTN_CAM_DOC])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnDGXPull()
{
    WAIT 10 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_LEFT)" 
    WAIT 20 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_RIGHT)" 
    WAIT 30 SEND_COMMAND dvDGX, "'?INPUT-AUDIO,',ITOA(AUDIO_OUT_MAIN)" 
    WAIT 40 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_AVBRIDGE)"
}
DEFINE_FUNCTION fnLoadDGXVideoLabels()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop=1; cLoop<=LENGTH_ARRAY(dcDGXVideoSlots); cLoop++)
    {
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDIN_NAME-',nDgxInputNames[cLoop]"
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDOUT_NAME-',nDgxOutputNames[cLoop]"
    }
}
DEFINE_FUNCTION fnLoadDGXAudioLabels()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop=1; cLoop<=LENGTH_ARRAY(dcDGXAudioSlots); cLoop++)
    {
	SEND_COMMAND dcDGXAudioSlots[cLoop], "'VIDOUT_NAME-',nDgxAudioOutName[cLoop]"
    }
}
DEFINE_CALL 'DGX NAMING'
{
    fnDGXPull()
    
    WAIT 120
    {
	fnLoadDGXAudioLabels()
    }
    WAIT 180
    {
	fnLoadDGXVideoLabels()
    }
}

DEFINE_FUNCTION fnRouteVideoLeft(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_LEFT),',',ITOA(OUT_LECTERN_MON_LEFT),',',ITOA(OUT_DISPLAY_LEFT),',',ITOA(OUT_REC_CONTENT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
    }
}
DEFINE_FUNCTION fnRouteVideoRight(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_RIGHT),',',ITOA(OUT_LECTERN_MON_RIGHT),',',ITOA(OUT_DISPLAY_RIGHT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
    }
}
DEFINE_FUNCTION fnRouteVideoPreview(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_LECTERN_MON_RIGHT)"
}
DEFINE_FUNCTION fnReboot()
{
    IF ((TIME == TIME_REBOOT) && (nTPOnline == FALSE))
    {
	REBOOT (dvMaster)
    }
}
DEFINE_FUNCTION fnPowerDisplays(INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    IF (cLockOutLeft == TRUE)
	    {
		//
	    }
	    ELSE
	    {
		PULSE [vdvProjector_Left, POWER_ON]
		    PULSE [vdvTelevision_Left, POWER_ON]
			nPwrStateLeft = TRUE;
			    ON [vdvTP_Main, BTN_PWR_ON_L]
	    }
	}
	CASE BTN_PWR_OFF_L :
	{
	    IF (cLockOutLeft == TRUE)
	    {
		//
	    }
	    ELSE
	    {
		PULSE [vdvProjector_Left, POWER_OFF]
		    PULSE [vdvTelevision_Left, POWER_OFF]
			nPwrStateLeft = FALSE;
	    }
	}
	CASE BTN_PWR_ON_R :
	{
	    IF (cLockOutRight == TRUE)
	    {
		//
	    }
	    ELSE
	    {
		PULSE [vdvProjector_Right, POWER_ON]
		    PULSE [vdvTelevision_Right, POWER_ON]
		    		    nPwrStateRight = TRUE;
			ON [vdvTP_Main, BTN_PWR_ON_R]
	    }
	}
	CASE BTN_PWR_OFF_R :
	{
	    IF (cLockOutRight == TRUE)
	    {
		//
	    }
	    ELSE
	    {
		PULSE [vdvProjector_Right, POWER_OFF]
		    PULSE [vdvTelevision_Right, POWER_OFF]
			 nPwrStateRight = FALSE;
	    }
	}
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
DEFINE_FUNCTION fnKill()
{
    IF (TIME == TIME_KILL)
    {
	IF (!TIMELINE_ACTIVE (TL_SHUTDOWN))
	{
	    TIMELINE_CREATE (TL_SHUTDOWN, lTLPwrShutdown, LENGTH_ARRAY (lTLPwrShutdown), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
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
DEFINE_FUNCTION fnDGXRouteCamera(INTEGER cIn) 
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_AVBRIDGE),',',ITOA(OUT_REC_CAMERA)"
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

nBootup_ = TRUE;

WAIT 50
{
    TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    

}
WAIT 450
{
    nBootup_ = FALSE;
}

DEFINE_MODULE 'Sony_FHZ700L' PROJMODLEFT(vdvProjector_Left, dvProjector_Left);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODRIGHT(vdvProjector_Right, dvProjector_Right);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODLEFT(vdvTelevision_Left, dvTelevision_Left);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODRIGHT(vdvTelevision_Right, dvTelevision_Right);


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
		IF (nMute_left == FALSE)
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
		IF (nMute_right == FALSE)
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
	STACK_VAR INTEGER nSTDX;
	    nSTDX = GET_LAST (nProjectorLeftVidBtns)
		fnRouteVideoLeft(nVideoSources[nSTDX])
    }
}
BUTTON_EVENT [vdvTP_Main, nProjectorRightVidBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX;
	    nSTDX = GET_LAST (nProjectorRightVidBtns)
		fnRouteVideoRight(nVideoSources[nSTDX])
	    	OFF [dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
	    nLivePreview_ = FALSE;
	    TOTAL_OFF [vdvTP_Main, nVideoPrvwBtns]
    }
}
BUTTON_EVENT [vdvTP_Main, nVideoPrvwBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER cSTX;
	cSTX = GET_LAST (nVideoPrvwBtns)
	    ON [vdvTP_Main, nVideoPrvwBtns[cSTX]] //FB...
	
	SWITCH (cSTX)
	{
	    CASE BTN_PREVIEW_EXT : fnRouteVideoPreview(VIDEO_PC_EXT)
	    CASE BTN_PREVIEW_REC : fnRouteVideoPreview(VIDEO_RECORD)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nCameraButtons] //Camera Select
{
    PUSH :
    {
	cIndexCamera = GET_LAST (nCameraButtons);
	SEND_COMMAND dvTP_Main, "'^PPX'" //Make sure we reset/close first...
	SEND_COMMAND dvTP_Main, "'^PPN-',nCameraPages[cIndexCamera]" //Call correct Page
	    fnDGXRouteCamera (nSourceCameraIn[cIndexCamera]) //Index correct source..
	    TOTAL_OFF [dvTP_Main, nPresetSelect]
	
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Set Correct Title
	    ON [dvTP_Main, nCameraButtons[cIndexCamera]] //Set FB
	    
	IF (nLivePreview_ == TRUE) 
	{
	    fnRouteVideoPreview(nSourceCameraIn[cIndexCamera])
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA] //Active Camera Preview
{
    PUSH :
    {
	IF (nLivePreview_ == FALSE)
	{
	    ON [dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
		fnRouteVideoPreview (nSourceCameraIn[cIndexCamera])
		    nLivePreview_ = TRUE;
	}
	ELSE
	{
	    fnRouteVideoPreview (nSource_Right)
		OFF [dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
		    nLivePreview_ = FALSE;
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_CAMERA_POPUP]
{
    PUSH :
    {
	SEND_COMMAND dvTP_Main, "'^PPN-',nCameraPages[cIndexCamera]" //Load appropriate Page...
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Load Title
	    
//	SELECT
//	{
//	    ACTIVE (nCamIDX == 1) :
//	    {
//		[vdvTP_Main, BTN_CAM_PWR] = nCamOnline_Front;
//	    }
//	    ACTIVE (nCamIDX == 2) :
//	    {
//		[vdvTP_Main, BTN_CAM_PWR] = nCamOnline_Rear;
//	    }
//	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SET_NUMBER]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL
	SEND_COMMAND vdvTP_Main, "'@TKP'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND vdvTP_Main, "'^TKP'"
	#END_IF
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SET_LOCATION]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL 
	SEND_COMMAND vdvTP_Main, "'@AKB'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND vdvTP_Main, "'^AKB'"
	#END_IF
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SET_ALL]
{
    PUSH :
    {
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_Left, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_MAX)"
		    ON [vdvTP_Main, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		IF (!TIMELINE_ACTIVE(TL_STATUS_L))
		{
		    TIMELINE_CREATE (TL_STATUS_L, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		}
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_LOW)"
		OFF [vdvTP_Main, BTN_ONLINE_L]
	    }
	}
    }
}
CHANNEL_EVENT [vdvProjector_Right, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_MAX)"
		ON [vdvTP_Main, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		IF (!TIMELINE_ACTIVE(TL_STATUS_R))
		{
		    TIMELINE_CREATE (TL_STATUS_R, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		}
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_LOW)"
		OFF [vdvTP_Main, BTN_ONLINE_R]
	    }
	 }   
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	nTPOnline = TRUE;
	SEND_STRING dvDebug, "'Main TouchPanel : Now Online'"

	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	
    }
    OFFLINE :
    {
	nTPOnline = FALSE;
    }
STRING :
    {
	LOCAL_VAR CHAR sTmp[30]
	
	sTmp = DATA.TEXT
	
	IF (FIND_STRING(sTmp,'KEYB-',1)OR FIND_STRING(sTmp,'AKB-',1)) //G4 or G5 Parsing
	{
	   REMOVE_STRING(sTmp,'-',1)
	   
		IF (FIND_STRING(sTmp,'ABORT',1))
		{
		    nRoom_Location = 'Set Default'
		    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
		}
		ELSE
		{
		     nRoom_Location = sTmp
		    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
		}
	}
	IF (FIND_STRING(sTmp,'KEYP-',1)OR FIND_STRING(sTmp,'TKP-',1)) //G4 or G5
	{
	    REMOVE_STRING(sTmp,'-',1)
	    
	    IF (FIND_STRING(sTmp,'ABORT',1)) //Keep Default if it was set...
	    {
		nHelp_Phone_ = nHelp_Phone_
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	    ELSE
	    {
		nHelp_Phone_ = sTmp
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	}
    }
}
DATA_EVENT [dvDGX]
{
    ONLINE :
    {
	SEND_STRING dvDebug, "'DGX : Now Online!'"
	WAIT 80
	{
	    CALL 'DGX NAMING'
	}
    }
    OFFLINE :
    {
	SEND_STRING dvDebug, "'DGX : Went Offline!'"
    }
    COMMAND :
    {
	STACK_VAR CHAR cAudioIn[4];
	STACK_VAR CHAR cInput[5];
	STACK_VAR INTEGER cOutput;
	
	CHAR cMsg[20];
	cMsg = DATA.TEXT
	
	IF (FIND_STRING(cMsg,"'SWITCH-LVIDEOI'",1))
	{
	    SEND_STRING dvDebug, "'DGX : Video Change: ',cMsg"
	    
	    REMOVE_STRING (cMsg,"'SWITCH-LVIDEOI'",1)
		
	    cInput = cMsg; //3O12 ...or 3O3...etc
		
	    REMOVE_STRING(cMsg,"'O'",1) //Removing "O" will leave output...
	    cOutput = ATOI(cMsg) //Store remaing Output Values
		
	    SWITCH (cOutput)
	    {
		CASE OUT_PROJECTOR_LEFT :
		{
		    cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-2)
			nSource_Left = ATOI (cInput)
		    		    
		    SWITCH (nSource_Left)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_L]
			CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_L]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_L]
			CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_L]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_L]
			CASE VIDEO_CAMERA_REAR : ON [vdvTP_Main, BTN_CAMERA_REAR_L]
		    }
		}
		CASE OUT_PROJECTOR_RIGHT :
		{
		    cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-2)
			nSource_Right = ATOI (cInput)
		    
		    SWITCH (nSource_Right)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_R]
			CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_R]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_R]
			CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_R]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_R]
			CASE VIDEO_CAMERA_REAR : ON [vdvTP_Main, BTN_CAMERA_REAR_R]
		    }
		}
		CASE OUT_AVBRIDGE :
		{
		    cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-2)
			nSourceCamera = ATOI (cInput)
			
		    SWITCH (nSourceCamera)
		    {
			CASE VIDEO_CAMERA_FRONT : 
			{
			    cIndexCamera = 1;
				//SEND_COMMAND dvTP_Main, "'^BMF-',ITOA(BTN_FLIP_IMAGE),',0,%OP255'"
				    [dvTP_Main, BTN_CAM_PWR] = nOnline_Front;
					ON [dvTP_Main, BTN_CAM_FRONT]
					SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_BOARD_1),'.',ITOA(BTN_BOARD_4),',0,%OP',ITOA(SET_OP_OFF)"
			}
			CASE VIDEO_CAMERA_REAR :
			{
			    cIndexCamera = 2;
				SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_BOARD_1),'.',ITOA(BTN_BOARD_4),',0,%OP',ITOA(SET_OP_MAX)"
				[dvTP_Main, BTN_CAM_PWR] = nOnline_Rear
				    ON [dvTP_Main, BTN_CAM_REAR]
			}
			CASE VIDEO_DOC_CAM : 
			{
			    ON [dvTP_Main, BTN_CAM_DOC]
				cIndexCamera = 3;
			}
		    }
		}
	    }
	}
	//Audio Feedback...
	IF (FIND_STRING(cMsg,"'SWITCH-LAUDIOI'",1))
	{
	    SEND_STRING dvDebug, "'DGX : Audio Change: ',cMsg"
		
	    REMOVE_STRING (cMsg,"'SWITCH-LAUDIOI'",1)
		
	    IF (FIND_STRING(cMsg,"'O',ITOA(AUDIO_OUT_MAIN)",1))
	    {
		cAudioIn = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-3)	
		    nSource_Audio = ATOI(cAudioIn)
		    
		SWITCH (nSource_Audio)
		{
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_AUDIO_PC]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_AUDIO_LECTERN]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_AUDIO_MERSIVE]
		}
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxLeft] //Left Projector Port...
{
    ONLINE :
    {
	SEND_STRING dvDebug, "'dvProjector_dxLeft : Now Online'"
	WAIT 150
	{
	    fnSetRXScale (dvProjector_dxLeft)
	    WAIT 30
	    {
		fnMuteCheck(dvProjector_dxLeft)
	    }
	}
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cTmp[8];
	
	CHAR cMsg[30];
	cMsg = DATA.TEXT
	
	IF (FIND_STRING(cMsg,'VIDOUT_MUTE-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
	    cTmp = cMsg;
	    
	    SWITCH (cTmp)
	    {
		CASE 'ENABLE' :
		{
			ON [vdvTP_Main, BTN_MUTE_PROJ_L]
			fnMuteProjector(dvTelevision_dxSonyLeft, SET_MUTE_ON)
			    nMute_Left = TRUE;
		}
		CASE 'DISABLE' :
		{
		    OFF [vdvTP_Main, BTN_MUTE_PROJ_L]
			fnMuteProjector(dvTelevision_dxSonyLeft, SET_MUTE_OFF)
			    nMute_Left = FALSE;
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxRight] //Left Projector Port...
{
    ONLINE :
    {
	SEND_STRING dvDebug, "'dvProjector_dxRight : Now Online'"
	WAIT 150
	{
	    fnSetRXScale (dvProjector_dxRight)
	    WAIT 30
	    {
		fnMuteCheck(dvProjector_dxRight)
	    }
	}
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cTmp[8];
	
	CHAR cMsg[30];
	cMsg = DATA.TEXT
	
	IF (FIND_STRING(cMsg,'VIDOUT_MUTE-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
		cTmp = cMsg;
		
	    SWITCH (cTmp)
	    {
		CASE 'ENABLE' :
		{
		    ON [vdvTP_Main, BTN_MUTE_PROJ_R]
			fnMuteProjector(dvTelevision_dxSonyRight, SET_MUTE_ON)
			    nMute_Right = TRUE;
		}
		CASE 'DISABLE' :
		{
		    OFF [vdvTP_Main, BTN_MUTE_PROJ_R]
			fnMuteProjector(dvTelevision_dxSonyRight, SET_MUTE_OFF)
			    nMute_Right = FALSE;
		}
	    }	
	}
    }
}
DATA_EVENT [vdvProjector_Left]
{
    COMMAND :
    {
	STACK_VAR CHAR cGrabStatus[8];
	
	CHAR cMsg[30];
	cMsg = DATA.TEXT
	
	IF (FIND_STRING (cMsg,'FBPROJECTOR-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
		SEND_STRING dvDebug, "'vdvProjector_Left : Response: ',cMsg"
	    
	    cGrabStatus = cMsg;
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'PWRON':
		{
		    ON [vdvTP_Main, BTN_PWR_ON_L]
		}
		CASE 'PWROFF' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_L]
		}
		CASE 'ONLINE':
		{
		    ON [vdvTP_Main, BTN_ONLINE_L]
			SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_MAX)"
		}
		CASE 'OFFLINE' :
		{
		    OFF [vdvTP_Main, BTN_ONLINE_L]
			SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_LOW)"
		}
	    }
	}
    }
}
DATA_EVENT [vdvProjector_Right]
{
    COMMAND :
    {
	STACK_VAR CHAR cGrabStatus[8];
	
	CHAR cMsg[30];
	cMsg = DATA.TEXT
	
	IF (FIND_STRING (cMsg,'FBPROJECTOR-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
	    SEND_STRING dvDebug, "'vdvProjector_Right : Response: ',cMsg"
	    
		cGrabStatus = cMsg;
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'PWRON':
		{
		    ON [vdvTP_Main, BTN_PWR_ON_R]
		}
		CASE 'PWROFF' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_R]
		}
		CASE 'ONLINE':
		{
		    ON [vdvTP_Main, BTN_ONLINE_R]
			SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_MAX)"
		}
		CASE 'OFFLINE' :
		{
		    OFF [vdvTP_Main, BTN_ONLINE_R]
			SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_LOW)"
		}
	    }
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_STATUS_L]
{
    IF (TIMELINE.REPETITION < SET_RUN_TIME)
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_LOW)"
	
	SWITCH (nPwrStateLeft)
	{
	    CASE 1 :
	    {
		[vdvTP_Main, 602] = ![vdvTP_Main, 602]
	    }
	    DEFAULT :
	    {
		[vdvTP_Main, 603] = ![vdvTP_Main, 603]
	    }
	}
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_MAX)"
	TIMELINE_KILL (TL_STATUS_L)
	    cLockOutLeft = FALSE;
		OFF [vdvTP_Main, 602]
		OFF [vdvTP_Main, 603]
    }
}
TIMELINE_EVENT [TL_STATUS_R]
{
    IF (TIMELINE.REPETITION < SET_RUN_TIME)
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_LOW)"
	
	SWITCH (nPwrStateRight)
	{
	    CASE 1 :
	    {
		[vdvTP_Main, 612] = ![vdvTP_Main, 612]
	    }
	    DEFAULT :
	    {
		[vdvTP_Main, 613] = ![vdvTP_Main, 613]
	    }
	}
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_MAX)"
	TIMELINE_KILL (TL_STATUS_R)
	    cLockOutRight = FALSE;
		OFF [vdvTP_Main, 612]
		    OFF [vdvTP_Main, 613]
    }
}
TIMELINE_EVENT [TL_SHUTDOWN]
{
    SEND_STRING dvDebug, "'timeline_event[TL_SHUTDOWN]: timeline.sequence = ', ITOA(TIMELINE.SEQUENCE)";
    
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 : //UnBlanK
	{
	    cLockOutLeft = TRUE;
	    cLockOutRight = TRUE;
	    fnMuteProjector (dvProjector_dxLeft, SET_MUTE_OFF)
		fnMuteProjector (dvProjector_dxRight, SET_MUTE_OFF)
	}
	CASE 2 :
	{
	    PULSE [vdvProjector_Left, POWER_OFF]
		PULSE [vdvTelevision_Left, POWER_OFF]
	}
	CASE 3 :
	{
	    PULSE [vdvProjector_Right, POWER_OFF]
		PULSE [vdvTelevision_Right, POWER_OFF]
	}
	CASE 4 :
	{
	    fnRouteVideoLeft (VIDEO_PC_MAIN)
		fnRouteVideoRight (VIDEO_PC_EXT)
	}
	CASE 5 :
	{
	   // fnSetAudioLevels()
	   	    cLockOutLeft = FALSE;
	    cLockOutRight = FALSE;
	}
    }
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

    WAIT 1200
    {
	fnDGXPull()
    }
}

DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)



