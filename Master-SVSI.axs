PROGRAM_NAME='Master'
(***********************************************************)
(*  FILE CREATED ON: 10/31/2019  AT: 11:07:31              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 03/31/2020  AT: 16:19:33        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $	
	Notes...
	
	Add "Hold" 3 Seconds to Engage 152 Stream...
	
	Add Manual 152 Switching buttons for sources on screen?? -
	152 Buttons feedback - mutall exculsive 
	
	http://www.audioscience.com/internet/products/avb/hono_avb_controller.htm
	
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster =			0:1:0
dvController =			0:2:0 
dvDebug =			0:0:0 //Send to Diag...
//dvShure =			0:3:0 
//dvCamFront =		0:4:0
//dvCamRear =		0:5:0
dvVaddioBridge =		0:6:0 //av Bridge klaus1207avbridge:23

dvTP_Main =			10001:1:0 //MT-1002
dvTP_Booth = 			10002:1:0 //MD-702
dvVaddioIO =			5001:22:0 //Vaddio Triggers...

vdvPipeFB =			33333:2:0 //Send FB to DL...

//Define Touch Panel Type
#WARN 'Check correct Panel Type'
//#DEFINE G4PANEL
#DEFINE G5PANEL //Ex..MT-702, MT1002, MXT701

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Decoder IPs
OUT_DISPLAY_FRONT_LEFT		 = '10.10.0.101' //Sharp
OUT_DISPLAY_FRONT_RIGHT		= '10.10.0.102' //Sharp
OUT_DISPLAY_REAR_LEFT		= '10.10.0.103'
OUT_DISPLAY_REAR_RIGHT		= '10.10.0.104'
OUT_DISPLAY_SIDE_LEFT		= '10.10.0.106'
OUT_DISPLAY_SIDE_RIGHT		= '10.10.0.105'
OUT_MONITOR_LEFT			= '10.10.0.107' //Lectern Monitor
OUT_MONITOR_RIGHT			= '10.10.0.108' //Dell Monitor
OUT_AV_BRIDGE_1				= '10.10.0.109'
OUT_AV_BRIDGE_2				= '10.10.0.110'
OUT_DL_CAPTURE				= '10.10.0.111'
OUT_AUDIO_ATC				= '10.10.0.199' //Pull audio from Pearl decoder

//Endocder Stream #'s
STREAM_PC_MAIN				= 11 //
STREAM_PC_EXT				= 12 //
STREAM_VGA_HDMI			= 13 //
STREAM_DOC_CAM			= 14  //
STREAM_MERSIVE				= 15
STREAM_CAM_FRONT			= 16
STREAM_CAM_REAR			= 17 
STREAM_KAPTIVO				= 23
STREAM_LIGHT_BOARD			= 18 
STREAM_AV_BRIDGE			= 19 
STREAM_DL_1					= 20
STREAM_DL_2					= 21
STREAM_DL_3					= 22

//Sharp Display Talk...
TALK_DISPLAY_FRONT_LEFT_IP	= '10.10.0.201'
TALK_DISPLAY_FRONT_RIGHT_IP	= '10.10.0.202'
TALK_SHARP_DISPLAY_PORT		= '10002'
//Sony Display Talk...
TALK_DISPLAY_REAR_LEFT_IP		= '10.10.0.203'
TALK_DISPLAY_REAR_RIGHT_IP	= '10.10.0.204'
TALK_DISPLAY_SIDE_LEFT_IP		= '10.10.0.206'
TALK_DISPLAY_SIDE_RIGHT_IP	= '10.10.0.205'
TALK_SONY_DISPLAY_PORT		= '20060' 
(** Sony TV Settings... 
	Settings : EZ IP ON
	Remote Start - On (Powered on by Apps) - Must be Active!! **)

CHAR TV_SONY_POWER_QUERY[]    		='2A 53 45 50 4F 57 52 23 23 23 23 23 23 23 23 23 23 23 23 23 23 23 23 0A'
CHAR TV_SONY_POWER_ON[]			='2A 53 43 50 4F 57 52 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 31 0A'
CHAR TV_SONY_POWER_OFF[]			='2A 53 43 50 4F 57 52 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 0A'

CHAR TV_SHARP_POWER_QUERY[]		= '50 4F 57 52 3F 3F 3F 3F 0D ' //POWR????
CHAR TV_SHARP_POWER_ON[]			= '50 4F 57 52 30 30 30 31 0D' //POWR0001,CR
CHAR TV_SHARP_POWER_OFF[] 			= '50 4F 57 52 30 30 30 30 0D'
CHAR TV_SHARP_RS232_ON[]			= '52 53 50 57 31 20 20 20 0D ' //"'RSPW1',$20,$20,$20,$0D"

//Av Bridge Stuff....
CHAR AVB_PIP_ON[]					= 'video program pip on'
CHAR AVB_PIP_OFF[]					= 'video program pip off'
CHAR AVB_PIP_GET[]					= 'video program pip get'
CHAR AVB_LOGIN[]					= 'admin'
CHAR AVB_PASS[]						= 'password'
CHAR AVB_INPUT_CAMERA[]				= 'video program source set input 1'
CHAR AVB_INPUT_DOC_CAM[]			= 'video program source set input 2'
CHAR AVB_MAC_ADD[17]				= '04-91-62-DB-60-BA'
CHAR AVB_MODEL[20]					= 'vaddio-av-bridge-2x1'
//End AV Bridge Stuff...

TL_FEEDBACK					= 1
TL_FLASH					= 2
CR 							= 13
LF 							= 10
//Times....
ONE_SECOND					= 10
ONE_MINUTE					= ONE_SECOND * 60
ONE_HOUR					= ONE_MINUTE * 60

TIME_REBOOT					= '06:00:00'
TIME_SHUT					= '22:00:00'

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100
TXT_CAMERA_PAGE			= 23

//Btns....
BTN_PWR_ON_L				= 1
BTN_PWR_OFF_L				= 2

BTN_PWR_ON_R				= 101
BTN_PWR_OFF_R				= 102

BTN_PWR_ON_REAR_L			= 201
BTN_PWR_OFF_REAR_L			= 202

BTN_PWR_ON_REAR_R			= 301
BTN_PWR_OFF_REAR_R			= 302

BTN_PWR_ON_SIDE_L			= 401
BTN_PWR_OFF_SIDE_L			= 402

BTN_PWR_ON_SIDE_R			= 701
BTN_PWR_OFF_SIDE_R			= 702

BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L					= 12
BTN_EXTERNAL_L				= 13
BTN_DOCCAM_L				= 14
BTN_MERSIVE_L				= 15
BTN_KAPTIVO_L				= 16
BTN_LIGHT_BOARD_L			= 18

BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R				= 112
BTN_EXTERNAL_R				= 113
BTN_DOCCAM_R				= 114
BTN_MERSIVE_R				= 115
BTN_KAPTIVO_R				= 116
BTN_LIGHT_BOARD_R			= 118

BTN_PC_MAIN_REAR_L			= 211
BTN_PC_EXT_REAR_L			= 212
BTN_EXTERNAL_REAR_L			= 213
BTN_DOCCAM_REAR_L			= 214
BTN_MERSIVE_REAR_L			= 215
BTN_KAPTIVO_REAR_L			= 216
BTN_LIGHT_BOARD_REAR_L		= 218

BTN_PC_MAIN_REAR_R			= 311
BTN_PC_EXT_REAR_R			= 312
BTN_EXTERNAL_REAR_R			= 313
BTN_DOCCAM_REAR_R			= 314
BTN_MERSIVE_REAR_R			= 315
BTN_KAPTIVO_REAR_R			= 316
BTN_LIGHT_BOARD_REAR_R		= 318

BTN_PC_MAIN_SIDE_L			= 411
BTN_PC_EXT_SIDE_L			= 412
BTN_EXTERNAL_SIDE_L			= 413
BTN_DOCCAM_SIDE_L			= 414
BTN_MERSIVE_SIDE_L			= 415
BTN_KAPTIVO_SIDE_L			= 416
BTN_LIGHT_BOARD_SIDE_L		= 418

BTN_PC_MAIN_SIDE_R			= 711
BTN_PC_EXT_SIDE_R			= 712
BTN_EXTERNAL_SIDE_R			= 713
BTN_DOCCAM_SIDE_R			= 714
BTN_MERSIVE_SIDE_R			= 715
BTN_KAPTIVO_SIDE_R			= 716
BTN_LIGHT_BOARD_SIDE_R		= 718

BTN_PC_MAIN_ALL				= 811
BTN_PC_EXT_ALL				= 812
BTN_EXTERNAL_ALL			= 813
BTN_DOCCAM_ALL				= 814
BTN_MERSIVE_ALL				= 815
BTN_KAPTIVO_ALL				= 816
BTN_LIGHT_BOARD_ALL			= 818

BTN_AUDIO_PC				= 511
BTN_AUDIO_EXTERNAL			= 513
BTN_AUDIO_MERSIVE			= 515

BTN_PRVW_ACTIVE_CAMERA		= 120
BTN_PRVW_PC_EXT				= 121
BTN_PRVW_REC				= 122

BTN_CAM_PWR				= 50
BTN_CAM_FRONT				= 51
BTN_CAM_REAR 				= 52 
BTN_CAM_DOC				= 53
BTN_CAM_KAPTIVO			= 54
BTN_CAM_LIGHT				= 55

BTN_START_PRESENTATION		= 22
BTN_PAGE_EXIT				= 23
BTN_TV_ALL_SHUT				= 24
BTN_CAMERA_POPUP			= 245
BTN_AVB_PIP_TOGGLE			= 246
BTN_AVB_SWAP_SOURCE		= 247

//Manual Routing Buttons...
BTN_SVSI_IN_1				= 2001
BTN_SVSI_IN_2				= 2002
BTN_SVSI_IN_3				= 2003
BTN_SVSI_IN_4				= 2004
BTN_SVSI_IN_5				= 2005
BTN_SVSI_IN_6				= 2006
BTN_SVSI_IN_7				= 2007
BTN_SVSI_IN_8				= 2008
BTN_SVSI_IN_9				= 2009
BTN_SVSI_IN_10				= 2010
BTN_SVSI_IN_11				= 2011
BTN_SVSI_IN_12				= 2012
BTN_SVSI_IN_13				= 2013
BTN_SVSI_IN_14				= 2014
BTN_SVSI_IN_15				= 2015
BTN_SVSI_IN_16				= 2016

BTN_SVSI_OUT_1				= 3001
BTN_SVSI_OUT_2				= 3002
BTN_SVSI_OUT_3				= 3003
BTN_SVSI_OUT_4				= 3004
BTN_SVSI_OUT_5				= 3005
BTN_SVSI_OUT_6				= 3006
BTN_SVSI_OUT_7				= 3007
BTN_SVSI_OUT_8				= 3008
BTN_SVSI_OUT_9				= 3009
BTN_SVSI_OUT_10				= 3010
BTN_SVSI_OUT_11				= 3011
BTN_SVSI_OUT_12				= 3012
BTN_SVSI_OUT_13				= 3013
BTN_SVSI_OUT_14				= 3014
BTN_SVSI_OUT_15				= 3015
BTN_SVSI_OUT_16				= 3016

BTN_SET_NUMBER				= 1501
BTN_SET_LOCATION			= 1500
BTN_SET_ALL					= 1502
BTN_LOAD_IO					= 1503

BTN_ROUTE_PAGE				= 3020
BTN_NET_BOOT				= 1000

DL_MUTE_CEILING_MICS			= 50

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

CHAR cControllerIP[15] = '172.21.6.200'
LONG nSVSI_Port = 50020
VOLATILE INTEGER nSVSIOnline
VOLATILE CHAR nAbleBuffer[500]

CHAR cAvBridge[15] = '172.21.6.204'
LONG nVaddio_Port = 23
VOLATILE INTEGER nVaddioBridgeOnline
VOLATILE INTEGER nVaddioSuccess_
VOLATILE INTEGER nPIPOn
VOLATILE INTEGER nBGSwap
VOLATILE CHAR nVaddioBridgeBuffer[100]

VOLATILE INTEGER nSource_Left 
VOLATILE INTEGER nSource_Right
VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER cIndexCamera
VOLATILE INTEGER nLivePreview_ //Is Camera Live or naw..
VOLATILE INTEGER nOnline_Rear //Camera
VOLATILE INTEGER nOnline_Front //Camera

VOLATILE INTEGER nOnlineLeft_
VOLATILE INTEGER nOnlineRight_
VOLATILE INTEGER nTPOnline
VOLATILE INTEGER nBoot_
VOLATILE INTEGER nSystemOn_ 

VOLATILE LONG lTLFeedback[] = {500};
VOLATILE LONG lTLFlash[] = {1000};
VOLATILE INTEGER iFlash

VOLATILE INTEGER nStreamChnl
VOLATILE CHAR nDecoderIP[15]

VOLATILE DEV vdvTP_Main[] = 
{
    dvTP_Main, 
    dvTP_Booth
}
VOLATILE INTEGER nStreamSend[] =
{
    STREAM_PC_MAIN,
    STREAM_PC_EXT,	
    STREAM_VGA_HDMI,
    STREAM_DOC_CAM,
    STREAM_MERSIVE,
    STREAM_KAPTIVO,
    STREAM_LIGHT_BOARD,
    STREAM_DL_1,
    STREAM_DL_2,	
    STREAM_DL_3
}
VOLATILE INTEGER nSourceLeftBtns[] = //Left + Center + Pearl Content
{
    BTN_PC_MAIN_L,
    BTN_PC_EXT_L,  
    BTN_EXTERNAL_L,
    BTN_DOCCAM_L,
    BTN_MERSIVE_L,
    BTN_KAPTIVO_L,
    BTN_LIGHT_BOARD_L
}
VOLATILE INTEGER nSourceRightBtns[] =
{
    BTN_PC_MAIN_R,
    BTN_PC_EXT_R,  
    BTN_EXTERNAL_R,
    BTN_DOCCAM_R,
    BTN_MERSIVE_R,
    BTN_KAPTIVO_R,
    BTN_LIGHT_BOARD_R
}
VOLATILE INTEGER nSourceRearLeftBtns[] = //Rear Left
{
    BTN_PC_MAIN_REAR_L,
    BTN_PC_EXT_REAR_L,  
    BTN_EXTERNAL_REAR_L,
    BTN_DOCCAM_REAR_L,
    BTN_MERSIVE_REAR_L,
    BTN_KAPTIVO_REAR_L,
    BTN_LIGHT_BOARD_REAR_L
}
VOLATILE INTEGER nSourceRearRightBtns[] = //Rear Right
{
    BTN_PC_MAIN_REAR_R,
    BTN_PC_EXT_REAR_R,  
    BTN_EXTERNAL_REAR_R,
    BTN_DOCCAM_REAR_R,
    BTN_MERSIVE_REAR_R,
    BTN_KAPTIVO_REAR_R,
    BTN_LIGHT_BOARD_REAR_R
}
VOLATILE INTEGER nSourceSideLeftBtns[] = //Rear Right
{
    BTN_PC_MAIN_SIDE_L,
    BTN_PC_EXT_SIDE_L,  
    BTN_EXTERNAL_SIDE_L,
    BTN_DOCCAM_SIDE_L,
    BTN_MERSIVE_SIDE_L,
    BTN_KAPTIVO_SIDE_L,
    BTN_LIGHT_BOARD_SIDE_L
}
VOLATILE INTEGER nSourceSideRightBtns[] = //Rear Right
{
    BTN_PC_MAIN_SIDE_R,
    BTN_PC_EXT_SIDE_R,  
    BTN_EXTERNAL_SIDE_R,
    BTN_DOCCAM_SIDE_R,
    BTN_MERSIVE_SIDE_R,
    BTN_KAPTIVO_SIDE_R,
    BTN_LIGHT_BOARD_SIDE_R
}
VOLATILE INTEGER nSourceAllBtns[] =
{
    BTN_PC_MAIN_ALL,
    BTN_PC_EXT_ALL,
    BTN_EXTERNAL_ALL,
    BTN_DOCCAM_ALL,
    BTN_MERSIVE_ALL,
    BTN_KAPTIVO_ALL,
    BTN_LIGHT_BOARD_ALL
}
VOLATILE INTEGER nVideoPrvwBtns[] =
{
    BTN_PRVW_PC_EXT,
    BTN_PRVW_REC,
    BTN_PRVW_ACTIVE_CAMERA
}
VOLATILE INTEGER nRouteSend[] =
{
    STREAM_PC_MAIN, //1
    STREAM_PC_EXT,
    STREAM_VGA_HDMI,
    STREAM_DOC_CAM,
    STREAM_MERSIVE, //5
    STREAM_CAM_FRONT,
    STREAM_CAM_REAR,
    STREAM_LIGHT_BOARD, //8
    STREAM_AV_BRIDGE, //9
    STREAM_DL_1, //10
    STREAM_DL_2, //11
    STREAM_DL_3, //12
    STREAM_KAPTIVO
}
VOLATILE INTEGER nSvsiInputBtns[] =
{
    BTN_SVSI_IN_1,		
    BTN_SVSI_IN_2,		
    BTN_SVSI_IN_3,		
    BTN_SVSI_IN_4,		
    BTN_SVSI_IN_5,				
    BTN_SVSI_IN_6,			
    BTN_SVSI_IN_7,				
    BTN_SVSI_IN_8,				
    BTN_SVSI_IN_9,				
    BTN_SVSI_IN_10,				
    BTN_SVSI_IN_11,				
    BTN_SVSI_IN_12
}
VOLATILE INTEGER nSvsiOutputBtns[] =
{
    BTN_SVSI_OUT_1,
    BTN_SVSI_OUT_2,
    BTN_SVSI_OUT_3,
    BTN_SVSI_OUT_4,
    BTN_SVSI_OUT_5,
    BTN_SVSI_OUT_6,
    BTN_SVSI_OUT_7,
    BTN_SVSI_OUT_8,
    BTN_SVSI_OUT_9,
    BTN_SVSI_OUT_10,
    BTN_SVSI_OUT_11
}
VOLATILE CHAR nDecoders[11][15] = //Need to fix this so its stays in variable form above...
{
    '10.10.0.101', //Front Left
    '10.10.0.102', //Front Right
    '10.10.0.103', //Rear Left
    '10.10.0.104', //Rear Right
    '10.10.0.105', //Side Left
    '10.10.0.106', //Side Right
    '10.10.0.107', //Lectern Monitor
    '10.10.0.108', //Lectern Monitor Right
    '10.10.0.109',
    '10.10.0.110',
    '10.10.0.111'
}
VOLATILE CHAR nSvsiInputNames[18][25] = //Type in Your Input Labels for DGX
{
    'PC Main',
    'PC Ext',
    'Lectern',
    'Doc Cam',
    'Mersive POD', //5
    'Camera Front',
    'Camera Rear',
    'Light Board',
    'AV Bridge', //9
    'DL 1',
    'DL 2',
    'DL 3',
    'Kaptivo'
}
VOLATILE CHAR nSvsiOutputName[16][25] =//Type in Your Output Labels for DGX
{
    'Display Front Left',
    'Display Front Right',
    'Display Rear Left',
    'Display Rear Right',
    'Display Side Left',
    'Display Side Right',
    'Lectern Left',
    'Lectern Right',
    'AVB 2x1-1',
    'AVB 2x1-2',
    'DL Capture'
}
VOLATILE INTEGER nCameraButtons[] =
{
    BTN_CAM_FRONT,
    BTN_CAM_REAR,
    BTN_CAM_DOC,
    BTN_CAM_KAPTIVO,
    BTN_CAM_LIGHT
}
VOLATILE INTEGER nSourceCameraIn[] =
{
    STREAM_CAM_FRONT,
    STREAM_CAM_REAR,
    STREAM_DOC_CAM,
    STREAM_KAPTIVO,
    STREAM_LIGHT_BOARD
}
VOLATILE CHAR nCameraPages[5][20] =
{
    '_Camera',
    '_Camera',
    '_Camera_DocCAm',
    '_Camera_Kaptivo',
    '_Camera_Board'
}
VOLATILE CHAR nCameraPageTitles[5][30] =
{
    'Audience Camera',
    'Instructor Camera',
    'Doc Camera',
    'Kaptivo Camera',
    'Light Board'
}
DEVCHAN dcNavBtns[] =
{
    {dvTP_Main, BTN_PC_MAIN_REAR_L},
    {dvTP_Main, BTN_PC_MAIN_REAR_R},
    {dvTP_Main, BTN_PC_MAIN_SIDE_L},
    {dvTP_Main, BTN_PC_MAIN_SIDE_R}
}
    

#INCLUDE 'Biamp_Tesira'
#INCLUDE 'SetMasterClock_'
#INCLUDE 'Shure_WM_Quad'
#INCLUDE 'PanasonicCameras'
#INCLUDE 'DL_Link'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main,BTN_PWR_OFF_L]) 
([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main,BTN_PWR_OFF_R]) 
([dvTP_Main, BTN_PWR_ON_REAR_L],[dvTP_Main,BTN_PWR_OFF_REAR_L])
([dvTP_Main, BTN_PWR_ON_REAR_R],[dvTP_Main,BTN_PWR_OFF_REAR_R])
([dvTP_Main, BTN_PWR_ON_SIDE_L],[dvTP_Main,BTN_PWR_OFF_SIDE_L])
([dvTP_Main, BTN_PWR_ON_SIDE_R],[dvTP_Main,BTN_PWR_OFF_SIDE_R])  

([dvTP_Main, BTN_START_PRESENTATION]..[dvTP_Main, BTN_TV_ALL_SHUT])
([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_LIGHT_BOARD_L])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_LIGHT_BOARD_R])
([dvTP_Main, BTN_PC_MAIN_REAR_L]..[dvTP_Main, BTN_LIGHT_BOARD_REAR_L])
([dvTP_Main, BTN_PC_MAIN_REAR_R]..[dvTP_Main, BTN_LIGHT_BOARD_REAR_R])
([dvTP_Main, BTN_PC_MAIN_SIDE_L]..[dvTP_Main, BTN_LIGHT_BOARD_SIDE_L])
([dvTP_Main, BTN_PC_MAIN_SIDE_R]..[dvTP_Main, BTN_LIGHT_BOARD_SIDE_R])
([dvTP_Main, BTN_PC_MAIN_ALL]..[dvTP_Main, BTN_LIGHT_BOARD_ALL])

