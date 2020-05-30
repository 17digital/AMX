PROGRAM_NAME='Tesira_Phone2'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/30/2020  AT: 12:06:08        *)
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

#IF_NOT_DEFINED dvTP_Biamp2
dvTP_Biamp2 =					10002:5:0
#END_IF

#IF_NOT_DEFINED dvTesira
dvTesira =						5001:2:0 //Tesira
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

VOL_UP				= 1
VOL_DN				= -1

//Phone Block ID (Typcially should be 1)
PHONE_ID		= 3


//Biamp ID's...
ID_PRGM_LEV				= 1
ID_CEILING					= 1 //Logic Block
ID_LAV_1					= 1
ID_LAV_2					= 2
ID_MIXER					= 3 //The Mixer Allen Hooks Up...
ID_CALLER_LEV				= 4
ID_RINGER				= 1 //Logic Block

//TP Addresses...
TXT_LAV_1					= 1
TXT_LAV_2					= 2
TXT_PRGM					= 10
TXT_CALLER				= 11
TXT_MIXER					= 12 //Allen's Mixer

TXT_NUMBER_DISPLAY		= 17
TXT_CALLER_NUM			= 19
TXT_CALLER_NAME			= 18
TXT_MYPHONE				= 20
TXT_PHONE_STATE			= 21

//biamp tags...
TAG_LEV_PRGM			= 'Program'
TAG_LEV_MICS				= 'Microphones'
TAG_MUTE_MICS			= 'MicMutes'
TAG_MUTE_PRGM			= 'ProgramMute'
TAG_MUTE_CEILING		= 'privacymute'
TAG_MUTE_RINGER			= 'ringermute'
YES_ON					= 'true'
YES_OFF					= 'false'

MY_PHONE				= '404-385-6196'

BTN_MUTE_LAV1			= 21
BTN_MUTE_LAV2			= 25
BTN_MUTE_MIXER			= 33
BTN_MUTE_PRGM			= 37
BTN_MUTE_CEILING		= 50
BTN_MUTE_RINGER			= 60

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE SINTEGER nMaximum = 12 //Max...
VOLATILE SINTEGER nMinimum = -88 //Minimum...

VOLATILE INTEGER nBiampOnline
VOLATILE CHAR nAudioBuffer[500]

VOLATILE SINTEGER nProgram_Level_Preset = -10 //Set Default Level
VOLATILE SINTEGER nProgram_Level //Caller + Speakers

//Wireless Lavs...
VOLATILE SINTEGER nLav1_Level
VOLATILE SINTEGER nLav1_Level_Preset = -13

VOLATILE SINTEGER nLav2_Level
VOLATILE SINTEGER nLav2_Level_Preset = -14

VOLATILE SINTEGER nMixer_Level
VOLATILE SINTEGER nMixer_Preset = -26

VOLATILE SINTEGER nCaller_Level
VOLATILE SINTEGER nCaller_Level_Preset = -10

VOLATILE CHAR dialPhone[20] //Dialer1
VOLATILE CHAR sLastNumber[20]
VOLATILE CHAR sIncomingCall[20]
VOLATILE INTEGER nPhoneState //On / Off

DEV vdvTP_Biamp[] = {dvTP_Biamp, dvTP_Biamp2}

