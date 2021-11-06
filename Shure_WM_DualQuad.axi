PROGRAM_NAME='Shure_WM_Quad'



DEFINE_DEVICE


dvShure =				0:4:0 //Shure WM Receiver
dvShure2 =				0:5:0 //Shure WM Receiver 2

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
IN_MIC_5				= 1
IN_MIC_6				= 2
IN_MIC_7				= 3
IN_MIC_8				= 4

BTN_NET_BOOT		= 1000
BTN_POLL_WM		= 10

//TXT Addresses...
TXT_CH_1				= 311
TXT_CH_2				= 312
TXT_CH_3				= 313
TXT_CH_4				= 314
TXT_CH_5				= 315
TXT_CH_6				= 316
TXT_CH_7				= 317
TXT_CH_8				= 318
TXT_DEVICE				= 1001

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR shureIP[15]= '172.21.0.96' //cob100wm1
CHAR shureIP2[15] = '172.21.0.97' //cob100wm2

LONG SCM820_Port= 2202 //Port Shure uses!
VOLATILE INTEGER scm820Online
VOLATILE INTEGER scmShureWm2Online
VOLATILE INTEGER lBooted

VOLATILE CHAR cShureBuffer[500]
VOLATILE CHAR cShureBuffer2[500]

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
VOLATILE INTEGER nNameSlot2[] =
{
    TXT_CH_5,
    TXT_CH_6,
    TXT_CH_7,
    TXT_CH_8
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnStartShureConnection()
{
    IP_CLIENT_OPEN(dvShure.PORT,shureIP,SCM820_Port,1) //#1 is for TCP/IP connection
    WAIT 10 
    {
	 IP_CLIENT_OPEN(dvShure2.PORT,shureIP2,SCM820_Port,1) //#1 is for TCP/IP connection
    }
}
DEFINE_FUNCTION fnCloseShureConnection()
{
    IP_CLIENT_CLOSE(dvShure.PORT) 
	IP_CLIENT_CLOSE(dvShure2.PORT) 
}
DEFINE_FUNCTION fnGetShureRep()
{
    WAIT 10 SEND_STRING dvShure, '< GET 1 FREQUENCY >'
    WAIT 15 SEND_STRING dvShure, '< GET 2 FREQUENCY >'
    WAIT 20 SEND_STRING dvShure, '< GET 3 FREQUENCY >'
    WAIT 25 SEND_STRING dvShure, '< GET 4 FREQUENCY >'
    
    WAIT 30 SEND_STRING dvShure, '< GET 1 BATT_BARS >'
    WAIT 35 SEND_STRING dvShure, '< GET 2 BATT_BARS >'
    WAIT 40 SEND_STRING dvShure, '< GET 3 BATT_BARS >'
    WAIT 45 SEND_STRING dvShure, '< GET 4 BATT_BARS >'
    
    WAIT 50 SEND_STRING dvShure2, '< GET 1 FREQUENCY >'
    WAIT 55 SEND_STRING dvShure2, '< GET 2 FREQUENCY >'
    WAIT 60 SEND_STRING dvShure2, '< GET 3 FREQUENCY >'
    WAIT 65 SEND_STRING dvShure2, '< GET 4 FREQUENCY >'
    
    WAIT 70 SEND_STRING dvShure2, '< GET 1 BATT_BARS >'
    WAIT 75 SEND_STRING dvShure2, '< GET 2 BATT_BARS >'
    WAIT 80 SEND_STRING dvShure2, '< GET 3 BATT_BARS >'
    WAIT 85 SEND_STRING dvShure2, '< GET 4 BATT_BARS >'
}
DEFINE_FUNCTION fnShureReconnect()
{
    fnCloseShureConnection()
	WAIT 20
	{
	    fnStartShureConnection()
	    WAIT 30 fnGetShureRep()
	}
}
DEFINE_FUNCTION char[100] GetShureIpError (LONG iErrorCode)
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
CREATE_BUFFER dvShure2, cShureBuffer2;


WAIT 600
{
    OFF [lBooted]
}

DEFINE_EVENT 
BUTTON_EVENT [vdvTP_Shure, BTN_POLL_WM]
{
    PUSH :
    {
	IF ((scm820Online == TRUE) OR (scmShureWm2Online ==TRUE))
	{
	    fnGetShureRep()
	}
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
	AMX_LOG (AMX_ERROR, "'dvShure : onerror: ',GetShureIpError(DATA.NUMBER)");
	Send_String 0,"'Shure onerror : ',GetShureIpError(DATA.NUMBER)"; 
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 17 : //Connection Time Out...
	    {
		scm820Online = FALSE;
		    fnShureReconnect()
	    }
	    DEFAULT :
	    {
		scm820Online = FALSE;
	    }
	}
    }
    STRING :
    {
    	STACK_VAR CHAR cResponse[100]
	STACK_VAR INTEGER cID //Holds Input ID
	LOCAL_VAR CHAR cFreq[6]
	LOCAL_VAR CHAR cBatteryLev[3]
	LOCAL_VAR CHAR cFirstFreq[3]
	LOCAL_VAR CHAR cLastFreq[3]
	STACK_VAR CHAR cType[30] //TX Type
	LOCAL_VAR CHAR cDbug[30]
	
	scm820Online = TRUE;
	    ON [vdvTP_Shure, BTN_NET_BOOT]
	
	AMX_LOG (AMX_INFO, "'dvShure : STRING: ',cShureBuffer"); //Store Log withing AMX Master- See Notes Above!
		
	//Parsing Begins....
	WHILE (FIND_STRING(cShureBuffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureBuffer,'>',1)
	    SEND_STRING 0,"'ShureULX-D : Response: ',cResponse"
	
	    IF (FIND_STRING (cResponse,'< REP ',1))
	    {
		REMOVE_STRING (cResponse,'< REP ',1)
		
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
}
DATA_EVENT [dvShure2]
{
    ONLINE :
    {
	scmShureWm2Online = TRUE;
    }
    OFFLINE :
    {
	scmShureWm2Online = FALSE;
    }
    STRING :
    {
    	STACK_VAR CHAR cResponse[100]
	STACK_VAR INTEGER cID //Holds Input ID
	LOCAL_VAR CHAR cFreq[6]
	LOCAL_VAR CHAR cBatteryLev[3]
	LOCAL_VAR CHAR cFirstFreq[3]
	LOCAL_VAR CHAR cLastFreq[3]
	STACK_VAR CHAR cType[30] //TX Type
	LOCAL_VAR CHAR cDbug[30]
	
	scmShureWm2Online = TRUE;

		AMX_LOG (AMX_INFO, "'dvShure2 : STRING: ',cShureBuffer2"); //Store Log withing AMX Master- See Notes Above!
	//SEND_STRING 0,"'ShureULX-D2 : Response: ',cShureBuffer2"
	
	//Parsing Begins....
	
	WHILE (FIND_STRING(cShureBuffer2,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureBuffer2,'>',1)
		SEND_STRING 0,"'dvShure2 : Response: ',cResponse"
	
	    IF (FIND_STRING (cResponse,'< REP ',1))
	    {
		REMOVE_STRING (cResponse,'< REP ',1)
		
		cID = ATOI (LEFT_STRING(cResponse, 1)) //1 -- 4
		
		IF (FIND_STRING(cResponse, "ITOA(cID), ' FREQUENCY '",1))
		{
		    REMOVE_STRING (cResponse,"ITOA(cId), ' FREQUENCY '",1)
			cFreq = cResponse
			
			cFirstFreq = LEFT_STRING (cFreq,3)
			cLastFreq = MID_STRING (cFreq, 4, 3)
			
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(cID +4),',0,',cFirstFreq,'-',cLastFreq"
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
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Not Connected'"
				OFF [vdvTP_Shure, nNameSlot2[cID]]
			}
			CASE '005' :
			CASE '004' :
			CASE '003' :
			CASE '002' :
			CASE '001' : //Actual Battery Levels...
			{
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Connectd !'"
				ON [vdvTP_Shure, nNameSlot2[cID]]
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
				SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Connectd !'"
				    ON [vdvTP_Shure, nNameSlot2[cID]]
			    }
			    CASE 'MENU_LOCK UNKN':
			    CASE 'PWR_LOCK UNKN':
			    CASE 'TYPE UNKN' :
			    CASE 'POWER_SOURCE UNKN' :
			    CASE 'RF_PWR UNKN' :
			    {
				SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Not Connected'"
				    OFF [vdvTP_Shure, nNameSlot2[cID]]
			    }
			}
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 350
    {
	IF ((scm820Online == FALSE) OR (scmShureWm2Online ==FALSE))
	{
	    fnStartShureConnection()
	    WAIT 20
	    {
		fnGetShureRep()
	    }
	}
	ELSE
	{
	    SEND_STRING dvShure, '< GET AUDIO_SUMMING_MODE >'
	    WAIT 10 SEND_STRING dvShure2, '< GET AUDIO_SUMMING_MODE >'
	}
    }
}