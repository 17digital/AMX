PROGRAM_NAME='ShureDSP'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/17/2019  AT: 06:43:53        *)
(***********************************************************)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED	dvQsysAudio
        dvQsysAudio =			0:2:0 //Auditorium First Floor
#END_IF

#IF_NOT_DEFINED 	dvTP_Audio
    dvTP_Audio =			10001:5:0
#END_IF

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

MAX_LEVEL				= 10
MIN_LEVEL					= -100
COMPENSATE_LEV			= 90 //Equal to 100 on touch panel...
//MinLevel for QSys...

//auditorium tag IDs...
TAG_LEV_PRGM			= 'program_fader'
TAG_MUTE_PRGM			= 'program_mute'
TAG_MUTE_PODIUM		= 'gooseneck_mute'
TAG_LEV_PODIUM			= 'gooseneck_fader'
TAG_LEV_WL1				= 'wl1_fader'
TAG_LEV_WL2				= 'wl2_fader'
TAG_LEV_WL3				= 'wl3_fader'
TAG_LEV_WL4				= 'wl4_fader'
TAG_LEV_WL5				= 'wl5_fader'
TAG_LEV_WL6				= 'wl6_fader'
TAG_LEV_WL7				= 'wl7_fader'
TAG_LEV_WL8				= 'wl8_fader'
TAG_MUTE_WL1			= 'wl1_mute'
TAG_MUTE_WL2			= 'wl2_mute'
TAG_MUTE_WL3			= 'wl3_mute'
TAG_MUTE_WL4			= 'wl4_mute'
TAG_MUTE_WL5			= 'wl5_mute'
TAG_MUTE_WL6			= 'wl6_mute'
TAG_MUTE_WL7			= 'wl7_mute'
TAG_MUTE_WL8			= 'wl8_mute'

TAG_MUTE_CEILING		= 'cmicmute'


TXT_PODIUM				= 1
TXT_WL_1					= 2
TXT_WL_2					= 3
TXT_WL_3					= 4
TXT_WL_4					= 5
TXT_WL_5					= 10
TXT_WL_6					= 11
TXT_WL_7					= 12
TXT_WL_8					= 13

TXT_PRGM					= 9

MUTE_ON					= 1
MUTE_OFF 				= 0

BTN_MUTE_LECTERN			= 1
BTN_MUTE_WM1				= 5
BTN_MUTE_WM2				= 9
BTN_MUTE_WM3				= 13
BTN_MUTE_WM4				= 17
BTN_MUTE_PRGM				= 21
BTN_MUTE_WM5				= 25
BTN_MUTE_WM6				= 29
BTN_MUTE_WM7				= 33
BTN_MUTE_WM8				= 37
BTN_MUTE_CEILING			= 60

BTN_RESET_DATA				= 1000

#IF_NOT_DEFINED LF 
LF 							= 10
#END_IF


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

CHAR shureDevice[30] = 'Kendeda152dsp' 

CHAR shureIP[30]= '172.21.5.124' 
LONG SCM820_Port= 1702
VOLATILE INTEGER scm820Online
VOLATILE INTEGER cBooted

VOLATILE CHAR cShureBuffer[500]


//Podium
SINTEGER nPodium_Preset = -3
VOLATILE INTEGER nPodium_Mute 
VOLATILE SINTEGER nPodium_VOL

//Wm 1
VOLATILE SINTEGER nMic1_Preset = -7
VOLATILE INTEGER nMic1_Mute 
VOLATILE SINTEGER nMic1_VOL

//Wm 2
VOLATILE SINTEGER nMic2_Preset = -6
VOLATILE INTEGER nMic2_Mute 
VOLATILE SINTEGER nMic2_VOL

//Wm 3
VOLATILE SINTEGER nMic3_Preset = -6
VOLATILE INTEGER nMic3_Mute 
VOLATILE SINTEGER nMic3_VOL

//Wm 4
VOLATILE SINTEGER nMic4_Preset = -6
VOLATILE INTEGER nMic4_Mute 
VOLATILE SINTEGER nMic4_VOL

