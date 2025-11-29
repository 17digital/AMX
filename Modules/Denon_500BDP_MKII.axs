MODULE_NAME='Denon_500BDP_MKII'(DEV vdvDevice, DEV dvDevice)

(**
	https://aca.im/driver_docs/Denon/dn-500bd_codes.pdf
**)

DEFINE_CONSTANT

LONG TL_BLURAY			= 21;

CHAR MSG_ETX			= $0D; //

DATA_INITIALIZED			= 251;

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE LONG lTLBluRay[] = {15000} //15 Seconds

VOLATILE CHAR cBluRayBuffer[100];

VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPower;
VOLATILE CHAR bDebug;
VOLATILE INTEGER bTrayOpen;

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([vdvDevice,241]..[vdvDevice,243],[vdvDevice,246],[vdvDevice,247])


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION SendDeviceString (CHAR iMsg[])
{
    SEND_STRING dvDevice, "iMsg, MSG_ETX";
}
DEFINE_FUNCTION ReInitialize()
{
    bIsInitialized = FALSE;
	[vdvDevice, DATA_INITIALIZED] = bIsInitialized;
    
    cBluRayBuffer = ""; //Clear Buffer
    
    bPower = FALSE;
	[vdvDevice, 255] = bPower;
		SEND_COMMAND vdvDevice, "'BLURAY-OFFLINE'"
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{
    STACK_VAR CHAR cRead[30];
    LOCAL_VAR CHAR cPullTitle[20];
	
    bIsInitialized = TRUE;
    [vdvDevice, DATA_INITIALIZED] = bIsInitialized;
	
    SELECT
    {
	ACTIVE(FIND_STRING(iMsg,'ack',1)):
	{
	    REMOVE_STRING (iMsg,'ack',1)

		cRead = iMsg;
		
		bPower = TRUE
		[vdvDevice, 255] = bPower;
		
	    SELECT
	    {
		ACTIVE (FIND_STRING(cRead, "'+@0CDNC'",1)) : //No Disc..
		{
		    SEND_COMMAND vdvDevice, "'STAT-No Disc In Drive'"
			bTrayOpen = FALSE;
			    [vdvDevice, 120] = bTrayOpen;
		}
		ACTIVE (FIND_STRING(cRead, "'+@0CDCI'",1)) : //Disc In...
		{
		    SEND_COMMAND vdvDevice, "'STAT-Disc Reading'"
			bTrayOpen = FALSE;
			    [vdvDevice, 120] = bTrayOpen;
		}
		ACTIVE (FIND_STRING(cRead, "'+@0CDTO'",1)) : //Tray Open...
		{
		    SEND_COMMAND vdvDevice, "'STAT-Disc Tray Open'"
			bTrayOpen = TRUE
			    [vdvDevice, 120] = bTrayOpen;
		}
		ACTIVE (FIND_STRING(cRead, "'+@0CDTE'",1)) : //Tray Error
		{
		    SEND_COMMAND vdvDevice, "'STAT-Disc Tray Error!'"
		}
		ACTIVE (FIND_STRING(cRead, "'+@0STPL'",1)) : {
			SEND_COMMAND vdvDevice, "'STAT-DISCPLAYING'"
		}
		ACTIVE (FIND_STRING(cRead, "'+@0STPP'",1)) : {
			SEND_COMMAND vdvDevice, "'STAT-DISCPAUSED'"
		}
		ACTIVE (FIND_STRING(cRead, "'+@0STPS'",1)) : {
			SEND_COMMAND vdvDevice, "'STAT-DISCSTOP'"
		}
		ACTIVE (FIND_STRING(cRead, "'+@0STDVHM'",1)) : 
		{
		    SEND_COMMAND vdvDevice, "'STAT-DVD Main Menu'"
		}
		ACTIVE (FIND_STRING(cRead, "'+@0ti'",1)) :  // Title of Current Track
		{
		    REMOVE_STRING (cRead,"'+@0ti'",1)
			cPullTitle = cRead;
			
			IF (FIND_STRING(cRead, "'NULL'",1)) {
				SEND_COMMAND vdvDevice, "'TITLE-Can Not Read Disc Title'"
				    bTrayOpen = FALSE;
				[vdvDevice, 120] = bTrayOpen;
			} ELSE {
			    SEND_COMMAND vdvDevice, "'TITLE-',cPullTitle"
			    
			}
		}
	    }
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

//CREATE_BUFFER dvDevice,cBluRayBuffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvDevice]
{
    ONLINE :
    {
	SEND_COMMAND dvDevice, "'SET BAUD 9600,N,8,1'"
	//SEND_COMMAND dvDevice, "'SET BAUD 115200,N,8,1'"
	SEND_COMMAND dvDevice, "'RXON'"
	SEND_COMMAND dvDevice, "'HSOFF'"
	
	SEND_COMMAND vdvDevice, "'BLURAY-ONLINE'"
	
	IF (!TIMELINE_ACTIVE (TL_BLURAY))
	{
	    TIMELINE_CREATE (TL_BLURAY,lTLBluRay,LENGTH_ARRAY(lTLBluRay),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	}
    }
    OFFLINE :
    {
	ReInitialize();
    }
    STRING :
    {
	STACK_VAR CHAR iResult[50];
	    iResult = DATA.TEXT;
		fnParseDeviceResponseString(iResult);
		
	    CANCEL_WAIT 'DVD_COMM'
	
	WAIT 350 'DVD_COMM'
	{
	    ReInitialize();
	}
    }
}
CHANNEL_EVENT[vdvDevice, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 1 : SendDeviceString ('@02353') //Play
	    CASE 2 : SendDeviceString ('@02354') //Strop
	    CASE 3 : SendDeviceString ('@02348') //Pause
	    CASE 4 : SendDeviceString ('@02332') //Next
	    CASE 5 : SendDeviceString ('@02333') //Prev
	    CASE 6 : SendDeviceString ('@0PCGPPV') //Search Fwd
	    CASE 7 : SendDeviceString ('@0PCSLSR') //Search Rwd
	    CASE 27 : SendDeviceString ('@0PW00') //Pwr On...
	    CASE 28 : SendDeviceString ('@0PW01') //Pwr Off...
	    CASE 44 : SendDeviceString ('@0DVTP') //Menu
	    CASE 45 : SendDeviceString ('@0PCCUSR3') //Cursor Up
	    CASE 46 : SendDeviceString ('@0PCCUSR4') //Cursor Dn
	    CASE 47 : SendDeviceString ('@0PCCUSR1') //Cursor Left
	    CASE 48 : SendDeviceString ('@0PCCUSR2') //Cursor Right
	    CASE 49 : SendDeviceString ('@0PCENTR') //Select
	    CASE 54 : SendDeviceString ('@0PCRTN') //Return
	    CASE 120 : {
		IF (bTrayOpen == FALSE) {
			    SendDeviceString ('@0PCDTRYOP') //Open 
				bTrayOpen = TRUE;
		    } ELSE {
			    SendDeviceString ('@0PCDTRYCL') //Close
				bTrayOpen = FALSE;
		}
	    }
	    CASE 250 : bDebug = TRUE
	}
  }
  OFF :
  {
    SWITCH (CHANNEL.CHANNEL)
    {
	CASE 250 : bDebug = FALSE;
    }
  }
}
TIMELINE_EVENT [TL_BLURAY]
{
    SendDeviceString ('@0?PW')
    
    IF (bPower == TRUE) {
	WAIT 10 SendDeviceString ('@0?CD')  //Disc Status
	    WAIT 30 SendDeviceString ('@0?ST') //Play Status
		WAIT 50 SendDeviceString ('@0?ti') //Track Title
    }
}

