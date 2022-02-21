MODULE_NAME='Sony_FWD65x750D'(DEV vdvDevice,DEV dvDevice)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/15/2020  AT: 14:53:51        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    Notes!!
    To Turn on the TV, first set standby command as Enable. After this, the set can receive Power On Command
*)    

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

LONG TL_POLL 			= 1;
CHAR MSG_ETX			= $0D; //End of Message....N/A for TV!!

DATA_INITIALIZED			= 251;


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE LONG lTLTelevisionStatus[] = {15000} //15 Seconds

VOLATILE CHAR cTV_Buffer[100];

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
DEFINE_FUNCTION ReInitialize()
{
    bIsInitialized = FALSE;
	[vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;
    
    cTV_Buffer = ""; //Clear Buffer
    
    bPower = FALSE;
    	    OFF [vdvDEVICE, DATA_INITIALIZED]
		SEND_COMMAND vdvDEVICE, "'FBTELEVISION-OFFLINE'"
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{    
    bIsInitialized = TRUE;
	[vdvDEVICE, DATA_INITIALIZED] = bIsInitialized;

    ON [vdvDEVICE, 252]
	    SEND_COMMAND vdvDEVICE, "'FBTELEVISION-ONLINE'"
    
    SELECT
    {
	ACTIVE (FIND_STRING(iMsg, "'p',$00,$02,$00,'r'",1)) :
	{
	    OFF [vdvDEVICE, 255]
		SEND_COMMAND vdvDEVICE, "'FBTELEVISION-PWROFF'"
		    bPower = FALSE;
	}
	ACTIVE (FIND_STRING(iMsg, "'p',$00,$02,$01,'s'",1)) :
	{
	    ON [vdvDEVICE, 255]
		SEND_COMMAND vdvDEVICE, "'FBTELEVISION-PWRON'"
		    bPower = TRUE;
	}
	ACTIVE (FIND_STRING (iMsg, "'p',$00,$03,$04,$01,'x'",1)): //Full String
	{
	    SEND_COMMAND vdvDevice, "'FBTELEVISION-HDMI,1'"
	}
	ACTIVE (FIND_STRING (iMsg, "'p',$00,$03,$04,$02,'y'",1)): //
	{
	    SEND_COMMAND vdvDevice, "'FBTELEVISION-HDMI,2'"
	}
	ACTIVE (FIND_STRING (iMsg, "'p',$00,$03,$04,$03,'z'",1)): //
	{
	    SEND_COMMAND vdvDevice, "'FBTELEVISION-HDMI,3'"
	}
	ACTIVE (FIND_STRING (iMsg, "'p',$00,$03,$04,$04,'{'",1)): //Full String
	{
	    SEND_COMMAND vdvDevice, "'FBTELEVISION-HDMI,4'"
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvDevice,cTV_Buffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [dvDevice]
{
    ONLINE :
    {
	SEND_COMMAND dvDevice, "'SET BAUD 9600,N,8,1,485 DISABLE'"
	    SEND_COMMAND dvDEVICE, "'RXON'"
		SEND_COMMAND dvDEVICE, "'HSOFF'"
    
	IF (!TIMELINE_ACTIVE (TL_POLL))
	{
	    TIMELINE_CREATE(TL_POLL,lTLTelevisionStatus,LENGTH_ARRAY (lTLTelevisionStatus),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	}
    }
    OFFLINE :
    {
	ReInitialize()
    }
    STRING:
    {
	STACK_VAR CHAR iResult[50];
	    iResult = DATA.TEXT;
		
	fnParseDeviceResponseString(iResult);
		
	IF (bDebug == TRUE )
	{
	    SEND_STRING 0, "__FILE__, 'DATA_EVENT [dvDEVICE] {STRING : ',DATA.TEXT"
	}
    }
}
DATA_EVENT [vdvDevice]
{
    COMMAND :
    {
    	LOCAL_VAR CHAR cSTR[10]; //Video Input Recall
	    
	CHAR cTVMsg[50];
	    cTVMsg = DATA.TEXT

	IF (FIND_STRING(cTVMsg,'INPUT-',1))
	{
	    REMOVE_STRING(cTVMsg,'-',1)
	    cSTR = cTVMsg;
	    
	    SWITCH (cSTR)
	    {
		CASE 'VGA,1' : //PC
		{
		    SEND_STRING dvDevice, "$8C,$00,$02,$03,$05,$01,$97" 
		}
		CASE 'HDMI,1' :
		{
		    SEND_STRING dvDevice, "$8C,$00,$02,$03,$04,$01,$96"
		}
		CASE 'HDMI,2' :
		{
		    SEND_STRING dvDevice, "$8C,$00,$02,$03,$04,$02,$97"
		}
		CASE 'HDMI,3' :
		{
		    SEND_STRING dvDevice, "$8C,$00,$02,$03,$04,$03,$98"
		}
		CASE 'HDMI,4' :
		{
		    SEND_STRING dvDevice, "$8C,$00,$02,$03,$04,$04,$99"
		}
	    }
	}
    }
}
CHANNEL_EVENT[vdvDevice, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 24 : //Volume Up
	    {
		SEND_STRING dvDevice, "$8C,$00,$05,$03,$00,$00,$94"
	    }
	    CASE 25 : //Volume Down..
	    {
		SEND_STRING dvDevice, "$8C,$00,$05,$03,$00,$01,$95"
	    }
	    CASE 27 : //Tv On..
	    {
		SEND_STRING dvDevice, "$8C,$00,$00,$02,$01,$8F"
		
		IF(bIsInitialized == TRUE)
		{
		    TIMELINE_PAUSE (TL_POLL)
		    
		    ON [vdvDevice, 255]
		    ON [vdvDevice, 253]
		    
		    WAIT 70
		    {
			OFF [vdvDevice, 253]
			    TIMELINE_RESTART (TL_POLL);
		    }
		}
	    }
	    CASE 28 :
	    {
		SEND_STRING dvDevice, "$8C,$00,$01,$02,$01,$90" //StandBy Enabled 
		WAIT 10 SEND_STRING dvDevice, "$8C,$00,$00,$02,$00,$8E"
		
		IF (bIsInitialized == TRUE)
		{
		    ON [vdvDevice, 254]
			TIMELINE_PAUSE (TL_POLL)

		    WAIT 50
		    {
			OFF [vdvDevice, 254]
			    TIMELINE_RESTART (TL_POLL);
				TIMELINE_SET (TL_POLL, lTLTelevisionStatus[LENGTH_ARRAY (lTLTelevisionStatus)] -100); //Take Timeline to Last Second..
		    }
		}
	    }
	    CASE 138 : //Volume Preset...
	    {
		//SEND_STRING dvDevice, "$8C,$00,$05,$03,$01,$32,$C7" //32 =50%
		SEND_STRING dvDevice, "$8C,$00,$05,$03,$01,$18,$AD" //18 =38% ??
	    }
	    CASE 199 : //Mute On..
	    {
		SEND_STRING dvDevice, "$8C,$00,$06,$03,$01,$01,$97"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 199 : //Mute Off
	    {
		SEND_STRING dvDevice, "$8C,$00,$06,$03,$01,$00,$96"
	    }
	}
    }
}

TIMELINE_EVENT [TL_POLL]
{
    SEND_STRING dvDevice, "$83,$00,$00,$FF,$FF,$81" //Power Status... (83 = Query Header!!)
    
    WAIT 20
    {
	IF (bPower == TRUE)
	{
	    SEND_STRING dvDevice, "$83,$00,$02,$FF,$FF,$83" //Video Input Status...
	}
    }
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