([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_MERSIVE])
([dvTP_Main, BTN_CAM_FRONT]..[dvTP_Main, BTN_CAM_REAR])
([dvTP_Main, BTN_CAM_DOC]..[dvTP_Main, BTN_CAM_LIGHT])
([dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]..[dvTP_Main, BTN_PRVW_REC])

//rack...
([dvTP_Booth, BTN_PWR_ON_L],[dvTP_Booth,BTN_PWR_OFF_L]) 
([dvTP_Booth, BTN_PWR_ON_R],[dvTP_Booth,BTN_PWR_OFF_R]) 
([dvTP_Booth, BTN_PWR_ON_REAR_L],[dvTP_Booth,BTN_PWR_OFF_REAR_L])
([dvTP_Booth, BTN_PWR_ON_REAR_R],[dvTP_Booth,BTN_PWR_OFF_REAR_R])
([dvTP_Booth, BTN_PWR_ON_SIDE_L],[dvTP_Booth,BTN_PWR_OFF_SIDE_L])
([dvTP_Booth, BTN_PWR_ON_SIDE_R],[dvTP_Booth,BTN_PWR_OFF_SIDE_R])  

([dvTP_Booth, BTN_PC_MAIN_R]..[dvTP_Booth, BTN_LIGHT_BOARD_R])
([dvTP_Booth, BTN_PC_MAIN_REAR_L]..[dvTP_Booth, BTN_LIGHT_BOARD_REAR_L])
([dvTP_Booth, BTN_PC_MAIN_REAR_R]..[dvTP_Booth, BTN_LIGHT_BOARD_REAR_R])
([dvTP_Booth, BTN_PC_MAIN_SIDE_L]..[dvTP_Booth, BTN_LIGHT_BOARD_SIDE_L])
([dvTP_Booth, BTN_PC_MAIN_SIDE_R]..[dvTP_Booth, BTN_LIGHT_BOARD_SIDE_R])
([dvTP_Booth, BTN_PC_MAIN_ALL]..[dvTP_Booth, BTN_LIGHT_BOARD_ALL])

