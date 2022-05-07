PROGRAM_NAME='Shure_WM_Quad'

DEFINE_DEVICE

#IF_NOT_DEFINED dvShure
dvShure =				0:4:0 //Shure WM Receiver
#END_IF

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
BTN_POLL_WM		= 10

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
    CHAR sFirmware[20];
    CHAR sSummMode[10];
    CHAR sEncryption[6];
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _SHUREStruct ShureStruct;
VOLATILE _MYShureWm ShureInfo;

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
DEFINE_FUNCTION fnStartShureConnection()
{
    SEND_STRING 0, "'Attempt to Start Shure Wireless Connection...'"
    
    IP_CLIENT_OPEN(dvShure.PORT,ShureStruct.sURL, ShureStruct.sPort, ShureStruct.sFlag) 
    
    	    TIMED_WAIT_UNTIL (ShureStruct.sOnline == TRUE) 300 '30 Seconds'
	    {
		fnGetShureRep()
	    }
}
DEFINE_FUNCTION fnCloseShureConnection()
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
    
        WAIT 90 SEND_STRING dvShure, " '< GET FW_VER >' "
    WAIT 100 SEND_STRING dvShure, '< GET AUDIO_SUMMING_MODE >'
    WAIT 110 SEND_STRING dvShure, '< GET DEVICE_ID >' //Can be 1-8 Characters Long...
    WAIT 120 SEND_STRING dvShure, '< GET ENCRYPTION >' 
    WAIT 130 SEND_STRING dvShure, '< GET MODEL >' //Needs FW 2.4+
}
DEFINE_FUNCTION fnShureReconnect()
{
    fnCloseShureConnection()
	WAIT 20
	{
	    fnStartShureConnection()
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

ShureStruct.sURL = 'alballroomwm.amx.gatech.edu' //172.21.2.196
ShureStruct.sPort = 2202;
ShureStruct.sFlag = IP_TCP;


CREATE_BUFFER dvShure, cShureBuffer;


WAIT 600
{
    OFF [lBooted]
}

DEFINE_EVENT 
BUTTON_EVENT [vdvTP_Shure, BTN_POLL_WM]
{
    RELEASE :
    {
	fnGetShureRep()
    }
}
DATA_EVENT [dvShure]
{
    ONLINE :
    {
	ShureStruct.sOnline = TRUE;
	    ON [vdvTP_Shure, BTN_NET_BOOT]
    }
    OFFLINE :
    {
	ShureStruct.sOnline = FALSE;
	    OFF [vdvTP_Shure, BTN_NET_BOOT]
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvShure : onerror: ',GetShureIpError(DATA.NUMBER)");
	Send_String 0,"'Shure onerror : ',GetShureIpError(DATA.NUMBER)"; 
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 : //Connection Time Out...
	    {
		ShureStruct.sOnline = FALSE;
		    fnShureReconnect();
	    }
	    DEFAULT :
	    {
		ShureStruct.sOnline = FALSE;
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
	
	ShureStruct.sOnline = TRUE;
	    ON [vdvTP_Shure, BTN_NET_BOOT]
	
	SEND_STRING 0,"'From Shure WM : ',cShureBuffer"
	
	//Parsing Begins....
	WHILE (FIND_STRING(cShureBuffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureBuffer,'>',1)
	
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
			    
    		    SWITCH (cID)
		    {
			CASE 1 :
			{
			    ShureInfo.sFreq1 = "cFirstFreq,'-',cLastFreq"
			}
			CASE 2 : 
			{
			    ShureInfo.sFreq2 = "cFirstFreq,'-',cLastFreq"
			}
		    }
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
		IF (FIND_STRING(cResponse, 'FW_VER {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			//SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -16);
			ShureInfo.sFirmware = LEFT_STRING (cResponse,8) ; //Ex : 2.3.34.0
		}
		IF (FIND_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1))
		{
		    REMOVE_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo.sSummMode = cResponse;
				cSum = "'Summing Mode = ', cResponse";
			    
		    //Responses...
			//OFF -- 1+2 -- 3+4 -- 1+2/3+4 -- 1+2+3+4
		}
		IF (FIND_STRING (cResponse, 'DEVICE_ID {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			ShureInfo.sLocation = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ENCRYPTION ',1))
		{
		    REMOVE_STRING (cResponse, 'ENCRYPTION ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureInfo.sEncryption = cResponse;
				//OFF -- AUTO -- MANUAL
		}
		IF (FIND_STRING (cResponse, 'MODEL {',1)) //Needs latest firmware...
		{
		    REMOVE_STRING (cResponse, '{',1)
		    ShureInfo.sModel = cResponse;
		}
    		IF (FIND_STRING (cResponse, 'ERR',1)) //Needs latest firmware...
		{
		    ShureInfo.sModel = "'Firmware Update Available'"
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 300
    {
	IF (ShureStruct.sOnline == FALSE)
	{
	    fnShureReconnect()
	}
	ELSE
	{
	    fnGetShureRep()
	}
    }
}
