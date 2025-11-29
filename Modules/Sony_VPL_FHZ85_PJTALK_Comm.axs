MODULE_NAME='Sony_VPLFHZ85_PJTALK_Comm' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])

DEFINE_CONSTANT

INTEGER PJTALK_IP_PORT			= 53484;

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
CHAR MSG_ETX = $9A; //End of Sony Proejctor Response...

//PJ Talk Commands Older Sony
CHAR PROJECTOR_IP_PWR_QUERY[] = {$02,$0A,$53,$4F,$4E,$59,$01,$01,$02,$02,$00,$00};
CHAR PROJECTOR_IP_PWR_ON[] =	{$02,$0A,$53,$4F,$4E,$59,$00,$17,$2E,$02,$00,$00};
CHAR PROJECTOR_IP_PWR_OFF[] =	{$02,$0A,$53,$4F,$4E,$59,$00,$17,$2F,$02,$00,$00};
CHAR PROJECTOR_IP_BLANK_ON[] =	{$02,$0A,$53,$4F,$4E,$59,$00,$00,$30,$02,$00,$01}
CHAR PROJECTOR_IP_BLANK_OFF[] =	{$02,$0A,$53,$4F,$4E,$59,$00,$00,$30,$02,$00,$00};
CHAR PROJECTOR_IP_BLANK_QUERY[] =	{$02,$0A,$53,$4F,$4E,$59,$01,$00,$30,$02,$00,$00}
CHAR PROJECTOR_IP_LAMP_QUERY[] =	{$02,$0A,$53,$4F,$4E,$59,$01,$01,$13,$02,$00,$00}
CHAR PROJ_HEADER[]				= {02,$0A,$53,$4F,$4E,$59} // Older Sony's

//COUNT_PROJ_REP					= 23;
//COUNT_PROJ_HEADER				= 10;

DEFINE_VARIABLE

VOLATILE CHAR bHost[255];
VOLATILE CHAR ResponseBuffer[500];
VOLATILE LONG lTlIpConnect[] = {25000}; //25-second Query Loop...
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPwr;
VOLATILE CHAR bMute;
VOLATILE CHAR bLamp[4];

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartPJTalkConnection() {
		        IP_CLIENT_OPEN(dvDevice.PORT, devIP, PJTALK_IP_PORT, IP_TCP);
			    bIsInitialized = TRUE;
	    SEND_COMMAND vdvDevice, "'Attempt to Start PJ Talk Connection...'"
    
    WAIT 20 {
	    SEND_STRING dvDevice, "PROJECTOR_IP_PWR_QUERY,CR"
    }
    WAIT 30 {
		SEND_STRING dvDevice, "PROJECTOR_IP_BLANK_QUERY,CR"
	}
}
DEFINE_FUNCTION fnClosePJTalkConnection() {
	IP_CLIENT_CLOSE (dvDevice.PORT);
		SEND_STRING vdvDevice, "'Closed PJ Talk Connection...'"
}
DEFINE_FUNCTION CHAR[100] GetPJTalkError (LONG iErrorCode)
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
	SEND_COMMAND vdvDevice, "'PJTALK-OFFLINE'"
	    bIsInitialized = FALSE;
		[vdvDevice, 251] = bIsInitialized;
}
DEFINE_FUNCTION fnParsePJTalkResponse(CHAR iMsg[])
{
    STACK_VAR CHAR cProjectorStat[100];
    
    LOCAL_VAR CHAR cLamp[5];
    LOCAL_VAR INTEGER cLampCount;
    
    bIsInitialized = TRUE;
	[vdvDevice, 251] = bIsInitialized;
	    
        
    IF (FIND_STRING(iMsg, "PROJ_HEADER",1)) {
	    SEND_COMMAND vdvDevice, "'PJTALK-ONLINE'"
	    
	    REMOVE_STRING (iMsg, "PROJ_HEADER",1)
	    cProjectorStat = iMsg;
		
	    
	SELECT
	{
	    ACTIVE (FIND_STRING(cProjectorStat, "$01,$01,$02,$02,$00,$03",1)) : {

		bPwr = TRUE;
		    [vdvDevice, 255] = bPwr;
			SEND_COMMAND vdvDevice, "'PJTALK-PWRON'"
	    }
	    ACTIVE (FIND_STRING(cProjectorStat, "$01,$01,$02,$02,$00,$00",1)) : {
		bPwr = FALSE;
		    [vdvDevice, 255] = bPwr;
			SEND_COMMAND vdvDevice, "'PJTALK-PWROFF'"
	    }
	    ACTIVE (FIND_STRING(cProjectorStat, "$01,$00,$30,$02,$00,$00",1)) : {
		bMute = FALSE;
		    [vdvDevice, 211] = bMute;
			SEND_COMMAND vdvDevice, "'PJTALK-MUTEOFF'"
	    }
	    ACTIVE (FIND_STRING(cProjectorStat, "$01,$00,$30,$02,$00,$01",1)) : {
		bMute = TRUE;
		    [vdvDevice, 211] = bMute;
			SEND_COMMAND vdvDevice, "'PJTALK-MUTEON'"
	    }
	     ACTIVE (FIND_STRING(cProjectorStat, "$01,$01,$13,$02",1)) : {

		REMOVE_STRING (iMsg, "$01,$01,$13,$02",1)
		cLamp = (LEFT_STRING (iMsg, 2)); 
		    
		    //Convert hex format....
		  bLamp = FORMAT('%02X',cLamp[2])
		    bLamp = "FORMAT('%02X',cLamp[1]),bLamp" //Convert from Here...
			
		    cLampCount = HEXTOI(bLamp);
		    
		    SEND_COMMAND vdvDEVICE, "'LAMPTIME-',ITOA(cLampCount)"
	    }
	}
    }
}

