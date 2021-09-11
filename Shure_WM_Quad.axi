PROGRAM_NAME='Shure_WM_Quad'
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    This include file is designed to Communicate with the Shure ULX-D Wireless to grab Transmitter connection status to receiver. Usefull for displaying connection
    status on AMX Touch panel for Users. Mic Receivers may not be installed in direct line of user's sight. 
    
    Device Shure ULX-D Wireless (Receiver)
    
    https://www.shure.com/en-IN/products/wireless-systems/ulx-d_digital_wireless
    
	Full API download :
	https://service.shure.com/s/article/ulx-d-crestron-amx-control-strings?language=en_US
	https://d24z4d3zypmncx.cloudfront.net/KnowledgeBaseFiles/ulx-d-network-string-commands.pdf
    
    !!! AMX Terminal Commands to see Msg logs from this program
	msg on //error | warning | info | debug | off
	msg stats //
	start log on|off //enable or disable
	show start log all //Display the start up log. <start> specifies message to begin to display. 'all' will display all
*)


DEFINE_DEVICE


dvShure =				0:4:0 //Shure WM Receiver

dvTP_Shure =				10001:6:0

#IF_NOT_DEFINED dvTP_Shure2
dvTP_Shure2 =			10002:6:0
#END_IF


DEFINE_CONSTANT

//Mic Transmitter IDS...
IN_MIC_1				= 1
IN_MIC_2				= 2
IN_MIC_3				= 3
IN_MIC_4				= 4

BTN_NET_BOOT		= 1000

//TouchPanel Bnts/TXT Addresses...
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
    WAIT 10 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_1),' FREQUENCY >' "
    WAIT 20 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_2),' FREQUENCY >' "
    WAIT 30 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_3),' FREQUENCY >' "
    WAIT 40 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_4),' FREQUENCY >' "
    
    WAIT 50 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_1),' BATT_BARS >' "
    WAIT 60 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_2),' BATT_BARS >' "
    WAIT 70 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_3),' BATT_BARS >' "
    WAIT 80 SEND_STRING dvShure, " '< GET ',ITOA(IN_MIC_4),' BATT_BARS >' "
}
DEFINE_FUNCTION fnReconnect()
{
    fnCloseConnection()
	WAIT 10
	{
	    fnStartConnection()
	    WAIT 20 fnGetShureRep()
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
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [lBooted]
CREATE_BUFFER dvShure, cShureBuffer;


WAIT 600
{
    OFF [lBooted]
}

DEFINE_EVENT 
BUTTON_EVENT [vdvTP_Shure, BTN_NET_BOOT]
{
    RELEASE :
    {
	fnReconnect()
    }
}
DATA_EVENT [dvShure]
{
    ONLINE :
    {
	scm820Online = TRUE;
	ON [vdvTP_Shure, BTN_NET_BOOT]
    }
    OFFLINE :
    {
	scm820Online = FALSE;
	    OFF [vdvTP_Shure, BTN_NET_BOOT]
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvShure:onerror: ',GetIpError(DATA.NUMBER)");
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 : //Connection Time Out...
	    {
		scm820Online = FALSE;
		    fnReconnect()
	    }
	    DEFAULT :
	    {
		scm820Online = FALSE;
	    }
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
	STACK_VAR CHAR cType[30] //TX Type
	LOCAL_VAR CHAR cDbug[30]
	
	AMX_LOG (AMX_INFO, "'dvShure:STRING: ',DATA.TEXT"); //Store Log withing AMX Master- See Notes Above!
	scm820Online = TRUE;
	    ON [vdvTP_Shure, BTN_NET_BOOT]
	
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
		    CASE '005' :
		    CASE '004' :
		    CASE '003' :
		    CASE '002' :
		    CASE '001' : //Actual Battery Levels...
		    {
			SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connectd !'"
			    ON [vdvTP_Shure, nNameSlot[cID]]
		    }
		}
	    }
	    IF (FIND_STRING (cResponse, "ITOA(cId), ' TX_'",1))
	    {
		REMOVE_STRING (cResponse, "ITOA(cId), ' TX_'",1)
		    cType = cResponse
			SET_LENGTH_STRING(cType,LENGTH_STRING(cType) -2);
		    cDbug = cType
		    
		    SWITCH (cType)
		    {
			CASE 'MUTE_STATUS OFF' :
			CASE 'MENU_LOCK OFF' :
			CASE 'TYPE ULXD1' : 
			CASE 'RF_PWR LOW' :
			CASE 'MUTE_BUTTON_STATUS RELEASED' :
			{
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connectd !'"
				ON [vdvTP_Shure, nNameSlot[cID]]
			}
			CASE 'MENU_LOCK UNKN':
			CASE 'PWR_LOCK UNKN':
			CASE 'TYPE UNKN' :
			CASE 'POWER_SOURCE UNKN' :
			CASE 'RF_PWR UNKN' :
			{
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
				OFF [vdvTP_Shure, nNameSlot[cID]]
			}
		    }
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK] //This is running every half second...
{
    WAIT 300
    {
	IF (scm820Online == FALSE)
	{
	    fnStartConnection()
	    WAIT 20
	    {
		fnGetShureRep()
	    }
	}
    }
}


