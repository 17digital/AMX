PROGRAM_NAME='NexiaCube'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/02/2018  AT: 08:29:14        *)
(***********************************************************)


(*
    No Phone Controls are included within this file...
    
    Thank Me later...
    http://support.biamp.com/Audia-Nexia/Control/Audia-Nexia_command_string_calculator
    
    This Particular Device is a NexiaTC - Commands are explicit for some blocks...
    
    *)

DEFINE_DEVICE

#IF_NOT_DEFINED Remote
Remote = 					6023
#END_IF

#IF_NOT_DEFINED dvTP_Nexia
dvTP_Nexia =				10001:5:0
#END_IF

#IF_NOT_DEFINED dvTP_Nexia2
dvTP_Nexia2 =				10002:5:0
#END_IF

#IF_NOT_DEFINED dvNexia
dvNexia =					5001:6:Remote
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

MAC_MINI				= 1
PC_DESK				= 1
SUB_OUT				= 1
CAP_OUT				= 1

CR 					= 13
LF 					= 10

MAX_GAIN 				= 88 

BI_FEEDBACK			= 20

SET_MUTE_ON			= 1
SET_MUTE_OFF			= 0

LEVEL_CAPTURE			= 1
LEVEL_WINDOWS			= 2
LEVEL_MAC				= 3
LEVEL_SUB				= 4
MAX_GAIN_				= -88 //Biamp Range -88 / +12

TAG_WINDOWS			= 'program'
TAG_MAC				= 'program2'
TAG_SUB				= 'subout'
TAG_CAP				= 'captureout'

TXT_SUBNET			= 31
TXT_IPADD				= 30
TXT_GATEWAY			= 32
TXT_DEVICE			= 100

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR nBiampDevice[30] = 'Nexia TC'
VOLATILE INTEGER nBiampOnline
VOLATILE INTEGER cHeartBeat_

DEV vdvTP_Nexia [] = {dvTP_Nexia, dvTP_Nexia2}

VOLATILE CHAR nAudioBuffer[1000]
VOLATILE LONG lBiampFeedback[] = {50}

VOLATILE SINTEGER nCaptureOut
VOLATILE SINTEGER nProgram_Preset = 25

//Mac Mini
VOLATILE INTEGER nMacMute 
NON_VOLATILE SINTEGER nMacVOL

//Desktop
VOLATILE INTEGER nDesktopMute 
NON_VOLATILE SINTEGER nDesktopVOL

//Output to Sub...
VOLATILE INTEGER nSubwooferMute 
NON_VOLATILE SINTEGER nSubwooferVOL
VOLATILE SINTEGER nSubwoofer_Preset = 30

VOLATILE CHAR stmpIP[15]
VOLATILE CHAR stmpGATE[15]
VOLATILE CHAR stmpSubnet[15]

