PROGRAM_NAME='Master'
(***********************************************************)
(*  FILE CREATED ON: 05/18/2017  AT: 06:30:24              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 08/30/2019  AT: 15:35:31        *)
(***********************************************************)
(* System Type : 

    NetLinx     
    Master Type [ NI-3200 ]
    Need to add code for Black Magic..

    *)
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

DGX_CONN =				8150 //System

dvMaster =					0:1:0
dvDGXMaster =				0:1:DGX_CONN
dvTP_Main =				10001:1:0 //330
dvTP_Main2 =				10002:1:0 //331

dvBlackMagic =			5001:5:0 //Black Magic (Smart VideoHub 20x20)
dvRS232_2 =				5001:2:0 //Tesira Top
dvRS232_3 =				5001:3:0 //Tesira Bottom (Main Connections)
dvRS232_4 =				5001:4:0 //Tesira DL
dvRS232_5 =				5001:5:0 //Extron SMP 301
dvRS232_6 =				5001:6:0 //Not Used
dvRS232_7 =				5001:7:0 //Not Used
dvRS232_8 =				5001:8:0 //Not used

dvRelays =					5001:21:0 //
dvIOs =						5001:22:0 //
dvRel8 =					5301:1:0 //For Rear Screens

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
dvVIDEOIN_10  = 			5002:10:DGX_CONN //Desktop Right
dvVIDEOIN_11 =			5002:11:DGX_CONN //DxLink TX (AAP Plate)
dvVIDEOIN_12 =			5002:12:DGX_CONN //Doc Cam
dvVIDEOIN_13 =			5002:13:DGX_CONN //Not Used
dvVIDEOIN_14 =			5002:14:DGX_CONN //Not Used
dvVIDEOIN_15 =			5002:15:DGX_CONN //Not Used
dvVIDEOIN_16 =			5002:16:DGX_CONN //Not Used
dvVIDEOIN_17 =				5002:17:DGX_CONN //Not Used
dvVIDEOIN_18 =				5002:18:DGX_CONN //Not Used
dvVIDEOIN_19 =				5002:19:DGX_CONN //Not Used
dvVIDEOIN_20 =				5002:20:DGX_CONN //Not Used


(**Room A **)
dvProjector_Front_330 =		46009:1:DGX_CONN //334
dvProjector_dxFront_330 =		46009:6:DGX_CONN

dvProjector_Side_330 =		46010:1:DGX_CONN
dvProjector_dxSide_330 =		46010:6:DGX_CONN

dvProjector_Rear_330 =		46011:1:DGX_CONN
dvProjector_dxRear_330 =		46011:6:DGX_CONN

vdvProjector_Front_330 =		35011:1:0
vdvProjector_Side_330 =		35012:1:0
vdvProjector_Rear_330 =		35013:1:0
								    
(**Room B 331 **)
dvProjector_Front_331 =		46013:1:DGX_CONN //
dvProjector_dxFront_331 =		46013:6:DGX_CONN

dvProjector_Side_331 =		46014:1:DGX_CONN
dvProjector_dxSide_331 =		46014:6:DGX_CONN

dvProjector_Rear_331 =		46015:1:DGX_CONN
dvProjector_dxRear_331 =		46015:6:DGX_CONN

vdvProjector_Front_331 =		35014:1:0
vdvProjector_Side_331 =		35015:1:0
vdvProjector_Rear_331 =		35016:1:0

//Define Touch Panel Type
#WARN 'Check correct Panel Type'
#DEFINE G4PANEL
//#DEFINE G5PANEL //Ex..MT-702, MT1002, MXT701

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Screen Relays...
UP_LEFT_330				= 1
DN_LEFT_330				= 2
UP_RIGHT_330				= 3 //330 HR 
DN_RIGHT_330			= 4 //330 HR
UP_REAR_330				= 5 //330 REAR
DN_REAR_330				= 6 //330 Rear

UP_LEFT_331				= 7 //331 Left
DN_LEFT_331				= 8 //331 Left

//REL 8 
UP_RIGHT_331				= 3 
DN_RIGHT_331			= 4 
UP_REAR_331				= 1 
DN_REAR_331				= 2 

//Common Feedback...
POWER_CYCLE				= 9
POWER_ON				= 27
POWER_OFF				= 28
WARMING					= 253
COOLING					= 254
ON_LINE					= 251
POWER					= 255
BLANK						= 211

//Offical DGX Routing Numbers...
IN_DESKTOP_330			= 1
IN_DESK_EXT_330			= 2
IN_EXTERNAL_330			= 3
IN_DOCCAM_330			= 4
IN_DESKTOP_331			= 5
IN_DESK_EXT_331			= 6
IN_EXTERNAL_331			= 8
IN_DOCCAM_331			= 7
IN_MERSIVE_330			= 9 
IN_MERSIVE_331			= 10 
IN_EXTRON_330			= 11 
IN_EXTRON_331			= 12 
IN_DL_1_330				= 13 //DL In Left
IN_DL_2_330				= 14 //DL In Right
IN_DL_3_330				= 15 //DL In Rear
IN_DL_1_331				= 17 //DL In 1
IN_DL_2_331				= 18 //DL In 2
IN_DL_3_331				= 19 //DL In 3

//DGX Outputs...
OUT_DL1_330				= 1
OUT_DL2_330				= 2
OUT_SMP_330				= 3
OUT_DL1_331				= 5
OUT_DL2_331				= 6
OUT_SMP_331				= 7
OUT_PROJLEFT_330		= 9
OUT_PROJRIGHT_330		= 10
OUT_PROJREAR_330		= 11

OUT_PROJLEFT_331		= 13
OUT_PROJRIGHT_331		= 14
OUT_PROJREAR_331 		= 15

OUT_MONLEFT_330		= 17
OUT_MONRIGHT_330		= 18
OUT_MONLEFT_331			= 19
OUT_MONRIGHT_331		= 20

AUDIO_OUT_330			= 4 //Due to Extract Card
AUDIO_OUT_331			= 8 //Due to Extract Card

SET_MUTE_ON				= 'ENABLE'
SET_MUTE_OFF			= 'DISABLE'

//TP Addresses
TXT_HELP					= 99
TXT_ROOM				= 100

ONE_SECOND				= 10
ONE_MINUTE				= 60 * ONE_SECOND
ONE_HOUR				= 600 * ONE_MINUTE
TIME_REBOOT				= '06:00:00'
TIME_KILL					= '22:00:00'

CR 								= 13 
LF 								= 10 
TL_FEEDBACK					= 1 
TL_FLASH 						= 2

BTN_TECH_PAGE				= 999
BTN_REBOOT_DGX				= 888

BTN_MODE_SEPARATE			=    21
BTN_MODE_MASTER_330		=    22 //330 Master
BTN_MODE_MASTER_331		=    23 //331 Master
BTN_MODE_BREAK				=    24 //Break / stop)
BTN_MODE_SHUT_330		=    25 //Shutdown 330
BTN_MODE_SHUT_331		=    26  //Shutdown 331

BTN_PWR_ON_L				= 1
BTN_PWR_OFF_L				= 2
BTN_MUTE_PROJ_L			= 3
BTN_SCREEN_UP_L				= 4
BTN_SCREEN_DN_L			= 5

BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L					= 12
BTN_EXTERNAL_L				= 13
BTN_DOC_CAM_L				= 14
BTN_MERSIVE_L				= 15

BTN_PWR_ON_R				= 101
BTN_PWR_OFF_R				= 102
BTN_MUTE_PROJ_R			= 103
BTN_SCREEN_UP_R			= 104
BTN_SCREEN_DN_R			= 105

BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R					= 112
BTN_EXTERNAL_R				= 113
BTN_DOC_CAM_R				= 114
BTN_MERSIVE_R				= 115

BTN_PREVIEW_EXT				= 116
BTN_PREVIEW_REC				= 117

