MODULE_NAME='SVSI_TRANCEIVER_IP' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])

DEFINE_CONSTANT

INTEGER SVSI_IP_PORT			= 50002;

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

//Encoder Commands....
CHAR SVSI_LIVE[]    	= 'live' //May need to add LF to end
CHAR SVSI_PLAYLIST_1[]		= '*local:1'
CHAR SVSI_PLAYLIST_2[]		= '*local:2'
CHAR SVSI_GET_STATUS[]			= 'getStatus'
CHAR SVSI_RESET[]			= 'setSettings:factoryRestore:factoryRestore'
CHAR SVSI_AUDIO_MUTE[]		= 'mute' // Disables audio Outpt
CHAR SVSI_AUDIO_UNMUTE[]		= 'unmute'
CHAR SVSI_SCALE_1080[]		= 'modeset:1080p60'
CHAR SVSI_SCALE_AUTO[]		= 'modeset:Auto'
CHAR SVSI_SET_YUV_OFF[]		= 'setSettings:yuvout:off'

DEFINE_VARIABLE

VOLATILE CHAR bHost[255];
VOLATILE CHAR ResponseBuffer[1500];
VOLATILE LONG lTlIpConnect[] = {35000}; //35-second Query Loop...
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPwr;
VOLATILE CHAR bStream[4];

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartSVSIEncDecConnection() {
		        IP_CLIENT_OPEN(dvDevice.PORT, devIP, SVSI_IP_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start SVSI Connection with : ',devIP"
	    
    WAIT 30 {
	    IF (bIsInitialized == TRUE) {
		IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
		    TIMELINE_SET (TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY (lTlIpConnect)] -100);
		}
	    }
	}
}
DEFINE_FUNCTION fnCloseSVSIIpConnection() {
	IP_CLIENT_CLOSE (dvDevice.PORT);
		SEND_STRING vdvDevice, "'Closed SVSI IP Connection...'"
}
DEFINE_FUNCTION CHAR[100] GetSVSIIpError (LONG iErrorCode)
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
DEFINE_FUNCTION fnREINitialize() {
	    bIsInitialized = FALSE;
		[vdvDevice, 251] = bIsInitialized;
}
DEFINE_FUNCTION fnIsINitialized() {
    	bIsInitialized = TRUE;
	    [vdvDevice, 251] = bIsInitialized;
}

DEFINE_START

CREATE_BUFFER dvDevice, ResponseBuffer;

WAIT 250 {
    TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTlIpConnect,LENGTH_ARRAY(lTlIpConnect),TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
}

DEFINE_EVENT
CHANNEL_EVENT [vdvDevice, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 251 : 
	    CASE 255 : {
		//Used Channel
	    }
	    DEFAULT : {
		    SEND_STRING dvDevice, "'seta:',ITOA(CHANNEL.CHANNEL),CR"
	    }
	}
    }
}
DATA_EVENT [dvDevice]
{
    ONLINE :
    {
	fnIsINitialized()
    }
    OFFLINE :
    {
	fnREINitialize();
    }
    ONERROR :
    {
	fnREINitialize();
		
	    SWITCH (DATA.NUMBER)
	    {
		CASE 14 : { // Already Used
			fnCloseSVSIIpConnection();
		}
	    }
    }
    STRING :
    {
	STACK_VAR CHAR iMsg[1500];
	fnIsINitialized();
	
	WHILE (FIND_STRING(ResponseBuffer,"$0D",1))
	{
	    iMsg = REMOVE_STRING(ResponseBuffer,"$0D",1);
	    
	    SELECT
	    {
		ACTIVE (FIND_STRING(iMsg, 'NAME:',1)): {
		    REMOVE_STRING (iMsg, ':',1)
			    SEND_COMMAND vdvDevice, "'FBSVSINAME-',iMsg"
		}
		ACTIVE (FIND_STRING(iMsg, 'AUDIOSTREAM:',1)): {  
		    REMOVE_STRING (iMsg, ':',1)
			    SEND_COMMAND vdvDevice, "'FBSVSISTREAM-',iMsg"
		}
		ACTIVE (FIND_STRING(iMsg, 'RXSTREAM:',1)): {  // This is conflicting with finding AudioStream
		    REMOVE_STRING (iMsg, ':',1)
			    SEND_COMMAND vdvDevice, "'FBSVSISTREAM-',iMsg"
		}
		ACTIVE (FIND_STRING(iMsg, 'HDMISTATUS:',1)): {
		    REMOVE_STRING (iMsg, ':',1) // connected
			SEND_COMMAND vdvDevice, "'FBHDMISTATUS-',iMsg"
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Call the Constant ID ...
{
    IF (bIsInitialized == FALSE) {
	    fnStartSVSIEncDecConnection();
    } ELSE {
	    SEND_STRING dvDevice, "SVSI_GET_STATUS,CR"
    }
}
