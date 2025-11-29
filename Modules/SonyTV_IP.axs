MODULE_NAME='SonyTV_IP' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])

DEFINE_CONSTANT

INTEGER TV_IP_PORT			= 20060;

// Time Lines
LONG TL_IPCOMM_CONNECT	= 5001; 

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

//Sony Bravia Ascii..
CHAR TV_SONY_POWER_QUERY[]    	= '*SEPOWR################' //May need to add LF to end
CHAR TV_SONY_POWER_ON[]		= '*SCPOWR0000000000000001'
CHAR TV_SONY_POWER_OFF[]		= '*SCPOWR0000000000000000'
CHAR TV_SONY_MUTE_ON[]			= '*SCPMUT0000000000000001'
CHAR TV_SONY_MUTE_OFF[]			= '*SCPMUT0000000000000000'
CHAR TV_SONY_MUTE_QUERY[]		= '*SEPMUT################'
CHAR TV_SONY_INPUT_QUERY[]		= '*SEINPT################'
CHAR TV_SONY_INPUT_HDMI_1[]		= '*SCINPT0000000100000001'
CHAR TV_SONY_INPUT_HDMI_2[]		= '*SCINPT0000000100000002'
CHAR TV_SONY_INPUT_HDMI_3[]		= '*SCINPT0000000100000003'

DEFINE_VARIABLE

VOLATILE CHAR bHost[255];
VOLATILE CHAR ResponseBuffer[500];
VOLATILE LONG lTlIpConnect[] = {15000}; //10-second Query Loop...
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPwr;
VOLATILE INTEGER bInstant;
VOLATILE CHAR bDbug;

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartTVIpConnection() {
		        IP_CLIENT_OPEN(dvDevice.PORT, devIP, TV_IP_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start TV IP Connection...'"
	
	WAIT 30 {
	    IF (bIsInitialized == TRUE) {
		IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
		    TIMELINE_SET (TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY (lTlIpConnect)] -100);
		}
	    }
	}
}
DEFINE_FUNCTION fnCloseTVIpConnection() {
	IP_CLIENT_CLOSE (dvDevice.PORT);
		SEND_STRING vdvDevice, "'Closed TV IP Connection...'"
}
DEFINE_FUNCTION CHAR[100] GetTVIpError (LONG iErrorCode)
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
	SEND_COMMAND vdvDevice, "'TVRESPONSE-OFFLINE'"
	    bIsInitialized = FALSE;
		[vdvDevice, 251] = bIsInitialized;
}
DEFINE_FUNCTION fnIsINitialized() {
    	bIsInitialized = TRUE;
	    [vdvDevice, 251] = bIsInitialized;
		SEND_COMMAND vdvDevice, "'TVRESPONSE-ONLINE'"
}
DEFINE_FUNCTION fnParseTVIPResponse(CHAR iMsg[])
{
    STACK_VAR INTEGER cPwrCmd;
    fnIsINitialized();
        
    IF (FIND_STRING(iMsg, '*SAPOWR000000000000000',1)) {
	REMOVE_STRING (iMsg, '*SAPOWR000000000000000',1)
	    cPwrCmd = ATOI(iMsg);
	    
	SWITCH (cPwrCmd)
	{
	    CASE 1 : {
		bPwr = TRUE;
		    [vdvDevice, 255] = bPwr;
			SEND_COMMAND vdvDevice, "'TVRESPONSE-PWRON'"
	    }
	    CASE 0 : {
		IF (bInstant == TRUE) {
		    bPwr = TRUE;
		    [vdvDevice, 255] = bPwr;
			SEND_COMMAND vdvDevice, "'TVRESPONSE-PWRON'"
		
		} ELSE {
		    bPwr = FALSE;
		    [vdvDevice, 255] = bPwr;
			SEND_COMMAND vdvDevice, "'TVRESPONSE-PWROFF'"
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
	bIsInitialized = TRUE;
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
			fnCloseTVIpConnection();
		}
	    }
    }
    STRING :
    {
	STACK_VAR CHAR iResult[100];
	STACK_VAR CHAR iDbug[100];
	
	WHILE (FIND_STRING(ResponseBuffer, "LF",1))
	{
	    iResult = REMOVE_STRING (ResponseBuffer, "LF",1);
		iDbug = iResult;
		fnParseTVIPResponse(iResult);
		    IF (bDbug == TRUE) {
			SEND_COMMAND vdvDevice, "'Poll Sony IP : ',iDbug"
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
	    CASE 1 : {
		bDbug = TRUE;
	    }
	    CASE 27 : {
		SEND_STRING dvDevice, "TV_SONY_POWER_ON,LF"
		    bInstant = TRUE;
		
		IF (bIsInitialized == TRUE) {
		    IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
			TIMELINE_PAUSE (TL_IPCOMM_CONNECT)
		    }
			WAIT 70 {
			    TIMELINE_RESTART (TL_IPCOMM_CONNECT);
				bInstant = FALSE;
			}
		}
	    }
	    CASE 28 : {
		SEND_STRING dvDevice, "TV_SONY_POWER_OFF,LF"
		
		IF (bIsInitialized == TRUE) {
		    IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
			TIMELINE_PAUSE (TL_IPCOMM_CONNECT)
		    }
			WAIT 70 {
			    TIMELINE_RESTART (TL_IPCOMM_CONNECT);
			}
		}
	    }	
	    CASE 31 : {
		SEND_STRING dvDevice, "TV_SONY_INPUT_HDMI_1,LF"
	    }
	    CASE 32 : {
		SEND_STRING dvDevice, "TV_SONY_INPUT_HDMI_2,LF"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 1 : {
		bDbug = FALSE;
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Call the Constant ID ...
{
    IF (bIsInitialized == FALSE) {
	    fnStartTVIpConnection();
    } ELSE {
    	SEND_STRING dvDevice, "TV_SONY_POWER_QUERY,LF"
    }
}
