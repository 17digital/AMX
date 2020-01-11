PROGRAM_NAME='Tesira_Phone421'



(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/28/2019  AT: 20:16:14        *)
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

#IF_NOT_DEFINED dvTP_Biamp2
dvTP_Biamp2 =					10002:5:0
#END_IF

#IF_NOT_DEFINED dvBiamp
dvBiamp =						5001:4:0 //Tesira TOP Biamp
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

TXT_PROGRAM			= 10
TXT_CALLER			= 11
TXT_MYPHONE			= 20
TXT_SIPDISAPLAY_NAME	= 22

#IF_NOT_DEFINED CR
CR				= 13
#END_IF

#IF_NOT_DEFINED LF
LF				= 10
#END_IF


YES_ON				= 'true'
YES_OFF				= 'false'

TAG_PRGM			= 'Program'
TAG_CEILING			= 'MicMutes'

ID_PROGRAM			= 1
ID_CEILING				= 1

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR nBiampDevice[30] = 'Tesira VT'
CHAR nMyPhone[15] = '404-385-4920'
CHAR nSipName[10]

VOLATILE INTEGER nBiampOnline

VOLATILE LONG lTLBiamp[] = {250}
VOLATILE CHAR nBiampBuffer[2500]

VOLATILE SINTEGER nProgram_Preset = -8 //Set Default Level
VOLATILE SINTEGER nProgram_Level //Caller + Speakers
VOLATILE INTEGER nProgram_Mute

VOLATILE INTEGER nCeiling_Mute //Ceiling Mics

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
DEFINE_FUNCTION fnMuteCeilingMics(CHAR cTag[], INTEGER cIn,    CHAR cMute[MAX_SPAN])
{
    //Toggle Logic State...
    SEND_STRING dvBiamp, "cTag,' set mute ',ITOA(cIn),' ',cMute,CR" 
}
DEFINE_FUNCTION fnMuteVolume(CHAR cTag[], INTEGER cIn, CHAR cValue[MAX_SPAN]) 
{
    SEND_STRING dvBiamp, "cTag,' set mute ',ITOA(cIn),' ',cValue,CR"
}
DEFINE_FUNCTION fnSetVolumeUp(CHAR cTag[], INTEGER cIn, SINTEGER cVolume)
{
    IF (nProgram_Level < nMaximum )
    {
	SEND_STRING dvBiamp, "cTag,' set level ',ITOA(cIn),' ',ITOA(cVolume + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnSetVolumeDown(CHAR cTag[], INTEGER cIn, SINTEGER cVolume)
{
    IF (nProgram_Level > nMinimum )
    {
	SEND_STRING dvBiamp, "cTag,' set level ',ITOA(cIn),' ',ITOA(cVolume + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], INTEGER cIn, SINTEGER cLevel)
{
    SEND_STRING dvBiamp, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLevel),CR"
}
DEFINE_FUNCTION fnGetValues()
{
    WAIT 10 fnSetVolumePreset(TAG_PRGM, ID_PROGRAM, nProgram_Preset)
    WAIT 20 fnMuteVolume(TAG_PRGM, ID_PROGRAM, YES_OFF)
    WAIT 30 fnMuteCeilingMics(TAG_CEILING, ID_CEILING, YES_OFF)
}
DEFINE_FUNCTION fnSubscribeCalls()
{
    SEND_STRING dvBiamp, "'TIControlStatus1 subscribe callState Calling',CR"
}
DEFINE_FUNCTION fnNoDisturb(CHAR cValue[MAX_SPAN])
{
    SEND_STRING dvBiamp, "'VoIPControlStatus1 set dndEnable 1 ',cValue,CR"
    //SEND_STRING dvBiamp, "'VoIPControlStatus1 get dndEnable 1',CR"
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
		
		SEND_COMMAND vdvTP_Biamp, "'@PPX'"
		SEND_COMMAND vdvTP_Biamp, "'PPON-_Phone'"
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Incoming Call'"
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
	    ACTIVE(FIND_STRING(cResponse,'! "publishToken":"Calling" "value":{"callStateInfo":[{"state":TI_CALL_STATE_RINGING',1)):
	    {
		SEND_COMMAND vdvTP_Biamp, "'PPON-_Phone'"
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
	    ACTIVE(FIND_STRING(cResponse,'TI_CALL_STATE_IDLE',1)):
	    {
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Disonnected'"
		nPhoneState = ON_HOOK
	    }
	    ACTIVE(FIND_STRING(cResponse,'TI_CALL_STATE_CONNECTED',1)):
	    {
		SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Connected'"
		//SEND_COMMAND vdvTP_Biamp, "'PPON-_Dialer'"
		SEND_COMMAND vdvTP_Biamp, "'PPON-_Phone'"
	    }
	    //Ceiling Mutes...
	    ACTIVE(FIND_STRING(cResponse,'MicMutes set mute 1 true',1)): 
	    {
		ON [nCeiling_Mute]
	    }
	    ACTIVE(FIND_STRING(cResponse,'MicMutes set mute 1 false',1)):
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
	
	nPhoneState = ON_HOOK
	SEND_COMMAND vdvTP_Biamp, "'^TXT-21,0,Disconnected'"
    }
}
BUTTON_EVENT [vdvTP_Biamp, 18] //Answer...
{
    PUSH :
    {
	TO[BUTTON.INPUT]
	SEND_STRING dvBiamp, "'TIControlStatus1 answer ',CR"
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
	    

	    //Program
	    CASE 1 :
	    {
		IF (!nProgram_Mute)
		{
		    fnMuteVolume(TAG_PRGM, ID_PROGRAM, YES_ON)
		}
		ELSE
		{
		    fnMuteVolume(TAG_PRGM, ID_PROGRAM, YES_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_PRGM, ID_PROGRAM, nProgram_Level)
	    CASE 3 : fnSetVolumeDown(TAG_PRGM, ID_PROGRAM, nProgram_Level)
	    CASE 4 : fnSetVolumePreset(TAG_PRGM, ID_PROGRAM, nProgram_Preset)
	            
	    //Ceiling
	    CASE 5 : 
	    {
		IF(!nCeiling_Mute)
		{
		    fnMuteCeilingMics(TAG_CEILING, ID_CEILING, YES_ON)
		}
		ELSE
		{
		    fnMuteCeilingMics(TAG_CEILING, ID_CEILING, YES_OFF)
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
	    CASE 2 : fnSetVolumeUp(TAG_PRGM, ID_PROGRAM, nProgram_Level)
	    CASE 3 : fnSetVolumeDown(TAG_PRGM, ID_PROGRAM, nProgram_Level)
	    
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Biamp]
{
    ONLINE:
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-100,0,',nBiampDevice"
	SEND_COMMAND vdvTP_Biamp, "'^TXT-22,0,',nMyPhone"
	
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
	    
	    WAIT 100
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

TIMELINE_EVENT[TL_FEEDBACK]
{

    [vdvTP_Biamp, 37] = nProgram_Mute
    [vdvTP_Biamp, 50] = nCeiling_Mute
    
    WAIT 3600 //6 Minutes...
    {
	fnSubscribeCalls()
    }

}
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)




