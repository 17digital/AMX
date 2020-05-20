PROGRAM_NAME='105_Master'

(***********************************************************)
(*  FILE CREATED ON: 05/19/2017  AT: 10:37:41              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/20/2020  AT: 09:04:39        *)
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

dvMaster =					0:1:0 //NX 4200
dvTP_MAIN =				10001:1:0

DGX_CONN =				166 //128.61.218.169

dvRS232_1 =				5001:1:0 //Tesira Biamp Top
dvRS232_2 =				5001:2:0 //Tesira Biamp Bottom
dvRS232_3 =				5001:3:0 //Extron SMP
dvRS232_4 =				5001:4:0 //Vaddio Cam 1
dvRS232_5 =				5001:5:0 //Vaddio Cam 2
dvRS232_6 =				5001:6:0 //Not Used
dvRS232_7 =				5001:7:0 //Not Used
dvRS232_8 =				5001:8:0 //Not used
 
dvRelays =					5001:21:0 //
dvIOs =						5001:22:0 //

dvDGX =					5002:1:DGX_CONN

dvVIDEOIN_1   = 			5002:1:DGX_CONN //Vaddio Cam 1
dvVIDEOIN_2   = 			5002:2:DGX_CONN //Vaddio Cam 2
dvVIDEOIN_3   = 			5002:3:DGX_CONN // Extron SMB 351
dvVIDEOIN_4   = 			5002:4:DGX_CONN //TV Tuner
dvVIDEOIN_5   = 			5002:5:DGX_CONN //Air media
dvVIDEOIN_6  = 			5002:6:DGX_CONN //Smart Kapp IQ Pro (Possible for Future)
dvVIDEOIN_7  = 			5002:7:DGX_CONN //Smart Kapp IQ Pro (Possible for Future)
dvVIDEOIN_8  = 			5002:8:DGX_CONN //Blank
dvVIDEOIN_9   = 			5002:9:DGX_CONN //Desktop Left
dvVIDEOIN_10  = 		5002:10:DGX_CONN //Desktop Right
dvVIDEOIN_11 =			5002:11:DGX_CONN //DxLink TX (AAP Plate)
dvVIDEOIN_12 =			5002:12:DGX_CONN //Doc Cam
dvVIDEOIN_13 =			5002:13:DGX_CONN 
dvVIDEOIN_14 =			5002:14:DGX_CONN 
dvVIDEOIN_15 =			5002:15:DGX_CONN 
dvVIDEOIN_16 =			5002:16:DGX_CONN 
dvVIDEOIN_17 =			5002:17:DGX_CONN 
dvVIDEOIN_18 =			5002:18:DGX_CONN 
dvVIDEOIN_19 =			5002:19:DGX_CONN 
dvVIDEOIN_20 =			5002:20:DGX_CONN 
dvVIDEOIN_21 =			5002:21:DGX_CONN 
dvVIDEOIN_22 =			5002:22:DGX_CONN 
dvVIDEOIN_23 =			5002:23:DGX_CONN 
dvVIDEOIN_24 =			5002:24:DGX_CONN 
dvVIDEOIN_25 =			5002:25:DGX_CONN 
dvVIDEOIN_26 =			5002:26:DGX_CONN 
dvVIDEOIN_27 =			5002:27:DGX_CONN 
dvVIDEOIN_28 =			5002:28:DGX_CONN 
dvVIDEOIN_29 =			5002:29:DGX_CONN 
dvVIDEOIN_30 =			5002:30:DGX_CONN 
dvVIDEOIN_31 =			5002:31:DGX_CONN 
dvVIDEOIN_32 =			5002:32:DGX_CONN 

dvAUDIOOUT_33 =			5002:33:DGX_CONN //Main Audio Out
dvAUDIOOUT_34 =			5002:34:DGX_CONN
dvAUDIOOUT_35 =			5002:35:DGX_CONN
dvAUDIOOUT_36 =			5002:36:DGX_CONN
dvAUDIOOUT_37 =			5002:37:DGX_CONN
dvAUDIOOUT_38 =			5002:38:DGX_CONN
dvAUDIOOUT_39 =			5002:39:DGX_CONN
dvAUDIOOUT_40 =			5002:40:DGX_CONN

dvProjector_Left =			46001:1:DGX_CONN
dvProjector_dxLeft =			46001:6:DGX_CONN

dvProjector_Right =			46002:1:DGX_CONN
dvProjector_dxRight =			46002:6:DGX_CONN

dvDisplay_One =				46005:1:DGX_CONN
dvDisplay_Two =				46006:1:DGX_CONN
dvDisplay_Three =			46007:1:DGX_CONN
dvDisplay_Four =				46008:1:DGX_CONN
dvDisplay_Five =				46009:1:DGX_CONN
dvDisplay_Six =				46010:1:DGX_CONN

vdvProjector_Left =			35011:1:0
vdvProjector_Right =			35012:1:0
vdvDisplay_One  =			35013:1:0
vdvDisplay_Two =			35014:1:0
vdvDisplay_Three =			35015:1:0
vdvDisplay_Four =			35016:1:0
vdvDisplay_Five =			35017:1:0
vdvDisplay_Six =				35018:1:0



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Screens...
LEFT_UP					= 4
LEFT_DN					= 3
RIGHT_DN					= 1
RIGHT_UP					= 2			

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100
TXT_TV					= 98
MY_ROOM					= 'IC 105'
MY_HELP_PHONE				= '404-894-4669'

//Other Stuff
ONE_SECOND				= 10 
ONE_MINUTE				= 60 * ONE_SECOND
ONE_HOUR					= 60 * ONE_MINUTE
CR 						= 13
LF 						= 10
MAX_LENGTH 				= 10
TIME_REBOOT				= '06:00:00'
TIME_KILL					= '22:00:00'

//Timelines
TL_FEEDBACK					= 1
TL_FLASH					= 2

