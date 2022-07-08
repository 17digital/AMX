PROGRAM_NAME='Shure_WM_Quad'


DEFINE_DEVICE


dvShurePress =				0:4:0 //Shure WM Receiver
dvShureSuite =				0:5:0 //Shure WM Receiver 2

dvTP_ShurePressA =			10001:6:0

#IF_NOT_DEFINED dvTP_ShurePressB
dvTP_ShurePressB =			10002:6:0
#END_IF

#IF_NOT_DEFINED dvTP_ShureSuiteB
dvTP_ShureSuiteB =			10004:6:0
#END_IF

#IF_NOT_DEFINED dvTP_ShureSuiteC
dvTP_ShureSuiteC =			10005:6:0
#END_IF

#IF_NOT_DEFINED dvTP_ShureLobby
dvTP_ShureLobby =				10007:6:0
#END_IF


DEFINE_CONSTANT

RECEIVER_COUNT			= 2;

ID_PRESS					= 1;
ID_SUITE					= 2;

CHAR WM_SUITE_IP[]		= 'presidentwm.amx.ems.edu' //172.21.1.127
CHAR WM_PRESS_IP[]		= 'presswm.amx.ems.edu' //172.21.1.118

//Mic + Line Input IDS...
IN_MIC_1					= 1
IN_MIC_2					= 2
IN_MIC_3					= 3
IN_MIC_4					= 4

BTN_NET_BOOT			= 1000
BTN_POLL_WM			= 10

//TXT Addresses...
TXT_CH_1				= 311
TXT_CH_2				= 312
TXT_CH_3				= 313
TXT_CH_4				= 314

TXT_DEVICE				= 1001

