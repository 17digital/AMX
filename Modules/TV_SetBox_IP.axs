MODULE_NAME='TV_SetBox_IP' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])


DEFINE_CONSTANT

INTEGER TV_IP_PORT			= 5001;

MAX_SPORTS_CH				= 18;

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

CHAR JSON_UNESCAPED_BACKSPACE       = $08;
CHAR JSON_UNESCAPED_TAB             = $09;
CHAR JSON_UNESCAPED_NEWLINE         = $0a;
CHAR JSON_UNESCAPED_FORM_FEED       = $0c;
CHAR JSON_UNESCAPED_CARRIAGE_RETURN = $0d;
CHAR JSON_UNESCAPED_DOUBLE_QUOTE    = '"';
CHAR JSON_UNESCAPED_BACKSLASH       = '\';

CHAR JSON_ESCAPED_BACKSPACE[]       = '\b'
CHAR JSON_ESCAPED_TAB[]             = '\t';
CHAR JSON_ESCAPED_NEWLINE[]         = '\n';
CHAR JSON_ESCAPED_FORM_FEED[]       = '\f';
CHAR JSON_ESCAPED_CARRIAGE_RETURN[] = '\r';
CHAR JSON_ESCAPED_DOUBLE_QUOTE[]    = '\"';
CHAR JSON_ESCAPED_BACKSLASH[]       = '\\';
CHAR JSON_ESCAPED_UNICODE[]         = '\u';

JSON_MAX_VALUE_NAME_LENGTH  = 200;
JSON_MAX_VALUE_DATA_LENGTH = 5000;
//JSON_MAX_VALUE_DATA_LENGTH = 65535;
JSON_MAX_OBJECT_VALUES = 100;
JSON_MAX_ARRAY_VALUES = 100;

CHAR JSON_TYPE_ARRAY[]   = 'array';
CHAR JSON_TYPE_BOOLEAN[] = 'boolean';
CHAR JSON_TYPE_NULL[]    = 'null';
CHAR JSON_TYPE_NUMBER[]  = 'number';
CHAR JSON_TYPE_OBJECT[]  = 'object';
CHAR JSON_TYPE_STRING[]  = 'string';

CHAR JSON_PROPERTY_NOT_FOUND[] = 'property not found';
CHAR JSON_INVALID[] = 'invalid';


DEFINE_VARIABLE

VOLATILE CHAR bHost[255];

VOLATILE CHAR httpResponseBuffer[9800];
VOLATILE LONG lTlIpConnect[] = {30000}; //30-second Query Loop...

VOLATILE CHAR bIsInitialized;
VOLATILE INTEGER cChannelFB;
VOLATILE CHAR cSetChannel[3];