BTN_PWR_ON_REAR			= 201
BTN_PWR_OFF_REAR			= 202
BTN_MUTE_PROJ_REAR		= 203
BTN_SCREEN_UP_REAR		= 204
BTN_SCREEN_DN_REAR		= 205
BTN_FOLLOW_LEFT			= 211 //Rear Screen
BTN_FOLLOW_NOTES			= 212 //Rear Screen

BTN_AUDIO_PC				= 511
BTN_AUDIO_EXTERNAL			= 513
BTN_AUDIO_MERSIVE			= 515

BTN_ONLINE_L					= 601
BTN_WARMING_L				= 602
BTN_COOLING_L				= 603

BTN_ONLINE_R				= 611
BTN_WARMING_R				= 612
BTN_COOLING_R				= 613

BTN_ONLINE_REAR				= 621

BTN_SET_NUMBER					= 1500
BTN_SET_LOCATION				= 1501
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
PERSISTENT CHAR nRoom_Location330[30]
PERSISTENT CHAR nRoom_Location331[30]

VOLATILE INTEGER iFlash
VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000}

//Room 330
VOLATILE INTEGER nSource_Left_330  
VOLATILE INTEGER nSource_Right_330
VOLATILE INTEGER nSource_Audio_330
VOLATILE INTEGER nFollow_Rear_330 //Rear Tracking
VOLATILE INTEGER nMasterMode330

VOLATILE INTEGER nMuteProjLeft_330
VOLATILE INTEGER nMuteProjRight_330
VOLATILE INTEGER nMuteProjRear_330

//Room 331
VOLATILE INTEGER nSource_Right_331  
VOLATILE INTEGER nSource_Left_331
VOLATILE INTEGER nSource_Audio_331
VOLATILE INTEGER nFollow_Rear_331 //Rear Tracking
VOLATILE INTEGER nMasterMode331

VOLATILE INTEGER nMuteProjLeft_331
VOLATILE INTEGER nMuteProjRight_331
VOLATILE INTEGER nMuteProjRear_331

VOLATILE INTEGER nTPOnline
VOLATILE INTEGER nDGXOnline
VOLATILE INTEGER nBootup_

VOLATILE DEV vdvTP_Main[] = {dvTP_MAIN, dvTP_Main2}

VOLATILE INTEGER nVideoSources330[] =
{
    IN_DESKTOP_330,
    IN_DESK_EXT_330,
    IN_EXTERNAL_330,
    IN_DOCCAM_330,
    IN_MERSIVE_330
}
VOLATILE INTEGER nVideoSources331[] =
{
    IN_DESKTOP_331,
    IN_DESK_EXT_331,
    IN_EXTERNAL_331,
    IN_DOCCAM_331,
    IN_MERSIVE_331
}
VOLATILE INTEGER nProjectorLeftVidBtns[] =
{
    BTN_PC_MAIN_L,
    BTN_PC_EXT_L,
    BTN_EXTERNAL_L,
    BTN_DOC_CAM_L,
    BTN_MERSIVE_L
}
VOLATILE INTEGER nProjectorRightVidBtns[] =
{
    BTN_PC_MAIN_R,
    BTN_PC_EXT_R,
    BTN_EXTERNAL_R,
    BTN_DOC_CAM_R,
    BTN_MERSIVE_R
}
VOLATILE CHAR nDgxInputNames[20][31] =
{
    'Desktop Main 330',
    'Desktop Ext 330',
    'Doc Cam 330',
    'VGA HDMI 330', //4
    'Desktop Main 331',
    'Desktop Ext 331',
    'Doc Cam 331',
    'VGA HDMI 331', //8
    'Solstice 330',
    'Solstice 331',
    'Extron SMP 330',
    'Extron SMP 331', //12
    'DL Feed1 330',
    'DL Feed2 330',
    'DL Feed3 330',
    'Not Used',//16
    'DL Feed1 331',
    'DL Feed2 331',
    'DL Feed3 331',
    'Not Used' //20
}
VOLATILE CHAR nDgxOutputNames[20][31] =
{
    '330 To DL 1',
    '330 DL 2',
    '330 Extron Rec',
    '330 Audio Extr', //4
    '331 To DL 1',
    '331 To DL 2',
    '331 Extron Rec',
    '331 Audio Extr', //8
    '330 Proj Left',
    '330 Proj Right',
    '330 Proj Rear',
    'Not Used', //12
    '331 Proj Left',
    '331 Proj Right',
    '331 Proj Rear',
    'Not Used', //16
    '330 Mon Left',
    '330 Mon Right',
    '331 Mon Right',
    '331 Mon Right' //20
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
    dvVIDEOIN_20 
}
VOLATILE DEV dcVirtual[] =
{
    vdvProjector_Front_330,
    vdvProjector_Side_330,
    vdvProjector_Rear_330,
    vdvProjector_Front_331,
    vdvProjector_Side_331,
    vdvProjector_Rear_331
}

#INCLUDE 'PanasonicCameras'
#INCLUDE 'Tesira_Phone2' 
#INCLUDE 'Extron_Recorder' //330
#INCLUDE 'Extron_Recorder331'
#INCLUDE 'DGX_Routing'
#INCLUDE 'Clock'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//330
([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main, BTN_PWR_OFF_L])
([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_MERSIVE_L])
([dvTP_Main, BTN_SCREEN_UP_L],[dvTP_Main, BTN_SCREEN_DN_L])

([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main, BTN_PWR_OFF_R])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_MERSIVE_R])
([dvTP_Main, BTN_SCREEN_UP_R],[dvTP_Main, BTN_SCREEN_DN_R])

([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_MERSIVE])

([dvTP_Main, BTN_PWR_ON_REAR],[dvTP_Main, BTN_PWR_OFF_REAR])
([dvTP_Main, BTN_SCREEN_UP_REAR],[dvTP_Main, BTN_SCREEN_DN_REAR])
([dvTP_Main, BTN_FOLLOW_LEFT],[dvTP_Main, BTN_FOLLOW_NOTES])

([dvTP_Main, BTN_PREVIEW_EXT],[dvTP_Main, BTN_PREVIEW_REC])

//331
([dvTP_Main2, BTN_PWR_ON_L],[dvTP_Main2, BTN_PWR_OFF_L])
([dvTP_Main2, BTN_PC_MAIN_L]..[dvTP_Main2, BTN_MERSIVE_L])
([dvTP_Main2, BTN_SCREEN_UP_L],[dvTP_Main2, BTN_SCREEN_DN_L])

([dvTP_Main2, BTN_PWR_ON_R],[dvTP_Main2, BTN_PWR_OFF_R])
([dvTP_Main2, BTN_PC_MAIN_R]..[dvTP_Main2, BTN_MERSIVE_R])
([dvTP_Main2, BTN_SCREEN_UP_R],[dvTP_Main2, BTN_SCREEN_DN_R])

([dvTP_Main2, BTN_AUDIO_PC]..[dvTP_Main2, BTN_AUDIO_MERSIVE])

([dvTP_Main2, BTN_PWR_ON_REAR],[dvTP_Main2, BTN_PWR_OFF_REAR])
([dvTP_Main2, BTN_SCREEN_UP_REAR],[dvTP_Main2, BTN_SCREEN_DN_REAR])
([dvTP_Main2, BTN_FOLLOW_LEFT],[dvTP_Main2, BTN_FOLLOW_NOTES])

