PROGRAM_NAME='Tesira_Phone2'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 01/12/2019  AT: 21:44:56        *)
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

#IF_NOT_DEFINED dvBiamp
dvBiamp =						5001:3:0 //Tesira TOP Biamp
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

COMPENSATE			= 88
MAX_COMP			= 88
MAX_SPAN				= 6

VOL_UP				= 1
VOL_DN				= -1

ON_HOOK				= 0 //not connected
OFF_HOOK				= 1

PROGRAM_CLASS			= 1
CALLER_CLASS				= 1
MIC_LAV_1				= 1
MIC_LAV_2				= 2

MIC_HH_1				= 3
MIC_HH_2				= 4
MIC_HH_3				= 5
MIC_TT_1				= 6
MIC_TT_2				= 7
MIC_TT_3				= 8
MIC_TT_4				= 9
CEILING				= 1


TXT_MIC_1				= 1
TXT_MIC_2				= 2
TXT_PROGRAM			= 10
TXT_CALLER			= 11
TXT_MYPHONE			= 20

#IF_NOT_DEFINED CR
CR				= 13
#END_IF

#IF_NOT_DEFINED LF
LF				= 10
#END_IF

TL_BIAMP				= 50
TL_SET				= 51

YES_ON				= 'true'
YES_OFF				= 'false'

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR nBiampDevice[30] = 'Tesira TI'
CHAR nMyPhone[15] = '404-385-1556'

VOLATILE INTEGER nBiampOnline

VOLATILE LONG lTLBiamp[] = {250}
VOLATILE CHAR nBiampBuffer[500]

VOLATILE SINTEGER nProgram_Preset = -18 //Set Default Level
NON_VOLATILE SINTEGER nProgram_Level //Caller + Speakers
NON_VOLATILE INTEGER nProgram_Mute

//Wireless Lavs...
NON_VOLATILE INTEGER nLav1_Mute
NON_VOLATILE SINTEGER nLav1_Level
VOLATILE SINTEGER nLav1_Level_Preset = -15

NON_VOLATILE INTEGER nLav2_Mute
NON_VOLATILE SINTEGER nLav2_Level
VOLATILE SINTEGER nLav2_Level_Preset = -15

//Phone In Volume
NON_VOLATILE INTEGER nMuteRinger //Caller + Ringer
NON_VOLATILE SINTEGER nCaller_Level
VOLATILE SINTEGER nCaller_Preset = -10

NON_VOLATILE INTEGER nCeiling_Mute //Ceiling Mics

VOLATILE CHAR dialPhone[20] //Dialer1
VOLATILE CHAR sLastNumber[20]
VOLATILE CHAR sIncomingCall[20]
VOLATILE INTEGER nPhoneState

//Biamp Level Ranges...
VOLATILE SINTEGER nMaximum = 12 //Max...
VOLATILE SINTEGER nMinimum = -88 //Minimum...

DEV vdvTP_Biamp[] = {dvTP_Biamp, dvTP_Biamp2}