VOLATILE CHAR sKeyChanUP[] = '{"key":"ChannelUp"}'
VOLATILE CHAR sKeyChanDN[] = '{"key":"ChannelDown"}'
VOLATILE CHAR sKeyPwrON[] = '{"sleep":false}'


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
	    IF (!TIMELINE_ACTIVE(TL_IPCOMM_CONNECT)) {
		    TIMELINE_SET (TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY (lTlIpConnect)] -100);	
	    }
	}
    }
}
DEFINE_FUNCTION fnCloseTVIpConnection(DEV cDev) {
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
DEFINE_FUNCTION sendPostHttp(CHAR iMode[20], CHAR iCmd[500], CHAR iBody[])
{
    STACK_VAR CHAR iPacket[500];
        
    //Minimum HTTP 1.1 Requirment
    iPacket = "iMode, ' ',iCmd, ' HTTP/1.1',$0D,$0A,
		    'Host: ',devIP,':',ITOA(TV_IP_PORT),$0D,$0A,
		    'Content-Type: application/json',$0D,$0A,
		    'Connection: keep-alive',$0D,$0A,
		    'Content-Length: ',ITOA(LENGTH_STRING(iBody)),$0D,$0A,$0D,$0A,
		    iBody"; //

    
    IF (bIsInitialized == TRUE) {
	SEND_STRING dvDevice, iPacket; //If online/connected - send the actual packet...
	    SEND_STRING vdvDevice, "iPacket"
    } ELSE {
	//sGitIpQueue = "sGitIpQueue , iPacket"
	    IP_CLIENT_OPEN (dvDevice.PORT, devIP, TV_IP_PORT, IP_TCP);
    }
}
DEFINE_FUNCTION sendGetHttp(CHAR iMode[20], CHAR iCmd[500])
{
    STACK_VAR CHAR iPacket[500];
        
    //Minimum HTTP 1.1 Requirment
    iPacket = "iMode, ' ',iCmd, ' HTTP/1.1',$0D,$0A,
		    'Host: ',devIP,':',ITOA(TV_IP_PORT),$0D,$0A,
		    CR,LF"; //Http terminates with the empty lin
    
    IF (bIsInitialized == TRUE) {
	SEND_STRING dvDevice, iPacket; //If online/connected - send the actual packet...
	    SEND_STRING vdvDevice, "iPacket"
    } ELSE {
	//sGitIpQueue = "sGitIpQueue , iPacket"
	   IP_CLIENT_OPEN (dvDevice.PORT, devIP, TV_IP_PORT, IP_TCP);
    }
}
DEFINE_FUNCTION fnParseJsonObject(CHAR jsonObjStr[]) {
		LOCAL_VAR CHAR tempJson[JSON_MAX_VALUE_DATA_LENGTH];
	
		tempJson = jsonObjStr;
		
		IF( FIND_STRING(tempJson, '{',1) && FIND_STRING(tempJson, '}',1)) {
		
		    STACK_VAR INTEGER iStx, iEtx;
		    STACK_VAR CHAR iCurrLabel[15];
		    STACK_VAR CHAR iCurrChannel[3];
		    
		    ON [vdvDevice, 255]; 
		   // {"success":true,"messages":["TBS","TBS"],"result":"67"}
		    
		    IF (cChannelFB == TRUE) { // Added this Check since other feedback starts with 'messages' header
			//iStx = FIND_STRING(tempJson, '"messages":["',1) +13;
			iStx = FIND_STRING(tempJson, '","',1) +3;
			iEtx = FIND_STRING(tempJson, '"],"',1);
			    iCurrLabel = MID_STRING(tempJson, iStx, (iEtx - iStx));
				    SEND_COMMAND vdvDevice, "'ACTIVETVLABEL-',iCurrLabel"
				
			iStx = FIND_STRING(tempJson, '"result":"',1) +10;
			iEtx = FIND_STRING(tempJson, '"}',1)
			    iCurrChannel = MID_STRING(tempJson, iStx, (iEtx - iStx));
				SEND_COMMAND vdvDevice, "'ACTIVETVCHANNEL-',iCurrChannel"
				    cChannelFB = FALSE;
		    }
		}
}

DEFINE_START

CREATE_BUFFER dvDevice, httpResponseBuffer;
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
	bIsInitialized = FALSE;
    }
    ONERROR :
    {
	SEND_STRING 0, "'<-- Could Not Reach Set top Box !!-->',GetTVIpError(DATA.NUMBER)";
	    bIsInitialized = FALSE;
		[vdvDevice, 255] = bIsInitialized;
    }
    STRING :
    {
	STACK_VAR response[9500];
	
	WHILE(FIND_STRING(httpResponseBuffer,'HTTP/1.1 200 OK',1)) {
		REMOVE_STRING(httpResponseBuffer, 'HTTP/1.1 200 OK',1)
		
		IF(FIND_STRING(httpResponseBuffer, 'Content-Length:',1)) {
		    REMOVE_STRING(httpResponseBuffer, 'Content-Length:',1)
		    
		    REMOVE_STRING(httpResponseBuffer, "$0D,$0A,$0D,$0A",1) //Remove line space before Json string
		    response = httpResponseBuffer;
			SEND_STRING 0, response; //See what I'm sending to parse...
			
			fnParseJsonObject(response);
			CLEAR_BUFFER httpResponseBuffer;
		}
	}
    }
}
DATA_EVENT [vdvDevice]
{
    COMMAND :
    {
	CHAR cReceiveMessage[100];
	    cReceiveMessage = DATA.TEXT;
	    
	    IF (FIND_STRING(cReceiveMessage, 'SETCHANNEL-',1)) {
		    REMOVE_STRING(cReceiveMessage,'-',1);
			cSetChannel = cReceiveMessage;
			cChannelFB = TRUE;
			    sendPostHttp( 'POST', '/v1/channel', "'{"channel":"',cSetChannel,'"}'");
				cSetChannel = ' ';
		    
		    // Get Feedback faster by skipping timeline ahead
		    WAIT 20 {
			    sendGetHttp('GET', '/v1/channel'); //Grabs Current Channel
		    }
	    }
    }
}
CHANNEL_EVENT [vdvDevice, 0]
{
    ON :
    {
	cChannelFB = FALSE;
	
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 22 : {
		sendPostHttp( 'POST', '/v1/key', sKeyChanUP);
		    
	    }
	    CASE 23 : {
		sendPostHttp( 'POST', '/v1/key', sKeyChanDN); 
	    }
	    CASE 27 : {
		sendPostHttp( 'POST', '/v1/sleep', sKeyPwrON); 
	    }
	    CASE 100 : {
		sendGetHttp('GET', '/v1/channels'); //Grabs full Json Array --> "channel": [{"tmsid": "1", "channel": "2", "callsign": "WSB-DT", "label": "ABC-WSB-DT"}
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Call the Constant ID ...
{
    IF (bIsInitialized == FALSE) {
	fnStartTVIpConnection();
    } ELSE {
	cChannelFB = TRUE;
	    sendGetHttp('GET', '/v1/channel'); //Grabs Current Channel
    }
}
    