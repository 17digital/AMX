PROGRAM_NAME='ShureSCM820'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/27/2017  AT: 13:06:01        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Notes
	0 = All
	1-8 = Input Channels
	9 = Aux Input
	18 = Output A
	19 = Output B
	
	Scale...Max 1280
	
	1100 = 0 / 82%
	1000 = -10 / 72%
	990 = -11 / 71%
	900 = -20 / 62%
	880 = -22 / 60%
	800 = -30 / 52%
	
	
	
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED	dvShure
        dvShure =			0:2:0 //Shure Mixer See AMX TECH NOTE 937!!! For more Documentation
#END_IF


#IF_NOT_DEFINED 	dvTP_Shure
    dvTP_Shure =			10001:5:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

TL_SHURE				= 4

MIC_1				= 1
MIC_2				= 2
MIC_3				= 3
MIC_4				= 4
MIC_5				= 5
MIC_6				= 6
MIC_7				= 7
MIC_8				= 8
LINE_AUX				= 9
OUT_A				= 18
OUT_B				= 19

//Channel Names...Max 31
NAME_1				= 'Testing'
NAME_2				= 'Max Input of 31'
NAME_3				= 'Put it to the limits'
NAME_9				= 'External'
NAME_19				= 'SUBZ'


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE


CHAR shureDevice[30] = 'I am Chris' //This will show up on the touchpanel

CHAR shureIP[15]= '128.61.216.19' 

LONG SCM820_Port= 2202 //Port Shure uses!
VOLATILE INTEGER scm820Online
VOLATILE INTEGER cBooted

VOLATILE CHAR cShureBuffer[500]
VOLATILE LONG lTLGetStatus[] = {15000} //15 Seconds


//Lav 1
VOLATILE INTEGER nMuteMic_1 
VOLATILE INTEGER nMic1_VOL
VOLATILE INTEGER nMic1_Preset = 910
//Lav 2

VOLATILE SINTEGER nAux_VOL
VOLATILE INTEGER nMuteAux //Auxillary
VOLATILE INTEGER nAux_Preset = 800

VOLATILE INTEGER nMasterA_VOL
VOLATILE INTEGER nMasterA_Mute
VOLATILE INTEGER nMasterA_Preset = 1100

VOLATILE INTEGER nMasterB_VOL
VOLATILE INTEGER nMasterB_Mute
VOLATILE INTEGER nMasterB_Preset = 1000

DEV vdvTP_Shure[] = {dvTP_Shure}


