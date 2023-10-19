PROGRAM_NAME='readMultiJson'


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvRead
dvRead =				0:10:0
#END_IF

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR GIT_IP_HOST[]				= 'config.amx.gatech.edu'
CHAR RM_DIRECTORY[]				= '/Nano/nano1118.json'

LONG TL_IPCOMM_CONNECT		= 5001 

#IF_NOT_DEFINED __COMMON_TXT__
#DEFINE __COMMON_TXT__
TXT_HELP					= 99
TXT_ROOM					= 100
#END_IF


//Json ID's
ROOM_ID				= 1; //Important see Json file
ROOM_COUNT			= 3; //Important for setting for Loop! 

BTN_SET_ALL					= 1502

DEFINE_TYPE

STRUCTURE _IpConnection
{
    CHAR address[255];
    INTEGER port;
    INTEGER nMode; 	//TCP or UDP
    CHAR isConnected;
}
STRUCTURE _ROOM_INFO
{
    CHAR bLocation[35];
    CHAR bPhone[15];
    SINTEGER bReset;
    SINTEGER bHour;
    SINTEGER bMinute;
}


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _IpConnection uGitConnection;
VOLATILE _ROOM_INFO cInfo[ROOM_COUNT];

VOLATILE CHAR sGitIpBuffer[8000];
VOLATILE CHAR sGitIpQueue[2500];
VOLATILE CHAR sNumFound[25];

VOLATILE LONG lTLreadIn[] =
{
    0,
    2000,
    5000,
    10000
}


