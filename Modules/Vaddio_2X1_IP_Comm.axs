MODULE_NAME='Vaddio_2X1_IP_Comm' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])

DEFINE_CONSTANT

CHAR MSG_END			= $0D;
CHAR MSG_FD			= $0A;

LONG TL_IPCOMM_CONNECT	= 5002; 
DATA_INITIALIZED				= 251
VADDIO_PORT					= 23;

CHAR AVB_USER[5]						= 'admin'
CHAR AVB_PASSWORD[8]				= 'password'


//Av Bridge Stuff....
CHAR AVB_PIP_ON[]					= 'video program pip on'
CHAR AVB_PIP_OFF[]					= 'video program pip off'
CHAR AVB_PIP_GET[]					= 'video program pip get'

IN_AVB_CAMERA						= 1;
IN_AVB_CONTENT						= 2;

//CH Buttons..
CH_INPUT_1						= 1;
CH_INPUT_2						= 2;
CH_AVB_PIP_TOGGLE				= 246;
CH_AVB_SWAP_SOURCE				= 247;
CH_AVB_PIP_LAYOUT				= 248;


DEFINE_VARIABLE

VOLATILE LONG lTlIpConnect[] = {25000}; // 25 Second Poll...
VOLATILE CHAR nAVBBuffer[1500];
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPower;

//VOLATILE INTEGER bAvBridge1Flip = 1;
VOLATILE INTEGER bAvBridge1Flip;

VOLATILE INTEGER aVaddioSuccess;
VOLATILE INTEGER aPIPOn;
VOLATILE INTEGER aBGSwap;
VOLATILE INTEGER aLogAttempt;
VOLATILE INTEGER aDbug;