//DGX Channels...
VIDEO_PC_MAIN				= 1
VIDEO_PC_EXT				= 2
VIDEO_EXTERNAL				= 3 //VGA HDMI
VIDEO_DOC_CAM				= 4
VIDEO_BYOD_1				= 5
VIDEO_BYOD_2				= 6
VIDEO_BYOD_3				= 7
VIDEO_BYOD_4				= 8
VIDEO_BYOD_5				= 9
VIDEO_BYOD_6				= 10
VIDEO_MERSIVE				= 13 //@Lectern
VIDEO_MERSIVE_1 			= 14
VIDEO_MERSIVE_2			= 15
VIDEO_MERSIVE_3			= 16
VIDEO_MERSIVE_4			= 17
VIDEO_MERSIVE_5			= 18
VIDEO_MERSIVE_6			= 19
VIDEO_RECORD				= 20
VIDEO_CAMERA_FRONT			= 21
VIDEO_CAMERA_REAR			= 22

OUT_PROJECTOR_RIGHT		= 2
OUT_PROJECTOR_LEFT			= 1
OUT_LECTERN_MON_RIGHT		= 4
OUT_LECTERN_MON_LEFT		= 3
OUT_DISPLAY_1				= 5
OUT_DISPLAY_2				= 6
OUT_DISPLAY_3				= 7
OUT_DISPLAY_4				= 8
OUT_DISPLAY_5				= 9
OUT_DISPLAY_6				= 10
OUT_REC_CONTENT			= 13 //Extron SMP
OUT_REC_CAMERA			= 14 //Extron SMP
OUT_AVBRIDGE				= 15 //Send Cameras

AUDIO_OUT_MAIN			= 33

//DxLink Stuff...
SET_MUTE_ON				= 'ENABLE'
SET_MUTE_OFF				= 'DISABLE'

//Common Feedback...
POWER_CYCLE				= 9
VOLUME_UP				= 24
VOLUME_DN				= 25
POWER_ON					= 27
POWER_OFF				= 28
WARMING					= 253
COOLING					= 254
ON_LINE					= 251
POWER					= 255
BLANK					= 211

//Buttons...
BTN_PWR_ON_L				= 1
BTN_PWR_OFF_L				= 2
BTN_MUTE_PROJ_L			= 3

BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L				= 12
BTN_EXTERNAL_L				= 13
BTN_DOC_CAM_L				= 14
BTN_MERSIVE_L				= 15
BTN_MERSIVE_TV1_L			= 16
BTN_BYOD_TV1_L			= 17
BTN_MERSIVE_TV2_L			= 18
BTN_BYOD_TV2_L			= 19
BTN_MERSIVE_TV3_L			= 20
BTN_BYOD_TV3_L			= 21
BTN_MERSIVE_TV4_L			= 22
BTN_BYOD_TV4_L			= 23
BTN_MERSIVE_TV5_L			= 24
BTN_BYOD_TV5_L			= 25
BTN_MERSIVE_TV6_L			= 26
BTN_BYOD_TV6_L			= 27
BTN_CAMERA_REAR_L			= 28

BTN_PWR_ON_R				= 101
BTN_PWR_OFF_R				= 102
BTN_MUTE_PROJ_R			= 103

BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R				= 112
BTN_EXTERNAL_R				= 113
BTN_DOC_CAM_R				= 114
BTN_MERSIVE_R				= 115
BTN_MERSIVE_TV1_R			= 116
BTN_BYOD_TV1_R			= 117
BTN_MERSIVE_TV2_R			= 118
BTN_BYOD_TV2_R			= 119
BTN_MERSIVE_TV3_R			= 120
BTN_BYOD_TV3_R			= 121
BTN_MERSIVE_TV4_R			= 122
BTN_BYOD_TV4_R			= 123
BTN_MERSIVE_TV5_R			= 124
BTN_BYOD_TV5_R			= 125
BTN_MERSIVE_TV6_R			= 126
BTN_BYOD_TV6_R			= 127
BTN_CAMERA_REAR_R			= 128

BTN_PREVIEW_EXT			= 129
BTN_PREVIEW_REC			= 130

BTN_AUDIO_PC				= 511
BTN_AUDIO_LECTERN			= 513
BTN_AUDIO_MERSIVE			= 515

BTN_ONLINE_L				= 601
BTN_WARMING_L				= 602
BTN_COOLING_L				= 603

BTN_ONLINE_R				= 611
BTN_WARMING_R				= 612
BTN_COOLING_R				= 613
BTN_ACTIVE_TV_ONLINE			= 621

BTN_TVS_ALL_OFF			= 2050
BTN_TVS_ALL_ON			= 2051
BTN_TVS_ALL_MERSIVE		= 2052
BTN_TVS_ALL_BYOD			= 2053
BTN_TVS_ALL_CAMERA			= 2054

BTN_TV_SINGLE_PWR			= 2001
BTN_TV_SINGLE_MERSIVE		= 2002
BTN_TV_SINGLE_BYOD			= 2003
BTN_TV_SINGLE_FOLLOW		= 2004

BTN_TV_ACTIVE_1			= 2031
BTN_TV_ACTIVE_2			= 2032
BTN_TV_ACTIVE_3			= 2033
BTN_TV_ACTIVE_4			= 2034
BTN_TV_ACTIVE_5			= 2035
BTN_TV_ACTIVE_6			= 2036

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE INTEGER iFlash
VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000}

VOLATILE INTEGER nSource_Left  
VOLATILE INTEGER nSource_Right
VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nTPOnline
VOLATILE INTEGER nDisplayOnline_1
VOLATILE INTEGER nDisplayOnline_2
VOLATILE INTEGER nDisplayOnline_3
VOLATILE INTEGER nDisplayOnline_4
VOLATILE INTEGER nDisplayOnline_5
VOLATILE INTEGER nDisplayOnline_6
VOLATILE INTEGER nDisplayPWR_1
VOLATILE INTEGER nDisplayPWR_2
VOLATILE INTEGER nDisplayPWR_3
VOLATILE INTEGER nDisplayPWR_4
VOLATILE INTEGER nDisplayPWR_5
VOLATILE INTEGER nDisplayPWR_6

