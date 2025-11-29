MODULE_NAME='Sony_FHZ_6500_SVSI_Serial' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])

DEFINE_CONSTANT

INTEGER COMM_PORT			= 50004; //SVSI POrt to pass Serial 

// Time Lines
LONG TL_IPCOMM_CONNECT	= 5001; 
DATA_INITIALIZED = 251;

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
CHAR ETX = $9A; // Sony Ends with this...
CHAR EOT = $04;
CHAR ACK = $06;
CHAR BS = $08;
CHAR NAK = $21;

//Sony RS232 HEX..
CHAR SONY_POWER_QUERY[]    	= {$A9,$01,$02,$01,$00,$00,$03,$9A};
CHAR SONY_POWER_ON[]			= {$A9,$17,$2E,$00,$00,$00,$3F,$9A};
CHAR SONY_POWER_OFF[]			= {$A9,$17,$2F,$00,$00,$00,$3F,$9A};
CHAR SONY_MUTE_ON[]			= {$A9,$00,$30,$00,$00,$01,$31,$9A};
CHAR SONY_MUTE_OFF[]			= {$A9,$00,$30,$00,$00,$00,$30,$9A};
CHAR SONY_MUTE_QUERY[]		= {$A9,$00,$30,$01,$00,$00,$31,$9A};
CHAR SONY_INPUT_A[]		= {$A9,$00,$01,$00,$00,$03,$03,$9A};
CHAR SONY_INPUT_B[]		= {$A9,$00,$01,$00,$00,$05,$05,$9A};
CHAR SONY_INPUT_C[]				= {$A9,$00,$01,$00,$00,$04,$05,$9A};
CHAR SONY_LAMP_QUERY[]		= {$A9,$01,$13,$01,$00,$00,$13,$9A}

DEFINE_VARIABLE

