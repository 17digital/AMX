PROGRAM_NAME='Biamp_Nexia'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/16/2016  AT: 08:10:56        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Notes
	http://support.biamp.com/Audia-Nexia/Control/Audia-Nexia_command_string_calculator
	
	Also works with audia
	
	"'GET 0 IPADDR',$0A"
	"'GET 0 SUBNETMASK',$0A"
	GET 0 DEFAULTGW
	REBOOT 0 DEVICE<LF>
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED DVX_REMOTE
DVX_REMOTE =				4011
#END_IF

#IF_NOT_DEFINED dvTP_Biamp
dvTP_Biamp =					10001:5:0
#END_IF

#IF_NOT_DEFINED dvTP_Biamp2
dvTP_Biamp2 =				10001:5:DVX_REMOTE

#IF_NOT_DEFINED dvBiamp
dvBiamp =					5301:1:0
#END_IF

//#IF_NOT_DEFINED dvBiamp115
//dvBiamp115 =				5350:1:DVX_REMOTE //To Call Presets when Combining & Seperating...
//#END_IF

#IF_NOT_DEFINED vdvPipeTX
vdvPipeTX				= 33333:1:DVX_REMOTE
#END_IF

#IF_NOT_DEFINED vdvPipeRX
vdvPipeRX				= 33333:2:DVX_REMOTE
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED CR 
CR 					 = 13
#END_IF

#IF_NOT_DEFINED LF
LF 					= 10
#END_IF

MAX_COMP			= 88 //88 is the difference from 12 - 100 = 88

VOL_UP				= 1
VOL_DN				= -1

ID_HH_4				= 1
ID_HH_5				= 2
ID_HH_6				= 3
ID_PRGM_LEV			= 1
ID_CEILING			= 1

TAG_LEV_MICS			= 'Wireless'
TAG_LEV_PRGM			= 'Program'
TAG_MUTE_MICS			= 'Wireless'
TAG_MUTE_CEILING		= 'Ceiling'
TAG_MUTE_PRGM			= 'ProgramIn'

YES_ON				= 1
YES_OFF				= 0

//Panel Address
TXT_HH_4			= 4
TXT_HH_5			= 5
TXT_HH_6			= 6
TXT_PRGM			= 10

BTN_MUTE_HH4		= 1
BTN_MUTE_HH5		= 5
BTN_MUTE_HH6		= 9
BTN_MUTE_PRGM		= 37
BTN_MUTE_CEILING		= 50

BTN_PRESET_SEPERATE		= 1001
BTN_PRESET_MASTER		= 1002
BTN_PRESET_SERVE			= 1003

//PIPE Comm...
PIPE_AUDIO_SEPERATE		= 50
PIPE_AUDIO_COMBINE		= 51

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR nBiampDevice[30] = 'Room 114'
VOLATILE INTEGER nBiampOnline
VOLATILE CHAR nBiampBuffer[1000]

VOLATILE SINTEGER nMaximum = 12
VOLATILE SINTEGER nMinimum = -88

//Program
VOLATILE INTEGER nProgramMute 
VOLATILE SINTEGER nProgramVOL
VOLATILE SINTEGER nProgram_Vol_Preset = - 10

//Microphone 4
VOLATILE INTEGER nMic4Mute
VOLATILE SINTEGER nMic4Vol
VOLATILE SINTEGER nMic4_Preset = 4

//Microphone 5
VOLATILE INTEGER nMic5Mute
VOLATILE SINTEGER nMic5Vol
VOLATILE SINTEGER nMic5_Preset = 4

//Microphone 6
VOLATILE INTEGER nMic6Mute
VOLATILE SINTEGER nMic6Vol
VOLATILE SINTEGER nMic6_Preset = 4

//Ceiling Mics
VOLATILE INTEGER nCeilingMute

VOLATILE DEV vdvTP_Biamp [] = 
{
    dvTP_Biamp, 
    dvTP_Biamp2
}
VOLATILE INTEGER nChnlbtns[] =
{
    // Lav 1
    1,2,3,4,

    // Lav 2
    5,6,7,8,

    //HH 1
    9,10,11,12, 
    
    //Program...
    37,38,39,40
}

