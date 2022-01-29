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

#IF_NOT_DEFINED dvTP_Biamp2
dvTP_Biamp2 =				10002:5:0
#END_IF

#IF_NOT_DEFINED dvTesira 
dvTesira =					5001:1:0
#END_IF

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

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

//biamp tags...
TAG_LEV_PRGM		= 'Program'
TAG_LEV_MICS		= 'Microphones'
TAG_MUTE_MICS		= 'MicMutes'
TAG_MUTE_PRGM		= 'ProgramMute'
TAG_CEILING			= 'privacymute'

YES_ON				= 'true'
YES_OFF				= 'false'

//Panel Addresses...
TXT_MIC_4			= 4
TXT_MIC_3			= 3
TXT_LAV_1			= 1
TXT_LAV_2			= 2
TXT_PRGM			= 10

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

#IF_NOT_DEFINED CR 
CR 					= 13
#END_IF

#IF_NOT_DEFINED LF 
LF 					= 10
#END_IF


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

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

VOLATILE INTEGER nCeiling_Mute

VOLATILE DEV vdvTP_Biamp[] = 
{
    dvTP_Biamp, 
    dvTP_Biamp2
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
DEFINE_FUNCTION fnResetAudio()
{
   WAIT 10 fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1, YES_OFF)
    
    WAIT 20 
    {
	IF (nLav1_Level_Hold == 0) 
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Preset)
	}
	ELSE
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Hold)
	}
    }
    WAIT 30 fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2, YES_OFF)
    
    WAIT 40 
    {
	IF (nLav2_Level_Hold == 0)
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Preset)
	}
	ELSE
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Hold)
	}
    }
    
    WAIT 50 fnMuteChannel(TAG_MUTE_MICS, ID_MIC_3, YES_OFF)
    WAIT 60 
    {
	IF (nMic3_Level_Hold == 0)
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_3, nMic3_Level_Preset)
	}
	ELSE
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_3, nMic3_Level_Hold)
	}
    }
    
    WAIT 70 fnMuteChannel(TAG_MUTE_MICS, ID_MIC_4, YES_OFF)
    WAIT 80 
    {
	IF (nMic4_Level_Hold == 0)
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_4, nMic4_Level_Preset)
	}
	ELSE
	{
	    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_4, nMic4_Level_Hold)
	}
    }
                 
    WAIT 90 fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV, YES_OFF)
    WAIT 100 
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
    
    WAIT 110 fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF)
    
}
DEFINE_FUNCTION fnParseTesira()
{
	STACK_VAR CHAR cResponse[500] 
	STACK_VAR INTEGER cID
	LOCAL_VAR CHAR cMsg[4]
	LOCAL_VAR CHAR cState[5]

	WHILE(FIND_STRING(nAudioBuffer,"$0D,$0A",1))
	{	
	    cResponse = REMOVE_STRING(nAudioBuffer,"$0D,$0A",1)
    
	    IF (FIND_STRING(cResponse,"TAG_LEV_MICS,' set level '",1))
	    {
		REMOVE_STRING(cResponse,"TAG_LEV_MICS,' set level '",1)
		    
		cID = ATOI(LEFT_STRING(cResponse,1))
		cMsg = MID_STRING (cResponse,2,4)
		    
		SWITCH (cID)
		{
		    CASE ID_LAV_1 :
		    {
			nLav1_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
		    }
		    CASE ID_LAV_2 :
		    {
			nLav2_Level = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
		    }
		    CASE ID_MIC_3 :
		    {
			nMic3_Level = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_3),',0,',ITOA(nMic3_Level + MAX_COMP),'%'"
		    }
		    CASE ID_MIC_4 :
		    {
			nMic4_Level = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_4),',0,',ITOA(nMic4_Level + MAX_COMP),'%'"
		    }
		}
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
	    IF (FIND_STRING (cResponse, "TAG_MUTE_MICS,' set mute '",1))
	    {
		REMOVE_STRING (cResponse,"TAG_MUTE_MICS,' set mute '",1)
		    cID = ATOI(LEFT_STRING(cResponse,1))
		    
		    IF (FIND_STRING(cResponse, "ITOA(cID),' true'",1))
		    {
			ON [vdvTP_Biamp, nMicMuteBtns[cID]]
			
			SWITCH (cID)
			{
			    CASE ID_LAV_1 : 
			    {
				ON [nLav1_Mute]
				    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,Muted'"
			    }
			    CASE ID_LAV_2 : 
			    {
				ON [nLav2_Mute]
					SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,Muted'"

			    }
			    CASE ID_MIC_3 : 
			    {
				ON [nMic3_Mute]
				    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_3),',0,Muted'"
				
			    }
			    CASE ID_MIC_4 : 
			    {
				ON [nMic4_Mute]
				    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_4),',0,Muted'"
			    }
			}
		    }
		    ELSE IF (FIND_STRING(cResponse, "ITOA(cID),' false'",1))
		    {
			OFF [vdvTP_Biamp, nMicMuteBtns[cID]]
			
			SWITCH (cID)
			{
			    CASE ID_LAV_1 : 
			    {
				OFF [nLav1_Mute]
				    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
			    }
			    CASE ID_LAV_2 : 
			    {
				OFF [nLav2_Mute]
					SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
			    }
			    CASE ID_MIC_3 : 
			    {
				OFF [nMic3_Mute]
				    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_3),',0,',ITOA(nMic3_Level + MAX_COMP),'%'"
			    }
			    CASE ID_MIC_4 : 
			    {
				OFF [nMic4_Mute]
				    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_MIC_4),',0,',ITOA(nMic4_Level + MAX_COMP),'%'"
			    }
			}
		    }
	    }
		//Program Feedback...
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
CREATE_BUFFER dvTesira,nAudioBuffer;


