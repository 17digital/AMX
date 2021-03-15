PROGRAM_NAME='ShureTest'
(***********************************************************)
(*  FILE CREATED ON: 04/03/2020  AT: 06:53:01              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/14/2020  AT: 10:10:08        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Device Shure P300
    Max Volume = 1400
    Min Volume = 
    
    https://pubs.shure.com/command-strings/P300/en-US
    https://blog.adafruit.com/2018/09/29/homemade-roku-remote-uses-roku-external-control-api-huzzah-esp8266/
    https://medium.com/@nchourrout/building-a-better-and-bulkier-roku-remote-fa34bcb185c3
    
    https://proforums.harman.com/amx/discussion/comment/195301#Comment_195301
    
    https://harman.remote-learner.net/course/view.php?id=964&section=5
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE



dvMaster =			0:1:0 //System 4003
dvRoku =				0:3:0 //Shure Mixer See AMX TECH NOTE 937!!! For more Documentation
vdvRoku =			33301:1:0

dvTP_Office =			10002:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

BTN_ROKU_PWR_ON			= 27
BTN_ROKU_PWR_OFF			= 28
BTN_ROKU_HOME				= 251

CHAR cROKU_HOME[]       = 'curl -i "http://172.21.24.10:8060/keypress/Home" -X POST' //Provides Response...
CHAR cROKU_POWEROFF[]       = 'curl -i "http://172.21.24.10:8060/keypress/PowerOff" -X POST'
CHAR cROKU_POWERON[]       = 'curl -i "http://172.21.24.10:8060/keypress/PowerOn" -X POST'

TL_ROKU						= 2

#IF_NOT_DEFINED __GLOBALS__
#DEFINE __GLOBALS__ 

STATE_PWR_ON			= 27
STATE_PWR_OFF 			= 28
STATE_ONLINE			= 251
STATE_INIT				= 252
STATE_WARMING			= 253
STATE_COOLING			= 254
STATE_POWER				= 255
STATE_BLANK				= 211


#END_IF



#INCLUDE 'SysInfo'
#INCLUDE 'TimerTimeline'
#INCLUDE 'ShureSCM820'

DEFINE_TYPE

STRUCTURE _ServerInfo
{
    CHAR cServerAddress[255];	// TCP-IP Address Server
    INTEGER nIPPort;		// TCP-IP No Port Server
    INTEGER nIPProtocol;		// TCP or UDP
    CHAR isConnected; //Track Connection State
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE LONG lTlIpConnect[] = {30000}; //30 Seconds....

VOLATILE _ServerInfo ServerInfo

VOLATILE INTEGER nConnect = 1
VOLATILE INTEGER nDisconnect = 0

VOLATILE INTEGER nRokuConnect_
VOLATILE INTEGER nTCP = 1	
VOLATILE INTEGER nPortSpx = 8060
VOLATILE CHAR cIPAddrSpx[] = '172.21.24.10'	//IP Adress Roku Bed

VOLATILE CHAR nRokuBuffer[5000];
VOLATILE CHAR bIpCommDebug = FALSE; 

VOLATILE INTEGER nConnectedToServer

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
DEFINE_FUNCTION fnStatusIP()	// Status  Connection
{
  //  [dvTP___1_1,255] = (nConnectedToServer == 1)
}
DEFINE_FUNCTION fnCommIP (INTEGER nMode)	// Open/Close socket
{
    STACK_VAR INTEGER nFct
    nFct = nMode
    SWITCH(nMode)
	{
	CASE 0 :
	    {
	    IP_CLIENT_CLOSE(dvRoku.Port)
	    BREAK;
	    }
	CASE 1 :
	    {
	    IP_CLIENT_OPEN(dvRoku.Port, ServerInfo.cServerAddress, ServerInfo.nIPPort, ServerInfo.nIPProtocol)
	    BREAK;
	    }
	}
}
DEFINE_FUNCTION fnSendHTTPString(CHAR cType[], CHAR cCmd[20])
{
	LOCAL_VAR CHAR iCmd[500];
	
	iCmd = "cType,' ',cCmd,' HTTP/1.1',$0D,$0A,
	    'Host: ',ServerInfo.cServerAddress,':',ITOA(ServerInfo.nIPPort),$0D,$0A,
	$0D,$0A";
	
	amx_log(AMX_INFO,"'sendRokuHttp(',cType, ',',cCmd,')'");
	
	IF (nConnectedToServer = nConnect)
	{
	    amx_log (AMX_INFO, "'SEND_STRING dvRoku, ',iCmd");
		SEND_STRING dvRoku, iCmd;
	}
	
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ServerInfo.cServerAddress = cIPAddrSpx
ServerInfo.nIPPort = nPortSpx
ServerInfo.nIPProtocol = IP_TCP

//nConnectedToServer = 0

CREATE_BUFFER dvRoku,nRokuBuffer;
TIMELINE_CREATE (TL_ROKU, lTlIpConnect,LENGTH_ARRAY(lTlIpConnect),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT[dvTP_Office, BTN_ROKU_PWR_OFF]	// button #1
{
    PUSH:
    {
	TO[BUTTON.INPUT]
	    fnCommIP (1)
	    WAIT 2
		{
		    fnSendHTTPString ('POST', '/keypress/PowerOff')
		}
    }
}
BUTTON_EVENT [dvTP_Office, 1]
{
    PUSH :
    {
	fnCommIP (1)
	WAIT 2
	{
	    fnSendHTTPString('POST','/keypress/Home')
	}
    }
}
DATA_EVENT[dvRoku]		// Event HMP
{
    ONLINE:
    {
	nConnectedToServer = nConnect
	fnStatusIP()
    }
    OFFLINE:
    {
	nConnectedToServer = nDisconnect
	fnStatusIP()
    }
}
TIMELINE_EVENT [TL_ROKU]
{
    IF (_ServerInfo.isConnected == FALSE)
    {
	IP_CLIENT_OPEN
    }
    
}


(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


