PROGRAM_NAME='Tesira'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/11/2020  AT: 16:09:45        *)
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


#IF_NOT_DEFINED dvTP_BiampBooth
dvTP_BiampBooth =			10002:5:0

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
ID_HH_4				= 6
ID_FLOOR				= 7
ID_FLOOR_MUTE			= 1 //Triggers Mute Block Only

ID_PRGM_LEV			= 1
ID_MUTE_152			= 2

//biamp tags...
TAG_LEV_PRGM			= 'Program'
TAG_LEV_MICS			= 'MixOuts'
TAG_MUTE_MICS			= 'MicMutes'
TAG_MUTE_PRGM			= 'ProgramMute'
TAG_MUTE_FLOOR		= 'FloorMute'
TAG_PRESET_MIDAS		= 'LiveFeed'
TAG_PRESET_TP			= 'LocalFeed'

YES_ON				= 'true'
YES_OFF				= 'false'

//Panel Addresses...
TXT_LAV_1				= 1
TXT_LAV_2				= 2
TXT_HH_1				= 3
TXT_HH_2				= 4
TXT_HH_3				= 5
TXT_HH_4				= 6
TXT_FLOOR				= 7
TXT_PRGM				= 10

BTN_MUTE_MIC_1				= 1
BTN_MUTE_MIC_2				= 5
BTN_MUTE_MIC_3				= 9
BTN_MUTE_MIC_4				= 13
BTN_MUTE_MIC_5				= 17
BTN_MUTE_MIC_6				= 21
BTN_MUTE_FLOOR				= 25
BTN_MUTE_PRGM				= 37

BTN_PRESET_MIDAS			= 501
BTN_PRESET_TP				= 500

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

CHAR nBiampDevice[30] = 'Tesira Server'
CHAR nMyPhone[15] = 'N/A'

VOLATILE SINTEGER nMaximum = 12
VOLATILE SINTEGER nMinimum = -88

VOLATILE INTEGER nBiampOnline

VOLATILE CHAR nAudioBuffer[1000]

DEV vdvTP_Biamp[] = {dvTP_Biamp, dvTP_BiampBooth}


//Wireless Microphones...
VOLATILE SINTEGER nHH1_Level
VOLATILE SINTEGER nHH1_Level_Preset = -13

VOLATILE SINTEGER nHH2_Level
VOLATILE SINTEGER nHH2_Level_Preset = -13

VOLATILE SINTEGER nHH3_Level
VOLATILE SINTEGER nHH3_Level_Preset = -12

VOLATILE SINTEGER nHH4_Level
VOLATILE SINTEGER nHH4_Level_Preset = -13

//Wireless Lavs...
VOLATILE SINTEGER nLav1_Level
VOLATILE SINTEGER nLav1_Level_Preset = -10

VOLATILE SINTEGER nLav2_Level
VOLATILE SINTEGER nLav2_Level_Preset = -10

//Wired Microphones...
VOLATILE SINTEGER nFloor_Level
VOLATILE SINTEGER nFloor_Level_Preset = -10

//Program
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
    
    //HH 4
    21,22,23,24,
    
    //Floor
    25,26,27,28,
        
    //Program...
    37,38,39,40
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_BiampBooth, BTN_PRESET_MIDAS],[dvTP_BiampBooth, BTN_PRESET_TP])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnRecallPreset(CHAR cPreset[])
{
    SEND_STRING dvTesira, "'DEVICE recallPresetByName ',cPreset,CR"
    
    SWITCH (cPreset)
    {
	CASE TAG_PRESET_MIDAS : //LiveFeed
	{
	    ON [dvTP_BiampBooth, BTN_PRESET_MIDAS]
	}
	CASE TAG_PRESET_TP : //LocalFeed
	{
	    ON [dvTP_BiampBooth, BTN_PRESET_TP]
	}
    }
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
                 
    WAIT 50 fnMuteChannel(TAG_MUTE_MICS, ID_HH_1, YES_OFF)
    WAIT 60 fnSetVolumePreset(TAG_LEV_MICS, ID_HH_1, nHH1_Level_Preset)
                 
    WAIT 70 fnMuteChannel(TAG_MUTE_MICS, ID_HH_2, YES_OFF)
    WAIT 80 fnSetVolumePreset(TAG_LEV_MICS, ID_HH_2, nHH2_Level_Preset)
                 
    WAIT 90 fnMuteChannel(TAG_MUTE_MICS, ID_HH_3, YES_OFF)
    WAIT 100  fnSetVolumePreset(TAG_LEV_MICS, ID_HH_3, nHH3_Level_Preset)

    WAIT 110 fnMuteChannel(TAG_MUTE_MICS, ID_HH_4, YES_OFF)
    WAIT 120  fnSetVolumePreset(TAG_LEV_MICS, ID_HH_4, nHH4_Level_Preset)
	
                 
    WAIT 130 fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV, YES_OFF)
    WAIT 140 fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
    
    WAIT 150 fnMuteChannel(TAG_MUTE_FLOOR,ID_FLOOR_MUTE,YES_OFF)
    WAIT 160  fnSetVolumePreset(TAG_LEV_MICS,ID_FLOOR,nFloor_Level_Preset)
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
    			CASE ID_HH_4:
			{
			    nHH4_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_4),',0,',ITOA(nHH4_Level + MAX_COMP),'%'"
			}
     			CASE ID_FLOOR:
			{
			    nFloor_Level = ATOI(cMsg)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_FLOOR),',0,',ITOA(nFloor_Level + MAX_COMP),'%'"
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

