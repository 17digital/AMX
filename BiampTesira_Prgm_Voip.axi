PROGRAM_NAME='Tesira_Phone2'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 08/21/2019  AT: 07:07:15        *)
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
	
	"'DEVICE get ipStatus control',13"
	
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


#IF_NOT_DEFINED dvBiamp
dvBiamp =						5001:1:0 //Tesira TOP Biamp
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED CR
CR				= 13
#END_IF

#IF_NOT_DEFINED LF
LF				= 10
#END_IF


MAX_COMP				= 88
MAX_SPAN				= 6

VOL_UP				= 1
VOL_DN				= -1

ID_PRGM_LEV			= 1
ID_CEILING				= 1
ID_LAV_1				= 1
ID_LAV_2				= 2
ID_MIC_3				= 3
ID_MIC_4				= 4

TXT_LAV_1				= 1
TXT_LAV_2				= 2
TXT_LAV_3				= 3
TXT_LAV_4				= 4
TXT_PRGM				= 10

TXT_MYPHONE			= 20
TXT_SIPDISAPLAY_NAME		= 22
TXT_CID_NUMBER			= 19
TXT_CID_NAME			= 18
TXT_PHONE_STATE			= 21
TXT_NUMBER_DISPLAY			= 17

YES_ON				= 'true'
YES_OFF				= 'false'

//biamp tags...
TAG_LEV_PRGM		= 'Program'
TAG_LEV_MICS		= 'Microphones'
TAG_MUTE_MICS		= 'MicMutes'
TAG_MUTE_PRGM		= 'ProgramMute'
TAG_CEILING			= 'privacymute'

//Buttons...
BTN_MUTE_LAV1			= 21
BTN_MUTE_LAV2			= 25
BTN_MUTE_LAV3			= 29
BTN_MUTE_PRGM			= 37
BTN_MUTE_CEILING		= 50
BTN_MUTE_RINGER			= 60

BTN_DISTURB			= 70 //Toggle Disturb on or Off

BTN_SET_PRESET_PRGM	= 110

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR nBiampDevice[30] = 'Tesira VT'
VOLATILE CHAR nSipNumber[10] //= '404-385-0677'
VOLATILE CHAR nSipName[8]
VOLATILE CHAR dialPhone[20] //Dialer1
VOLATILE CHAR sLastNumber[20]
VOLATILE CHAR sIncomingCall[20]
VOLATILE INTEGER nPhoneState //On / Off
VOLATILE INTEGER nSubscribed

//Biamp Level Ranges...
VOLATILE SINTEGER nMaximum = 12 //Max...
VOLATILE SINTEGER nMinimum = -88 //Minimum...

VOLATILE INTEGER nBiampOnline
VOLATILE CHAR nBiampBuffer[2500]

//Program
VOLATILE INTEGER nProgram_Mute
VOLATILE SINTEGER nProgram_Level
VOLATILE SINTEGER nProgram_Level_Preset = -10
PERSISTENT SINTEGER nProgram_Level_Hold;

VOLATILE INTEGER nCeiling_Mute //Ceiling Mics
VOLATILE INTEGER nDoNotDisturb_

VOLATILE DEV vdvTP_Biamp[] = 
{
    dvTP_Biamp
}
VOLATILE INTEGER nPrgmChnlbtns[] =
{
    //Program + Voip Lev...
    37,38,39,40
}
    
