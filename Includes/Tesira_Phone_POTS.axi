PROGRAM_NAME='Tesira_Phone2'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/12/2017  AT: 13:08:11        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Notes
	https://support.biamp.com/Tesira/Control/Tesira_command_string_calculator
	
	?? RIBED$0D$0A - Returning Feedback
	
	"'SESSION set verbose true',$0A"
	"'SESSION set detailedResponse true',$0A"
	
	Output 1 = Vadio..
	Output 2 = Ceiling...
	Output 4 = Front Speakers
	
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Biamp
dvTP_Biamp =					10001:5:0
#END_IF

#IF_NOT_DEFINED dvTesira
dvTesira =						5001:3:0 //Tesira
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR BIAMP_TYPE[]		= 'Tesira TI';
CHAR BIAMP_TI_NUM[]		 = '404-385-5721'

//RMS Stuff...
BIAMP_INITIALIZED			= 251;
HOLD_MAC_ADDRESS		= 17;
HOLD_IP_ADDRESS			= 15;

MAX_COMP				= 88 //Biamp | Value= 1120 | Level=  12

VOL_UP					= 1;
VOL_DN					= -1;

//Biamp ID's
ID_PRGM_LEV				= 1
ID_CEILING				= 1 //Logic Block
ID_RINGER				= 1;

//Biamp Tags...
//TAG_MUTE_PRGM			= 'ProgramMute'
TAG_MUTE_PRGM			= 'Program' //I cheated
TAG_LEV_PRGM			= 'Program'
TAG_TI					= 'TIControlStatus1'
TAG_CEILING				= 'privacymute'
TAG_CALLING				= 'Calling' //For Phone call Subscription...
TAG_MUTE_RINGER			= 'ringermute'

YES_ON					= 'true'
YES_OFF					= 'false'

//Txt Fields..
TXT_MYPHONE			= 20
TXT_SIPDISAPLAY_NAME	= 22
TXT_CID_NUMBER			= 19
TXT_CID_NAME			= 18
TXT_PHONE_STATE			= 21
TXT_NUMBER_DISPLAY		= 17

TXT_PRGM				= 10

//Buttons...
BTN_MUTE_CEILING		= 50
BTN_MUTE_RINGER		= 60

#IF_NOT_DEFINED MSG_ETX 
CHAR MSG_ETX			= $0D;
#END_IF

#IF_NOT_DEFINED MSG_LF
CHAR MSG_LF			= $0A;
#END_IF

