PROGRAM_NAME='System_Setup_'


DEFINE_DEVICE

dvMaster =				0:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)

DEFINE_CONSTANT


//Clock Stuff...
CHAR TIME_IP[]					= '130.207.165.28' //Your Clock Server IP Address
CHAR TIME_SERVER[]				= 'ntp1.gatech.edu' //Your Clock Server Name Address
CHAR TIME_LOC[]					= 'NIST, Georgia, ATL'
CHAR TIME_ZONE[]				= 'UTC-05:00' //Eastern
INTEGER TIME_SYNC_PERIOD 		= 60 //1 hour


//System Number...
INTEGER MY_SYSTEM				= 1234


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)

DEFINE_VARIABLE

IP_ADDRESS_STRUCT myIPSet[1]
DNS_STRUCT myDNS[1]


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSetClock()
{
	WAIT 10 CLKMGR_SET_CLK_SOURCE(CLKMGR_MODE_NETWORK)//1 
	WAIT 30 CLKMGR_SET_TIMEZONE(TIME_ZONE)
	WAIT 60 CLKMGR_SET_RESYNC_PERIOD(TIME_SYNC_PERIOD) 
	WAIT 90 CLKMGR_SET_DAYLIGHTSAVINGS_MODE(TRUE)
	WAIT 110 CLKMGR_ADD_USERDEFINED_TIMESERVER(TIME_IP, TIME_SERVER, TIME_LOC)
	WAIT 140 CLKMGR_SET_ACTIVE_TIMESERVER(TIME_IP) 
}
DEFINE_FUNCTION fnSetIPAddress()
{
    #WARN    'Extremely Important DO NOT set an incorrect address here! '
    
    myIPSet[1].FLAGS = 0 //Use Static... 1 for DHCP
    myIPSet[1].HOSTNAME = 'Skiles006Master'
    myIPSet[1].IPADDRESS = '172.21.1.128'
    myIPSet[1].SUBNETMASK = '255.255.252.0'
    myIPSet[1].GATEWAY = '172.21.0.1'

}
DEFINE_FUNCTION fnSetDNSAddress()
{
    myDNS[1].DomainName = 'amx.gatech.edu'
    myDNS[1].DNS1 = '130.207.244.251'
    myDNS[1].DNS2 = '130.207.244.244'
    myDNS[1].DNS3 = '128.61.244.254'

}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SET_SYSTEM_NUMBER (MY_SYSTEM) //Will Not See this change until the first reboot AFTER loading this

fnSetIPAddress()
fnSetDNSAddress()

WAIT 350
{
    fnSetClock()
    WAIT 20
    {
	SET_IP_ADDRESS (dvMaster, myIPSet[1])
	WAIT 30
	{
	    SET_DNS_LIST (dvMaster, myDNS[1])
	}
    }
}