([dvTP_Main2, BTN_PREVIEW_EXT],[dvTP_Main2, BTN_PREVIEW_REC])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnDGXPull()
{
    WAIT 10 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_PROJLEFT_330)" 
    WAIT 20 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_PROJRIGHT_330)" 
    //WAIT 30 SEND_COMMAND dvDGX, "'?INPUT-AUDIO,',ITOA(AUDIO_OUT_330)" 

    WAIT 40 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_PROJLEFT_331)" 
    WAIT 50 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_PROJRIGHT_331)" 
    //WAIT 60 SEND_COMMAND dvDGX, "'?INPUT-AUDIO,',ITOA(AUDIO_OUT_331)" 
}
DEFINE_FUNCTION fnLoadDGXVideoLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXVideoSlots); cLoop++)
    {
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDIN_NAME-',nDgxInputNames[cLoop]"
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDOUT_NAME-',nDgxOutputNames[cLoop]"
    }
}
DEFINE_CALL 'DGX NAMING'
{
    fnDGXPull()
    
    WAIT 150
    {
	fnLoadDGXVideoLabels()
    }
}
DEFINE_FUNCTION fnRelayDirection(DEV cDev, INTEGER cTrigger)
{
    PULSE [cDev, cTrigger]
}
DEFINE_FUNCTION fnRouteVideoLeft330(INTEGER cIn)
{ 
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_SMP_330),',',ITOA(OUT_PROJLEFT_330),',',ITOA(OUT_MONLEFT_330)"
    
    SWITCH (cIn)
    {
	CASE IN_DESKTOP_330 :
	CASE IN_DESK_EXT_330 :
	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(IN_DESKTOP_330),'O',ITOA(AUDIO_OUT_330)" //Use CI Due to Extract Card
	}
	CASE IN_EXTERNAL_330 :
	CASE IN_MERSIVE_330 :
    	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(cIn),'O',ITOA(AUDIO_OUT_330)" //Use "CI" Due to Extract Card
	}
    }
    IF (nFollow_Rear_330)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_330)"
    }
    IF (nMasterMode330)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJLEFT_331)"
    }
    IF ((nMasterMode330) && (nFollow_Rear_330))
    {
	WAIT 10
	{
	    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_331)"
	}
    }
    
    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL1_330)"
    }
}
DEFINE_FUNCTION fnRouteVideoRight330(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_330),',',ITOA(OUT_MONRIGHT_330)"
    
    SWITCH (cIn)
    {
	CASE IN_DESKTOP_330 :
	CASE IN_DESK_EXT_330 :
	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(IN_DESKTOP_330),'O',ITOA(AUDIO_OUT_330)" //Use CI Due to Extract Card
	}
	CASE IN_EXTERNAL_330 :
	CASE IN_MERSIVE_330 :
    	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(cIn),'O',ITOA(AUDIO_OUT_330)" //Use "CI" Due to Extract Card
	}
    }
    
    IF (nMasterMode330)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_331)"
    }
    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL2_330)"
    }
}
DEFINE_FUNCTION fnRouteVideoLeft331(INTEGER cIn)
{   
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_SMP_331),',',ITOA(OUT_PROJLEFT_331),',',ITOA(OUT_MONLEFT_331)"

    SWITCH (cIn)
    {
	CASE IN_DESKTOP_331 :
	CASE IN_DESK_EXT_331 :
	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(IN_DESKTOP_331),'O',ITOA(AUDIO_OUT_331)" //Use CI Due to Extract Card
	}
	CASE IN_EXTERNAL_331 :
	CASE IN_MERSIVE_331 :
    	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(cIn),'O',ITOA(AUDIO_OUT_331)" //Use "CI" Due to Extract Card
	}
    }
    IF (nFollow_Rear_331)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_331)"
    }
    IF (nMasterMode331)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJLEFT_330)"
    }
    IF ((nMasterMode331) && (nFollow_Rear_331))
    {
	WAIT 10
	{
	    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_330)"
	}
    }

    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL1_331)"
    }
}
DEFINE_FUNCTION fnRouteVideoRight331(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_331),',',ITOA(OUT_MONRIGHT_331)"
    
      SWITCH (cIn)
    {
	CASE IN_DESKTOP_331 :
	CASE IN_DESK_EXT_331 :
	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(IN_DESKTOP_331),'O',ITOA(AUDIO_OUT_331)" //Use CI Due to Extract Card
	}
	CASE IN_EXTERNAL_331 :
	CASE IN_MERSIVE_331 :
    	{
	    SEND_COMMAND dvDGX, "'CI',ITOA(cIn),'O',ITOA(AUDIO_OUT_331)" //Use "CI" Due to Extract Card
	}
    }  
    IF (nMasterMode331)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_330)"
    }
    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL2_331)"
    }
}
DEFINE_FUNCTION fnRouteVideoPreview330(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_MONRIGHT_330)"
    
    SWITCH (cIn)
    {
	CASE IN_DESK_EXT_330 : ON [dvTP_Main, BTN_PREVIEW_EXT]
	CASE IN_EXTRON_330 : ON [dvTP_Main, BTN_PREVIEW_REC]
    }
}
DEFINE_FUNCTION fnRouteVideoPreview331(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_MONRIGHT_331)"
    
    SWITCH (cIn)
    {
	CASE IN_DESK_EXT_331 : ON [dvTP_Main2, BTN_PREVIEW_EXT]
	CASE IN_EXTRON_331 : ON [dvTP_Main2, BTN_PREVIEW_REC]
    }
}
DEFINE_FUNCTION fnRouteVideoRear330(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_330)"
}
DEFINE_FUNCTION fnRouteVideoRear331(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_331)"
}
DEFINE_FUNCTION fnRouteVideoIO (INTEGER cIn, INTEGER cOut)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(cOut)"
}
DEFINE_FUNCTION fnPowerDisplays330(INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    PULSE [vdvProjector_Front_330, POWER_ON]
	    fnRelayDirection(dvRelays, DN_LEFT_330)
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Front_331, POWER_ON]
		fnRelayDirection(dvRelays, DN_LEFT_330)
	    }
	}
	CASE BTN_PWR_OFF_L :
	{
	    PULSE [vdvProjector_Front_330, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection (dvRelays, UP_LEFT_330)
	    }
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Front_331, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection (dvRelays, UP_LEFT_330)
		}
	    }
	}
	CASE BTN_PWR_ON_R :
	{
	    PULSE [vdvProjector_Side_330, POWER_ON]
	    fnRelayDirection (dvRelays, DN_RIGHT_330)
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Side_331, POWER_ON]
		    fnRelayDirection (dvRel8, DN_RIGHT_331)
	    }
	}
	CASE BTN_PWR_OFF_R :
	{
	    PULSE [vdvProjector_Side_330, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(dvRelays, UP_RIGHT_330)
	    }
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Side_331, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection (dvRel8, UP_RIGHT_331)
		}
	    }
	}
	CASE BTN_PWR_ON_REAR :
	{
	    PULSE [vdvProjector_Rear_330, POWER_ON]
	    fnRelayDirection(dvRel8, DN_REAR_330)
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Rear_331, POWER_ON]
		fnRelayDirection(dvRel8, DN_REAR_331)
	    }
	}
	CASE BTN_PWR_OFF_REAR :
	{
	    PULSE [vdvProjector_Rear_330, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(dvRelays, UP_REAR_330)
	    }
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Rear_331, POWER_OFF]
		
		WAIT 30
		{
		    fnRelayDirection(dvRel8, UP_REAR_331)
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnPowerDisplays331(INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    PULSE [vdvProjector_Front_331, POWER_ON]
	    fnRelayDirection(dvRelays, DN_LEFT_330)
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Front_330, POWER_ON]
		fnRelayDirection(dvRelays, DN_LEFT_330)
	    }
	}
	CASE BTN_PWR_OFF_L :
	{
	    PULSE [vdvProjector_Front_331, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection (dvRelays, UP_LEFT_331)
	    }
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Front_330, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection (dvRelays, UP_LEFT_330)
		}
	    }
	}
	CASE BTN_PWR_ON_R :
	{
	    PULSE [vdvProjector_Side_331, POWER_ON]
	    fnRelayDirection (dvRel8, DN_RIGHT_331)
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Side_330, POWER_ON]
		    fnRelayDirection (dvRelays, DN_RIGHT_330)
	    }
	}
	CASE BTN_PWR_OFF_R :
	{
	    PULSE [vdvProjector_Side_331, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(dvRel8, UP_RIGHT_331)
	    }
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Side_331, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection (dvRelays, UP_RIGHT_330)
		}
	    }
	}
	CASE BTN_PWR_ON_REAR :
	{
	    PULSE [vdvProjector_Rear_331, POWER_ON]
	    fnRelayDirection(dvRel8, DN_REAR_330)
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Rear_331, POWER_ON]
		fnRelayDirection(dvRelays, DN_REAR_330)
	    }
	}
	CASE BTN_PWR_OFF_REAR :
	{
	    PULSE [vdvProjector_Rear_331, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(dvRelays, UP_REAR_331)
	    }
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Rear_330, POWER_OFF]
		
		WAIT 30
		{
		    fnRelayDirection(dvRelays, UP_REAR_330)
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnDisplayMute(DEV cDevice, CHAR cState[8])
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
DEFINE_CALL 'ROOM MODE' (CHAR cMode[20])
{
    SWITCH (cMode)
    {
	CASE 'SEPARATE' :
	{
	    OFF [nMasterMode330]
	    OFF [nMasterMode331]
	    //Audio Break...
	    fnRecallPreset (TAG_PRESET_UNCOMBINE)
	}
	CASE 'MASTER 330' :
	{
	    ON [nMasterMode330]
	    OFF [nMasterMode331]
	    //Audio Combine Preset..
	    fnRecallPreset (TAG_PRESET_COMBINE)
	      
	    //Lock other touch Panel...
	    SEND_COMMAND dvTP_Main2, "'PAGE-Locked'"
	    	    
    	    //Mirror DGX Roughts to other room
	    fnRouteVideoIO (nSource_Left_330,OUT_PROJLEFT_331)
	    WAIT 20 fnRouteVideoIO (nSource_Right_330, OUT_PROJRIGHT_331)
	    WAIT 30 fnRouteVideoIO (nSource_Left_330, OUT_PROJREAR_331)
	    
	    WAIT 40 fnDisplayMute(dvProjector_dxFront_330, SET_MUTE_OFF)
	    WAIT 50 fnDisplayMute(dvProjector_dxSide_330, SET_MUTE_OFF)
	    WAIT 60 fnDisplayMute(dvProjector_dxRear_330, SET_MUTE_OFF)

	    WAIT 70 fnDisplayMute(dvProjector_dxFront_331, SET_MUTE_OFF)
	    WAIT 80 fnDisplayMute(dvProjector_dxSide_331, SET_MUTE_OFF)
	    WAIT 90 fnDisplayMute(dvProjector_dxRear_331, SET_MUTE_OFF)
	    
	    IF ([vdvProjector_Front_330, POWER])
	    {
		fnPowerDisplays331 (BTN_PWR_ON_L)
	    }
	    IF ([vdvProjector_Side_330, POWER])
	    {
		fnPowerDisplays331 (BTN_PWR_ON_R)
	    }
	    IF ([vdvProjector_Rear_330, POWER])
	    {
		fnPowerDisplays331 (BTN_PWR_ON_REAR)
	    }
	}
	CASE 'MASTER 331' :
	{
	    ON [nMasterMode331]
	    OFF [nMasterMode330]
	    //Audio Combine...
	   fnRecallPreset (TAG_PRESET_COMBINE)
	    
	    SEND_COMMAND dvTP_Main, "'PAGE-Locked'" //Locks 334...
	    //Mirror DGX Roughts to other room
	    fnRouteVideoIO (nSource_Left_331,OUT_PROJLEFT_330)
	    WAIT 20 fnRouteVideoIO (nSource_Right_331, OUT_PROJRIGHT_330)
	    WAIT 30 fnRouteVideoIO (nSource_Left_331, OUT_PROJREAR_330)
	    
	    WAIT 40 fnDisplayMute(dvProjector_dxFront_331, SET_MUTE_OFF)
	    WAIT 50 fnDisplayMute(dvProjector_dxSide_331, SET_MUTE_OFF)
	    WAIT 60 fnDisplayMute(dvProjector_dxRear_331, SET_MUTE_OFF)

	    WAIT 70 fnDisplayMute(dvProjector_dxFront_330, SET_MUTE_OFF)
	    WAIT 80 fnDisplayMute(dvProjector_dxSide_330, SET_MUTE_OFF)
	    WAIT 90 fnDisplayMute(dvProjector_dxRear_330, SET_MUTE_OFF)
	    
	    IF ([vdvProjector_Front_331, POWER])
	    {
		fnPowerDisplays330 (BTN_PWR_ON_L)
	    }
	    IF ([vdvProjector_Side_331, POWER])
	    {
		fnPowerDisplays330 (BTN_PWR_ON_R)
	    }
	    IF ([vdvProjector_Rear_331, POWER])
	    {
		fnPowerDisplays330 (BTN_PWR_ON_REAR)
	    }
	}
	CASE 'BREAK' : //Resets 330 + 331
	{
	    OFF [nMasterMode330]
	    OFF [nMasterMode331]
	    SEND_COMMAND vdvTP_Main, "'PAGE-Start'"
	    //Audio Break
	  fnRecallPreset (TAG_PRESET_UNCOMBINE)
	    
	    fnRouteVideoIO (nSource_Left_330,OUT_PROJLEFT_330)
	    WAIT 10 fnRouteVideoIO (nSource_Right_330, OUT_PROJRIGHT_330)
	    WAIT 20 fnRouteVideoIO (nSource_Left_330, OUT_PROJREAR_330)
	    WAIT 30 fnRouteVideoIO (nSource_Left_331,OUT_PROJLEFT_331)
	    WAIT 40 fnRouteVideoIO (nSource_Right_331, OUT_PROJRIGHT_331)
	    WAIT 50 fnRouteVideoIO (nSource_Left_331, OUT_PROJREAR_331)
	    
	    WAIT 60 fnDisplayMute(dvProjector_dxFront_330, SET_MUTE_OFF)
	    WAIT 70 fnDisplayMute(dvProjector_dxSide_330, SET_MUTE_OFF)
	    WAIT 80 fnDisplayMute(dvProjector_dxRear_330, SET_MUTE_OFF)

	    WAIT 90 fnDisplayMute(dvProjector_dxFront_331, SET_MUTE_OFF)
	    WAIT 100 fnDisplayMute(dvProjector_dxSide_331, SET_MUTE_OFF)
	    WAIT 110 fnDisplayMute(dvProjector_dxRear_331, SET_MUTE_OFF)
	}
	CASE 'OFF 330' :
	{
	    fnPowerDisplays330 (BTN_PWR_OFF_L)
	    fnPowerDisplays330 (BTN_PWR_OFF_R)
	    fnPowerDisplays330 (BTN_PWR_OFF_REAR)
	}
	CASE 'OFF 331' :
	{
	    fnPowerDisplays331 (BTN_PWR_OFF_L)
	    fnPowerDisplays331 (BTN_PWR_OFF_R)
	    fnPowerDisplays331 (BTN_PWR_OFF_REAR)
	}
    }
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = TIME_REBOOT)
    {
	IF (!nTPOnline)
	{
	    REBOOT (dvMaster)
	}
    }
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = TIME_KILL)
    {
	SEND_COMMAND vdvTP_Main, "'PAGE-Start'" //330 + 331
	
	IF (([vdvProjector_Front_330, POWER]) || ([vdvProjector_Side_330,POWER]) || ([vdvProjector_Rear_330, POWER]))
	{
	    CALL 'ROOM MODE' ('OFF 330')
	}
	IF (([vdvProjector_Front_331, POWER]) || ([vdvProjector_Side_331,POWER]) || ([vdvProjector_Rear_331, POWER]))
	{
	    CALL 'ROOM MODE' ('OFF 331')
	}
    }
}
DEFINE_FUNCTION fnToggleChannels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcVirtual); cLoop++)
    {
	ON [dcVirtual[cLoop], POWER] 
	OFF [dcVirtual[cLoop], ON_LINE]
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [nBootup_]
OFF [nFollow_Rear_330]
OFF [nFollow_Rear_331]

WAIT 100
{
    TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,LENGTH_ARRAY(lTLFeedback),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    //TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    
    fnToggleChannels()
}
WAIT 450
{
    OFF [nBootup_]
}

//Modules Here..
DEFINE_MODULE 'Sony_FHZ700L' PROJMODLEFT(vdvProjector_Front_330, dvProjector_Front_330);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODRIGHT(vdvProjector_Side_330, dvProjector_Side_330);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODREAR(vdvProjector_Rear_330, dvProjector_Rear_330);

DEFINE_MODULE 'Sony_FHZ700L' PROJMODFRONT(vdvProjector_Front_331, dvProjector_Front_331);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODSIDE(vdvProjector_Side_331, dvProjector_Side_331);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODREAREND(vdvProjector_Rear_331, dvProjector_Rear_331);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, BTN_SET_NUMBER]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL
	SEND_COMMAND dvTP_MAIN, "'@TKP'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND dvTP_MAIN, "'^TKP'"
	#END_IF
    }
}
BUTTON_EVENT [dvTP_Main, BTN_SET_LOCATION]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL 
	SEND_COMMAND dvTP_MAIN, "'@AKB'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND dvTP_MAIN, "'^AKB'"
	#END_IF
    }
}
BUTTON_EVENT [dvTP_Main, BTN_SET_ALL]
{
    PUSH :
    {
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location330"
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_SET_NUMBER] //Help TP 331
{
    PUSH :
    {
	#IF_DEFINED G4PANEL
	SEND_COMMAND dvTP_MAIN2, "'@TKP'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND dvTP_MAIN2, "'^TKP'"
	#END_IF
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_SET_LOCATION]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL 
	SEND_COMMAND dvTP_MAIN2, "'@AKB'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND dvTP_MAIN2, "'^AKB'"
	#END_IF
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_SET_ALL]
{
    PUSH :
    {
	SEND_COMMAND dvTP_Main2, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location331"
	SEND_COMMAND dvTP_Main2, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_MODE_SEPARATE]
BUTTON_EVENT [vdvTP_Main, BTN_MODE_MASTER_330]
BUTTON_EVENT [vdvTP_Main, BTN_MODE_MASTER_331]
BUTTON_EVENT [vdvTP_Main, BTN_MODE_BREAK]
BUTTON_EVENT [vdvTP_Main, BTN_MODE_SHUT_330]
BUTTON_EVENT [vdvTP_Main, BTN_MODE_SHUT_331] //Room Modes...
{
    HOLD [30] :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_MODE_SHUT_330 : CALL 'ROOM MODE' ('OFF 331')
	    CASE BTN_MODE_SHUT_331 : CALL 'ROOM MODE' ('OFF 330')
	}
    }
    RELEASE :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_MODE_SEPARATE : CALL 'ROOM MODE' ('SEPARATE')
	    CASE BTN_MODE_MASTER_330 : CALL 'ROOM MODE' ('MASTER 330')
	    CASE BTN_MODE_MASTER_331 : CALL 'ROOM MODE' ('MASTER 331')
	    CASE BTN_MODE_BREAK : CALL 'ROOM MODE' ('BREAK')
	    CASE BTN_MODE_SHUT_330 : CALL 'ROOM MODE' ('OFF 330')
	    CASE BTN_MODE_SHUT_331 : CALL 'ROOM MODE' ('OFF 331')
	}
    }
}
BUTTON_EVENT [dvTP_Main, BTN_PWR_ON_L]
BUTTON_EVENT [dvTP_Main, BTN_PWR_OFF_L]
BUTTON_EVENT [dvTP_Main, BTN_MUTE_PROJ_L] 
BUTTON_EVENT [dvTP_Main, BTN_SCREEN_UP_L]
BUTTON_EVENT [dvTP_Main, BTN_SCREEN_DN_L] //330 Front Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L : fnPowerDisplays330 (BTN_PWR_ON_L)
	    CASE BTN_PWR_OFF_L : fnPowerDisplays330 (BTN_PWR_OFF_L)
	    
	    CASE BTN_MUTE_PROJ_L :
	    {
		IF (!nMuteProjLeft_330)
		{
		    fnDisplayMute(dvProjector_dxFront_330, SET_MUTE_ON)
		}
		ELSE
		{
		   fnDisplayMute(dvProjector_dxFront_330, SET_MUTE_OFF)
		}
	    }
	    CASE BTN_SCREEN_UP_L :
	    {
		fnRelayDirection(dvRelays, UP_LEFT_330)
		    ON [dvTP_Main, BTN_SCREEN_UP_L]
	    }
	    CASE BTN_SCREEN_DN_L :
	    {
		fnRelayDirection(dvRelays, DN_LEFT_330)
		    ON [dvTP_Main, BTN_SCREEN_DN_L]
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main, BTN_PWR_ON_R]
BUTTON_EVENT [dvTP_Main, BTN_PWR_OFF_R]
BUTTON_EVENT [dvTP_Main, BTN_MUTE_PROJ_R] 
BUTTON_EVENT [dvTP_Main, BTN_SCREEN_UP_R]
BUTTON_EVENT [dvTP_Main, BTN_SCREEN_DN_R] //330 Side Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R : fnPowerDisplays330 (BTN_PWR_ON_R)
	    CASE BTN_PWR_OFF_R : fnPowerDisplays330 (BTN_PWR_OFF_R)
	    
	    CASE BTN_MUTE_PROJ_R :
	    {
		IF (!nMuteProjRight_330)
		{
		    fnDisplayMute(dvProjector_dxSide_330, SET_MUTE_ON)
		}
		ELSE
		{
		   fnDisplayMute(dvProjector_dxSide_330, SET_MUTE_OFF)
		}
	    }
	    CASE BTN_SCREEN_UP_R :
	    {
		fnRelayDirection (dvRelays, UP_RIGHT_330)
		    ON [dvTP_Main, BTN_SCREEN_UP_R]
	    }
	    CASE BTN_SCREEN_DN_R :
	    {
		fnRelayDirection(dvRelays, DN_RIGHT_330)
		    ON [dvTP_Main, BTN_SCREEN_DN_R]
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main, BTN_PWR_ON_REAR]
BUTTON_EVENT [dvTP_Main, BTN_PWR_OFF_REAR]
BUTTON_EVENT [dvTP_Main, BTN_MUTE_PROJ_REAR] 
BUTTON_EVENT [dvTP_Main, BTN_SCREEN_UP_REAR]
BUTTON_EVENT [dvTP_Main, BTN_SCREEN_DN_REAR] 
BUTTON_EVENT [dvTP_Main, BTN_FOLLOW_LEFT]
BUTTON_EVENT [dvTP_Main, BTN_FOLLOW_NOTES] //330 Rear Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_REAR : fnPowerDisplays330 (BTN_PWR_ON_REAR)
	    CASE BTN_PWR_OFF_REAR : fnPowerDisplays330 (BTN_PWR_OFF_REAR)
	    
	    CASE BTN_MUTE_PROJ_REAR :
	    {
		IF (!nMuteProjRear_330)
		{
		    fnDisplayMute(dvProjector_dxRear_330, SET_MUTE_ON)
		}
		ELSE
		{
		    fnDisplayMute(dvProjector_dxRear_330, SET_MUTE_OFF)
		}
	    }
	    CASE BTN_FOLLOW_LEFT :
	    {
		ON [dvTP_Main, BTN_FOLLOW_LEFT]
		    ON [nFollow_Rear_330]
			fnRouteVideoRear330 (nSource_Left_330)
	    }
	    CASE BTN_FOLLOW_NOTES :
	    {
		ON [dvTP_Main, BTN_FOLLOW_NOTES]
		    OFF [nFollow_Rear_330]
			fnRouteVideoRear330 (IN_DESK_EXT_330)
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main, nProjectorLeftVidBtns] //330 Main Video Routing Left...
{
    PUSH :
    {
	fnRouteVideoLeft330 (nVideoSources330 [GET_LAST (nProjectorLeftVidBtns)])
    }
}
BUTTON_EVENT [dvTP_Main, nProjectorRightVidBtns] //330 Main Video Routing Side...
{
    PUSH :
    {
	fnRouteVideoRight330 (nVideoSources330 [GET_LAST (nProjectorRightVidBtns)])
    }
}
BUTTON_EVENT [dvTP_Main, BTN_PREVIEW_EXT]
BUTTON_EVENT [dvTP_Main, BTN_PREVIEW_REC] //330 Preview....
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PREVIEW_EXT :
	    {
		fnRouteVideoPreview330 (IN_DESK_EXT_330)
	    }
	    CASE BTN_PREVIEW_REC :
	    {
		fnRouteVideoPreview330 (IN_EXTRON_330)
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main, BTN_TECH_PAGE]
{
    HOLD [50] :
    {
	SEND_COMMAND dvTP_Main, "'PAGE-Select_Tech'"
    }
}
BUTTON_EVENT [dvTP_Main, BTN_REBOOT_DGX]
{
    PUSH :
    {
	REBOOT (dvDGXMaster)
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_PWR_ON_L]
BUTTON_EVENT [dvTP_Main2, BTN_PWR_OFF_L]
BUTTON_EVENT [dvTP_Main2, BTN_MUTE_PROJ_L] 
BUTTON_EVENT [dvTP_Main2, BTN_SCREEN_UP_L]
BUTTON_EVENT [dvTP_Main2, BTN_SCREEN_DN_L] //331 Front Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L : fnPowerDisplays331 (BTN_PWR_ON_L)
	    CASE BTN_PWR_OFF_L : fnPowerDisplays331 (BTN_PWR_OFF_L)
	    
	    CASE BTN_MUTE_PROJ_L :
	    {
		IF (!nMuteProjLeft_331)
		{
		    fnDisplayMute(dvProjector_dxFront_331, SET_MUTE_ON)
		}
		ELSE
		{
		   fnDisplayMute(dvProjector_dxFront_331, SET_MUTE_OFF)
		}
	    }
	    CASE BTN_SCREEN_UP_L :
	    {
		fnRelayDirection(dvRelays, UP_LEFT_331)
		    ON [dvTP_Main2, BTN_SCREEN_UP_L]
	    }
	    CASE BTN_SCREEN_DN_L :
	    {
		fnRelayDirection(dvRelays, DN_LEFT_331)
		    ON [dvTP_Main2, BTN_SCREEN_DN_L]
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_PWR_ON_R]
BUTTON_EVENT [dvTP_Main2, BTN_PWR_OFF_R]
BUTTON_EVENT [dvTP_Main2, BTN_MUTE_PROJ_R] 
BUTTON_EVENT [dvTP_Main2, BTN_SCREEN_UP_R]
BUTTON_EVENT [dvTP_Main2, BTN_SCREEN_DN_R] //331 Side Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R : fnPowerDisplays331 (BTN_PWR_ON_R)
	    CASE BTN_PWR_OFF_R : fnPowerDisplays331 (BTN_PWR_OFF_R)
	    
	    CASE BTN_MUTE_PROJ_R :
	    {
		IF (!nMuteProjRight_331)
		{
		    fnDisplayMute(dvProjector_dxSide_331, SET_MUTE_ON)
		}
		ELSE
		{
		   fnDisplayMute(dvProjector_dxSide_331, SET_MUTE_OFF)
		}
	    }
	    CASE BTN_SCREEN_UP_R :
	    {
		fnRelayDirection (dvRel8, UP_RIGHT_331)
		    ON [dvTP_Main2, BTN_SCREEN_UP_R]
	    }
	    CASE BTN_SCREEN_DN_R :
	    {
		fnRelayDirection(dvRel8, DN_RIGHT_331)
		    ON [dvTP_Main2, BTN_SCREEN_DN_R]
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_PWR_ON_REAR]
BUTTON_EVENT [dvTP_Main2, BTN_PWR_OFF_REAR]
BUTTON_EVENT [dvTP_Main2, BTN_MUTE_PROJ_REAR] 
BUTTON_EVENT [dvTP_Main2, BTN_SCREEN_UP_REAR]
BUTTON_EVENT [dvTP_Main2, BTN_SCREEN_DN_REAR] 
BUTTON_EVENT [dvTP_Main2, BTN_FOLLOW_LEFT]
BUTTON_EVENT [dvTP_Main2, BTN_FOLLOW_NOTES] //331 Rear Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_REAR : fnPowerDisplays331 (BTN_PWR_ON_REAR)
	    CASE BTN_PWR_OFF_REAR : fnPowerDisplays331 (BTN_PWR_OFF_REAR)
	    
	    CASE BTN_MUTE_PROJ_REAR :
	    {
		IF (!nMuteProjRear_331)
		{
		    fnDisplayMute(dvProjector_dxRear_331, SET_MUTE_ON)
		}
		ELSE
		{
		    fnDisplayMute(dvProjector_dxRear_331, SET_MUTE_OFF)
		}
	    }
	    CASE BTN_FOLLOW_LEFT :
	    {
		ON [dvTP_Main2, BTN_FOLLOW_LEFT]
		    ON [nFollow_Rear_331]
			fnRouteVideoRear331 (nSource_Left_330)
	    }
	    CASE BTN_FOLLOW_NOTES :
	    {
		ON [dvTP_Main2, BTN_FOLLOW_NOTES]
		    OFF [nFollow_Rear_331]
			fnRouteVideoRear331 (IN_DESK_EXT_330)
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main2, nProjectorLeftVidBtns] //331 Main Video Routing Left...
{
    PUSH :
    {
	fnRouteVideoLeft331 (nVideoSources331 [GET_LAST (nProjectorLeftVidBtns)])
    }
}
BUTTON_EVENT [dvTP_Main2, nProjectorRightVidBtns] //331 Main Video Routing Side...
{
    PUSH :
    {
	fnRouteVideoRight331 (nVideoSources331 [GET_LAST (nProjectorRightVidBtns)])
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_PREVIEW_EXT]
BUTTON_EVENT [dvTP_Main2, BTN_PREVIEW_REC] //331 Preview....
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PREVIEW_EXT :
	    {
		fnRouteVideoPreview331 (IN_DESK_EXT_330)
	    }
	    CASE BTN_PREVIEW_REC :
	    {
		fnRouteVideoPreview331 (IN_EXTRON_330)
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_TECH_PAGE]
{
    HOLD [50] :
    {
	SEND_COMMAND dvTP_Main2, "'PAGE-Select_Tech'"
    }
}
BUTTON_EVENT [dvTP_Main2, BTN_REBOOT_DGX]
{
    PUSH :
    {
	REBOOT (dvDGXMaster)
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main] //TP 330
{
    ONLINE:
    {
	ON [nTPOnline]
	ON [dvTP_Main, ON_LINE]

	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND dvTP_MAIN, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location330"
	SEND_COMMAND dvTP_MAIN, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	
    	IF (nBootup_)
	{
	    fnToggleChannels()
	}
    }
    OFFLINE :
    {
	OFF [nTPOnline]
	OFF [dvTP_Main, ON_LINE]
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
		    nRoom_Location330 = 'Set Default'
		    SEND_COMMAND dvTP_MAIN, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location330"
		}
		ELSE
		{
		     nRoom_Location330 = sTmp
		    SEND_COMMAND dvTP_MAIN, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location330"
		}
	}
	IF (FIND_STRING(sTmp,'KEYP-',1)OR FIND_STRING(sTmp,'TKP-',1)) //G4 or G5
	{
	    REMOVE_STRING(sTmp,'-',1)
	    
	    IF (FIND_STRING(sTmp,'ABORT',1)) //Keep Default if it was set...
	    {
		nHelp_Phone_ = nHelp_Phone_
		SEND_COMMAND dvTP_MAIN, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	    ELSE
	    {
		nHelp_Phone_ = sTmp
		SEND_COMMAND dvTP_MAIN, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	}
    }
}
DATA_EVENT [dvTp_Main2] //TP 331
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND dvTP_Main2, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location331"
	SEND_COMMAND dvTP_MAIN2, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	
	IF (nBootup_)
	{
	    fnToggleChannels()
	}
    }
OFFLINE :
    {
	OFF [nTPOnline]
	OFF [dvTP_Main2, ON_LINE]
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
		    nRoom_Location331 = 'Set Default'
		    SEND_COMMAND dvTP_MAIN2, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location331"
		}
		ELSE
		{
		     nRoom_Location331 = sTmp
		    SEND_COMMAND dvTP_MAIN2, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location331"
		}
	}
	IF (FIND_STRING(sTmp,'KEYP-',1)OR FIND_STRING(sTmp,'TKP-',1)) //G4 or G5
	{
	    REMOVE_STRING(sTmp,'-',1)
	    
	    IF (FIND_STRING(sTmp,'ABORT',1)) //Keep Default if it was set...
	    {
		nHelp_Phone_ = nHelp_Phone_
		SEND_COMMAND dvTP_MAIN2, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	    ELSE
	    {
		nHelp_Phone_ = sTmp
		SEND_COMMAND dvTP_MAIN2, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	}
    }
}
DATA_EVENT [dvDGX]
{
    ONLINE :
    {
	ON [nDGXOnline]
	WAIT 120
	{
	    CALL 'DGX NAMING'
	}
    }
    OFFLINE :
    {
	OFF [nDGXOnline]
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cInput[5]
	LOCAL_VAR INTEGER cOutput
	
	CHAR cMsg[20]
	cMsg = DATA.TEXT
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LVIDEOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LVIDEOI'",1)
		
		cInput = cMsg //Should Read #O##
		
		REMOVE_STRING(cMsg,"'O'",1)
		cOutput = ATOI(cMsg)
		
		SWITCH (cOutput)
		{
		    CASE OUT_PROJLEFT_330:  //Output 9
		    {
			cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-2)
			nSource_Left_330 = ATOI (cInput)
			
			SWITCH (nSource_Left_330)
			{
			    CASE IN_DESKTOP_330 : 
			    {
				ON [dvTP_Main, BTN_PC_MAIN_L]
				    ON [dvTP_Main, BTN_AUDIO_PC]
			    }
			    CASE IN_DESK_EXT_330 : 
			    {
				ON [dvTP_Main, BTN_PC_EXT_L]
				    ON [dvTP_Main, BTN_AUDIO_PC]
			    }
			    CASE IN_EXTERNAL_330 : 
			    {
				ON [dvTP_Main, BTN_EXTERNAL_L]
				    ON [dvTP_Main, BTN_AUDIO_EXTERNAL]
			    }
			    CASE IN_DOCCAM_330 :
			    {
				ON [dvTP_Main, BTN_DOC_CAM_L]
			    }
			    CASE IN_MERSIVE_330 : 
			    {
				ON [dvTP_Main, BTN_MERSIVE_L]
				    ON [dvTP_Main, BTN_AUDIO_MERSIVE]
			    }
			}
		    }
		    CASE OUT_PROJRIGHT_330 : //Output 10
		    {
			cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-3)
			nSource_Right_330 = ATOI (cInput)
			
			SWITCH (nSource_Right_330)
			{
			    CASE IN_DESKTOP_330 : 
			    {
				ON [dvTP_Main, BTN_PC_MAIN_R]
				    ON [dvTP_Main, BTN_AUDIO_PC]
			    }
			    CASE IN_DESK_EXT_330 : 
			    {
				ON [dvTP_Main, BTN_PC_EXT_R]
				    ON [dvTP_Main, BTN_AUDIO_PC]
			    }
			    CASE IN_EXTERNAL_330 : 
			    {
				ON [dvTP_Main, BTN_EXTERNAL_R]
				    ON [dvTP_Main, BTN_AUDIO_EXTERNAL]
			    }
			    CASE IN_DOCCAM_330 :
			    {
				ON [dvTP_Main, BTN_DOC_CAM_R]
			    }
			    CASE IN_MERSIVE_330 : 
			    {
				ON [dvTP_Main, BTN_MERSIVE_R]
				    ON [dvTP_Main, BTN_AUDIO_MERSIVE]
			    }
			}
		    }
		    CASE OUT_PROJLEFT_331 : //13
		    {
    			cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-3)
			nSource_Left_331 = ATOI (cInput)
			
			SWITCH (nSource_Left_331)
			{
			    CASE IN_DESKTOP_331 : 
			    {
				ON [dvTP_Main2, BTN_PC_MAIN_L]
				    ON [dvTP_Main2, BTN_AUDIO_PC]
			    }
			    CASE IN_DESK_EXT_331 : 
			    {
				ON [dvTP_Main2, BTN_PC_EXT_L]
				    ON [dvTP_Main2, BTN_AUDIO_PC]
			    }
			    CASE IN_EXTERNAL_331 : 
			    {
				ON [dvTP_Main2, BTN_EXTERNAL_L]
				    ON [dvTP_Main2, BTN_AUDIO_EXTERNAL]
			    }
			    CASE IN_DOCCAM_331 :
			    {
				ON [dvTP_Main2, BTN_DOC_CAM_L]
			    }
			    CASE IN_MERSIVE_331 : 
			    {
				ON [dvTP_Main2, BTN_MERSIVE_L]
				    ON [dvTP_Main2, BTN_AUDIO_MERSIVE]
			    }
			}
		    }
		    CASE OUT_PROJRIGHT_331 : //14
		    {
    			cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-3)
			nSource_Right_331 = ATOI (cInput)
			
			SWITCH (nSource_Right_331)
			{
			    CASE IN_DESKTOP_331 : 
			    {
				ON [dvTP_Main2, BTN_PC_MAIN_R]
				    ON [dvTP_Main2, BTN_AUDIO_PC]
			    }
			    CASE IN_DESK_EXT_331 : 
			    {
				ON [dvTP_Main2, BTN_PC_EXT_R]
				    ON [dvTP_Main2, BTN_AUDIO_PC]
			    }
			    CASE IN_EXTERNAL_331 : 
			    {
				ON [dvTP_Main2, BTN_EXTERNAL_R]
				    ON [dvTP_Main2, BTN_AUDIO_EXTERNAL]
			    }
			    CASE IN_DOCCAM_331 :
			    {
				ON [dvTP_Main2, BTN_DOC_CAM_R]
			    }
			    CASE IN_MERSIVE_331 : 
			    {
				ON [dvTP_Main2, BTN_MERSIVE_R]
				    ON [dvTP_Main2, BTN_AUDIO_MERSIVE]
			    }
			}
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxFront_330] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxFront_330, "'?VIDOUT_MUTE'"
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
			ON [dvTP_Main, BTN_MUTE_PROJ_L]
			    ON [nMuteProjLeft_330]
			    
			    IF (nMasterMode330)
			    {
				 fnDisplayMute(dvProjector_dxFront_331, SET_MUTE_ON)
			    }
		    }
		    CASE 'DISABLE' :
		    {
			OFF [dvTP_Main, BTN_MUTE_PROJ_L]
			    OFF [nMuteProjLeft_330]
			    
			    If (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxFront_331, SET_MUTE_OFF)
			    }
		    }
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxSide_330] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxSide_330, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cTmpRight330[8]
	
	CHAR cMsgRight330[30]
	cMsgRight330 = DATA.TEXT
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsgRight330,'VIDOUT_MUTE-',1)):
	    {
		REMOVE_STRING (cMsgRight330,'VIDOUT_MUTE-',1)
		cTmpRight330 = cMsgRight330
		
		SWITCH (cTmpRight330)
		{
		    CASE 'ENABLE' :
		    {
			ON [dvTP_Main, BTN_MUTE_PROJ_R]
			    ON [nMuteProjRight_330]
			    
			    IF (nMasterMode330)
			    {
				 fnDisplayMute(dvProjector_dxSide_331, SET_MUTE_ON)
			    }
				
		    }
		    CASE 'DISABLE' :
		    {
			OFF [dvTP_Main, BTN_MUTE_PROJ_R]
			    OFF [nMuteProjRight_330]
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxSide_331, SET_MUTE_OFF)
			    }
		    }
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxRear_330] //Rear Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxRear_330, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cTmpRear330[8]
	
	CHAR cMsgRear330[30]
	cMsgRear330 = DATA.TEXT
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsgRear330,'VIDOUT_MUTE-',1)):
	    {
		REMOVE_STRING (cMsgRear330,'VIDOUT_MUTE-',1)
		cTmpRear330 = cMsgRear330
		
		SWITCH (cTmpRear330)
		{
		    CASE 'ENABLE' :
		    {
			ON [dvTP_Main, BTN_MUTE_PROJ_REAR]
			    ON [nMuteProjRear_330]
			    
			    IF (nMasterMode330)
			    {
				 fnDisplayMute(dvProjector_dxRear_331, SET_MUTE_ON)
			    }
		    }
		    CASE 'DISABLE' :
		    {
			OFF [dvTP_Main, BTN_MUTE_PROJ_REAR]
			    OFF [nMuteProjRear_330]
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxRear_331, SET_MUTE_OFF)
			    }
		    }
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxFront_331] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxFront_331, "'?VIDOUT_MUTE'"
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
			ON [dvTP_Main2, BTN_MUTE_PROJ_L]
			    ON [nMuteProjLeft_331]
			    
			    IF (nMasterMode331)
				 fnDisplayMute(dvProjector_dxFront_330, SET_MUTE_ON)
				
		    }
		    CASE 'DISABLE' :
		    {
			OFF [dvTP_Main2, BTN_MUTE_PROJ_L]
			    OFF [nMuteProjLeft_331]
			    
			    If (nMasterMode331)
				fnDisplayMute(dvProjector_dxFront_330, SET_MUTE_OFF)
		    }
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxSide_331] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxSide_331, "'?VIDOUT_MUTE'"
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
			ON [dvTP_Main2, BTN_MUTE_PROJ_R]
			    ON [nMuteProjRight_331]
			    
			    IF (nMasterMode331)
				 fnDisplayMute(dvProjector_dxSide_330, SET_MUTE_ON)
				
		    }
		    CASE 'DISABLE' :
		    {
			OFF [dvTP_Main2, BTN_MUTE_PROJ_R]
			    OFF [nMuteProjRight_331]
			    
			    If (nMasterMode331)
				fnDisplayMute(dvProjector_dxSide_330, SET_MUTE_OFF)
		    }
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxRear_331] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxRear_331, "'?VIDOUT_MUTE'"
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
			ON [dvTP_Main2, BTN_MUTE_PROJ_REAR]
			    ON [nMuteProjRear_331]
			    
			    IF (nMasterMode331)
				 fnDisplayMute(dvProjector_dxRear_330, SET_MUTE_ON)
				
		    }
		    CASE 'DISABLE' :
		    {
			OFF [dvTP_Main2, BTN_MUTE_PROJ_REAR]
			    OFF [nMuteProjRear_331]
			    
			    If (nMasterMode331)
				fnDisplayMute(dvProjector_dxRear_330, SET_MUTE_OFF)
		    }
		}
	    }	
	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_Front_330, ON_LINE]
