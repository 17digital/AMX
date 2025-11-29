MODULE_NAME='Hitachi_WX9211' (DEV vdvDEVICE,DEV dvDEVICE)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

LONG TL_POLL 			= 1001;
CHAR MSG_ETX			= $00; //End of Hitachi Message...
CHAR MSG_SRX			= $1D;


CHAR MSG_STX[]			= {$BE,$EF,$03,$06,$00}

DATA_INITIALIZED			= 251;
DATA_SIZE				= 15;

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE LONG lTLProjectorStatus[] = {10000} //10 Seconds

VOLATILE CHAR cProj_Buffer[200];

VOLATILE CHAR bIsInitialized;
VOLATILE INTEGER bPower;
VOLATILE INTEGER bMuted;
VOLATILE CHAR bLamp[4];

VOLATILE CHAR bDebug;

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION SendDeviceString (CHAR iMsg[])
{
    SEND_STRING dvDEVICE, "MSG_STX, iMsg, MSG_ETX";
}
DEFINE_FUNCTION ReInitialize()
{
    bIsInitialized = FALSE;
	[vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;
    
    cProj_Buffer = ""; //Clear Buffer
    
    bPower = FALSE;
	[vdvDEVICE, 255] = bPower;
	    SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-OFFLINE'"
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{
    LOCAL_VAR CHAR cLamp[5];
    LOCAL_VAR INTEGER cLampCount;
    
    bIsInitialized = TRUE;
	[vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;

	    SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-ONLINE'"
    
    SELECT
    {
	ACTIVE (FIND_STRING(iMsg,"$1D,$00,$00",1)) :
	{
	    bPower = FALSE;
		[vdvDevice, 255] = bPower;
		    SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-PWROFF'"
	}
	ACTIVE (FIND_STRING(iMsg,"$1D,$01,$00",1)) :
	{
	    bPower = TRUE;
		[vdvDevice, 255] = bPower;
		    SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-PWRON'"
	}
	ACTIVE (FIND_STRING(iMsg,"$1D,$02,$00",1)) :
	{
	    bPower = FALSE;
		[vdvDevice, 255] = bPower;
		    SEND_COMMAND vdvDEVICE, "'FBPROJECTOR-COOL'"
	}
	// 1C 00 00 Received right after power On
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvDEVICE, cProj_Buffer;

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [dvDEVICE]
{
    ONLINE :
    {
	SEND_COMMAND dvDEVICE, "'SET BAUD 19200,N,8,1,485 DISABLE'"
	
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
    STRING :
    {
	STACK_VAR CHAR iResult[50];
	
	iResult = DATA.TEXT
	    fnParseDeviceResponseString(iResult);
		
		CANCEL_WAIT 'PROJ_COMM'
		WAIT 600 'PROJ_COMM'
		{
		    ReInitialize();
		}
    }
}
CHANNEL_EVENT[vdvDevice, 0]
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 27 : //On
	    {
		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$BA,$D2,$01,$00,$00,$60,$01,$00"
		
		IF (bIsInitialized == TRUE)
		{
		    TIMELINE_PAUSE (TL_POLL)
		    
		    ON [vdvDEVICE, 255]
		    ON [vdvDEVICE, 253]
		    WAIT 350
		    {
			OFF [vdvDEVICE, 253]
			    TIMELINE_RESTART (TL_POLL);
		    }
		}
	    }
	    CASE 28 : //Off
	    {
		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$2A,$D3,$01,$00,$00,$60,$00,$00"
		
		IF (bIsInitialized == TRUE)
		{
		    ON [vdvDEVICE, 254]
		    TIMELINE_PAUSE (TL_POLL)
		
		    WAIT 300
		    {
			OFF [vdvDEVICE, 254]
			    TIMELINE_RESTART (TL_POLL);
				TIMELINE_SET (TL_POLL, lTLProjectorStatus[LENGTH_ARRAY (lTLProjectorStatus)] -100); //Take Timeline to Last Second..
		    }
		}
	    }
	    CASE 30 :
	    {
		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$AE,$D4,$01,$00,$00,$20,$09,$00"
	    }
	    CASE 31 : //Hdmi 1
	    {
		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$0E,$D2,$01,$00,$00,$20,$03,$00"
	    }
	    CASE 32 : //hdmi 2
	    {
		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$6E,$D6,$01,$00,$00,$20,$0D,$00"
	    }
	    CASE 211 : //Video Mute ON..
	    {
		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$63,$92,$01,$00,$05,$24,$01,$00"
	    }
	}
    }
    OFF:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 211 :
	    {
		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$F3,$93,$01,$00,$05,$24,$00,$00"
	    }
	}
    }
}
TIMELINE_EVENT [TL_POLL]
{
    SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$19,$D3,$02,$00,$00,$60,$00,$00" //Query Pwr...
    
//    IF (bPower == TRUE) {
//	WAIT 20 {
//		SEND_STRING dvDevice, "$BE,$EF,$03,$06,$00,$C0,$93,$02,$00,$05,$24,$00,$00"
//	}
//    }
}


