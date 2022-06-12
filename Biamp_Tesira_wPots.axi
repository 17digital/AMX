PROGRAM_NAME='Biamp_Tesira'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/21/2019  AT: 16:03:26        *)
(***********************************************************)

(*
https://support.biamp.com/Tesira/Control/Tesira_command_string_calculator

													*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Biamp
dvTP_Biamp =					10001:5:0
#END_IF

#IF_NOT_DEFINED dvTesira 
dvTesira =					5001:2:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR BIAMP_TYPE[]		= 'Tesira AVB VT';
CHAR BIAMP_TI_NUM[]		= '404-385-3149';

//RMS Stuff...
BIAMP_INITIALIZED			= 251;

HOLD_MAC_ADDRESS			= 17;
HOLD_IP_ADDRESS				= 15;

MAX_ATTRIBUTES				= 1;
//End RMS....

MAX_COMP			= 88 //Biamp | Value= 1120 | Level=  12
MAX_SPAN			= 6

VOL_UP				= 1
VOL_DN				= -1

ID_LAV_1				= 1
ID_LAV_2				= 2
ID_MIC_3				= 3
ID_MIC_4				= 4
ID_PRGM_LEV			= 1
ID_CEILING			= 1 //Logic Block

SOURCE_PC			= 1;
SOURCE_LAPTOP		= 2;
SOURCE_MERSIVE		= 3;

//biamp tags...
TAG_LEV_PRGM		= 'Program'
TAG_LEV_MICS		= 'Microphones'
TAG_MUTE_MICS		= 'MicMutes'
TAG_MUTE_PRGM		= 'ProgramMute'
TAG_CEILING			= 'privacymute'
TAG_MUTE_RINGER		= 'ringermute'
TAG_SOURCE			= 'SourceSwitch' // 
TAG_CALLING			= 'Calling' //For Phone call Subscription...
TAG_TI				= 'TIControlStatus1'

YES_ON				= 'true'
YES_OFF				= 'false'

//Panel Addresses...
TXT_MIC_4			= 4
TXT_MIC_3			= 3
TXT_LAV_1			= 1
TXT_LAV_2			= 2
TXT_PRGM			= 10

TXT_MYPHONE			= 20
TXT_SIPDISAPLAY_NAME	= 22
TXT_CID_NUMBER			= 19
TXT_CID_NAME			= 18
TXT_PHONE_STATE			= 21
TXT_NUMBER_DISPLAY		= 17

//Mute Buttons....
BTN_MUTE_LAV_1		= 1
BTN_MUTE_LAV_2		= 5
BTN_MUTE_MIC_3		= 9
BTN_MUTE_MIC_4 		= 13
BTN_MUTE_PRGM		= 37
BTN_MUTE_CEILING	= 50

BTN_SET_PRESET_LAV_1	= 101
BTN_SET_PRESET_LAV_2	= 102
BTN_SET_PRESET_MIC_3	= 103
BTN_SET_PRESET_MIC_4	= 104
BTN_SET_PRESET_PRGM	= 110

BTN_MUTE_RINGER	= 60

#IF_NOT_DEFINED CR 
CR 					= 13
#END_IF

#IF_NOT_DEFINED LF 
LF 					= 10
#END_IF


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


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

//RMS Variables....
_BiampStruct MyBiampStruct;

VOLATILE CHAR bFound[20];

//End RMS Variables..

//Phone stuff...
VOLATILE CHAR dialPhone[20] //Dialer1
VOLATILE CHAR sLastNumber[20]
VOLATILE CHAR sIncomingCall[20]
VOLATILE INTEGER nPhoneState //On / Off
VOLATILE INTEGER nSubscribed;

VOLATILE SINTEGER nMaximum = 12
VOLATILE SINTEGER nMinimum = -88

VOLATILE INTEGER nBiampOnline
VOLATILE CHAR nAudioBuffer[1000]

//Wireless Microphones...
VOLATILE INTEGER nLav1_Mute
VOLATILE SINTEGER nLav1_Level
VOLATILE SINTEGER nLav1_Level_Preset = -18
PERSISTENT SINTEGER nLav1_Level_Hold; //User Set Variable...

VOLATILE INTEGER nLav2_Mute
VOLATILE SINTEGER nLav2_Level
VOLATILE SINTEGER nLav2_Level_Preset = -18
PERSISTENT SINTEGER nLav2_Level_Hold;

VOLATILE INTEGER nMic3_Mute
VOLATILE SINTEGER nMic3_Level
VOLATILE SINTEGER nMic3_Level_Preset = -15
PERSISTENT SINTEGER nMic3_Level_Hold; //User Set Variable...

VOLATILE INTEGER nMic4_Mute
VOLATILE SINTEGER nMic4_Level
VOLATILE SINTEGER nMic4_Level_Preset = -15
PERSISTENT SINTEGER nMic4_Level_Hold; //User Set Variable...

//Program
VOLATILE INTEGER nProgram_Mute
VOLATILE SINTEGER nProgram_Level
VOLATILE SINTEGER nProgram_Level_Preset = -10
PERSISTENT SINTEGER nProgram_Level_Hold;

VOLATILE INTEGER nCeiling_Mute;
VOLATILE INTEGER nRinger_Mute;

VOLATILE DEV vdvTP_Biamp[] = 
{
    dvTP_Biamp
}
VOLATILE INTEGER nMicChnlbtns[] =
{
    // Lav 1
    1,2,3,4,

    // Lav 2
    5,6,7,8,

    //Mic 3
    9,10,11,12,
    
    //Mic 4
    13,14,15,16
}
VOLATILE INTEGER nPrgmChnlbtns[] =
{
    //Program
    37,38,39,40
}
VOLATILE INTEGER nMicMuteBtns[] =
{
    BTN_MUTE_LAV_1,
    BTN_MUTE_LAV_2,
    BTN_MUTE_MIC_3,
    BTN_MUTE_MIC_4
}
VOLATILE INTEGER nSetPresetBtns[] =
{
    BTN_SET_PRESET_LAV_1,
    BTN_SET_PRESET_LAV_2,
    BTN_SET_PRESET_MIC_3,
    BTN_SET_PRESET_MIC_4,
    BTN_SET_PRESET_PRGM
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnMuteLogic(CHAR cTag[], INTEGER cIn, CHAR cToggle[MAX_SPAN])
{
    SEND_STRING dvTesira, "cTag,' set state ',ITOA(cIn),' ',cToggle,CR" 
}
DEFINE_FUNCTION fnMuteChannel(CHAR cTag[], INTEGER cIn, CHAR cValue[])
{
    SEND_STRING dvTesira, "cTag,' set mute ',ITOA(cIn),' ',cValue,CR"
}
DEFINE_FUNCTION fnSetVolumeUp(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    IF (cLev < nMaximum )
    {
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA( cLev + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnSetVolumeDown(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    IF (cLev > nMinimum )
    {
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev),CR"
}
DEFINE_FUNCTION fnSetAudioSource (INTEGER cIn)
{
    SEND_STRING dvTesira, "TAG_SOURCE,' set sourceSelection ',ITOA(cIn),CR"
}
DEFINE_FUNCTION fnResetAudio()
{
    IF (nProgram_Level_Hold == 0)
    {
	    fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
    }
    ELSE
    {
	    fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Hold)
    }
    
    WAIT 20 fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF)

	WAIT 60 SEND_STRING dvTesira, "'DEVICE get ipStatus control',CR"
	WAIT 90 SEND_STRING dvTesira, "'DEVICE get hostname',CR"
	
	WAIT 110 SEND_STRING dvTesira, "'DEVICE get serialNumber',CR"
	
	WAIT 130 SEND_STRING dvTesira, "'DEVICE get version',CR"
	
	WAIT 150 SEND_STRING dvTesira, "TAG_TI,' get hookState',CR"
    
    WAIT 180 fnSubscribeCalls();
}
DEFINE_FUNCTION fnSubscribeCalls()
{
    SEND_STRING dvTesira, "TAG_TI,' subscribe callState ',TAG_CALLING,CR"
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MYPHONE),',0,',BIAMP_TI_NUM"
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[500] 
    LOCAL_VAR CHAR cRemoteNum[10]//Caller's Number (incoming/Outgoing)
    LOCAL_VAR CHAR cRemoteID[30] //Caller's Name Info
    
    LOCAL_VAR CHAR cMsg[4]
    LOCAL_VAR CHAR cState[5]
    LOCAL_VAR CHAR cNetHelp[50];
    LOCAL_VAR CHAR cMute[2]
    LOCAL_VAR CHAR cSource[2];
    LOCAL_VAR CHAR cCallState[5]; //RING,IDLE,DIAL,

    WHILE(FIND_STRING(nAudioBuffer,"$0D,$0A",1))
    {	
	cResponse = REMOVE_STRING(nAudioBuffer,"$0D,$0A",1)
	    
	SELECT
	{
	    ACTIVE (FIND_STRING(cResponse,'Welcome to the Tesira Text Protocol Server. . .',1)):
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
			    nPhoneState = FALSE;
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Disconnected'"
				    SEND_STRING 0, "'Phone is NOT in Use-->'"
			}
			ELSE IF (FIND_STRING (cResponse, 'OFFHOOK',1))
			{
			    nPhoneState = TRUE;
				SEND_STRING 0, "'Phone is in Use!!-->'"
			}
			
		    }
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,"'! "publishToken":"',TAG_CALLING,'" "value":{"callStateInfo":[{"state":TI_CALL_STATE_'",1)):
	    {
		REMOVE_STRING (cResponse,"'! "publishToken":"',TAG_CALLING,'" "value":{"callStateInfo":[{"state":TI_CALL_STATE_'",1)
		    cCallState = LEFT_STRING(cResponse,5)
		
		SWITCH (cCallState)
		{
		    CASE 'RINGI' :
		    {
			cCallState = '';
			SEND_COMMAND vdvTP_Biamp, "'PPON-_Phone'" //Show Caller PopuP
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Incoming Call'"
			    
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
		    CASE 'DIALI' : //Dialing...
		    {
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connecting'"
			    nPhoneState = TRUE;
		    }
		    CASE 'IDLE ' :	//Not in Use...
		    CASE 'DROPP' : //DROPPED ~ someone hung Up...
		    CASE 'FAULT' : //FAULT
		    {
			    nPhoneState = FALSE;
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
			nPhoneState = TRUE;
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
	    ACTIVE (FIND_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1)) :
	    {
		REMOVE_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1)
		cState = cResponse;
		    
			IF (FIND_STRING (cState,'true',1))
			{
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
				ON [vdvTP_Biamp, BTN_MUTE_PRGM]
				    ON [nProgram_Mute]
			}
			ELSE
			{
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
				OFF [vdvTP_Biamp, BTN_MUTE_PRGM]
				    OFF [nProgram_Mute]
			}
	    }
	    ACTIVE (FIND_STRING (cResponse, 'CEILINGMUTE-',1)) : //My Custom String
	    {
		    REMOVE_STRING (cResponse, '-',1)
		    cMute = LEFT_STRING (cResponse, 2)
		    
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
	    ACTIVE (FIND_STRING (cResponse, 'RINGERMUTE-',1)) : //My Custom String
	    {
		    REMOVE_STRING (cResponse, '-',1)
		    cMute = LEFT_STRING (cResponse, 2)
		    
		    SWITCH (cMute)
		    {
			CASE 'ON' :
			{
			    ON [nRinger_Mute]
				ON [vdvTP_Biamp, BTN_MUTE_RINGER]
			}
			CASE 'OF' :
			{
			    OFF [nRinger_Mute]
				OFF [vdvTP_Biamp, BTN_MUTE_RINGER]
			}
		    }
	    }
	    //Program Feedback...
	    ACTIVE (FIND_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)) :
	    {
		REMOVE_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)
			nProgram_Level = ATOI(cResponse)
			
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
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
	STACK_VAR INTEGER nPhoneBtns
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
	
	IF (nPhoneState == TRUE )
	{
	    SEND_STRING dvTesira, "TAG_TI,' dtmf ',nDigit,CR"
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
	    SEND_STRING dvTesira, "TAG_TI,' dial ',dialPhone,CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 16] //Redial...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "TAG_TI,' redial',CR"
    }
}
BUTTON_EVENT [vdvTP_Biamp, 17] //HangUp...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "TAG_TI,' end',CR"
	    nPhoneState = FALSE;
    }
}
BUTTON_EVENT [vdvTP_Biamp, 18] //Answer...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	    SEND_STRING dvTesira, "TAG_TI,' answer',CR"
		nPhoneState = TRUE;
    }
}
BUTTON_EVENT [vdvTP_Biamp, 19] //Reject Call
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "TAG_TI,' answer',CR"
	
	WAIT 10
	{
	   SEND_STRING dvTesira, "TAG_TI,' end',CR" 
		nPhoneState = FALSE;
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, nSetPresetBtns]
{
    HOLD [30] :
    {
	STACK_VAR INTEGER nPDX;
	nPDX = GET_LAST (nSetPresetBtns)
	    SEND_COMMAND vdvTP_Biamp, "'ADBEEP'"
	
	SWITCH (nPDX)
	{
	    CASE 1 : nLav1_Level_Hold = nLav1_Level;
	    CASE 2 : nLav2_Level_Hold = nLav2_Level;
	    CASE 3 : nMic3_Level_Hold = nMic3_Level;
	    CASE 4 : nMic4_Level_Hold = nMic4_Level;
	    CASE 5 : nProgram_Level_Hold = nProgram_Level;
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, nPrgmChnlbtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmChnlbtns)
	SWITCH (nPrgmIDX)
	{
	    //Program
	    CASE 1 :
	    {
		IF (!nProgram_Mute)
		{
		    fnMuteChannel(TAG_MUTE_PRGM, ID_PRGM_LEV,YES_ON)
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_PRGM, ID_PRGM_LEV,YES_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)

	    CASE 4 : 
	    {
		IF (nProgram_Level_Hold == 0)
		{
		    fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
		}
		ELSE
		{
		    fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Hold)
		}
	    }
	}
    }
    HOLD [2, REPEAT] :
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmChnlbtns)
	SWITCH (nPrgmIDX)
	{
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, BTN_MUTE_CEILING]
{
    PUSH :
    {
	IF (!nCeiling_Mute)
	{
	    fnMuteLogic(TAG_CEILING, ID_CEILING, YES_ON)
	}
	ELSE
	{
	    fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF)
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, BTN_MUTE_RINGER]
{
    PUSH :
    {
	IF (!nRinger_Mute)
	{
	    fnMuteLogic(TAG_MUTE_RINGER, ID_CEILING, YES_ON)
	}
	ELSE
	{
	    fnMuteLogic(TAG_MUTE_RINGER, ID_CEILING, YES_OFF)
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTesira]
{
    ONLINE :
    {
	SEND_STRING 0, "'<======= Biamp Now Online! =======>'"
	    MyBiampStruct.bBiampOnline = TRUE;
	
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 150
	{
	    fnResetAudio()
	}
    }
    OFFLINE :
    {
	MyBiampStruct.bBiampOnline = FALSE;
	    SEND_STRING 0, "'<=======Biamp Now Offline! =======>'" //Dropped off the Bus
    }
    STRING :
    {
	MyBiampStruct.bBiampOnline = TRUE;
	    fnParseTesira()
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 3600
    {
	fnSubscribeCalls();
	    WAIT 20
	    {
		SEND_STRING dvTesira, "TAG_TI,' get hookState',CR"
	    }
    }
}
    