(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _SHUREStruct
{
    CHAR sURL[128];
    INTEGER sPort;
    CHAR sFlag;
    CHAR sOnline;
}
STRUCTURE _MYShureWm
{
    CHAR sLocation[8]; //Is 8 Char of the device ID
    CHAR sModel[25];
    CHAR sFreq1[7]; 
    CHAR sFreq2[7];
    CHAR sFreq3[7];
    CHAR sFreq4[7];
    CHAR sFirmware[20];
    CHAR sSummMode[10];
    CHAR sEncryption[6];
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _SHUREStruct ShureIPStruct[RECEIVER_COUNT];
VOLATILE _MYShureWm ShureInfo[RECEIVER_COUNT];

VOLATILE CHAR cShurePressBuffer[100];
VOLATILE CHAR cShureSuiteBuffer[100];

VOLATILE DEV vdvTP_ShurePress[] = 
{
    dvTP_ShurePressA,
    dvTP_ShurePressB
}
VOLATILE DEV vdvTP_ShureSuite[] = 
{
    dvTP_ShureSuiteB,
    dvTP_ShureSuiteC,
    dvTP_ShureLobby
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
DEFINE_FUNCTION fnStartShurePressConnection()
{
    ShureIPStruct[ID_PRESS].sURL = WM_PRESS_IP;
    ShureIPStruct[ID_PRESS].sPort = 2202;
    ShureIPStruct[ID_PRESS].sFlag = IP_TCP;

    WAIT 20 '2 Seconds'
    {
	SEND_STRING 0, "'Start dvShurePress IP Connection...'"
	IP_CLIENT_OPEN (dvShurePress.PORT, ShureIPStruct[ID_PRESS].sURL, ShureIPStruct[ID_PRESS].sPort, ShureIPStruct[ID_PRESS].sFlag) 

	TIMED_WAIT_UNTIL (ShureIPStruct[1].sOnline == TRUE) 300 '30 Seconds'
	{
	    fnGetShurePressRep()
	}
    }
}
DEFINE_FUNCTION fnStartShureSuiteConnection()
{
    ShureIPStruct[ID_SUITE].sURL = WM_SUITE_IP;
    ShureIPStruct[ID_SUITE].sPort = 2202;
    ShureIPStruct[ID_SUITE].sFlag = IP_TCP;

    WAIT 20 '2 Seconds'
    {
	SEND_STRING 0, "'Start dvShureSuite IP Connection...'"
	    IP_CLIENT_OPEN (dvShureSuite.PORT, ShureIPStruct[ID_SUITE].sURL, ShureIPStruct[ID_SUITE].sPort, ShureIPStruct[ID_SUITE].sFlag) 

	TIMED_WAIT_UNTIL (ShureIPStruct[ID_SUITE].sOnline == TRUE) 300 '30 Seconds'
	{
	    fnGetShureSuiteRep();
	}
    }
}
DEFINE_FUNCTION fnCloseShurePressConnection()
{
    IP_CLIENT_CLOSE (dvShurePress.PORT) 
}
DEFINE_FUNCTION fnCloseShureSuiteConnection()
{
    IP_CLIENT_CLOSE (dvShureSuite.PORT) 
}
DEFINE_FUNCTION fnGetShurePressRep()
{
    WAIT 10 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_1),' FREQUENCY >' "
    WAIT 15 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_2),' FREQUENCY >' "
    WAIT 20 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_3),' FREQUENCY >' "
    WAIT 25 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_4),' FREQUENCY >' "
    
    WAIT 30 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_1),' BATT_BARS >' "
    WAIT 35 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_2),' BATT_BARS >' "
    WAIT 40 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_3),' BATT_BARS >' "
    WAIT 45 SEND_STRING dvShurePress, " '< GET ',ITOA(IN_MIC_4),' BATT_BARS >' "
    
    WAIT 50 SEND_STRING dvShurePress, '< GET FW_VER >'
    WAIT 60 SEND_STRING dvShurePress, '< GET AUDIO_SUMMING_MODE >'
    WAIT 70 SEND_STRING dvShurePress, '< GET DEVICE_ID >' //Can be 1-8 Characters Long
    WAIT 80 SEND_STRING dvShurePress, '< GET ENCRYPTION >' 
    WAIT 90 SEND_STRING dvShurePress, '< GET MODEL >' //Needs FW 2.4+
}
DEFINE_FUNCTION fnGetShureSuiteRep()
{
    WAIT 10 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_1),' FREQUENCY >' "
    WAIT 15 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_2),' FREQUENCY >' "
    WAIT 20 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_3),' FREQUENCY >' "
    WAIT 25 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_4),' FREQUENCY >' "
    
    WAIT 30 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_1),' BATT_BARS >' "
    WAIT 35 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_2),' BATT_BARS >' "
    WAIT 40 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_3),' BATT_BARS >' "
    WAIT 45 SEND_STRING dvShureSuite, " '< GET ',ITOA(IN_MIC_4),' BATT_BARS >' "
    
    WAIT 50 SEND_STRING dvShureSuite, '< GET FW_VER >'
    WAIT 60 SEND_STRING dvShureSuite, '< GET AUDIO_SUMMING_MODE >'
    WAIT 70 SEND_STRING dvShureSuite, '< GET DEVICE_ID >' // Can be 1-8 Characters Long...
    WAIT 80 SEND_STRING dvShureSuite, '< GET ENCRYPTION >' 
    WAIT 90 SEND_STRING dvShureSuite, '< GET MODEL >' // Needs FW 2.4+
}
DEFINE_FUNCTION fnShurePressReconnect()
{
    fnCloseShurePressConnection();
	WAIT 20
	{
	    fnStartShurePressConnection();
	}
}
DEFINE_FUNCTION fnShureSuiteReconnect()
{
    fnCloseShureSuiteConnection();
	WAIT 20
	{
	    fnStartShureSuiteConnection();
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


CREATE_BUFFER dvShurePress, cShurePressBuffer;
CREATE_BUFFER dvShureSuite, cShureSuiteBuffer;

WAIT 150
{
    fnStartShurePressConnection();
}
WAIT 250
{
    fnStartShureSuiteConnection();
}

DEFINE_EVENT 
DATA_EVENT [dvShurePress]
{
    ONLINE :
    {
	ShureIPStruct[ID_PRESS].sOnline = TRUE;
	    ON [vdvTP_ShurePress, BTN_NET_BOOT]
    }
    OFFLINE :
    {
	ShureIPStruct[ID_PRESS].sOnline = FALSE;
	    OFF [vdvTP_ShurePress, BTN_NET_BOOT]
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvShurePress : onerror: ',GetShureIpError(DATA.NUMBER)");
	    Send_String 0,"'dvShurePress onerror : ',GetShureIpError(DATA.NUMBER)"; 
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 17 : //Connection Time Out...
	    {
		ShureIPStruct[ID_PRESS].sOnline = FALSE;
		    fnShurePressReconnect();
	    }
	    DEFAULT :
	    {
		ShureIPStruct[ID_PRESS].sOnline = FALSE;
	    }
	}
    }
    STRING :
    {
    	STACK_VAR CHAR cResponse[100]
	STACK_VAR INTEGER cID //Holds Input ID
	STACK_VAR CHAR cFreq[6]
	STACK_VAR CHAR cBatteryLev[3]
	STACK_VAR CHAR cFirstFreq[3]
	STACK_VAR CHAR cLastFreq[3]
	STACK_VAR CHAR cType[30] //TX Type
	LOCAL_VAR CHAR cSum[30]
	
	//Parsing Begins....
	WHILE (FIND_STRING(cShurePressBuffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShurePressBuffer,'>',1)
		SEND_STRING 0,"'dvShurePress : Response: ',cResponse"
		    ShureIPStruct[ID_PRESS].sOnline = TRUE;
	
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
			
		    SEND_COMMAND vdvTP_ShurePress, "'^TXT-',ITOA(cID),',0,',cFirstFreq,'-',cLastFreq"
		    
		    SWITCH (cID)
		    {
			CASE 1 : ShureInfo[ID_PRESS].sFreq1 = "cFirstFreq,'-',cLastFreq"
			CASE 2 : ShureInfo[ID_PRESS].sFreq2 = "cFirstFreq,'-',cLastFreq"
			CASE 3 : ShureInfo[ID_PRESS].sFreq3 = "cFirstFreq,'-',cLastFreq"
			CASE 4 : ShureInfo[ID_PRESS].sFreq4 = "cFirstFreq,'-',cLastFreq"
		    }
		}
		IF (FIND_STRING (cResponse, "ITOA(cID), ' BATT_BARS '",1))
		{
		    REMOVE_STRING (cResponse,"ITOA(cId), ' BATT_BARS '",1)
		    cBatteryLev = cResponse;
		    
		    SWITCH (cBatteryLev)
		    {
			CASE '255' : //Error Code - Not communicating w/ Mic...
			{
			    //Not Connectd / Battery Level not Received...
			    SEND_COMMAND vdvTP_ShurePress, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
				OFF [vdvTP_ShurePress, nNameSlot[cID]]
			}
			CASE '005' :
			CASE '004' :
			CASE '003' :
			CASE '002' :
			CASE '001' : //Actual Battery Levels...
			{
			    SEND_COMMAND vdvTP_ShurePress, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connectd !'"
				ON [vdvTP_ShurePress, nNameSlot[cID]]
			}
		    }
		}
		IF (FIND_STRING (cResponse, "ITOA(cId), ' TX_'",1))
		{
		    REMOVE_STRING (cResponse, "ITOA(cId), ' TX_'",1)
			cType = cResponse;
			SET_LENGTH_STRING(cType,LENGTH_STRING(cType) -2);
			
		    SWITCH (cType)
		    {
			CASE 'MUTE_STATUS OFF' :
			CASE 'MENU_LOCK OFF' :
			CASE 'TYPE ULXD1' : 
			CASE 'RF_PWR LOW' :
			CASE 'MUTE_BUTTON_STATUS RELEASED' :
			{
			    SEND_COMMAND vdvTP_ShurePress, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connectd !'"
				    ON [vdvTP_ShurePress, nNameSlot[cID]]
			}
			CASE 'MENU_LOCK UNKN':
			CASE 'PWR_LOCK UNKN':
			CASE 'TYPE UNKN' :
			CASE 'POWER_SOURCE UNKN' :
			CASE 'RF_PWR UNKN' :
			{
			    SEND_COMMAND vdvTP_ShurePress, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
				    OFF [vdvTP_ShurePress, nNameSlot[cID]]
			}
		    }
		}
		IF (FIND_STRING(cResponse, 'FW_VER {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			//SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -16);
			ShureInfo[ID_PRESS].sFirmware = LEFT_STRING (cResponse,8) ; //Ex : 2.3.34.0
		}
		IF (FIND_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1))
		{
		    REMOVE_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[ID_PRESS].sSummMode = cResponse;
				cSum = "'Summing Mode = ', cResponse";
			    
		    //Responses...
			//OFF -- 1+2 -- 3+4 -- 1+2/3+4 -- 1+2+3+4
		}
		IF (FIND_STRING (cResponse, 'DEVICE_ID {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			ShureInfo[ID_PRESS].sLocation = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ENCRYPTION ',1))
		{
		    REMOVE_STRING (cResponse, 'ENCRYPTION ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[ID_PRESS].sEncryption = cResponse;
				//OFF -- AUTO -- MANUAL
		}
		IF (FIND_STRING (cResponse, 'MODEL {',1)) //Needs latest firmware...
		{
		    REMOVE_STRING (cResponse, '{',1)
		    ShureInfo[ID_PRESS].sModel = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ERR',1)) //Needs latest firmware...
		{
		    ShureInfo[ID_PRESS].sModel = "'Firmware Update Available'"
		}
	    }
	}
    }
}
DATA_EVENT [dvShureSuite]
{
    ONLINE :
    {
	ShureIPStruct[ID_SUITE].sOnline = TRUE;
    }
    OFFLINE :
    {
	ShureIPStruct[ID_SUITE].sOnline = FALSE;
    }
    STRING :
    {
    	STACK_VAR CHAR cResponse[100]
	STACK_VAR INTEGER cID //Holds Input ID
	STACK_VAR CHAR cFreq[6]
	STACK_VAR CHAR cBatteryLev[3]
	STACK_VAR CHAR cFirstFreq[3]
	STACK_VAR CHAR cLastFreq[3]
	STACK_VAR CHAR cType[30] //TX Type
	LOCAL_VAR CHAR cSum[30]
		
	WHILE (FIND_STRING(cShureSuiteBuffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureSuiteBuffer,'>',1)
		SEND_STRING 0,"'dvShureSuite : Response: ',cResponse"
		    ShureIPStruct[ID_SUITE].sOnline = TRUE;
	
	    IF (FIND_STRING (cResponse,'< REP ',1))
	    {
		REMOVE_STRING (cResponse,'< REP ',1)
		
		cID = ATOI (LEFT_STRING(cResponse, 1)) //1 -- 4
		
		IF (FIND_STRING(cResponse, "ITOA(cID), ' FREQUENCY '",1))
		{
		    REMOVE_STRING (cResponse,"ITOA(cId), ' FREQUENCY '",1)
			cFreq = cResponse;
			
		    cFirstFreq = LEFT_STRING (cFreq,3)
		    cLastFreq = MID_STRING (cFreq, 4, 3)
			
		    SEND_COMMAND vdvTP_ShureSuite, "'^TXT-',ITOA(cID),',0,',cFirstFreq,'-',cLastFreq"
			    
		    SWITCH (cID)
		    {
			CASE 1 : ShureInfo[ID_SUITE].sFreq1 = "cFirstFreq,'-',cLastFreq"
			CASE 2 : ShureInfo[ID_SUITE].sFreq2 = "cFirstFreq,'-',cLastFreq"
			CASE 3 : ShureInfo[ID_SUITE].sFreq3 = "cFirstFreq,'-',cLastFreq"
			CASE 4 : ShureInfo[ID_SUITE].sFreq4 = "cFirstFreq,'-',cLastFreq"
		    }
		}
		IF (FIND_STRING (cResponse, "ITOA(cID), ' BATT_BARS '",1))
		{
		    REMOVE_STRING (cResponse,"ITOA(cId), ' BATT_BARS '",1)
		    cBatteryLev = cResponse;
		    
		    SWITCH (cBatteryLev)
		    {
			CASE '255' : //Error Code - Not communicating w/ Mic...
			{
			    //Not Connectd / Battery Level not Received...
			    SEND_COMMAND vdvTP_ShureSuite, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Not Connected'"
				OFF [vdvTP_ShureSuite, nNameSlot2[cID]]
			}
			CASE '005' :
			CASE '004' :
			CASE '003' :
			CASE '002' :
			CASE '001' : //Actual Battery Levels...
			{
			    SEND_COMMAND vdvTP_ShureSuite, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Connectd !'"
				ON [vdvTP_ShureSuite, nNameSlot2[cID]]
			}
		    }
		}
		IF (FIND_STRING (cResponse, "ITOA(cId), ' TX_'",1))
		{
		    REMOVE_STRING (cResponse, "ITOA(cId), ' TX_'",1)
			cType = cResponse;
			SET_LENGTH_STRING(cType,LENGTH_STRING(cType) -2);
			
		    SWITCH (cType)
		    {
			CASE 'MUTE_STATUS OFF' :
			CASE 'MENU_LOCK OFF' :
			CASE 'TYPE ULXD1' : 
			CASE 'RF_PWR LOW' :
			CASE 'MUTE_BUTTON_STATUS RELEASED' :
			{
			    SEND_COMMAND vdvTP_ShureSuite, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Connectd !'"
				    ON [vdvTP_ShureSuite, nNameSlot2[cID]]
			}
			CASE 'MENU_LOCK UNKN':
			CASE 'PWR_LOCK UNKN':
			CASE 'TYPE UNKN' :
			CASE 'POWER_SOURCE UNKN' :
			CASE 'RF_PWR UNKN' :
			{
			    SEND_COMMAND vdvTP_ShureSuite, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Not Connected'"
				    OFF [vdvTP_ShureSuite, nNameSlot2[cID]]
			}
		    }
		}
		IF (FIND_STRING(cResponse, 'FW_VER {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			//SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -16);
			ShureInfo[ID_SUITE].sFirmware = LEFT_STRING (cResponse,8) ; //Ex : 2.3.34.0
		}
		IF (FIND_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1))
		{
		    REMOVE_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[ID_SUITE].sSummMode = cResponse;
				cSum = "'Summing Mode = ', cResponse";
			    
		    //Responses...
			//OFF -- 1+2 -- 3+4 -- 1+2/3+4 -- 1+2+3+4
		}
		IF (FIND_STRING (cResponse, 'DEVICE_ID {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			ShureInfo[ID_SUITE].sLocation = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ENCRYPTION ',1))
		{
		    REMOVE_STRING (cResponse, 'ENCRYPTION ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[ID_SUITE].sEncryption = cResponse;
				//OFF -- AUTO -- MANUAL
		}
		IF (FIND_STRING (cResponse, 'MODEL {',1)) //Needs latest firmware...
		{
		    REMOVE_STRING (cResponse, '{',1)
		    ShureInfo[ID_SUITE].sModel = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ERR',1)) //Needs latest firmware...
		{
		    ShureInfo[ID_SUITE].sModel = "'Firmware Update Available'"
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 350
    {
	IF (ShureIPStruct[ID_PRESS].sOnline == FALSE)
	{
	    fnShurePressReconnect();
	}
	ELSE
	{
	    fnGetShurePressRep()
	}
    }
    WAIT 450
    {
	IF (ShureIPStruct[ID_SUITE].sOnline == FALSE)
	{
	    fnShureSuiteReconnect();
	}
	ELSE
	{
	    fnGetShureSuiteRep();
	}
    }
}
