PROGRAM_NAME='Shure_WM_Quad'



DEFINE_DEVICE


dvShure =				0:4:0 //Shure WM Receiver

dvTP_Shure =				10001:6:0

#IF_NOT_DEFINED dvTP_Shure2
dvTP_Shure2 =			10002:6:0
#END_IF


DEFINE_CONSTANT


//Mic + Line Input IDS...
IN_MIC_1				= 1
IN_MIC_2				= 2
IN_MIC_3				= 3
IN_MIC_4				= 4

BTN_NET_BOOT		= 1000


//TXT Addresses...
TXT_CH_1				= 311
TXT_CH_2				= 312
TXT_CH_3				= 313
TXT_CH_4				= 314
TXT_DEVICE				= 1001

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR shureIP[15]= '172.21.2.159' 

LONG SCM820_Port= 2202 //Port Shure uses!
VOLATILE INTEGER scm820Online
VOLATILE INTEGER lBooted

VOLATILE CHAR cShureBuffer[500]

VOLATILE DEV vdvTP_Shure[] = 
{
    dvTP_Shure,
    dvTP_Shure2
}
VOLATILE INTEGER nNameSlot[] =
{
    TXT_CH_1,
    TXT_CH_2,
    TXT_CH_3,
    TXT_CH_4
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnStartConnection()
{
    IP_CLIENT_OPEN(dvShure.PORT,shureIP,SCM820_Port,1) //#1 is for TCP/IP connection
}
DEFINE_FUNCTION fnCloseConnection()
{
    IP_CLIENT_CLOSE(dvShure.PORT) 
}
DEFINE_FUNCTION fnGetShureRep()
{
    WAIT 10 SEND_STRING dvShure, '< GET 1 FREQUENCY >'
    WAIT 20 SEND_STRING dvShure, '< GET 2 FREQUENCY >'
    WAIT 30 SEND_STRING dvShure, '< GET 3 FREQUENCY >'
    WAIT 40 SEND_STRING dvShure, '< GET 4 FREQUENCY >'
    
    WAIT 50 SEND_STRING dvShure, '< GET 1 BATT_BARS >'
    WAIT 60 SEND_STRING dvShure, '< GET 2 BATT_BARS >'
    WAIT 70 SEND_STRING dvShure, '< GET 3 BATT_BARS >'
    WAIT 80 SEND_STRING dvShure, '< GET 4 BATT_BARS >'
}
DEFINE_FUNCTION fnReconnect()
{
    fnCloseConnection()
	WAIT 20
	{
	    fnStartConnection()
	    WAIT 30 fnGetShureRep()
	}
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [lBooted]
CREATE_BUFFER dvShure, cShureBuffer;


WAIT 80
{
    fnStartConnection()
    WAIT 30
    {
	    fnGetShureRep()
    }
}

WAIT 600
{
    OFF [lBooted]
}

DEFINE_EVENT 
DATA_EVENT [dvShure]
{
    ONLINE :
    {
	ON [scm820Online]
	ON [vdvTP_Shure, BTN_NET_BOOT]
    	CANCEL_WAIT 'DEVICE COMM/INIT'
	
	WAIT 3500 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
		OFF [vdvTP_Shure, BTN_NET_BOOT]
	    fnReconnect()
	}
    }
    STRING :
    {
    	LOCAL_VAR CHAR cResponse[100]
	LOCAL_VAR INTEGER cID //Holds Input ID
	LOCAL_VAR CHAR cFreq[6]
	LOCAL_VAR CHAR cBatteryLev[3]
	LOCAL_VAR CHAR cFirstFreq[3]
	LOCAL_VAR CHAR cLastFreq[3]
	
	ON [scm820Online]
	ON [vdvTP_Shure, BTN_NET_BOOT]
    	CANCEL_WAIT 'DEVICE COMM/INIT'
	
	WAIT 3500 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
		OFF [vdvTP_Shure, BTN_NET_BOOT]
	    fnReconnect()
	}
	SEND_STRING 0,"'RECEIVING AUDIO ',cShureBuffer"
	
	//Parsing Begins....
	
	IF (FIND_STRING (cShureBuffer,'< REP ',1))
	{
	    REMOVE_STRING (cShureBuffer,'< REP ',1)
	    
	    cResponse = cShureBuffer
	    cID = ATOI (LEFT_STRING(cResponse, 1)) //1 -- 4
	    
	    IF (FIND_STRING(cResponse, "ITOA(cID), ' FREQUENCY '",1))
	    {
		REMOVE_STRING (cResponse,"ITOA(cId), ' FREQUENCY '",1)
		    cFreq = cResponse
		    
		    cFirstFreq = LEFT_STRING (cFreq,3)
		    cLastFreq = MID_STRING (cFreq, 4, 3)
		    
			SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(cID),',0,',cFirstFreq,'-',cLastFreq"
	    }
	    IF (FIND_STRING (cResponse, "ITOA(cID), ' BATT_BARS '",1))
	    {
		REMOVE_STRING (cResponse,"ITOA(cId), ' BATT_BARS '",1)
		cBatteryLev = cResponse
		
		SWITCH (cBatteryLev)
		{
		    CASE '255' : //Error Code - Not communicating w/ Mic...
		    {
			//Not Connectd / Battery Level not Received...
			SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
			    OFF [vdvTP_Shure, nNameSlot[cID]]
		    }
		    DEFAULT :
		    {
			//Received Battery Level...
			SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connectd !'"
			    ON [vdvTP_Shure, nNameSlot[cID]]
		    }
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 3000
    {
	fnGetShureRep()
    }

}


