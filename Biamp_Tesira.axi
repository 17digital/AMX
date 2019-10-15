PROGRAM_NAME='Biamp_Nexia'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/14/2019  AT: 13:26:18        *)
(***********************************************************)

(*
https://support.biamp.com/Tesira/Control/Tesira_command_string_calculator

    *)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Biamp
dvTP_Biamp =				10001:5:0
#END_IF

#IF_NOT_DEFINED dvTP_Biamp2
dvTP_Biamp2 =				10002:5:0
#END_IF

#IF_NOT_DEFINED dvTesira 
dvTesira =					5001:2:0
#END_IF

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

MAX_COMP			= 88

VOL_UP				= 1
VOL_DN				= -1

//Biamp IDs...
ID_LAV_1				= 1
ID_LAV_2				= 2
ID_HH_1				= 3
ID_HH_2				= 4
ID_HH_3				= 5
ID_TT_1				= 6
ID_TT_2				= 7
ID_TT_3				= 8
ID_TT_4				= 9
ID_PRGM_LEV			= 1
ID_MUTE_152			= 2

//biamp tags...
TAG_LEV_PRGM		= 'Program'
TAG_LEV_MICS			= 'Microphones'
TAG_MUTE_MICS		= 'MicMutes'
TAG_MUTE_PRGM		= 'ProgramMute'

YES_ON				= 'true'
YES_OFF				= 'false'

//Panel Addresses...
TXT_LAV_1				= 1
TXT_LAV_2				= 2
TXT_HH_1				= 3
TXT_HH_2				= 4
TXT_HH_3				= 5
TXT_TT_1				= 6
TXT_TT_2				= 7
TXT_TT_3				= 8
TXT_TT_4				= 9
TXT_PRGM				= 10


#IF_NOT_DEFINED CR
CR						= 13
#END_IF

#IF_NOT_DEFINED LF
LF					= 10
#END_IF


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR nBiampDevice[30] = 'Tesira TI'
CHAR nMyPhone[15] = 'N/A'

VOLATILE SINTEGER nMaximum = 12
VOLATILE SINTEGER nMinimum = -88

VOLATILE INTEGER nBiampOnline

VOLATILE CHAR nAudioBuffer[1000]

DEV vdvTP_Biamp[] = {dvTP_Biamp, dvTP_Biamp2}

//152 Overflow Mute
VOLATILE INTEGER nOverflow_Mute

//Wireless Microphones...
VOLATILE INTEGER nHH1_Mute
VOLATILE SINTEGER nHH1_Level
VOLATILE SINTEGER nHH1_Level_Preset = -2

VOLATILE INTEGER nHH2_Mute
VOLATILE SINTEGER nHH2_Level
VOLATILE SINTEGER nHH2_Level_Preset = -3

VOLATILE INTEGER nHH3_Mute
VOLATILE SINTEGER nHH3_Level
VOLATILE SINTEGER nHH3_Level_Preset = -3

//Wireless Lavs...
VOLATILE INTEGER nLav1_Mute
VOLATILE SINTEGER nLav1_Level
VOLATILE SINTEGER nLav1_Level_Preset = -10

VOLATILE INTEGER nLav2_Mute
VOLATILE SINTEGER nLav2_Level
VOLATILE SINTEGER nLav2_Level_Preset = -10

//TT Microphones...
VOLATILE INTEGER nTT1_Mute
VOLATILE SINTEGER nTT1_Level
VOLATILE SINTEGER nTT1_Level_Preset = -7

VOLATILE INTEGER nTT2_Mute
VOLATILE SINTEGER nTT2_Level
VOLATILE SINTEGER nTT2_Level_Preset = -7

VOLATILE INTEGER nTT3_Mute
VOLATILE SINTEGER nTT3_Level
VOLATILE SINTEGER nTT3_Level_Preset = -7

VOLATILE INTEGER nTT4_Mute
VOLATILE SINTEGER nTT4_Level
VOLATILE SINTEGER nTT4_Level_Preset = -7

//Program
VOLATILE INTEGER nProgram_Mute
VOLATILE SINTEGER nProgram_Level
VOLATILE SINTEGER nProgram_Level_Preset = -10

