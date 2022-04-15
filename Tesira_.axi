PROGRAM_NAME='Tesira_'



DEFINE_DEVICE


#IF_NOT_DEFINED dvTesira
dvTesira	= 		5405:2:0
#END_IF



DEFINE_CONSTANT

CHAR BIAMP_TYPE[]		= 'Tesira TI';

CHAR MSG_ETX			= $0D;

BIAMP_INITIALIZED			= 251;

HOLD_MAC_ADDRESS			= 17;
HOLD_IP_ADDRESS				= 15;

MAX_ATTRIBUTES				= 1;

DEFINE_TYPE

STRUCTURE _BiampStruct
{
    CHAR sHost[35]
    CHAR sMac[30]
    CHAR sIP[30]
    CHAR sSerial[25]
    CHAR sFirmware[30]
}

DEFINE_VARIABLE

_BiampStruct MyBiampStruct

VOLATILE CHAR cTesira_Buffer[500];

VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPower;
VOLATILE CHAR bDebug;

VOLATILE CHAR bMacAddress[HOLD_MAC_ADDRESS];
VOLATILE CHAR bIPAddress[HOLD_IP_ADDRESS];
VOLATILE CHAR bFound[20];
VOLATILE CHAR bHost[20];
VOLATILE CHAR bSerial[10];
VOLATILE CHAR bFirmware[12];

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION ReInitialize()
{
    bIsInitialized = FALSE;
    
    cTesira_Buffer = "";  //Clear Buffer...
    
	bPower = FALSE;
	    SEND_STRING 0, "'What Happened to the Tesira? Went offline'" //35 seconds for alarm
}
DEFINE_FUNCTION fnParseTesiraFind(CHAR iFind[500])
{
    LOCAL_VAR CHAR cHelper[50];
    
    bIsInitialized = TRUE;
	SEND_STRING 0, "'Tesira is Online'"
	
    SELECT
    {
	ACTIVE (FIND_STRING(iFind,'Welcome to the Tesira Text Protocol Server. . .',1)):
	{
	    SEND_STRING 0, "'Tesira is Ready'"
		    //Load Presets....
	}
	ACTIVE (FIND_STRING(iFind,'+OK "value":{"macAddress":"',1)) :
	{
	    REMOVE_STRING (iFind,'+OK "value":{"macAddress":"',1)
		bMacAddress = LEFT_STRING (iFind, HOLD_MAC_ADDRESS)
			
	    REMOVE_STRING (iFind,'"addressSource":DHCP "ip":"',1)
	    
	    cHelper = REMOVE_STRING (iFind,'" "netmask":"',1)
	    //cHelper = cHelp1; //Should give me IP + netmask
			bIPAddress = LEFT_STRING(cHelper,LENGTH_STRING(cHelper) -13)
	}
	ACTIVE (FIND_STRING (iFind,'DEVICE get hostname',1)):
	{
		    bFound= 'hostname';
	}
	ACTIVE (FIND_STRING (iFind,'DEVICE get serialNumber',1)):
	{
		    bFound= 'serialNumber';
	}
	ACTIVE (FIND_STRING (iFind,'DEVICE get version',1)):
	{
	    bFound = 'firmware';
	}
	ACTIVE (FIND_STRING (iFind,'+OK "value":"',1)) :
	{
	    REMOVE_STRING (iFind,'+OK "value":"',1)
	    
	    SWITCH (bFound)
	    {
		CASE 'hostname' :
		{
		    bHost = LEFT_STRING(iFind,LENGTH_STRING(iFind) -3) //Remove Last Quote + 2Bytes
						bFound = '';
		}
		CASE 'serialNumber' :
		{
		    bSerial = LEFT_STRING(iFind,LENGTH_STRING(iFind) -3) //Remove Last Quote + 2Bytes
			bFound = '';
		}
		CASE 'firmware' :
		{
		    bFirmware = LEFT_STRING(iFind,LENGTH_STRING(iFind) -3)
			bFound = '';
		}
		DEFAULT :
		{
		    bFound ='';
		}
	    }
	}
    }
}
DEFINE_FUNCTION biampPrintOut()
{
    MyBiampStruct.sHost = "'Biamp Host ',bHost"
    MyBiampStruct.sMac = "'Biamp Mac ',bMacAddress"
    MyBiampStruct.sIP = "'Biamp IP ',bIPAddress"
    MyBiampStruct.sSerial = "'Biamp Serial ',bSerial"
    MyBiampStruct.sFirmware = "'Biamp Firmware ',bFirmware"
    
//    WAIT 20
//    {
//	lPos = 1;
//	    slReturn = VARIABLE_TO_XML (MyBiampStruct, sXMLString, lPos, 0)
//		SEND_STRING 0, "'POSITION=',ITOA(lPos),'; RETURN=',ITOA(slReturn)"
//		
//	    //Save these to Disk...
//	    slFile = FILE_OPEN ('BiampEncode.xml', nFileWrite) //nFilewrite = 2
//	    
//	    IF (slFile > 0)
//	    {
//		slReturn = FILE_WRITE (slFile, sXMLString, LENGTH_STRING (sXMLString))
//		    FILE_CLOSE (slFile)
//	    }
//	    ELSE
//	    {
//		SEND_STRING 0,"'FILE OPEN ERROR:',ITOA(slFile)" // IF THE LOG FILE COULD NOT BE CREATED
//	    }
//    }
}


DEFINE_START

CREATE_BUFFER dvTesira, cTesira_Buffer;


DEFINE_EVENT
DATA_EVENT [dvTesira]
{
    ONLINE :
    {
    	SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1,485 DISABLE'" //Tesira Default
	    SEND_COMMAND DATA.DEVICE, "'RXON'"
		SEND_COMMAND DATA.DEVICE, "'HSOFF'"
		
	WAIT 50 SEND_STRING dvTesira, "'DEVICE get ipStatus control',MSG_ETX"
	WAIT 70 SEND_STRING dvTesira, "'DEVICE get hostname',MSG_ETX"
	
	WAIT 90 SEND_STRING dvTesira, "'DEVICE get serialNumber',MSG_ETX"
	
	WAIT 110 SEND_STRING dvTesira, "'DEVICE get version',MSG_ETX"
    }
    OFFLINE :
    {
	ReInitialize()
    }
    STRING :
    {
	WHILE (FIND_STRING(cTesira_Buffer, "$0D,$0A",1))
	{
	    STACK_VAR CHAR iResult[500];
	    
	    iResult = REMOVE_STRING (cTesira_Buffer, "$0D,$0A",1)
		SEND_STRING 0, "'Biamp Found :', iResult"
	    
		fnParseTesiraFind(iResult);
	}
    }
}

