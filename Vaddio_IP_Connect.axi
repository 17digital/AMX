PROGRAM_NAME='Vaddio_IP_Connect'



DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_PressA
dvTP_PressA =			10001:1:0 //MD-1002
#END_IF

#IF_NOT_DEFINED dvTP_PressB
dvTP_PressB = 		10002:1:0 //MD-1002
#END_IF

#IF_NOT_DEFINED dvCameraPressA
dvCameraPressA =		0:6:0 
#END_IF

#IF_NOT_DEFINED dvCameraPressB
dvCameraPressB =		0:7:0 //
#END_IF


DEFINE_CONSTANT

#IF_NOT_DEFINED POWER
POWER							= 255
#END_IF


CHAR CAM_PRESS_A_IP[]				= 'ssc-pressacamera.amx.gatech.edu' //172.21.2.113
CHAR CAM_PRESS_B_IP[]				= 'ssc-pressbcamera.amx.gatech.edu' //172.21.2.254
CHAR CAM_USER[]						= 'admin'
CHAR CAM_PASSWORD[]				= 'password'

VADDIO_COUNT						= 2;
ID_PRESS_A							= 1;
ID_PRESS_B							= 2;

//Vaddio Commands....
CHAR CAM_TILT_UP[]					= 'camera tilt up 7' //1-20
CHAR CAM_TILT_DN[]					= 'camera tilt down 7'
CHAR CAM_TILT_STOP[]					= 'camera tilt stop'
CHAR CAM_PAN_LEFT[]					= 'camera pan left 8' //Speed 1-24
CHAR CAM_PAN_RIGHT[]				= 'camera pan right 8'  //Speed 1-24
CHAR CAM_PAN_STOP[]				= 'camera pan stop' //Speed 07 07
CHAR CAM_ZOOM_IN[]					= 'camera zoom in 2' 
CHAR CAM_ZOOM_OUT[]				= 'camera zoom out 2' //Standard Zoom Speeds 1-7
CHAR CAM_ZOOM_STOP[]				= 'camera zoom stop' //Standard Zoom
CHAR CAM_PWR_STATUS[] 				= 'camera standby get'
CHAR CAM_AUTO_FOCUS[]				= 'camera focus mode auto'
CHAR CAM_HOME_RESET[]				= 'camera home'
CHAR CAM_AUTO_BALANCE[]			= 'camera ccu set auto_white_balance on'
CHAR CAM_NET_STATUS[]				= 'network settings get'

#IF_NOT_DEFINED __VADDIO_CONST__
#DEFINE __VADDIO_CONST__

CHAR MSG_END			= $0D;
CHAR MSG_FD			= $0A;

TILT_UP					= 132
TILT_DOWN				= 133
PAN_LEFT				= 134
PAN_RIGHT				= 135
ZOOM_IN 				= 158
ZOOM_OUT				= 159
AUTO_FOCUS				= 97
AUTO_WB				= 98

TXT_CAMERA_SAVED		= 22

BTN_CAMERA_PWR		= 50 //FB

BTN_PRESET_1				= 71
BTN_PRESET_2				= 72
BTN_PRESET_3				= 73
BTN_PRESET_4				= 74
BTN_PRESET_5				= 75
BTN_PRESET_6				= 76
BTN_PRESET_HOME		= 77

#END_IF

