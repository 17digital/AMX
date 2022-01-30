PROGRAM_NAME='Master'
(***********************************************************)
(*  FILE CREATED ON: 10/31/2019  AT: 11:07:31              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/26/2020  AT: 13:36:31        *)
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
	
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster =				0:1:0
dvDebug =				0:0:0
dvController =			0:2:0 //172.21.4.51
dvTP_Main =			10001:1:0
dvTP_Booth = 			10002:1:0
dvRelays =			5001:21:0
dvVaddioIO =			5001:22:0 //Vaddio Triggers...
dvLights			=	5001:2:0	//Crestron Lighting
vdvPipe =					33333:1:0

//Define Touch Panel Type
#WARN 'Check correct Panel Type'
//#DEFINE G4PANEL
#DEFINE G5PANEL //Ex..MT-702, MT1002, MXT701

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Relays
screen_up_left					= 1
screen_down_left				= 2
screen_up_right				= 3
screen_down_right				= 4
screen_up_center				= 5
screen_down_center			= 6 

//Lights....specifically for 2447....
LIGHTS_AREA				= 13
LIGHTS_SCENE1			= 225
LIGHTS_SCENE2			= 226
LIGHTS_SCENE3			= 227
LIGHTS_SCENE4			= 228
LIGHTS_OFF				= 241

OUT_PROJECTOR_LEFT			  = '10.10.0.228' //Sony
OUT_PROJECTOR_RIGHT		  	= '10.10.0.229' //Sony
OUT_PROJECTOR_CENTER		  = '10.10.0.230'
OUT_PROJECTOR_REAR			= '10.10.0.230'
OUT_MONITOR_LEFT			= '10.10.0.231' //Lectern Monitor
OUT_MONITOR_RIGHT			= '10.10.0.232' //Dell Monitor
OUT_DL_FEED					= '10.10.0.233' //Send Content to DL
OUT_AUDIO_ATC				= '10.10.0.234'

//Projector PJ Talk...
TALK_PROJECTOR_LEFT_IP		= '10.10.0.157'
TALK_PROJECTOR_RIGHT_IP		= '10.10.0.158'
TALK_PROJECTOR_REAR_IP		= '10.10.0.159'
TALK_PROJECTOR_PORT			= '53484' //Enable PJ Talk...

//Projector Commands..
CHAR PROJECTOR_IP_PWR_QUERY[] = '02 0A 53 4F 4E 59 00 70 00 08 A9 01 02 01 00 00 03 9A'
CHAR PROJECTOR_IP_PWR_ON[] =	'02 0A 53 4F 4E 59 00 70 00 08 A9 17 2E 00 00 00 3F 9A'
CHAR PROJECTOR_IP_PWR_OFF[] =	'02 0A 53 4F 4E 59 00 70 00 08 A9 17 2F 00 00 00 3F 9A'
CHAR PROJECTOR_IP_BLANK_ON[] =	'02 0A 53 4F 4E 59 00 70 00 08 A9 00 30 00 00 01 31 9A'
CHAR PROJECTOR_IP_BLANK_OFF[] =	'02 0A 53 4F 4E 59 00 70 00 08 A9 00 30 00 00 00 30 9A'
CHAR PROJECTOR_IP_BLANK_QUERY[] =	'02 0A 53 4F 4E 59 00 70 00 08 A9 00 30 01 00 00 31 9A'

//Projector Commands...
CHAR PROJECTOR_RS232_PWR_QUERY[] =	'A9 01 02 01 00 00 03 9A'
CHAR PROJECTOR_RS232_PWR_ON[] =		'A9 17 2E 00 00 00 3F 9A'
CHAR PROJECTOR_RS232_PWR_OFF[] =	'A9 17 2F 00 00 00 3F 9A'
CHAR PROJECTOR_RS232_BLANK_ON[] =	'A9 00 30 00 00 01 31 9A'
CHAR PROJECTOR_RS232_BLANK_OFF[] =	'A9 00 30 00 00 00 30 9A'
CHAR PROJECTOR_RS232_BLANK_QUERY[] =	'A9 00 30 01 00 00 31 9A'

//Library Sony Projector Channels (N-Controller)
PROJECTOR_QUERY			= 1
//PROJECTOR_POWER_ON		= 2
//PROJECTOR_POWER_OFF		= 3
//PROJECTOR_BLANK_ON		= 4
//PROJECTOR_BLANK_OFF		= 5
PROJECTOR_BLANK_QUERY		= 2

//Encoder Stream Numbers...
STREAM_PC_MAIN				= 41 // -30 / +70 / + 470
STREAM_PC_EXT				= 42 //
STREAM_VGA_HDMI			= 43 //
STREAM_DOC_CAM			= 44  //
STREAM_MERSIVE				= 45
STREAM_CAMERA_R			= 46 //
STREAM_DL_L					= 47 //
STREAM_DL_R					= 48 //
STREAM_DL_PROD				= 49 //

//timelines...
TL_FEEDBACK					= 1
TL_ON_SEQ_L					= 91
TL_OFF_SEQ_L					= 92
TL_ON_SEQ_R					= 93
TL_OFF_SEQ_R					= 94
TL_STATUS_L					= 95
TL_STATUS_R					= 96
TL_STATUS_REAR				= 97
TL_SHUTDOWN				= 100
SET_RUN_TIME				= 10 //10 Second Startup/Shutdown..

CR 								= 13
LF 								= 10

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100
TXT_CAMERA_VIEW			= 23

//Times....
ONE_SECOND					= 10
ONE_MINUTE					= ONE_SECOND * 60
ONE_HOUR					= ONE_MINUTE * 60

TIME_REBOOT					= '06:00:00'
TIME_SHUT					= '21:30:00'


//Btns....
BTN_PWR_ON_L			= 1
BTN_PWR_OFF_L			= 2
BTN_BLANK_L					= 3
BTN_SCREEN_UP_L			= 4
BTN_SCREEN_DN_L			= 5
BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L					= 12
BTN_EXTERNAL_L				= 13
BTN_DOCCAM_L				= 14
BTN_MERSIVE_L				= 15