WAIT 600 //1 Minute
{
    OFF [nBiampOnline]
}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Biamp, nSetPresetBtns]
{
    HOLD [30] :
    {
	STACK_VAR INTEGER nPDX
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
BUTTON_EVENT [vdvTP_Biamp, nMicChnlbtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nMicChnlbtns)
	SWITCH (nChnlIdx)
	{
	    //LAV 1
	    CASE 1:
	    {
		IF (!nLav1_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_ON)
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)

	    CASE 4 : 
	    {
		IF (nLav1_Level_Hold == 0)
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Preset)
		}
		ELSE
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Hold)
		}
	    }
	    
	    //LAV 2
	    CASE 5:
	    {
		IF (!nLav2_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_ON)
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_OFF)

		}
	    }
	    CASE 6: fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 7: fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)

	    CASE 8: 
	    {
		IF (nLav2_Level_Hold == 0)
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Preset)
		}
		ELSE
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Hold)
		}
	    }
	    
	    //HH 3
	    CASE 9 :
	    {
		IF (!nMic3_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_MIC_3,YES_ON)
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_MIC_3,YES_OFF)
		}
	    }
	    CASE 10 : fnSetVolumeUp(TAG_LEV_MICS, ID_MIC_3, nMic3_Level)
	    CASE 11 : fnSetVolumeDown(TAG_LEV_MICS, ID_MIC_3, nMic3_Level)

	    CASE 12 : 
	    {
		IF (nMic3_Level_Hold == 0)
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_3, nMic3_Level_Preset)
		}
		ELSE
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_3, nMic3_Level_Hold)
		}
	    }
	    
	    CASE 13 :
	    {
		IF (!nMic4_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_MIC_4,YES_ON)
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_MIC_4,YES_OFF)
		}
	    }
	    CASE 14 : fnSetVolumeUp(TAG_LEV_MICS, ID_MIC_4, nMic4_Level)
	    CASE 15 : fnSetVolumeDown(TAG_LEV_MICS, ID_MIC_4, nMic4_Level)

	    CASE 16 : 
	    {
		IF (nMic4_Level_Hold == 0)
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_4, nMic4_Level_Preset)
		}
		ELSE
		{
		    fnSetVolumePreset(TAG_LEV_MICS, ID_MIC_4, nMic4_Level_Hold)
		}  
	    }
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nMicChnlbtns)
	SWITCH (nChnlIdx)
	{
	    CASE 2 : fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    
	    CASE 6: fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 7: fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    
	    CASE 10 : fnSetVolumeUp(TAG_LEV_MICS, ID_MIC_3, nMic3_Level)
	    CASE 11 : fnSetVolumeDown(TAG_LEV_MICS, ID_MIC_3, nMic3_Level)

	    CASE 14 : fnSetVolumeUp(TAG_LEV_MICS, ID_MIC_4, nMic4_Level)
	    CASE 15 : fnSetVolumeDown(TAG_LEV_MICS, ID_MIC_4, nMic4_Level)
	}
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

DEFINE_EVENT
DATA_EVENT [dvTP_Biamp]
{
    ONLINE:
    {
	IF (!nBiampOnline)
	{
	    fnResetAudio()
	}
    }
}
DATA_EVENT [dvTesira]
{
    ONLINE :
    {
	ON [dvTesira, 251]
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
	OFF [dvTesira, 251]
    }
    STRING :
    {
	    fnParseTesira()
    }
}
    
