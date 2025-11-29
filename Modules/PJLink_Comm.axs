MODULE_NAME='PJLink_Comm' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])

DEFINE_CONSTANT

INTEGER PJLINK_IP_PORT			= 4352;

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

//PJ Link Ascii..
CHAR PJ_POWER_QUERY[]    			= {'%1POWR ?'}
CHAR PJ_POWER_ON[]		= {'%1POWR 1'}
CHAR PJ_POWER_OFF[]		= {'%1POWR 0'}
CHAR PJ_MUTE_ON[]			= {'%1AVMT 11'} // Video Only
CHAR PJ_MUTE_OFF[]			= {'%1AVMT 10'} // Video Only
CHAR PJ_MUTE_QUERY[]		= {'%1AVMT ?'}
CHAR PJ_INPUT_QUERY[]		= {'%1INPT ?'}
CHAR PJ_INPUT_HDMI_1[]		= {'%1INPT 31'}
CHAR PJ_INPUT_HDMI_2[]		= {'%1INPT 32'} // Or Display Port
CHAR PJ_INPUT_HDBT[]			= {'%1INPT 34'} 
CHAR PJ_LAMP_QUERY[]		= {'%1LAMP ?'}
CHAR PJ_NAME_QUERY[]		= {'%1NAME ?'}
CHAR PJ_MODEL_QUERY[]		= {'%1INF2 ?'}
CHAR PJ_INFO_QUERY[]			= {'%1INF0 ?'} // Other Info

DEFINE_VARIABLE

VOLATILE CHAR bHost[255];
VOLATILE CHAR ResponseBuffer[500];
VOLATILE LONG lTlIpConnect[] = {25000}; //25-second Query Loop...
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPwr;
VOLATILE CHAR bMute;

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartPJLinkConnection() {
		        IP_CLIENT_OPEN(dvDevice.PORT, devIP, PJLINK_IP_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start PJ Link Connection...'"
    
    WAIT 30 {
	    IF (bIsInitialized == TRUE) {
		IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
		    TIMELINE_SET (TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY (lTlIpConnect)] -100);
		}
	    }
	}
}
DEFINE_FUNCTION fnClosePJLInkConnection() {
	IP_CLIENT_CLOSE (dvDevice.PORT);
		SEND_STRING vdvDevice, "'Closed PJ Link Connection...'"
}
DEFINE_FUNCTION CHAR[100] GetPJLinkError (LONG iErrorCode)
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
	SEND_COMMAND vdvDevice, "'PJLINK-OFFLINE'"
	    bIsInitialized = FALSE;
		[vdvDevice, 251] = bIsInitialized;
}
DEFINE_FUNCTION fnParsePJLinkResponse(CHAR iMsg[])
{
    STACK_VAR INTEGER cPwrCmd;
    STACK_VAR INTEGER cMuteCmd;
    STACK_VAR CHAR cLampCmd[5];
    
    bIsInitialized = TRUE;
	[vdvDevice, 251] = bIsInitialized;
	    
        
    IF (FIND_STRING(iMsg, '%1POWR=',1)) {
	
	REMOVE_STRING (iMsg, '=',1)
	    cPwrCmd = ATOI(iMsg);
		SEND_COMMAND vdvDevice, "'PJLINK-ONLINE'"
	    
	SWITCH (cPwrCmd)
	{
	    CASE 1 : 
	    {
		bPwr = TRUE;
		    [vdvDevice, 255] = bPwr;
			SEND_COMMAND vdvDevice, "'PJLINK-PWRON'"
	    }
	    CASE 0 :
	    {
		bPwr = FALSE;
		    [vdvDevice, 255] = bPwr;
			SEND_COMMAND vdvDevice, "'PJLINK-PWROFF'"
	    }
	}
    }
    IF (FIND_STRING(iMsg, '%1AVMT=',1)) { // Video Mute Response
	
	REMOVE_STRING (iMsg, '=',1)
	    cMuteCmd = ATOI(iMsg);
	    
	SWITCH (cMuteCmd)
	{
	    CASE 11 : 
	    CASE 31 :
	    {
		bMute = TRUE;
		    [vdvDevice, 211] = bMute;
			SEND_COMMAND vdvDevice, "'PJLINK-MUTEON'"
	    }
	    CASE 10 :
	    CASE 30 :
	    {
		bMute = FALSE;
		    [vdvDevice, 211] = bMute;
			SEND_COMMAND vdvDevice, "'PJLINK-MUTEOFF'"
	    }
	}
    }
    IF (FIND_STRING(iMsg, '%1LAMP=',1)) { // Video Mute Response
	
	REMOVE_STRING (iMsg, '=',1)
	    cLampCmd = LEFT_STRING(iMsg,LENGTH_STRING(iMsg) -7); 
		    SEND_COMMAND vdvDevice, "'LAMPTIME-',cLampCmd";
    }
    IF (FIND_STRING(iMsg, 'PJLINK 0',1)) { // Connected w/ No Authentication
    
	    SEND_COMMAND vdvDevice, "'Connected w/No Auth'"
    }
}

DEFINE_START

CREATE_BUFFER dvDevice, ResponseBuffer;
WAIT 50 {
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
	    SEND_COMMAND vdvDevice, "'OnError : ',GetPJLinkError(DATA.NUMBER)"
		
	    SWITCH (DATA.NUMBER)
	    {
		CASE 14 : { // Already Used
			fnClosePJLInkConnection();
		}
	    }
    }
    STRING :
    {
	STACK_VAR CHAR iResult[100];
	
	WHILE (FIND_STRING(ResponseBuffer, "CR",1))
	{
	    iResult = REMOVE_STRING (ResponseBuffer, "CR",1);
		//SEND_COMMAND vdvDevice, "'Poll Sony IP : ',iResult"
		    fnParsePJLinkResponse(iResult);
	}
    }
}
CHANNEL_EVENT [vdvDevice, 0]
{
    ON :
    {	
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 27 : {
		SEND_STRING dvDevice, "PJ_POWER_ON,CR"
		
		    IF (bIsInitialized == TRUE) {
			    [vdvDevice, 253] = TRUE;
			    
			    IF (TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
				    TIMELINE_PAUSE(TL_IPCOMM_CONNECT);
			    }
			    WAIT 60 {
				[vdvDevice, 253] = FALSE;
				    TIMELINE_RESTART (TL_IPCOMM_CONNECT);
					TIMELINE_SET (TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY (lTlIpConnect)] -100);
			    }
		    }
	    }
	    CASE 28 : {
		SEND_STRING dvDevice, "PJ_POWER_OFF,CR"
	    }	
	    CASE 31 : {
		SEND_STRING dvDevice, "PJ_INPUT_HDMI_1,CR"
	    }
	    CASE 32 : {
		SEND_STRING dvDevice, "PJ_INPUT_HDMI_2,CR"
	    }
	    CASE 211 : {
		SEND_STRING dvDevice, "PJ_MUTE_ON,CR"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 211 : {
		SEND_STRING dvDevice, "PJ_MUTE_OFF,CR"
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Call the Constant ID ...
{
    IF (bIsInitialized == FALSE) {
	fnStartPJLinkConnection();
    } ELSE {
    	SEND_STRING dvDevice, "PJ_POWER_QUERY,CR"
	WAIT 20 SEND_STRING dvDevice, "PJ_MUTE_QUERY,CR"
	    WAIT 40 SEND_STRING dvDevice, "PJ_LAMP_QUERY,CR"
    }
}