([dvTP_Booth, BTN_AUDIO_PC]..[dvTP_Booth, BTN_AUDIO_MERSIVE])

([dvTP_Booth, BTN_SVSI_IN_1]..[dvTP_Booth, BTN_SVSI_IN_16])
([dvTP_Booth, BTN_SVSI_OUT_1]..[dvTP_Booth, BTN_SVSI_OUT_16])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartVaddioConnection()
{
    IP_CLIENT_OPEN (dvVaddioBridge.PORT,cAvBridge,nVaddio_Port,1) //TCP Connection
    
    WAIT 20
    {
	fnGetVaddioRep()
    }
}
DEFINE_FUNCTION fnCloseVaddioConnection()
{
    IP_CLIENT_CLOSE (dvVaddioBridge.PORT)
}
DEFINE_FUNCTION fnReconnectVaddio()
{
    fnCloseVaddioConnection()
    WAIT 10
    {
	fnStartVaddioConnection()
    }
}
DEFINE_FUNCTION char[100] GetVaddioIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '" ;
	CASE 4 : iReturn = "'Unknown host'";
	CASE 6 : iReturn = "'Connection Refused'";
	CASE 7 : iReturn = "'Connection timed Out'";
	CASE 8 : iReturn = "'Unknown Connection Error'";
	CASE 9 : iReturn = "'Already Closed'";
	CASE 10 : iReturn = "'Binding Error'";
	CASE 11 : iReturn = "'Listening Error'";
	CASE 14 : iReturn = "'Local Port Already Used'";
	CASE 15 : iReturn = "'UDP Socket Already Listening'";
	CASE 16 : iReturn = "'Too Many Open Sockets'";
	CASE 17 : iReturn = "'Local Port Not Open'"
	
	DEFAULT : iReturn = "'(', ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION fnParseVaddioIP() //Parse Vaddio IP
{
    LOCAL_VAR CHAR cVaddioData[80]
    LOCAL_VAR CHAR cVaddioPassFind[25]
    LOCAL_VAR CHAR cVaddioOK[100]
    LOCAL_VAR CHAR cStatusPIP[15]
    
    WHILE (FIND_STRING(nVaddioBridgeBuffer, 'login',1) OR FIND_STRING(nVaddioBridgeBuffer,'Password:',1) OR FIND_STRING(nVaddioBridgeBuffer,"$0D,$0A",1))
    {
	cVaddioOK = REMOVE_STRING (nVaddioBridgeBuffer,"$0D,$0A",1)
	cVaddioData = REMOVE_STRING (nVaddioBridgeBuffer,'login',1)
	cVaddioPassFind = REMOVE_STRING (nVaddioBridgeBuffer,'Password:',1)
	
	
	IF (FIND_STRING(cVaddioData, 'login',1)) //Initial Login...
	{
	    SEND_STRING dvVaddioBridge, "AVB_LOGIN,CR"
		nVaddioSuccess_ = FALSE;
	}
	IF (FIND_STRING(cVaddioPassFind, 'Password:',1))
	{
	    SEND_STRING dvVaddioBridge, "AVB_PASS,CR"
		nVaddioSuccess_ = FALSE;
	}
	IF (FIND_STRING(cVaddioOK, 'Welcome admin',1))
	{
	    nVaddioSuccess_ = TRUE;
	    SEND_STRING dvDebug, "'Vaddio AVBridge 2x1 -Login Success!'"
	    
	    WAIT 10
	    {
		nBGSwap = FALSE;
		    SEND_STRING dvVaddioBridge, "AVB_INPUT_CAMERA,CR" //Set Default
	    }
	}
	IF (FIND_STRING (cVaddioOK,'Login incorrect',1))
	{
	    SEND_STRING dvDebug, "'Vaddio AVBridge 2x1 - Login Incorrect!! Try Again ModaSucka!!'"
	    SEND_STRING dvVaddioBridge, "CR"
	} 
	IF (FIND_STRING (cVaddioOK,'video program pip ',1)) //Direct On FB...
	{
	    nVaddioSuccess_ = TRUE;
	    REMOVE_STRING (cVaddioOK,'video program pip ',1)
	    cStatusPIP = cVaddioOK;
	    
	    IF (FIND_STRING(cStatusPIP,'on',1))
	    {
		nPIPOn = TRUE;
			ON [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	    IF (FIND_STRING(cStatusPIP,'off',1))
	    {
		    nPIPOn = FALSE;
			    OFF [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	}
	IF (FIND_STRING (cVaddioOK, 'pip:    ',1)) //From PIP Get Query Response
	{
	    nVaddioSuccess_ = TRUE;
	    
	    REMOVE_STRING (cVaddioOK, 'pip:    ',1)
		cStatusPIP = cVaddioOK;
	    IF (FIND_STRING(cStatusPIP,'on',1))
	    {
		    nPIPOn = TRUE;
			ON [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	    IF (FIND_STRING(cStatusPIP,'off',1))
	    {
		    nPIPOn = FALSE;
			    OFF [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	}
    }
}
DEFINE_FUNCTION fnGetVaddioRep()
{
    IF (nVaddioSuccess_ == TRUE)
    {
	SEND_STRING dvVaddioBridge, "AVB_PIP_GET,CR"
    }
}
DEFINE_FUNCTION fnStartConnection()
{
    IP_CLIENT_OPEN (dvController.PORT,cControllerIP,nSVSI_Port,1) //TCP Connection
    WAIT 20
    {
	fnGetSVSIRep()
    }
}
DEFINE_FUNCTION fnCloseConnection()
{
    IP_CLIENT_CLOSE (dvController.PORT)
}
DEFINE_FUNCTION fnReconnect()
{
    fnCloseConnection()
    WAIT 10
    {
	fnStartConnection()
    }
}
DEFINE_FUNCTION char[100] GetIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '" ;
	CASE 4 : iReturn = "'Unknown host'";
	CASE 6 : iReturn = "'Connection Refused'";
	CASE 7 : iReturn = "'Connection timed Out'";
	CASE 8 : iReturn = "'Unknown Connection Error'";
	CASE 9 : iReturn = "'Already Closed'";
	CASE 10 : iReturn = "'Binding Error'";
	CASE 11 : iReturn = "'Listening Error'";
	CASE 14 : iReturn = "'Local Port Already Used'";
	CASE 15 : iReturn = "'UDP Socket Already Listening'";
	CASE 16 : iReturn = "'Too Many Open Sockets'";
	CASE 17 : iReturn = "'Local Port Not Open'"
	
	DEFAULT : iReturn = "'(', ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION fnLoadTPEncoderIOs()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=LENGTH_ARRAY(nSvsiInputBtns); cLoop++)
    {
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(nSvsiInputBtns[cLoop]),',0,',ITOA(cLoop),$0A,$0D,nSvsiInputNames[cLoop]"
    }
}
DEFINE_FUNCTION fnLoadTPDecoderIOs()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=LENGTH_ARRAY(nSvsiOutputBtns); cLoop++)
    {
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(nSvSiOutputBtns[cLoop]),',0,',ITOA(cLoop),$0A,$0D,nSvsiOutputName[cLoop]"
    }
}
DEFINE_FUNCTION fnSystemCall (INTEGER nSys)
{
    SWITCH (nSys)
    {
	CASE BTN_START_PRESENTATION : //20
	{
	    nSystemOn_ = TRUE;
	    ON [vdvPipeFB, DL_SET_ALL_TVS_ON]
	    ON [dcNavBtns]
		fnPowerDisplays (BTN_PWR_ON_L)
		    fnPowerDisplays (BTN_PWR_ON_R)
		fnPowerDisplays (BTN_PWR_ON_REAR_L)
		    fnPowerDisplays (BTN_PWR_ON_REAR_R)
		fnPowerDisplays (BTN_PWR_ON_SIDE_L)
		    fnPowerDisplays (BTN_PWR_ON_SIDE_R)
		    
		    WAIT 20
		    {
			fnRouteVideoScriptLeft(STREAM_PC_MAIN)
			    fnRouteVideoScriptRight(STREAM_PC_EXT)
				fnRouteVideoRearLeft (STREAM_PC_MAIN)
				    fnRouteVideoRearRight (STREAM_PC_MAIN)
							fnRouteVideoSideLeft (STREAM_PC_MAIN)
				    fnRouteVideoSideRight (STREAM_PC_MAIN)
			    ON [dcDLDefaultFB]
		    }
	}
	CASE BTN_PAGE_EXIT : //21
	{		
		//
	}
	CASE BTN_TV_ALL_SHUT : //24
	{
	    nSystemOn_ = FALSE;
	    ON [vdvPipeFB, DL_SET_ALL_TVS_OFF]
		fnPowerDisplays (BTN_PWR_OFF_L)
		    fnPowerDisplays (BTN_PWR_OFF_R)
		fnPowerDisplays (BTN_PWR_OFF_REAR_L)
		    fnPowerDisplays (BTN_PWR_OFF_REAR_R)
		fnPowerDisplays (BTN_PWR_OFF_SIDE_L)
		    fnPowerDisplays (BTN_PWR_OFF_SIDE_R)

	    WAIT 20
	    {
			fnRouteVideoScriptLeft(STREAM_PC_MAIN)
			    fnRouteVideoScriptRight(STREAM_PC_EXT)
				fnRouteVideoRearLeft (STREAM_PC_MAIN)
				    fnRouteVideoRearRight (STREAM_PC_MAIN)
							fnRouteVideoSideLeft (STREAM_PC_MAIN)
				    fnRouteVideoSideRight (STREAM_PC_MAIN)
		    			ON [dcDLDefaultFB]
	    }
	}
    }
}
DEFINE_FUNCTION fnRouteVideoScriptLeft(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_FRONT_LEFT,' ',ITOA(cStream),CR" 
	SEND_STRING dvController, "'switch ',OUT_MONITOR_LEFT,' ',ITOA(cStream),CR"
    
    SWITCH (cStream)
    {
	CASE STREAM_PC_MAIN :
	CASE STREAM_PC_EXT :
	{
	    ON [vdvTP_Main, BTN_AUDIO_PC]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(STREAM_PC_MAIN),CR" 
	}
	CASE STREAM_VGA_HDMI :
	{
	    ON [vdvTP_Main, BTN_AUDIO_EXTERNAL]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
	}
	CASE STREAM_MERSIVE :
	{
	    ON [vdvTP_Main, BTN_AUDIO_MERSIVE]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
	}
    }
}
DEFINE_FUNCTION fnRouteVideoScriptRight(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_FRONT_RIGHT,' ',ITOA(cStream),CR" 
	SEND_STRING dvController, "'switch ',OUT_MONITOR_RIGHT,' ',ITOA(cStream),CR"

    SWITCH (cStream)
    {
	CASE STREAM_PC_MAIN :
	CASE STREAM_PC_EXT :
	{
	    ON [vdvTP_Main, BTN_AUDIO_PC]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(STREAM_PC_MAIN),CR" 
	}
	CASE STREAM_VGA_HDMI :
	{
	    ON [vdvTP_Main, BTN_AUDIO_EXTERNAL]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
	}
	CASE STREAM_MERSIVE :
	{
	    ON [vdvTP_Main, BTN_AUDIO_MERSIVE]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
	}
    }
}
DEFINE_FUNCTION fnRouteVideoRearLeft(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_REAR_LEFT,' ',ITOA(cStream),CR" 
}
DEFINE_FUNCTION fnRouteVideoRearRight(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_REAR_RIGHT,' ',ITOA(cStream),CR" 
}
DEFINE_FUNCTION fnRouteVideoSideLeft(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_SIDE_LEFT,' ',ITOA(cStream),CR" 
}
DEFINE_FUNCTION fnRouteVideoSideRight(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_SIDE_RIGHT,' ',ITOA(cStream),CR" 
}
DEFINE_FUNCTION fnRouteVideoDLPreview (INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DL_CAPTURE,' ',ITOA(cStream),CR" 
}
DEFINE_FUNCTION fnRouteVideoAllDisplays (INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_FRONT_LEFT,' ',ITOA(cStream),CR" 
	SEND_STRING dvController, "'switch ',OUT_MONITOR_LEFT,' ',ITOA(cStream),CR"
	
    
    SWITCH (cStream)
    {
	CASE STREAM_PC_MAIN :
	CASE STREAM_PC_EXT :
	{
	    SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
		ON [vdvTP_Main, BTN_AUDIO_PC]
	}
	CASE STREAM_VGA_HDMI :
	{
	    SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
		ON [vdvTP_Main, BTN_AUDIO_EXTERNAL]
	}
	CASE STREAM_MERSIVE :
	{
		    SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
		ON [vdvTP_Main, BTN_AUDIO_MERSIVE]
	}
    }
    
    WAIT 10
    {
    SEND_STRING dvController, "'switch ',OUT_DISPLAY_FRONT_RIGHT,' ',ITOA(cStream),CR" 
	SEND_STRING dvController, "'switch ',OUT_MONITOR_RIGHT,' ',ITOA(cStream),CR"
    }
    WAIT 20
    {
	SEND_STRING dvController, "'switch ',OUT_DISPLAY_SIDE_LEFT,' ',ITOA(cStream),CR" 
	SEND_STRING dvController, "'switch ',OUT_DISPLAY_SIDE_RIGHT,' ',ITOA(cStream),CR" 
    }
    WAIT 30
    {
	SEND_STRING dvController, "'switch ',OUT_DISPLAY_REAR_LEFT,' ',ITOA(cStream),CR" 
	SEND_STRING dvController, "'switch ',OUT_DISPLAY_REAR_RIGHT,' ',ITOA(cStream),CR" 
    }
}
DEFINE_FUNCTION fnRouteVideoPreview(INTEGER cIn)
{
    SEND_STRING dvController, "'switch ',OUT_MONITOR_RIGHT,' ',ITOA(cIn),CR"
}
DEFINE_FUNCTION fnParseControllerIP() //Parse SVSI Controller...
{
    STACK_VAR CHAR cResponse[500]
    STACK_VAR CHAR cMonitorSource[100]
    LOCAL_VAR CHAR cProjectorStat[47] //Total Hex Value I need only!
    STACK_VAR CHAR cActiveProjector[12]
    LOCAL_VAR CHAR cSharpPwr[2]
    STACK_VAR INTEGER cTemp_Source
    LOCAL_VAR CHAR cDug[47]   
    
    WHILE (FIND_STRING(nAbleBuffer,"$0D,$0A",1)OR FIND_STRING(nAbleBuffer,'</status>',1))
    {
	cResponse = REMOVE_STRING(nAbleBuffer,"$0D,$0A",1)
	cMonitorSource = REMOVE_STRING(nAbleBuffer,'</status>',1)

	IF (FIND_STRING (cResponse,"TALK_DISPLAY_FRONT_LEFT_IP,';'",1)) //Sharp IP Parsing
	{
	    REMOVE_STRING (cResponse,"TALK_DISPLAY_FRONT_LEFT_IP,';'",1)
	    cSharpPwr = LEFT_STRING(cResponse,2)
	    ON [vdvTP_Main, 601]
		ON [nOnlineLeft_]
	
	    SWITCH (cSharpPwr)
	    {
		CASE  '31' :
		{
		    ON [vdvTP_Main, BTN_PWR_ON_L]
			ON [vdvPipeFB, DL_PWR_ON_LEFT]
		}
		CASE  '30' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_L]
			ON [vdvPipeFB, DL_PWR_OFF_LEFT]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"TALK_DISPLAY_FRONT_RIGHT_IP,';'",1)) //Sharp IP Parsing...
	{
	    REMOVE_STRING (cResponse,"TALK_DISPLAY_FRONT_RIGHT_IP,';'",1)
		cSharpPwr = LEFT_STRING(cResponse,2)
		ON [vdvTP_Main, 611]
		    ON [nOnlineRight_]
	
	    SWITCH (cSharpPwr)
	    {
		CASE  '31' :
		{
		    ON [vdvTP_Main, BTN_PWR_ON_R]
			ON [vdvPipeFB, DL_PWR_ON_RIGHT]
		}
		CASE  '30' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_R]
			ON [vdvPipeFB, DL_PWR_OFF_RIGHT]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"TALK_DISPLAY_REAR_LEFT_IP,';2A 53 41 50 4F 57 52 '",1))
	{
	    REMOVE_STRING (cResponse,"TALK_DISPLAY_REAR_LEFT_IP,';2A 53 41 50 4F 57 52 '",1)
		cProjectorStat = cResponse;
		ON [vdvTP_Main, 621]
	
	    SWITCH (cProjectorStat)
	    {
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 31' :
		{
		    ON [vdvTP_Main, BTN_PWR_ON_REAR_L]
			ON [vdvPipeFB, DL_PWR_ON_REAR_L]
		}
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_REAR_L]
			ON [vdvPipeFB, DL_PWR_OFF_REAR_L]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"TALK_DISPLAY_REAR_RIGHT_IP,';2A 53 41 50 4F 57 52 '",1))
	{
	    REMOVE_STRING (cResponse,"TALK_DISPLAY_REAR_RIGHT_IP,';2A 53 41 50 4F 57 52 '",1)
		cProjectorStat = cResponse; //Remove 0A ending
		
		ON [vdvTP_Main, 631]
	
	    SWITCH (cProjectorStat)
	    {
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 31' :
		{
		    ON [vdvTP_Main, BTN_PWR_ON_REAR_R]
			ON [vdvPipeFB, DL_PWR_ON_REAR_R]
		}
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_REAR_R]
			ON [vdvPipeFB, DL_PWR_OFF_REAR_R]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"TALK_DISPLAY_SIDE_LEFT_IP,';2A 53 41 50 4F 57 52 '",1))
	{
	    REMOVE_STRING (cResponse,"TALK_DISPLAY_SIDE_LEFT_IP,';2A 53 41 50 4F 57 52 '",1)
		cProjectorStat = cResponse
		ON [vdvTP_Main, 641]
	
	    SWITCH (cProjectorStat)
	    {
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 31' :
		{
		    ON [vdvTP_Main, BTN_PWR_ON_SIDE_L]
			ON [vdvPipeFB, DL_PWR_ON_SIDE_L]
		}
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_SIDE_L]
			ON [vdvPipeFB, DL_PWR_OFF_SIDE_L]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"TALK_DISPLAY_SIDE_RIGHT_IP,';2A 53 41 50 4F 57 52 '",1))
	{
	    REMOVE_STRING (cResponse,"TALK_DISPLAY_SIDE_RIGHT_IP,';2A 53 41 50 4F 57 52 '",1)
		cProjectorStat = cResponse
		ON [vdvTP_Main, 661]
	
	    SWITCH (cProjectorStat)
	    {
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 31' :
		{
		    ON [vdvTP_Main, BTN_PWR_ON_SIDE_R]
			ON [vdvPipeFB, DL_PWR_ON_SIDE_R]
		}
		CASE  '30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_SIDE_R]
			ON [vdvPipeFB, DL_PWR_OFF_SIDE_R]
		}
	    }
	}
	IF (FIND_STRING (cMonitorSource,"'<status>'",1)) //Monitoring must be enabled...
	{
	    REMOVE_STRING (cMonitorSource, "'<status>'",1)
	    
	    cActiveProjector = LEFT_STRING (cMonitorSource, 11) //Pulls Decoder IP Address...    
		cTemp_Source = ATOI(MID_STRING (cMonitorSource, 33,2));
	    
	    SWITCH (cActiveProjector)
	    {
		CASE OUT_DISPLAY_FRONT_LEFT :
		{
		    nSource_Left = cTemp_Source
		    SWITCH (nSource_Left)
		    {
			CASE STREAM_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_L]
			CASE STREAM_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_L]
			CASE STREAM_DOC_CAM : ON [vdvTP_Main, BTN_DOCCAM_L]
			CASE STREAM_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_L]
			CASE STREAM_VGA_HDMI : ON [vdvTP_Main, BTN_EXTERNAL_L]
			CASE STREAM_KAPTIVO : ON [vdvTP_Main, BTN_KAPTIVO_L]
			CASE STREAM_LIGHT_BOARD : ON [vdvTP_Main, BTN_LIGHT_BOARD_L]
		    }
		}
		CASE OUT_DISPLAY_FRONT_RIGHT :
		{
		    nSource_Right = cTemp_Source
		    SWITCH (nSource_Right)
		    {
			CASE STREAM_PC_MAIN : 
			{
			    ON [vdvTP_Main, BTN_PC_MAIN_R]
			    		nLivePreview_ = FALSE;
				    OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
				    BREAK;
			}
			CASE STREAM_PC_EXT : 
			{
			    ON [vdvTP_Main, BTN_PC_EXT_R]
			    			    		nLivePreview_ = FALSE;
				    OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
				    BREAK;
			}
			CASE STREAM_DOC_CAM : 
			{
			    ON [vdvTP_Main, BTN_DOCCAM_R]
			    			    		nLivePreview_ = FALSE;
				    OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
				    BREAK;
			}
			CASE STREAM_MERSIVE : 
			{
			    ON [vdvTP_Main, BTN_MERSIVE_R]
				nLivePreview_ = FALSE;
				    OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
				    BREAK;
			}
			CASE STREAM_VGA_HDMI : 
			{
			    ON [vdvTP_Main, BTN_EXTERNAL_R]
				nLivePreview_ = FALSE;
				    OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
				    BREAK;
			}
			CASE STREAM_KAPTIVO : 
			{
			    ON [vdvTP_Main, BTN_KAPTIVO_R]
				nLivePreview_ = FALSE;
				    OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
				    BREAK;
			}
			CASE STREAM_LIGHT_BOARD : 
			{
			    ON [vdvTP_Main, BTN_LIGHT_BOARD_R]
			    			    		nLivePreview_ = FALSE;
				    OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
				    BREAK;
			}
		    }
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnQueryProjectorsIP()
{
    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_LEFT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_POWER_QUERY,CR"
    WAIT 20 SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_RIGHT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_POWER_QUERY,CR"
    
    WAIT 40 SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_REAR_LEFT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_QUERY,CR"
    WAIT 60 SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_REAR_RIGHT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_QUERY,CR"
    
    WAIT 80 SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_SIDE_LEFT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_QUERY,CR"
    WAIT 100 SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_SIDE_RIGHT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_QUERY,CR"
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME == TIME_REBOOT)
    {
	REBOOT (dvMaster)
    }
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME == TIME_SHUT)
    {
	fnSystemCall (BTN_TV_ALL_SHUT)
    }
}
DEFINE_FUNCTION fnPowerDisplays (INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_LEFT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_POWER_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_L]
		    ON [vdvPipeFB, DL_PWR_ON_LEFT]
	}
	CASE BTN_PWR_OFF_L :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_LEFT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_RS232_ON,CR"
	    WAIT 10
	    {
		SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_LEFT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_POWER_OFF,CR"
		ON [vdvTP_Main, BTN_PWR_OFF_L]
		    ON [vdvPipeFB, DL_PWR_OFF_LEFT]
	    }
	}
	CASE BTN_PWR_ON_R :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_RIGHT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_POWER_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_R]
		    ON [vdvPipeFB, DL_PWR_ON_RIGHT]
	}
	CASE BTN_PWR_OFF_R :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_RIGHT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_RS232_ON,CR"
	    WAIT 10
	    {
		SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_FRONT_RIGHT_IP,' ',TALK_SHARP_DISPLAY_PORT,' ',TV_SHARP_POWER_OFF,CR"
		ON [vdvTP_Main, BTN_PWR_OFF_R]
		    ON [vdvPipeFB, DL_PWR_OFF_RIGHT]
	    }
	}
	CASE BTN_PWR_ON_REAR_L :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_REAR_LEFT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_REAR_L]
		    ON [vdvPipeFB, DL_PWR_ON_REAR_L]
	}
	CASE BTN_PWR_OFF_REAR_L :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_REAR_LEFT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_OFF,CR"
		ON [vdvTP_Main, BTN_PWR_OFF_REAR_L]
		    ON [vdvPipeFB, DL_PWR_OFF_REAR_L]
	}
	CASE BTN_PWR_ON_REAR_R :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_REAR_RIGHT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_REAR_R]
		    ON [vdvPipeFB, DL_PWR_ON_REAR_R]
	}
	CASE BTN_PWR_OFF_REAR_R :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_REAR_RIGHT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_OFF,CR"
	    ON [vdvTP_Main, BTN_PWR_OFF_REAR_R]
		ON [vdvPipeFB, DL_PWR_OFF_REAR_R]
	}
	CASE BTN_PWR_ON_SIDE_L :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_SIDE_LEFT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_SIDE_L]
		    ON [vdvPipeFB, DL_PWR_ON_SIDE_L]
	}
	CASE BTN_PWR_OFF_SIDE_L :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_SIDE_LEFT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_OFF,CR"
	    ON [vdvTP_Main, BTN_PWR_OFF_SIDE_L]
		ON [vdvPipeFB, DL_PWR_OFF_SIDE_L]
	}
	CASE BTN_PWR_ON_SIDE_R :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_SIDE_RIGHT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_SIDE_R]
		   ON [vdvPipeFB, DL_PWR_ON_SIDE_R]
	}
	CASE BTN_PWR_OFF_SIDE_R :
	{
	    SEND_STRING dvController, "'tcpclient ',TALK_DISPLAY_SIDE_RIGHT_IP,' ',TALK_SONY_DISPLAY_PORT,' ',TV_SONY_POWER_OFF,CR"
		ON [vdvTP_Main, BTN_PWR_OFF_SIDE_R]
		    ON [vdvPipeFB, DL_PWR_OFF_SIDE_R]
	}
    }
}
DEFINE_FUNCTION fnGetSVSIRep()
{
    SEND_STRING dvController, "'monitor ',OUT_DISPLAY_FRONT_LEFT,CR" //Enable device change status for Video Routing...
    WAIT 10 SEND_STRING dvController, "'monitor ',OUT_DISPLAY_FRONT_RIGHT,CR"
    
    WAIT 20 SEND_STRING dvController, "'readresponse ',OUT_DISPLAY_FRONT_LEFT,CR" //Enable device change status for Decoder TX/RX
    WAIT 25 SEND_STRING dvController, "'readresponse ',OUT_DISPLAY_FRONT_RIGHT,CR"
    WAIT 30 SEND_STRING dvController, "'readresponse ',OUT_DISPLAY_REAR_LEFT,CR"
    WAIT 35 SEND_STRING dvController, "'readresponse ',OUT_DISPLAY_REAR_RIGHT,CR"
    WAIT 40 SEND_STRING dvController, "'readresponse ',OUT_DISPLAY_SIDE_LEFT,CR"
    WAIT 45 SEND_STRING dvController, "'readresponse ',OUT_DISPLAY_SIDE_RIGHT,CR"
    
    WAIT 50 SEND_STRING dvController, "'monitornotify ',OUT_DISPLAY_FRONT_LEFT,CR" //Get Current State...
    WAIT 60 SEND_STRING dvController, "'monitornotify ',OUT_DISPLAY_FRONT_RIGHT,CR" //Get Current State
    
    //WAIT 120 fnQueryProjectorsSerial()
    WAIT 100 fnQueryProjectorsIP()
}
DEFINE_FUNCTION fnRouteCameraToUSB (INTEGER cStream)
{
    SWITCH (cStream)
    {
	CASE STREAM_CAM_FRONT :
	{
	    SEND_STRING dvController, "'switch ',OUT_AV_BRIDGE_1,' ',ITOA(cStream),CR"
		[dvTP_Main, BTN_CAM_PWR] = nOnline_Front
	}
	CASE STREAM_CAM_REAR :
	{
	    [dvTP_Main, BTN_CAM_PWR] = nOnline_Rear
		SEND_STRING dvController, "'switch ',OUT_AV_BRIDGE_1,' ',ITOA(cStream),CR"
	}
	CASE STREAM_DOC_CAM :
	CASE STREAM_KAPTIVO :
	CASE STREAM_LIGHT_BOARD :
	{
	    SEND_STRING dvController, "'switch ',OUT_AV_BRIDGE_2,' ',ITOA(cStream),CR"
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


nBoot_ = TRUE;

TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	CREATE_BUFFER dvController,nAbleBuffer; 
	    CREATE_BUFFER dvVaddioBridge,nVaddioBridgeBuffer;

WAIT 300
{
    cIndexCamera = 2; //Set Rear Control Default
	fnRouteCameraToUSB (STREAM_CAM_REAR)
	    ON [dvTP_Main, nCameraButtons[cIndexCamera]]
}
WAIT 450
{
    nBoot_ = FALSE;
}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main,BTN_START_PRESENTATION] 
BUTTON_EVENT [vdvTP_Main,BTN_PAGE_EXIT] 
BUTTON_EVENT [vdvTP_Main,BTN_TV_ALL_SHUT] //System Mode Calls...
{
  PUSH:
  {
    ON [dvTP_Main, BUTTON.INPUT.CHANNEL]
    
    SWITCH(BUTTON.INPUT.CHANNEL)
    {
	CASE BTN_START_PRESENTATION: fnSystemCall (BTN_START_PRESENTATION)   
	CASE BTN_PAGE_EXIT: fnSystemCall (BTN_PAGE_EXIT)  
	CASE BTN_TV_ALL_SHUT: fnSystemCall (BTN_TV_ALL_SHUT)  
    }          
  }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_L]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_L] //Front Left TV's...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L : fnPowerDisplays (BTN_PWR_ON_L)
	    CASE BTN_PWR_OFF_L : fnPowerDisplays (BTN_PWR_OFF_L)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_R]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_R] //Front Right TV's
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R : fnPowerDisplays (BTN_PWR_ON_R)
	    CASE BTN_PWR_OFF_R : fnPowerDisplays (BTN_PWR_OFF_R)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_REAR_L]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_REAR_L] //Rear Left TV's
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_REAR_L : fnPowerDisplays (BTN_PWR_ON_REAR_L)
	    CASE BTN_PWR_OFF_REAR_L : fnPowerDisplays (BTN_PWR_OFF_REAR_L)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_REAR_R]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_REAR_R] //Rear Right Tv's
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_REAR_R : fnPowerDisplays (BTN_PWR_ON_REAR_R)
	    CASE BTN_PWR_OFF_REAR_R : fnPowerDisplays (BTN_PWR_OFF_REAR_R)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_SIDE_L]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_SIDE_L] //Side Left TV's
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_SIDE_L : fnPowerDisplays (BTN_PWR_ON_SIDE_L)
	    CASE BTN_PWR_OFF_SIDE_L : fnPowerDisplays (BTN_PWR_OFF_SIDE_L)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_SIDE_R]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_SIDE_R] //side Right TV's
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_SIDE_R : fnPowerDisplays (BTN_PWR_ON_SIDE_R)
	    CASE BTN_PWR_OFF_SIDE_R : fnPowerDisplays (BTN_PWR_OFF_SIDE_R)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceLeftBtns] //Front Left TV+Monitor Video...
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	nSTDX = GET_LAST (nSourceLeftBtns)
	
	    fnRouteVideoScriptLeft(nStreamSend[nSTDX])
		ON [vdvTP_Main, nSourceLeftBtns[nSTDX]] //Video FB
		    ON [vdvPipeFB, dcChanFrontVidLeft[nSTDX]]//FB to DL
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceRightBtns] //Front Right TV+Monitor Video...
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	    nSTDX = GET_LAST (nSourceRightBtns)
	fnRouteVideoScriptRight(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceRightBtns[nSTDX]] //Video FB
		ON [vdvPipeFB, dcChanFrontVidRight[nSTDX]]
		
		nLivePreview_ = FALSE;
		OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceRearLeftBtns] //Rear Left TV+Monitor Video...
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	    nSTDX = GET_LAST (nSourceRearLeftBtns)
	fnRouteVideoRearLeft(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceRearLeftBtns[nSTDX]] //Video FB
		ON [vdvPipeFB, dcChanRearVidLeft[nSTDX]]
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceRearRightBtns] //Rear Right TV+Monitor Video...
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	    nSTDX = GET_LAST (nSourceRearRightBtns)
	fnRouteVideoRearRight(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceRearRightBtns[nSTDX]] //Video FB
		ON [vdvPipeFB, dcChanRearVidRight[nSTDX]]
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceSideLeftBtns] //Rear Right TV+Monitor Video...
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	    nSTDX = GET_LAST (nSourceSideLeftBtns)
	fnRouteVideoSideLeft(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceSideLeftBtns[nSTDX]] //Video FB
		ON [vdvPipeFB, dcChanSideVidLeft[nSTDX]]
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceSideRightBtns] //Rear Right TV+Monitor Video...
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	    nSTDX = GET_LAST (nSourceSideRightBtns)
	fnRouteVideoSideRight(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceSideRightBtns[nSTDX]] //Video FB
		ON [vdvPipeFB, dcChanSideVidRight[nSTDX]]
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceAllBtns] //Rear Right TV+Monitor Video...
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	    nSTDX = GET_LAST (nSourceAllBtns)
	fnRouteVideoAllDisplays(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceAllBtns[nSTDX]] //Video FB
    }
}
BUTTON_EVENT [vdvTP_Main, nVideoPrvwBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER cSTX
	cSTX = GET_LAST (nVideoPrvwBtns)
	
	ON [vdvTP_Main, nVideoPrvwBtns[cSTX]] //FB...
	
	SWITCH (cSTX)
	{
	    CASE 1 : fnRouteVideoPreview (STREAM_PC_EXT)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nCameraButtons] //Rear
{
    PUSH :
    {
	cIndexCamera = GET_LAST (nCameraButtons);
	//SEND_COMMAND dvTP_Main, "'^PPX'" //Make sure we reset/close first...
	//SEND_COMMAND dvTP_Main, "'^PPN-',nCameraPages[cIndexCamera]" //Call correct Page
	    fnRouteCameraToUSB (nSourceCameraIn[cIndexCamera]) //Index correct source..
	    TOTAL_OFF [dvTP_Main, nPresetSelect]
	    ON [dvTP_Main, nCameraButtons[cIndexCamera]] //Set FB
	
	    SWITCH (cIndexCamera)
	    {
		CASE 1 :
		CASE 2 :
		{
		    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Set Correct Title
		    BREAK;
		}
		DEFAULT :
		{
		    //
		}
	    }	    
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
{
    PUSH :
    {
	IF ( nLivePreview_ == FALSE)
	{
	    ON [dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
		fnRouteVideoPreview (STREAM_AV_BRIDGE)
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
	//SEND_COMMAND dvTP_Main, "'^PPN-',nCameraPages[cIndexCamera]" //Load appropriate Page...
	SEND_COMMAND dvTP_Main, "'^PPN-_Camera'"
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Load Title
    }
}
BUTTON_EVENT [dvTP_Main, BTN_SET_NUMBER]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL
	SEND_COMMAND dvTP_Main, "'@TKP'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND dvTP_Main, "'^TKP'"
	#END_IF
    }
}
BUTTON_EVENT [dvTP_Main, BTN_SET_LOCATION]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL 
	SEND_COMMAND dvTP_Main, "'@AKB'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND dvTP_Main, "'^AKB'"
	#END_IF
    }
}
BUTTON_EVENT [dvTP_Main, BTN_SET_ALL]
{
    PUSH :
    {
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nRoom_Location"
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_LOAD_IO]
{
    PUSH :
    {
	fnLoadTPEncoderIOs()
	    fnLoadTPDecoderIOs()
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_ROUTE_PAGE]
{
    HOLD [80] :
    {
	SEND_COMMAND dvTP_Main, "'^PPN-SVSIRouting'"
    }
    RELEASE :
    {
    	fnLoadTPEncoderIOs()
	    fnLoadTPDecoderIOs()
    }
}
BUTTON_EVENT [vdvTP_Main, nSvsiInputBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nChan 
	nChan = GET_LAST (nSvsiInputBtns)
	
	ON [vdvTP_Main, nSvsiInputBtns[nChan]]
	    nStreamChnl = nRouteSend[nChan]
    }
}
BUTTON_EVENT [vdvTP_Main, nSvsiOutputBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nDec 
	
	nDec = GET_LAST (nSvsiOutputBtns)

	ON [vdvTP_Main, nSvsiOutputBtns[nDec]] 

	    IF (LENGTH_STRING (nStreamChnl) > 0)
	    {
		SEND_STRING dvController, "'switch ',nDecoders[nDec],' ',ITOA(nStreamChnl),CR"
	    }
	    WAIT 20
	    {
		    TOTAL_OFF [vdvTP_Main, nSvsiInputBtns]
		    TOTAL_OFF [vdvTP_Main, nSvsiOutputBtns]
		    nStreamChnl = 0
	    }
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
{
    PUSH :
    {
	IF (nPIPOn == FALSE)
	{
	    SEND_STRING dvVaddioBridge, "AVB_PIP_ON, CR"
		ON [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	}
	ELSE
	{
	    SEND_STRING dvVaddioBridge, "AVB_PIP_OFF, CR"
		OFF [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
{
    PUSH :
    {
	IF (nBGSwap == FALSE)
	{
	    SEND_STRING dvVaddioBridge, "AVB_INPUT_DOC_CAM,CR"
		nBGSwap = TRUE;
		    ON [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
	}
	ELSE
	{
	    SEND_STRING dvVaddioBridge, "AVB_INPUT_CAMERA,CR"
		nBGSwap = FALSE;
		    OFF [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Main] //
{
    ONLINE :
    {
	nTPOnline = TRUE;
	
	#IF_DEFINED G4PANEL
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'" //Make Your Presence Known...
	#END_IF
	
	#IF_DEFINED G5PANEL 
	SEND_COMMAND DATA.DEVICE, "'^ADP'" //Make Your Presence Known...
	#END_IF
	
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	
	IF (nBoot_ == FALSE)
	{
	    WAIT 10 SEND_STRING dvController, "'monitornotify ',OUT_DISPLAY_FRONT_LEFT,CR" //Get Current State...
	    WAIT 30 SEND_STRING dvController, "'monitornotify ',OUT_DISPLAY_FRONT_RIGHT,CR" //Get Current State
	}
	
	WAIT 100
	{
	    fnLoadTPEncoderIOs()
		fnLoadTPDecoderIOs()
	}
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
DATA_EVENT [dvController]
{
    ONLINE :
    {
	nSVSIOnline = TRUE;
	ON [vdvTP_Main, BTN_NET_BOOT]
    }
    OFFLINE :
    {
	nSVSIOnline = FALSE;
	    OFF [vdvTP_Main, BTN_NET_BOOT]
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvController : onerror : ',GetIpError(DATA.NUMBER)");
	SEND_STRING 0, "'Controller onerror : ',GetIpError(DATA.NUMBER)";
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 17 :
	    {
		nSVSIOnline = FALSE;
		    OFF [vdvTP_Main, BTN_NET_BOOT]
			fnReconnect()
	    }
	    DEFAULT :
	    {
		nSVSIOnline = FALSE;
		    OFF [vdvTP_Main, BTN_NET_BOOT]
	    }
	}
    }
    STRING :
    {
	nSVSIOnline = TRUE;
	ON [vdvTP_Main, BTN_NET_BOOT]
	
	AMX_LOG (AMX_INFO, "'dvController : ',DATA.TEXT");
	    SEND_STRING dvDebug, "'From SVSI ',nAbleBuffer"
		SEND_COMMAND vdvPipeFB, "'Classroom N-Command : ', nAbleBuffer"
	
	fnParseControllerIP()
	//fnParseControllerSerial()
    }
}
DATA_EVENT [dvVaddioBridge]
{
    ONLINE :
    {
	nVaddioBridgeOnline = TRUE;
    }
    OFFLINE :
    {
	nVaddioBridgeOnline = FALSE;
    }
    ONERROR :
    {
	SEND_STRING dvDebug, "'AVBridg 2x1 Error : ',GetVaddioIpError(DATA.NUMBER)"
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 :
	    {
		nVaddioBridgeOnline = FALSE;
		    fnReconnectVaddio()
	    }
	    DEFAULT :
	    {
		nVaddioBridgeOnline = FALSE;
	    }
	}
    }
    STRING :
    {
	nVaddioBridgeOnline = TRUE;
	    fnParseVaddioIP()
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnKill()
    fnReboot()
    
    WAIT 250 //30 Second Loop
    {
	IF (nVaddioBridgeOnline == FALSE)
	{
	    fnStartVaddioConnection()
	}
	ELSE
	{
	    fnGetVaddioRep()
	}
    }
        
    WAIT 450 //Second Loop
    {
	IF (nSVSIOnline == FALSE)
	{
	    fnStartConnection()
	}
	ELSE
	{
	    fnQueryProjectorsIP()
	}
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