VOLATILE INTEGER nChnlbtns[] =
{
    //Wireless 1
    21,22,23,24,
    
    //Wireless 2
    25,26,27,28,
    
    //Caller Volume
    29,30,31,32,
    
    //Mixer Volume...
    33,34,35,36,
       
    //Program...
    37,38,39,40,
    
    //Ceiling Mic Mute
    50 
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnMuteLogic(CHAR cTag[], INTEGER cIn, CHAR cValue[]) 
{
    SEND_STRING dvTesira, "cTag,'  set state ',ITOA(cIn),' ',cValue,CR"
}
DEFINE_FUNCTION fnMuteChannel(CHAR cTag[], INTEGER cIn, CHAR cValue[])
{
    SEND_STRING dvTesira, "cTag,' set mute ',ITOA(cIn),' ',cValue,CR"
}
DEFINE_FUNCTION fnSetVolumeUp(CHAR cTag[], INTEGER cIn, SINTEGER cVolume)
{
    IF (cVolume < nMaximum )
    {
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cVolume + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnSetVolumeDown(CHAR cTag[], INTEGER cIn, SINTEGER cVolume)
{
    IF (cVolume > nMinimum )
    {
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cVolume + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], INTEGER cIn, SINTEGER cLevel)
{
    SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLevel),CR"
}
DEFINE_FUNCTION fnResetAudio()
{
    WAIT 10 fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1, YES_OFF)
    WAIT 20 fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Preset)
                 
    WAIT 30 fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2, YES_OFF)
    WAIT 40 fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Preset)

    WAIT 50 fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV, YES_OFF)
    WAIT 60 fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
    
    WAIT 80 fnMuteLogic(TAG_MUTE_CEILING,ID_CEILING,YES_OFF)
    
    WAIT 90  fnMuteChannel(TAG_LEV_MICS, ID_MIXER, YES_OFF)
    WAIT 100 fnSetVolumePreset(TAG_LEV_MICS, ID_MIXER, nMixer_Preset)
    
    WAIT 110 fnMuteLogic(TAG_MUTE_RINGER,ID_RINGER,YES_OFF)
    WAIT 120 fnSetVolumePreset(TAG_LEV_MICS, ID_CALLER_LEV, nCaller_Level_Preset)
    
    WAIT 150 fnSubscribeCalls()
    
    WAIT 180 SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' get hookState',CR"
}
DEFINE_FUNCTION fnSubscribeCalls()
{
    SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' subscribe callState Calling',CR"
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[500]
    STACK_VAR INTEGER cID 
    LOCAL_VAR CHAR cCMD[4]
    LOCAL_VAR CHAR cMsg[100]
    LOCAL_VAR CHAR cMsgId[100]
    LOCAL_VAR CHAR cCallState[10]

    WHILE(FIND_STRING(nAudioBuffer,"CR,LF",1))
    {	
	cResponse = REMOVE_STRING(nAudioBuffer,"CR,LF",1)
    
	SELECT
	{
		//Full Caller ID Parse...
	    ACTIVE(FIND_STRING(cResponse,'+OK "value":"\"',1)):
	    {
		    REMOVE_STRING(cResponse,'+OK "value":"\"',1) //Left with --> 04011103\"\"6789929391\"\"Wireless Caller\""$0D$0A
		    
		    REMOVE_STRING(cResponse,'\"\"',1) //Should be left with --> 6789929391\"\"Wireless Caller\""$0D$0A
		
		    cMsg = LEFT_STRING(cResponse, 10) //Just get 10 digit phone number
		    REMOVE_STRING(cResponse, '\"\"',1) //Should be left with --> Wireless Caller\""$0D$0A
		    
		    cMsgId = cResponse 
		    //IF (LENGTH_STRING (cMsgId) < 0)
		    SET_LENGTH_STRING (cMsgId,LENGTH_STRING(cMsgId) -5); //Should be left with --> Wireless Caller$0D$0A
		    
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER_NUM),',0,',cMsg" //Place the Number
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER_NAME),',0,',cMsgId" //Place the Name...
	    }
	    ACTIVE (FIND_STRING(cResponse,'! "publishToken":"Calling" "value":{"callStateInfo":[{"state":TI_CALL_STATE_',1)):
	    {
		    REMOVE_STRING(cResponse,'! "publishToken":"Calling" "value":{"callStateInfo":[{"state":TI_CALL_STATE_',1)
		    cCallState = LEFT_STRING(cResponse,10)
		    
		    IF (FIND_STRING(cCallState,'IDLE',1))
		    {
			    OFF [nPhoneState]
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Disconnected'"
			    WAIT 80
			    {
				cMsg = ''
				cMsgId = ''
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER_NUM),',0,',cMsg" 
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER_NAME),',0,',cMsgId" 
			    }
		    }
		    IF (FIND_STRING(cCallState,'CONNECTED',1))
		    {
			    ON [nPhoneState ]
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Connected'"
		    }
		    IF (FIND_STRING(cCallState,'RINGING',1))
		    {
			    SEND_COMMAND vdvTP_Biamp, "'@PPX'" //kill pop ups first
			    SEND_COMMAND vdvTP_Biamp, "'PPON-_Phone'" //Show Caller PopuP
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Incoming Call'"
			    WAIT 30 
			    {
				SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' get cidUser',CR"
			    }
		    }
		    IF (FIND_STRING(cCallState,'DIALING',1))
		    {
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PHONE_STATE),',0,Dialing'"
				ON [nPhoneState ]
		    }
	    }
	    ACTIVE(FIND_STRING(cResponse, '+OK "value":ONHOOK',1)): 
	    {
		    OFF [nPhoneState ]
	    }
	    ACTIVE(FIND_STRING(cResponse, '+OK "value":OFFHOOK',1)): 
	    {
		    ON [nPhoneState ]
	    }    
	    ACTIVE(FIND_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)):
	    {
		    REMOVE_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)
		    nProgram_Level = ATOI(cResponse)
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
	    }
	    ACTIVE(FIND_STRING(cResponse,"TAG_LEV_MICS,' set level '",1)):
	    {
		REMOVE_STRING(cResponse,"TAG_LEV_MICS,' set level '",1)    
		    
		cID = ATOI(LEFT_STRING(cResponse,1))
		cCMD = MID_STRING (cResponse,2,4)
		    
		SWITCH (cID)
		{
		    CASE ID_LAV_1 :
		    {
			nLav1_Level = ATOI(cCMD)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
		    }
		    CASE ID_LAV_2 :
		    {
			nLav2_Level = ATOI(cCMD)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
		    }
		    CASE ID_MIXER :
		    {
			nMixer_Level = ATOI(cCMD)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIXER),',0,',ITOA(nMixer_Level + MAX_COMP),'%'"
		    }
		    CASE ID_CALLER_LEV :
		    {
			nCaller_Level = ATOI(cCMD)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER),',0,',ITOA(nCaller_Level + MAX_COMP),'%'"
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

ON [nBiampOnline]
CREATE_BUFFER dvTesira,nAudioBuffer;

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
	
	IF (nPhoneState )
	{
	    SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' dtmf ',nDigit,CR"
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
	    SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' dial ',dialPhone,CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 16] //Redial...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' redial',CR"
    }
}
BUTTON_EVENT [vdvTP_Biamp, 17] //HangUp...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' end',CR"
	    OFF [nPhoneState]
    }
}
BUTTON_EVENT [vdvTP_Biamp, 18] //Answer...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' answer',CR"
	ON [nPhoneState]
	WAIT 10
	{
	    SEND_COMMAND vdvTP_Biamp, "'PPON-_Phone'"
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 19] //Reject Call
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' answer',CR"
	WAIT 10
	{
	   SEND_STRING dvTesira, "'TIControlStatus',ITOA(PHONE_ID),' end',CR" 
	   OFF [nPhoneState]
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, BTN_MUTE_RINGER]
{
    PUSH :
    {
	IF (![vdvTP_Biamp, BTN_MUTE_RINGER])
	{
	    ON [vdvTP_Biamp, BTN_MUTE_RINGER]
	    fnMuteLogic(TAG_MUTE_RINGER,ID_RINGER,YES_ON)
	    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER),',0,Muted!'" 
	}
	ELSE
	{
	    OFF [vdvTP_Biamp, BTN_MUTE_RINGER]
		fnMuteLogic(TAG_MUTE_RINGER,ID_RINGER,YES_OFF)
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER),',0,',ITOA(nCaller_Level + MAX_COMP),'%'"
	}
    }

}
BUTTON_EVENT [vdvTP_Biamp, nChnlbtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nChnlbtns)
	SWITCH (nChnlIdx)
	{
	    CASE 1:
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_LAV1])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_LAV1]
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_LAV1]
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 4 : fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Preset)
	    
	    //LAV 2
	    CASE 5:
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_LAV2])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_LAV2]
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_LAV2]
		}
	    }
	    CASE 6: fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 7: fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 8: fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Preset)
	    
	    //Caller Volume..
	    CASE 10 : fnSetVolumeUp(TAG_LEV_MICS, ID_CALLER_LEV, nCaller_Level)
	    CASE 11 : fnSetVolumeDown(TAG_LEV_MICS, ID_CALLER_LEV, nCaller_Level)
	    CASE 12 : fnSetVolumePreset(TAG_LEV_MICS, ID_CALLER_LEV, nCaller_Level_Preset)
	    
	    //Allen's Mixer
	    CASE 13:
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_MIXER])
		{
		    fnMuteChannel(TAG_LEV_MICS, ID_MIXER, YES_ON)
		    ON [vdvTP_Biamp, BTN_MUTE_MIXER]
		}
		ELSE
		{
		    fnMuteChannel(TAG_LEV_MICS, ID_MIXER, YES_OFF)
		    OFF [vdvTP_Biamp, BTN_MUTE_MIXER]
		}
	    }
	    CASE 14: fnSetVolumeUp(TAG_LEV_MICS, ID_MIXER, nMixer_Level)
	    CASE 15: fnSetVolumeDown(TAG_LEV_MICS, ID_MIXER, nMixer_Level)
	    CASE 16: fnSetVolumePreset(TAG_LEV_MICS, ID_MIXER, nMixer_Preset)
	    

	    //Program
	    CASE 17 :
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_PRGM])
		{
		    fnMuteChannel(TAG_MUTE_PRGM,ID_PRGM_LEV,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_PRGM]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_PRGM, ID_PRGM_LEV,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_PRGM]
		}
	    }
	    CASE 18 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 19 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 20 :fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
	            
	    //Ceiling
	    CASE 21 : 
	    {
		IF(![vdvTP_Biamp, BTN_MUTE_CEILING])
		{
		   fnMuteLogic(TAG_MUTE_CEILING,ID_CEILING,YES_ON)
		   ON [vdvTP_Biamp, BTN_MUTE_CEILING]
		}
		ELSE
		{
		    fnMuteLogic(TAG_MUTE_CEILING,ID_CEILING,YES_OFF)
		    OFF [vdvTP_Biamp, BTN_MUTE_CEILING]
		}
	    }
	}
    }
    HOLD [2, REPEAT] :
    {
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nChnlbtns)
	SWITCH (nChnlIdx)
	{
	    CASE 2 : fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    //
	    CASE 6: fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 7: fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    //
	    CASE 14: fnSetVolumeUp(TAG_LEV_MICS, ID_MIXER, nMixer_Level)
	    CASE 15: fnSetVolumeDown(TAG_LEV_MICS, ID_MIXER, nMixer_Level)
	    //
	    CASE 18 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 19 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Biamp]
{
    ONLINE:
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MYPHONE),',0,',MY_PHONE"
	
	IF (!nBiampOnline)
	{
	    fnResetAudio()
	}
    }
}
DATA_EVENT [dvTesira]
{
    ONLINE:
    {
	    SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1'"
	    SEND_COMMAND DATA.DEVICE, "'RXON'"
	    SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	    WAIT 150
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
TIMELINE_EVENT[TL_FEEDBACK] //Pulled from Main file! Feedback set for 1/2 second
{
    WAIT 1950
    {
	fnSubscribeCalls()
    }
}


    

