MODULE_NAME='ContemporaryResearch_232STS' (DEV VIRTUAL, DEV REAL)
(***********************************************************)
(*  FILE CREATED ON: 10/22/2016  AT: 16:58:24              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/27/2016  AT: 16:01:14        *)
(***********************************************************)

(*
//Favorites...
"'>1TC=7-1',$0D //One of the favorites...
	    *)

DEFINE_CONSTANT

LONG TL_TUNER 			= 50;

CHAR MSG_ETX			= $0D; //
//CHAR MSG_END			= "$0D,$0A";

DATA_INITIALIZED			= 251;


DEFINE_VARIABLE

VOLATILE LONG lTLTVStatus[] = {9000};
VOLATILE CHAR cTuner_Buffer[100];

VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPower;
VOLATILE CHAR bDebug;



DEFINE_MUTUALLY_EXCLUSIVE


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION SendDeviceString (CHAR iMsg[])
{
    SEND_STRING REAL, "iMsg, MSG_ETX";
}
DEFINE_FUNCTION ReInitialize()
{
    bIsInitialized = FALSE;
    [VIRTUAL, DATA_INITIALIZED] = bIsInitialized;
    
    cTuner_Buffer = ""; //Clear Buffer
    
    bPower = FALSE;
    	    OFF [VIRTUAL, 251]
		SEND_COMMAND VIRTUAL, "'FBTUNER-DEVICE-PROBLEM'"
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{
    bIsInitialized = TRUE;
    [VIRTUAL, DATA_INITIALIZED] = bIsInitialized;

    ON [VIRTUAL, 252]
	ON [VIRTUAL, 251]
	    SEND_COMMAND VIRTUAL, "'FBTUNER-ONLINE'"
    
    SELECT
    {
	ACTIVE(FIND_STRING(iMsg,'<1VU',1)): //Status Query On
	{
	    ON [VIRTUAL, 255]
		SEND_COMMAND VIRTUAL, "'FBPOWER-ON'"
		    bPower = TRUE;
	}
	ACTIVE(FIND_STRING(iMsg,'<1VM',1)): //Status Query Off
	{
	    OFF [VIRTUAL, 255]
		SEND_COMMAND VIRTUAL, "'FBPOWER-OFF'"
		    bPower = FALSE;
	}
    }
} 


DEFINE_START

CREATE_BUFFER REAL,cTuner_Buffer;


DEFINE_EVENT
DATA_EVENT [REAL]
{
    ONLINE :
    {
	SEND_COMMAND REAL, "'SET BAUD 9600,N,8,1 485 DISABLE'"
	SEND_COMMAND REAL, "'RXON'"
	SEND_COMMAND REAL, "'HSOFF'"
	 
	IF (!TIMELINE_ACTIVE (TL_TUNER))
	{
	    TIMELINE_CREATE (TL_TUNER,lTLTVStatus,LENGTH_ARRAY(lTLTVStatus),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	}
    }
    OFFLINE :
    {
	ReInitialize()
    }
    STRING :
    {
//	ON [VIRTUAL, 252]
//	ON [VIRTUAL, 251]
//	CANCEL_WAIT 'DEVICE COMM/INIT'
//	WAIT 200'DEVICE COMM/INIT'
//	{
//	    OFF[VIRTUAL, 252]
//	    OFF[VIRTUAL, 251]
//	}
	WHILE (FIND_STRING(cTuner_Buffer, "$0D,$0A",1))
	{
	    STACK_VAR CHAR iResult[25];
		iResult = REMOVE_STRING (cTuner_Buffer, "$0D,$0A",1);
		
		fnParseDeviceResponseString(iResult);
	}
    }
}
DATA_EVENT [VIRTUAL]
{
    COMMAND :
    {
	CHAR cTunerMsg[20];
	cTunerMsg = DATA.TEXT;
	
	IF (FIND_STRING(cTunerMsg,'XCH-',1))
	{
	    REMOVE_STRING(cTunerMsg,'-',1) //Removes everything up to and including the hyphen
		
		SEND_STRING REAL, "'>1TC=',cTunerMsg,MSG_ETX"
	}
    }
}
CHANNEL_EVENT[VIRTUAL, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 9 :
	    {
		IF (![VIRTUAL, 255])
		{
		    SendDeviceString ('>1KK=27') 
			ON [VIRTUAL, 255]
		}
		ELSE
		{
		    SendDeviceString ('>1KK=28')
			OFF [VIRTUAL, 255]
		}
	    }
	    CASE 10 : SendDeviceString ('>1KK=10')
	    CASE 11 : SendDeviceString ('>1KK=11')
	    CASE 12 : SendDeviceString ('>1KK=12')
	    CASE 13 : SendDeviceString ('>1KK=13')
	    CASE 14 : SendDeviceString ('>1KK=14')
	    CASE 15 : SendDeviceString ('>1KK=15')
	    CASE 16 : SendDeviceString ('>1KK=16')
	    CASE 17 : SendDeviceString ('>1KK=17')
	    CASE 18 : SendDeviceString ('>1KK=18')
	    CASE 19 : SendDeviceString ('>1KK=19')
	    CASE 22 : SendDeviceString ('>1TU') //CH Up..
	    CASE 23 : SendDeviceString ('>1TD') //Ch Dn..
	    CASE 24 : SendDeviceString ('>1VU') //Vol Up..
	    CASE 25 : SendDeviceString ('>1VD') //Vol Dn..
	    CASE 27 : SendDeviceString ('>1KK=27') 
	    CASE 28 : SendDeviceString ('>1KK=28')
	    CASE 90 : SendDeviceString ('>1KK=99')
	    CASE 101 : SendDeviceString ('>1KK=101') //Last Channel
	    CASE 110 : SendDeviceString ('>1KK=110') //Enter	    
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 24 :
	    CASE 25 : //Volume Stop...
	    {
		SendDeviceString ('>1VV')
	    }
	}
    }
}
TIMELINE_EVENT [TL_TUNER]
{
  // SEND_STRING REAL, "'>1SV',$0D" //AV Status -	
    SendDeviceString ('>1SV')
}


