PROGRAM_NAME='RokuIP'

(*
    Sample Roku HTTP Commands..
    
    	    //http://172.21.24.12:8060/keypress/PowerOff"
	    //http://172.21.24.12:8060/keypress/PowerOn"
	    
	Test from Windows Terminal....
	    CHAR cROKU_HOME[]       = 'curl -i "http://172.21.24.10:8060/keypress/Home" -X POST' //Provides Response...
CHAR cROKU_POWEROFF[]       = 'curl -i "http://172.21.24.10:8060/keypress/PowerOff" -X POST'
CHAR cROKU_POWERON[]       = 'curl -i "http://172.21.24.10:8060/keypress/PowerOn" -X POST'

'curl -d '' "http://172.21.24.10:8060/keypress/PowerOn" -X POST' //Does not send FB Response
    *)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvRoku = 		0:3:0
dvTP_Roku =		10002:4:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED __GLOBAL_CONST__
#DEFINE __GLOBAL_CONST__

STATE_PWR_ON			= 27
STATE_PWR_OFF			= 28
STATE_BLANK				= 211
STATE_ONLINE			= 251
STATE_INIT				= 252
STATE_WARMING			= 253
STATE_COOLING			= 254
STATE_POWER				= 255

#END_IF

LONG TL_IPCOMM_CONNECT		= 5001 


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _IpConnection
{
    CHAR address[255];
    INTEGER port;
    INTEGER nMode; 	//TCP or UDP
    CHAR isConnected;
}


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _IpConnection uRokuIpConnection;

VOLATILE LONG lTlIpConnect[] = {30000}; //30-second Query Loop...

VOLATILE CHAR sRokuIpBuffer[5000]; //Reads the Return of the Roku Response..
VOLATILE CHAR sRokuIpQueue[1000]; //Hold if Command is Not sent due to connection trouble...

VOLATILE LONG lTlFeedback[] = {500}; // 1/2 Second
VOLATILE CHAR sActiveApp[6];

VOLATILE CHAR sRokuAppList[6][6] = //Stores List of Apps...
{
    '23333', //PBS Kids
    '13535', //Plex App...
    '12', //NetFlix
    '61595', //Joseph Prince...
    '13', //Prime Video (Amazon)
    '50025' //Google Play
}
VOLATILE INTEGER nRokuAppBtns[] = //Buttons to Call App Array...
{
    301,
    302,
    303,
    304,
    305,
    306
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Roku,203],[dvTP_Roku, 301]..[dvTP_Roku, 306])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
DEFINE_FUNCTION sendRokuHttp(CHAR iMode[20], CHAR iCmd[500])
{
    STACK_VAR CHAR iPacket[500]
    
    //Minimum HTTP 1.1 Requirment
    iPacket = "iMode, ' ',iCmd, ' HTTP/1.1',$0D,$0A,
			'Host: ',uRokuIpConnection.address,':',ITOA(uRokuIpConnection.port),$0D,$0A,
			$0D,$0A"; //Http terminates with the empty line
			
    //Send Debug Log
    AMX_LOG (AMX_INFO," 'sendRokuHttp(',iMode,',',iCmd,')'");
    
    IF (uRokuIpConnection.isConnected == TRUE)
    {
	AMX_LOG (AMX_INFO,"'SEND_STRING dvRoku, ',iPacket"); //Send for Debugging...
	SEND_STRING dvRoku, iPacket; //If online/connected - send the actual packet...
    }
    ELSE
    {
	sRokuIpQueue = "sRokuIpQueue, iPacket"; //If Not connected store it in a que!
	    IP_CLIENT_OPEN(dvRoku.PORT, uRokuIpConnection.address, uRokuIpConnection.port, uRokuIpConnection.nMode);
    }
}
DEFINE_FUNCTION char[100] GetIpError (LONG iErrorCode)
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
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

uRokuIpConnection.address = '172.21.24.10'
uRokuIpConnection.port = 8060
uRokuIpConnection.nMode = IP_TCP

CREATE_BUFFER dvRoku, sRokuIpBuffer; 

TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTlIpConnect,LENGTH_ARRAY(lTlIpConnect),TIMELINE_ABSOLUTE, TIMELINE_REPEAT);

