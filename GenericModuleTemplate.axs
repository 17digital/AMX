MODULE_NAME='GenericTemplate' (DEV vdvDEVICE, DEV dvDEVICE)

https://harman.remote-learner.net/course/view.php?id=964&section=6

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

LONG TL_FB		= 1; //This is acceptable due to being within it's own module
LONG TL_POLLING	 = 2;

LONG TL_FB_TIME[] = {500};
LONG TL_POLL_TIME[] = {9000}; 

CHAR MSG_ETX		= $0D;
//CHAR MSG_ETX		= "$0D,$0A"; 

DATA_INITIALIZED		= 251

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR bDebug;
VOLATILE CHAR sRxBuffer[500];
VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPower;

VOLATILE INTEGER nTransport

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION SendDeviceString (CHAR iMsg[])
{
    SEND_STRING dvDEVICE, "iMsg, MSG_ETX";
}
DEFINE_FUNCTION ReInitialize()
{
    bIsInitialized = FALSE;
    [vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;
    sRxBuffer = ""; //Clear Buffer
    
    bPower = FALSE;
    
    IF (TIMELINE_ACTIVE (TL_POLLING)
    {
	TIMELINE_KILL (TL_POLLING);
    }
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{
    bIsInitialized = TRUE;
    [vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;
    
    SELECT
    {
	ACTIVE (iMsg[1] == $05): //Evaluate First Byte... ($05, $12) 
	{
	    OFF [bPower]
	}
	ACTIVE (iMsg[1] == $12): //Evaluate First Byte as in ...
	{
	    ON [bPower]
	    
	    SWITCH (iMsg[2]) //Switch 2nd Byte
	    {
		CASE $01 :
		{
		    //nTransport = Play
		}
		CASE $03 :
		{
		    //nTransport = Play
		}
	    }
	}
    }
} 


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvDEVICE,sRxBuffer;

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [dvDDEVICE]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 9600,N,8,1'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	
	IF (!TIMELINE_ACTIVE(TL_POLLING))
	{
	    TIMELINE_CREATE (TL_POLLING, TL_POLL_TIME, LENGTH_ARRAY(TL_POLL_TIME), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	}
	TIMELINE_SET (TL_POLLING, TL_POLL_TIME[LENGTH_ARRAY(TL_POLL_TIME)] -100); //Set's timeline towards the end
    }
    OFFLINE :
    {
	ReInitialize(); //Purge Module...
    }
    STRING :
    {
	IF (bDebug == TRUE )
	{
	    SEND_STRING 0, "__FILE__, 'DATA_EVENT[dvDEVICE]{STRING: ',DATA.TEXT"
	}
	//Buffer Parsing
	WHILE (FIND_STRING(sRxBuffer, "MSG_ETX",1))
	{
	    STACK_VAR CHAR iResult[25];
	    
		iResult = REMOVE_STRING(sRxBuffer,"MSG_ETX",1);
		
		fnParseDeviceResponseString(iResult);
	}
    }
}
DATA_EVENT [vdvDEVICE]
{
    ONLINE :
    {
	IF (!TIMELINE_ACTIVE (TL_FB))
	{
	    TIMELINE_CREATE (TL_FB, TL_FB_TIME, LENGTH_ARRAY (TL_FB_TIME), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	}
    }
    COMMAND :
    {
	STACK_VAR CHAR iCmd[DUET_MAX_CMD_LEN], iHeader[DUET_MAX_HDR_LEN], iParam[DUET_MAX_PARAM_LEN];
	
	iCmd = DATA.TEXT;
	iHeader = DUETParseCmdHeader(iCmd);
	iParm = DuetParseCmdParam(iCmd);
    }
}
CHANNEL_EVENT [vdvDEVICE, 0] //Wild Card
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 1 : SendDeviceString ("$20, $21");
	    CASE 2 : SendDeviceString ("$20, $22");
	    CASE 9 : //Power Toggle
	    {
		SendDeviceString ("$20, $22");
		    nTransport = CHANNEL.CHANNEL // (speed up feedback)
	    }
	    CASE 28 : //Power Off
	    {
		IF (bPower)
		{
		    //Send Power On Command
		}
	    }
	    CASE 27 : //Power On
	    CASE 255 : //Power State
	    {
		IF (!bPower)
		{
		    //Send Power On Command
		}
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 255 : //Power State
	    {
		IF (bPower)
		{
		    //Send off command 
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FB]
{
    [vdvDEVICE, DATA_INITIALIZED] = (bIsInitialized == TRUE);
    
    [vdvDEVICE, POWER_STATUS] = bPower;
}
TIMELINE_EVEN [TL_POLLING]
{
    SendDeviceString ($21, $23)
}
    
