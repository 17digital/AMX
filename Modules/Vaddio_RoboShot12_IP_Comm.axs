MODULE_NAME='Vaddio_RoboShot12_IP_Comm' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])


DEFINE_CONSTANT

CHAR MSG_END			= $0D;
CHAR MSG_FD			= $0A;

LONG TL_IPCOMM_CONNECT	= 5003; 
DATA_INITIALIZED			= 251
VADDIO_PORT				= 23;

CHAR CAM_USER[5]						= 'admin'
CHAR CAM_PASSWORD[8]				= 'password'

//Camera Commands....
CHAR CAM_TILT_UP[]					= 'camera tilt up 6' //1-20
CHAR CAM_TILT_UP_FAST[]				= 'camera tilt up 9'
CHAR CAM_TILT_DN[]					= 'camera tilt down 6'
CHAR CAM_TILT_DN_FAST[]				= 'camera tilt down 9'
CHAR CAM_TILT_STOP[]					= 'camera tilt stop'
CHAR CAM_PAN_LEFT[]					= 'camera pan left 8' //Speed 1-24
CHAR CAM_PAN_LEFT_FAST[]			= 'camera pan left 10'
CHAR CAM_PAN_RIGHT[]				= 'camera pan right 8'  //Speed 1-24
CHAR CAM_PAN_RIGHT_FAST[]			= 'camera pan right 10'  //Speed 1-24
CHAR CAM_PAN_STOP[]				= 'camera pan stop' //Speed 07 07
CHAR CAM_ZOOM_IN[]					= 'camera zoom in 2' 
CHAR CAM_ZOOM_OUT[]				= 'camera zoom out 2' //Standard Zoom Speeds 1-7
CHAR CAM_ZOOM_IN_FAST[]			= 'camera zoom in 5' 
CHAR CAM_ZOOM_OUT_FAST[]			= 'camera zoom out 5' //Standard Zoom
CHAR CAM_ZOOM_STOP[]				= 'camera zoom stop' //Standard Zoom
CHAR CAM_PWR_STATUS[] 				= 'camera standby get'
CHAR CAM_AUTO_FOCUS[]				= 'camera focus mode auto'
CHAR CAM_HOME_RESET[]				= 'camera home'
CHAR CAM_AUTO_BALANCE[]			= 'camera ccu set auto_white_balance on'
CHAR CAM_NET_STATUS[]				= 'network settings get'

DEFINE_VARIABLE