DEFINE_MUTUALLY_EXCLUSIVE


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnMuteChannel (CHAR cTag[], INTEGER cId, INTEGER cToggle)
{
    SEND_STRING dvBiamp, "'SETD 1 FDRMUTE ',cTag,' ',ITOA(cId),' ',ITOA(cToggle),CR"
    //SEND_STRING dvBiamp, "'SETD 1 FDRMUTE Ceiling 1 1',$0A" 
}
DEFINE_FUNCTION fnSetVolumeUp (CHAR cTag[], INTEGER cId, SINTEGER cVol )
{
    IF (cVol < nMaximum)
    {
	SEND_STRING dvBiamp, "'SETD 1 FDRLVL ',cTag,' ',ITOA(cId),' ',ITOA(cVol + VOL_UP),CR"
	     //SEND_STRING dvBiamp,"'SETD 1 FDRLVL Program 1 ',ITOA(nProgramVOL + Volume_Up),$0A"
    }
}
DEFINE_FUNCTION fnSetVolumeDown (CHAR cTag[], INTEGER cId, SINTEGER cVol )
{
    IF (cVol > nMinimum)
    {
	SEND_STRING dvBiamp, "'SETD 1 FDRLVL ',cTag,' ',ITOA(cId),' ',ITOA(cVol + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnSetVolumePreset (CHAR cTag[], INTEGER cId, SINTEGER cPreset )
{
    SEND_STRING dvBiamp, "'SETD 1 FDRLVL ',cTag,' ',ITOA(cId),' ',ITOA(cPreset),CR"
}
DEFINE_FUNCTION fnAudioMode (INTEGER b)
{
    SEND_STRING dvBiamp, "'RECALL 0 PRESET ',ITOA(b),CR"
    
    SWITCH (b)
    {
	CASE BTN_PRESET_SEPERATE :
	{
	    PULSE [vdvPipeTX, PIPE_AUDIO_SEPERATE]
		//SEND_STRING dvBiamp115, "'RECALL 0 PRESET 1001',$0A" //Seperate...
	}
	CASE BTN_PRESET_MASTER :
	{
	    PULSE [vdvPipeTX, PIPE_AUDIO_COMBINE]
		//SEND_STRING dvBiamp115, "'RECALL 0 PRESET 1003',$0A" //Opposite Biamp
	}
    }
}
DEFINE_FUNCTION fnResetAudio()
{
    WAIT 10 fnMuteChannel (TAG_MUTE_MICS, ID_HH_4, YES_OFF)
    WAIT 20 fnSetVolumePreset (TAG_LEV_MICS, ID_HH_4, nMic4_Preset)

    WAIT 10 fnMuteChannel (TAG_MUTE_MICS, ID_HH_5, YES_OFF)
    WAIT 20 fnSetVolumePreset (TAG_LEV_MICS, ID_HH_5, nMic5_Preset)
    
    WAIT 10 fnMuteChannel (TAG_MUTE_MICS, ID_HH_6, YES_OFF)
    WAIT 20 fnSetVolumePreset (TAG_LEV_MICS, ID_HH_6, nMic6_Preset)
    
    WAIT 10 fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_OFF)
    WAIT 20 fnSetVolumePreset (TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Vol_Preset)
    
    WAIT 10 fnMuteChannel (TAG_MUTE_CEILING, ID_CEILING, YES_OFF)
}
DEFINE_FUNCTION fnRoomSourceFeed(CHAR cMatx[3])
{
    SWITCH (cMatx)
    {
	CASE 'Off' : //Kills rooms source audio during presentation mode...
	{
	    SEND_STRING dvBiamp, "'SET 1 MMMUTEXP Matx 3 4 0',$0A"
	}
	CASE 'On' :
	{
	 SEND_STRING dvBiamp, "'SET 1 MMMUTEXP Matx 3 4 1',$0A"
	}
    }
}
DEFINE_FUNCTION fnParseBiamp()
{
    STACK_VAR CHAR cResponse[500]
    STACK_VAR INTEGER cID
    LOCAL_VAR CHAR cMsg[4]

    WHILE (FIND_STRING (nBiampBuffer, "CR,LF",1))
    {
	cResponse = REMOVE_STRING (nBiampBuffer,"CR,LF",1)
	
	SELECT
	{
	    ACTIVE (FIND_STRING (cResponse,"'#SETD 1 FDRLVL ',TAG_LEV_MICS,' '",1)):
	    {
		REMOVE_STRING (cResponse, "'#SETD 1 FDRLVL ',TAG_LEV_MICS,' '",1)
		
		cID = ATOI(LEFT_STRING(cResponse,1))
		cMsg = MID_STRING (cResponse,2,4)
		
		SWITCH (cID)
		{
		    CASE ID_HH_4 :
		    {
			nMic4Vol = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_4),',0,',ITOA(nMic4Vol + MAX_COMP),'%'"
		    }
		    CASE ID_HH_5 :
		    {
			nMic5Vol = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_5),',0,',ITOA(nMic5Vol + MAX_COMP),'%'"
		    }
		    CASE ID_HH_6 :
		    {
			nMic6Vol = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_6),',0,',ITOA(nMic6Vol + MAX_COMP),'%'"
		    }
		}
	    }
	    ACTIVE (FIND_STRING (cResponse,"'#SETD 1 FDRLVL ',TAG_LEV_PRGM,' ',ITOA(ID_PRGM_LEV)",1)):
	    {
		REMOVE_STRING (cResponse, "'#SETD 1 FDRLVL ',TAG_LEV_PRGM,' ',ITOA(ID_PRGM_LEV)",1)
		
		nProgramVOL = ATOI(cResponse)
		    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgramVOL + MAX_COMP),'%'"
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


WAIT 600
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
	    CASE 1 : //Mic 1
	    {
		IF (!nMic4Mute)
		{
		    ON [nMic4Mute]
			ON [vdvTP_Biamp, BTN_MUTE_HH4]
			    fnMuteChannel (TAG_MUTE_MICS, ID_HH_4, YES_ON)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_4),',0,Muted'"
		}
		ELSE
		{
		    OFF [nMic4Mute]
			OFF [vdvTP_Biamp, BTN_MUTE_HH4]
			    fnMuteChannel (TAG_MUTE_MICS, ID_HH_4, YES_OFF)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_4),',0,',ITOA(nMic4Vol + MAX_COMP),'%'"
		}
	    }
	    CASE 2 : fnSetVolumeUp (TAG_LEV_MICS, ID_HH_4, nMic4Vol)
	    CASE 3 : fnSetVolumeDown (TAG_LEV_MICS, ID_HH_4, nMic4Vol)
	    CASE 4 : fnSetVolumePreset (TAG_LEV_MICS, ID_HH_4, nMic4_Preset)
	    
	    CASE 5 : //Mic 2
	    {
		IF (!nMic5Mute)
		{
		    ON [nMic5Mute]
			ON [vdvTP_Biamp, BTN_MUTE_HH5]
			    fnMuteChannel (TAG_MUTE_MICS, ID_HH_5, YES_ON)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_5),',0,Muted'"
		}
		ELSE
		{
		    OFF [nMic5Mute]
			OFF [vdvTP_Biamp, BTN_MUTE_HH5]
			    fnMuteChannel (TAG_MUTE_MICS, ID_HH_5, YES_OFF)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_5),',0,',ITOA(nMic5Vol + MAX_COMP),'%'"
		}
	    }
	    CASE 6 : fnSetVolumeUp (TAG_LEV_MICS, ID_HH_5, nMic5Vol)
	    CASE 7 : fnSetVolumeDown (TAG_LEV_MICS, ID_HH_5, nMic5Vol)
	    CASE 8 : fnSetVolumePreset (TAG_LEV_MICS, ID_HH_5, nMic5_Preset)
	    
	    CASE 9 : //Mic 3
	    {
		IF (!nMic6Mute)
		{
		    ON [nMic6Mute]
			ON [vdvTP_Biamp, BTN_MUTE_HH6]
			    fnMuteChannel (TAG_MUTE_MICS, ID_HH_6, YES_ON)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_6),',0,Muted'"
		}
		ELSE
		{
		    OFF [nMic6Mute]
			OFF [vdvTP_Biamp, BTN_MUTE_HH6]
			    fnMuteChannel (TAG_MUTE_MICS, ID_HH_6, YES_OFF)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_HH_6),',0,',ITOA(nMic6Vol + MAX_COMP),'%'"
		}
	    }
	    CASE 10 : fnSetVolumeUp (TAG_LEV_MICS, ID_HH_6, nMic6Vol)
	    CASE 11 : fnSetVolumeDown (TAG_LEV_MICS, ID_HH_6, nMic6Vol)
	    CASE 12 : fnSetVolumePreset (TAG_LEV_MICS, ID_HH_6, nMic6_Preset)
	    
	    CASE 13 : //Program
	    {
		IF (!nProgramMute)
		{
		    ON [nProgramMute]
			ON [vdvTP_Biamp, BTN_MUTE_PRGM]
			    fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_ON)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
		}
		ELSE
		{
		    OFF [nProgramMute]
			OFF [vdvTP_Biamp, BTN_MUTE_PRGM]
			    fnMuteChannel (TAG_MUTE_MICS, ID_PRGM_LEV, YES_OFF)
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgramVOL + MAX_COMP),'%'"
		}
	    }
	    CASE 14 : fnSetVolumeUp (TAG_LEV_PRGM, ID_PRGM_LEV, nProgramVOL)
	    CASE 15 : fnSetVolumeDown (TAG_LEV_PRGM, ID_PRGM_LEV, nProgramVOL)
	    CASE 16 : fnSetVolumePreset (TAG_LEV_PRGM, ID_PRGM_LEV, nProgram_Vol_Preset)
	}
    }
    HOLD [2, REPEAT] :
    {
   	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nChnlbtns)
	SWITCH (nChnlIdx)
	{
	    CASE 2 : fnSetVolumeUp (TAG_LEV_MICS, ID_HH_4, nMic4Vol)
	    CASE 3 : fnSetVolumeDown (TAG_LEV_MICS, ID_HH_4, nMic4Vol)
	    
	    CASE 6 : fnSetVolumeUp (TAG_LEV_MICS, ID_HH_5, nMic5Vol)
	    CASE 7 : fnSetVolumeDown (TAG_LEV_MICS, ID_HH_5, nMic5Vol)
	    
	    CASE 10 : fnSetVolumeUp (TAG_LEV_MICS, ID_HH_6, nMic6Vol)
	    CASE 11 : fnSetVolumeDown (TAG_LEV_MICS, ID_HH_6, nMic6Vol)
	    
    	    CASE 14 : fnSetVolumeUp (TAG_LEV_PRGM, ID_PRGM_LEV, nProgramVOL)
	    CASE 15 : fnSetVolumeDown (TAG_LEV_PRGM, ID_PRGM_LEV, nProgramVOL)
	}
    }
}
BUTTON_EVENT [dvTP_Biamp, BTN_MUTE_CEILING]
{
    PUSH :
    {
	IF (!nCeilingMute)
	{
	    ON [nCeilingMute]
		ON [vdvTP_Biamp, BTN_MUTE_CEILING]
		    fnMuteChannel (TAG_MUTE_CEILING, ID_CEILING, YES_ON)
	}
	ELSE
	{
	    OFF [nCeilingMute]
		OFF [vdvTP_Biamp, BTN_MUTE_CEILING]
		    fnMuteChannel (TAG_MUTE_CEILING, ID_CEILING, YES_OFF)
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
DATA_EVENT [dvBiamp]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 38400,N,8,1 485 DISABLED'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 100
	{
	    fnResetAudio()
	}
    }
    STRING :
    {
	fnParseBiamp()
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvPipeRX, PIPE_AUDIO_COMBINE]
CHANNEL_EVENT [vdvPipeRX, PIPE_AUDIO_SEPERATE]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE PIPE_AUDIO_COMBINE :
	    {
		fnAudioMode (BTN_PRESET_SERVE)
	    }
	    CASE PIPE_AUDIO_SEPERATE :
	    {
		fnAudioMode (BTN_PRESET_SEPERATE)
	    }
	}
    }
}