BTN_PWR_ON_R			= 101
BTN_PWR_OFF_R			= 102
BTN_BLANK_R					= 103
BTN_SCREEN_UP_R			= 104
BTN_SCREEN_DN_R			= 105
BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R					= 112
BTN_EXTERNAL_R				= 113
BTN_DOCCAM_R				= 114
BTN_MERSIVE_R				= 115

BTN_PWR_ON_REAR			= 201
BTN_PWR_OFF_REAR			= 202
BTN_BLANK_REAR				= 203
BTN_SCREEN_UP_REAR			= 204
BTN_SCREEN_DN_REAR			= 205
BTN_FOLLOW_LEFT				= 211
BTN_FOLLOW_NOTES			= 212

BTN_AUDIO_PC				= 511
BTN_AUDIO_EXTERNAL			= 513
BTN_AUDIO_MERSIVE			= 515

BTN_PRVW_ACTIVE_CAMERA		= 120 //Rear Only...
BTN_PRVW_PC_EXT				= 121

BTN_LIGHTS_OFF				= 801
BTN_LIGHTS_SCENE1			= 802
BTN_LIGHTS_SCENE2			= 803
BTN_LIGHTS_SCENE3			= 804
BTN_LIGHTS_SCENE4			= 805

BTN_SET_NUMBER					= 1500
BTN_SET_LOCATION				= 1501
BTN_SET_ALL						= 1502


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
BTN_SVSI_OUT_10			= 3010
BTN_SVSI_OUT_11			= 3011
BTN_SVSI_OUT_12			= 3012
BTN_SVSI_OUT_13			= 3013
BTN_SVSI_OUT_14			= 3014
BTN_SVSI_OUT_15			= 3015
BTN_SVSI_OUT_16			= 3016


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

CHAR cControllerIP[15] = '172.21.4.51'
LONG nSVSI_Port = 50020
VOLATILE INTEGER nSVSIOnline
VOLATILE CHAR nAbleBuffer[500]

VOLATILE INTEGER cLockOutLeft
VOLATILE INTEGER cLockOutRight
VOLATILE INTEGER cLockOutRear

VOLATILE INTEGER nPwrStateLeft
VOLATILE INTEGER nPwrStateRight
VOLATILE INTEGER nPwrStateRear

VOLATILE INTEGER nOnlineLeft_
VOLATILE INTEGER nOnlineRight_
VOLATILE INTEGER nOnlineRear_

VOLATILE INTEGER nMute_Left;
VOLATILE INTEGER nMute_Right;
VOLATILE INTEGER nMute_Rear;

VOLATILE INTEGER nBoot_
VOLATILE INTEGER nTpOnline;
VOLATILE INTEGER nSource_Left
VOLATILE INTEGER nSource_Right
VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nCurrentLightsScene
VOLATILE INTEGER nLivePreview_ //Is Camera Live or naw..
VOLATILE INTEGER nRearFollow_

VOLATILE LONG lTLFeedback[] = {500};
VOLATILE LONG lTLPwrStatus[] = {1000};

VOLATILE INTEGER nStreamChnl
VOLATILE CHAR nDecoderIP[15]

VOLATILE DEV vdvTP_Main[] = 
{
    dvTP_Main
}  
VOLATILE INTEGER nStreamSend[] =
{
    STREAM_PC_MAIN,
    STREAM_PC_EXT,
    STREAM_VGA_HDMI,
    STREAM_DOC_CAM,
    STREAM_MERSIVE,
    STREAM_CAMERA_R,
    STREAM_DL_L,
    STREAM_DL_R,
    STREAM_DL_PROD    
}
VOLATILE INTEGER nSourceLeftBtns[] = //Left + Center + Pearl Content
{
    BTN_PC_MAIN_L, 
    BTN_PC_EXT_L,  
    BTN_EXTERNAL_L,
    BTN_DOCCAM_L,
    BTN_MERSIVE_L
}
VOLATILE INTEGER nSourceRightBtns[] =
{
    BTN_PC_MAIN_R, //Source 1
    BTN_PC_EXT_R,  //Source 2
    BTN_EXTERNAL_R,
    BTN_DOCCAM_R,
    BTN_MERSIVE_R
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
    BTN_SVSI_IN_12,				
    BTN_SVSI_IN_13,
    BTN_SVSI_IN_14,
    BTN_SVSI_IN_15,
    BTN_SVSI_IN_16
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
    BTN_SVSI_OUT_11,
    BTN_SVSI_OUT_12,
    BTN_SVSI_OUT_13,
    BTN_SVSI_OUT_14,
    BTN_SVSI_OUT_15,
    BTN_SVSI_OUT_16
}
VOLATILE CHAR nDecoders[7][15] = //Need to fix this so its stays in variable form above...
{
    '10.10.0.228', //Projector Left 152
    '10.10.0.229', //Projector Right
    '10.10.0.230', //Projector Center
    '10.10.0.231', //Monitor Left
    '10.10.0.232',  //Monitor Right
    '10.10.0.233', //152 Projector Left
    '10.10.0.234'  //152 Projector Right
}
VOLATILE CHAR nSvsiInputNames[9][25] = //Type in Your Input Labels for DGX
{
    'PC Main',
    'PC Ext',
    'Laptop Lectern',
    'Doc Cam',
    'Mersive POD',
    'Camera Rear',
    'DL 1',
    'DL 2',
    'DL 3'
}
VOLATILE CHAR nSvsiOutputName[6][25] =//Type in Your Output Labels for DGX
{
    'Projector Left',
    'Projector Right',
    'Projector Rear',
    'Monitor Left',
    'Monitor Right',
    'DL Capture'
}
VOLATILE INTEGER nLightsBtns[]=
{
    BTN_LIGHTS_OFF,			
    BTN_LIGHTS_SCENE1,
    BTN_LIGHTS_SCENE2,			
    BTN_LIGHTS_SCENE3,		
    BTN_LIGHTS_SCENE4			
}
VOLATILE INTEGER nSendLights[] =
{
    LIGHTS_OFF,
    LIGHTS_SCENE1,		
    LIGHTS_SCENE2,	
    LIGHTS_SCENE3,		
    LIGHTS_SCENE4		
}
VOLATILE LONG lTLPwrSequenceLeft[] =
{
    0, //Initial Set
    1000, //1 Second
    3000 //3 Seconds
}
VOLATILE LONG lTLPwrSequenceRight[] =
{
    0, //Initial Set
    1000, //1 Second
    3000 //3 Seconds
}
VOLATILE LONG lTLPwrShutdown[] =
{
    0,
    2000, //Left
    3000, //Right
    3000, //Rear
    9000 //Reset...
}