VOLATILE LONG lTlIpConnect[] = {15000}; //15 Second Poll...
VOLATILE CHAR nCamBuffer[1500];
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPower;
VOLATILE INTEGER uVaddioSuccess;

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSendCameraString (CHAR iMsg[])
{
    SEND_STRING dvDevice, "iMsg, MSG_END";
}
DEFINE_FUNCTION fnStartCameraConnection()
{
    IP_CLIENT_OPEN(dvDevice.PORT, devIP, VADDIO_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start Camera Connection...'"
}
DEFINE_FUNCTION fnCloseVaddioCamConnection()
{
    IP_CLIENT_CLOSE (dvDevice.PORT)
	SEND_STRING 0, "'Closed Vaddio Camera Connection'"
}
DEFINE_FUNCTION char[100] GetVaddioCamIpError (LONG iErrorCode)
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
DEFINE_FUNCTION fnGoPassword(CHAR bUser[5], CHAR bPass[10]) {
WAIT 20 '2-Seconds' {
		fnSendCameraString (bUser)
			SEND_STRING vdvDevice, "'Sent Vaddio Camera Login ',bUser ,'=====>'"
		WAIT 20 	{
			fnSendCameraString (bPass)
			    SEND_STRING vdvDevice, "'Sent Vaddio Camera Password ',bPass ,'=====>'"
		}
	    }
}
DEFINE_FUNCTION fnParseVaddioCamera()
{
    STACK_VAR CHAR iFind[200];
    LOCAL_VAR CHAR iStandby[2]; //On or Of
    LOCAL_VAR INTEGER nLogAttempt;

    WHILE (FIND_STRING (nCamBuffer, "$0D,$0A",1)) //
    {
	iFind = REMOVE_STRING (nCamBuffer, "$0D,$0A",1)
	
	IF (FIND_STRING(iFind,'www.legrandav.com/vaddio',1)) {
	   uVaddioSuccess = FALSE;
		bIsInitialized = FALSE;
		    [vdvDevice, DATA_INITIALIZED] = bIsInitialized;
	    
	    fnGoPassword(CAM_USER, CAM_PASSWORD);
	}
	IF (FIND_STRING(iFind,'www.vaddio.com',1)) //For Older Versions of Vaddio
	{
	   uVaddioSuccess = FALSE;
		bIsInitialized = FALSE;
		[vdvDevice, DATA_INITIALIZED] = bIsInitialized;
	    
	    fnGoPassword(CAM_USER, CAM_PASSWORD);
	}
	IF (FIND_STRING (iFind,"'Welcome admin'",1)) {
		uVaddioSuccess = TRUE;
			SEND_COMMAND vdvDevice, "'Vaddio Camera - Login Success!'"
			
			bIsInitialized = TRUE;
		[vdvDevice, DATA_INITIALIZED] = bIsInitialized;
		    SEND_COMMAND vdvDevice, "'FBCAMERA-ONLINE'"
	}
	IF (FIND_STRING (iFind, "'Login incorrect'",1)) 
	{
	    uVaddioSuccess = FALSE;
		nLogAttempt = nLogAttempt +1;
		SEND_STRING 0, "'Login for Vaddio Camera Incorrect Attempt 1 of ',ITOA(nLogAttempt)"
		    SEND_COMMAND vdvDevice, "'Vaddio Camera - Login Incorrect!'"
		
		    bIsInitialized = FALSE;
		[vdvDevice, DATA_INITIALIZED] = bIsInitialized;
		    SEND_COMMAND vdvDevice, "'FBCAMERA-OFFLINE'"
	    
	    fnGoPassword(CAM_USER, CAM_PASSWORD);
	}
	IF (FIND_STRING (iFind, "'standby:'",1)) //(standby:        off)
	{
	    iStandby = MID_STRING (iFind, 17, 2)
		bIsInitialized = TRUE;
	    
	    SWITCH (iStandby)
	    {
		CASE 'of' : //off
		{
		    bPower = TRUE;
			[vdvDevice, 255] = bPower;
			    SEND_COMMAND vdvDevice, "'FBCAMERA-PWRON'"
		}
		CASE 'on' : //Camera is Sleep
		{
		    bPower = FALSE;
			[vdvDevice, 255] = bPower;
			    SEND_COMMAND vdvDevice, "'FBCAMERA-PWROFF'"
		}
	    }
	}
    }
}

DEFINE_START

WAIT 50 {
    TIMELINE_CREATE(TL_IPCOMM_CONNECT,lTlIpConnect,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	CREATE_BUFFER dvDevice, nCamBuffer;
}


DEFINE_EVENT
DATA_EVENT [dvDevice]
{
    ONLINE :
    {
	//bIsInitialized = TRUE;
    }
    OFFLINE :
    {
	bIsInitialized = FALSE;
    }
    ONERROR :
    {
	SEND_COMMAND vdvDevice, "'Camera Error : ',GetVaddioCamIpError(DATA.NUMBER)";
	    bIsInitialized = FALSE;
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14 :
	    {
		fnCloseVaddioCamConnection();
	    }
	}
    }
    STRING :
    {
	fnParseVaddioCamera();
    }
}
DATA_EVENT [vdvDevice]
{
    COMMAND :
    {
	STACK_VAR INTEGER cSTR; //Memory Recall
	STACK_VAR INTEGER cSTS; //Memory Save
	
        CHAR cVaddioMsg[100];
	    cVaddioMsg = DATA.TEXT;
	
	IF (FIND_STRING(cVaddioMsg,'CAMERAPRESET-',1)) {
		REMOVE_STRING(cVaddioMsg,'-',1) //Removes everything up to and including the hyphen
		    cSTR = ATOI(cVaddioMsg);
		    	    fnSendCameraString("'camera preset recall ',ITOA(cSTR)")
	}
	IF (FIND_STRING(cVaddioMsg,'CAMERAPRESETSAVE-',1)) {
		REMOVE_STRING(cVaddioMsg,'-',1) //Removes everything up to and including the hyphen
		    cSTS = ATOI(cVaddioMsg)
		        fnSendCameraString("'camera preset store ',ITOA(cSTS)")
	}
    }
}
CHANNEL_EVENT [vdvDevice, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 99 : //Home
	    {
		fnSendCameraString(CAM_HOME_RESET)
	    }
	    CASE 132 : //Tilt Up
	    {
		fnSendCameraString(CAM_TILT_UP)  //1-20
	    }
	    CASE 133 : //Titl Dn
	    {
		fnSendCameraString(CAM_TILT_DN)  //1-20
	    }
	    CASE 134 : //Pan Left
	    {
		fnSendCameraString(CAM_PAN_LEFT) //1-24
	    }
	    CASE 135 : //Pan Right
	    {
		fnSendCameraString(CAM_PAN_RIGHT) //1-24
	    }
	    CASE 158 : //Zoom In
	    {
		fnSendCameraString(CAM_ZOOM_IN) //1-7
		
	    }
	    CASE 159 : //Zoom Out
	    {
		fnSendCameraString(CAM_ZOOM_OUT) //1-7
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 132 :
	    CASE 133 :
	    {
		fnSendCameraString(CAM_TILT_STOP) 
	    }
	    CASE 134 :
	    CASE 135 :
	    {
		fnSendCameraString(CAM_PAN_STOP) 
	    }
	    CASE 158 :
	    CASE 159 :
	    {
		fnSendCameraString(CAM_ZOOM_STOP) 
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT]
{
    IF (bIsInitialized == FALSE) {
	    fnStartCameraConnection();
    } 
    ELSE IF (uVaddioSuccess == TRUE)
    {
	fnSendCameraString(CAM_PWR_STATUS);

    } ELSE {
	SEND_COMMAND vdvDevice, "'Password incorrect or not Inititalized'"
    }
}