VOLATILE INTEGER nChnlbtns[] =
{
    // Lav 1
    1,2,3,4,

    // Lav 2
    5,6,7,8,

    //HH 1
    9,10,11,12, 

    //HH 2
    13,14,15,16,
    
    //HH 3
    17,18,19,20,
    
    //TT 1
    21,22,23,24,
    
    //TT 2
    25,26,27,28,
    
    //TT 3
    29,30,31,32,
    
    //TT 4
    33,34,35,36,
    
    //Program...
    37,38,39,40,
    
    //Overflow Mute
    50 
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
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

DEFINE_FUNCTION fnMuteOverFlow() 
{
     fnMuteChannel(TAG_MUTE_PRGM, ID_MUTE_152,YES_ON)
     ON [nOverflow_Mute]
}
DEFINE_FUNCTION fnUnMuteOverflow()
{
    fnMuteChannel(TAG_MUTE_PRGM, ID_MUTE_152,YES_OFF)
    WAIT 10 fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV,YES_OFF) //Make sure main feed is unmuted!
    WAIT 20 fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
    OFF [nOverflow_Mute]
}
DEFINE_FUNCTION fnResetAudio()
{
    WAIT 10 fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1, YES_OFF)
    WAIT 20 fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Preset)
                 
    WAIT 30 fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2, YES_OFF)
    WAIT 40 fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Preset)
                 
    WAIT 50 fnMuteChannel(TAG_MUTE_MICS, ID_HH_1, YES_OFF)
    WAIT 60 fnSetVolumePreset(TAG_LEV_MICS, ID_HH_1, nHH1_Level_Preset)
                 
    WAIT 70 fnMuteChannel(TAG_MUTE_MICS, ID_HH_2, YES_OFF)
    WAIT 80 fnSetVolumePreset(TAG_LEV_MICS, ID_HH_2, nHH2_Level_Preset)
                 
    WAIT 90 fnMuteChannel(TAG_MUTE_MICS, ID_HH_3, YES_OFF)
    WAIT 100  fnSetVolumePreset(TAG_LEV_MICS, ID_HH_3, nHH3_Level_Preset)
                 
    WAIT 110 fnMuteChannel(TAG_MUTE_MICS, ID_TT_1, YES_OFF)
    WAIT 120 fnSetVolumePreset(TAG_LEV_MICS, ID_TT_1, nTT1_Level_Preset)
                 
    WAIT 130 fnMuteChannel(TAG_MUTE_MICS, ID_TT_2, YES_OFF)
    WAIT 140 fnSetVolumePreset(TAG_LEV_MICS, ID_TT_2, nTT2_Level_Preset)
                 
    WAIT 150 fnMuteChannel(TAG_MUTE_MICS, ID_TT_3, YES_OFF)
    WAIT 160 fnSetVolumePreset(TAG_LEV_MICS, ID_TT_3, nTT3_Level_Preset)
                 
    WAIT 170 fnMuteChannel(TAG_MUTE_MICS, ID_TT_4, YES_OFF)
    WAIT 180 fnSetVolumePreset(TAG_LEV_MICS, ID_TT_4, nTT4_Level_Preset)
                 
    WAIT 190 fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV, YES_OFF)
    WAIT 200 fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
    
    WAIT 220 fnMuteChannel(TAG_MUTE_PRGM, ID_MUTE_152, YES_ON)
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[500]
    STACK_VAR INTEGER cID 
    LOCAL_VAR CHAR cMsg[4]


	WHILE(FIND_STRING(nAudioBuffer,"CR,LF",1))
	{	
	    cResponse = REMOVE_STRING(nAudioBuffer,"CR,LF",1)
    
	    SELECT
	    {
		//LAV 1
		ACTIVE(FIND_STRING(cResponse,"TAG_LEV_MICS,' set level '",1)):
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
			CASE ID_HH_1:
			{
			    nHH1_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_1),',0,',ITOA(nHH1_Level + MAX_COMP),'%'"
			}
			CASE ID_HH_2:
			{
			    nHH2_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_2),',0,',ITOA(nHH2_Level + MAX_COMP),'%'"
			}
			CASE ID_HH_3:
			{
			    nHH3_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_3),',0,',ITOA(nHH3_Level + MAX_COMP),'%'"
			}
			CASE ID_TT_1 :
			{
			    nTT1_Level = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_1),',0,',ITOA(nTT1_Level + MAX_COMP),'%'"
			}
			CASE ID_TT_2 :
			{
			    nTT2_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_2),',0,',ITOA(nTT2_Level + MAX_COMP),'%'"
			}
			CASE ID_TT_3 :
			{
			    nTT3_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_3),',0,',ITOA(nTT3_Level + MAX_COMP),'%'"
			}
			CASE ID_TT_4 :
			{
			    nTT4_Level = ATOI(cMsg)
		    		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_4),',0,',ITOA(nTT4_Level + MAX_COMP),'%'"
			}
		    }
		}
		//Program Feedback...
		ACTIVE(FIND_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)):
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
BUTTON_EVENT [vdvTP_Biamp, nChnlbtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nChnlbtns)
	SWITCH (nChnlIdx)
	{
	    //LAV 1
	    CASE 1:
	    {
		IF (!nLav1_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,Muted'"
			    ON [nLav1_Mute]
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
			    OFF [nLav1_Mute]
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 4 : fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Preset)
	    
	    //LAV 2
	    CASE 5:
	    {
		IF (!nLav2_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,Muted'"
			    ON [nLav2_Mute]
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
			    OFF [nLav2_Mute]
		}
	    }
	    CASE 6: fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 7: fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 8: fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Preset)
	    
	    //HH 1
	    CASE 9 :
	    {
		IF (!nHH1_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_HH_1,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_1),',0,Muted'"
			    ON [nHH1_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_HH_1,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_1),',0,',ITOA(nHH1_Level + MAX_COMP),'%'"
			    OFF [nHH1_Mute]
		}
	    }
	    CASE 10 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_1, nHH1_Level)
	    CASE 11 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_1, nHH1_Level)
	    CASE 12 : fnSetVolumePreset(TAG_LEV_MICS, ID_HH_1, nHH1_Level_Preset)
	    
	    //HH 2
	    CASE 13 :
	    {
		IF (!nHH2_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_HH_2,YES_ON)
		        SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_2),',0,Muted'"
			    ON [nHH2_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_HH_2,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_2),',0,',ITOA(nHH2_Level + MAX_COMP),'%'"
			    OFF [nHH2_Mute]
		}
	    }
	    CASE 14 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_2, nHH2_Level)
	    CASE 15 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_2, nHH2_Level)
	    CASE 16 : fnSetVolumePreset(TAG_LEV_MICS, ID_HH_2, nHH2_Level_Preset)
	    
	    //HH 3
	    CASE 17 :
	    {
		IF (!nHH3_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_HH_3,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_3),',0,Muted'"
			    ON [nHH3_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_HH_3,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_3),',0,',ITOA(nHH3_Level + MAX_COMP),'%'"
			    OFF [nHH3_Mute]
		}
	    }
	    CASE 18 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_3, nHH3_Level)
	    CASE 19 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_3, nHH3_Level)
	    CASE 20 : fnSetVolumePreset(TAG_LEV_MICS, ID_HH_3, nHH3_Level_Preset)
	    
	    //TT 1
	    CASE 21 :
	    {
		IF (!nTT1_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_TT_1,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_1),',0,Muted'"
			    ON [nTT1_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_TT_1,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_1),',0,',ITOA(nTT1_Level + MAX_COMP),'%'"
			    OFF [nTT1_Mute]
		}
	    }
	    CASE 22 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_1, nTT1_Level)
	    CASE 23 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_1, nTT1_Level)
	    CASE 24 : fnSetVolumePreset(TAG_LEV_MICS, ID_TT_1, nTT1_Level_Preset)
	    
	    //TT 2
	    CASE 25 :
	    {
		IF (!nTT2_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_TT_2,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_2),',0,Muted'"
			    ON [nTT2_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_TT_2,YES_OFF)
    			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_2),',0,',ITOA(nTT2_Level + MAX_COMP),'%'"
			    OFF [nTT2_Mute]
		}
	    }
	    CASE 26 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_2, nTT2_Level)
	    CASE 27 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_2, nTT2_Level)
	    CASE 28 : fnSetVolumePreset(TAG_LEV_MICS, ID_TT_2, nTT2_Level_Preset)
	    
	    //TT 3
	    CASE 29 :
	    {
		IF (!nTT3_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_TT_3,YES_ON)
    			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_3),',0,Muted'"
			    ON [nTT3_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_TT_3,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_3),',0,',ITOA(nTT3_Level + MAX_COMP),'%'"
			    OFF [nTT3_Mute]
		}
	    }
	    CASE 30 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_3, nTT3_Level)
	    CASE 31 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_3, nTT3_Level)
	    CASE 32 : fnSetVolumePreset(TAG_LEV_MICS, ID_TT_3, nTT3_Level_Preset)
	    
	    //TT 4
	    CASE 33 :
	    {
		IF (!nTT4_Mute)
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_TT_4,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_4),',0,Muted'"
			    ON [nTT4_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_TT_4,YES_OFF)
    			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_TT_4),',0,',ITOA(nTT4_Level + MAX_COMP),'%'"
			    OFF [nTT4_Mute]
		}
	    }
	    CASE 34 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_4, nTT4_Level)
	    CASE 35 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_4, nTT4_Level)
	    CASE 36 : fnSetVolumePreset(TAG_LEV_MICS, ID_TT_4, nTT4_Level_Preset)
	             
	    //Program
	    CASE 37 :
	    {
		IF (!nProgram_Mute)
		{
		    fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV,YES_ON)
		    	    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
			    ON [nProgram_Mute]
		}
		ELSE
		{
		   fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV,YES_OFF)
		   	    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
			    OFF [nProgram_Mute]
		}
	    }
	    CASE 38 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 39 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 40 : fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
	            
	    //Overflow...
	    CASE 41 : 
	    {
		IF(!nOverflow_Mute)
		{
		    fnMuteOverFlow()
		}
		ELSE
		{
		    fnUnMuteOverflow()
		}
	    }
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nChnlbtns)
	SWITCH (nChnlIdx)
	{
	    CASE 2 : fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    
	    CASE 6: fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 7: fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    
	    CASE 10 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_1, nHH1_Level)
	    CASE 11 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_1, nHH1_Level)
	    
	    CASE 14 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_2, nHH2_Level)
	    CASE 15 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_2, nHH2_Level)
	    
	    CASE 18 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_3, nHH3_Level)
	    CASE 19 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_3, nHH3_Level)
	    
	    CASE 22 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_1, nTT1_Level)
	    CASE 23 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_1, nTT1_Level)
	    
	    CASE 26 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_2, nTT2_Level)
	    CASE 27 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_2, nTT2_Level)
	    
	    CASE 30 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_3, nTT3_Level)
	    CASE 31 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_3, nTT3_Level)
	    
	    CASE 34 : fnSetVolumeUp(TAG_LEV_MICS, ID_TT_4, nTT4_Level)
	    CASE 35 : fnSetVolumeDown(TAG_LEV_MICS, ID_TT_4, nTT4_Level)
	
	    CASE 38 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 39 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Biamp]
