PROGRAM_NAME='_RMS_Inventory'


DEFINE_DEVICE

#IF_NOT_DEFINED dvMaster
dvMaster 	=		0:1:0
#END_IF



DEFINE_CONSTANT

TOTAL_ASSETS				= 1;

MAX_BUILDING_LENGTH	= 25;
MAX_ROOM_LENGTH		= 35;
MAX_HEADER_LENGTH		= 35; //Determined by Physical assets in Room
MAX_ASSET_LENGTH		= 20;
MAX_IP_LENGTH			= 15;
MAX_MAC_LENGTH		= 17;
MAX_SERIAL_NUM			= 14;
MAX_FIRMWARE			= 15;

POS_CONTROLLER			= 1;
POS_TP_1				= 2;
POS_TP_2				= 3;
POS_DX_RX_1				= 5;
POS_DX_RX_2				= 6;
POS_DSP					= 4;
POS_PROJ_1				= 7;
POS_PROJ_2				= 8;

DEFINE_TYPE

STRUCTURE _RoomAsset
{
    CHAR nAssetName[MAX_ASSET_LENGTH];
    CHAR nAssetType[MAX_ASSET_LENGTH];
    CHAR nAssetIP[MAX_IP_LENGTH];
    CHAR nAssetMacAddress[MAX_MAC_LENGTH];
    CHAR nAssetSerialNum[MAX_SERIAL_NUM];
    CHAR nAssetFirmware[MAX_FIRMWARE];
    INTEGER nAssetOnline;
}
STRUCTURE _Room 
{
    CHAR nBuildingName[MAX_BUILDING_LENGTH];
    CHAR nRoomName[MAX_ROOM_LENGTH];
    _RoomAsset ROOMMANAGER;
}



DEFINE_VARIABLE

DEV_INFO_STRUCT sDeviceInfo; //Pull Master Info...
DEV_INFO_STRUCT sTpInfoMain; //Pull Touch Panel
DEV_INFO_STRUCT sTpInfoRear; //Pull Touch Panel
DEV_INFO_STRUCT sComBox; //Pull EXB-Com or Similar Netlinx device

IP_ADDRESS_STRUCT nMaster;

VOLATILE CHAR cMac_Address[17]; //Hold Init Master Mac Address...
VOLATILE CHAR iMacFormatted[17]; //Format Master Mac Address...

VOLATILE CHAR bTPMainInitialized;
VOLATILE CHAR bTP2ndInitialized;

//Export Variables...
nFileWrite		= 2;
LONG  lPos;
SLONG  slReturn;
SLONG  slFile;
SLONG  slResult;
CHAR  sBinaryString[10000]
CHAR  sXMLString[50000]
//End Export Variables...

VOLATILE INTEGER TXT_ROOM_ASSET[] =
{
    1,2,3,4,5,6,7
}
VOLATILE INTEGER TXT_BUILDING[] =
{
    101,
    102
}

_Room uROOMBUILD[TOTAL_ASSETS];

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
DEFINE_FUNCTION fnGetAssetDetails()
{
	    uROOMBUILD[POS_CONTROLLER].nBuildingName = RM_LOCATION;
	    uROOMBUILD[POS_CONTROLLER].nRoomName = RM_NUMBER;
	    uROOMBUILD[POS_CONTROLLER].ROOMMANAGER.nAssetName = 'Controller';
	    uROOMBUILD[POS_CONTROLLER].ROOMMANAGER.nAssetType = sDeviceInfo.DEVICE_ID_STRING;
	    uROOMBUILD[POS_CONTROLLER].ROOMMANAGER.nAssetIP = nMaster.IPADDRESS;
	    uROOMBUILD[POS_CONTROLLER].ROOMMANAGER.nAssetMacAddress = iMacFormatted;
	    uROOMBUILD[POS_CONTROLLER].ROOMMANAGER.nAssetSerialNum = sDeviceInfo.SERIAL_NUMBER;
	    uROOMBUILD[POS_CONTROLLER].ROOMMANAGER.nAssetFirmware = sDeviceInfo.VERSION;
	    uROOMBUILD[POS_CONTROLLER].ROOMMANAGER.nAssetOnline = TRUE;
}
DEFINE_FUNCTION InventoryRMSPrintXML()
{
    lPos = 1;
	slReturn = VARIABLE_TO_XML (uROOMBUILD, sXMLString, lPos, 0)
	    SEND_STRING 0, "'POSITION=',ITOA(lPos),'; RETURN=',ITOA(slReturn)"
		
	//Save these to Disk...
	slFile = FILE_OPEN ('\RoomInventory.xml', nFileWrite) //nFilewrite = 2
	    
	IF (slFile > 0)
	{
	    slReturn = FILE_WRITE (slFile, sXMLString, LENGTH_STRING (sXMLString))
		    FILE_CLOSE (slFile)
	}
	ELSE
	{
	    SEND_STRING 0,"'FILE OPEN ERROR:',ITOA(slFile)" // IF THE LOG FILE COULD NOT BE CREATED
	}
}
DEFINE_FUNCTION InventoryRMSPrintString()
{
    lPos = 1;
	slReturn = VARIABLE_TO_STRING (uROOMBUILD, sXMLString, lPos)
	    SEND_STRING 0, "'POSITION=',ITOA(lPos),'; RETURN=',ITOA(slReturn)"
		
	//Save these to Disk...
	slFile = FILE_OPEN ('\RoomString.xml', nFileWrite) //nFilewrite = 2
	    
	IF (slFile > 0)
	{
	    slReturn = FILE_WRITE (slFile, sXMLString, LENGTH_STRING (sXMLString))
		    FILE_CLOSE (slFile)
	}
	ELSE
	{
	    SEND_STRING 0,"'FILE OPEN ERROR:',ITOA(slFile)" // IF THE LOG FILE COULD NOT BE CREATED
	}
}

DEFINE_START


DEFINE_EVENT
DATA_EVENT [dvMaster]
{
    ONLINE :
    {	
	WAIT 100
	{
	    DEVICE_INFO (dvMaster, sDeviceInfo)
	}
	WAIT 120
	{
	    GET_IP_ADDRESS (dvMaster, nMaster) //Pulls Given Host Name, IP, Subnet, GW....
	}
	WAIT 140
	{
	    cMac_Address = GET_UNIQUE_ID()
		    iMacFormatted = FORMAT('-%02X',cMac_Address[6]) //
		    iMacFormatted = "FORMAT('-%02X',cMac_Address[5]),iMacFormatted"
		    iMacFormatted = "FORMAT('-%02X',cMac_Address[4]),iMacFormatted"
		    iMacFormatted = "FORMAT('-%02X',cMac_Address[3]),iMacFormatted"
		    iMacFormatted = "FORMAT('-%02X',cMac_Address[2]),iMacFormatted"
		    iMacFormatted = "FORMAT('%02X',cMac_Address[1]),iMacFormatted"
		    
	    //SEND_STRING 0, "'Contoller Mac Address : ',iMacFormatted"
	}
	WAIT 180
	{
	  //  FILE_DELETE ('RmsInventory.txt')
	}
	WAIT 1200 //Everything else should be loaded by now...
	{
	    fnGetAssetDetails()
	}
	WAIT 1800
	{
	    InventoryRMSPrintXML()
	}
	WAIT 1850
	{
	    InventoryRMSPrintString()
	}
    }
}