(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
DEFINE_FUNCTION parseLineFromJson()
{
    STACK_VAR CHAR cMsg[5000];
    STACK_VAR CHAR cResponse[20];
    STACK_VAR INTEGER cCount;
    LOCAL_VAR INTEGER nRoomTotal;
    STACK_VAR CHAR cRead[25];
    STACK_VAR CHAR cSmpHelp[100];
    
    WHILE (FIND_STRING(sGitIpBuffer, 'HTTP/1.1 200 OK',1))
    {
	REMOVE_STRING(sGitIpBuffer, 'HTTP/1.1 200 OK',1)
	    REMOVE_STRING(sGitIpBuffer, 'Accept-Ranges: bytes',1) //Just Before Json Structure
	    
	cMsg = sGitIpBuffer; //
	    uGitConnection.isConnected = TRUE;
	    
	    IF (FIND_STRING(cMsg,'"roomphone": "',1)) 
	    {
		REMOVE_STRING (cMsg, '"roomphone": "',1)
		    cResponse = REMOVE_STRING (cMsg, '",',1)
			cInfo[ROOM_ID].bPhone = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    SEND_COMMAND vdvTP_Rooms, "'^TXT-',ITOA(TXT_HELP),',0,',cInfo[ROOM_ID].bPhone"
				sNumFound = cInfo[ROOM_ID].bPhone;
	    }
	    IF (FIND_STRING(cMsg,'"roomreboot": ',1)) 
	    {
		REMOVE_STRING (cMsg, '"roomreboot": ',1)
		    cInfo[ROOM_ID].bReset = ATOI(cMsg);
	    }
	    IF (FIND_STRING(cMsg,'off_hour": ',1)) 
	    {
		REMOVE_STRING (cMsg, 'off_hour": ',1)
		    cInfo[ROOM_ID].bHour = ATOI(cMsg);
	    }
	    IF (FIND_STRING(cMsg,'off_minute": ',1)) 
	    {
		REMOVE_STRING (cMsg, 'off_minute": ',1)
			cInfo[ROOM_ID].bMinute = ATOI(cMsg);
	    }
	    IF (FIND_STRING(cMsg, '"room_name1":',1))  {
		REMOVE_STRING (cMsg, '"room_name1": "',1)
		    cResponse = REMOVE_STRING (cMsg, '",',1)
			cInfo[ROOM_ID].bLocation = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -2);
		    
			    SEND_COMMAND dvTP_1118, "'^TXT-',ITOA(TXT_ROOM),',0,',cInfo[ROOM_ID].bLocation"
	    }
	    IF (FIND_STRING(cMsg, '"smpIp": "',1)) {
		REMOVE_STRING (cMsg, '"smpIp": "',1)
		    cSmpHelp = REMOVE_STRING (cMsg, '",',1)
			SmpInfo.bHost = LEFT_STRING(cSmpHelp,LENGTH_STRING(cSmpHelp) -2);
			    bData = SmpInfo.bHost;
	    }
	    IF (FIND_STRING(cMsg, '"smpSubnet": "',1)) {
		    REMOVE_STRING (cMsg, '"smpSubnet": "',1)
			     cSmpHelp = REMOVE_STRING (cMsg, '",',1)
			SmpInfo.bSubNet =LEFT_STRING(cSmpHelp,LENGTH_STRING(cSmpHelp) -2);
	    }
	    IF (FIND_STRING(cMsg, '"smpGateway": "',1)) {
			REMOVE_STRING (cMsg, '"smpGateway": "',1)
			    cSmpHelp = REMOVE_STRING (cMsg, '",',1)
				SmpInfo.bGateway = LEFT_STRING(cSmpHelp,LENGTH_STRING(cSmpHelp) -2);
	    }
	    IF (FIND_STRING(cMsg, '"smpName": "',1)) {
		REMOVE_STRING (cMsg, '"smpName": "',1)
			   cSmpHelp = REMOVE_STRING (cMsg, '",',1)
				SmpInfo.bDeviceName = LEFT_STRING(cSmpHelp,LENGTH_STRING(cSmpHelp) -2);
	    }
	    IF (FIND_STRING(cMsg, '"smpDns": "',1)) {
		    REMOVE_STRING (cMsg, '"smpDns": "',1)
			    cSmpHelp = REMOVE_STRING (cMsg, '",',1)
				SmpInfo.bDNS = LEFT_STRING(cSmpHelp,LENGTH_STRING(cSmpHelp) -2);
	    }
	    IF (FIND_STRING(cMsg, '"smpLocation": "',1)) {
		REMOVE_STRING (cMsg, '"smpLocation": "',1)
		    cSmpHelp = REMOVE_STRING (cMsg, '"',1)
			SmpInfo.bLocation = LEFT_STRING(cSmpHelp,LENGTH_STRING(cSmpHelp) -1);
	    }
    }
}
DEFINE_FUNCTION sendGitHttp(CHAR iMode[20], CHAR iCmd[500])
{
    STACK_VAR CHAR iPacket[500];
    
    //Minimum HTTP 1.1 Requirment
    iPacket = "iMode, ' ',iCmd, ' HTTP/1.1',$0D,$0A,
		    'Host: ',uGitConnection.address,':',ITOA(uGitConnection.port),$0D,$0A,
		    $0D,$0A"; //Http terminates with the empty line
    
    IF (uGitConnection.isConnected == TRUE)
    {
	SEND_STRING dvRead, iPacket; //If online/connected - send the actual packet...
    }
    ELSE
    {
	sGitIpQueue = "sGitIpQueue , iPacket"
	    IP_CLIENT_OPEN (dvRead.PORT, uGitConnection.address, uGitConnection.port, uGitConnection.nMode);
    }
}
DEFINE_FUNCTION char[100] GetHubIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '";
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
	CASE 17 : iReturn = "'Local Port Not Open'";
	
	DEFAULT : iReturn = "'(',ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

uGitConnection.address = GIT_IP_HOST;
uGitConnection.port = 80;
uGitConnection.nMode = IP_TCP;

cInfo[2].bLocation = 'Nano-Tech 1117'
cInfo[3].bLocation = 'Nano-Tech 1116'

//TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
CREATE_BUFFER dvRead, sGitIpBuffer;

    WAIT 250 '25 Secs'
    {
	SEND_STRING 0, "'25 Secs after boot - Give me Json poll'"
	    TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTLreadIn,LENGTH_ARRAY(lTLreadIn),TIMELINE_ABSOLUTE, TIMELINE_ONCE);
    }

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_SET_ALL]
{
    PUSH :
    {
	IF (LENGTH_STRING (sNumFound))
	{
	    SEND_STRING 0, "'Phone # Already Stored'"
		SEND_COMMAND dvTP_1118, "'^TXT-',ITOA(TXT_ROOM),',0,',cInfo[ROOM_ID].bLocation"
		    SEND_COMMAND dvTP_1117, "'^TXT-',ITOA(TXT_ROOM),',0,',cInfo[2].bLocation"
		    SEND_COMMAND dvTP_1116, "'^TXT-',ITOA(TXT_ROOM),',0,',cInfo[3].bLocation"
		    
		    SEND_COMMAND vdvTP_Rooms, "'^TXT-',ITOA(TXT_HELP),',0,',cInfo[ROOM_ID].bPhone"
	}
	ELSE
	{
	    IF (!TIMELINE_ACTIVE(TL_IPCOMM_CONNECT))
	    {
		TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTLreadIn,LENGTH_ARRAY(lTLreadIn),TIMELINE_ABSOLUTE, TIMELINE_ONCE);
	    }
	}
    }
}
DATA_EVENT [dvRead]
{
    ONLINE :
    {
	uGitConnection.isConnected = TRUE;
    }
    OFFLINE :
    {
	uGitConnection.isConnected = FALSE;
    }
    ONERROR :
    {
	uGitConnection.isConnected = FALSE;
	   SEND_STRING 0, "'<-- Could Not Reach Config.amx !!-->',GetHubIpError(DATA.NUMBER)";
	    
	    IF (LENGTH_STRING (sNumFound) == 0) //No Length...
	    {
	    	    SEND_COMMAND vdvTP_Rooms, "'^TXT-',ITOA(TXT_HELP),',0,',INFO_NUM"
			SEND_COMMAND dvTP_1118, "'^TXT-',ITOA(TXT_ROOM),',0,',INFO_ROOM_1118"
			    SEND_COMMAND dvTP_1117, "'^TXT-',ITOA(TXT_ROOM),',0,',INFO_ROOM_1117"
				SEND_COMMAND dvTP_1116, "'^TXT-',ITOA(TXT_ROOM),',0,',INFO_ROOM_1116"
	    }
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14 : //Port already Open...
	    {
		IP_CLIENT_CLOSE (dvRead.PORT);
	    }
	    DEFAULT :
	    {
		//TIMELINE_SET(TL_IPCOMM_CONNECT, 0); //Set to beginning
	    }
	}
    }
    STRING :
    {
	parseLineFromJson();
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT]
{
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 :
	{
	    SEND_STRING 0, "'Grab Info from GIT...'"
		sGitIpBuffer = ''; 
	    
	    IF (uGitConnection.isConnected == TRUE)
	    {
		IP_CLIENT_CLOSE (dvRead.PORT);
	    }
	}
	CASE 2 :
	{
	    IF (LENGTH_STRING (uGitConnection.address) && (uGitConnection.port))
	    {
		IP_CLIENT_OPEN (dvRead.PORT, uGitConnection.address, uGitConnection.port, uGitConnection.nMode);
	    }
	}
	CASE 3 :
	{
	    sendGitHttp( 'GET', RM_DIRECTORY);
	}
	CASE 4 :
	{
	    IP_CLIENT_CLOSE (dvRead.PORT);
		uGitConnection.isConnected = FALSE;
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 6000 '10 Min'
    {
	IF (!TIMELINE_ACTIVE(TL_IPCOMM_CONNECT))
	{
	    TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTLreadIn,LENGTH_ARRAY(lTLreadIn),TIMELINE_ABSOLUTE, TIMELINE_ONCE);
	}
    }
}