VOLATILE INTEGER nVideoSources[] =
{
    VIDEO_PC_MAIN,
    VIDEO_PC_EXT,
    VIDEO_EXTERNAL,
    VIDEO_DOC_CAM,
    VIDEO_MERSIVE,
    VIDEO_MERSIVE_1,
    VIDEO_BYOD_1,
    VIDEO_MERSIVE_2,
    VIDEO_BYOD_2,
    VIDEO_MERSIVE_3,
    VIDEO_BYOD_3,
    VIDEO_MERSIVE_4,
    VIDEO_BYOD_4,
    VIDEO_MERSIVE_5,
    VIDEO_BYOD_5,
    VIDEO_MERSIVE_6,
    VIDEO_BYOD_6,
    VIDEO_CAMERA_REAR
}
VOLATILE INTEGER nProjectorLeftVidBtns[] =
{
    BTN_PC_MAIN_L,
    BTN_PC_EXT_L,
    BTN_EXTERNAL_L,
    BTN_DOC_CAM_L,
    BTN_MERSIVE_L,
    BTN_MERSIVE_TV1_L,
    BTN_BYOD_TV1_L,
    BTN_MERSIVE_TV2_L,
    BTN_BYOD_TV2_L,
    BTN_MERSIVE_TV3_L,
    BTN_BYOD_TV3_L,
    BTN_MERSIVE_TV4_L,
    BTN_BYOD_TV4_L,
    BTN_MERSIVE_TV5_L,
    BTN_BYOD_TV5_L,
    BTN_MERSIVE_TV6_L,
    BTN_BYOD_TV6_L,
    BTN_CAMERA_REAR_L
}
VOLATILE INTEGER nProjectorRightVidBtns[] =
{
    BTN_PC_MAIN_R,
    BTN_PC_EXT_R,
    BTN_EXTERNAL_R,
    BTN_DOC_CAM_R,
    BTN_MERSIVE_R,
    BTN_MERSIVE_TV1_R,
    BTN_BYOD_TV1_R,
    BTN_MERSIVE_TV2_R,
    BTN_BYOD_TV2_R,
    BTN_MERSIVE_TV3_R,
    BTN_BYOD_TV3_R,
    BTN_MERSIVE_TV4_R,
    BTN_BYOD_TV4_R,
    BTN_MERSIVE_TV5_R,
    BTN_BYOD_TV5_R,
    BTN_MERSIVE_TV6_R,
    BTN_BYOD_TV6_R,
    BTN_CAMERA_REAR_R
}
VOLATILE CHAR nDgxInputNames[32][31] =
{
    //Naming - Max Char = 31
    'Desktop Main', //1
    'Desktop Ext', //2
    'VGA HDMI', //3
    'Doc Cam', //4
    'BYOD 1', //5
    'BYOD 2', //6
    'BYOD 3', //7
    'BYOD 4', //8
    'BYOD 5', //9
    'BYOD 6', //10
    'Not Used', //11
    'Not Used', //12
    'Mersive Lectern', //13
    'Mersive TV 1', //14
    'Mersive TV 2', //15
    'Mersive TV 3', //16
    'Mersive TV 4', //17
    'Mersive TV 5', //18
    'Mersive TV 6', //19
    'ExtronSMP IN', //20
    'Vaddio Cam 1', //21
    'Vaddio Cam 2', //22
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used', //30
    'Not Used', //31
    'Not Used' //32
}
VOLATILE CHAR nDgxOutputName[32][31] =
{
    'Projector Left',
    'Projector Right',
    'Lectern Mon L',
    'Lectern Mon R',
    'Monitor 1',//5
    'Monitor 2',
    'Monitor 3',
    'Monitor 4',
    'Monitor 5', //9
    'Monitor 6',
    'Not Used',
    'Not Used',
    'SMP Content In',//13
    'SMP  Camera In',
    'AV Bridge',
    'Not Used', //16
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used', //27
    'Not Used', //28
    'Not Used', //29
    'Not Used', //30
    'Not Used', //31
    'Not Used' //32
}
VOLATILE CHAR nDgxAudioOutName[8][31] =
{
    'Audio Mix Out',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used', //5
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
    dvVIDEOIN_16,
    dvVIDEOIN_17,
    dvVIDEOIN_18,
    dvVIDEOIN_19,
    dvVIDEOIN_20,
    dvVIDEOIN_21,
    dvVIDEOIN_22,
    dvVIDEOIN_23,
    dvVIDEOIN_24,
    dvVIDEOIN_25,
    dvVIDEOIN_26,
    dvVIDEOIN_27,
    dvVIDEOIN_28,
    dvVIDEOIN_29,
    dvVIDEOIN_30,
    dvVIDEOIN_31,
    dvVIDEOIN_32
}
VOLATILE DEV dcDGXAudioSlots[] =
{
    dvAUDIOOUT_33,
    dvAUDIOOUT_34,
    dvAUDIOOUT_35,
    dvAUDIOOUT_36,
    dvAUDIOOUT_37,
    dvAUDIOOUT_38,
    dvAUDIOOUT_39,
    dvAUDIOOUT_40
}
VOLATILE DEV dcDisplays[] =
{
    vdvDisplay_One,
    vdvDisplay_Two,
    vdvDisplay_Three,
    vdvDisplay_Four,
    vdvDisplay_Five,
    vdvDisplay_Six
}
VOLATILE CHAR nTVDisplayText[6][25] =
{
    'Television Controls #1',
    'Television Controls #2',
    'Television Controls #3',
    'Television Controls #4',
    'Television Controls #5',
    'Television Controls #6'
}
VOLATILE INTEGER nTVButtons[] =
{
    BTN_TV_SINGLE_MERSIVE,
    BTN_TV_SINGLE_BYOD,
    BTN_TV_SINGLE_FOLLOW
}

#INCLUDE 'Vaddio_Connect'
#INCLUDE 'Extron_Recorder'
#INCLUDE 'Biamp_Tesira'

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main, BTN_PWR_OFF_L])
([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_CAMERA_REAR_L])

([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main, BTN_PWR_OFF_R])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_CAMERA_REAR_R])

([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_MERSIVE])