(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnMuteLogic(CHAR cTag[], INTEGER cIn, CHAR cMute[MAX_SPAN])
{
    SEND_STRING dvBiamp, "cTag,' set state ',ITOA(cIn),' ',cMute,CR" 
}
DEFINE_FUNCTION fnMuteChannel(CHAR cTag[], INTEGER cIn, CHAR cValue[])
{
    SEND_STRING dvBiamp, "cTag,' set mute ',ITOA(cIn),' ',cValue,CR"
}
DEFINE_FUNCTION fnMuteVolume(CHAR cTag[], INTEGER cIn, CHAR cValue[MAX_SPAN]) 
{
    SEND_STRING dvBiamp, "cTag,' set mute ',ITOA(cIn),' ',cValue,CR"
}
DEFINE_FUNCTION fnSetVolumeUp(CHAR cTag[], INTEGER cIn, SINTEGER cVolume)
{
    IF (cVolume < nMaximum )
    {
	SEND_STRING dvBiamp, "cTag,' set level ',ITOA(cIn),' ',ITOA(cVolume + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnSetVolumeDown(CHAR cTag[], INTEGER cIn, SINTEGER cVolume)
{
    IF (cVolume > nMinimum )
    {
	SEND_STRING dvBiamp, "cTag,' set level ',ITOA(cIn),' ',ITOA(cVolume + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], INTEGER cIn, SINTEGER cLevel)
{
    SEND_STRING dvBiamp, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLevel),CR"
}
DEFINE_FUNCTION fnResetAudio()
{
    SEND_STRING dvDebug, "'dvBiamp : Set Audio Defaults...'";
    
    WAIT 10 fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV, YES_OFF)
    
    WAIT 20 
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
    WAIT 30 fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF)
    
    WAIT 40 fnNoDisturb (YES_OFF)

    WAIT 60 SEND_STRING dvBiamp, "'VoIPControlStatus1 get protocols',CR"
    
    WAIT 100 fnSubscribeCalls()
    
}
DEFINE_FUNCTION fnSubscribeCalls()
{
    SEND_STRING dvDebug, "'dvBiamp : Set Voip Subscription and Call State'";
    
    IF (!nSubscribed)
    {
	SEND_STRING dvBiamp, "'VoIPControlStatus1 subscribe callState Calling',CR"
	    WAIT 50 SEND_STRING dvBiamp, "'VoIPControlStatus1 get callState',CR"
    }
    ELSE
    {
	SEND_STRING dvBiamp, "'VoIPControlStatus1 get callState',CR"
    }
    
}
DEFINE_FUNCTION fnNoDisturb(CHAR cValue[MAX_SPAN])
{
    SEND_STRING dvBiamp, "'VoIPControlStatus1 set dndEnable 1 ',cValue,CR"
    
    SWITCH (cValue)
    {
	CASE 'true' :
	{
	    ON [nDoNotDisturb_]
		ON [vdvTP_Biamp, BTN_DISTURB]
	}
	CASE 'false' :
	{
	    	    OFF [nDoNotDisturb_]
		OFF [vdvTP_Biamp, BTN_DISTURB]
	}
    }
    //SEND_STRING dvBiamp, "'VoIPControlStatus1 get dndEnable 1',CR"
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[500]
    LOCAL_VAR CHAR cMsg[10]
    LOCAL_VAR CHAR cMsgId[20]
    LOCAL_VAR CHAR cCallState[4]
    LOCAL_VAR CHAR cVoipStatus[10]
    LOCAL_VAR CHAR cDbug[20]
    STACK_VAR INTEGER cID
    LOCAL_VAR CHAR cAudioLev[4]
    LOCAL_VAR CHAR cState[5]

    WHILE(FIND_STRING(nBiampBuffer,"CR,LF",1))
    {	
	    cResponse = REMOVE_STRING(nBiampBuffer,"CR,LF",1)
    
	    //Full Caller ID Parse...
	    IF (FIND_STRING(cResponse,'! "publishToken":"Calling" "value":{"callStateInfo":[{"state":VOIP_CALL_STATE_RINGING "lineId":0 "callId":0 "action":UI_DISPLAY_STATUS "cid":"\"',1))
	    {
		REMOVE_STRING(cResponse,'! "publishToken":"Calling" "value":{"callStateInfo":[{"state":VOIP_CALL_STATE_RINGING "lineId":0 "callId":0 "action":UI_DISPLAY_STATUS "cid":"\"',1) //Left with --> 04011103\"\"6789929391\"\"Wireless Caller\""$0D$0A
		
		REMOVE_STRING(cResponse,'\"\"',1) //Should be left with --> 6789929391\"\"Wireless Caller\""$0D$0A
	    
		cMsg = LEFT_STRING(cResponse, 10) //Just get 10 digit phone number
		REMOVE_STRING(cResponse, '\"\"',1) //Should be left with --> Wireless Caller\""$0D$0A
		
		cMsgId = cResponse 
		cMsgId = LEFT_STRING(cMsgId,LENGTH_STRING(cMsgId) -5) //Should be left with --> Wireless Caller$0D$0A
				
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NUMBER),',0,',cMsg" //Place the Number
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NAME),',0,',cMsgId" //Place the Name...
		
		SEND_COMMAND vdvTP_Biamp, "'^PPN-_Phone'" //Show Caller PopuP
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Incoming Call'"
	    }
	    IF (FIND_STRING(cResponse,'"channelProtoSipInfo":[{"sipUser":"',1)) //Pull SIP Number
	    {
		REMOVE_STRING(cResponse,'"channelProtoSipInfo":[{"sipUser":"',1)
		nSipNumber = LEFT_STRING(cResponse,10)
		
		REMOVE_STRING(cResponse,'" "sipDisplayName":"',1)
		nSipName = LEFT_STRING(cResponse,10)
		
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MYPHONE),',0,',nSipNumber"
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_SIPDISAPLAY_NAME),',0,',nSipName"
	    }
	    IF (FIND_STRING(cResponse,'VoIPControlStatus1 ',1)) 
	    {
		REMOVE_STRING (cResponse, 'VoIPControlStatus1 ',1)
		
		cCallState = cResponse;
		    cMsg = MID_STRING (cResponse, 10, 10)
		    
		SWITCH (cCallState)
		{
		    CASE 'dial ' :
		    {
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NUMBER),',0,',cMsg" //Phone Number Block...
			 ON [nPhoneState]
			 SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connecting'"
		    }
		    CASE 'end ' : //end 1 1
		    {
			 OFF [nPhoneState]
			 SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Disconnected'"
			 
			 cMsg = ''
			 cMsgId = ''
			 WAIT 50
			 {
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NUMBER),',0,',cMsg" //Place the Number
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CID_NAME),',0,',cMsgId" //Place the Name...
			}
		    }
		    CASE 'answ' : //answer 1 1
		    {
		    		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connected'"
			ON [nPhoneState]
		    }
		}
	    }
	    IF (FIND_STRING(cResponse,'{"callStateInfo":[{"state":VOIP_CALL_STATE_',1)) //UPDATED!!!!
	    {
		REMOVE_STRING (cResponse,'{"callStateInfo":[{"state":VOIP_CALL_STATE_',1) //<--- Length 78
		cCallState = LEFT_STRING(cResponse,10)
		
		SWITCH (cCallState)
		{
		    CASE 'RING' : //RINGING
		    {
		
			SEND_COMMAND vdvTP_Biamp, "'@PPX'"
			SEND_COMMAND vdvTP_Biamp, "'^PPN-_Phone'" //Show Caller PopuP
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Incoming Call'"
		    }
		    CASE 'DIAL' : //DIALING
		    {
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connecting'"
			ON [nPhoneState]
			WAIT 200
			{
			    SEND_STRING dvBiamp, "'VoIPControlStatus1 get callState',CR"
			}
			WAIT 350
			{
			    SEND_STRING dvBiamp, "'VoIPControlStatus1 get callState',CR"
			}
		    }
		    CASE 'IDLE' :
		    {
			OFF [nPhoneState]
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Disconnected'"
		    }
		    CASE 'ACTI': //ACTIVE
		    {
			ON [nPhoneState]
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connected'"
		    }
		    CASE 'ANSW' : //ANSWER_CALL
		    {
			ON [nPhoneState]
			 SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connected'"
		    }
		}
	    }
	    IF (FIND_STRING(cResponse,'+OK "value":{"callStateInfo":[]{"state":VOIP_CALL_STATE_IDLE',1)) //Get State Return...
	    {
		cDbug = cResponse
				OFF [nPhoneState]
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Disconnected'"
	    }
	    IF (FIND_STRING(cResponse,'+OK "value":{"callStateInfo":[]{"state":VOIP_CALL_STATE_ACTIVE',1))
	    {
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connected'"
		    ON [nPhoneState]
	    }
	    IF  (FIND_STRING(cResponse,'-ERR ALREADY_SUBSCRIBED',1))
	    {
		ON [nSubscribed]
	    }
	    IF (FIND_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1))
	    {
		REMOVE_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1)
		cState = cResponse
		
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
	    IF (FIND_STRING (cResponse, "TAG_CEILING,' set state ',ITOA(ID_CEILING),' '",1))
	    {
		REMOVE_STRING (cResponse, "TAG_CEILING,' set state ',ITOA(ID_CEILING),' '",1)
		cState = cResponse
		    IF (FIND_STRING (cState,'true',1))
		    {
			ON [nCeiling_Mute]
			    ON [vdvTP_Biamp, BTN_MUTE_CEILING]
		    }
		    ELSE
		    {
			OFF [nCeiling_Mute]
			    OFF [vdvTP_Biamp, BTN_MUTE_CEILING]
		    }
	    }
	    IF (FIND_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1))
	    {
		REMOVE_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)
		    nProgram_Level = ATOI(cResponse)
		    
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
	    }
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [nBiampOnline]
CREATE_BUFFER dvBiamp,nBiampBuffer;


