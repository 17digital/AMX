MODULE_NAME='Planar_VC_WALL_IP' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])


DEFINE_CONSTANT

INTEGER IP_PORT				= 57;

// Time Lines
LONG TL_IPCOMM_CONNECT	= 5002; 

CHAR CR = $0D;
CHAR LF = $0A;
CHAR CRLF[] = {CR,LF};
CHAR SPACE = ' ';
CHAR TABH = $09;
CHAR TABV = $11;
CHAR ESC = $27;
CHAR NULL = $00;
CHAR SOH = $01;
CHAR STX = $02;
CHAR ETX = $03;
CHAR EOT = $04;
CHAR ACK = $06;
CHAR BS = $08;
CHAR NAK = $21;

DATA_INITIALIZED			= 251;

// Commands
CHAR SET_POWER_ON[]		= 'SYSTEM.POWER=ON'
CHAR SET_POWER_OFF[]		= 'SYSTEM.POWER=OFF'
CHAR GET_SYSTEM_STATE[]		= 'SYSTEM.STATE?'
CHAR GET_POWER_STATE[]		= 'SYSTEM.POWER?'



DEFINE_VARIABLE

VOLATILE CHAR ResponseBuffer[500];
VOLATILE LONG lTlIpConnect[] = {25000}; //25-second Query Loop...
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPwr;
VOLATILE CHAR bDbug;



(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartPlanarConnection() {
		        IP_CLIENT_OPEN(dvDevice.PORT, devIP, IP_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start Planar Connection...'"
    
    WAIT 30 {
	    IF (bIsInitialized == TRUE) {
		IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
		    TIMELINE_SET (TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY (lTlIpConnect)] -100);
		}
	    }
	}
}
DEFINE_FUNCTION fnClosePlanarConnection() {
	IP_CLIENT_CLOSE (dvDevice.PORT);
		SEND_STRING vdvDevice, "'Closed Planar Connection...'"
}
DEFINE_FUNCTION CHAR[100] GetPlanarIPError (LONG iErrorCode)
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
DEFINE_FUNCTION SendDeviceString (CHAR iMsg[])
{
    SEND_STRING dvDevice, "iMsg, CR";
}
DEFINE_FUNCTION ReInitialize(INTEGER bState)
{
    SWITCH (bState)
    {
	CASE 1 : {
	    bIsInitialized = TRUE;
		[vdvDevice, 251] = bIsInitialized;
	}
	DEFAULT : {
	    bIsInitialized = FALSE;
		[vdvDevice, DATA_INITIALIZED] = bIsInitialized;
	
	ResponseBuffer = ""; //Clear Buffer
	
	    bPwr = FALSE;
		    SEND_COMMAND vdvDevice, "'FBTELEVISION-OFFLINE'"
	}
    }
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{
    STACK_VAR CHAR nActivePreset[1];
    
    bIsInitialized = TRUE;
    [vdvDevice, DATA_INITIALIZED] = bIsInitialized;

	SEND_COMMAND vdvDevice, "'FBTELEVISION-ONLINE'"
	
    SELECT
    {
	ACTIVE (FIND_STRING (iMsg,'SYSTEM.STATE:',1)):
	{
	    REMOVE_STRING (iMsg,':',1)
		SET_LENGTH_STRING (iMsg, LENGTH_STRING(iMsg)-1) //Remove $0D on End...
		
		SWITCH (iMsg)
		{
		    CASE 'ON' :
		    CASE 'POWERING.ON' :
		    {
			bPwr = TRUE;
			    [vdvDevice, 255] = bPwr;
				SEND_COMMAND vdvDevice, "'FBTELEVISION-PWRON'"
		    }
		    CASE 'OFF' :
		    CASE 'POWERING.DOWN' :
		    CASE 'STANDBY' :
		    {
			bPwr = FALSE;
			    [vdvDevice, 255] = bPwr;
				SEND_COMMAND vdvDevice, "'FBTELEVISION-PWROFF'"
		    }
		    CASE 'FAULT' : {
			SEND_STRING vdvDevice, "'ERROR-SYSTEMFAULT'"
		    }
		}
	}
    }
}


DEFINE_START

CREATE_BUFFER dvDevice, ResponseBuffer;

WAIT 100 {
    TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTlIpConnect,LENGTH_ARRAY(lTlIpConnect),TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
}


DEFINE_EVENT
DATA_EVENT [dvDevice]
{
    ONLINE :
    {
	ReInitialize(TRUE)
    }
    OFFLINE :
    {
	ReInitialize(FALSE)
    }
    ONERROR :
    {		
	    SWITCH (DATA.NUMBER)
	    {
		CASE 14 : { // Already Used
			fnClosePlanarConnection();
		}
	    }
    }
    STRING :
    {
	STACK_VAR CHAR iResult[100];
	
	WHILE (FIND_STRING(ResponseBuffer,"CR",1))
	{
	    iResult = REMOVE_STRING (ResponseBuffer,"CR",1);
	    	fnParseDeviceResponseString(iResult);
		
	    IF (bDbug == TRUE ) {
		SEND_STRING vdvDevice, "'PLANAR DBUG : ',ResponseBuffer"
	    }
	}
    }
}
CHANNEL_EVENT [vdvDevice, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 27 : //Pwr On...
	    {
		SendDeviceString (SET_POWER_ON)

		IF(bIsInitialized == TRUE) {
		    TIMELINE_PAUSE (TL_IPCOMM_CONNECT)
		    
		    ON [vdvDevice, 255]
			ON [vdvDevice, 253]
		    
		    WAIT 70 {
			OFF [vdvDevice, 253]
			    TIMELINE_RESTART (TL_IPCOMM_CONNECT);
		    }
		}
	    }
	    CASE 28 : //Pwr Off...
	    {
		SendDeviceString (SET_POWER_OFF)

		IF (bIsInitialized == TRUE) {
		    ON [vdvDevice, 254]
		    
			TIMELINE_PAUSE (TL_IPCOMM_CONNECT);

		    WAIT 50 {
			OFF [vdvDevice, 254]
			    TIMELINE_RESTART (TL_IPCOMM_CONNECT);
				TIMELINE_SET (TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY (lTlIpConnect)] -100); //Take Timeline to Last Second..
		    }
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT]
{
    IF (bIsInitialized == FALSE) {
	fnStartPlanarConnection();
    } ELSE {
	    SendDeviceString (GET_POWER_STATE);
    }
}

