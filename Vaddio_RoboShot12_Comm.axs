MODULE_NAME='Vaddio_RoboShot12_Comm' (DEV VIRTUAL, DEV REAL)
(***********************************************************)
(*  FILE CREATED ON: 10/22/2016  AT: 16:58:24              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/29/2017  AT: 12:05:42        *)
(***********************************************************)

(*
//Favorites...
"'>1TC=7-1',$0D //One of the favorites...
	    *)

DEFINE_CONSTANT

LONG TL_CAMERA 			= 20;
CHAR MSG_ETX			= $FF; //End of Vaddio Command..

DATA_INITIALIZED			= 251

DEFINE_VARIABLE

VOLATILE LONG lTLCameraStatus[] = {15000}; //15 Second Poll...
VOLATILE CHAR c_Buffer[100]
VOLATILE CHAR cVaddioMsg[100]

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
    
    c_Buffer = ""; //Clear Buffer
    
    bPower = FALSE;
    	    OFF [VIRTUAL, 251]
		SEND_COMMAND VIRTUAL, "'FBCAMERA-OFFLINE'"
}
DEFINE_FUNCTION fnParseDeviceResponseString(CHAR iMsg[])
{
    bIsInitialized = TRUE;
    [VIRTUAL, DATA_INITIALIZED] = bIsInitialized;

    ON [VIRTUAL, 252]
	ON [VIRTUAL, 251]
	    SEND_COMMAND VIRTUAL, "'FBCAMERA-ONLINE'"
    
    SELECT
    {
	ACTIVE(FIND_STRING(iMsg,"$90,'P',$02,$FF",1)): //Status Query On
	{
	    ON [VIRTUAL, 255]
		SEND_COMMAND VIRTUAL, "'FBPOWER-ON'"
		    bPower = TRUE;
	}
	ACTIVE(FIND_STRING(iMsg,"$90,'P',$03,$FF",1)): //Status Query Off
	{
	    OFF [VIRTUAL, 255]
		SEND_COMMAND VIRTUAL, "'FBPOWER-OFF'"
		    bPower = FALSE;
	}
    }
} 

DEFINE_START

