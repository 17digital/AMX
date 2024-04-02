PROGRAM_NAME='BlackMagicHubIP'

(*
----- Set Take Mode to False! -

CONFIGURATION:
Take Mode: false

Upon Inital Connection - should give you device info or "PREAMBLE"
-- PROTOCOL PREAMBLE:
-- Version:2.8
-- VIDEOHUB DEVICE:
-- Device preset: true
-- Model name:
-- Friendly name:
-- Unique ID: 7C2E0303
--VIDEO OUTPUT ROUTING:
--0 6
--1 3
--2 6
--3 4
--4 3
--5 7
--6 1
--7 6
--8 3
--9 1
--CONFIGURATION:
--Take Mode: false
-- END PRELUDE:

Example - change 3 Outputs to same input....

VIDEO OUTPUT ROUTING:
0 0
1 0
2 0

ACK
*)

DEFINE_DEVICE

#IF_NOT_DEFINED dvBlackMagic
dvBlackMagic =			5001:1:0 //Black Magic 20x20
#END_IF

DEFINE_CONSTANT

#IF_NOT_DEFINED __COMMON_ASCII__
#DEFINE __COMMON_ASCII__
CHAR CR 					= $0D;
CHAR LF 					= $0A;
CHAR ESC					= $1B;
#END_IF

CHAR BM_IP[]					= 'seb122switcher.amx.gatech.edu'
BM_PORT					= 9990;

//BlackMagic Video Routing...
SOURCE_CAMERA_FRONT		= 1 //Between TV's - Front of Room
SOURCE_CAMERA_FRONT_RIGHT	= 2 //House Right Front - Above AV Rack
SOURCE_CAMERA_REAR			= 3 //
SOURCE_CAMERA_FRONT_LEFT	= 4
SOURCE_CAMERA_REAR_RIGHT	= 5 //Standing from rear Looking into room
SOURCE_CAMERA_REAR_LEFT	= 6

DESTINATION_REC				= 3 //Physical Source (Virtual =2)
DESTINATION_USB				= 8 //Physical Source  (Virtual = 7)

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _BM_STRUCT
{
    CHAR iURL[128];
    INTEGER iPort;
    CHAR iFlag;
    INTEGER iOnline;
}


DEFINE_VARIABLE

VOLATILE _BM_STRUCT uMagic;
VOLATILE CHAR nBMBuffer[2500];



(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartSwitcherIPConnection()
{
    uMagic.iURL = BM_IP;
    uMagic.iPort = BM_PORT;
    uMagic.iFlag = IP_TCP;
    
    SEND_STRING 0, "'Connect to Black Magic Video Hub Connection...'"
    
    WAIT 20 {
	IP_CLIENT_OPEN (dvBlackMagic.PORT, uMagic.iURL, uMagic.iPort, uMagic.iFlag);
    }
}
DEFINE_FUNCTION fnStopSwitcherIPConnection()
{
    IP_CLIENT_CLOSE (dvBlackMagic.PORT);
}
DEFINE_FUNCTION char[100] GetSwitcherIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '" ;
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
	CASE 17 : iReturn = "'Local Port Not Open'"
	
	DEFAULT : iReturn = "'(', ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION fnBlackMagicSwitch(INTEGER cIn)
{
    SEND_STRING dvBlackMagic, "'VIDEO OUTPUT ROUTING:',LF,ITOA(DESTINATION_USB -1),' ',ITOA(cIn -1),LF,ITOA(DESTINATION_REC -1),' ',ITOA(cIn -1),LF,LF"
}
DEFINE_FUNCTION fnBlackMagicSwitchRec(INTEGER cIn)
{
    SEND_STRING dvBlackMagic, "'VIDEO OUTPUT ROUTING:',LF,ITOA(DESTINATION_REC -1),LF,LF"
}
DEFINE_FUNCTION fnParseSwitcherIP(CHAR iResult[1500])
{
    LOCAL_VAR CHAR iLipton[1500];
    LOCAL_VAR INTEGER cDestination;
    LOCAL_VAR INTEGER cHubIn;
    LOCAL_VAR INTEGER cTest;
    
    SELECT
    {
	ACTIVE (FIND_STRING(iResult, "'VIDEO OUTPUT ROUTING:'",1)) : {
	
	    REMOVE_STRING (iResult, "':'",1)
	    
	    IF (LENGTH_STRING(iResult) > 10) {   //We have a full Route table Read...
		
		iLipton = iResult;
		    SEND_STRING 0, "'VideoHub Routing : ',iLipton";
		    
		    cDestination = ATOI(MID_STRING(iResult, 10, 1));
		    cHubIn = ATOI(MID_STRING(iResult, 12, 1));
		
		cTest = cHubIn + 1; //To Align Array Properly
		nVaddioCameraSelect = cHubIn + 1;
		    ON [vdvTP_Main, nCameraVaddioBtns[nVaddioCameraSelect]];
			[vdvTP_Main, BTN_CAM_PWR] = vaddioStruct[nVaddioCameraSelect].uPwr;
		
	    }
	    ELSE IF (LENGTH_STRING(iResult) < 10) { //Montoring 1 Input Change
		//We have a direct route change
		
		iLipton = iResult;
		    SEND_STRING 0, "'VideoHub : ',iLipton";
		    
		cDestination = ATOI(MID_STRING(iResult, 2, 1)); 
		    cHubIn = ATOI(MID_STRING(iResult, 4, 1));
		    
		    nVaddioCameraSelect = cHubIn + 1;
		    ON [vdvTP_Main, nCameraVaddioBtns[nVaddioCameraSelect]];		
	    }
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvBlackMagic, nBMBuffer;

DEFINE_EVENT 
DATA_EVENT [dvBlackMagic]
{
    ONLINE :
    {
	uMagic.iOnline = TRUE;
    }
    OFFLINE :
    {
	uMagic.iOnline = FALSE;
    }
    ONERROR :
    {
	uMagic.iOnline = FALSE;
	    SEND_STRING 0, "'Black Magic Hub Onerror : ',GetSwitcherIpError(DATA.NUMBER)";
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14: //Already Open
	    {
		WAIT 20 {
		    fnStopSwitcherIPConnection();
		}
	    }
	    CASE 17 : //Port Not Opened
	    {
		WAIT 50 {
		    fnStartSwitcherIPConnection();
		}
	    }
	}
    }
    STRING :
    {
	WHILE (FIND_STRING(nBMBuffer, "LF,LF",1)) {
	    
	    STACK_VAR CHAR iSandwich[1500];
	    
	    iSandwich = REMOVE_STRING(nBMBuffer, "LF,LF",1)
		uMagic.iOnline = TRUE;
		
		    fnParseSwitcherIP(iSandwich);
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 450 {
	IF (uMagic.iOnline == FALSE) {
	    fnStartSwitcherIPConnection();
	}
	ELSE {
	    //SEND_STRING dvBlackMagic, "'PING:',LF,LF"
	    SEND_STRING dvBlackMagic, "'VIDEO OUTPUT ROUTING:',LF" 
		WAIT 10 {
		    SEND_STRING dvBlackMagic, "LF"
		}
	    //SEND_STRING dvBlackMagic, "'PING:',LF,LF"
	}
    }
}
	
    