(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _VaddioStruct
{
    CHAR uURL[128];
    INTEGER uPort;
    CHAR uFlag;
    CHAR uOnline;
    INTEGER uPwr;
    CHAR uUser[5];
    CHAR uPassword[8];
    INTEGER uVaddioSuccess;
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _VaddioStruct vaddioStruct[VADDIO_COUNT];

VOLATILE CHAR nVaddioPressABuffer[1500];
VOLATILE CHAR nVaddioPressBBuffer[1500];

VOLATILE INTEGER nPresetsPressA[] =
{
    BTN_PRESET_1,
    BTN_PRESET_2,
    BTN_PRESET_3,
    BTN_PRESET_4,
    BTN_PRESET_5,
    BTN_PRESET_6,
    BTN_PRESET_HOME
}
VOLATILE INTEGER nPresetsPressB[] =
{
    BTN_PRESET_1,
    BTN_PRESET_2,
    BTN_PRESET_3,
    BTN_PRESET_4,
    BTN_PRESET_5,
    BTN_PRESET_6,
    BTN_PRESET_HOME
}


DEFINE_MUTUALLY_EXCLUSIVE


([dvTP_PressA, BTN_PRESET_1]..[dvTP_PressA, BTN_PRESET_HOME])
([dvTP_PressB, BTN_PRESET_1]..[dvTP_PressB, BTN_PRESET_HOME])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartVaddioPressAConnection()
{
    vaddioStruct[ID_PRESS_A].uURL = CAM_PRESS_A_IP;
    vaddioStruct[ID_PRESS_A].uPort = 23;
    vaddioStruct[ID_PRESS_A].uFlag = IP_TCP;
    vaddioStruct[ID_PRESS_A].uUser = CAM_USER;
    vaddioStruct[ID_PRESS_A].uPassword = CAM_PASSWORD;
    
    WAIT 30
    {
	SEND_STRING 0, "'Attempt dvCameraPressA Camera IP Connect...'"
	    IP_CLIENT_OPEN (dvCameraPressA.PORT, vaddioStruct[ID_PRESS_A].uURL, vaddioStruct[ID_PRESS_A].uPort, vaddioStruct[ID_PRESS_A].uFlag) 
	    
	TIMED_WAIT_UNTIL (vaddioStruct[ID_PRESS_A].uVaddioSuccess == TRUE) 300 '30 Seconds'
	{
	    fnSendVaddioPressAString ('camera standby get')
	}
    }
}
DEFINE_FUNCTION fnCloseVaddioPressAConnection()
{
    IP_CLIENT_CLOSE (dvCameraPressA.PORT)
}
DEFINE_FUNCTION fnSendVaddioPressAString (CHAR iSend[])
{
    SEND_STRING dvCameraPressA, "iSend, MSG_END";
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
DEFINE_FUNCTION fnParseVaddioPressAIP()
{
    STACK_VAR CHAR iFind[200];
    LOCAL_VAR CHAR iMsg[200]; //Debug Reader...
    LOCAL_VAR CHAR iStandby[2]; //On or Of
    LOCAL_VAR INTEGER nLogAttempt;
    
    WHILE (FIND_STRING (nVaddioPressABuffer, "$0D,$0A",1)) //OR FIND_STRING(nAVBBuffer, 'login:',1))
    {
	iFind = REMOVE_STRING (nVaddioPressABuffer, "$0D,$0A",1)

	iMsg = iFind;
        
	IF (FIND_STRING(iFind,'www.legrandav.com/vaddio',1)) //apart of the login splash page...
	{
	   vaddioStruct[ID_PRESS_A].uVaddioSuccess = FALSE;
		vaddioStruct[ID_PRESS_A].uOnline = FALSE;
	    
	    WAIT 20 '2-Seconds'
	    {
		fnSendVaddioPressAString (vaddioStruct[ID_PRESS_A].uUser)
			SEND_STRING 0, "'dvCameraPressA Login ',vaddioStruct[ID_PRESS_A].uUser ,'=====>'"
		WAIT 20
		{
			fnSendVaddioPressAString (vaddioStruct[ID_PRESS_A].uPassword)
			    SEND_STRING 0, "'dvCameraPressA Login ',vaddioStruct[ID_PRESS_A].uPassword ,'=====>'"
		}
	    }
	}
	IF (FIND_STRING(iFind,'www.vaddio.com',1)) //Older Version Vaddio Roboshot
	{
	     vaddioStruct[ID_PRESS_A].uVaddioSuccess = FALSE;
		vaddioStruct[ID_PRESS_A].uOnline = FALSE;
	    
	    WAIT 20 '2-Seconds'
	    {
		fnSendVaddioPressAString (vaddioStruct[ID_PRESS_A].uUser)
			SEND_STRING 0, "'dvCameraPressA Login ',vaddioStruct[ID_PRESS_A].uUser ,'=====>'"
		WAIT 20
		{
			fnSendVaddioPressAString (vaddioStruct[ID_PRESS_A].uPassword)
			    SEND_STRING 0, "'dvCameraPressA Login ',vaddioStruct[ID_PRESS_A].uPassword ,'=====>'"
		}
	    }
	}
	IF (FIND_STRING (iFind,"'Welcome admin'",1)) 
	{
	    vaddioStruct[ID_PRESS_A].uVaddioSuccess = TRUE;
		SEND_STRING 0, "'dvCameraPressA -Login Success!'"
		    vaddioStruct[ID_PRESS_A].uOnline = TRUE;
	}
	IF (FIND_STRING (iFind, "'Login incorrect'",1)) 
	{
	    vaddioStruct[ID_PRESS_A].uVaddioSuccess = FALSE;
		nLogAttempt = nLogAttempt +1;
		    SEND_STRING 0, "'Login for dvCameraPressA Incorrect Attempt 1 of ',ITOA(nLogAttempt)"
	    
	    WAIT 20 '2-Seconds'
	    {
		fnSendVaddioPressAString (vaddioStruct[ID_PRESS_A].uUser)
			SEND_STRING 0, "'dvCameraPressA Login ',vaddioStruct[ID_PRESS_A].uUser ,'=====>'"
		WAIT 20
		{
			fnSendVaddioPressAString (vaddioStruct[ID_PRESS_A].uPassword)
			    SEND_STRING 0, "'dvCameraPressA Login ',vaddioStruct[ID_PRESS_A].uPassword ,'=====>'"
		}
	    }
	}
	IF (FIND_STRING (iFind, "'standby:'",1)) //standby:        off
	{
	    iStandby = MID_STRING (iFind, 17, 2)
		vaddioStruct[ID_PRESS_A].uOnline = TRUE;
		    
	    
	    SWITCH (iStandby)
	    {
		CASE 'of' : 
		{
		    vaddioStruct[ID_PRESS_A].uPwr = TRUE;
			SEND_STRING 0, "'dvCameraPressA Camera Powered On'"
			    [dvTP_PressA, BTN_CAMERA_PWR] = vaddioStruct[ID_PRESS_A].uPwr;
		}
		CASE 'on' : 
		{
		    vaddioStruct[ID_PRESS_A].uPwr = FALSE;
			SEND_STRING 0, "'dvCameraPressA Camera in Standby...'"
			    [dvTP_PressA, BTN_CAMERA_PWR] = vaddioStruct[ID_PRESS_A].uPwr;
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnStartVaddioPressBConnection()
{
    vaddioStruct[ID_PRESS_B].uURL = CAM_PRESS_B_IP;
    vaddioStruct[ID_PRESS_B].uPort = 23;
    vaddioStruct[ID_PRESS_B].uFlag = IP_TCP;
    vaddioStruct[ID_PRESS_B].uUser = CAM_USER;
    vaddioStruct[ID_PRESS_B].uPassword = CAM_PASSWORD;
    
    WAIT 30
    {
	SEND_STRING 0, "'Attempt dvCameraPressB Camera IP Connect...'"
	    IP_CLIENT_OPEN (dvCameraPressB.PORT, vaddioStruct[ID_PRESS_B].uURL, vaddioStruct[ID_PRESS_B].uPort, vaddioStruct[ID_PRESS_B].uFlag) 
	    
	TIMED_WAIT_UNTIL (vaddioStruct[ID_PRESS_B].uVaddioSuccess == TRUE) 300 '30 Seconds'
	{
	    fnSendVaddioPressBString ('camera standby get')
	}
    }
}
DEFINE_FUNCTION fnCloseVaddioPressBConnection()
{
    IP_CLIENT_CLOSE (dvCameraPressB.PORT)
}
DEFINE_FUNCTION fnSendVaddioPressBString (CHAR iSend[])
{
    SEND_STRING dvCameraPressB, "iSend, MSG_END";
}
DEFINE_FUNCTION fnParseVaddioPressBIP()
{
    STACK_VAR CHAR iFind[200];
    LOCAL_VAR CHAR iMsg[200]; //Debug Reader...
    LOCAL_VAR CHAR iStandby[2]; //On or Of
    LOCAL_VAR INTEGER nLogAttempt;
    
    WHILE (FIND_STRING (nVaddioPressBBuffer, "$0D,$0A",1)) //OR FIND_STRING(nAVBBuffer, 'login:',1))
    {
	iFind = REMOVE_STRING (nVaddioPressBBuffer, "$0D,$0A",1)

	iMsg = iFind;
        
	IF (FIND_STRING(iFind,'www.legrandav.com/vaddio',1)) //apart of the login splash page...
	{
	   vaddioStruct[ID_PRESS_B].uVaddioSuccess = FALSE;
		vaddioStruct[ID_PRESS_B].uOnline = FALSE;
	    
	    WAIT 20 '2-Seconds'
	    {
		fnSendVaddioPressBString (vaddioStruct[ID_PRESS_B].uUser)
			SEND_STRING 0, "'dvCameraPressB Login ',vaddioStruct[ID_PRESS_B].uUser ,'=====>'"
		WAIT 20
		{
			fnSendVaddioPressBString (vaddioStruct[ID_PRESS_B].uPassword)
			    SEND_STRING 0, "'dvCameraPressB Login ',vaddioStruct[ID_PRESS_B].uPassword ,'=====>'"
		}
	    }
	}
	IF (FIND_STRING(iFind,'www.vaddio.com',1)) //Older Version Vaddio Roboshot
	{
	     vaddioStruct[ID_PRESS_B].uVaddioSuccess = FALSE;
		vaddioStruct[ID_PRESS_B].uOnline = FALSE;
	    
	    WAIT 20 '2-Seconds'
	    {
		fnSendVaddioPressBString (vaddioStruct[ID_PRESS_B].uUser)
			SEND_STRING 0, "'dvCameraPressB Login ',vaddioStruct[ID_PRESS_B].uUser ,'=====>'"
		WAIT 20
		{
			fnSendVaddioPressBString (vaddioStruct[ID_PRESS_B].uPassword)
			    SEND_STRING 0, "'dvCameraPressB Login ',vaddioStruct[ID_PRESS_B].uPassword ,'=====>'"
		}
	    }
	}
	IF (FIND_STRING (iFind,"'Welcome admin'",1)) 
	{
	    vaddioStruct[ID_PRESS_B].uVaddioSuccess = TRUE;
		SEND_STRING 0, "'dvCameraPressB -Login Success!'"
		    vaddioStruct[ID_PRESS_B].uOnline = TRUE;
	}
	IF (FIND_STRING (iFind, "'Login incorrect'",1)) 
	{
	    vaddioStruct[ID_PRESS_B].uVaddioSuccess = FALSE;
		nLogAttempt = nLogAttempt +1;
		    SEND_STRING 0, "'Login for dvCameraPressB Incorrect Attempt 1 of ',ITOA(nLogAttempt)"
	    
	    WAIT 20 '2-Seconds'
	    {
		fnSendVaddioPressBString (vaddioStruct[ID_PRESS_B].uUser)
			SEND_STRING 0, "'dvCameraPressB Login ',vaddioStruct[ID_PRESS_B].uUser ,'=====>'"
		WAIT 20
		{
			fnSendVaddioPressBString (vaddioStruct[ID_PRESS_B].uPassword)
			    SEND_STRING 0, "'dvCameraPressB Login ',vaddioStruct[ID_PRESS_B].uPassword ,'=====>'"
		}
	    }
	}
	IF (FIND_STRING (iFind, "'standby:'",1)) //standby:        off
	{
	    iStandby = MID_STRING (iFind, 17, 2)
		vaddioStruct[ID_PRESS_B].uOnline = TRUE;

	    SWITCH (iStandby)
	    {
		CASE 'of' : 
		{
		    vaddioStruct[ID_PRESS_B].uPwr = TRUE;
			SEND_STRING 0, "'dvCameraPressB Camera Powered On'"
			    [dvTP_PressB, BTN_CAMERA_PWR] = vaddioStruct[ID_PRESS_B].uPwr;
		}
		CASE 'on' : 
		{
		    vaddioStruct[ID_PRESS_B].uPwr = FALSE;
			SEND_STRING 0, "'dvCameraPressB Camera in Standby...'"
			    [dvTP_PressB, BTN_CAMERA_PWR] = vaddioStruct[ID_PRESS_B].uPwr;
		}
	    }
	}
    }
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvCameraPressA, nVaddioPressABuffer;
CREATE_BUFFER dvCameraPressB, nVaddioPressBBuffer;

WAIT 150
{
    fnStartVaddioPressAConnection();
}
WAIT 200
{
    fnStartVaddioPressBConnection();
}


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_PressA, TILT_UP] 
BUTTON_EVENT [dvTP_PressA, TILT_DOWN] 
BUTTON_EVENT [dvTP_PressA, PAN_LEFT] 
BUTTON_EVENT [dvTP_PressA, PAN_RIGHT] 
BUTTON_EVENT [dvTP_PressA, ZOOM_IN] 
BUTTON_EVENT [dvTP_PressA, ZOOM_OUT] //Camera Move
{
    PUSH :
    {
	TOTAL_OFF [dvTP_PressA, nPresetsPressA]
	SEND_STRING 0, "'Sending dvCameraPressA Movement'"
	
	    SWITCH (BUTTON.INPUT.CHANNEL)
	    {
		CASE TILT_UP : fnSendVaddioPressAString (CAM_TILT_UP)
		CASE TILT_DOWN : fnSendVaddioPressAString (CAM_TILT_DN)
		CASE PAN_LEFT : fnSendVaddioPressAString (CAM_PAN_LEFT)
		CASE PAN_RIGHT : fnSendVaddioPressAString (CAM_PAN_RIGHT)
		CASE ZOOM_IN : fnSendVaddioPressAString (CAM_ZOOM_IN)
		CASE ZOOM_OUT : fnSendVaddioPressAString (CAM_ZOOM_OUT)
	    }
    }
    RELEASE :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
		CASE TILT_UP : 
		CASE TILT_DOWN :
		{
		    fnSendVaddioPressAString (CAM_TILT_STOP)
		}
		CASE PAN_LEFT : 
		CASE PAN_RIGHT : 
		{
		    fnSendVaddioPressAString (CAM_PAN_STOP)
		}
		CASE ZOOM_IN :
		CASE ZOOM_OUT : 
		{
		    fnSendVaddioPressAString (CAM_ZOOM_STOP)
		}
	}
    }
}
BUTTON_EVENT [dvTP_PressA, BTN_PRESET_1]
BUTTON_EVENT [dvTP_PressA, BTN_PRESET_2]
BUTTON_EVENT [dvTP_PressA, BTN_PRESET_3]
BUTTON_EVENT [dvTP_PressA, BTN_PRESET_4]
BUTTON_EVENT [dvTP_PressA, BTN_PRESET_5]
BUTTON_EVENT [dvTP_PressA, BTN_PRESET_6] //Recall + Save Presets...
{	
    HOLD [30] :
    {	
	SEND_COMMAND dvTP_PressA, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	    fnSendVaddioPressAString ("'camera preset store ',ITOA(BUTTON.INPUT.CHANNEL -70)")
	    
	WAIT 50 
	{
	    SEND_COMMAND dvTP_PressA, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
	}
    }
    RELEASE :
    {    
	ON [dvTP_PressA, BUTTON.INPUT.CHANNEL]
	    fnSendVaddioPressAString ("'camera preset recall ',ITOA(BUTTON.INPUT.CHANNEL -70)")
    }
}
BUTTON_EVENT [dvTP_PressA, BTN_PRESET_HOME]
{
    PUSH :
    {
	ON [dvTP_PressA, BTN_PRESET_HOME]
		fnSendVaddioPressAString (CAM_HOME_RESET)
	    
	    WAIT 10 fnSendVaddioPressAString (CAM_AUTO_FOCUS)
		WAIT 20 fnSendVaddioPressAString (CAM_AUTO_BALANCE)
    }
}

DEFINE_EVENT
BUTTON_EVENT [dvTP_PressB, TILT_UP] 
BUTTON_EVENT [dvTP_PressB, TILT_DOWN] 
BUTTON_EVENT [dvTP_PressB, PAN_LEFT] 
BUTTON_EVENT [dvTP_PressB, PAN_RIGHT] 
BUTTON_EVENT [dvTP_PressB, ZOOM_IN] 
BUTTON_EVENT [dvTP_PressB, ZOOM_OUT] //Camera Move
{
    PUSH :
    {
	TOTAL_OFF [dvTP_PressB, nPresetsPressA]
	SEND_STRING 0, "'Sending dvCameraPressB Movement'"
	
	    SWITCH (BUTTON.INPUT.CHANNEL)
	    {
		CASE TILT_UP : fnSendVaddioPressBString (CAM_TILT_UP)
		CASE TILT_DOWN : fnSendVaddioPressBString (CAM_TILT_DN)
		CASE PAN_LEFT : fnSendVaddioPressBString (CAM_PAN_LEFT)
		CASE PAN_RIGHT : fnSendVaddioPressBString (CAM_PAN_RIGHT)
		CASE ZOOM_IN : fnSendVaddioPressBString (CAM_ZOOM_IN)
		CASE ZOOM_OUT : fnSendVaddioPressBString (CAM_ZOOM_OUT)
	    }
    }
    RELEASE :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
		CASE TILT_UP : 
		CASE TILT_DOWN :
		{
		    fnSendVaddioPressBString (CAM_TILT_STOP)
		}
		CASE PAN_LEFT : 
		CASE PAN_RIGHT : 
		{
		    fnSendVaddioPressBString (CAM_PAN_STOP)
		}
		CASE ZOOM_IN :
		CASE ZOOM_OUT : 
		{
		    fnSendVaddioPressBString (CAM_ZOOM_STOP)
		}
	}
    }
}
BUTTON_EVENT [dvTP_PressB, BTN_PRESET_1]
BUTTON_EVENT [dvTP_PressB, BTN_PRESET_2]
BUTTON_EVENT [dvTP_PressB, BTN_PRESET_3]
BUTTON_EVENT [dvTP_PressB, BTN_PRESET_4]
BUTTON_EVENT [dvTP_PressB, BTN_PRESET_5]
BUTTON_EVENT [dvTP_PressB, BTN_PRESET_6] //Recall + Save Presets...
{	
    HOLD [30] :
    {	
	SEND_COMMAND dvTP_PressB, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	    fnSendVaddioPressBString ("'camera preset store ',ITOA(BUTTON.INPUT.CHANNEL -70)")
	    
	WAIT 50 
	{
	    SEND_COMMAND dvTP_PressB, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
	}
    }
    RELEASE :
    {    
	ON [dvTP_PressB, BUTTON.INPUT.CHANNEL]
	    fnSendVaddioPressBString ("'camera preset recall ',ITOA(BUTTON.INPUT.CHANNEL -70)")
    }
}
BUTTON_EVENT [dvTP_PressB, BTN_PRESET_HOME]
{
    PUSH :
    {
	ON [dvTP_PressB, BTN_PRESET_HOME]
		fnSendVaddioPressBString (CAM_HOME_RESET)
	    
	    WAIT 10 fnSendVaddioPressBString (CAM_AUTO_FOCUS)
		WAIT 20 fnSendVaddioPressBString (CAM_AUTO_BALANCE)
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_PressA]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
    }
}
DATA_EVENT [dvTP_PressB]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
    }
}
DATA_EVENT [dvCameraPressA]
{
    ONLINE :
    {
	//
    }
    OFFLINE :
    {
	vaddioStruct[ID_PRESS_A].uOnline = FALSE;
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvCameraPressA : onerror : ',GetVaddioIpError(DATA.NUMBER)");
	    SEND_STRING 0, "'dvCameraPressA Camera onerror : ',GetVaddioIpError(DATA.NUMBER)";
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 :
	    {
		vaddioStruct[ID_PRESS_A].uOnline = FALSE;
	    }
	    DEFAULT :
	    {
		vaddioStruct[ID_PRESS_A].uOnline = FALSE;
		    vaddioStruct[ID_PRESS_A].uVaddioSuccess = FALSE;
	    }
	}
    }
    STRING :
    {	
	fnParseVaddioPressAIP();
    }
}
DATA_EVENT [dvCameraPressB]
{
    ONLINE :
    {
	//
    }
    OFFLINE :
    {
	vaddioStruct[ID_PRESS_B].uOnline = FALSE;
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvCameraPressB : onerror : ',GetVaddioIpError(DATA.NUMBER)");
	    SEND_STRING 0, "'dvCameraPressB Camera onerror : ',GetVaddioIpError(DATA.NUMBER)";
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 :
	    {
		vaddioStruct[ID_PRESS_B].uOnline = FALSE;
	    }
	    DEFAULT :
	    {
		vaddioStruct[ID_PRESS_B].uOnline = FALSE;
		    vaddioStruct[ID_PRESS_B].uVaddioSuccess = FALSE;
	    }
	}
    }
    STRING :
    {	
	fnParseVaddioPressBIP();
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 550 '55 Seconds'
    {
	IF (vaddioStruct[ID_PRESS_A].uOnline == FALSE)
	{
	    fnStartVaddioPressAConnection();
	}
	ELSE IF (vaddioStruct[ID_PRESS_A].uVaddioSuccess  == TRUE)
	{
	    fnSendVaddioPressAString (CAM_PWR_STATUS)
	}
	ELSE
	{
	    //
	}
    }
    WAIT 600 '60 Seconds'
    {
	IF (vaddioStruct[ID_PRESS_B].uOnline == FALSE)
	{
	    fnStartVaddioPressBConnection();
	}
	ELSE IF (vaddioStruct[ID_PRESS_B].uVaddioSuccess  == TRUE)
	{
	    fnSendVaddioPressBString (CAM_PWR_STATUS)
	}
	ELSE
	{
	    //
	}
    }
}