//WAIT 300
//{
//    fnRecallPreset(TAG_PRESET_TP) //Room Default
//}
WAIT 600 //1 Minute
{
    OFF [nBiampOnline]
}


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Biamp, BTN_PRESET_TP]
BUTTON_EVENT [vdvTP_Biamp, BTN_PRESET_MIDAS]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PRESET_TP : fnRecallPreset(TAG_PRESET_TP)
	    CASE BTN_PRESET_MIDAS : fnRecallPreset(TAG_PRESET_MIDAS)
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
	    //LAV 1
	    CASE 1:
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_MIC_1])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_MIC_1]
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_1,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_1),',0,',ITOA(nLav1_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_MIC_1]
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 3 : fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_1, nLav1_Level)
	    CASE 4 : fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_1, nLav1_Level_Preset)
	    
	    //LAV 2
	    CASE 5:
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_MIC_2])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_MIC_2]
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_LAV_2,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_LAV_2),',0,',ITOA(nLav2_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_MIC_2]
		}
	    }
	    CASE 6: fnSetVolumeUp(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 7: fnSetVolumeDown(TAG_LEV_MICS, ID_LAV_2, nLav2_Level)
	    CASE 8: fnSetVolumePreset(TAG_LEV_MICS, ID_LAV_2, nLav2_Level_Preset)
	    
	    //HH 1
	    CASE 9 :
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_MIC_3])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_HH_1,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_1),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_MIC_3]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_HH_1,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_1),',0,',ITOA(nHH1_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_MIC_3]
		}
	    }
	    CASE 10 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_1, nHH1_Level)
	    CASE 11 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_1, nHH1_Level)
	    CASE 12 : fnSetVolumePreset(TAG_LEV_MICS, ID_HH_1, nHH1_Level_Preset)
	    
	    //HH 2
	    CASE 13 :
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_MIC_4])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_HH_2,YES_ON)
		        SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_2),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_MIC_4]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_HH_2,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_2),',0,',ITOA(nHH2_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_MIC_4]
		}
	    }
	    CASE 14 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_2, nHH2_Level)
	    CASE 15 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_2, nHH2_Level)
	    CASE 16 : fnSetVolumePreset(TAG_LEV_MICS, ID_HH_2, nHH2_Level_Preset)
	    
	    //HH 3
	    CASE 17 :
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_MIC_5])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_HH_3,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_3),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_MIC_5]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_HH_3,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_3),',0,',ITOA(nHH3_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_MIC_5]
		}
	    }
	    CASE 18 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_3, nHH3_Level)
	    CASE 19 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_3, nHH3_Level)
	    CASE 20 : fnSetVolumePreset(TAG_LEV_MICS, ID_HH_3, nHH3_Level_Preset)
	    
	    //TT 1
	    CASE 21 :
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_MIC_6])
		{
		    fnMuteChannel(TAG_MUTE_MICS, ID_HH_4,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_4),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_MIC_6]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_MICS, ID_HH_4,YES_OFF)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_4),',0,',ITOA(nHH4_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_MIC_6]
		}
	    }
	    CASE 22 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_4, nHH4_Level)
	    CASE 23 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_4, nHH4_Level)
	    CASE 24 : fnSetVolumePreset(TAG_LEV_MICS, ID_HH_4, nHH4_Level_Preset)
	    
	    //Floor (Podium)
	    CASE 25 :
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_FLOOR])
		{
		    fnMuteChannel(TAG_MUTE_FLOOR,ID_FLOOR_MUTE,YES_ON)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_FLOOR),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_FLOOR]
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_FLOOR,ID_FLOOR_MUTE,YES_OFF)
    			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_FLOOR),',0,',ITOA(nFloor_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_FLOOR]
		}
	    }
	    CASE 26 : fnSetVolumeUp(TAG_LEV_MICS, ID_FLOOR, nFloor_Level)
	    CASE 27 : fnSetVolumeDown(TAG_LEV_MICS, ID_FLOOR, nFloor_Level)
	    CASE 28 : fnSetVolumePreset(TAG_LEV_MICS, ID_FLOOR, nFloor_Level_Preset)
	    
	             
	    //Program
	    CASE 29 :
	    {
		IF (![vdvTP_Biamp, BTN_MUTE_PRGM])
		{
		    fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV,YES_ON)
		    	    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
			    ON [vdvTP_Biamp, BTN_MUTE_PRGM]
		}
		ELSE
		{
		   fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV,YES_OFF)
		   	    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
			    OFF [vdvTP_Biamp, BTN_MUTE_PRGM]
		}
	    }
	    CASE 30 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 31 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 32 : fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level_Preset)
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
	    
	    CASE 22 : fnSetVolumeUp(TAG_LEV_MICS, ID_HH_4, nHH4_Level)
	    CASE 23 : fnSetVolumeDown(TAG_LEV_MICS, ID_HH_4, nHH4_Level)
	    
	    CASE 26 : fnSetVolumeUp(TAG_LEV_MICS, ID_FLOOR, nFloor_Level)
	    CASE 27 : fnSetVolumeDown(TAG_LEV_MICS, ID_FLOOR, nFloor_Level)
	    
	    CASE 30 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	    CASE 31 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Level)
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Biamp]
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
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1'"
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

//DEFINE_EVENT
//TIMELINE_EVENT[TL_FEEDBACK]
//{
//    
//    WAIT 1600
//    {
//	SEND_STRING dvTesira, "'DEVICE get hostname',CR"
//    }
//}                                    
