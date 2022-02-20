MODULE_NAME='Sony_FHZ55'(DEV vdvDEVICE,DEV dvDEVICE)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/28/2017  AT: 07:01:50        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    Input A = RGBHV A9 00 01 00 00 02 03 9A (Computer 3
    Input B = VGA  (Computer 1 /Button 3)
    Input C = DVI
    Input D = HDMI
*)    
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

LONG TL_POLL 			= 15;
CHAR MSG_ETX			= $9A; //End of Sony Proejctor Response...

DATA_INITIALIZED			= 251;


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE LONG lTLProjectorStatus[] = {12000} //12 Seconds

VOLATILE CHAR cProj_Buffer[100];

VOLATILE CHAR bIsInitialized;
VOLATILE CHAR bPower;
VOLATILE CHAR bDebug;

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

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
    
    cProj_Buffer = ""; //Clear Buffer
    
    bPower = FALSE;
    	    OFF [vdvDEVICE, DATA_INITIALIZED]
		SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-OFFLINE'"
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{
    bIsInitialized = TRUE;
	[vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;

    ON [vdvDEVICE, 252]
	    SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-ONLINE'"
    
    SELECT
    {
	ACTIVE (iMsg[6] ==$03): //Status Query On --$A9,$01,$02,$02,$00,[$03],$03
	{
	    ON [vdvDEVICE, 255]
		SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-PWRON'"
		    bPower = TRUE;
	}
	ACTIVE (iMsg[3] == $2E) : //Immediate FB On --$A9,$17,[$2E],$00,$00,$00,$3F
	{
	    ON [vdvDEVICE, 255]
		SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-IMMEDIATE-ON'"
		    bPower = TRUE;
	}
	ACTIVE (iMsg[6] == $00): //Status Query Off -- $A9,$01,$02,$02,$00,$00,$03
	{
	    OFF [vdvDEVICE, 255]
		SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-PWROFF'"
		    bPower = FALSE;
	}
	ACTIVE (iMsg[3] == $2F) : //Immediate FB Off -- $A9,$17,[$2F],$00,$00,$00,$3F
	{
	    OFF [vdvDEVICE, 255]
		SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-IMMEDIATE-OFF'"
		    bPower = FALSE;
	}
    }
} 

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


CREATE_BUFFER dvDEVICE,cProj_Buffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [dvDEVICE]
{
    ONLINE :
    {
	SEND_COMMAND dvDEVICE, "'SET BAUD 38400,E,8,1,485 DISABLE'"
	    SEND_COMMAND dvDEVICE, "'RXON'"
		SEND_COMMAND dvDEVICE, "'HSOFF'"
	
	IF (!TIMELINE_ACTIVE (TL_POLL))
	{
	    TIMELINE_CREATE(TL_POLL,lTLProjectorStatus,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	}
    }
    OFFLINE :
    {
	ReInitialize();
    }
    STRING:
    {
	IF (bDebug == TRUE )
	{
	    SEND_STRING 0, "__FILE__, 'DATA_EVENT [dvDEVICE] {STRING : ',cProj_Buffer"
	}
	WHILE (FIND_STRING(cProj_Buffer, "MSG_ETX",1))
	{
	    STACK_VAR CHAR iResult[50];
		iResult = REMOVE_STRING (cProj_Buffer, "MSG_ETX",1);
		
		fnParseDeviceResponseString(iResult);
	}
    }
}
DATA_EVENT [vdvDEVICE]
{
    COMMAND :
    {
    	LOCAL_VAR CHAR cSTR[10]; //Video Input Recall
	    
	CHAR cProjectorMsg[50];
	    cProjectorMsg = DATA.TEXT

	IF (FIND_STRING(cProjectorMsg,'INPUT-',1))
	{
	    REMOVE_STRING(cProjectorMsg,'-',1)
	    cSTR = cProjectorMsg;
	    
	    SWITCH (cSTR)
	    {
		CASE 'RGBHV,1' :
		{
		    SEND_STRING dvDEVICE, "$A9,$00,$01,$00,$00,$02,$03,$9A" //Input A
			WAIT 10 SEND_STRING dvDEVICE, "$A9,$00,$32,$00,$00,$01,$33,$9A" //Input A - SubCategory
		}
		CASE 'VGA,1' : SEND_STRING dvDEVICE, "$A9,$00,$01,$00,$00,$03,$03,$9A" //Input B
		CASE 'DVI,1' : SEND_STRING dvDEVICE, "$A9,$00,$01,$00,$00,$04,$05,$9A" //Input C
		CASE 'HDMI,1' : SEND_STRING dvDEVICE, "$A9,$00,$01,$00,$00,$05,$05,$9A" //Input D
	    }
	}
    }
}
CHANNEL_EVENT[vdvDEVICE, 0]
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 27 :
	    {
	    	SEND_STRING dvDEVICE, "$A9,$17,$2E,$00,$00,$00,$3F,$9A" //Power On...
		
		IF (bIsInitialized == TRUE)
		{
		    TIMELINE_PAUSE (TL_POLL)
		    
		    ON [vdvDEVICE, 255]
		    ON [vdvDEVICE, 253]
		    WAIT 60
		    {
			OFF [vdvDEVICE, 253]
			    TIMELINE_RESTART (TL_POLL);
		    }
		}
	    }
	    CASE 28 :
	    {
		SEND_STRING dvDEVICE, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"
		
		IF (bIsInitialized == TRUE)
		{
		    ON [vdvDEVICE, 254]
		    TIMELINE_PAUSE (TL_POLL)
		
		    WAIT 90
		    {
			OFF [vdvDEVICE, 254]
			    TIMELINE_RESTART (TL_POLL);
				TIMELINE_SET (TL_POLL, lTLProjectorStatus[LENGTH_ARRAY (lTLProjectorStatus)] -100); //Take Timeline to Last Second..
			
		    }
		}
	    }
	    CASE 211 :
	    {
		SEND_STRING dvDEVICE, "$A9,$00,$30,$00,$00,$01,$31,$9A" //blank On...
	    }
	    CASE 250 :
	    {
		bDebug = TRUE;
	    }
	}
    }
    OFF:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 211 :
	    {
		SEND_STRING dvDEVICE, "$A9,$00,$30,$00,$00,$00,$30,$9A" //blank Off
	    }
	    CASE 250 :
	    {
		bDebug = FALSE;
	    }
	}
    }
}
TIMELINE_EVENT [TL_POLL]
{
    SEND_STRING dvDEVICE, "$A9,$01,$02,$01,$00,$00,$03,$9A" //Pwr Query
}


DEFINE_EVENT
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)