VOLATILE SINTEGER nMic5_Preset = -5
VOLATILE INTEGER nMic5_Mute 
VOLATILE SINTEGER nMic5_VOL

VOLATILE SINTEGER nMic6_Preset = -5
VOLATILE INTEGER nMic6_Mute 
VOLATILE SINTEGER nMic6_VOL

VOLATILE SINTEGER nMic7_Preset = -5
VOLATILE INTEGER nMic7_Mute 
VOLATILE SINTEGER nMic7_VOL

VOLATILE SINTEGER nMic8_Preset = -5
VOLATILE INTEGER nMic8_Mute 
VOLATILE SINTEGER nMic8_VOL


//Prgm...
VOLATILE SINTEGER nPrgm_Preset = -15
VOLATILE INTEGER nPrgm_Mute 
VOLATILE SINTEGER nPrgm_VOL

//Ceiling...
VOLATILE INTEGER nCeiling_Mute


DEV vdvTP_Audio[] = {dvTP_Audio}

VOLATILE INTEGER nShureChannelIdx[] = //Microphone Channels
{
    //Auditorium Mute || UP || DN || Preset
    
    //Podium
    1, 2, 3, 4, 
    
    //WL 1
    5, 6, 7, 8, 
    
    //WL 2
    9, 10, 11, 12, 
    
    //WL 3
    13, 14, 15, 16, 
    
    //WL 4
    17, 18, 19, 20, 
    
    //Prgm...
    21,22,23,24,
    
    //Ceiling
    60 
}
VOLATILE INTEGER nShureMoreMicsIdx[] =
{
    25,26,27,28,
    
    29,30,31,32,
    
    33,34,35,36,
    
    37,38,39,40
}


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSetConnection(CHAR cConnect[5])
{
    SWITCH (cConnect)
    {
	CASE 'OPEN' :
	{
	    IP_CLIENT_OPEN(dvQsysAudio.PORT,shureIP,SCM820_Port,1) //#1 is for TCP/IP connection
	}
	CASE 'CLOSE' :
	{
	    IP_CLIENT_CLOSE(dvQsysAudio.PORT) //Closes Connection When Done
	}
    }
}
DEFINE_FUNCTION fnMuteVolume(CHAR cTag[], INTEGER cState)
{
    SEND_STRING dvQsysAudio, "'csp ',cTag,' ',ITOA(cState),LF"
}
DEFINE_FUNCTION fnVolumePreset(CHAR cTag[], SINTEGER cPreset)
{
    SEND_STRING dvQsysAudio, "'csv ',cTag,' ',ITOA(cPreset),LF" 
}
DEFINE_FUNCTION fnAdjustVolumeUP(CHAR cTag[])
{
	SEND_STRING dvQsysAudio, "'css ' ,cTag,' ++1',LF" 
}
DEFINE_FUNCTION fnAdjustVolumeDN(CHAR cTag[])
{
	SEND_STRING dvQsysAudio, "'css ' ,cTag,'  --1',LF" 
}
DEFINE_FUNCTION fnReconnect()
{
    fnSetConnection('CLOSE')
	
	WAIT 10 fnSetConnection('OPEN')
}
DEFINE_FUNCTION fnSetValues()
{
   WAIT 10 fnMuteVolume(TAG_MUTE_PODIUM, MUTE_OFF)
    WAIT 20 fnVolumePreset(TAG_LEV_PODIUM, nPodium_Preset)
    
    WAIT 30 fnVolumePreset(TAG_LEV_WL1, nMic1_Preset)
    WAIT 40 fnMuteVolume(TAG_MUTE_WL1, MUTE_OFF)
    WAIT 50 fnVolumePreset(TAG_LEV_WL2, nMic2_Preset)
    WAIT 60 fnMuteVolume(TAG_MUTE_WL2, MUTE_OFF)
    WAIT 70 fnVolumePreset(TAG_LEV_WL3, nMic3_Preset)
    WAIT 80 fnMuteVolume(TAG_MUTE_WL3, MUTE_OFF)
    WAIT 90 fnVolumePreset(TAG_LEV_WL4, nMic4_Preset)
    WAIT 100 fnMuteVolume(TAG_MUTE_WL4, MUTE_OFF)
    WAIT 110 fnVolumePreset(TAG_LEV_PRGM, nPrgm_Preset)
    WAIT 120 fnMuteVolume(TAG_MUTE_PRGM, MUTE_OFF)
    
    WAIT 140 fnMuteVolume(TAG_MUTE_CEILING, MUTE_OFF)
    
    WAIT 150 fnVolumePreset(TAG_LEV_WL5, nMic5_Preset)
    WAIT 160 fnMuteVolume(TAG_MUTE_WL5, MUTE_OFF)

    WAIT 170 fnVolumePreset(TAG_LEV_WL6, nMic6_Preset)
    WAIT 180 fnMuteVolume(TAG_MUTE_WL6, MUTE_OFF)

    WAIT 190 fnVolumePreset(TAG_LEV_WL7, nMic7_Preset)
    WAIT 200 fnMuteVolume(TAG_MUTE_WL7, MUTE_OFF)

    WAIT 210 fnVolumePreset(TAG_LEV_WL8, nMic8_Preset)
    WAIT 220 fnMuteVolume(TAG_MUTE_WL8, MUTE_OFF)
}
DEFINE_FUNCTION fnParseQsys()
{
    STACK_VAR CHAR cResponse[100]
    STACK_VAR CHAR cTag[30]
    LOCAL_VAR CHAR cMsg[4]
    
    WHILE (FIND_STRING(cShureBuffer,"$0D,$0A",1))
    {
	cResponse = REMOVE_STRING (cShureBuffer,"$0D,$0A",1)
	
	SELECT
	{
	    //parse Volume Changes
	    ACTIVE (FIND_STRING(cResponse,"'cv "'",1)): //Grab level changes....
	    {
		REMOVE_STRING(cResponse,"'cv "'",1)
		cTag = REMOVE_STRING(cResponse,'" "',1)
		cMsg = cResponse //Grab Remaining...
		cTag = LEFT_STRING(cTag,LENGTH_STRING(cTag)-3) //Should provide T
		
		SWITCH (cTag)
		{
		    CASE TAG_LEV_PODIUM :
		    {
			nPodium_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_PODIUM),',0,',ITOA(nPodium_VOL + COMPENSATE_LEV),'%'"
			   
		    }
		    CASE TAG_LEV_WL1 :
		    {
			nMic1_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_1),',0,',ITOA(nMic1_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_WL2 :
		    {
			nMic2_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_2),',0,',ITOA(nMic2_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_WL3 :
		    {
		    			nMic3_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_3),',0,',ITOA(nMic3_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_WL4 :
		    {
		    			nMic4_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_4),',0,',ITOA(nMic4_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_WL5 :
		    {
		    			nMic5_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_5),',0,',ITOA(nMic5_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_WL6 :
		    {
			    nMic6_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_6),',0,',ITOA(nMic6_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_WL7 :
		    {
						    nMic7_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_7),',0,',ITOA(nMic7_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_WL8 :
		    {
						    nMic8_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_8),',0,',ITOA(nMic8_VOL + COMPENSATE_LEV),'%'"
		    }
		    CASE TAG_LEV_PRGM :
		    {
			nPrgm_VOL = ATOI(cMsg)
			    SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nPrgm_VOL + COMPENSATE_LEV),'%'"
		    }
		}
	    }
	}
    }
}
DEFINE_FUNCTION char[100] GetIpError (LONG iErrorCode)
{
    CHAR iReturn[100];

    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '";
	CASE 4 : iReturn = "'Unknown host'";
	CASE 6 : iReturn = "'Connection Refused'";
	CASE 7 : iReturn = "'Connection timed Out'";
	CASE 8 : iReturn = "'Unknown Connection Error'";
	CASE 9 : iReturn = "'Already Closed'";
	CASE 10 : iReturn = "'Binding Error'";
	CASE 11 : iReturn = "'Listening Error'";
	CASE 14 : iReturn = "'Local Port Already Used'";
	CASE 15 : iReturn = "'UDP Socket Already Listening'";
	CASE 16 : iReturn = "'Too Many Open Sockets'";
	CASE 17 : iReturn = "'Local Port Not Open'";
	
	DEFAULT : iReturn = "'(',ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [cBooted]
CREATE_BUFFER dvQsysAudio,cShureBuffer;

WAIT 50
{
    fnReconnect()
}
WAIT 80
{
    fnSetValues()
}
WAIT 200 
{
    OFF [cBooted]
}


(***********************************************************)
(*                  THE EVENTS GO BELOW                    *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [dvTP_Audio]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-100,0,',shureDevice"
	
	IF (!cBooted)
	{
		fnSetValues()
	}
    }
}
DATA_EVENT [dvQsysAudio]
{
    ONLINE: //SET UP SHURE
    {
	SEND_STRING 0, 'Audio Is Online'
	ON [scm820Online]
	
	CANCEL_WAIT 'DEVICE COMM/INIT'
	WAIT 300 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
	    
	}
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, " 'dvQsysAudio:ONERROR: ',GetIpError(DATA.NUMBER)");
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 : //Connection TimeOut
	    {
		fnReconnect()
	    }
	    DEFAULT :
	    {
		fnReconnect()
	    }
	}
    }
    STRING :
    {
	ON [scm820Online]
	
	CANCEL_WAIT 'DEVICE COMM/INIT'
	
	WAIT 300 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
	    fnReconnect()
	}
	Send_String 0,"'RECEIVING AUDIO ',cShureBuffer"
	
	fnParseQsys()
    }
}

DEFINE_EVENT
BUTTON_EVENT [dvTP_Audio, nShureMoreMicsIdx]
{
    PUSH :
    {
	STACK_VAR INTEGER nMicIdx
	
	nMicIdx = GET_LAST (nShureMoreMicsIdx)
	SWITCH (nMicIdx)
	{
	    CASE 1 :
	    {
		IF (!nMic5_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL1, MUTE_ON)
		    ON [nMic5_Mute]
			ON [vdvTP_Audio, BTN_MUTE_WM5]
			SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_5),',0,Muted'" 
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL5, MUTE_OFF)
		    	OFF [nMic5_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM5]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_5),',0,',ITOA(nMic5_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 2: fnAdjustVolumeUP(TAG_LEV_WL5)
	    CASE 3: fnAdjustVolumeDN(TAG_LEV_WL5)
	    CASE 4: fnVolumePreset(TAG_LEV_WL5, nMic5_Preset)
	    
	    //Mic 6
	    CASE 5 :
	    {
		IF (!nMic6_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL6, MUTE_ON)
		    ON [nMic6_Mute]
			ON [vdvTP_Audio, BTN_MUTE_WM6]
			SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_6),',0,Muted'" 
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL6, MUTE_OFF)
		    	OFF [nMic6_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM6]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_6),',0,',ITOA(nMic6_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 6: fnAdjustVolumeUP(TAG_LEV_WL6)
	    CASE 7: fnAdjustVolumeDN(TAG_LEV_WL6)
	    CASE 8: fnVolumePreset(TAG_LEV_WL6, nMic6_Preset)
	    
	    //Mic 7
    	    CASE 9 :
	    {
		IF (!nMic7_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL7, MUTE_ON)
		    ON [nMic7_Mute]
			ON [vdvTP_Audio, BTN_MUTE_WM7]
			SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_7),',0,Muted'" 
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL7, MUTE_OFF)
		    	OFF [nMic7_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM7]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_7),',0,',ITOA(nMic7_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 10: fnAdjustVolumeUP(TAG_LEV_WL7)
	    CASE 11: fnAdjustVolumeDN(TAG_LEV_WL7)
	    CASE 12: fnVolumePreset(TAG_LEV_WL7, nMic7_Preset)
	    
	    //Mic 8
    	    CASE 13 :
	    {
		IF (!nMic8_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL8, MUTE_ON)
		    ON [nMic8_Mute]
			ON [vdvTP_Audio, BTN_MUTE_WM8]
			SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_8),',0,Muted'" 
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL8, MUTE_OFF)
		    	OFF [nMic8_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM8]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_8),',0,',ITOA(nMic8_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 14: fnAdjustVolumeUP(TAG_LEV_WL8)
	    CASE 15: fnAdjustVolumeDN(TAG_LEV_WL8)
	    CASE 16: fnVolumePreset(TAG_LEV_WL8, nMic8_Preset)
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nMicIdx
	
	nMicIdx = GET_LAST (nShureMoreMicsIdx)
	SWITCH (nMicIdx)
	{
	    CASE 2: fnAdjustVolumeUP(TAG_LEV_WL5)
	    CASE 3: fnAdjustVolumeDN(TAG_LEV_WL5)
	    
	    CASE 6: fnAdjustVolumeUP(TAG_LEV_WL6)
	    CASE 7: fnAdjustVolumeDN(TAG_LEV_WL6)
	    
	    CASE 10: fnAdjustVolumeUP(TAG_LEV_WL7)
	    CASE 11: fnAdjustVolumeDN(TAG_LEV_WL7)
	    
	    CASE 14: fnAdjustVolumeUP(TAG_LEV_WL8)
	    CASE 15: fnAdjustVolumeDN(TAG_LEV_WL8)
	}
    }
}
BUTTON_EVENT [dvTP_Audio, nShureChannelIdx]
{
    PUSH:
    { 
	STACK_VAR INTEGER nChannelIdx
		
	nChannelIdx = GET_LAST (nShureChannelIdx)
	SWITCH (nChannelIdx)
	{
	    //Podium 
	    CASE 1: 
	    {
		IF (!nPodium_Mute)
		{
		    fnMuteVolume(TAG_MUTE_PODIUM, MUTE_ON)
		    	ON [nPodium_Mute]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_PODIUM),',0,Muted'"
		    ON [vdvTP_Audio, BTN_MUTE_LECTERN]
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_PODIUM, MUTE_OFF)
		    OFF [nPodium_Mute]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_PODIUM),',0,',ITOA(nPodium_VOL + COMPENSATE_LEV),'%'"
		    OFF [vdvTP_Audio, BTN_MUTE_LECTERN]
		}
	    }
	    CASE 2: fnAdjustVolumeUP(TAG_LEV_PODIUM)
	    CASE 3: fnAdjustVolumeDN(TAG_LEV_PODIUM)
	    CASE 4: fnVolumePreset(TAG_LEV_PODIUM, nPodium_Preset)
	    
	    //WL 1
	    CASE 5:
	    {
		IF (!nMic1_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL1, MUTE_ON)
		    		ON [nMic1_Mute]
				ON [vdvTP_Audio, BTN_MUTE_WM1]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_1),',0,Muted'" 
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL1, MUTE_OFF)
		    	OFF [nMic1_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM1]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_1),',0,',ITOA(nMic1_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 6: fnAdjustVolumeUP(TAG_LEV_WL1)
	    CASE 7: fnAdjustVolumeDN(TAG_LEV_WL1)
	    CASE 8: fnVolumePreset(TAG_LEV_WL1, nMic1_Preset)
	    
	    //WL 2
	    CASE 9:
	    {
		IF (!nMic2_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL2, MUTE_ON)
		    		ON [nMic2_Mute]
				ON [vdvTP_Audio, BTN_MUTE_WM2]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_2),',0,Muted'"
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL2, MUTE_OFF)
		    	OFF [nMic2_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM2]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_2),',0,',ITOA(nMic2_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 10: fnAdjustVolumeUP(TAG_LEV_WL2)
	    CASE 11: fnAdjustVolumeDN(TAG_LEV_WL2)
	    CASE 12: fnVolumePreset(TAG_LEV_WL2, nMic2_Preset)
	    
	    //WL 3
	    CASE 13:
	    {
		IF (!nMic3_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL3, MUTE_ON)
		    	ON [nMic3_Mute]
			    ON [vdvTP_Audio, BTN_MUTE_WM3]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_3),',0,Muted'"
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL3, MUTE_OFF)
		    	OFF [nMic3_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM3]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_3),',0,',ITOA(nMic3_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 14: fnAdjustVolumeUP(TAG_LEV_WL3)
	    CASE 15: fnAdjustVolumeDN(TAG_LEV_WL3)
	    CASE 16: fnVolumePreset(TAG_LEV_WL3, nMic3_Preset)
	    
	    //WL 4
    	    CASE 17:
	    {
		IF (!nMic4_Mute)
		{
		    fnMuteVolume(TAG_MUTE_WL4, MUTE_ON)
		    ON [nMic4_Mute]
			ON [vdvTP_Audio, BTN_MUTE_WM4]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_4),',0,Muted'"
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_WL4, MUTE_OFF)
		    	OFF [nMic4_Mute]
			    OFF [vdvTP_Audio, BTN_MUTE_WM4]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_WL_4),',0,',ITOA(nMic4_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 18: fnAdjustVolumeUP(TAG_LEV_WL4)
	    CASE 19: fnAdjustVolumeDN(TAG_LEV_WL4)
    	    CASE 20: fnVolumePreset(TAG_LEV_WL4, nMic4_Preset)
	    
	    //Prgm..
	    CASE 21:
	    {
		IF (!nPrgm_Mute)
		{
		    fnMuteVolume(TAG_MUTE_PRGM, MUTE_ON)
		    	ON [nPrgm_Mute]
			    ON [vdvTP_Audio, BTN_MUTE_PRGM]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'" 
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_PRGM, MUTE_OFF)
		    	OFF [nPrgm_Mute]
			OFF [vdvTP_Audio, BTN_MUTE_PRGM]
		SEND_COMMAND vdvTP_Audio, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nPrgm_VOL + COMPENSATE_LEV),'%'"
		}
	    }
	    CASE 22: fnAdjustVolumeUP(TAG_LEV_PRGM)
	    CASE 23: fnAdjustVolumeDN(TAG_LEV_PRGM)
    	    CASE 24: fnVolumePreset(TAG_LEV_PRGM, nPrgm_Preset)
	    
	    //Ceiling Mute / Privacy
	    CASE 25:
	    {
		IF (!nCeiling_Mute)
		{	
		    fnMuteVolume(TAG_MUTE_CEILING, MUTE_ON)
		    	ON [nCeiling_Mute]
			ON [vdvTP_Audio, BTN_MUTE_CEILING]
		}
		ELSE
		{
		    fnMuteVolume(TAG_MUTE_CEILING, MUTE_OFF)
		    		OFF [nCeiling_Mute]
				    OFF [vdvTP_Audio, BTN_MUTE_CEILING]
		}
	    }
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nChannelIdx
	
	nChannelIdx = GET_LAST (nShureChannelIdx)
	SWITCH (nChannelIdx)
	{
	    CASE 2: fnAdjustVolumeUP(TAG_LEV_PODIUM)
	    CASE 3: fnAdjustVolumeDN(TAG_LEV_PODIUM)
	    
    	    CASE 6: fnAdjustVolumeUP(TAG_LEV_WL1)
	    CASE 7: fnAdjustVolumeDN(TAG_LEV_WL1)
	    
	    CASE 10: fnAdjustVolumeUP(TAG_LEV_WL2)
	    CASE 11: fnAdjustVolumeDN(TAG_LEV_WL2)
	    
	    CASE 14: fnAdjustVolumeUP(TAG_LEV_WL3)
	    CASE 15: fnAdjustVolumeDN(TAG_LEV_WL3)
	    
	    CASE 18: fnAdjustVolumeUP(TAG_LEV_WL4)
	    CASE 19: fnAdjustVolumeDN(TAG_LEV_WL4)
	    
	    CASE 22: fnAdjustVolumeUP(TAG_LEV_PRGM)
	    CASE 23: fnAdjustVolumeDN(TAG_LEV_PRGM)
	}
    }
}
BUTTON_EVENT [dvTP_Audio, BTN_RESET_DATA]
{
    PUSH :
    {
	fnReconnect()
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FEEDBACK]
{
    [dvTP_Audio, BTN_RESET_DATA] = scm820Online
   
    
    WAIT 250 //25 Seconds..
    {
	SEND_STRING dvQsysAudio, "'sg',LF" //Keep Alive
    }
}