(***********************************************************)
(*                  THE EVENTS GO BELOW                    *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Roku, 0] //wild card zero..
{
    PUSH :
    {
	TO [BUTTON.INPUT]
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE 201 :
	    {
		sendRokuHttp( 'POST', ' /keypress/PowerOn')
	    }
	    CASE 202 :
	    {
		sendRokuHttp( 'POST', ' /keypress/PowerOff')
	    }
	    CASE 203 :
	    {
		sendRokuHttp( 'POST', ' /keypress/Home')
	    }
	    CASE 204 :
	    {
		sendRokuHttp( 'POST', ' /keypress/Up')
	    }
	    CASE 205 :
	    {
		sendRokuHttp( 'POST', ' /keypress/Down')
	    }
	    CASE 206 :
	    {
		sendRokuHttp( 'POST', ' /keypress/Left')
	    }
	    CASE 207 :
	    {
		sendRokuHttp( 'POST', ' /keypress/Right')
	    }
	    CASE 208 :
	    {
		sendRokuHttp( 'POST', ' /keypress/Select')
	    }
	    CASE 209 :
	    {
		sendRokuHttp( 'POST', ' /keypress/VolumeUp')
	    }
	    CASE 210 :
	    {
		sendRokuHttp( 'POST', ' /keypress/VolumeDown')
	    }
	    CASE 211 :
	    {
		sendRokuHttp( 'POST', ' /keypress/VolumeMute')
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Roku, nRokuAppBtns] //Call Apps...
{
    PUSH :
    {
	STACK_VAR INTEGER iBtn
	
	iBtn = GET_LAST (nRokuAppBtns)
	
	    sendRokuHttp('POST', "'/launch/',sRokuAppList[iBtn]" );
	    sActiveApp = sRokuAppList[iBtn]; //Direct Variable Feedback....
	    ON [dvTP_Roku, nRokuAppBtns[iBtn]] //Direct Button On Feedback...
    }
}

DEFINE_EVENT
DATA_EVENT[dvRoku]
{
    ONLINE :
    {
	uRokuIpConnection.isConnected = TRUE;
	
	//Empty Que...
	WHILE(FIND_STRING(sRokuIpQueue,"$0D,$0A,$0D,$0A",1)) //Standard Http Terminator
	{
	    STACK_VAR CHAR iMessage[500];
	    
	    iMessage = REMOVE_STRING( sRokuIpQueue,"$0D,$0A,$0D,$0A",1 );
	    
	    AMX_LOG (AMX_INFO,"'SEND_STRING dvRoku, ',iMessage"); //Send Debug Message...
	    SEND_STRING DATA.DEVICE,iMessage;
	    
	}
    }
    OFFLINE :
    {
	uRokuIpConnection.isConnected = FALSE;
	
	IF (TIMELINE_ACTIVE (TL_IPCOMM_CONNECT))
	{
	    TIMELINE_SET(TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY(lTlIpConnect)] -100); //Set to Just before the end - speed things up
	}
	ELSE
	{
	    TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTlIpConnect,LENGTH_ARRAY(lTlIpConnect),TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	}
    }
    ONERROR :
    {
	AMX_LOG(AMX_ERROR, " 'dvRoku:ONERROR: ',GetIpError(DATA.NUMBER)");
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 : //Connection Timed Out...
	    {
		TIMELINE_SET(TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY(lTlIpConnect)] -100); //Set to Just before the end - speed things up
	    }
	    DEFAULT :
	    {
		TIMELINE_SET(TL_IPCOMM_CONNECT, 0); //Set to beginning
	    }
	}
    }
    STRING :
    {
	//Parse Data Here....
	//I Just Want the ID...
	//	<app id="50025" type="appl" version="2.1.20201113">Google Play Movies &amp; TV</app> ...String Returned
	//61595

	WHILE (FIND_STRING(sRokuIpBuffer,"$0A",1))
	{
	    LOCAL_VAR CHAR cMsg[100];
	    
	    cMsg = REMOVE_STRING(sRokuIpBuffer, "$0A",1)
	    
	    IF ( FIND_STRING(cMsg,'<app', 1) && FIND_STRING(cMsg, '</app>',1))
	    {
		LOCAL_VAR INTEGER iStx, iEtx;
		STACK_VAR CHAR iApp[6];
		
		iStx = FIND_STRING(cMsg, 'id=',1) +4; //Offset after leading "
		//iEtx = FIND_STRING (cMsg, 'type=',1) -2; //Offset back before trailing...
		iEtx = FIND_STRING(cMsg, '"', FIND_STRING (cMsg, 'id=',1)+4); //Find Trailing " after leading "
		
		iApp = MID_STRING(cMsg, iStx, (iEtx - iStx));
		
		AMX_LOG (AMX_WARNING, "'ROKU RX active-app = ',iApp");
		
		sActiveApp = iApp; 
		
		SWITCH (sActiveApp)
		{
		    CASE  '23333' : ON [dvTP_Roku, 301] //PBS
		    CASE '13535' : ON [dvTP_Roku, 302] //Plex
		    CASE '12' : ON [dvTP_Roku, 303] //Netflix
		    CASE '61595' : ON [dvTP_Roku, 304] //JP
		    CASE '13' : ON [dvTP_Roku, 305] //Prime
		    CASE '50025' : ON [dvTP_Roku, 306] //Google
		    DEFAULT : ON [dvTP_Roku, 203] //Home
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Query Device Timeline
{
    
    IF (uRokuIpConnection.isConnected == FALSE)
    {
	IF (LENGTH_STRING (uRokuIpConnection.address) && (uRokuIpConnection.port))
	{
	    IP_CLIENT_OPEN (dvRoku.PORT, uRokuIpConnection.address, uRokuIpConnection.port, uRokuIpConnection.nMode)
	}
	ELSE
	{
	    AMX_LOG (AMX_ERROR, 'IP ERROR-> IP Addressing is Not Set');
	}
    }

    sendRokuHttp ('GET', '/query/active-app');
}