DEFINE_START

CREATE_BUFFER dvDevice, ResponseBuffer;
 TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTlIpConnect,LENGTH_ARRAY(lTlIpConnect),TIMELINE_ABSOLUTE, TIMELINE_REPEAT);



DEFINE_EVENT
DATA_EVENT [dvDevice]
{
    ONLINE :
    {
	//bIsInitialized = TRUE;
	SEND_STRING vdvDevice, "'Device/Socket - Online Flag'"
    }
    OFFLINE :
    {
	fnREINitialize();
    }
    ONERROR :
    {
	fnREINitialize();
	    SEND_COMMAND vdvDevice, "'OnError : ',GetPJTalkError(DATA.NUMBER)"
		
	    SWITCH (DATA.NUMBER)
	    {
		CASE 14 : { // Already Used
			fnClosePJTalkConnection();
		}
	    }
    }
    STRING :
    {	
	fnParsePJTalkResponse(ResponseBuffer);
	    ResponseBuffer = '';
    }
}
CHANNEL_EVENT [vdvDevice, 0]
{
    ON :
    {	
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 27 : {
		SEND_STRING dvDevice, "PROJECTOR_IP_PWR_ON"
		
		    IF (bIsInitialized == TRUE) {
			    [vdvDevice, 253] = TRUE;
			    
			    IF (TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
				    TIMELINE_PAUSE(TL_IPCOMM_CONNECT);
			    }
			    WAIT 60 {
				[vdvDevice, 253] = FALSE;
				    TIMELINE_RESTART (TL_IPCOMM_CONNECT);
					TIMELINE_SET (TL_IPCOMM_CONNECT, 0);
			    }
		    }
	    }
	    CASE 28 : {
		SEND_STRING dvDevice, "PROJECTOR_IP_PWR_OFF"
	    }	
	    CASE 211 : {
		SEND_STRING dvDevice, "PROJECTOR_IP_BLANK_ON"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 211 : {
		SEND_STRING dvDevice, "PROJECTOR_IP_BLANK_OFF"
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Call the Constant ID ...
{
    IF (bIsInitialized == FALSE) {
	fnStartPJTalkConnection();
    } ELSE {
    	SEND_STRING dvDevice, "PROJECTOR_IP_PWR_QUERY,CR"
	WAIT 20 SEND_STRING dvDevice, "PROJECTOR_IP_BLANK_QUERY,CR"
	    WAIT 40 SEND_STRING dvDevice, "PROJECTOR_IP_LAMP_QUERY,CR"
    }
}