([dvTP_Main, BTN_TVS_ALL_OFF],[dvTP_Main, BTN_TVS_ALL_ON])
([dvTP_Main, BTN_TVS_ALL_MERSIVE]..[dvTP_Main, BTN_TVS_ALL_CAMERA])
([dvTP_Main, BTN_TV_ACTIVE_1]..[dvTP_Main, BTN_TV_ACTIVE_6])
([dvTP_Main, BTN_TV_SINGLE_MERSIVE]..[dvTP_Main, BTN_TV_SINGLE_FOLLOW])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnDoRelays(INTEGER cRelay)
{
    PULSE [dvRelays, cRelay]
}
DEFINE_FUNCTION fnDGXPull()
{
    WAIT 10 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_LECTERN_MON_LEFT)" 
    WAIT 30 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_LECTERN_MON_RIGHT)" 
    WAIT 50 SEND_COMMAND dvDGX, "'?INPUT-AUDIO,',ITOA(AUDIO_OUT_MAIN)" 
}
DEFINE_FUNCTION fnLoadDGXVideoLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXVideoSlots); cLoop++ )
    {
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDIN_NAME-',nDgxInputNames[cLoop]"
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDOUT_NAME-',nDgxOutputName[cLoop]"
    }
}
DEFINE_FUNCTION fnLoadDGXAudioLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXAudioSlots); cLoop++ )
    {
	SEND_COMMAND dcDGXAudioSlots[cLoop], "'AUDOUT_NAME-',nDgxAudioOutName[cLoop]"
    }
}
DEFINE_CALL 'DGX NAMING'
{
    fnDGXPull()
    
    WAIT 120
    {
	fnLoadDGXVideoLabels()
    }
    WAIT 180
    {
	fnLoadDGXAudioLabels()
    }
}
DEFINE_FUNCTION fnPowerDisplays(INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    PULSE [vdvProjector_Left, POWER_ON]
	    fnDoRelays(LEFT_DN)
	}
	CASE BTN_PWR_OFF_L :
	{
	    PULSE [vdvProjector_Left, POWER_OFF]
	    WAIT 30
	    {
		fnDoRelays(LEFT_UP)
	    }
	}
	CASE BTN_PWR_ON_R :
	{
		    PULSE [vdvProjector_Right, POWER_ON]
	    fnDoRelays(RIGHT_DN)
	}
	CASE BTN_PWR_OFF_R :
	{
	    PULSE [vdvProjector_Right, POWER_OFF]
	    WAIT 30
	    {
		fnDoRelays(RIGHT_UP)
	    }
	}
    }
}
DEFINE_FUNCTION fnRouteVideoLeft(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_LEFT),',',ITOA(OUT_LECTERN_MON_LEFT),',',ITOA(OUT_REC_CONTENT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	CASE VIDEO_MERSIVE_1 :
	CASE VIDEO_MERSIVE_2 :
	CASE VIDEO_MERSIVE_3 :
	CASE VIDEO_MERSIVE_4 :
	CASE VIDEO_MERSIVE_5 :
	CASE VIDEO_MERSIVE_6 :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_CAMERA_REAR :
	{
	    fnDGXRouteCamera(VIDEO_CAMERA_REAR)
	}
    }
}
DEFINE_FUNCTION fnRouteVideoRight(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_RIGHT),',',ITOA(OUT_LECTERN_MON_RIGHT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	CASE VIDEO_MERSIVE_1 :
	CASE VIDEO_MERSIVE_2 :
	CASE VIDEO_MERSIVE_3 :
	CASE VIDEO_MERSIVE_4 :
	CASE VIDEO_MERSIVE_5 :
	CASe VIDEO_MERSIVE_6 :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_CAMERA_REAR :
	{
	    fnDGXRouteCamera(VIDEO_CAMERA_REAR)
	}
    }
}
DEFINE_FUNCTION fnRouteVideoPreview(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_LECTERN_MON_RIGHT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PREVIEW_EXT]
	CASE VIDEO_RECORD : ON [vdvTP_Main, BTN_PREVIEW_REC]
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
DEFINE_FUNCTION fnSetDisplaysON()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=0; cLoop<=MAX_LENGTH_ARRAY(dcDisplays); cLoop++)
    {
	PULSE [dcDisplays[cLoop], POWER_ON]
    }
}
DEFINE_FUNCTION fnSetDisplaysOFF()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=0; cLoop<=MAX_LENGTH_ARRAY(dcDisplays); cLoop++)
    {
	PULSE [dcDisplays[cLoop], POWER_OFF]
    }
}
DEFINE_FUNCTION fnSetDisplaysHDMI()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=0; cLoop<=MAX_LENGTH_ARRAY(dcDisplays); cLoop++)
    {
	SEND_COMMAND dcDisplays[cLoop], "'INPUT-HDMI,1'"
    }
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = TIME_REBOOT)
    {
	REBOOT (dvMaster)
    }
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = TIME_KILL)
    {
	IF (([vdvProjector_Left, POWER]) || ([vdvProjector_Right, POWER]))
	{
	    fnPowerDisplays(BTN_PWR_OFF_L)
	    fnPowerDisplays(BTN_PWR_OFF_R)
	    
	    WAIT ONE_SECOND
	    {
		fnSetDisplaysOFF()
	    }
	}
    }
}
DEFINE_FUNCTION fnSetDGXRouteTV(INTEGER cIn, INTEGER cOut)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(cOut)" 
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