VOLATILE INTEGER nChnlbtns[] =
{
    //Wireless 1
    21,22,23,24,
    
    //Wireless 2
    25,26,27,28,
    
    //Caller Volume
    29,30,31,32,
       
    //Program...
    37,38,39,40,
    
    //Ceiling Mute
    50 //
}

    
(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnAudioMode(CHAR cAudio[15])
{
    SWITCH (cAudio)
    {
	CASE 'Combine' :
	{
	    SEND_STRING dvBiamp, "'DEVICE recallPresetByName COMBINE',CR"
	}
	CASE 'UnCombine' :
	{
	    SEND_STRING dvBiamp, "'DEVICE recallPresetByName UNCOMBINE',CR"
	}
    }
}
DEFINE_FUNCTION fnMuteCeilingMics(CHAR cMute[MAX_SPAN])
{
    SEND_STRING dvBiamp, "'Ceiling set mute 1 ',cMute,CR" 
}
DEFINE_FUNCTION fnMuteProgram(INTEGER cInput, CHAR cValue[MAX_SPAN]) //Mutes Only Speaker Outpt
{
    SEND_STRING dvBiamp, "'Program set mute ',ITOA(cInput),' ',cValue,CR"
}
DEFINE_FUNCTION fnMuteMicInput(INTEGER cInput, CHAR cValue[MAX_SPAN])
{
    SEND_STRING dvBiamp, "'MicMutes set mute ',ITOA(cInput),' ',cValue,CR"
}
DEFINE_FUNCTION fnMuteCaller(CHAR cRinger[MAX_SPAN]) //Mute Caller / Ringer
{
    SEND_STRING dvBiamp, "'Caller set mute 1 ',cRinger,CR"
}
DEFINE_FUNCTION fnSetMicVolumeUp(INTEGER cInput, SINTEGER cVolume)
{
    IF (cVolume < nMaximum )
    {
	SEND_STRING dvBiamp, "'Microphones set level ',ITOA(cInput),' ',ITOA(cVolume + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnSetMicVolumeDown(INTEGER cInput, SINTEGER cVolume)
{
    IF (cVolume > nMinimum )  
    {
	SEND_STRING dvBiamp, "'Microphones set level ',ITOA(cInput),' ',ITOA(cVolume + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnSetMicPreset(INTEGER cInput, SINTEGER cLevel)
{
    SEND_STRING dvBiamp, "'Microphones set level ',ITOA(cInput),' ',ITOA(cLevel),CR"
}
DEFINE_FUNCTION fnSetProgramVolumeUp(INTEGER cInput, SINTEGER cVolume)
{
    IF (nProgram_Level < nMaximum )
    {
	SEND_STRING dvBiamp, "'Program set level ',ITOA(cInput),' ',ITOA(cVolume + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnSetProgramVolumeDown(INTEGER cInput, SINTEGER cVolume)
{
    IF (nProgram_Level > nMinimum )
    {
	SEND_STRING dvBiamp, "'Program set level ',ITOA(cInput),' ',ITOA(cVolume + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnProgramPreset(INTEGER cInput, SINTEGER cLevel)
{
    SEND_STRING dvBiamp, "'Program set level ',ITOA(cInput),' ',ITOA(cLevel),CR"
}
DEFINE_FUNCTION fnSetCallerVolumeUp(INTEGER cInput, SINTEGER cVolume)
{
    IF (nCaller_Level < nMaximum)
    {
	SEND_STRING dvBiamp, "'Caller set level ',ITOA(cInput),' ',ITOA(cVolume + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnSetCallerVolumeDown(INTEGER cInput, SINTEGER cVolume)
{
    IF (nCaller_Level > nMinimum)
    {
	SEND_STRING dvBiamp, "'Caller set level ',ITOA(cInput),' ',ITOA(cVolume + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnCallerPreset(INTEGER cInput, SINTEGER cLevel)
{
    SEND_STRING dvBiamp, "'Caller set level ',ITOA(cInput),' ',ITOA(cLevel),CR"
}
DEFINE_FUNCTION fnGetValues()
{
    IF (nLav1_Mute)
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_1),',0,Muted'"
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
    }
    IF (nLav2_Mute)
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_2),',0,Muted'"
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
    }
    IF (nProgram_Mute)
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PROGRAM),',0,Muted'"
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PROGRAM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
    }    
    
    WAIT 50 SEND_STRING dvBiamp, "'TIControlStatus1 get hookState',CR"
}
DEFINE_FUNCTION fnSubscribeCalls()
{
    SEND_STRING dvBiamp, "'TIControlStatus1 subscribe callState Calling',CR"
}
DEFINE_FUNCTION fnParseTesira()
{
	STACK_VAR CHAR cResponse[500] CHAR cTrash[500]
	LOCAL_VAR CHAR cMsg[100]
	LOCAL_VAR CHAR cMsgId[100]

	WHILE(FIND_STRING(nBiampBuffer,"CR,LF",1))
	{	
	    cResponse = REMOVE_STRING(nBiampBuffer,"CR,LF",1)
    
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
		
		SEND_COMMAND vdvTP_Biamp, "'^TXT-19,0,',cMsg" //Place the Number
		SEND_COMMAND vdvTP_Biamp, "'^TXT-18,0,',cMsgId" //Place the Name...
		SEND_COMMAND vdvTP_Biamp, "'PPON-IncomingCall'" //Show Caller PopuP
		//cResponse = '' 
	    }
	    ACTIVE(FIND_STRING(cResponse, '"state":TI_CALL_STATE_IDLE',1)): //Phone NOT In Use
	    {
		nPhoneState = ON_HOOK
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Disconnected'"
		WAIT 80
		{
		    cMsg = ''
		    cMsgId = ''
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-19,0,',cMsg"
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-18,0,',cMsgId"
		}
	    }
	    ACTIVE(FIND_STRING(cResponse, 'state":TI_CALL_STATE_CONNECTED',1)): 
	    {
		nPhoneState = OFF_HOOK
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Connected'"
	    }	    
	    // Updates....
	    ACTIVE(FIND_STRING(cResponse,'TI_CALL_STATE_RINGING',1)): //UPDATED!!!!
	    {
		SEND_COMMAND vdvTP_Biamp, "'@PPX'" //Close all before..
		SEND_COMMAND vdvTP_Biamp, "'PPON-IncomingCall'" //Show Caller PopuP
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Incoming Call'"
		WAIT 30 
		{
		    SEND_STRING dvBiamp, "'TIControlStatus1 get cidUser',CR"
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'"state":TI_CALL_STATE_DIALING',1)):
	    {
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Dialing'"
		nPhoneState = OFF_HOOK
	    }
	    ACTIVE(FIND_STRING(cResponse, '+OK "value":ONHOOK',1)): 
	    {
		nPhoneState = ON_HOOK
	    }
	    ACTIVE(FIND_STRING(cResponse, '+OK "value":OFFHOOK',1)): 
	    {
		nPhoneState = OFF_HOOK
	    }
	    ACTIVE(FIND_STRING(cResponse,'TI_CALL_STATE_IDLE',1)):
	    {
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Disonnected'"
		nPhoneState = ON_HOOK
	    }
	    ACTIVE(FIND_STRING(cResponse,'TI_CALL_STATE_CONNECTED',1)):
	    {
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Connected'"
		SEND_COMMAND vdvTP_Biamp, "'PPON-_Dialer'"
	    }
	    (*** Volumes & Mutes***)
	    
	    //Ceiling Mutes...
	    ACTIVE(FIND_STRING(cResponse,'Ceiling set mute 1 true',1)): //Set
	    {
		ON [nCeiling_Mute]
	    }
	    ACTIVE(FIND_STRING(cResponse,'Ceiling set mute 1 false',1)):
	    {
		OFF [nCeiling_Mute]
	    }
	    //Program  Mutes and Levels...
	    ACTIVE(FIND_STRING(cResponse,'Program set mute 1 true',1)): //Set
	    {
		ON [nProgram_Mute]
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PROGRAM),',0,Muted'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'Program set mute 1 false',1)):
	    {
		OFF [nProgram_Mute]
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PROGRAM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'Program set level 1',1)):
	    {
		REMOVE_STRING(cResponse,'Program set level 1',1)
		nProgram_Level = ATOI(cResponse)
		
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PROGRAM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
	    }
	    //Caller  Mutes and Levels...
	    ACTIVE(FIND_STRING(cResponse,'Caller set mute 1 true',1)): //Set
	    {
		ON [nMuteRinger]
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER),',0,Muted'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'Caller set mute 1 false',1)):
	    {
		OFF [nMuteRinger]
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER),',0,',ITOA(nCaller_Level + MAX_COMP),'%'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'Caller set level 1',1)):
	    {
		REMOVE_STRING(cResponse,'Caller set level 1',1)
		nCaller_Level = ATOI(cResponse)
		
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_CALLER),',0,',ITOA(nCaller_Level + MAX_COMP),'%'"
	    }
	    //LAV 1 - Level + Mutes...
	    ACTIVE(FIND_STRING(cResponse,'MicMutes set mute 1 true',1)):
	    {
		ON [nLav1_Mute]
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_1),',0,Muted'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'MicMutes set mute 1 false',1)):
	    {
		OFF [nLav1_Mute] 
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'Microphones set level 1',1)):
	    {
		REMOVE_STRING(cResponse,'Microphones set level 1',1)
		nLav1_Level = ATOI(cResponse)
		
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
	    }
	    //LAV 2...
	    ACTIVE(FIND_STRING(cResponse,'MicMutes set mute 2 true',1)):
	    {
		ON [nLav2_Mute]
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_2),',0,Muted'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'MicMutes set mute 2 false',1)):
	    {
		OFF [nLav2_Mute]
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'Microphones set level 2',1)):
	    {
		REMOVE_STRING(cResponse,'Microphones set level 2',1)
		nLav2_Level = ATOI(cResponse)
		
		SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
	    }
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [nBiampOnline]
CREATE_BUFFER dvBiamp,nBiampBuffer;

