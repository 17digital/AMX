PROGRAM_NAME='VaddioBridge2x1'


DEFINE_DEVICE


dvAvbridge	=    0:4:0 //IP
//dvAvbridge	=	5001:1:0 //Serial


DEFINE_CONSTANT

CHAR MSG_END					= $0D;
CHAR MSG_FD					= $0A;

DATA_INITIALIZED				= 251;

//Av Bridge Stuff....
CHAR AVB_PIP_ON[]				= 'video program pip on'
CHAR AVB_PIP_OFF[]				= 'video program pip off'
CHAR AVB_PIP_GET[]				= 'video program pip get'

IN_AVB_CAMERA					= 1;
IN_AVB_CONTENT					= 2;

//Buttons..
BTN_AVB_PIP_TOGGLE				= 246;
BTN_AVB_SWAP_SOURCE				= 247

(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE


STRUCTURE _AVBStruct
{
    CHAR aURL[128];
    INTEGER aPort;
    CHAR aFlag;
    CHAR aOnline;
}


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _AVBStruct avbStruct;

VOLATILE CHAR nAVBBuffer[1500];

VOLATILE INTEGER nVaddioSuccess_
VOLATILE INTEGER nPIPOn
VOLATILE INTEGER nBGSwap
VOLATILE INTEGER nLogAttempt;

VOLATILE CHAR cUser[5] = 'admin'
VOLATILE CHAR cPassword[8] = 'password'


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnStartAVBConnection()
{
    nVaddioSuccess_ = FALSE;
    SEND_STRING 0, "'Attempt to Start AVBridge Connection...'"
    
    IP_CLIENT_OPEN (dvAvbridge.PORT, avbStruct.aURL, avbStruct.aPort, avbStruct.aFlag)
}
DEFINE_FUNCTION fnCloseAVBConnections()
{
    IP_CLIENT_CLOSE (dvAvbridge.PORT)
}
DEFINE_FUNCTION char[100] GetAVBIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '";
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
	CASE 17 : iReturn = "'Local Port Not Open'";
	
	DEFAULT : iReturn = "'(',ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION fnSendAVBString(CHAR iSend[])
{
    SEND_STRING dvAvbridge, "iSend, MSG_END";
	SEND_STRING 0, "'Sent to AVB-2x1 : ',iSend"
}
DEFINE_FUNCTION fnParseVaddioAVB()
{
    STACK_VAR CHAR iFind[200];
    LOCAL_VAR CHAR iMsg[200]; //Debug Reader...
    STACK_VAR INTEGER cInput;
    LOCAL_VAR CHAR cStatusPIP[15]
    
    WHILE (FIND_STRING (nAVBBuffer, "$0D,$0A",1)) //OR FIND_STRING(nAVBBuffer, 'login:',1))
    {
	iFind = REMOVE_STRING (nAVBBuffer, "$0D,$0A",1)

	iMsg = iFind;
	
	IF (FIND_STRING(iFind,'www.legrandav.com/vaddio',1)) //apart of the login splash page...
	{
	    nVaddioSuccess_ = FALSE;
	    
	    WAIT 20 '2-Seconds'
	    {
		fnSendAVBString (cUser)
			SEND_STRING 0, "'Sent Login ',cUser ,'=====>'"
		WAIT 20
		{
			fnSendAVBString (cPassword)
			    SEND_STRING 0, "'Sent Login ',cPassword ,'=====>'"
		}
	    }
	}
	IF (FIND_STRING (iFind,"'Welcome admin'",1)) 
	{
		nVaddioSuccess_ = TRUE;
		    SEND_STRING 0, "'Vaddio AVBridge 2x1 -Login Success!'"
	}
	IF (FIND_STRING (iFind, "'Login incorrect'",1)) 
	{
	    nVaddioSuccess_ = FALSE;
		nLogAttempt = nLogAttempt +1;
		SEND_STRING 0, "'Login for Vaddio 2x1 Incorrect Attempt 1 of ',ITOA(nLogAttempt)"
	    
	    WAIT 20 'Try Again'
	    {
		fnSendAVBString (cUser)
			SEND_STRING 0, "'Sent Login ',cUser ,'=====>'"
		WAIT 20
		{
			fnSendAVBString (cPassword)
			    SEND_STRING 0, "'Sent Login ',cPassword ,'=====>'"
		}
	    }
	    //After Incorrect login - 
	    //vaddio-av-bridge-2x1-Mac-Address login: //Will result...with no Carriage Return
	}
	IF (FIND_STRING (iFind,'video program source set input',1)) //Direct Change FB...
	{
	   nVaddioSuccess_ = TRUE;
	   REMOVE_STRING (iFind,'video program source set input',1)
	    cInput = ATOI(LEFT_STRING(iFind,1))
	    
	    SWITCH (cInput)
	    {
		CASE IN_AVB_CAMERA :
		{
		    nBGSwap = FALSE;
			OFF [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
		}
		CASE IN_AVB_CONTENT :
		{
		    nBGSwap = TRUE;
			ON [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
		}
	    }
	}
	IF (FIND_STRING (iFind, "'source: input'",1))
	{
	    nVaddioSuccess_ = TRUE;
	    REMOVE_STRING(iFind,'source: input',1)
		//cCamIDX  = ATOI(LEFT_STRING (iFind,1)) //Only need Remaing #
		    cInput  = ATOI(LEFT_STRING (iFind,1)) //Only need Remaing #
		
	    SWITCH (cInput)
	    {
		CASE IN_AVB_CAMERA :
		{
		    //[vdvTP_Main, BTN_CAM_PWR] = nCamOnline_Rear;
			//ON [vdvTP_Main, BTN_CAM_REAR]
			nBGSwap = FALSE;
			OFF [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
		}
		CASE IN_AVB_CONTENT :
		{
		    //[vdvTP_Main, BTN_CAM_PWR] = nCamOnline_Front;
			//ON [vdvTP_Main, BTN_CAM_FRONT]
			nBGSwap = TRUE;
			ON [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
		}
	    }
	}
	IF (FIND_STRING (iFind,'video program pip ',1)) //Direct On FB...
	{
	    nVaddioSuccess_ = TRUE;
	    REMOVE_STRING (iFind,'video program pip ',1)
	    cStatusPIP = iFind;
	    
	    IF (FIND_STRING(cStatusPIP,'on',1))
	    {
		nPIPOn = TRUE;
			ON [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	    IF (FIND_STRING(cStatusPIP,'off',1))
	    {
		    nPIPOn = FALSE;
			    OFF [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	}
	IF (FIND_STRING (iFind, 'pip:    ',1)) //From PIP Get Query Response
	{
	    nVaddioSuccess_ = TRUE;
	    
	    REMOVE_STRING (iFind, 'pip:    ',1)
		cStatusPIP = iFind;
	    IF (FIND_STRING(cStatusPIP,'on',1))
	    {
		    nPIPOn = TRUE;
			ON [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	    IF (FIND_STRING(cStatusPIP,'off',1))
	    {
		    nPIPOn = FALSE;
			    OFF [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
	    }
	}
    }
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

avbStruct.aURL = 'weberl4avbridge.amx.uno.edu'
avbStruct.aPort = 23;
avbStruct.aFlag = IP_TCP;

CREATE_BUFFER dvAvbridge, nAVBBuffer;

WAIT 100
{
    fnStartAVBConnection();
}


DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_AVB_PIP_TOGGLE]
{
    PUSH :
    {
	IF (nPIPOn == FALSE)
	{
	    fnSendAVBString (AVB_PIP_ON)
	}
	ELSE
	{
	    fnSendAVBString (AVB_PIP_OFF)
	}    
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_AVB_SWAP_SOURCE]
{
    PUSH :
    {
	IF (nBGSwap == FALSE)
	{
	    fnSendAVBString ("'video program source set input',ITOA(IN_AVB_CONTENT)")
	}
	ELSE
	{
	    fnSendAVBString ("'video program source set input',ITOA(IN_AVB_CAMERA)")
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvAvbridge]
{
    ONLINE :
    {
	avbStruct.aOnline = TRUE;
    }
    OFFLINE :
    {
	avbStruct.aOnline = FALSE;
    }
    ONERROR :
    {
		AMX_LOG (AMX_ERROR, "'dvAvbridge : onerror: ',GetAVBIpError(DATA.NUMBER)");
	Send_String 0,"'AVBridge onerror : ',GetAVBIpError(DATA.NUMBER)"; 

	SWITCH (DATA.NUMBER)
	{
	    CASE 7 : //Connection Time Out...
	    {
		avbStruct.aOnline = FALSE;
		    fnStartAVBConnection()
	    }
	    DEFAULT :
	    {
		ShureStruct.sOnline = FALSE;
	    }
	}
    }
    STRING :
    {
	avbStruct.aOnline = TRUE;
	    fnParseVaddioAVB()
    }
}
TIMELINE_EVENT [TL_FEEDBACK] //Created on Main Program File....
{
    WAIT 200
    {
	IF (avbStruct.aOnline == FALSE)
	{
	    fnStartAVBConnection()
	}
	ELSE IF (nVaddioSuccess_ == TRUE)
	{
	    fnSendAVBString ('video program source get')
	}
	ELSE
	{
	    //We Wait till logged in...
	}
    }
}