WAIT 150
{
    TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    TIMELINE_CREATE (TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    
    ON [vdvProjector_Left, POWER]
    ON [vdvProjector_Right, POWER]
    ON [vdvDisplay_One, POWER]
    ON [vdvDisplay_Two, POWER]
    ON [vdvDisplay_Three, POWER]
    ON [vdvDisplay_Four, POWER]
    ON [vdvDisplay_Five, POWER]
    ON [vdvDisplay_Six, POWER]
}

DEFINE_MODULE 'Sony_FHZ700L' PROJMODLEFT(vdvProjector_Left, dvProjector_Left);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODRIGHT(vdvProjector_Right, dvProjector_Right);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODONE(vdvDisplay_One, dvDisplay_One);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODTWO(vdvDisplay_Two, dvDisplay_Two);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODTHREE(vdvDisplay_Three, dvDisplay_Three);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODFOUR(vdvDisplay_Four, dvDisplay_Four);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODFIVE(vdvDisplay_Five, dvDisplay_Five);
DEFINE_MODULE 'Sony_FWD65X750D' TVMODSIX(vdvDisplay_Six, dvDisplay_Six);

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
BUTTON_EVENT [vdvTP_Main, BTN_TVS_ALL_OFF]
BUTTON_EVENT [vdvTP_Main, BTN_TVS_ALL_ON]
BUTTON_EVENT [vdvTP_Main, BTN_TVS_ALL_MERSIVE]
BUTTON_EVENT [vdvTP_Main, BTN_TVS_ALL_BYOD]
BUTTON_EVENT [vdvTP_Main, BTN_TVS_ALL_CAMERA]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_TVS_ALL_OFF :
	    {
		ON [vdvTP_Main, BTN_TVS_ALL_OFF]
		fnSetDisplaysHDMI()
		    WAIT ONE_SECOND
		    {
			fnSetDisplaysOFF()
		    }
	    }
	    CASE BTN_TVS_ALL_ON :
	    {
		ON [vdvTP_Main, BTN_TVS_ALL_ON]
		fnSetDisplaysON()
		WAIT 10 fnSetDGXRouteTV(nSource_Left, OUT_DISPLAY_1)
		WAIT 20 fnSetDGXRouteTV(nSource_Left, OUT_DISPLAY_2)
		WAIT 30 fnSetDGXRouteTV(nSource_Left, OUT_DISPLAY_3)
		WAIT 40 fnSetDGXRouteTV(nSource_Left, OUT_DISPLAY_4)
		WAIT 50 fnSetDGXRouteTV(nSource_Left, OUT_DISPLAY_5)
		WAIT 60 fnSetDGXRouteTV(nSource_Left, OUT_DISPLAY_6)
	    }
	    CASE BTN_TVS_ALL_MERSIVE :
	    {
		ON [vdvTP_Main, BTN_TVS_ALL_MERSIVE]
		WAIT 10 fnSetDGXRouteTV(VIDEO_MERSIVE_1, OUT_DISPLAY_1)
		WAIT 20 fnSetDGXRouteTV(VIDEO_MERSIVE_2, OUT_DISPLAY_2)
		WAIT 30 fnSetDGXRouteTV(VIDEO_MERSIVE_3, OUT_DISPLAY_3)
		WAIT 40 fnSetDGXRouteTV(VIDEO_MERSIVE_4, OUT_DISPLAY_4)
		WAIT 50 fnSetDGXRouteTV(VIDEO_MERSIVE_5, OUT_DISPLAY_5)
		WAIT 60 fnSetDGXRouteTV(VIDEO_MERSIVE_6, OUT_DISPLAY_6)
	    }
	    CASE BTN_TVS_ALL_BYOD :
	    {
		ON [vdvTP_Main, BTN_TVS_ALL_BYOD]
    		WAIT 10 fnSetDGXRouteTV(VIDEO_BYOD_1, OUT_DISPLAY_1)
		WAIT 20 fnSetDGXRouteTV(VIDEO_BYOD_2, OUT_DISPLAY_2)
		WAIT 30 fnSetDGXRouteTV(VIDEO_BYOD_3, OUT_DISPLAY_3)
		WAIT 40 fnSetDGXRouteTV(VIDEO_BYOD_4, OUT_DISPLAY_4)
		WAIT 50 fnSetDGXRouteTV(VIDEO_BYOD_5, OUT_DISPLAY_5)
		WAIT 60 fnSetDGXRouteTV(VIDEO_BYOD_6, OUT_DISPLAY_6)
	    }
	    CASE BTN_TVS_ALL_CAMERA :
	    {
		ON [vdvTP_Main, BTN_TVS_ALL_CAMERA]
		fnDGXRouteCamera(VIDEO_CAMERA_REAR)
		
    		WAIT 10 fnSetDGXRouteTV(VIDEO_CAMERA_REAR, OUT_DISPLAY_1)
		WAIT 20 fnSetDGXRouteTV(VIDEO_CAMERA_REAR, OUT_DISPLAY_2)
		WAIT 30 fnSetDGXRouteTV(VIDEO_CAMERA_REAR, OUT_DISPLAY_3)
		WAIT 40 fnSetDGXRouteTV(VIDEO_CAMERA_REAR, OUT_DISPLAY_4)
		WAIT 50 fnSetDGXRouteTV(VIDEO_CAMERA_REAR, OUT_DISPLAY_5)
		WAIT 60 fnSetDGXRouteTV(VIDEO_CAMERA_REAR, OUT_DISPLAY_6)
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_TV_ACTIVE_1]
BUTTON_EVENT [vdvTP_Main, BTN_TV_ACTIVE_2]
BUTTON_EVENT [vdvTP_Main, BTN_TV_ACTIVE_3]
BUTTON_EVENT [vdvTP_Main, BTN_TV_ACTIVE_4]
BUTTON_EVENT [vdvTP_Main, BTN_TV_ACTIVE_5]
BUTTON_EVENT [vdvTP_Main, BTN_TV_ACTIVE_6] //Set Active Display...
{
    PUSH :
    {
	ON [vdvTP_Main, BUTTON.INPUT.CHANNEL]
	//Change Text on Page!
	
	
	TOTAL_OFF [vdvTP_Main, nTVButtons] //Reset Feedback..
	
	SELECT
	{
	    //Track /Reload Current Feedback...
	    ACTIVE ([vdvTP_Main, BTN_TV_ACTIVE_1]):
	    {
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_TV),',0,',nTVDisplayText[1]"
		[vdvTP_Main, BTN_TV_SINGLE_PWR] = nDisplayPWR_1
		[vdvTP_Main, BTN_ACTIVE_TV_ONLINE] = nDisplayOnline_1
	    }
	    ACTIVE ([vdvTP_Main, BTN_TV_ACTIVE_2]):
	    {
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_TV),',0,',nTVDisplayText[2]"
		[vdvTP_Main, BTN_TV_SINGLE_PWR] = nDisplayPWR_2
		[vdvTP_Main, BTN_ACTIVE_TV_ONLINE] = nDisplayOnline_2
	    }
	    ACTIVE ([vdvTP_Main, BTN_TV_ACTIVE_3]):
	    {
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_TV),',0,',nTVDisplayText[3]"
		[vdvTP_Main, BTN_TV_SINGLE_PWR] = nDisplayPWR_3
		[vdvTP_Main, BTN_ACTIVE_TV_ONLINE] = nDisplayOnline_3
	    }
	    ACTIVE ([vdvTP_Main, BTN_TV_ACTIVE_4]):
	    {
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_TV),',0,',nTVDisplayText[4]"
		[vdvTP_Main, BTN_TV_SINGLE_PWR] = nDisplayPWR_4
		[vdvTP_Main, BTN_ACTIVE_TV_ONLINE] = nDisplayOnline_4
	    }
	    ACTIVE ([vdvTP_Main, BTN_TV_ACTIVE_5]):
	    {
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_TV),',0,',nTVDisplayText[5]"
		[vdvTP_Main, BTN_TV_SINGLE_PWR] = nDisplayPWR_5
		[vdvTP_Main, BTN_ACTIVE_TV_ONLINE] = nDisplayOnline_5
	    }
	    ACTIVE ([vdvTP_Main, BTN_TV_ACTIVE_6]):
	    {
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_TV),',0,',nTVDisplayText[6]"
		[vdvTP_Main, BTN_TV_SINGLE_PWR] = nDisplayPWR_6
		[vdvTP_Main, BTN_ACTIVE_TV_ONLINE] = nDisplayOnline_6
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_TV_SINGLE_PWR]
BUTTON_EVENT [vdvTP_Main, BTN_TV_SINGLE_MERSIVE]
BUTTON_EVENT [vdvTP_Main, BTN_TV_SINGLE_BYOD]
BUTTON_EVENT [vdvTP_Main, BTN_TV_SINGLE_FOLLOW] //Single TV Controls
{
    PUSH :
    {
	//ON [vdvTP_Main, BUTTON.INPUT.CHANNEL] //Flag On...
	
	SELECT
	{
	    ACTIVE ([dvTP_Main, BTN_TV_ACTIVE_1]) : 
	    {
		SWITCH (BUTTON.INPUT.CHANNEL)
		{
		    CASE BTN_TV_SINGLE_PWR :
		    {
			IF (![vdvDisplay_One, POWER])
			{
			    PULSE [vdvDisplay_One, POWER_ON]
			    ON [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
			ELSE
			{
			    PULSE [vdvDisplay_One, POWER_OFF]
			    OFF [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
		    }
		    CASE BTN_TV_SINGLE_MERSIVE :  
		    {
			fnSetDGXRouteTV(VIDEO_MERSIVE_1,OUT_DISPLAY_1)
			ON [vdvTP_Main, BTN_TV_SINGLE_MERSIVE]
		    }
		    CASE BTN_TV_SINGLE_BYOD : 
		    {
			fnSetDGXRouteTV(VIDEO_BYOD_1,OUT_DISPLAY_1)
			ON [vdvTP_Main, BTN_TV_SINGLE_BYOD]
		    }
		    CASE BTN_TV_SINGLE_FOLLOW : 
		    {
			fnSetDGXRouteTV(nSource_Left,OUT_DISPLAY_1)
			ON [vdvTP_Main, BTN_TV_SINGLE_FOLLOW]
		    }
		}
	    }
	    ACTIVE ([dvTP_Main, BTN_TV_ACTIVE_2]) :
	    {
		SWITCH (BUTTON.INPUT.CHANNEL)
		{
		    CASE BTN_TV_SINGLE_PWR :
		    {
			IF (![vdvDisplay_Two, POWER] )
			{
			    PULSE [vdvDisplay_Two, POWER_ON]
			    ON [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
			ELSE
			{
			    PULSE [vdvDisplay_Two, POWER_OFF]
			    OFF [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
		    }
		    CASE BTN_TV_SINGLE_MERSIVE :  
		    {
			fnSetDGXRouteTV(VIDEO_MERSIVE_2,OUT_DISPLAY_2)
			ON [vdvTP_Main, BTN_TV_SINGLE_MERSIVE]
		    }
		    CASE BTN_TV_SINGLE_BYOD : 
		    {
			fnSetDGXRouteTV(VIDEO_BYOD_2,OUT_DISPLAY_2)
			ON [vdvTP_Main, BTN_TV_SINGLE_BYOD]
		    }
		    CASE BTN_TV_SINGLE_FOLLOW : 
		    {
			fnSetDGXRouteTV(nSource_Left,OUT_DISPLAY_2)
			ON [vdvTP_Main, BTN_TV_SINGLE_FOLLOW]
		    }
		}
	    }
	    ACTIVE ([dvTP_Main, BTN_TV_ACTIVE_3]) :
	    {
		SWITCH (BUTTON.INPUT.CHANNEL)
		{
		    CASE BTN_TV_SINGLE_PWR :
		    {
			IF (![vdvDisplay_Three, POWER] )
			{
			    PULSE [vdvDisplay_Three, POWER_ON]
			    ON [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
			ELSE
			{
			    PULSE [vdvDisplay_Three, POWER_OFF]
			    OFF [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
		    }
		    CASE BTN_TV_SINGLE_MERSIVE :  
		    {
			fnSetDGXRouteTV(VIDEO_MERSIVE_3,OUT_DISPLAY_3)
			ON [vdvTP_Main, BTN_TV_SINGLE_MERSIVE]
		    }
		    CASE BTN_TV_SINGLE_BYOD : 
		    {
			fnSetDGXRouteTV(VIDEO_BYOD_3,OUT_DISPLAY_3)
			ON [vdvTP_Main, BTN_TV_SINGLE_BYOD]
		    }
		    CASE BTN_TV_SINGLE_FOLLOW : 
		    {
			fnSetDGXRouteTV(nSource_Left,OUT_DISPLAY_3)
			ON [vdvTP_Main, BTN_TV_SINGLE_FOLLOW]
		    }
		}
	    }
	    ACTIVE ([dvTP_Main, BTN_TV_ACTIVE_4]) :
	    {
		SWITCH (BUTTON.INPUT.CHANNEL)
		{
		    CASE BTN_TV_SINGLE_PWR :
		    {
			IF (![vdvDisplay_Four, POWER] )
			{
			    PULSE [vdvDisplay_Four, POWER_ON]
			    ON [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
			ELSE
			{
			    PULSE [vdvDisplay_Four, POWER_OFF]
			    OFF [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
		    }
		    CASE BTN_TV_SINGLE_MERSIVE :  
		    {
			fnSetDGXRouteTV(VIDEO_MERSIVE_4,OUT_DISPLAY_4)
			ON [vdvTP_Main, BTN_TV_SINGLE_MERSIVE]
		    }
		    CASE BTN_TV_SINGLE_BYOD : 
		    {
			fnSetDGXRouteTV(VIDEO_BYOD_4,OUT_DISPLAY_4)
			ON [vdvTP_Main, BTN_TV_SINGLE_BYOD]
		    }
		    CASE BTN_TV_SINGLE_FOLLOW : 
		    {
			fnSetDGXRouteTV(nSource_Left,OUT_DISPLAY_4)
			ON [vdvTP_Main, BTN_TV_SINGLE_FOLLOW]
		    }
		}
	    }
	    ACTIVE ([dvTP_Main, BTN_TV_ACTIVE_5]) :
	    {
		SWITCH (BUTTON.INPUT.CHANNEL)
		{
		    CASE BTN_TV_SINGLE_PWR :
		    {
			IF (![vdvDisplay_Five, POWER] )
			{
			    PULSE [vdvDisplay_Five, POWER_ON]
			    ON [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
			ELSE
			{
			    PULSE [vdvDisplay_Five, POWER_OFF]
			    OFF [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
		    }
		    CASE BTN_TV_SINGLE_MERSIVE :  
		    {
			fnSetDGXRouteTV(VIDEO_MERSIVE_5,OUT_DISPLAY_5)
			ON [vdvTP_Main, BTN_TV_SINGLE_MERSIVE]
		    }
		    CASE BTN_TV_SINGLE_BYOD : 
		    {
			fnSetDGXRouteTV(VIDEO_BYOD_5,OUT_DISPLAY_5)
			ON [vdvTP_Main, BTN_TV_SINGLE_BYOD]
		    }
		    CASE BTN_TV_SINGLE_FOLLOW : 
		    {
			fnSetDGXRouteTV(nSource_Left,OUT_DISPLAY_5)
			ON [vdvTP_Main, BTN_TV_SINGLE_FOLLOW]
		    }
		}
	    }
	    ACTIVE ([dvTP_Main, BTN_TV_ACTIVE_6]) :
	    {
		SWITCH (BUTTON.INPUT.CHANNEL)
		{
		    CASE BTN_TV_SINGLE_PWR :
		    {
			IF (![vdvDisplay_Six, POWER] )
			{
			    PULSE [vdvDisplay_Six, POWER_ON]
			    ON [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
			ELSE
			{
			    PULSE [vdvDisplay_Six, POWER_OFF]
			    OFF [vdvTP_Main, BTN_TV_SINGLE_PWR]
			}
		    }
		    CASE BTN_TV_SINGLE_MERSIVE :  
		    {
			fnSetDGXRouteTV(VIDEO_MERSIVE_6,OUT_DISPLAY_6)
			ON [vdvTP_Main, BTN_TV_SINGLE_MERSIVE]
		    }
		    CASE BTN_TV_SINGLE_BYOD : 
		    {
			fnSetDGXRouteTV(VIDEO_BYOD_6,OUT_DISPLAY_6)
			ON [vdvTP_Main, BTN_TV_SINGLE_BYOD]
		    }
		    CASE BTN_TV_SINGLE_FOLLOW : 
		    {
			fnSetDGXRouteTV(nSource_Left,OUT_DISPLAY_6)
			ON [vdvTP_Main, BTN_TV_SINGLE_FOLLOW]
		    }
		}
	    }
	}
    }
}

DEFINE_EVENT

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_Left, ON_LINE]
CHANNEL_EVENT [vdvProjector_Left, WARMING]
CHANNEL_EVENT [vdvProjector_Left, COOLING]
CHANNEL_EVENT [vdvProjector_Left, POWER]
{
    ON :
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
    OFF :
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
CHANNEL_EVENT [vdvProjector_Right, ON_LINE]
CHANNEL_EVENT [vdvProjector_Right, WARMING]
CHANNEL_EVENT [vdvProjector_Right, COOLING]
CHANNEL_EVENT [vdvProjector_Right, POWER]
{
    ON :
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
    OFF :
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
CHANNEL_EVENT [vdvDisplay_One, ON_LINE]
CHANNEL_EVENT [vdvDisplay_One, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : ON [nDisplayOnline_1]
	    CASE POWER : ON [nDisplayPWR_1]
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : OFF [nDisplayOnline_1]
	    CASE POWER : OFF [nDisplayPWR_1]
	}
    }
}
CHANNEL_EVENT [vdvDisplay_Two, ON_LINE]
CHANNEL_EVENT [vdvDisplay_Two, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : ON [nDisplayOnline_2]
	    CASE POWER : ON [nDisplayPWR_2]
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : OFF [nDisplayOnline_2]
	    CASE POWER : OFF [nDisplayPWR_2]
	}
    }
}
CHANNEL_EVENT [vdvDisplay_Three, ON_LINE]
CHANNEL_EVENT [vdvDisplay_Three, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : ON [nDisplayOnline_3]
	    CASE POWER : ON [nDisplayPWR_3]
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : OFF [nDisplayOnline_3]
	    CASE POWER : OFF [nDisplayPWR_3]
	}
    }
}
CHANNEL_EVENT [vdvDisplay_Four, ON_LINE]
CHANNEL_EVENT [vdvDisplay_Four, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : ON [nDisplayOnline_4]
	    CASE POWER : ON [nDisplayPWR_4]
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : OFF [nDisplayOnline_4]
	    CASE POWER : OFF [nDisplayPWR_4]
	}
    }
}
CHANNEL_EVENT [vdvDisplay_Five, ON_LINE]
CHANNEL_EVENT [vdvDisplay_Five, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : ON [nDisplayOnline_5]
	    CASE POWER : ON [nDisplayPWR_5]
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : OFF [nDisplayOnline_5]
	    CASE POWER : OFF [nDisplayPWR_5]
	}
    }
}
CHANNEL_EVENT [vdvDisplay_Six, ON_LINE]
CHANNEL_EVENT [vdvDisplay_Six, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : ON [nDisplayOnline_6]
	    CASE POWER : ON [nDisplayPWR_6]
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE : OFF [nDisplayOnline_6]
	    CASE POWER : OFF [nDisplayPWR_6]
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Main]
{
    ONLINE :
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
	WAIT 120
	{
	    CALL 'DGX NAMING'
	}
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cAudio[5] //Potential... 11O33
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
		    
		    IF (FIND_STRING(cMsg,"'O',ITOA(OUT_LECTERN_MON_LEFT)",1))
		    {
			cLeftTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    
			nSource_Left = ATOI(cLeftTmp)
			
			SWITCH (nSource_Left)
			{
			    CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_L]
			    CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_L]
			    CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_L]
			    CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_L]
			    CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_L]
			    CASE VIDEO_MERSIVE_1 : ON [vdvTP_Main, BTN_MERSIVE_TV1_L]
			    CASE VIDEO_MERSIVE_2 : ON [vdvTP_Main, BTN_MERSIVE_TV2_L]
			    CASE VIDEO_MERSIVE_3 : ON [vdvTP_Main, BTN_MERSIVE_TV3_L]
			    CASE VIDEO_MERSIVE_4 : ON [vdvTP_Main, BTN_MERSIVE_TV4_L]
			    CASE VIDEO_MERSIVE_5 : ON [vdvTP_Main, BTN_MERSIVE_TV5_L]
			    CASE VIDEO_MERSIVE_6 : ON [vdvTP_Main, BTN_MERSIVE_TV6_L]
			    CASE VIDEO_BYOD_1 : ON [vdvTP_Main, BTN_BYOD_TV1_L]
			    CASE VIDEO_BYOD_2 : ON [vdvTP_Main, BTN_BYOD_TV2_L]
			    CASE VIDEO_BYOD_3 : ON [vdvTP_Main, BTN_BYOD_TV3_L]
			    CASE VIDEO_BYOD_4 : ON [vdvTP_Main, BTN_BYOD_TV4_L]
			    CASE VIDEO_BYOD_5 : ON [vdvTP_Main, BTN_BYOD_TV5_L]
			    CASE VIDEO_BYOD_6 : ON [vdvTP_Main, BTN_BYOD_TV6_L]
			    CASE VIDEO_CAMERA_REAR : ON [vdvTP_Main, BTN_CAMERA_REAR_L]
			}
		    }
		    IF (FIND_STRING(cMsg,"'O',ITOA(OUT_LECTERN_MON_RIGHT)",1))
		    {
			cRightTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    
			nSource_Right = ATOI(cRightTmp)
			
			SWITCH (nSource_Right)
			{
			    CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_R]
			    CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_R]
			    CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_R]
			    CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_R]
			    CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_R]
			    CASE VIDEO_MERSIVE_1 : ON [vdvTP_Main, BTN_MERSIVE_TV1_R]
			    CASE VIDEO_MERSIVE_2 : ON [vdvTP_Main, BTN_MERSIVE_TV2_R]
			    CASE VIDEO_MERSIVE_3 : ON [vdvTP_Main, BTN_MERSIVE_TV3_R]
			    CASE VIDEO_MERSIVE_4 : ON [vdvTP_Main, BTN_MERSIVE_TV4_R]
			    CASE VIDEO_MERSIVE_5 : ON [vdvTP_Main, BTN_MERSIVE_TV5_R]
			    CASE VIDEO_MERSIVE_6 : ON [vdvTP_Main, BTN_MERSIVE_TV6_R]
			    CASE VIDEO_BYOD_1 : ON [vdvTP_Main, BTN_BYOD_TV1_R]
			    CASE VIDEO_BYOD_2 : ON [vdvTP_Main, BTN_BYOD_TV2_R]
			    CASE VIDEO_BYOD_3 : ON [vdvTP_Main, BTN_BYOD_TV3_R]
			    CASE VIDEO_BYOD_4 : ON [vdvTP_Main, BTN_BYOD_TV4_R]
			    CASE VIDEO_BYOD_5 : ON [vdvTP_Main, BTN_BYOD_TV5_R]
			    CASE VIDEO_BYOD_6 : ON [vdvTP_Main, BTN_BYOD_TV6_R]
			    CASE VIDEO_CAMERA_REAR : ON [vdvTP_Main, BTN_CAMERA_REAR_R]
			}
		    }
		}
	    //Audio Feedback...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LAUDIOI'",1)):  //Output 33 - so subtract 3
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LAUDIOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(AUDIO_OUT_MAIN)",1))
		{
		    cAudio = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-3)	
		    nSource_Audio = ATOI(cAudio)
		    
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
}
DATA_EVENT [dvProjector_dxLeft] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxLeft, "'?VIDOUT_MUTE'"
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
DATA_EVENT [dvProjector_dxRight] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxRight, "'?VIDOUT_MUTE'"
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
    iFlash = !iFlash
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnReboot()
    fnKill()
    
    WAIT ONE_MINUTE
    {
	    SEND_COMMAND dvProjector_dxLeft, "'?VIDOUT_MUTE'"
	    WAIT ONE_SECOND
	    {
		SEND_COMMAND dvProjector_dxRight, "'?VIDOUT_MUTE'"
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



