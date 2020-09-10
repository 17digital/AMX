PROGRAM_NAME='Master'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/10/2019  AT: 06:06:29        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    38400,E,8,1
    !! IMPORTANT !!
    
    YOU MUST...
    Update Line 142 with correct room number (102 or 423
    Update the RMSMain file line 56 & 57 for RMS
    
    Compile...
    Make sure you are sending to correct master!!
*)
    

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

DL_SYSTEM = 7068

dvMaster 			=	0:1:0 //Master
dvTelnet =				0:4:0 //

dvTP_Main			=	10001:1:0 //TouchPanel

dvRelays			=	5001:8:0	//Relays start on Port 8
dvIO				=	5001:17:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CR 					= 13
LF 					= 10

// Time Lines
TL_FEEDBACK				= 1
TL_FLASH				= 2
TL_REBOOT				= 3

ONE_SECOND				= 10 
ONE_MINUTE				= 60*ONE_SECOND
ONE_HOUR				= 60*ONE_MINUTE

LONG IP_PORT				= 23 //AMX use
CHAR IP_ADDRESS[]			= '127.0.0.1' //Loop Back Address...

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nTPOnline

VOLATILE LONG lTLFeedback[] = {500}


VOLATILE DEV vdvTP_Main[] = {dvTP_Main}

VOLATILE LONG TIMER_ARRAY[] =
{
    1000,		// 1 Second
    300000,  	// 5 Minutes
    600000,  	// 10 Minutes
    1200000, 	// 20 Minutes
    1800000, 	// 30 Minutes
    3600000, 	// 60 Minutes
    6900000, 	// 115 Minutes (5 Minute Warning Before Shutdown)
    7200000  	// 120 Minutes (Max)
} 
VOLATILE INTEGER nTimelineIO[] =
{
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8
}


(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvIO,nTimelineIO[1]]..[dvIO,nTimelineIO[8]])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnNetCheck(CHAR cTIMING[15])
{
    SWITCH (cTIMING)
    {
	CASE 'TIMER START' :
	{
	    TIMELINE_CREATE(TL_REBOOT,TIMER_ARRAY,LENGTH_ARRAY(TIMER_ARRAY),TIMELINE_ABSOLUTE,TIMELINE_ONCE);
	}
	CASE 'CLEAR ALL' :
	{
	    TIMELINE_KILL(TL_REBOOT)
	    TOTAL_OFF [dvIO, nTimelineIO]
	}
    }
}
DEFINE_FUNCTION fnReGainConnection()
{
    IP_CLIENT_CLOSE(dvTelnet.PORT)
    WAIT 20
    {
	IP_CLIENT_OPEN (dvTelnet.PORT,IP_ADDRESS,IP_PORT,1) //Open Telent
    }
}
DEFINE_FUNCTION fnConnectionLost()
{
    IF (!nTPOnline)
    {
	fnNetCheck ('TIMER START')
    }
    ELSE
    {
	fnNetCheck ('CLEAR ALL')
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)

DEFINE_EVENT
DATA_EVENT [dvTelnet]
{
    ONLINE :
    {
	SEND_STRING 0, "'TELNET CLIENT IS ONLINE'"
    }
    STRING :
    {
	LOCAL_VAR CHAR cResponse[500]
	
	cResponse = DATA.TEXT
	
	SELECT
	{
	    ACTIVE (FIND_STRING(cResponse,'Welcome to NetLinx',1)):
	    {
		WAIT 20
		{
		    SEND_STRING dvTelnet, "'renew dhcp',CR"
		    cResponse = ''
		}
	    }
	    ACTIVE (FIND_STRING (cResponse, 'Are you sure you want to renew the DHCP lease?',1)):
	    {
	    
		SEND_STRING dvTelnet, "'y',CR" //Say Yes...
		cResponse = ''
		WAIT 10
		{
		    IP_CLIENT_CLOSE(dvTelnet.PORT)
		}
	    }
	    ACTIVE (FIND_STRING (cResponse, 'You may need to re-establish the telnet session',1)):
	    {
		SEND_STRING 0, "'DHCP RENEW SUCCESSFUL'"
		cResponse =''
	    }
	    ACTIVE (FIND_STRING (cResponse, 'Hostname',1)):
	    {
		//Remove  all [Office-NI7000] At least 31 Char
	    }
	    ACTIVE (FIND_STRING (cResponse, 'Type',1)):
	    {
		//Remove All
		//DHCP
	    }
	    ACTIVE (FIND_STRING (cResponse, 'IP Address',1)):
	    {
		//Remove All
		//Range 15 CHAR
	    }
	    ACTIVE (FIND_STRING (cResponse, 'Subnet Mask',1)):
	    {
				//Remove All
		//Range 15 CHAR
	    }
	    ACTIVE (FIND_STRING (cResponse, 'Gateway IP',1)):
	    {
				//Remove All
		//Range 15 CHAR
	    }
	    ACTIVE (FIND_STRING (cResponse, 'MAC Address',1)):
	    {
				//Remove All
		//Range 18 CHAR
		//00:66:9f:95:2a:c6
	    }
	}
    }
    OFFLINE :
    {
	SEND_STRING 0, "'TELNET CLIENT IS OFFLINE'"
    }
}
DATA_EVENT [dvTP_Main] //Touch Panel Reset...
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
    }
    OFFLINE :
    {
	OFF [nTPOnline]
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_REBOOT]
{
    SWITCH(TIMELINE.SEQUENCE)
    {
	CASE 1 : 
	{
	    ON [dvIO, 1]
	    SEND_COMMAND vdvTp_Main,"'^TXT-600,0,',ITOA(TIMELINE_GET(TL_REBOOT))"
	}
	CASE 2 : //5 Minutes...
	{
	    ON [dvIO, 2]
	    SEND_COMMAND vdvTp_Main,"'^TXT-600,0,',ITOA(TIMELINE_GET(TL_REBOOT))"
	    fnReGainConnection()
	}
	CASE 3 : //10 Minutes..
	{
	    ON [dvIO, 3]
	    SEND_COMMAND vdvTp_Main,"'^TXT-600,0,',ITOA(TIMELINE_GET(TL_REBOOT))"
	    fnReGainConnection()
	}
	CASE 4 : //20 Minutes...
	{
	    ON [dvIO, 4]
	    SEND_COMMAND vdvTp_Main,"'^TXT-600,0,',ITOA(TIMELINE_GET(TL_REBOOT))"
	    fnReGainConnection()
	}
	CASE 5 : //30 Minutes...
	{
	    ON [dvIO, 5]
	    SEND_COMMAND vdvTp_Main,"'^TXT-600,0,',ITOA(TIMELINE_GET(TL_REBOOT))"
	    
	    fnNetCheck('CLEAR ALL')
	    
	    WAIT 50
	    {
		
		REBOOT(dvMaster)
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{

    fnConnectionLost()
}

DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


               



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

