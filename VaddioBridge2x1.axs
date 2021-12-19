PROGRAM_NAME='VaddioBridge2x1'
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

dvDebug =			0:0:0 //Send to Diag...
//dvShure =			0:3:0 
//dvCamFront =		0:4:0
//dvCamRear =		0:5:0
dvVaddioBridge =		0:6:0 //av Bridge klaus1207avbridge:23

dvTP_Main =			10001:1:0 //MT-1002
dvTP_Booth = 			10002:1:0 //MD-702


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

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100
TXT_CAMERA_PAGE			= 23

//Btns....
BTN_PRVW_ACTIVE_CAMERA		= 120
BTN_PRVW_PC_EXT				= 121
BTN_PRVW_REC				= 122

BTN_CAM_PWR				= 50
BTN_CAM_FRONT				= 51
BTN_CAM_REAR 				= 52 
BTN_CAM_DOC				= 53
BTN_CAM_KAPTIVO			= 54
BTN_CAM_LIGHT				= 55

BTN_CAMERA_POPUP			= 245
BTN_AVB_PIP_TOGGLE			= 246
BTN_AVB_SWAP_SOURCE		= 247


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

CHAR cAvBridge[15] = '172.21.6.204'
LONG nVaddio_Port = 23
VOLATILE INTEGER nVaddioBridgeOnline
VOLATILE INTEGER nVaddioSuccess_
VOLATILE INTEGER nPIPOn
VOLATILE INTEGER nBGSwap
VOLATILE CHAR nVaddioBridgeBuffer[100]

VOLATILE INTEGER cIndexCamera
VOLATILE INTEGER nLivePreview_ //Is Camera Live or naw..


VOLATILE INTEGER nOnlineLeft_
VOLATILE INTEGER nOnlineRight_
VOLATILE INTEGER nTPOnline
VOLATILE INTEGER nBoot_
VOLATILE INTEGER nSystemOn_ 

VOLATILE LONG lTLFeedback[] = {500};
VOLATILE LONG lTLFlash[] = {1000};
VOLATILE INTEGER iFlash

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
VOLATILE INTEGER nVideoPrvwBtns[] =
{
    BTN_PRVW_PC_EXT,
    BTN_PRVW_REC,
    BTN_PRVW_ACTIVE_CAMERA
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
   
(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_CAM_FRONT]..[dvTP_Main, BTN_CAM_REAR])
([dvTP_Main, BTN_CAM_DOC]..[dvTP_Main, BTN_CAM_LIGHT])
([dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]..[dvTP_Main, BTN_PRVW_REC])

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
DEFINE_FUNCTION fnRouteVideoPreview(INTEGER cIn)
{
    SEND_STRING dvController, "'switch ',OUT_MONITOR_RIGHT,' ',ITOA(cIn),CR"
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
	    CASE 17 :
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
}

(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See Differences in DEFINE_PROGRAM Program Execution section *)
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