VOLATILE INTEGER nNexiaChnlIdx[] =
{
    //Mac Mini...
    1, //Mute
    2, //Up
    3, //Down
    4, //Preset
    
    //Desktop
    5,
    6,
    7,
    8,
    
    //SubWoofer Out
    13,
    14,
    15,
    16
} 

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnLevelRestore()
{
//    nSubwooferVOL_Hold = nSubwooferVOL
//    nDesktopVOL_Hold = nDesktopVOL
//    nMacVOL_Hold = nMacVOL
//    fnVolumeChange(TAG_SUB, SUB_OUT, nSubwooferVOL_Hold)   
//    fnVolumeChange(TAG_WINDOWS, PC_DESK, nDesktopVOL_Hold)    
//    fnVolumeChange(TAG_MAC, MAC_MINI, nMacVOL_Hold)
}
DEFINE_FUNCTION fnVolumeChange(CHAR cTag[], INTEGER cIn, SINTEGER cLevel)
{
    SEND_STRING dvNexia,"'SETD 1 FDRLVL ',cTag,' ',ITOA(cIn),' ',ITOA(cLevel + MAX_GAIN_),CR"
}
DEFINE_FUNCTION fnVolumeMute(CHAR cTag[], INTEGER cIn, INTEGER cState)
{
    SEND_STRING dvNexia, "'SETD 1 FDRMUTE ',cTag,' ',ITOA(cIn),' ',ITOA(cState),CR"
}
DEFINE_FUNCTION fnGetMuteStates(CHAR cTag[], INTEGER cIn)
{
    SEND_STRING dvNexia, "'GETD 1 FDRMUTE ',cTag,' ',ITOA(cIn),CR"
}
DEFINE_FUNCTION fnVolumePreset(INTEGER cIn, SINTEGER cLevel)
{
    SEND_LEVEL vdvTP_Nexia,cIn,cLevel
}
DEFINE_FUNCTION fnSetValues()
{
    WAIT 10 fnVolumePreset(LEVEL_MAC,nProgram_Preset)
    WAIT 20 fnVolumePreset(LEVEL_WINDOWS,nProgram_Preset)  
    WAIT 30 fnVolumePreset(LEVEL_SUB, nSubwoofer_Preset)
    
    WAIT 40 fnGetMuteStates(TAG_MAC, MAC_MINI)
    WAIT 50 fnGetMuteStates(TAG_WINDOWS, PC_DESK)
    WAIT 60 fnGetMuteStates(TAG_SUB, SUB_OUT)

    WAIT 70 SEND_STRING dvNexia, "'GETD 0 IPADDR',CR"
    WAIT 90 SEND_STRING dvNexia, "'GETD 0 SUBNETMASK',CR"
    WAIT 110 SEND_STRING dvNexia, "'GETD 0 DEFAULTGW',CR"
    WAIT 120 SEND_COMMAND vdvTP_Nexia, "'^TXT-50,0,Values Received!'"
}
DEFINE_FUNCTION fnGetValues()
{
    //Get Mutes...
    WAIT 10 fnVolumePreset(LEVEL_MAC,nProgram_Preset)
    WAIT 20 fnVolumePreset(LEVEL_WINDOWS,nProgram_Preset)  
    WAIT 30 fnVolumePreset(LEVEL_SUB, nSubwoofer_Preset)
    
    WAIT 40 fnGetMuteStates(TAG_MAC, MAC_MINI)
    WAIT 50 fnGetMuteStates(TAG_WINDOWS, PC_DESK)
    WAIT 60 fnGetMuteStates(TAG_SUB, SUB_OUT)
    
    WAIT 70 SEND_STRING dvNexia, "'GETD 0 IPADDR',CR"
    WAIT 90 SEND_STRING dvNexia, "'GETD 0 SUBNETMASK',CR"
    WAIT 120 SEND_STRING dvNexia, "'GETD 0 DEFAULTGW',CR"
    WAIT 120 SEND_COMMAND vdvTP_Nexia, "'^TXT-50,0,Values Received!'"
}
DEFINE_FUNCTION fnParseNexia()
{
    LOCAL_VAR CHAR cResponse[100]
    
    cResponse = REMOVE_STRING(nAudioBuffer,"CR,LF",1)
    
    SELECT
    {
	//MacMini
	ACTIVE(FIND_STRING(cResponse,'#SETD 1 FDRMUTE program2 1 1 +OK',1)): 
	{
	    ON [nMacMute]
	    //SEND_COMMAND vdvTP_Nexia, "'^TXT-9,0,Muted'"
	}
	ACTIVE(FIND_STRING(cResponse,'#SETD 1 FDRMUTE program2 1 0 +OK',1)):
	{
	    OFF [nMacMute]
	    //SEND_COMMAND vdvTP_Nexia, "'^TXT-9,0,',ITOA(nMacVOL + MAX_GAIN),'%'"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 1 FDRMUTE program2 1 1',1)): 
	{
	    ON [nMacMute]
	    //SEND_COMMAND vdvTP_Nexia, "'^TXT-9,0,Muted'"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 1 FDRMUTE program2 1 0',1)):
	{
	    OFF [nMacMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-9,0,',ITOA(nMacVOL + MAX_GAIN),'%'"
	}
	//Desktop...
	ACTIVE(FIND_STRING(cResponse,'#SETD 1 FDRMUTE program 1 1 +OK',1)): 
	{
		ON [nDesktopMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-10,0,Muted'"
	}
	ACTIVE(FIND_STRING(cResponse,'#SETD 1 FDRMUTE program 1 0 +OK',1)):
	{
		OFF [nDesktopMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-10,0,',ITOA(nDesktopVOL + MAX_GAIN),'%'"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 1 FDRMUTE program 1 1',1)): //Get Mute..
	{
		ON [nDesktopMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-10,0,Muted'"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 1 FDRMUTE program 1 0',1)):
	{
		OFF [nDesktopMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-10,0,',ITOA(nDesktopVOL + MAX_GAIN),'%'"
	}

	//Subwoofer...
	ACTIVE(FIND_STRING(cResponse,'#SETD 1 FDRMUTE subout 1 1 +OK',1)):
	{
		  ON [  nSubwooferMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-11,0,Muted'"
	}
	ACTIVE(FIND_STRING(cResponse,'#SETD 1 FDRMUTE subout 1 0 +OK',1)):
	{
		    OFF [nSubwooferMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-11,0,',ITOA(nSubwooferVOL + MAX_GAIN),'%'"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 1 FDRMUTE subout 1 1',1)):
	{
		    ON [nSubwooferMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-11,0,Muted'"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 1 FDRMUTE subout 1 0',1)):
	{
		    OFF [nSubwooferMute]
		    //SEND_COMMAND vdvTP_Nexia, "'^TXT-11,0,',ITOA(nSubwooferVOL + MAX_GAIN),'%'"
	}
	//system Info....
	ACTIVE(FIND_STRING(cResponse,'#GETD 0 SUBNETMASK',1)):
	{    
	    REMOVE_STRING(cResponse,'#GETD 0 SUBNETMASK',1)
		    stmpSubnet = cResponse
		    
		    SEND_COMMAND vdvTP_Nexia, "'^TXT-',ITOA(TXT_SUBNET),',0,SubNet ',stmpSubnet"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 0 IPADDR',1)):
	{    
	    REMOVE_STRING(cResponse,'#GETD 0 IPADDR',1)
		    
		    stmpIP = cResponse
		    SEND_COMMAND vdvTP_Nexia, "'^TXT-',ITOA(TXT_IPADD),',0,IP Address ',stmpIP"
	}
	ACTIVE(FIND_STRING(cResponse,'#GETD 0 DEFAULTGW',1)):
	{    
	    REMOVE_STRING(cResponse,'#GETD 0 DEFAULTGW',1)
		    
		    stmpGATE = cResponse
		    SEND_COMMAND vdvTP_Nexia, "'^TXT-',ITOA(TXT_GATEWAY),',0,Gateway ',stmpGATE"
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


CREATE_BUFFER dvNexia,nAudioBuffer

TIMELINE_CREATE(BI_FEEDBACK,lBiampFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
ON [nBiampOnline]

WAIT 500
{
    OFF [nBiampOnline]
}


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
LEVEL_EVENT [vdvTP_Nexia, LEVEL_CAPTURE]
{
    IF (cHeartBeat_)
    {
	nCaptureOut = LEVEL.VALUE
	fnVolumeChange(TAG_CAP, CAP_OUT, nCaptureOut)
    }
}
LEVEL_EVENT [vdvTP_Nexia,LEVEL_MAC]
{
    IF (cHeartBeat_)
    {
	nMacVOL = LEVEL.VALUE
    	fnVolumeChange(TAG_MAC, MAC_MINI, nMacVOL)
    }
}
LEVEL_EVENT [vdvTP_Nexia, LEVEL_WINDOWS]
{
    IF (cHeartBeat_)
    {
	nDesktopVOL = LEVEL.VALUE
	fnVolumeChange(TAG_WINDOWS, PC_DESK, nDesktopVOL)
    }
}
LEVEL_EVENT [vdvTP_Nexia, LEVEL_SUB]
{
    IF (cHeartBeat_)
    {
	nSubwooferVOL = LEVEL.VALUE
	fnVolumeChange(TAG_SUB, SUB_OUT, nSubwooferVOL)
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Nexia]
DATA_EVENT [dvTP_Nexia2]
{
    ONLINE :
    {
	ON [cHeartBeat_]
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_DEVICE),',0,',nBiampDevice"
	
	IF (!nBiampOnline)
	{
	    SEND_COMMAND vdvTP_Nexia, "'^TXT-50,0,Receiving Values...'"
	    fnGetValues()
	}
    }
    OFFLINE :
    {
	OFF [cHeartBeat_]
    }
}
DATA_EVENT [dvNexia]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 38400,N,8,1 485 DISABLED'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	SEND_COMMAND vdvTP_Nexia, "'^TXT-50,0,Please Wait...'"
	
	WAIT 80 
	{
	    SEND_COMMAND vdvTP_Nexia, "'^TXT-50,0,Receiving Values...'"
		fnSetValues()
	}
    }
    STRING :
    {
	fnParseNexia()
    }
}
BUTTON_EVENT [vdvTP_Nexia, nNexiaChnlIdx]
{
    PUSH :
    {
	STACK_VAR INTEGER nLevelIdx
	
	nLevelIdx = GET_LAST (nNexiaChnlIdx)
	SWITCH (nLevelIdx)
	{
	    CASE 1:
	    {
		IF (!nMacMute)
		{
		    fnVolumeMute(TAG_MAC,MAC_MINI, SET_MUTE_ON)
		}
		ELSE
		{
		    fnVolumeMute(TAG_MAC,MAC_MINI, SET_MUTE_OFF)
		}
	    }

	    CASE 4: fnVolumePreset(LEVEL_MAC,nProgram_Preset)
	    
	    //Desktop...
	    CASE 5: 
	    {
		IF (!nDesktopMute)
		{
		    fnVolumeMute(TAG_WINDOWS, PC_DESK, SET_MUTE_ON)
		}
		ELSE
		{
		    fnVolumeMute(TAG_WINDOWS, PC_DESK, SET_MUTE_OFF)
		}
	    }

	    CASE 8: fnVolumePreset(LEVEL_WINDOWS,nProgram_Preset) 
	    
	    //
	    CASE 9: 
	    {
		IF (!nSubwooferMute)
		{
		    fnVolumeMute(TAG_SUB, SUB_OUT, SET_MUTE_ON)
		}
		ELSE
		{
		    fnVolumeMute(TAG_SUB, SUB_OUT, SET_MUTE_OFF)
		}
	    }
	    CASE 12: fnVolumePreset(LEVEL_SUB, nSubwoofer_Preset)
	}
    }  
}

TIMELINE_EVENT [BI_FEEDBACK]
{
    [vdvTP_Nexia, 1] = nMacMute
    [vdvTP_Nexia, 5] = nDesktopMute
    [vdvTP_Nexia, 13] = nSubwooferMute
       
}