//TIMELINE_CREATE(TL_BIAMP,lTLBiamp,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

WAIT 600 //1 Minute
{
    OFF [nBiampOnline]
}


(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)


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
	
	IF ( nPhoneState == OFF_HOOK )
	{
	    SEND_STRING dvBiamp, "'TIControlStatus1 dtmf ',nDigit,CR"
	}
	
	SEND_COMMAND vdvTP_Biamp, "'^TXT-17,0,',dialPhone";
	
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
	    SEND_COMMAND vdvTP_Biamp, "'^TXT-17,0,',dialPhone";
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 14] //Clear...
{
    PUSH :
    {
	dialPhone = "";
	SEND_COMMAND vdvTP_Biamp, "'^TXT-17,0,',dialPhone";
    }
}
BUTTON_EVENT [vdvTP_Biamp, 15] //Dial...
{
    PUSH :
    {
	IF (LENGTH_STRING (dialPhone) > 0)
	{
	    TO[BUTTON.INPUT]
	    SEND_STRING dvBiamp, "'TIControlStatus1 dial ',dialPhone,CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 16] //Redial...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'TIControlStatus1 redial',CR"
    }
}
BUTTON_EVENT [vdvTP_Biamp, 17] //HangUp...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'TIControlStatus1 end ',CR"
    }
}
BUTTON_EVENT [vdvTP_Biamp, 18] //Answer...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'TIControlStatus1 answer ',CR"
	SEND_COMMAND vdvTP_Biamp, "'PPOF-IncomingCall'" //Remove Me...
	WAIT 10
	{
	    //SEND_STRING dvBiamp, "'TIControlStatus1 get hookState',$0A" 
	    SEND_COMMAND vdvTP_Biamp, "'PPON-_Phone'"
	    	    
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, 19] //Ignore Call
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_COMMAND vdvTP_Biamp, "'@PPK-IncomingCall'"
	SEND_STRING dvBiamp, "'TIControlStatus1 answer ',CR"
	WAIT 10
	{
	   SEND_STRING dvBiamp, "'TIControlStatus1 end ',CR" 
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
	    CASE 1: //Lav 1
	    {
		IF (!nLav1_Mute)
		{
		    fnMuteMicInput(MIC_LAV_1,YES_ON)
		}
		ELSE
		{
		    fnMuteMicInput(MIC_LAV_1,YES_OFF)
		}
	    }
	    CASE 2 : fnSetMicVolumeUp(MIC_LAV_1, nLav1_Level)
	    CASE 3 : fnSetMicVolumeDown(MIC_LAV_1, nLav1_Level)
	    CASE 4 : fnSetMicPreset(MIC_LAV_1, nLav1_Level_Preset)
	    
	    //LAV 2
	    CASE 5:
	    {
		IF (!nLav2_Mute)
		{
		    fnMuteMicInput(MIC_LAV_2,YES_ON)
		}
		ELSE
		{
		    fnMuteMicInput(MIC_LAV_2,YES_OFF)
		}
	    }
	    CASE 6: fnSetMicVolumeUp(MIC_LAV_2, nLav2_Level)
	    CASE 7: fnSetMicVolumeDown(MIC_LAV_2, nLav2_Level)
	    CASE 8: fnSetMicPreset(MIC_LAV_2, nLav2_Level_Preset)
	    
	    //Caller
	    CASE 9:
	    {
		IF (!nMuteRinger)
		{
		    fnMuteCaller(YES_ON)
		}
		ELSE
		{
		    fnMuteCaller(YES_OFF)
		}
	    }
	    CASE 10: fnSetCallerVolumeUp(CALLER_CLASS, nCaller_Level)
	    CASE 11: fnSetCallerVolumeDown(CALLER_CLASS, nCaller_Level)
	    CASE 12: fnCallerPreset(CALLER_CLASS, nCaller_Preset)
	    

	    //Program
	    CASE 13 :
	    {
		IF (!nProgram_Mute)
		{
		    fnMuteProgram(PROGRAM_CLASS, YES_ON)
		}
		ELSE
		{
		    fnMuteProgram(PROGRAM_CLASS, YES_OFF)
		}
	    }
	    CASE 14 : fnSetProgramVolumeUp(PROGRAM_CLASS, nProgram_Level)
	    CASE 15 : fnSetProgramVolumeDown(PROGRAM_CLASS, nProgram_Level)
	    CASE 16 : fnProgramPreset(PROGRAM_CLASS, nProgram_Preset)
	            
	    //Ceiling
	    CASE 17 : 
	    {
		IF(!nCeiling_Mute)
		{
		    fnMuteCeilingMics(YES_ON)
		}
		ELSE
		{
		    fnMuteCeilingMics(YES_OFF)
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
	    CASE 2 : fnSetMicVolumeUp(MIC_LAV_1, nLav1_Level)
	    CASE 3 : fnSetMicVolumeDown(MIC_LAV_1, nLav1_Level)
	    
	    CASE 6: fnSetMicVolumeUp(MIC_LAV_2, nLav2_Level)
	    CASE 7: fnSetMicVolumeDown(MIC_LAV_2, nLav2_Level)
	    
	    CASE 14 : fnSetProgramVolumeUp(PROGRAM_CLASS, nProgram_Level)
	    CASE 15 : fnSetProgramVolumeDown(PROGRAM_CLASS, nProgram_Level)
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Biamp]
{
    ONLINE:
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-100,0,',nBiampDevice"
	SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MYPHONE),',0,',nMyPhone"
	
	IF (!nBiampOnline)
	{
	    fnGetValues()
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
	    WAIT 150
	    {
		    fnGetValues()
		    WAIT 50
		    {
			fnSubscribeCalls()
		    }
	    }
    }
    STRING:
    {
	fnParseTesira()
    }
}


DEFINE_EVENT

TIMELINE_EVENT[TL_MAINLINE]
{
    [vdvTP_Biamp, 21] = nLav1_Mute
    [vdvTP_Biamp, 25] = nLav2_Mute //You Need Microphones!!
    [vdvTP_Biamp, 29] = nMuteRinger //Caller + Ringer
    [vdvTP_Biamp, 37] = nProgram_Mute
    [vdvTP_Biamp, 50] = nCeiling_Mute

}
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

    
