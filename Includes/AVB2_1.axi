PROGRAM_NAME='AVB2_1'

DEFINE_DEVICE

#IF_NOT_DEFINED vdvAvbridge
vdvAvbridge				= 35992:1:0
#END_IF

DEFINE_CONSTANT

CHAR AVB_IP_HOST[]				= 'parb126avbridge.amx.gatech.edu' // 

//Av Bridge Stuff....
CHAR AVB_PIP_ON[]					= 'video program pip on'
CHAR AVB_PIP_OFF[]					= 'video program pip off'
CHAR AVB_PIP_GET[]					= 'video program pip get'

IN_AVB_CAMERA						= 1;
IN_AVB_CONTENT						= 2;

//Buttons..
BTN_AVB_PIP_TOGGLE				= 246;
BTN_AVB_SWAP_SOURCE			= 247;
BTN_AVB_PIP_LAYOUT				= 248;

(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE


STRUCTURE _AVBStruct
{
    CHAR aURL[100];
    CHAR aOnline;
    INTEGER aVaddioSuccess;
    INTEGER aActiveInput;
    CHAR aPIPOn[3];
    INTEGER aDbug;
}
(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _AVBStruct avbVaddio;

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  




(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

avbVaddio.aURL = AVB_IP_HOST;

DEFINE_MODULE 'Vaddio_2X1_IP_Comm' VADDIOAVB(vdvAvbridge, dvAvbridge, avbVaddio.aURL);


DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, BTN_AVB_PIP_TOGGLE]
BUTTON_EVENT [dvTP_Main, BTN_AVB_SWAP_SOURCE]
BUTTON_EVENT [dvTP_Main, BTN_AVB_PIP_LAYOUT]
{
    PUSH :
    {
	    PULSE [vdvAvbridge,  BUTTON.INPUT.CHANNEL];
    }
}

DEFINE_EVENT 
CHANNEL_EVENT [vdvAvbridge, POWER]
{
    ON :
    {
	avbVaddio.aOnline = TRUE;
    }
    OFF :
    {
	avbVaddio.aOnline = FALSE;
    }
}

DEFINE_EVENT
DATA_EVENT [vdvAvbridge]
{
    COMMAND :
    {
	STACK_VAR CHAR iStatus[50];
	    STACK_VAR INTEGER b;
	
	iStatus = DATA.TEXT;
	
	IF (FIND_STRING(iStatus,'INPUT-',1)) {
	    REMOVE_STRING (iStatus, '-',1);
		avbVaddio.aActiveInput = ATOI(iStatus);
		    cIndexCamera = avbVaddio.aActiveInput;
		    ON [dvTP_Main, nCameraBtns[avbVaddio.aActiveInput]];
		    
	    [dvTP_Main, BTN_CAM_PWR] = vaddioStruct[cIndexCamera].uOnline
	}
	IF (FIND_STRING(iStatus,'PIP-',1)) {
		REMOVE_STRING (iStatus, '-',1);
		
		avbVaddio.aPIPOn = iStatus;
	    SWITCH (iStatus)
	    {
		CASE 'ON' : {
		    ON [dvTP_Main, BTN_AVB_PIP_TOGGLE];
		}
		CASE 'OFF' : {
		    OFF [dvTP_Main, BTN_AVB_PIP_TOGGLE];
		}
	    }
	}
    }
}