(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _BiampStruct
{
    CHAR bHost[20];
    CHAR bMacAddress[HOLD_MAC_ADDRESS];
    CHAR bIPAddress[HOLD_IP_ADDRESS];
    CHAR bSerial[10];
    CHAR bFirmware[12];
    INTEGER bBiampOnline;
}
STRUCTURE _BiampPrgm
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
}
STRUCTURE _BiampPhone
{
    CHAR bMyPhone[15];
    CHAR bLastNumber[20];
    CHAR bIncomingCall[20];
    INTEGER bPhoneState;
    INTEGER bSubscribed;
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR bFound[20];

_BiampStruct MyBiampStruct;
_BiampPrgm BiampPrgm;
_BiampPhone BiampPhone;

VOLATILE SINTEGER nMaximum = 12
VOLATILE SINTEGER nMinimum = -88

VOLATILE CHAR nAudioBuffer[1000];

VOLATILE SINTEGER nProgram_Preset = -22; //Set Default Level

VOLATILE INTEGER nCeiling_Mute;
VOLATILE INTEGER nMuteRinger;

VOLATILE CHAR dialPhone[20] //Dialer1

VOLATILE DEV vdvTP_Biamp[] = 
{
    dvTP_Biamp 
}
VOLATILE INTEGER nPrgmBtns[] =
{    
    //Program...
    37,38,39,40
};

    
(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnMuteLogic(CHAR cTag[], INTEGER cIn, CHAR cToggle[])
{
    SEND_STRING dvTesira, "cTag,' set state ',ITOA(cIn),' ',cToggle,MSG_ETX" 
}
DEFINE_FUNCTION fnMuteChannel(CHAR cTag[], INTEGER cIn, CHAR cValue[])
{
    SEND_STRING dvTesira, "cTag,' set mute ',ITOA(cIn),' ',cValue,MSG_ETX"
}
DEFINE_FUNCTION fnSetVolumeUp(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    IF (cLev < nMaximum )
    {
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA( cLev + VOL_UP),MSG_ETX"
    }
}
DEFINE_FUNCTION fnSetVolumeDown(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    IF (cLev > nMinimum )
    {
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev + VOL_DN),MSG_ETX"
    }
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev),MSG_ETX"
}
DEFINE_FUNCTION fnSubscribeCalls()
{
    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MYPHONE),',0,',BIAMP_TI_NUM"
    
    IF (BiampPhone.bSubscribed == FALSE)
    {
	SEND_STRING dvTesira, "TAG_TI,' subscribe callState ',TAG_CALLING,MSG_ETX"
	WAIT 50
	{
	    SEND_STRING dvTesira, "TAG_TI,' get hookState',MSG_ETX"
	}
    }
    ELSE
    {
	SEND_STRING dvTesira, "TAG_TI,' get hookState',MSG_ETX"
    }
}
DEFINE_FUNCTION fnSetPresetVar()
{
    //Declare Starting Presets....   
    BiampPrgm.bPreset = nProgram_Preset;
    BiampPhone.bMyPhone = BIAMP_TI_NUM;
}
DEFINE_FUNCTION fnResetAudio()
{
    fnSetPresetVar();
    
    WAIT 20 fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_OFF);
    WAIT 40 fnSetVolumePreset (TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bPreset);
    WAIT 60 fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF); //Let's mute this by default shall we???
    WAIT 70 fnMuteChannel (TAG_MUTE_RINGER, ID_RINGER, YES_OFF);
    
    WAIT 80 SEND_STRING dvTesira, "'DEVICE get ipStatus control',MSG_ETX"
    WAIT 100 SEND_STRING dvTesira, "'DEVICE get hostname',MSG_ETX"
	
    WAIT 120 SEND_STRING dvTesira, "'DEVICE get serialNumber',MSG_ETX"
	
    WAIT 150 SEND_STRING dvTesira, "'DEVICE get version',MSG_ETX"
        
    WAIT 190 fnSubscribeCalls();
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[500] 
    LOCAL_VAR CHAR cRemoteNum[10]//Caller's Number (incoming/Outgoing)
    LOCAL_VAR CHAR cRemoteID[30] //Caller's Name Info
    
    LOCAL_VAR CHAR cMsg[4]
    LOCAL_VAR CHAR cState[5]
    LOCAL_VAR CHAR cNetHelp[50];
    LOCAL_VAR CHAR cMute[2];
    LOCAL_VAR CHAR cSource[2];
    LOCAL_VAR CHAR cCallState[5]; //RING,IDLE,DIAL,

    WHILE(FIND_STRING(nAudioBuffer,"$0D,$0A",1))
    {	
	cResponse = REMOVE_STRING(nAudioBuffer,"$0D,$0A",1)
	    MyBiampStruct.bBiampOnline = TRUE;
    
	SELECT
	{
	    ACTIVE (FIND_STRING(cResponse,'Welcome to the Tesira Text Protocol Server...',1)):
	    {
		SEND_STRING 0, "'Tesira has booted and now Ready'"
			//Load Presets....
			    fnResetAudio();
	    }
	    ACTIVE (FIND_STRING(cResponse,'+OK "value":{"macAddress":"',1)) :
	    {
		REMOVE_STRING (cResponse,'+OK "value":{"macAddress":"',1)
		    MyBiampStruct.bMacAddress = LEFT_STRING (cResponse, HOLD_MAC_ADDRESS)
		//
		REMOVE_STRING (cResponse,'"ip":"',1)
		
		cNetHelp = REMOVE_STRING (cResponse,'" "netmask":"',1)
		//cHelper = cHelp1; //Should give me IP + netmask
			    MyBiampStruct.bIPAddress = LEFT_STRING(cNetHelp,LENGTH_STRING(cNetHelp) -13)
	    }
	    ACTIVE (FIND_STRING (cResponse,'DEVICE get hostname',1)):
	    {
		bFound= 'hostname';
	    }
	    ACTIVE (FIND_STRING (cResponse,'DEVICE get serialNumber',1)):
	    {
		bFound= 'serialNumber';
	    }
	    ACTIVE (FIND_STRING (cResponse,'DEVICE get version',1)):
	    {
		bFound = 'firmware';
	    }
	    ACTIVE (FIND_STRING (cResponse, "TAG_TI,' get hookState'",1)) :
	    {
		bFound = 'hookState';
	    }
	    ACTIVE (FIND_STRING (cResponse,'+OK "value":',1)) :
	    {
		REMOVE_STRING (cResponse,'+OK "value":',1)
	    
		SWITCH (bFound)
		{
		    CASE 'hostname' :
		    {
			REMOVE_STRING (cResponse,'"',1)
			
			MyBiampStruct.bHost = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -3) //Remove Last Quote + 2Bytes
			    bFound = '';
		    }
		    CASE 'serialNumber' :
		    {
			REMOVE_STRING (cResponse,'"',1)
			
			MyBiampStruct.bSerial = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -3) //Remove Last Quote + 2Bytes
			    bFound = '';
		    }
		    CASE 'firmware' :
		    {
			REMOVE_STRING (cResponse,'"',1)
			
			MyBiampStruct.bFirmware = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -3)
			    bFound = '';
		    }
		    CASE 'hookState' :
		    {
			REMOVE_STRING (cResponse,'":',1)
			    bFound = '';
			
			IF (FIND_STRING (cResponse,'ONHOOK',1))
			{
			    BiampPhone.bPhoneState = FALSE;
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Disconnected'"
				    SEND_STRING 0, "'Phone is NOT in Use-->'"
			}
			ELSE IF (FIND_STRING (cResponse, 'OFFHOOK',1))
			{
			    BiampPhone.bPhoneState = TRUE;
				SEND_STRING 0, "'Phone is in Use!!-->'"
			}
			
		    }
		}
	    }
	    //Full Caller ID Parse...
	    ACTIVE(FIND_STRING(cResponse,"'! "publishToken":"',TAG_CALLING,'" "value":{"callStateInfo":[{"state":TI_CALL_STATE_'",1)):
	    {
		REMOVE_STRING (cResponse,"'! "publishToken":"',TAG_CALLING,'" "value":{"callStateInfo":[{"state":TI_CALL_STATE_'",1)
		    cCallState = LEFT_STRING(cResponse,5);
			BiampPhone.bSubscribed = TRUE; //The only way to get this feedback is because subscribed 
		
		SWITCH (cCallState)
		{
		    CASE 'RINGI' :
		    {
			cCallState = '';
			SEND_COMMAND vdvTP_Biamp, "'PPON-Phone'" //Show Caller PopuP
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Incoming Call'"
			    
			IF (FIND_STRING (cResponse, '"cid":"\"',1)) //Means we have an ID...
			{
			    REMOVE_STRING (cResponse, '"cid":"\"',1)
				REMOVE_STRING (cResponse, '\"\"',1) 
				cRemoteNum = LEFT_STRING (cResponse, 10); //Just get 10 digit phone number
				    REMOVE_STRING(cResponse, '\"\"',1) //Should be left with --> WIRELESS CALLER\"" "prompt":FAULT_NONE}]}$0D$0A
			
			    cRemoteID = REMOVE_STRING (cResponse,'\"" "prompt":',1);
				cRemoteID = LEFT_STRING (cRemoteID, LENGTH_STRING (cRemoteID) -13); //Remove Tail and grab pre
				
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NUMBER),',0,',cRemoteNum" //Place the Number
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NAME),',0,',cRemoteID" //Place the Name...
			}
		    }
		    CASE 'DIALI' : //Dialing...
		    {
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connecting'"
			    BiampPhone.bPhoneState = TRUE;
		    }
		    CASE 'IDLE ' :	//Not in Use...
		    CASE 'DROPP' : //DROPPED ~ someone hung Up...
		    CASE 'FAULT' : //FAULT
		    {
			    BiampPhone.bPhoneState = FALSE;
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Disconnected'"
			
			cRemoteNum = 'Caller ID';
			cRemoteID = 'Phone Number';
			
			 WAIT 100
			 {
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NUMBER),',0,',cRemoteNum" //Place the Number
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NAME),',0,',cRemoteID" //Place the Name...
			}
		    }
		    CASE 'CONNE' : //Connected - Will display as dialing out and Answered from Room...
		    {
			cCallState = '';
			BiampPhone.bPhoneState = TRUE;
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connected'"
			    
			IF (FIND_STRING (cResponse, '"cid":"\"',1)) //Means we have an ID...
			{
			    REMOVE_STRING (cResponse, '"cid":"\"',1)
				REMOVE_STRING (cResponse, '\"\"',1) 
				cRemoteNum = LEFT_STRING (cResponse, 10) //Just get 10 digit phone number
				    REMOVE_STRING(cResponse, '\"\"',1) //Should be left with --> WIRELESS CALLER\"" "prompt":FAULT_NONE}]}$0D$0A
			
			    cRemoteID = REMOVE_STRING (cResponse,'\"" "prompt":',1)
				cRemoteID = LEFT_STRING (cRemoteID, LENGTH_STRING (cRemoteID) -13); //Remove Tail and grab pre
				
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NUMBER),',0,',cRemoteNum" //Place the Number
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NAME),',0,',cRemoteID" //Place the Name...
			}
		    }
		}
	    }
	    ACTIVE (FIND_STRING(cResponse,'-ERR ALREADY_SUBSCRIBED',1)):
	    {
		BiampPhone.bSubscribed = TRUE;
	    }
	     //Program Level Parsing...
	    ACTIVE(FIND_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)):
	    {
		REMOVE_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)
		    BiampPrgm.bLevel = ATOI(cResponse);
		    
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm.bLevel + MAX_COMP),'%'"
	    }
	   ACTIVE (FIND_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1)) :
	    {
		REMOVE_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1)
		cState = cResponse;
		    
		IF (FIND_STRING (cState,'true',1))
		{
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
			ON [vdvTP_Biamp, nPrgmBtns[1]]
				    BiampPrgm.bMute = TRUE;
		}
		ELSE
		{
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm.bLevel + MAX_COMP),'%'"
			OFF [vdvTP_Biamp, nPrgmBtns[1]]
			    BiampPrgm.bMute = FALSE;
		}
	    }
	    ACTIVE (FIND_STRING (cResponse, "TAG_MUTE_RINGER,' set mute ',ITOA(ID_RINGER),' '",1)) :
	    {
		REMOVE_STRING (cResponse, "TAG_MUTE_RINGER,' set mute ',ITOA(ID_RINGER),' '",1)
		cState = cResponse;
		    
		IF (FIND_STRING (cState,'true',1))
		{
			ON [vdvTP_Biamp, BTN_MUTE_RINGER]
				    nMuteRinger = TRUE;
		}
		ELSE
		{
			OFF [vdvTP_Biamp, BTN_MUTE_RINGER]
			    nMuteRinger = FALSE;
		}
	    }
	    //Microphone Mutes...
	    ACTIVE (FIND_STRING (cResponse, 'CEILINGMUTE-',1)) : //My Custom String
	    {
		REMOVE_STRING (cResponse, '-',1);
		    cMute = LEFT_STRING (cResponse, 2);
		    
		SWITCH (cMute)
		{
		    CASE 'ON' :
		    {
			ON [nCeiling_Mute]
			    ON [vdvTP_Biamp, BTN_MUTE_CEILING]
				    //SEND_COMMAND vdvTesira, "'TELL-MUTECEILING'"
		    }
		    CASE 'OF' :
		    {
			OFF [nCeiling_Mute]
			    OFF [vdvTP_Biamp, BTN_MUTE_CEILING]
				   // SEND_COMMAND vdvTesira, "'TELL-UNMUTECEILING'"
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

CREATE_BUFFER dvTesira,nAudioBuffer;

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Biamp, 1]
BUTTON_EVENT [vdvTP_Biamp, 2]
BUTTON_EVENT [vdvTP_Biamp, 3]
BUTTON_EVENT [vdvTP_Biamp, 4]
BUTTON_EVENT [vdvTP_Biamp, 5]
BUTTON_EVENT [vdvTP_Biamp, 6]
BUTTON_EVENT [vdvTP_Biamp, 7]
BUTTON_EVENT [vdvTP_Biamp, 8]
BUTTON_EVENT [vdvTP_Biamp, 9]
BUTTON_EVENT [vdvTP_Biamp, 10]
BUTTON_EVENT [vdvTP_Biamp, 11] 
BUTTON_EVENT [vdvTP_Biamp, 12] //Dial Pad...
{                                    
    PUSH :
    {
	STACK_VAR INTEGER nPhoneBtns;
	STACK_VAR CHAR nDigit[1];
	
	nPhoneBtns = BUTTON.INPUT.CHANNEL - 1;

	TO[BUTTON.INPUT];
	
	SWITCH (nPhoneBtns)
	{
	    CASE 10:
	    {
		nDigit = '*';
		BREAK;
	    }
	    CASE 11:
	    {
		nDigit = '#';
		BREAK;
	    }
	    DEFAULT:
	    {
		nDigit = ITOA (nPhoneBtns);
		BREAK;
	    }
	}
	dialPhone = "dialPhone, nDigit"
	
	IF ( BiampPhone.bPhoneState == TRUE )
	{
	    SEND_STRING dvTesira, "TAG_TI,' dtmf ',nDigit,MSG_ETX"
	}
	
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_NUMBER_DISPLAY),',0,',dialPhone";
	
    }
}
BUTTON_EVENT [vdvTP_Biamp, 13] //BackSpace...
{
    PUSH :
    {
	IF (LENGTH_STRING(dialPhone))
	{
	    TO[BUTTON.INPUT];
	    SET_LENGTH_STRING(dialPhone,LENGTH_STRING(dialPhone) -1);
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_NUMBER_DISPLAY),',0,',dialPhone";
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 14] //Clear...
{
    PUSH :
    {
	dialPhone = "";
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_NUMBER_DISPLAY),',0,',dialPhone";
    }
}
BUTTON_EVENT [vdvTP_Biamp, 15] //Dial...
{
    PUSH :
    {
	IF (LENGTH_STRING (dialPhone) > 0)
	{
	    TO[BUTTON.INPUT]
	    SEND_STRING dvTesira, "TAG_TI,' dial ',dialPhone,MSG_ETX"
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 16] //Redial...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "TAG_TI,' redial',MSG_ETX"
    }
}
BUTTON_EVENT [vdvTP_Biamp, 17] //HangUp...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	    SEND_STRING dvTesira, "TAG_TI,' end',MSG_ETX"
		BiampPhone.bPhoneState = FALSE;
    }
}
BUTTON_EVENT [vdvTP_Biamp, 18] //Answer...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	    SEND_STRING dvTesira, "TAG_TI,' answer',MSG_ETX"
		BiampPhone.bPhoneState = TRUE;
    }
}
BUTTON_EVENT [vdvTP_Biamp, 19] //Ignore Call
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	    SEND_STRING dvTesira, "TAG_TI,' answer',MSG_ETX"
	
	WAIT 10
	{
	   SEND_STRING dvTesira, "TAG_TI,' end',MSG_ETX" 
		BiampPhone.bPhoneState = FALSE;
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, nPrgmBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmBtns);
	SWITCH (nPrgmIDX)
	{
	    CASE 1 :
	    {
		IF (BiampPrgm.bMute == FALSE)
		{
		    fnMuteChannel(TAG_MUTE_PRGM, ID_PRGM_LEV,YES_ON);
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_PRGM, ID_PRGM_LEV,YES_OFF);
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	    CASE 4 : fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bPreset);
	}
    }
    HOLD [2, REPEAT] :
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmBtns);
	SWITCH (nPrgmIDX)
	{
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, BTN_MUTE_CEILING]
{
    PUSH :
    {
	IF (nCeiling_Mute == FALSE)
	{
	    fnMuteLogic (TAG_CEILING, ID_CEILING, YES_ON);
	}
	ELSE
	{
	    fnMuteLogic (TAG_CEILING, ID_CEILING, YES_OFF);
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, BTN_MUTE_RINGER]
{
    PUSH :
    {
	IF (nMuteRinger == FALSE)
	{
	    fnMuteChannel (TAG_MUTE_RINGER, ID_RINGER, YES_ON);
	}
	ELSE
	{
	     fnMuteChannel (TAG_MUTE_RINGER, ID_RINGER, YES_OFF);
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTesira]
{
    ONLINE:
    {
	SEND_STRING 0, "'<======= Biamp Now Online! =======>'"
	    MyBiampStruct.bBiampOnline = TRUE;
	    
	    SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1 485 DISABLED'"
	    SEND_COMMAND DATA.DEVICE, "'RXON'"
	    SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	    
	WAIT 150 'Go Presets'
	{
	    fnResetAudio();
	}
    }
    OFFLINE :
    {
	MyBiampStruct.bBiampOnline = FALSE;
	    SEND_STRING 0, "'<=======Biamp Now Offline! =======>'" //Dropped off the Bus
    }
    STRING:
    {
	fnParseTesira();
	
	CANCEL_WAIT 'BIAMP_COMM'
	WAIT 5400 'BIAMP_COMM'
	{
	    MyBiampStruct.bBiampOnline = FALSE;
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT[TL_FEEDBACK]
{
    WAIT 4500
    {
	fnSubscribeCalls();
    }
}


    