CHANNEL_EVENT [vdvProjector_Front_330, WARMING]
CHANNEL_EVENT [vdvProjector_Front_330, COOLING]
CHANNEL_EVENT [vdvProjector_Front_330, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-1.2,0,%OP255'"
		ON [dvTP_Main, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main, BTN_PWR_ON_L]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-1.2,0,%OP30'"
		OFF [dvTP_Main, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main, BTN_PWR_OFF_L]
	    }
	 }   
    }
}
CHANNEL_EVENT [vdvProjector_Side_330, ON_LINE]
CHANNEL_EVENT [vdvProjector_Side_330, WARMING]
CHANNEL_EVENT [vdvProjector_Side_330, COOLING]
CHANNEL_EVENT [vdvProjector_Side_330, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP255'"
		ON [dvTP_Main, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main, BTN_PWR_ON_R]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP30'"
		OFF [dvTP_Main, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main, BTN_PWR_OFF_R]
	    }
	 }   
    }
}
CHANNEL_EVENT [vdvProjector_Rear_330, ON_LINE]
CHANNEL_EVENT [vdvProjector_Rear_330, WARMING]
CHANNEL_EVENT [vdvProjector_Rear_330, COOLING]
CHANNEL_EVENT [vdvProjector_Rear_330, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP255'"
		ON [dvTP_Main, BTN_ONLINE_REAR]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main, BTN_PWR_ON_REAR]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP30'"
		OFF [dvTP_Main, BTN_ONLINE_REAR]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main, BTN_PWR_OFF_REAR]
	    }
	 }   
    }
}
CHANNEL_EVENT [vdvProjector_Front_331, ON_LINE]
CHANNEL_EVENT [vdvProjector_Front_331, WARMING]
CHANNEL_EVENT [vdvProjector_Front_331, COOLING]
CHANNEL_EVENT [vdvProjector_Front_331, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-1.2,0,%OP255'"
		ON [dvTP_Main2, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main2, BTN_PWR_ON_L]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-1.2,0,%OP30'"
		OFF [dvTP_Main2, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main2, BTN_PWR_OFF_L]
	    }
	 }   
    }
}
CHANNEL_EVENT [vdvProjector_Side_331, ON_LINE]
CHANNEL_EVENT [vdvProjector_Side_331, WARMING]
CHANNEL_EVENT [vdvProjector_Side_331, COOLING]
CHANNEL_EVENT [vdvProjector_Side_331, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-101.102,0,%OP255'"
		ON [dvTP_Main2, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-101.102,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main2, BTN_PWR_ON_R]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-101.102,0,%OP30'"
		OFF [dvTP_Main2, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-101.102,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main2, BTN_PWR_OFF_R]
	    }
	 }   
    }
}
CHANNEL_EVENT [vdvProjector_Rear_331, ON_LINE]
CHANNEL_EVENT [vdvProjector_Rear_331, WARMING]
CHANNEL_EVENT [vdvProjector_Rear_331, COOLING]
CHANNEL_EVENT [vdvProjector_Rear_331, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-201.202,0,%OP255'"
		ON [dvTP_Main2, BTN_ONLINE_REAR]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-201.202,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main2, BTN_PWR_ON_REAR]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-201.202,0,%OP30'"
		OFF [dvTP_Main2, BTN_ONLINE_REAR]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main2, "'^BMF-201.202,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_Main2, BTN_PWR_OFF_REAR]
	    }
	 }   
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnReboot()
    fnKill()
    
    [vdvTP_Main, BTN_REBOOT_DGX] = nDGXOnline
    
    WAIT ONE_MINUTE
    {
    	fnMuteCheck(dvProjector_dxFront_330)
	WAIT ONE_SECOND fnMuteCheck(dvProjector_dxSide_330)
	WAIT 20 fnMuteCheck(dvProjector_dxRear_330)
    	WAIT 30 fnMuteCheck(dvProjector_dxFront_331)
	WAIT 40 fnMuteCheck(dvProjector_dxSide_331)
	WAIT 50 fnMuteCheck(dvProjector_dxRear_331)
    }
}
                       
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