VOLATILE CHAR bHost[255];
VOLATILE CHAR ResponseBuffer[500];
VOLATILE LONG lTlIpConnect[] = {15000}; //10-second Query Loop...
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPwr;
VOLATILE INTEGER bInstant;
VOLATILE CHAR bDbug;
VOLATILE INTEGER bMuted;
VOLATILE CHAR bLamp[4];

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartIpConnection() {
    IP_CLIENT_OPEN(dvDevice.PORT, devIP, COMM_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start Sony Serial Connection...'"
	
	WAIT 30 {
		IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
		    TIMELINE_SET (TL_IPCOMM_CONNECT, 0);
		}
	}
}
DEFINE_FUNCTION fnCloseIpConnection() {
	IP_CLIENT_CLOSE (dvDevice.PORT);
		SEND_STRING vdvDevice, "'Closed Projector IP Connection...'"
}
DEFINE_FUNCTION CHAR[100] GetIpError (LONG iErrorCode)
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
	SEND_COMMAND vdvDevice, "'PJ-OFFLINE'"
	    bIsInitialized = FALSE;
		[vdvDevice, 251] = bIsInitialized;
}
DEFINE_FUNCTION fnIsINitialized() {
    	bIsInitialized = TRUE;
	    [vdvDevice, 251] = bIsInitialized;
		SEND_COMMAND vdvDevice, "'PJ-ONLINE'"
}
DEFINE_FUNCTION fnParseIPResponse(CHAR iMsg[])
{
    LOCAL_VAR CHAR cLamp[5];
    LOCAL_VAR INTEGER cLampCount;
    
    bIsInitialized = TRUE;
	[vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;
	    SEND_COMMAND vdvDEVICE, "'PJ-ONLINE'"
    
    SELECT
    {
	ACTIVE (FIND_STRING(iMsg, "$A9,$01,$02,$02,$00,$03,$03",1)) : //Status Query On --$A9,$01,$02,$02,$00,$03,$03
	{
	     bPwr = TRUE;
		[vdvDEVICE, 255] = bPwr;
		    SEND_COMMAND vdvDEVICE, "'PJ-PWRON'"
	}
	ACTIVE (FIND_STRING(iMsg, "$A9,$01,$02,$02,$00,$00,$03",1)) : //Status Query Off -- $A9,$01,$02,$02,$00,$00,$03
	{
	    bPwr = FALSE;
		[vdvDEVICE, 255] = bPwr;
		SEND_COMMAND vdvDEVICE, "'PJ-PWROFF'"
	}
	ACTIVE (FIND_STRING(iMsg, "$A9,$00,$30,$02,$00,$01,$33,$9A",1)) : //Query Mute FB On --A9 00 30 02 00 01 33 9A
	{
	    bMuted = TRUE;
		[vdvDEVICE, 211] = bMuted;
		    SEND_COMMAND vdvDEVICE, "'PJ-MUTEON'"
	}
	ACTIVE (FIND_STRING(iMsg, "$A9,$00,$30,$02,$00,$00,$32,$9A",1)) : //Immediate FB Off -- A9 00 30 02 00 00 [32] 9A
	{
	    bMuted = FALSE;
		[vdvDEVICE, 211] = bMuted;
		SEND_COMMAND vdvDEVICE, "'PJ-MUTEOFF'"
	}
	ACTIVE (FIND_STRING (iMsg, "$A9,$01,$13,$02",1)) : //Lamp Hr Read....
	{
	    REMOVE_STRING (iMsg, "$A9,$01,$13,$02",1)
		cLamp = (LEFT_STRING (iMsg, 2)); 
		    
		    //Convert hex format....
		  bLamp = FORMAT('%02X',cLamp[2])
		    bLamp = "FORMAT('%02X',cLamp[1]),bLamp" //Convert from Here...
			
		    cLampCount = HEXTOI(bLamp);
		    
		    SEND_COMMAND vdvDEVICE, "'LAMPTIME-',ITOA(cLampCount)"
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
			fnCloseIpConnection();
		}
	    }
    }
    STRING :
    {
	STACK_VAR CHAR iDbug[100];
	    STACK_VAR CHAR iResult[50];
	
	WHILE (FIND_STRING(ResponseBuffer, "ETX",1))
	{
	    iResult = REMOVE_STRING (ResponseBuffer, "ETX",1);
	    
		fnParseIPResponse(iResult);
	
	    IF (bDbug == TRUE) {
		SEND_COMMAND vdvDevice, "'Poll Sony Projector : ',iDbug"
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
		SEND_STRING dvDevice, "SONY_POWER_ON"
		
		IF (bIsInitialized == TRUE) {
		
		ON [vdvDEVICE, 255];
		    ON [vdvDEVICE, 253];
		    
		    IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
			TIMELINE_PAUSE (TL_IPCOMM_CONNECT)
		    }

			WAIT 70 {
			    OFF [vdvDEVICE, 253]
			    TIMELINE_RESTART (TL_IPCOMM_CONNECT);
			}
		}
	    }
	    CASE 28 : {
		    SEND_STRING dvDevice, "SONY_POWER_OFF"
		    		    
		    IF (bIsInitialized == TRUE) {
			ON [vdvDEVICE, 254];
		    
			IF(TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
			    TIMELINE_PAUSE (TL_IPCOMM_CONNECT)
			}
			    WAIT 70 {
				OFF [vdvDEVICE, 254]
				TIMELINE_RESTART (TL_IPCOMM_CONNECT);
			    }
		    }
	    }	
	    CASE 31 : {
		SEND_STRING dvDevice, "SONY_INPUT_A"
	    }
	    CASE 32 : {
		SEND_STRING dvDevice, "SONY_INPUT_B"
	    }
	    CASE 33 : {
		SEND_STRING dvDevice, "SONY_INPUT_C"
	    }
	    CASE 211 : {
		    SEND_STRING dvDevice, "SONY_MUTE_ON"
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
	    CASE 211 : {
		    SEND_STRING dvDevice, "SONY_MUTE_OFF"
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Call the Constant ID ...
{
    IF (bIsInitialized == FALSE) {
	    fnStartIpConnection();
    } ELSE {
    	SEND_STRING dvDevice, "SONY_POWER_QUERY"
	    WAIT 20 {
		SEND_STRING dvDevice, "SONY_LAMP_QUERY"
	    }
	    WAIT 40 {	
		IF (bPwr == TRUE) {
		    SEND_STRING dvDevice, "SONY_MUTE_QUERY"
		}
	    }
    }
}
