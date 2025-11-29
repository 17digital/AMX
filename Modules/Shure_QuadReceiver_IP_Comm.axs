MODULE_NAME='Shure_QuadReceiver_IP_Comm' (DEV vdvDevice, DEV dvDevice, CHAR devIP[])

DEFINE_CONSTANT

CHAR MSG_END			= $0D;
CHAR MSG_FD			= $0A;

LONG TL_IPCOMM_CONNECT	= 5005; 
DATA_INITIALIZED				= 251
SHURE_PORT					= 2202;


//Mic + Line Input IDS...
IN_MIC_1					= 1
IN_MIC_2					= 2
IN_MIC_3					= 3
IN_MIC_4					= 4


DEFINE_VARIABLE

VOLATILE LONG lTlIpConnect[] = {30000}; // 30 Second Poll...
VOLATILE CHAR cShureBuffer[500];
VOLATILE CHAR sOnline;
VOLATILE CHAR sLocation[8];
VOLATILE CHAR sFirmware[20];
VOLATILE CHAR sSummMode[10];
VOLATILE CHAR sEncryption[6];
VOLATILE CHAR sModel[25];
VOLATILE INTEGER sDbug;

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartShureRXConnection()
{
    IP_CLIENT_OPEN(dvDevice.PORT, devIP, SHURE_PORT, IP_TCP);
	    SEND_COMMAND vdvDevice, "'Attempt to Start Shure Wireless Connection...'"
}
DEFINE_FUNCTION fnCloseShureRXConnection()
{
    IP_CLIENT_CLOSE (dvDevice.PORT)
	SEND_STRING 0, "'Closed Vaddio AVB Connection'"
}
DEFINE_FUNCTION char[100] GetShureIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '" ;
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
	CASE 17 : iReturn = "'Local Port Not Open'"
	
	DEFAULT : iReturn = "'(', ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION fnGetShureRXQuadRep()
{
    WAIT 10 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_1),' FREQUENCY >' "
    WAIT 20 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_2),' FREQUENCY >' "
    WAIT 30 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_3),' FREQUENCY >' "
    WAIT 40 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_4),' FREQUENCY >' "
    
    WAIT 50 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_1),' BATT_BARS >' "
    WAIT 60 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_2),' BATT_BARS >' "
    WAIT 70 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_3),' BATT_BARS >' "
    WAIT 80 SEND_STRING dvDevice, " '< GET ',ITOA(IN_MIC_4),' BATT_BARS >' "

    WAIT 90 SEND_STRING dvDevice, " '< GET FW_VER >' "
    WAIT 100 SEND_STRING dvDevice, '< GET AUDIO_SUMMING_MODE >'
    WAIT 110 SEND_STRING dvDevice, '< GET DEVICE_ID >' //Can be 1-8 Characters Long...
    WAIT 120 SEND_STRING dvDevice, '< GET ENCRYPTION >' 
    WAIT 130 SEND_STRING dvDevice, '< GET MODEL >' //Needs FW 2.4+
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvDevice, cShureBuffer;
WAIT 50 {
    TIMELINE_CREATE(TL_IPCOMM_CONNECT,lTlIpConnect,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
}


DEFINE_EVENT
DATA_EVENT [dvDevice]
{
    ONLINE :
    {
	//bIsInitialized = TRUE;
    }
    OFFLINE :
    {
	sOnline = FALSE;
    }
    ONERROR :
    {
	SEND_COMMAND vdvDevice, "'Shure Error : ',GetShureIpError(DATA.NUMBER)";
	    sOnline = FALSE;
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14 :
	    {
		fnCloseShureRXConnection();
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
	LOCAL_VAR CHAR cSum[30]
	
	//Parsing Begins....
	WHILE (FIND_STRING(cShureBuffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureBuffer,'>',1)
	    SEND_STRING vdvDevice,"'dvShure : Response: ',cResponse"
		    sOnline = TRUE;
	
	    IF (FIND_STRING (cResponse,'< REP ',1)) {
		    REMOVE_STRING (cResponse,'< REP ',1)
			cID = ATOI (LEFT_STRING(cResponse, 1)) //1 -- 4
		
		IF (FIND_STRING(cResponse, "ITOA(cID), ' FREQUENCY '",1)) {
			    REMOVE_STRING (cResponse,"ITOA(cId), ' FREQUENCY '",1)
				cFreq = cResponse;
			
			cFirstFreq = LEFT_STRING (cFreq,3);
			cLastFreq = MID_STRING (cFreq, 4, 3);
			
			SEND_COMMAND vdvDevice, "'FREQ-',ITOA(cID),':',cFirstFreq,'-',cLastFreq"	
				// Will look like this when sending...
				    // FREQ-1:555-444
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
			    SEND_COMMAND vdvDevice, "'MICSTAT-',ITOA(cId),':Not Connected'"
				OFF [vdvDevice, cID];
			}
			CASE '005' :
			CASE '004' :
			CASE '003' :
			CASE '002' :
			CASE '001' : //Actual Battery Levels...
			{
			    SEND_COMMAND vdvDevice, "'MICSTAT-',ITOA(cId),':Connected!'"
				ON [vdvDevice, cID];
			}
		    }
		}
		IF (FIND_STRING (cResponse, "ITOA(cId), ' TX_'",1))
		{
		    REMOVE_STRING (cResponse, "ITOA(cId), ' TX_'",1)
			cType = LEFT_STRING(cResponse, LENGTH_STRING(cResponse) -2)
			
		    SWITCH (cType)
		    {
			CASE 'MUTE_STATUS OFF' :
			CASE 'MENU_LOCK OFF' :
			CASE 'TYPE ULXD1' : 
			CASE 'RF_PWR LOW' :
			CASE 'MUTE_BUTTON_STATUS RELEASED' :
			{
			    SEND_COMMAND vdvDevice, "'MICSTAT-',ITOA(cId),':Connected!'"
				ON [vdvDevice, cID];
			}
			CASE 'MENU_LOCK UNKN':
			CASE 'PWR_LOCK UNKN':
			CASE 'TYPE UNKN' :
			CASE 'POWER_SOURCE UNKN' :
			CASE 'RF_PWR UNKN' :
			{
			    SEND_COMMAND vdvDevice, "'MICSTAT-',ITOA(cId),':Not Connected'"
				OFF [vdvDevice, cID];
			}
		    }
		}
		IF (FIND_STRING(cResponse, 'FW_VER {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			//SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -16);
			sFirmware = LEFT_STRING (cResponse,8) ; //Ex : 2.3.34.0
			    SEND_COMMAND vdvDevice, "'FW_VER-',sFirmware";
		}
		IF (FIND_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1))
		{
		    REMOVE_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    sSummMode = cResponse;
				SEND_COMMAND vdvDevice, "'SUMMING_MODE-',sSummMode";
			    
		    //Responses...
			//OFF -- 1+2 -- 3+4 -- 1+2/3+4 -- 1+2+3+4
		}
		IF (FIND_STRING (cResponse, 'DEVICE_ID {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			sLocation = cResponse;
			    SEND_COMMAND vdvDevice, "'DEVICE_ID-',sLocation";
		}
		IF (FIND_STRING (cResponse, 'ENCRYPTION ',1))
		{
		    REMOVE_STRING (cResponse, 'ENCRYPTION ',1)
			sEncryption = SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    
				SEND_COMMAND vdvDevice, "'ENCRYPTION-',sEncryption";
				//OFF -- AUTO -- MANUAL
		}
		IF (FIND_STRING (cResponse, 'MODEL {',1)) //Needs latest firmware...
		{
		    REMOVE_STRING (cResponse, '{',1)
		    sModel = cResponse;
			SEND_COMMAND vdvDevice, "'MODEL-',sModel";
		}
    		IF (FIND_STRING (cResponse, 'ERR',1)) //Needs latest firmware...
		{
		    sModel = "'Firmware Update Available'"
			SEND_COMMAND vdvDevice, "'MODEL-',sModel";
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT]
{   
    IF (sOnline == FALSE) {
	fnStartShureRXConnection();
    } ELSE {
	    fnGetShureRXQuadRep();
    }
}