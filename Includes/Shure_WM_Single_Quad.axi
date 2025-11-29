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


CHAR WM_IP_HOST[] =		'na-gymwm.amx.gatech.edu'
WM_COUNT				= 4;

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
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _MYShureWm
{
    INTEGER sConnected;
    CHAR sFreq[7];
}
STRUCTURE _SHUREStruct
{
    CHAR sURL[128];
    INTEGER sPort;
    CHAR sFlag;
    INTEGER sOnline;
    CHAR sLocation[8]; //Is 8 Char of the device ID
    CHAR sModel[25];
    CHAR sFirmware[20];
    CHAR sSummMode[10];
    CHAR sEncryption[6];
    _MYShureWm WMic[WM_COUNT];
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _SHUREStruct ShureReceiver;
VOLATILE CHAR cShureBuffer[500];

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
DEFINE_FUNCTION fnStartShureRXConnection(DEV cDev)
{
    ShureReceiver.sURL = WM_IP_HOST;
    ShureReceiver.sPort = 2202;
    ShureReceiver.sFlag = IP_TCP;

    WAIT 10 {
	SEND_STRING vdvShure, "'Start dvShure : IP Connection...'"
	    IP_CLIENT_OPEN (cDev.PORT, ShureReceiver.sURL, ShureReceiver.sPort, ShureReceiver.sFlag); 
    }
}
DEFINE_FUNCTION fnCloseShureRXConnection(DEV cDev)
{
    IP_CLIENT_CLOSE(cDev.PORT) 
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
DEFINE_FUNCTION fnGetShureRXQuadRep(DEV cDev)
{
    WAIT 10 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_1),' FREQUENCY >' "
    WAIT 20 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_2),' FREQUENCY >' "
    WAIT 30 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_3),' FREQUENCY >' "
    WAIT 40 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_4),' FREQUENCY >' "
    
    WAIT 50 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_1),' BATT_BARS >' "
    WAIT 60 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_2),' BATT_BARS >' "
    WAIT 70 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_3),' BATT_BARS >' "
    WAIT 80 SEND_STRING cDev, " '< GET ',ITOA(IN_MIC_4),' BATT_BARS >' "

    WAIT 90 SEND_STRING cDev, " '< GET FW_VER >' "
    WAIT 100 SEND_STRING cDev, '< GET AUDIO_SUMMING_MODE >'
    WAIT 110 SEND_STRING cDev, '< GET DEVICE_ID >' //Can be 1-8 Characters Long...
    WAIT 120 SEND_STRING cDev, '< GET ENCRYPTION >' 
    WAIT 130 SEND_STRING cDev, '< GET MODEL >' //Needs FW 2.4+
}



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


CREATE_BUFFER dvShure, cShureBuffer;


DEFINE_EVENT 
DATA_EVENT [dvShure]
{
    ONLINE :
    {
	ShureReceiver.sOnline = TRUE;
    }
    OFFLINE :
    {
	ShureReceiver.sOnline = FALSE;
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvShure:onerror: ',GetShureIpError(DATA.NUMBER)");
	Send_String vdvShure,"'Shure onerror : ',GetShureIpError(DATA.NUMBER)"; 
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14 : //Connection Time Out...
	    {
		fnCloseShureRXConnection(dvShure);
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
	WHILE (FIND_STRING(cShureBuffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureBuffer,'>',1)
		SEND_STRING vdvShure, "'Shure Wm : ',cResponse"
	    
		    ShureReceiver.sOnline = TRUE;
	
	    IF (FIND_STRING (cResponse,'< REP ',1)) {
		    REMOVE_STRING (cResponse,'< REP ',1)
			cID = ATOI (LEFT_STRING(cResponse, 1)) //1 -- 4
		
		IF (FIND_STRING(cResponse, "ITOA(cID), ' FREQUENCY '",1)) {
			    REMOVE_STRING (cResponse,"ITOA(cId), ' FREQUENCY '",1)
				cFreq = cResponse;
			
			cFirstFreq = LEFT_STRING (cFreq,3);
			cLastFreq = MID_STRING (cFreq, 4, 3);
			
			ShureReceiver.WMic[cID].sFreq = "cFirstFreq,'-',cLastFreq"
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(cID),',0,',ShureReceiver.WMic[cID].sFreq"
			
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
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
				OFF [vdvTP_Shure, nNameSlot[cID]]
				    ShureReceiver.WMic[cID].sConnected = FALSE;
			}
			CASE '005' :
			CASE '004' :
			CASE '003' :
			CASE '002' :
			CASE '001' : //Actual Battery Levels...
			{
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connected!'"
				ON [vdvTP_Shure, nNameSlot[cID]]
				    ShureReceiver.WMic[cID].sConnected = TRUE;
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
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Connected!'"
				ON [vdvTP_Shure, nNameSlot[cID]]
				    ShureReceiver.WMic[cID].sConnected = TRUE;
			}
			CASE 'MENU_LOCK UNKN':
			CASE 'PWR_LOCK UNKN':
			CASE 'TYPE UNKN' :
			CASE 'POWER_SOURCE UNKN' :
			CASE 'RF_PWR UNKN' :
			{
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,Not Connected'"
				    OFF [vdvTP_Shure, nNameSlot[cID]]
					ShureReceiver.WMic[cID].sConnected = FALSE;
			}
		    }
		}
		IF (FIND_STRING(cResponse, 'FW_VER {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			//SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -16);
			ShureReceiver.sFirmware = LEFT_STRING (cResponse,8) ; //Ex : 2.3.34.0
		}
		IF (FIND_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1))
		{
		    REMOVE_STRING (cResponse, 'AUDIO_SUMMING_MODE ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureReceiver.sSummMode = cResponse;
				cSum = "'Summing Mode = ', cResponse";
			    
		    //Responses...
			//OFF -- 1+2 -- 3+4 -- 1+2/3+4 -- 1+2+3+4
		}
		IF (FIND_STRING (cResponse, 'DEVICE_ID {',1))
		{
		    REMOVE_STRING (cResponse,'{',1)
			ShureReceiver.sLocation = cResponse;
		}
		IF (FIND_STRING (cResponse, 'ENCRYPTION ',1))
		{
		    REMOVE_STRING (cResponse, 'ENCRYPTION ',1)
			SET_LENGTH_STRING(cResponse,LENGTH_STRING(cResponse) -2);
			    ShureReceiver.sEncryption = cResponse;
				//OFF -- AUTO -- MANUAL
		}
		IF (FIND_STRING (cResponse, 'MODEL {',1)) //Needs latest firmware...
		{
		    REMOVE_STRING (cResponse, '{',1)
		    ShureReceiver.sModel = cResponse;
		}
    		IF (FIND_STRING (cResponse, 'ERR',1)) //Needs latest firmware...
		{
		    ShureReceiver.sModel = "'Firmware Update Available'"
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 300 {
	    IF (ShureReceiver.sOnline == FALSE) {
		fnStartShureRXConnection(dvShure);
	    } ELSE {
		fnGetShureRXQuadRep(dvShure);
	    }
    }
}