WAIT 600 //1 Minute
{
    OFF [nBiampOnline]
}

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
	
	IF (nPhoneState == TRUE)
	{
	    SEND_STRING dvBiamp, "'VoIPControlStatus1 dtmf  1 ',nDigit,CR"
	}
	
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_NUMBER_DISPLAY),',0,',dialPhone";
	
    }
}
BUTTON_EVENT [vdvTP_Biamp, 13] //Dial Pad BackSpace...
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
BUTTON_EVENT [vdvTP_Biamp, 14] //Dial Pad Clear All...
{
    PUSH :
    {
	dialPhone = "";
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_NUMBER_DISPLAY),',0,',dialPhone";
    }
}
BUTTON_EVENT [vdvTP_Biamp, 15] //Dial Out...
{
    PUSH :
    {
	IF (LENGTH_STRING (dialPhone) > 0)
	{
	    TO[BUTTON.INPUT]
	    SEND_STRING dvBiamp, "'VoIPControlStatus1 dial 1 1 ',dialPhone,CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 16] //Redial...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'VoIPControlStatus1 redial 1 1',CR"
    }
}
BUTTON_EVENT [vdvTP_Biamp, 17] //HangUp...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'VoIPControlStatus1 end 1 1 ',CR"
	
	nPhoneState = FALSE;
    }
}
BUTTON_EVENT [vdvTP_Biamp, 18] //Answer...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'VoIPControlStatus1 answer 1 1 ',CR"
	nPhoneState = TRUE;
    }
}
BUTTON_EVENT [vdvTP_Biamp, 19] //Ignore Call
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'VoIPControlStatus1 answer 1 1 ',CR"
	WAIT 10
	{
	   SEND_STRING dvBiamp, "'VoIPControlStatus1 end 1 1 ',CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, BTN_SET_PRESET_PRGM]
{
    HOLD [30] :
    {
	SEND_COMMAND vdvTP_Biamp, "'ADBEEP'"
	    nProgram_Level_Hold = nProgram_Level;
    }
}
BUTTON_EVENT [vdvTP_Biamp, nPrgmChnlbtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nPrgmIDX
	
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
	STACK_VAR INTEGER nPrgmIDX
	
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
BUTTON_EVENT [vdvTP_Biamp, BTN_DISTURB]
{
    PUSH :
    {
	IF (nDoNotDisturb_ == FALSE)
	{
	    fnNoDisturb (YES_ON)
	}
	ELSE
	{
	    fnNoDisturb (YES_OFF)
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Biamp]
{
    ONLINE:
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MYPHONE),',0,',nSipNumber"
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_SIPDISAPLAY_NAME),',0,',nSipName"
	
	IF (!nBiampOnline)
	{
	    fnResetAudio()
	}
    }
}
DATA_EVENT [dvBiamp]
{
    ONLINE:
    {
	    SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1 485 DISABLED'"
	    SEND_COMMAND DATA.DEVICE, "'RXON'"
	    SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	    
	    WAIT 100
	    {
		   fnResetAudio()
	    }
    }
    STRING:
    {
	fnParseTesira()
    }
}


DEFINE_EVENT
TIMELINE_EVENT[TL_FEEDBACK]
{ 
    WAIT 1800
    {
	SEND_STRING dvBiamp, "'VoIPControlStatus1 get protocols',CR"
    }
    WAIT 3000
    {
	fnSubscribeCalls()
    }

}
