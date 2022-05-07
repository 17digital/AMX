PROGRAM_NAME='Shure_WM_Quad'


DEFINE_DEVICE

#IF_NOT_DEFINED dvShureWm1
dvShureWm1 =				0:6:0 //Shure WM Receiver
#END_IF

#IF_NOT_DEFINED dvShureWm2
dvShureWm2 =				0:7:0 //Shure WM Receiver 2
#END_IF

dvTP_ShureWM =				10001:6:0

#IF_NOT_DEFINED dvTP_ShureWM2
dvTP_ShureWM2 =			10002:6:0
#END_IF


DEFINE_CONSTANT

RECEIVER_COUNT		= 2;


//Mic + Line Input IDS...
IN_MIC_1				= 1
IN_MIC_2				= 2
IN_MIC_3				= 3
IN_MIC_4				= 4

BTN_NET_BOOT		= 1000
BTN_WM_POLL		= 10

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


VOLATILE INTEGER lBooted

VOLATILE CHAR cShureWm1Buffer[100];
VOLATILE CHAR cShureWm2Buffer[100];

VOLATILE DEV vdvTP_ShureWM[] = 
{
    dvTP_ShureWM,
    dvTP_ShureWM2
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
DEFINE_FUNCTION fnStartShureWm1Connection()
{
    IP_CLIENT_OPEN (dvShureWm1.PORT,ShureIPStruct[1].sURL, ShureIPStruct[1].sPort, ShureIPStruct[1].sFlag) 

    TIMED_WAIT_UNTIL (ShureIPStruct[1].sOnline == TRUE) 300 '30 Seconds'
    {
	fnGetShureWm1Rep()
    }
}
DEFINE_FUNCTION fnStartShureWm2Connection()
{
    IP_CLIENT_OPEN(dvShureWm2.PORT,ShureIPStruct[2].sURL, ShureIPStruct[1].sPort, ShureIPStruct[1].sFlag) 

    TIMED_WAIT_UNTIL (ShureIPStruct[2].sOnline == TRUE) 300 '30 Seconds'
    {
	fnGetShureWm2Rep()
    }
}
DEFINE_FUNCTION fnCloseShureWm1Connection()
{
    IP_CLIENT_CLOSE(dvShureWm1.PORT) 
}
DEFINE_FUNCTION fnCloseShureWm2Connection()
{
    IP_CLIENT_CLOSE(dvShureWm2.PORT) 
}
DEFINE_FUNCTION fnGetShureWm1Rep()
{
    WAIT 10 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_1),' FREQUENCY >' "
    WAIT 15 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_2),' FREQUENCY >' "
    WAIT 20 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_3),' FREQUENCY >' "
    WAIT 25 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_4),' FREQUENCY >' "
    
    WAIT 30 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_1),' BATT_BARS >' "
    WAIT 35 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_2),' BATT_BARS >' "
    WAIT 40 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_3),' BATT_BARS >' "
    WAIT 45 SEND_STRING dvShureWm1, " '< GET ',ITOA(IN_MIC_4),' BATT_BARS >' "
    
    WAIT 50 SEND_STRING dvShureWm1, " '< GET FW_VER >' "
    WAIT 60 SEND_STRING dvShureWm1, '< GET AUDIO_SUMMING_MODE >'
    WAIT 70 SEND_STRING dvShureWm1, '< GET DEVICE_ID >' //Can be 1-8 Characters Long...
    WAIT 80 SEND_STRING dvShureWm1, '< GET ENCRYPTION >' 
    WAIT 90 SEND_STRING dvShureWm1, '< GET MODEL >' //Needs FW 2.4+
}
DEFINE_FUNCTION fnGetShureWm2Rep()
{    
    WAIT 10 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_1),' FREQUENCY >' "
    WAIT 15 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_2),' FREQUENCY >' "
    WAIT 20 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_3),' FREQUENCY >' "
    WAIT 25 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_4),' FREQUENCY >' "
    
    WAIT 30 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_1),' BATT_BARS >' "
    WAIT 35 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_2),' BATT_BARS >' "
    WAIT 40 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_3),' BATT_BARS >' "
    WAIT 45 SEND_STRING dvShureWm2, " '< GET ',ITOA(IN_MIC_4),' BATT_BARS >' "

    WAIT 50 SEND_STRING dvShureWm2, " '< GET FW_VER >' "
    WAIT 60 SEND_STRING dvShureWm2, '< GET AUDIO_SUMMING_MODE >'
    WAIT 70 SEND_STRING dvShureWm2, '< GET DEVICE_ID >' //Can be 1-8 Characters Long...
    WAIT 80 SEND_STRING dvShureWm2, '< GET ENCRYPTION >' 
    WAIT 90 SEND_STRING dvShureWm2, '< GET MODEL >' //Needs FW 2.4+
}
DEFINE_FUNCTION fnShureWm1Reconnect()
{
    fnCloseShureWm1Connection()
	WAIT 20
	{
	    fnStartShureWm1Connection()
	}
}
DEFINE_FUNCTION fnShureWm2Reconnect()
{
    fnCloseShureWm2Connection()
	WAIT 20
	{
	    fnStartShureWm2Connection()
	}
}
DEFINE_FUNCTION char[100] GetShureWmIpError (LONG iErrorCode)
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