VOLATILE INTEGER nShureChannelIdx[] = //Microphone Channels
{
    //Mute || UP || DN || Preset
    
    //DVX In..
    1, 2, 3, 4, 
    
    //Aux In
    5,6,7,8, 
    
    //Master A
    9,10, 11,12, 
    
    //Master B
    13,14, 15,16 
}


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnStartConnection()
{
    IP_CLIENT_OPEN(dvShure.PORT,shureIP,SCM820_Port,1) //#1 is for TCP/IP connection
}
DEFINE_FUNCTION fnCloseConnection()
{
    IP_CLIENT_CLOSE(dvShure.PORT) //Closes Connection When Done
}
DEFINE_FUNCTION fnChannelNames() //Set Channel Names (31 Characters Max)
{
    //Names can have a Max of (1) Space - Or it will Not work!!
    SEND_STRING dvShure, " '< SET ',ITOA(MIC_1), ' CHAN_NAME {',NAME_1,'} >' "
    SEND_STRING dvShure, " '< SET ',ITOA(MIC_2), ' CHAN_NAME {',NAME_2,'} >' "
    SEND_STRING dvShure, " '< SET ',ITOA(MIC_3), ' CHAN_NAME {',NAME_3,'} >' "
    SEND_STRING dvShure, '< SET 4 CHAN_NAME {HandHeld 2} >'
    SEND_STRING dvShure, '< SET 5 CHAN_NAME {TableTop 1} >'
    SEND_STRING dvShure, '< SET 6 CHAN_NAME {TableTop 2} >'
    SEND_STRING dvShure, '< SET 7 CHAN_NAME {TableTop 3} >'
    SEND_STRING dvShure, '< SET 8 CHAN_NAME {TableTop 4} >'
    SEND_STRING dvShure, " '< SET ',ITOA(LINE_AUX), ' CHAN_NAME {',NAME_9,'} >' "
     SEND_STRING dvShure, " '< SET ',ITOA(OUT_B), ' CHAN_NAME {',NAME_19,'} >' "
}
DEFINE_FUNCTION fnShureID() //Set Shure Id
{
    //You CAN NOT have spaces!!
    //Example - CULC144DSP1
    //Example - CULC144DSP2
    SEND_STRING dvShure, '< SET DEVICE_ID {CHRISMIX} >'
}
DEFINE_FUNCTION fnMuteMicrophones(INTEGER cInput, CHAR cState[3])
{
    SEND_STRING dvShure, " '< SET ',ITOA(cInput), ' AUDIO_MUTE ',cState, ' >' "
}
DEFINE_FUNCTION fnPresetMicrophones(INTEGER cInput, INTEGER cPreset)
{
    SEND_STRING dvShure, " '< SET ',ITOA(cInput), ' AUDIO_GAIN_HI_RES ',ITOA(cPreset), ' >' "
}
DEFINE_FUNCTION fnSetGainAdjustUP(INTEGER cInput)
{
    SEND_STRING dvShure, " '< SET ',ITOA(cInput), ' AUDIO_GAIN_HI_RES INC 10 >' "
}
DEFINE_FUNCTION fnSetGainAdjustDOWN(INTEGER cInput)
{
    SEND_STRING dvShure, " '< SET ',ITOA(cInput), ' AUDIO_GAIN_HI_RES DEC 10 >' "
}
DEFINE_FUNCTION fnGetShureRep()
{
    //0 Will Set All Channels
    //SEND_STRING dvShure, '< SET 0 AUDIO_GAIN_HI_RES 1040 >'
    WAIT 10 SEND_STRING dvShure, '< GET 1 AUDIO_GAIN_HI_RES >'
    WAIT 20 SEND_STRING dvShure, '< GET 1 AUDIO_MUTE >'
    
    WAIT 30 SEND_STRING dvShure, '< GET 9 AUDIO_GAIN_HI_RES >'
    WAIT 40 SEND_STRING dvShure, '< GET 9 AUDIO_MUTE >'
    
    WAIT 50 SEND_STRING dvShure, '< GET 18 AUDIO_GAIN_HI_RES >'
    WAIT 60 SEND_STRING dvShure, '< GET 18 AUDIO_MUTE >'
    
    WAIT 70 SEND_STRING dvShure, '< GET 19 AUDIO_GAIN_HI_RES >'
    WAIT 90 SEND_STRING dvShure, '< GET 19 AUDIO_MUTE >'
}
DEFINE_FUNCTION fnReconnect()
{
    fnCloseConnection()
	WAIT 20
	{
	    fnStartConnection()
	    WAIT 30 fnGetShureRep()
	}
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [cBooted]
CREATE_BUFFER dvShure, cShureBuffer;
TIMELINE_CREATE(TL_SHURE,lTLGetStatus,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

WAIT 50
{
    fnStartConnection()
    WAIT 30
    {
	fnChannelNames()
	WAIT 50
	{
	    fnGetShureRep()
	}
    }
}

WAIT 600
{
    OFF [cBooted]
}
    

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [vdvTP_Shure]
{
    ONLINE:
    {
	SEND_COMMAND vdvTP_Shure, "'^TXT-100,0,',shureDevice"
	
	IF (!cBooted)
	{
	    fnGetShureRep()
	}
    }
}
DATA_EVENT [dvShure]
{
    ONLINE: //SET UP SHURE
    {
	SEND_STRING 0, 'Audio Is Online'
	
	ON [scm820Online]
	CANCEL_WAIT 'DEVICE COMM/INIT'
	WAIT 200 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
	    fnReconnect()
	}
    }
    STRING :
    {
	ON [scm820Online]
	CANCEL_WAIT 'DEVICE COMM/INIT'
	WAIT 200 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
	    fnReconnect()
	}
	Send_String 0,"'RECEIVING AUDIO ',cShureBuffer"
	
	SELECT
	{
	    ACTIVE (FIND_STRING(cShureBuffer,'< REP 1 AUDIO_MUTE ON >',1)):
	    {
		ON [nMuteMic_1]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(MIC_1),',0,Muted'"
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 1 AUDIO_MUTE OFF >',1)):
	    {
		OFF [nMuteMic_1]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(MIC_1),',0,',ITOA((nMic1_VOL / 10) -28),'%'"	
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 1 AUDIO_GAIN_HI_RES ',1)):
	    {
		REMOVE_STRING(cShureBuffer,'< REP 1 AUDIO_GAIN_HI_RES ',1)
		
		nMic1_VOL = ATOI(cShureBuffer)
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(MIC_1),',0,',ITOA((nMic1_VOL / 10) -28),'%'"
	    }
	    
	    //Aux...
	    ACTIVE (FIND_STRING(cShureBuffer,'< REP 9 AUDIO_MUTE ON >',1)):
	    {
		ON [nMuteAux]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(LINE_AUX),',0,Muted'"
		
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 9 AUDIO_MUTE OFF >',1)):
	    {
		OFF [nMuteAux]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(LINE_AUX),',0,',ITOA((nAux_VOL / 10) -28),'%'"
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 9 AUDIO_GAIN_HI_RES ',1)):
	    {
		REMOVE_STRING(cShureBuffer,'< REP 9 AUDIO_GAIN_HI_RES ',1)
		
		nAux_VOL = ATOI(cShureBuffer)
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(LINE_AUX),',0,',ITOA((nAux_VOL / 10) -28),'%'"
	    }
	    
	    //Master A...
	    ACTIVE (FIND_STRING(cShureBuffer,'< REP 18 AUDIO_MUTE ON >',1)):
	    {
		ON [nMasterA_Mute]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(OUT_A),',0,Muted'"
		
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 18 AUDIO_MUTE OFF >',1)):
	    {
		OFF [nMasterA_Mute]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(OUT_A),',0,',ITOA((nMasterA_VOL / 10) -28),'%'"
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 18 AUDIO_GAIN_HI_RES ',1)):
	    {
		REMOVE_STRING(cShureBuffer,'< REP 18 AUDIO_GAIN_HI_RES ',1)
		
		nMasterA_VOL = ATOI(cShureBuffer)
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(OUT_A),',0,',ITOA((nMasterA_VOL / 10) -28),'%'"
	    }
	    
	    //Master B...
	    ACTIVE (FIND_STRING(cShureBuffer,'< REP 19 AUDIO_MUTE ON >',1)):
	    {
		ON [nMasterB_Mute]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(OUT_B),',0,Muted'"
		
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 19 AUDIO_MUTE OFF >',1)):
	    {
		OFF [nMasterB_Mute]
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(OUT_B),',0,',ITOA((nMasterB_VOL / 10) -28),'%'"
	    }
	    ACTIVE (FIND_STRING(cShureBuffer, '< REP 19 AUDIO_GAIN_HI_RES ',1)):
	    {
		REMOVE_STRING(cShureBuffer,'< REP 19 AUDIO_GAIN_HI_RES ',1)
		
		nMasterB_VOL = ATOI(cShureBuffer)
		SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(OUT_B),',0,',ITOA((nMasterB_VOL / 10) -28),'%'"
	    }
	}
    cShureBuffer = ''
    
    }
}

DEFINE_EVENT
BUTTON_EVENT [vdvTP_Shure, nShureChannelIdx]
{
    PUSH:
    {  
	STACK_VAR INTEGER nChannelIdx
	
	nChannelIdx = GET_LAST (nShureChannelIdx)
	SWITCH (nChannelIdx)
	{
	    //DVX In...
	    CASE 1: 
	    {
		IF (!nMuteMic_1)
		{
		    fnMuteMicrophones(MIC_1, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(MIC_1, 'OFF')
		}
	    }
	    CASE 2: fnSetGainAdjustUP(MIC_1)
	    CASE 3: fnSetGainAdjustDOWN(MIC_1)
	    CASE 4: fnPresetMicrophones(MIC_1,nMic1_Preset)
	    
	    //Aux...
	    CASE 5: 
	    {
		IF (!nMuteAux)
		{
		    fnMuteMicrophones(LINE_AUX, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(LINE_AUX, 'OFF')
		}
	    }
	    CASE 6: fnSetGainAdjustUP(LINE_AUX)
	    CASE 7: fnSetGainAdjustDOWN(LINE_AUX)
	    CASE 8: fnPresetMicrophones(LINE_AUX,nAux_Preset)
	    
	    //Master A
	    CASE 9:
	    {
		IF (!nMasterA_Mute )
		{
		    fnMuteMicrophones(OUT_A, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(OUT_A, 'OFF')
		}
	    }
	    CASE 10: fnSetGainAdjustUP(OUT_A)
	    CASE 11: fnSetGainAdjustDOWN(OUT_A)
	    CASE 12: fnPresetMicrophones(OUT_A,nMasterA_Preset)
	    
	    //Master B
	    CASE 13:
	    {
		IF (!nMasterB_Mute)
		{
		    fnMuteMicrophones(OUT_B, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(OUT_B, 'OFF')
		}
	    }
	    CASE 14: fnSetGainAdjustUP(OUT_B)
	    CASE 15: fnSetGainAdjustDOWN(OUT_B)
	    CASE 16: fnPresetMicrophones(OUT_B,nMasterB_Preset)
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nChannelIdx
	
	nChannelIdx = GET_LAST (nShureChannelIdx)
	SWITCH (nChannelIdx)
	{
	    CASE 2: fnSetGainAdjustUP(MIC_1)
	    CASE 3: fnSetGainAdjustDOWN(MIC_1)
	    CASE 6: fnSetGainAdjustUP(LINE_AUX)
	    CASE 7: fnSetGainAdjustDOWN(LINE_AUX)
	    CASE 14: fnSetGainAdjustUP(OUT_B)
	    CASE 15: fnSetGainAdjustDOWN(OUT_B)
	}
    }
}
BUTTON_EVENT [vdvTP_Shure, 1000]
{
    PUSH :
    {
	fnReconnect()
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_SHURE]
{
    SEND_STRING dvShure, '< GET DEVICE_ID >'
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    [vdvTP_Shure, 1] = nMuteMic_1
    [vdvTP_Shure, 5] = nMuteAux
    [vdvTP_Shure, 9] = nMasterA_Mute
    [vdvTP_Shure, 13] = nMasterB_Mute
    [vdvTP_Shure, 1000] = scm820Online
    
}
    
DEFINE_EVENT
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


    