#INCLUDE 'Biamp_Tesira'
#INCLUDE 'Vaddio_Connect_IP'
#INCLUDE 'DL_Link'
#INCLUDE 'SetMasterClock_'
#INCLUDE 'Shure_WM_Quad'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main,BTN_PWR_OFF_L]) 
([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main,BTN_PWR_OFF_R]) 
([dvTP_Main, BTN_PWR_ON_REAR],[dvTP_Main,BTN_PWR_OFF_REAR]) 
([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_MERSIVE_L])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_MERSIVE_R])
([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_MERSIVE])

([dvTP_Main, BTN_FOLLOW_LEFT],[dvTP_Main, BTN_FOLLOW_NOTES])

([dvTP_Main, BTN_LIGHTS_OFF]..[dvTP_Main, BTN_LIGHTS_SCENE4])

([dvTP_Main, BTN_SVSI_IN_1]..[dvTP_Main, BTN_SVSI_IN_9])
([dvTP_Main, BTN_SVSI_OUT_1]..[dvTP_Main, BTN_SVSI_OUT_6])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartSVSIConnection()
{
    IP_CLIENT_OPEN (dvController.PORT,cControllerIP,nSVSI_Port,1) //TCP Connection
    WAIT 20
    {
	fnGetSVSIRep()
    }
}
DEFINE_FUNCTION fnCloseSVSIConnection()
{
    IP_CLIENT_CLOSE (dvController.PORT)
}
DEFINE_FUNCTION fnSVSIReconnect()
{
    fnCloseSVSIConnection()
    WAIT 10
    {
	fnStartSVSIConnection()
    }
}
DEFINE_FUNCTION char[100] GetSVSIIpError (LONG iErrorCode)
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
DEFINE_FUNCTION fnScreen(INTEGER nTrigger) //Screen Functions
{
    PULSE [dvRelays,nTrigger] 
}
DEFINE_FUNCTION fnRouteVideoScriptLeft(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_PROJECTOR_LEFT,' ',ITOA(cStream),CR" 
	SEND_STRING dvController, "'switch ',OUT_MONITOR_LEFT,' ',ITOA(cStream),CR"
	    SEND_STRING dvController, "'switch ',OUT_DL_FEED,' ',ITOA(cStream),CR"
    
    SWITCH (cStream)
    {
	CASE STREAM_PC_MAIN :
	CASE STREAM_PC_EXT :
	{
	    ON [vdvTP_Main, BTN_AUDIO_PC]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(STREAM_PC_MAIN),CR" 
	}
	CASE STREAM_VGA_HDMI :
	CASE STREAM_MERSIVE :
	{
	    ON [vdvTP_Main, cStream + 480]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
	}
	WAIT ONE_SECOND
	{
	    IF (nRearFollow_ == TRUE)
	    {
		SEND_STRING dvController, "'switch ',OUT_PROJECTOR_REAR,' ',ITOA(cStream),CR"
	    }
	}
    }
}
DEFINE_FUNCTION fnRouteVideoScriptRight(INTEGER cStream)
{
    SEND_STRING dvController, "'switch ',OUT_PROJECTOR_RIGHT,' ',ITOA(cStream),CR" 
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
	CASE STREAM_MERSIVE :
	{
	    ON [vdvTP_Main, cStream + 490]
		SEND_STRING dvController, "'switchaudio ',OUT_AUDIO_ATC,' ',ITOA(cStream),CR" 
	}
    }
}
DEFINE_FUNCTION fnParseControllerIP() //Projector Connected via IP...
{
    STACK_VAR CHAR cResponse[500]
    STACK_VAR CHAR cMonitorSource[100]
    STACK_VAR CHAR cProjectorStat[23]
    STACK_VAR CHAR cActiveProjector[12]
    STACK_VAR INTEGER cTemp_Source
    LOCAL_VAR CHAR cDug[35]   
    
    WHILE (FIND_STRING(nAbleBuffer,"$0D,$0A",1)OR FIND_STRING(nAbleBuffer,'</status>',1))
    {
	cResponse = REMOVE_STRING(nAbleBuffer,"$0D,$0A",1)
	cMonitorSource = REMOVE_STRING(nAbleBuffer,'</status>',1)
	//cDug = cMonitorSource
	
	IF (FIND_STRING (cResponse,"TALK_PROJECTOR_LEFT_IP,';02 0A 53 4F 4E 59 01 70 00 08 '",1))
	{
	    REMOVE_STRING (cResponse,"TALK_PROJECTOR_LEFT_IP,';02 0A 53 4F 4E 59 01 70 00 08 '",1)
	    cProjectorStat = cResponse
	    cDug = cProjectorStat
	    ON [vdvTP_Main, 601]
		ON [nOnlineLeft_]
	    
	    SWITCH (cProjectorStat)
	    {
		CASE 'A9 01 02 02 00 03 03 9A' : 
		{
		    ON [vdvTP_Main, BTN_PWR_ON_L]
			ON [vdvPipeFB, DL_PWR_ON_LEFT]
		}
		CASE 'A9 01 02 02 00 00 03 9A' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_L]
			ON [vdvPipeFB, DL_PWR_OFF_LEFT]
		}
		CASE 'A9 00 30 02 00 00 32 9A' :
		{
		    nMute_Left = FALSE;
		    OFF [vdvTP_Main, BTN_BLANK_L]
			OFF [vdvPipeFB, DL_BLANK_LEFT]
		}
		CASE 'A9 00 30 02 00 01 33 9A' :
		{
		    nMute_Left = TRUE;
			ON [vdvTP_Main, BTN_BLANK_L]
			    ON [vdvPipeFB, DL_BLANK_LEFT]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"TALK_PROJECTOR_RIGHT_IP,';02 0A 53 4F 4E 59 01 70 00 08 '",1))
	{
	    REMOVE_STRING (cResponse,"TALK_PROJECTOR_RIGHT_IP,';02 0A 53 4F 4E 59 01 70 00 08 '",1)
		cProjectorStat = cResponse
		ON [vdvTP_Main, 611]
		    ON [nOnlineRight_]
	
	    SWITCH (cProjectorStat)
	    {
		CASE 'A9 01 02 02 00 03 03 9A' : 
		{
		    ON [vdvTP_Main, BTN_PWR_ON_R]
			ON [vdvPipeFB, DL_PWR_ON_RIGHT]
		}
		CASE 'A9 01 02 02 00 00 03 9A' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_R]
			ON [vdvPipeFB, DL_PWR_OFF_RIGHT]
		}
		CASE 'A9 00 30 02 00 00 32 9A' :
		{
		    nMute_Right = FALSE;
		    OFF [vdvTP_Main, BTN_BLANK_R]
			OFF [vdvPipeFB, DL_BLANK_RIGHT]
		}
		CASE 'A9 00 30 02 00 01 33 9A' :
		{
		    nMute_Right = TRUE;
			ON [vdvTP_Main, BTN_BLANK_R]
			    ON [vdvPipeFB, DL_BLANK_RIGHT]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"TALK_PROJECTOR_REAR_IP,';02 0A 53 4F 4E 59 01 70 00 08 '",1))
	{
	    REMOVE_STRING (cResponse,"TALK_PROJECTOR_REAR_IP,';02 0A 53 4F 4E 59 01 70 00 08 '",1)
	    cProjectorStat = cResponse
	    ON [vdvTP_Main, 621]
		ON [nOnlineRear_]
	    
	    SWITCH (cProjectorStat)
	    {
		CASE 'A9 01 02 02 00 03 03 9A' : 
		{
		    ON [vdvTP_Main, BTN_PWR_ON_REAR]
			ON [vdvPipeFB, DL_PWR_ON_REAR]
		}
		CASE 'A9 01 02 02 00 00 03 9A' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_REAR]
			ON [vdvPipeFB, DL_PWR_OFF_REAR]
		}
		CASE 'A9 00 30 02 00 00 32 9A' :
		{
		    nMute_Rear = FALSE;
		    OFF [vdvTP_Main, BTN_BLANK_REAR]
			ON [vdvPipeFB, DL_BLANK_REAR]
		}
		CASE 'A9 00 30 02 00 01 33 9A' : //Blank Query On..
		{
		    nMute_Rear = TRUE;
			ON [vdvTP_Main, BTN_BLANK_REAR]
			    OFF [vdvPipeFB, DL_BLANK_REAR]
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
		CASE OUT_PROJECTOR_LEFT :
		{
		    nSource_Left = cTemp_Source
			ON [vdvTP_Main, nSource_Left - 20]
		}
		CASE OUT_PROJECTOR_RIGHT :
		{
		    nSource_Right = cTemp_Source
			ON [vdvTP_Main, nSource_Right + 80]
		}
		CASE OUT_AUDIO_ATC :
		{
		    nSource_Audio = ATOI(MID_STRING(cMonitorSource, 35,2)); //Audio Tranceiver Position
			SEND_STRING dvDebug, "'dvController : Receiving Audio Stream ', ITOA(nSource_Audio)"
			    ON [vdvTP_Main, nSource_Audio + 480] //FB
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnParseControllerSerial() //Projector Connected via Serial...
{
    STACK_VAR CHAR cResponse[500]
    STACK_VAR CHAR cMonitorSource[100]
    STACK_VAR CHAR cProjectorStat[23]
    STACK_VAR CHAR cActiveProjector[12]
    STACK_VAR INTEGER cTemp_Source
    LOCAL_VAR CHAR cDug[35]   
    
    WHILE (FIND_STRING(nAbleBuffer,"$0D,$0A",1)OR FIND_STRING(nAbleBuffer,'</status>',1))
    {
	cResponse = REMOVE_STRING(nAbleBuffer,"$0D,$0A",1)
	cMonitorSource = REMOVE_STRING(nAbleBuffer,'</status>',1)
	cDug = cMonitorSource
	
	IF (FIND_STRING (cResponse,"OUT_PROJECTOR_LEFT,';'",1))
	{
	    REMOVE_STRING (cResponse,"OUT_PROJECTOR_LEFT,';'",1)
	    cProjectorStat = cResponse
	    ON [vdvTP_Main, 601]
		ON [nOnlineLeft_]
	    
	    SWITCH (cProjectorStat)
	    {
		CASE 'A9 01 02 02 00 03 03 9A' : 
		{
		    ON [vdvTP_Main, BTN_PWR_ON_L]
			ON [vdvPipeFB, DL_PWR_ON_LEFT]
		}
		CASE 'A9 01 02 02 00 00 03 9A' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_L]
			ON [vdvPipeFB, DL_PWR_OFF_LEFT]
		}
		CASE 'A9 00 30 02 00 00 32 9A' :
		{
		    nMute_Left = FALSE;
		    OFF [vdvTP_Main, BTN_BLANK_L]
			ON [vdvPipeFB, DL_BLANK_LEFT]
		}
		CASE 'A9 00 30 02 00 01 33 9A' :
		{
		    nMute_Left = TRUE;
			ON [vdvTP_Main, BTN_BLANK_L]
			    OFF [vdvPipeFB, DL_BLANK_LEFT]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"OUT_PROJECTOR_RIGHT,';'",1))
	{
	    REMOVE_STRING (cResponse,"OUT_PROJECTOR_RIGHT,';'",1)
		cProjectorStat = cResponse
		ON [vdvTP_Main, 611]
		    ON [nOnlineRight_]
	
	    SWITCH (cProjectorStat)
	    {
		CASE 'A9 01 02 02 00 03 03 9A' : 
		{
		    ON [vdvTP_Main, BTN_PWR_ON_R]
			ON [vdvPipeFB, DL_PWR_ON_RIGHT]
		}
		CASE 'A9 01 02 02 00 00 03 9A' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_R]
			ON [vdvPipeFB, DL_PWR_OFF_RIGHT]
		}
		CASE 'A9 00 30 02 00 00 32 9A' :
		{
		    nMute_Right = FALSE;
		    OFF [vdvTP_Main, BTN_BLANK_R]
			ON [vdvPipeFB, DL_BLANK_RIGHT]
		}
		CASE 'A9 00 30 02 00 01 33 9A' :
		{
		    nMute_Right = TRUE;
			ON [vdvTP_Main, BTN_BLANK_R]
			    OFF [vdvPipeFB, DL_BLANK_RIGHT]
		}
	    }
	}
	IF (FIND_STRING (cResponse,"OUT_PROJECTOR_REAR,';'",1))
	{
	    REMOVE_STRING (cResponse,"OUT_PROJECTOR_REAR,';'",1)
	    cProjectorStat = cResponse
	    ON [vdvTP_Main, 621]
		ON [nOnlineRear_]
	    
	    SWITCH (cProjectorStat)
	    {
		CASE 'A9 01 02 02 00 03 03 9A' : 
		{
		    ON [vdvTP_Main, BTN_PWR_ON_REAR]
			ON [vdvPipeFB, DL_PWR_ON_REAR]
		}
		CASE 'A9 01 02 02 00 00 03 9A' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_REAR]
			ON [vdvPipeFB, DL_PWR_OFF_REAR]
		}
		CASE 'A9 00 30 02 00 00 32 9A' :
		{
		    nMute_Rear = FALSE;
		    OFF [vdvTP_Main, BTN_BLANK_REAR]
			ON [vdvPipeFB, DL_BLANK_REAR]
		}
		CASE 'A9 00 30 02 00 01 33 9A' :
		{
		    nMute_Rear = TRUE;
			ON [vdvTP_Main, BTN_BLANK_REAR]
			    OFF [vdvPipeFB, DL_BLANK_REAR]
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
		CASE OUT_PROJECTOR_LEFT :
		{
		    nSource_Left = cTemp_Source
			ON [vdvTP_Main, nSource_Left - 30]
		}
		CASE OUT_PROJECTOR_RIGHT :
		{
		    nSource_Right = cTemp_Source
			ON [vdvTP_Main, nSource_Right + 70]
		}
		CASE OUT_AUDIO_ATC :
		{
		    nSource_Audio = ATOI(MID_STRING(cMonitorSource, 35,2)); //Audio Tranceiver Position
			SEND_STRING dvDebug, "'dvController : Receiving Audio Stream ', ITOA(nSource_Audio)"
			    ON [vdvTP_Main, nSource_Audio + 470] //FB
		}
	    }
	}
    }
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
	IF (!TIMELINE_ACTIVE (TL_SHUTDOWN))
	{
	    TIMELINE_CREATE (TL_SHUTDOWN, lTLPwrShutdown, LENGTH_ARRAY (lTLPwrShutdown), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
	}
    }
}
DEFINE_FUNCTION fnQueryProjectorsSerial()
{
    SEND_STRING dvController, "'tpc ',OUT_PROJECTOR_LEFT,' ',ITOA(PROJECTOR_QUERY),CR"
    WAIT 20 SEND_STRING dvController, "'tpc ',OUT_PROJECTOR_LEFT,' ',ITOA(PROJECTOR_BLANK_QUERY),CR"
    
    WAIT 40 SEND_STRING dvController, "'tpc ',OUT_PROJECTOR_RIGHT,' ',ITOA(PROJECTOR_QUERY),CR"
    WAIT 60 SEND_STRING dvController, "'tpc ',OUT_PROJECTOR_RIGHT,' ',ITOA(PROJECTOR_BLANK_QUERY),CR"
    
    WAIT 80 SEND_STRING dvController, "'tpc ',OUT_PROJECTOR_REAR,' ',ITOA(PROJECTOR_QUERY),CR"
    WAIT 100 SEND_STRING dvController, "'tpc ',OUT_PROJECTOR_REAR,' ',ITOA(PROJECTOR_BLANK_QUERY),CR"
}
DEFINE_FUNCTION fnQueryProjectorsIP()
{
    SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_QUERY,CR"
    WAIT 20 SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_QUERY,CR"
    
    WAIT 40 SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_RIGHT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_QUERY,CR"
    WAIT 60 SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_RIGHT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_QUERY,CR"

    WAIT 80 SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_REAR_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_QUERY,CR"
    WAIT 100 SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_REAR_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_QUERY,CR"
}
DEFINE_FUNCTION fnRouteVideoPreview(INTEGER cIn)
{
    SEND_STRING dvController, "'switch ',OUT_MONITOR_RIGHT,' ',ITOA(cIn),CR"
}
DEFINE_FUNCTION fnPowerDisplays (INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    IF (cLockOutLeft == TRUE)
	    {
		//Wait
	    }
	    ELSE
	    {
		IF (!TIMELINE_ACTIVE (TL_ON_SEQ_L))
		{
		    TIMELINE_CREATE (TL_ON_SEQ_L, lTLPwrSequenceLeft, LENGTH_ARRAY (lTLPwrSequenceLeft), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
		}
	    }
	}
	CASE BTN_PWR_OFF_L :
	{
	    IF (cLockOutLeft == TRUE)
	    {
		//Wait
	    }
	    ELSE
	    {
		IF (!TIMELINE_ACTIVE (TL_OFF_SEQ_L))
		{
		    TIMELINE_CREATE (TL_OFF_SEQ_L, lTLPwrSequenceLeft, LENGTH_ARRAY (lTLPwrSequenceLeft), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
		}
	    }
	}
	CASE BTN_PWR_ON_R :
	{
	    IF (cLockOutRight == TRUE)
	    {
		//Wait
	    }
	    ELSE
	    {
		IF (!TIMELINE_ACTIVE (TL_ON_SEQ_R))
		{
		    TIMELINE_CREATE (TL_ON_SEQ_R, lTLPwrSequenceRight, LENGTH_ARRAY (lTLPwrSequenceRight), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
		}
	    }
	}
	CASE BTN_PWR_OFF_R :
	{
	    IF (cLockOutRight == TRUE)
	    {
		//Wait
	    }
	    ELSE
	    {
		IF (!TIMELINE_ACTIVE (TL_OFF_SEQ_R))
		{
		    TIMELINE_CREATE (TL_OFF_SEQ_R, lTLPwrSequenceRight, LENGTH_ARRAY (lTLPwrSequenceRight), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
		}
	    }
	}
	CASE BTN_PWR_ON_REAR :
	{
	    nPwrStateRear = TRUE;
	    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_REAR,' ',PROJECTOR_RS232_PWR_ON,CR"
		//SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_REAR_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_REAR]
		    ON [vdvPipeFB, DL_PWR_ON_REAR]
		    fnScreen (screen_down_center)
		    
		IF (!TIMELINE_ACTIVE (TL_STATUS_REAR))
		{
		    TIMELINE_CREATE (TL_STATUS_REAR, lTLPwrStatus, LENGTH_ARRAY (lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		}
	}
	CASE BTN_PWR_OFF_REAR :
	{
	    nPwrStateRear = FALSE;
	    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_REAR,' ',PROJECTOR_RS232_PWR_OFF,CR"
	    // SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_REAR_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_OFF,CR"
		ON [vdvTP_Main, BTN_PWR_OFF_REAR]
		   ON [vdvPipeFB, DL_PWR_OFF_REAR]
	    
		IF (!TIMELINE_ACTIVE (TL_STATUS_REAR))
		{
		    TIMELINE_CREATE (TL_STATUS_REAR, lTLPwrStatus, LENGTH_ARRAY (lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		}
	    WAIT 30
	    {
		fnScreen (screen_up_center)
	    }
	}
    }
}
DEFINE_FUNCTION fnGetSVSIRep()
{
		   SEND_STRING dvController, "'monitor ',OUT_PROJECTOR_LEFT,CR" //Enable device change status for Video Routing...
    WAIT 10 SEND_STRING dvController, "'monitor ',OUT_PROJECTOR_RIGHT,CR"
    WAIT 20 SEND_STRING dvController, "'monitor ',OUT_AUDIO_ATC,CR"
    
    WAIT 30 SEND_STRING dvController, "'readresponse ',OUT_PROJECTOR_LEFT,CR" //Enable device change status for Decoder TX/RX
    WAIT 35 SEND_STRING dvController, "'readresponse ',OUT_PROJECTOR_RIGHT,CR"
    WAIT 40 SEND_STRING dvController, "'readresponse ',OUT_PROJECTOR_REAR,CR"
    
    WAIT 50 SEND_STRING dvController, "'monitornotify ',OUT_PROJECTOR_LEFT,CR" //Get Current State...
    WAIT 60 SEND_STRING dvController, "'monitornotify ',OUT_PROJECTOR_RIGHT,CR" //Get Current State
    
    WAIT 100 fnQueryProjectorsSerial()
    //WAIT 100 fnQueryProjectorsIP()
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


nBoot_ = TRUE;

WAIT 50
{
    TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	CREATE_BUFFER dvController,nAbleBuffer; 
}


WAIT 450
{
    nBoot_ = FALSE;
}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_L]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_L]
BUTTON_EVENT [vdvTP_Main, BTN_BLANK_L]
BUTTON_EVENT [vdvTP_Main, BTN_SCREEN_UP_L]
BUTTON_EVENT [vdvTP_Main, BTN_SCREEN_DN_L]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L : fnPowerDisplays (BTN_PWR_ON_L)
	    CASE BTN_PWR_OFF_L : fnPowerDisplays (BTN_PWR_OFF_L)
	    
	    CASE BTN_BLANK_L :
	    {
		IF (nMute_Left == FALSE)
		{
		    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_LEFT,' ',PROJECTOR_RS232_BLANK_ON,CR"
		    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_ON,CR"
		    ON [vdvTP_Main, BTN_BLANK_L]
			nMute_Left = TRUE;
		}
		ELSE
		{
		    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_LEFT,' ',PROJECTOR_RS232_BLANK_OFF,CR"
		    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_OFF,CR"
		    OFF [vdvTP_Main, BTN_BLANK_L]
			nMute_Left = FALSE;
		}
	    }
	    CASE BTN_SCREEN_UP_L : fnScreen (screen_up_left)
	    CASE BTN_SCREEN_DN_L : fnScreen (screen_down_left)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_R]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_R]
BUTTON_EVENT [vdvTP_Main, BTN_BLANK_R]
BUTTON_EVENT [vdvTP_Main, BTN_SCREEN_UP_R]
BUTTON_EVENT [vdvTP_Main, BTN_SCREEN_DN_R]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R : fnPowerDisplays (BTN_PWR_ON_R)
	    CASE BTN_PWR_OFF_R : fnPowerDisplays (BTN_PWR_OFF_R)
	    
	    CASE BTN_BLANK_R :
	    {
		IF (nMute_Right == FALSE)
		{
		    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_RIGHT,' ',PROJECTOR_RS232_BLANK_ON,CR"
		    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_ON,CR"
		    ON [vdvTP_Main, BTN_BLANK_R]
			nMute_Right = TRUE;
		}
		ELSE
		{
		    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_RIGHT,' ',PROJECTOR_RS232_BLANK_OFF,CR"
		    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_OFF,CR"
		    OFF [vdvTP_Main, BTN_BLANK_R]
			nMute_Right = FALSE;
		}
	    }
	    CASE BTN_SCREEN_UP_R : fnScreen (screen_up_right)
	    CASE BTN_SCREEN_DN_R : fnScreen (screen_down_right)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_REAR]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_REAR]
BUTTON_EVENT [vdvTP_Main, BTN_BLANK_REAR]
BUTTON_EVENT [vdvTP_Main, BTN_SCREEN_UP_REAR]
BUTTON_EVENT [vdvTP_Main, BTN_SCREEN_DN_REAR] //Rear Controls..
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_REAR : fnPowerDisplays (BTN_PWR_ON_REAR)
	    CASE BTN_PWR_OFF_REAR : fnPowerDisplays (BTN_PWR_OFF_REAR)
	    CASE BTN_BLANK_REAR :
	    {
		IF (nMute_Rear == FALSE)
		{
		    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_REAR,' ',PROJECTOR_RS232_BLANK_ON,CR"
		    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_ON,CR"
		    ON [vdvTP_Main, BTN_BLANK_REAR]
			nMute_Rear = TRUE;
		}
		ELSE
		{
		    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_REAR,' ',PROJECTOR_RS232_BLANK_OFF,CR"
		    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_OFF,CR"
		    OFF [vdvTP_Main, BTN_BLANK_REAR]
			nMute_Rear = FALSE;
		}
	    }
	    CASE BTN_SCREEN_UP_REAR : fnScreen (screen_up_center)
	    CASE BTN_SCREEN_DN_REAR : fnScreen (screen_down_center)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceLeftBtns] //Left + Center
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	nSTDX = GET_LAST (nSourceLeftBtns)
	
	fnRouteVideoScriptLeft(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceLeftBtns[nSTDX]] //Video FB
		ON [vdvPipeFB, dcChanLeft[nSTDX]]
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceRightBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nSTDX
	nSTDX = GET_LAST (nSourceRightBtns)
	
	fnRouteVideoScriptRight(nStreamSend[nSTDX])
	    ON [vdvTP_Main, nSourceRightBtns[nSTDX]] //Video FB
		ON [vdvPipeFB, dcChanRight[nSTDX]]
		    OFF [vdvTP_Main, BTN_PRVW_PC_EXT]
			OFF [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
			    nLivePreview_ = FALSE;
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
{
    PUSH :
    {
	IF ( nLivePreview_ == FALSE)
	{
	    ON [dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
		fnRouteVideoPreview (STREAM_CAMERA_R)
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
BUTTON_EVENT [vdvTP_Main, BTN_PRVW_PC_EXT]
{
    PUSH :
    {
	fnRouteVideoPreview (STREAM_PC_EXT)
	    ON [vdvTP_Main, BTN_PRVW_PC_EXT]
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_FOLLOW_LEFT]
BUTTON_EVENT [vdvTP_Main, BTN_FOLLOW_NOTES] //Rear Source Options...
{
    PUSH :
    {
	ON [vdvTP_Main, BUTTON.INPUT.CHANNEL]
	
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_FOLLOW_LEFT :
	    {
		SEND_STRING dvController, "'switch ',OUT_PROJECTOR_REAR,' ',ITOA(nSource_Left),CR"
		    nRearFollow_ = TRUE;
	    }
	    CASE BTN_FOLLOW_NOTES :
	    {
		SEND_STRING dvController, "'switch ',OUT_PROJECTOR_REAR,' ',ITOA(STREAM_PC_EXT),CR"
		    nRearFollow_ = FALSE;
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Booth, nSvsiInputBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nChan 
	nChan = GET_LAST (nSvsiInputBtns)
	
	ON [vdvTP_Main, nSvsiInputBtns[nChan]]
	    nStreamChnl = nStreamSend[nChan]
    }
}
BUTTON_EVENT [dvTP_Booth, nSvsiOutputBtns]
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
BUTTON_EVENT [vdvTP_MAIN, nLightsBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER cIn 
	
	SEND_STRING dvLights, "'~11h 12 ',ITOHEX(nSendLights[GET_LAST(nLightsBtns)]),CR"
	
	cIn = GET_LAST (nLightsBtns)
	ON [vdvTP_Main, nLightsBtns[cIn]]
    }
    RELEASE :
    {
	WAIT 10 SEND_STRING dvLights, "'~11h 12 ',ITOHEX(LIGHTS_AREA),CR"
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
DATA_EVENT [dvTP_Main] //
{
    ONLINE :
    {
	nTpOnline = TRUE;
	
	#IF_DEFINED G4PANEL
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'" //Make Your Presence Known...
	#END_IF
	
	#IF_DEFINED G5PANEL 
	SEND_COMMAND DATA.DEVICE, "'^ADP'" //Make Your Presence Known...
	#END_IF
	
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	
	WAIT 100
	{
	    fnLoadTPEncoderIOs()
		fnLoadTPDecoderIOs()
	}
    }
    OFFLINE :
    {
	nTpOnline = FALSE;
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
DATA_EVENT [dvLights]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 9600,N,8,1'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
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
	AMX_LOG (AMX_ERROR, "'dvController : onerror : ',GetSVSIIpError(DATA.NUMBER)");
	SEND_STRING dvDebug, "'Controller onerror : ',GetSVSIIpError(DATA.NUMBER)";
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 17 :
	    {
		nSVSIOnline = FALSE;
		    OFF [vdvTP_Main, BTN_NET_BOOT]
		    fnSVSIReconnect()
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
		SEND_COMMAND vdvPipeFB, "'Classroom Controller : ', nAbleBuffer"
	
	//fnParseControllerIP()
	fnParseControllerSerial()
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_ON_SEQ_L] //Left Pwr On Sequence...
{
    SEND_STRING dvDebug, "'timeline_event[TL_ON_SEQ_L]: timeline.sequence = ', ITOA(TIMELINE.SEQUENCE)";
    
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 :
	{
	    cLockOutLeft = TRUE;
	    nPwrStateLeft = TRUE;
	    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_ON,CR"
	    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_LEFT,' ',PROJECTOR_RS232_PWR_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_L]
	    BREAK;
	}
	CASE 2 :
	{
	    fnScreen (SCREEN_DOWN_LEFT)
			ON [vdvPipeFB, DL_PWR_ON_LEFT]
			
	    IF (!TIMELINE_ACTIVE(TL_STATUS_L))
	    {
		TIMELINE_CREATE (TL_STATUS_L, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	    }
	    BREAK;
	}
	CASE 3 :
	{
	    BREAK;
	}
    }
}	
TIMELINE_EVENT [TL_OFF_SEQ_L]	 //Right Pwr Off Sequence..
{
    SEND_STRING dvDebug, "'timeline_event[TL_OFF_SEQ_L]: timeline.sequence = ', ITOA(TIMELINE.SEQUENCE)";
    
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 :
	{
	    cLockOutLeft = TRUE;
	    nPwrStateLeft = FALSE;
	   SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_LEFT,' ',PROJECTOR_RS232_PWR_OFF,CR"
		//SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_OFF,CR"
		ON [vdvTP_Main, BTN_PWR_OFF_L]
	    BREAK;
	}
	CASE 2 :
	{
	    ON [vdvPipeFB, DL_PWR_OFF_LEFT]
	    
	    IF (!TIMELINE_ACTIVE(TL_STATUS_L))
	    {
		TIMELINE_CREATE (TL_STATUS_L, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	    }
	    BREAK;
	}
	CASE 3 :
	{
	    fnScreen (SCREEN_UP_LEFT)
	    BREAK;
	}
    }
}
TIMELINE_EVENT [TL_ON_SEQ_R]
{
    SEND_STRING dvDebug, "'timeline_event[TL_ON_SEQ_R]: timeline.sequence = ', ITOA(TIMELINE.SEQUENCE)";
    
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 :
	{
	    cLockOutRight = TRUE;
	    nPwrStateRight = TRUE;
	   SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_RIGHT,' ',PROJECTOR_RS232_PWR_ON,CR"
	   //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_RIGHT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_ON,CR"
		ON [vdvTP_Main, BTN_PWR_ON_R]
	    BREAK;
	}
	CASE 2 :
	{
	    ON [vdvPipeFB, DL_PWR_ON_RIGHT]
		    fnScreen (SCREEN_DOWN_RIGHT)
		    
	    IF (!TIMELINE_ACTIVE(TL_STATUS_R))
	    {
		TIMELINE_CREATE (TL_STATUS_R, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	    }
	    BREAK;
	}
	CASE 3 :
	{
	    BREAK;
	}
    }
}
TIMELINE_EVENT [TL_OFF_SEQ_R]
{
    SEND_STRING dvDebug, "'timeline_event[TL_OFF_SEQ_R]: timeline.sequence = ', ITOA(TIMELINE.SEQUENCE)";
    
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 :
	{
	    cLockOutRight = TRUE;
	    nPwrStateRight = FALSE;
	   SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_RIGHT,' ',PROJECTOR_RS232_PWR_OFF,CR"
	   // SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_RIGHT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_OFF,CR"
		ON [vdvTP_Main, BTN_PWR_OFF_R]
	    BREAK;
	}
	CASE 2 :
	{
	    ON [vdvPipeFB, DL_PWR_OFF_RIGHT]
	    
	    IF (!TIMELINE_ACTIVE(TL_STATUS_R))
	    {
		TIMELINE_CREATE (TL_STATUS_R, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	    }
	    BREAK;
	}
	CASE 3 :
	{
	    fnScreen (screen_up_right)
	    BREAK;
	}
    }
}
TIMELINE_EVENT [TL_STATUS_L]
{
    IF (TIMELINE.REPETITION < SET_RUN_TIME)
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	
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
	SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
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
	SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
	
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
	SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
	TIMELINE_KILL (TL_STATUS_R)
	    cLockOutRight = FALSE;
		OFF [vdvTP_Main, 612]
		OFF [vdvTP_Main, 613]
    }
}
TIMELINE_EVENT [TL_STATUS_REAR]
{
    IF (TIMELINE.REPETITION < SET_RUN_TIME)
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP30'"
	
	SWITCH (nPwrStateRear)
	{
	    CASE 1 :
	    {
		[vdvTP_Main, 622] = ![vdvTP_Main, 622]
	    }
	    DEFAULT :
	    {
		[vdvTP_Main, 623] = ![vdvTP_Main, 623]
	    }
	}
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP255'"
	TIMELINE_KILL (TL_STATUS_REAR)
	    nPwrStateRear = FALSE;
		OFF [vdvTP_Main, 622]
		OFF [vdvTP_Main, 623]
    }
}
TIMELINE_EVENT [TL_SHUTDOWN]
{
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 : //UnBlanK
	{
	    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_LEFT,' ',PROJECTOR_RS232_BLANK_OFF,CR"
		SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_RIGHT,' ',PROJECTOR_RS232_BLANK_OFF,CR"
		    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_REAR,' ',PROJECTOR_RS232_BLANK_OFF,CR"
	    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_OFF,CR"
		//SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_RIGHT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_OFF,CR"
		    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_REAR_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_BLANK_OFF,CR"
	}
	CASE 2 :
	{
	    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_LEFT,' ',PROJECTOR_RS232_PWR_OFF,CR"
	    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_LEFT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_OFF,CR"
		fnScreen (screen_up_left)
	}
	CASE 3 :
	{
	    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_RIGHT,' ',PROJECTOR_RS232_PWR_OFF,CR"
	    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_RIGHT_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_OFF,CR"
		fnScreen (screen_up_right)
	}
	CASE 4 :
	{
	    SEND_STRING dvController, "'serialhex 1 ',OUT_PROJECTOR_REAR,' ',PROJECTOR_RS232_PWR_OFF,CR"
	    //SEND_STRING dvController, "'tcpclient ',TALK_PROJECTOR_REAR_IP,' ',TALK_PROJECTOR_PORT,' ',PROJECTOR_IP_PWR_OFF,CR"
		fnScreen (screen_up_center)
	}
	CASE 5 :
	{
	    fnResetAudio()
		fnRouteVideoScriptLeft (STREAM_PC_MAIN)
		WAIT 10
		{
		    fnRouteVideoScriptLeft (STREAM_PC_EXT)
		}
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnReboot()
    fnKill()

    WAIT 450 //Second Loop
    {
	IF (nSVSIOnline == FALSE)
	{
	    fnStartSVSIConnection()
	}
	ELSE
	{
	    fnQueryProjectorsSerial()
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