DATA_EVENT [dvTP_Biamp2]
{
    ONLINE:
    {
	SEND_COMMAND vdvTP_Biamp, "'^TXT-100,0,',nBiampDevice"
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
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1 485 DISABLED'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 100
	{
	    fnResetAudio()
	}
    }
    STRING :
    {
	    fnParseTesira()
    }
}

DEFINE_EVENT
TIMELINE_EVENT[TL_FEEDBACK]
{
    [vdvTP_Biamp, 1] = nLav1_Mute
    [vdvTP_Biamp, 5] = nLav2_Mute
    [vdvTP_Biamp, 9] = nHH1_Mute
    [vdvTP_Biamp, 13] = nHH2_Mute
    [vdvTP_Biamp, 17] = nHH3_Mute
    [vdvTP_Biamp, 21] = nTT1_Mute
    [vdvTP_Biamp, 25] = nTT2_Mute
    [vdvTP_Biamp, 29] = nTT3_Mute
    [vdvTP_Biamp, 33] = nTT4_Mute
    [vdvTP_Biamp, 37] = nProgram_Mute
    [vdvTP_Biamp, 50] = nOverflow_Mute
    
    WAIT 1600
    {
	SEND_STRING dvTesira, "'DEVICE get hostname',CR"
    }
}                                    