ShureIPStruct[1].sURL = 'arch123wm.amx.gatech.edu' //172.21.2.8
ShureIPStruct[2].sURL = 'arch123wm2.amx.gatech.edu' //172.21.2.9

ShureIPStruct[1].sPort = 2202;
ShureIPStruct[1].sFlag = IP_TCP;

CREATE_BUFFER dvShureWm1, cShureWm1Buffer;
CREATE_BUFFER dvShureWm2, cShureWm2Buffer;

WAIT 80 '8 Seconds'
{
    fnStartShureWm1Connection();
}
WAIT 100 '10 Seconds'
{
    fnStartShureWm2Connection();
}

DEFINE_EVENT 
DATA_EVENT [dvShureWm1]
{
    ONLINE :
    {
	ShureIPStruct[1].sOnline = TRUE;
	    ON [vdvTP_ShureWM, BTN_NET_BOOT]
    }
    OFFLINE :
    {
	ShureIPStruct[1].sOnline = FALSE;
	    OFF [vdvTP_ShureWM, BTN_NET_BOOT]
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvShureWm1 : onerror: ',GetShureWmIpError(DATA.NUMBER)");
	Send_String 0,"'Shure onerror : ',GetShureWmIpError(DATA.NUMBER)"; 
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 : //Connection Time Out...
	    {
		ShureIPStruct[1].sOnline = FALSE;
		    fnShureWm1Reconnect()
	    }
	    DEFAULT :
	    {
		ShureIPStruct[1].sOnline = FALSE;
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
	
	ShureIPStruct[1].sOnline = TRUE;
	    ON [vdvTP_ShureWM, BTN_NET_BOOT]
	
	SEND_STRING 0, "'dvShureWm1 : STRING : ',cShureWm1Buffer";
	
	//Parsing Begins....
	WHILE (FIND_STRING(cShureWm1Buffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureWm1Buffer,'>',1)
	
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
			
		    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(cID),',0,',cFirstFreq,'-',cLastFreq"
		    
		    SWITCH (cID)
		    {
			CASE 1 :
			{
			    ShureInfo[1].sFreq1 = "cFirstFreq,'-',cLastFreq"
			}
			CASE 2 : 
			{
			    ShureInfo[1].sFreq2 = "cFirstFreq,'-',cLastFreq"
			}
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
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
				OFF [vdvTP_ShureWM, nNameSlot[cID]]
			}
			CASE '005' :
			CASE '004' :
			CASE '003' :
			CASE '002' :
			CASE '001' : //Actual Battery Levels...
			{
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connected !'"
				ON [vdvTP_ShureWM, nNameSlot[cID]]
			}
		    }
		}
		IF (FIND_STRING (cResponse, "ITOA(cId), ' TX_'",1))
		{
		    REMOVE_STRING (cResponse, "ITOA(cId), ' TX_'",1)
			cType = cResponse
			SET_LENGTH_STRING(cType,LENGTH_STRING(cType) -2);
			
		    SWITCH (cType)
		    {
			CASE 'MUTE_STATUS OFF' :
			CASE 'MENU_LOCK OFF' :
			CASE 'TYPE ULXD1' : 
			CASE 'RF_PWR LOW' :
			CASE 'MUTE_BUTTON_STATUS RELEASED' :
			{
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connectd !'"
				ON [vdvTP_ShureWM, nNameSlot[cID]]
			}
			CASE 'MENU_LOCK UNKN':
			CASE 'PWR_LOCK UNKN':
			CASE 'TYPE UNKN' :
			CASE 'POWER_SOURCE UNKN' :
			CASE 'RF_PWR UNKN' :
			{
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
				OFF [vdvTP_ShureWM, nNameSlot[cID]]
			}
		    }
		}
		IF (FIND_STRING(cResponse, 'FW_VER {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			//SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -16);
			ShureInfo[1].sFirmware = LEFT_STRING (cResponse,8) ; //Ex : 2.3.34.0
		}
		IF (FIND_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1))
		{
		    REMOVE_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[1].sSummMode = cResponse;
				cSum = "'Summing Mode = ', cResponse";
			    
		    //Responses...
			//OFF -- 1+2 -- 3+4 -- 1+2/3+4 -- 1+2+3+4
		}
		IF (FIND_STRING (cResponse, 'DEVICE_ID {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			ShureInfo[1].sLocation = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ENCRYPTION ',1))
		{
		    REMOVE_STRING (cResponse, 'ENCRYPTION ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[1].sEncryption = cResponse;
				//OFF -- AUTO -- MANUAL
		}
		IF (FIND_STRING (cResponse, 'MODEL {',1)) //Needs latest firmware...
		{
		    REMOVE_STRING (cResponse, '{',1)
		    ShureInfo[1].sModel = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ERR',1)) //Needs latest firmware...
		{
		    ShureInfo[1].sModel = "'Firmware Update Available'"
		}
	    }
	}
    }
}
DATA_EVENT [dvShureWm2]
{
    ONLINE :
    {
	ShureIPStruct[2].sOnline = TRUE;
    }
    OFFLINE :
    {
	ShureIPStruct[2].sOnline = FALSE;
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvShureWm2 : onerror: ',GetShureWmIpError(DATA.NUMBER)");
	Send_String 0,"'Shure onerror : ',GetShureWmIpError(DATA.NUMBER)"; 
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 17 : //Connection Time Out...
	    {
		ShureIPStruct[2].sOnline = FALSE;
		    fnShureWm2Reconnect()
	    }
	    DEFAULT :
	    {
		ShureIPStruct[2].sOnline = FALSE;
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
	
	ShureIPStruct[2].sOnline = TRUE;

		//AMX_LOG (AMX_INFO, "'dvShureWm2 : STRING: ',cShureWmBuffer2"); //Store Log withing AMX Master- See Notes Above!
	SEND_STRING 0,"'dvShureWm2 : Response: ',cShureWm2Buffer"
	
	//Parsing Begins....
	
	WHILE (FIND_STRING(cShureWm2Buffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureWm2Buffer,'>',1)
	
	    IF (FIND_STRING (cResponse,'< REP ',1))
	    {
		REMOVE_STRING (cResponse,'< REP ',1)
		
		cID = ATOI (LEFT_STRING(cResponse, 1)) //1 -- 4
		
		IF (FIND_STRING(cResponse, "ITOA(cID), ' FREQUENCY '",1))
		{
		    REMOVE_STRING (cResponse,"ITOA(cID), ' FREQUENCY '",1)
			cFreq = cResponse;
			
			cFirstFreq = LEFT_STRING (cFreq,3)
			cLastFreq = MID_STRING (cFreq, 4, 3)
			
		    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(cID +4),',0,',cFirstFreq,'-',cLastFreq"
			    
		    SWITCH (cID)
		    {
			CASE 1 :
			{
			    ShureInfo[2].sFreq1 = "cFirstFreq,'-',cLastFreq"
			}
			CASE 2 : 
			{
			    ShureInfo[2].sFreq2 = "cFirstFreq,'-',cLastFreq"
			}
		    }
		}
		IF (FIND_STRING (cResponse, "ITOA(cID), ' BATT_BARS '",1))
		{
		    REMOVE_STRING (cResponse,"ITOA(cID), ' BATT_BARS '",1)
		    cBatteryLev = cResponse;
		    
		    SWITCH (cBatteryLev)
		    {
			CASE '255' : //Error Code - Not communicating w/ Mic...
			{
			    //Not Connectd / Battery Level not Received...
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot2[cID]),',0,Not Connected'"
				OFF [vdvTP_ShureWM, nNameSlot2[cID]]
			}
			CASE '005' :
			CASE '004' :
			CASE '003' :
			CASE '002' :
			CASE '001' : //Actual Battery Levels...
			{
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot2[cID]),',0,Connectd !'"
				ON [vdvTP_ShureWM, nNameSlot2[cID]]
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
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Connectd !'"
				    ON [vdvTP_ShureWM, nNameSlot2[cID]]
			}
			CASE 'MENU_LOCK UNKN':
			CASE 'PWR_LOCK UNKN':
			CASE 'TYPE UNKN' :
			CASE 'POWER_SOURCE UNKN' :
			CASE 'RF_PWR UNKN' :
			{
			    SEND_COMMAND vdvTP_ShureWM, "'^TXT-',ITOA(nNameSlot2[cId]),',0,Not Connected'"
				    OFF [vdvTP_ShureWM, nNameSlot2[cID]]
			}
		    }
		}
		IF (FIND_STRING(cResponse, 'FW_VER {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			//SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -16);
			ShureInfo[2].sFirmware = LEFT_STRING (cResponse,8) ; //Ex : 2.3.34.0
		}
		IF (FIND_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1))
		{
		    REMOVE_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[2].sSummMode = cResponse;
				cSum = "'Summing Mode = ', cResponse";
			    
		    //Responses...
			//OFF -- 1+2 -- 3+4 -- 1+2/3+4 -- 1+2+3+4
		}
		IF (FIND_STRING (cResponse, 'DEVICE_ID {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			ShureInfo[2].sLocation = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ENCRYPTION ',1))
		{
		    REMOVE_STRING (cResponse, 'ENCRYPTION ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo[2].sEncryption = cResponse;
				//OFF -- AUTO -- MANUAL
		}
		IF (FIND_STRING (cResponse, 'MODEL {',1)) //Needs latest firmware...
		{
		    REMOVE_STRING (cResponse, '{',1)
		    ShureInfo[2].sModel = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ERR',1)) //Needs latest firmware...
		{
		    ShureInfo[2].sModel = "'Firmware Update Available'"
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 350
    {
	IF (ShureIPStruct[1].sOnline == FALSE)
	{
	    fnShureWm1Reconnect()
	}
	ELSE
	{
	    fnGetShureWm1Rep()
	}
    }
    WAIT 450
    {
    	//
	IF (ShureIPStruct[2].sOnline == FALSE)
	{
	    fnShureWm2Reconnect()
	}
	ELSE
	{
	    fnGetShureWm2Rep()
	}
    }
}