CREATE_BUFFER REAL,c_Buffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [REAL]
{
    ONLINE :
    {
	SEND_COMMAND REAL, "'SET BAUD 9600,N,8,1 485 DISABLE'"
	    SEND_COMMAND REAL, "'RXON'"
		SEND_COMMAND REAL, "'HSOFF'"
	
	IF (!TIMELINE_ACTIVE (TL_CAMERA))
	 {
	    TIMELINE_CREATE(TL_CAMERA,lTLCameraStatus,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	}
    }
    OFFLINE :
    {
	ReInitialize();
    }
    STRING :
    {	    
	WHILE (FIND_STRING(c_Buffer, "MSG_ETX",1))
	{
	    STACK_VAR CHAR iResult[25];
		iResult = REMOVE_STRING (c_Buffer, "MSG_ETX",1);
		
		fnParseDeviceResponseString(iResult);
	}
    }
}
DATA_EVENT [VIRTUAL]
{
    COMMAND :
    {
	STACK_VAR INTEGER cSTR; //Memory Recall
	STACK_VAR INTEGER cSTS; //Memory Save
	
        CHAR cVaddioMsg[100];
	cVaddioMsg = DATA.TEXT;
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cVaddioMsg,'CAMERAPRESET-',1)):
	    {
		REMOVE_STRING(cVaddioMsg,'-',1) //Removes everything up to and including the hyphen
		    cSTR = ATOI(cVaddioMsg)
		
		SWITCH (cSTR)
		{
		    CASE 1 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$01,$FF"
		    CASE 2 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$02,$FF"
		    CASE 3 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$03,$FF"
		    CASE 4 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$04,$FF"
		    CASE 5 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$05,$FF"
		    CASE 6 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$06,$FF"
		    CASE 7 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$07,$FF"
		    CASE 8 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$08,$FF"
		    CASE 9 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$09,$FF"
		    CASE 10 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$0A,$FF"
		    CASE 11 : SEND_STRING REAL, "$81,$01,$04,$3F,$02,$0B,$FF"
		}
	    }
	    ACTIVE(FIND_STRING(cVaddioMsg,'CAMERAPRESETSAVE-',1)):
	    {
		REMOVE_STRING(cVaddioMsg,'-',1) //Removes everything up to and including the hyphen
		    cSTS = ATOI(cVaddioMsg)
		
		SWITCH (cSTS)
		{
		    CASE 1 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$01,$FF"
		    CASE 2 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$02,$FF"
		    CASE 3 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$03,$FF"
		    CASE 4 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$04,$FF"
		    CASE 5 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$05,$FF"
		    CASE 6 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$06,$FF"
		    CASE 7 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$07,$FF"
		    CASE 8 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$08,$FF"
		    CASE 9 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$09,$FF"
		    CASE 10 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$0A,$FF"
		    CASE 11 : SEND_STRING REAL, "$81,$01,$04,$3F,$01,$0B,$FF"
		}
	    }
	}
    }
}
CHANNEL_EVENT[VIRTUAL, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 11 : //Flip On...
	    {
		SEND_STRING REAL, "$81,$01,$04,$66,$02,$FF"
	    }
	    CASE 12 : //Flip Off
	    {
		SEND_STRING REAL, "$81,$01,$04,$66,$03,$FF"
	    }
	    CASE 27 : //Direct On...
	    {
		SEND_STRING REAL, "$81,$01,$04,$00,$02,$FF"
	    }
	    CASE 28 : //Direct Off...
	    {
		SEND_STRING REAL, "$81,$01,$04,$00,$03,$FF"
	    }
	    CASE 97 : //Auto Focus On...
	    {
		SEND_STRING REAL, "$81,$01,$04,$38,$02,$FF"
	    }
	    CASE 98 : //White Balance Auto On..
	    {
		SEND_STRING REAL, "$81,$01,$04,$35,$00,$FF"
	    }
	    CASE 99 : //Home Position
	    {
		SEND_STRING REAL, "$81,$01,$06,$0C,$FF"
	    }
	    CASE 100 : //Stop All Movement (Pan, Tilt, Zoom)
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$09,$09,$04,$03,$03,$03,$FF"
	    }
	    CASE 132 : //Tilt Up
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$09,$09,$04,$03,$01,$03,$FF" //Pan-Tilt-ZoomDrive
		    //SEND_STRING REAL, "$81,$01,$06,$01,$09,$09,$03,$01,$FF" //Pan-TiltDrive
	    }
	    CASE 133 : //Tilt Dn
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$09,$09,$04,$03,$02,$03,$FF"
		    //SEND_STRING REAL, "$81,$01,$06,$01,$09,$09,$03,$02,$FF"
	    }
	    CASE 134 : //Pan Left..
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$09,$09,$01,$01,$03,$03,$FF"
		//SEND_STRING REAL, "$81,$01,$06,$01,$09,$09,$01,$03,$FF"
	    }
	    CASE 135 : //Pan Right
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$09,$09,$01,$02,$03,$03,$FF"
		    //SEND_STRING REAL, "$81,$01,$06,$01,$09,$09,$02,$03,$FF"
	    }
	    CASE 158 : //Zoom In..
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$01,$01,$02,$03,$03,$01,$FF"
	    }
	    CASE 159 : 
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$01,$01,$02,$03,$03,$02,$FF"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE 132 : 
	    CASE 133 : 
	    CASE 134 : 
	    CASE 135 : //Stop Pan, Tilt
	    CASE 158 :
	    CASE 159 : //Stop Zooming...
	    {
		SEND_STRING REAL, "$81,$01,$06,$0A,$09,$09,$04,$03,$03,$03,$FF" //Stop Moving All
	    }
	    CASE 255 :
	    {
		//
	    }
	}
    }
}
TIMELINE_EVENT [TL_CAMERA]
{
   SEND_STRING REAL, "$81,$09,$04,$00,$FF" //Pwr Query...
}