VOLATILE CHAR nPIPLayout[5][15] =
{
    'lower_right',
    'lower_left',
    'upper_left',
    'upper_right',
    'left_right'
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSendAVBString(CHAR iSend[])
{
    SEND_STRING dvDevice, "iSend, MSG_END";
}
DEFINE_FUNCTION fnStartAVBConnection()
{
    IP_CLIENT_OPEN(dvDevice.PORT, devIP, VADDIO_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start AVB Connection...'"
}
DEFINE_FUNCTION fnCloseVaddioAVBConnection()
{
    IP_CLIENT_CLOSE (dvDevice.PORT)
	SEND_STRING 0, "'Closed Vaddio AVB Connection'"
}
DEFINE_FUNCTION char[100] GetVaddioAVBIpError (LONG iErrorCode)
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
		fnSendAVBString (bUser)
			SEND_STRING vdvDevice, "'Sent Vaddio Camera Login ',bUser ,'=====>'"
		WAIT 20 	{
			fnSendAVBString (bPass)
			    SEND_STRING vdvDevice, "'Sent Vaddio Camera Password ',bPass ,'=====>'"
		}
	    }
}
DEFINE_FUNCTION fnParseVaddioAVB()
{
    STACK_VAR CHAR iFind[200];
    STACK_VAR CHAR iMsg[200]; //Debug Reader...
    STACK_VAR INTEGER cInput;
    LOCAL_VAR CHAR cStatusPIP[15]
    
    WHILE (FIND_STRING (nAVBBuffer, "MSG_END,MSG_FD",1)) //OR FIND_STRING(nAVBBuffer, 'login:',1))
    {
	iFind = REMOVE_STRING (nAVBBuffer, "MSG_END,MSG_FD",1)

	IF (FIND_STRING(iFind,'www.legrandav.com/vaddio',1)) //apart of the login splash page...
	{
	    aVaddioSuccess = FALSE;
		bIsInitialized = TRUE;
	    
	    WAIT 20 {
		fnGoPassword (AVB_USER, AVB_PASSWORD);
	    }
	}
	IF (FIND_STRING (iFind,"'Welcome admin'",1)) {
		aVaddioSuccess = TRUE;
	}
	IF (FIND_STRING (iFind, "'Login incorrect'",1)) 
	{
	    aVaddioSuccess = FALSE;
		aLogAttempt = aLogAttempt +1;
		SEND_STRING vdvDevice, "'Login for Vaddio 2x1 Incorrect Attempt 1 of ',ITOA(aLogAttempt)"
	    
	    WAIT 20 '2-Seconds' {
	    	fnGoPassword (AVB_USER, AVB_PASSWORD);
	    }
	    //After Incorrect login - 
	    //vaddio-av-bridge-2x1-Mac-Address login: //Will result...with no Carriage Return
	}
	IF (FIND_STRING (iFind,'video program source set input',1)) //Direct Change FB...
	{
	   aVaddioSuccess = TRUE;
	   REMOVE_STRING (iFind,'video program source set input',1)
	    cInput = ATOI(LEFT_STRING(iFind,1))
		SEND_COMMAND vdvDevice, "'INPUT-',ITOA(cInput)"
	    
	    SWITCH (cInput)
	    {
		CASE IN_AVB_CAMERA : {
		    aBGSwap = FALSE;
		}
		CASE IN_AVB_CONTENT : {
		    aBGSwap = TRUE;
		}
	    }
	}
	IF (FIND_STRING (iFind, "'source: input'",1))
	{
	    aVaddioSuccess = TRUE;
	    REMOVE_STRING(iFind,'source: input',1)
		    cInput  = ATOI(LEFT_STRING (iFind,1)) //Only need Remaing #
			SEND_COMMAND vdvDevice, "'INPUT-',ITOA(cInput)"
		
	    SWITCH (cInput)
	    {
		CASE IN_AVB_CAMERA : {
			aBGSwap = FALSE;
			    
		}
		CASE IN_AVB_CONTENT : {
			aBGSwap = TRUE;
		}
	    }
	}
	IF (FIND_STRING (iFind,'video program pip ',1)) //Direct On FB...
	{
	    aVaddioSuccess = TRUE;
	    REMOVE_STRING (iFind,'video program pip ',1)
	    cStatusPIP = iFind;
	    
	    IF (FIND_STRING(cStatusPIP,'on',1))  {
		aPIPOn = TRUE;
		    SEND_COMMAND vdvDevice, "'PIP-ON'"
	    }
	    IF (FIND_STRING(cStatusPIP,'off',1)) {
		    aPIPOn = FALSE;
			SEND_COMMAND vdvDevice, "'PIP-OFF'"
	    }
	}
	IF (FIND_STRING (iFind, 'pip:    ',1)) //From PIP Get Query Response
	{
	    aVaddioSuccess = TRUE;
	    
	    REMOVE_STRING (iFind, 'pip:    ',1)
		cStatusPIP = iFind;
	    IF (FIND_STRING(cStatusPIP,'on',1)) {
		    aPIPOn = TRUE;
			SEND_COMMAND vdvDevice, "'PIP-ON'"
	    }
	    IF (FIND_STRING(cStatusPIP,'off',1)) {
		    aPIPOn = FALSE;
			SEND_COMMAND vdvDevice, "'PIP-OFF'"
	    }
	}
    }
}
DEFINE_FUNCTION fnGetAVBStatus() {
    fnSendAVBString ('video program source get')
    WAIT 20 {
	fnSendAVBString ('video program pip get')
    }
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvDevice, nAVBBuffer;
WAIT 50 {
    TIMELINE_CREATE(TL_IPCOMM_CONNECT,lTlIpConnect,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
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
	SEND_COMMAND vdvDevice, "'AVB Error : ',GetVaddioAVBIpError(DATA.NUMBER)";
	    bIsInitialized = FALSE;
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14 :
	    {
		fnCloseVaddioAVBConnection();
	    }
	}
    }
    STRING :
    {
	fnParseVaddioAVB();
    }
}
CHANNEL_EVENT [vdvDevice, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE CH_INPUT_1 : {
		fnSendAVBString ("'video program source set input',ITOA(IN_AVB_CAMERA)")
	    }
	    CASE CH_INPUT_2 : {
		    fnSendAVBString ("'video program source set input',ITOA(IN_AVB_CONTENT)")
	    }
	    CASE CH_AVB_PIP_TOGGLE : {
		IF (aPIPOn == FALSE) {
		    fnSendAVBString (AVB_PIP_ON)
		} ELSE {
		    fnSendAVBString (AVB_PIP_OFF)
		}
	    }
	    CASE CH_AVB_SWAP_SOURCE :
	    {
		IF (aBGSwap == FALSE) {
		    fnSendAVBString ("'video program source set input',ITOA(IN_AVB_CONTENT)")
		} ELSE {
			fnSendAVBString ("'video program source set input',ITOA(IN_AVB_CAMERA)")
		}
	    }
	    CASE CH_AVB_PIP_LAYOUT : 
	    {
		bAvBridge1Flip = bAvBridge1Flip + 1;
		fnSendAVBString ("'video program pip layout ',nPIPLayout[bAvBridge1Flip],MSG_END");
	
		    IF (bAvBridge1Flip >= LENGTH_ARRAY(nPIPLayout)) {
			bAvBridge1Flip = 0;
		    }
	    }
	}
    }
    OFF :
    {
	//
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT]
{
    [vdvDevice, 255] = bIsInitialized;
    
    IF (bIsInitialized == FALSE) {
	    fnStartAVBConnection();
	} ELSE IF (aVaddioSuccess == FALSE) {
		SEND_STRING vdvDevice, "'dvAvbridge : Unsuccessful'"
	} ELSE {
	    fnGetAVBStatus();
	}
}