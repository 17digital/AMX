PROGRAM_NAME='ShureTest'
(***********************************************************)
(*  FILE CREATED ON: 04/03/2020  AT: 06:53:01              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/03/2020  AT: 17:48:22        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Device Shure P300
    Max Volume = 1400
    Min Volume = 
    
    https://pubs.shure.com/command-strings/P300/en-US
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE



dvMaster =			0:1:0 //
dvShure =			0:2:0 //Shure Mixer See AMX TECH NOTE 937!!! For more Documentation

dvTP_Shure =			10002:5:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Mic Input Channels (cId)
DANTE_1				= 1
DANTE_2				= 2
DANTE_3				= 3
DANTE_4				= 4
DANTE_5				= 5
DANTE_6				= 6
DANTE_7				= 7
DANTE_8				= 8
DANTE_9				= 9
DANTE_10				= 10
ANALOG_IN_1				= 11
ANALOG_IN_2			= 12
USB_IN				= 13
MOBILE_IN				= 14

ANALOG_OUT_1			= 17
ANALOG_OUT_2			= 18
USB_OUT				= 19
MOBILE_OUT			= 20

BTN_MUTE_DAN_1		= 1
BTN_MUTE_DAN_2		= 1
BTN_MUTE_DAN_3		= 1
BTN_MUTE_DAN_4		= 1
BTN_MUTE_DAN_5		= 1
BTN_MUTE_DAN_6		= 1
BTN_MUTE_DAN_7		= 1
BTN_MUTE_DAN_8		= 1
BTN_MUTE_DAN_9		= 1
BTN_MUTE_DAN_10		= 1
BTN_MUTE_MOBILE		= 1 //3.5 Input
BTN_MUTE_ANALOG_1		= 5
BTN_MUTE_MAIN			= 9 //Analog Out 1
BTN_MUTE_Subs			= 13 //Analog Out 2

TXT_CH_1				= 301
TXT_CH_2				= 302
TXT_CH_3				= 303
TXT_CH_4				= 304
TXT_CH_5				= 305
TXT_CH_6				= 306
TXT_CH_7				= 307
TXT_CH_8				= 308
TXT_CH_9				= 309
TXT_CH_10				= 310
TXT_CH_11				= 311
TXT_CH_12				= 312
TXT_CH_13				= 313
TXT_CH_14				= 314
TXT_CH_15				= 315
TXT_CH_16				= 316
TXT_CH_17				= 317
TXT_CH_18				= 318


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Shure[] = {dvTP_Shure}

CHAR shureDevice[30] = 'Shure Office' //This will show up on the touchpanel

CHAR shureIP[15]= '172.21.24.16' 

LONG SCM820_Port= 2202 //Port Shure uses!
VOLATILE INTEGER scm820Online
VOLATILE INTEGER cBooted

VOLATILE CHAR cShureBuffer[500]

VOLATILE INTEGER nLevel_Preset = 1150
VOLATILE INTEGER cSubPreset = 1100 //0 

VOLATILE INTEGER nShureChannelIdx[] = //Microphone Channels
{
    //Mute || UP || DN || Preset
    
    //Mobile In
    1, 2, 3, 4, 
    
    //Aux In
    5,6,7,8, 
    
    //Main Speakers (Analog 1)
    9,10, 11,12, 
    
    //Subs (Analog 2)
    13,14, 15,16 
}
VOLATILE INTEGER nMixLevels[] =
{
    DANTE_1,
    DANTE_2,
    DANTE_3,
    DANTE_4,
    DANTE_5,
    DANTE_6,
    DANTE_7,
    DANTE_8,
    DANTE_9, 
    DANTE_10,
    ANALOG_IN_1,
    ANALOG_IN_2,
    USB_IN,
    MOBILE_IN,
    15,
    16,
    ANALOG_OUT_1,
    ANALOG_OUT_2
}
VOLATILE INTEGER nMuteButtons[] =
{
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    BTN_MUTE_ANALOG_1,
    12,
    13,
    BTN_MUTE_MOBILE,
    15,
    16,
    BTN_MUTE_MAIN,
    BTN_MUTE_Subs
}
VOLATILE INTEGER nNameSlot[] =
{
    TXT_CH_1,
    TXT_CH_2,
    TXT_CH_3,
    TXT_CH_4,
    TXT_CH_5,
    TXT_CH_6,
    TXT_CH_7,
    TXT_CH_8,
    TXT_CH_9,
    TXT_CH_10,
    TXT_CH_11,
    TXT_CH_12,
    TXT_CH_13,
    TXT_CH_14,
    TXT_CH_15,
    TXT_CH_16,
    TXT_CH_17,
    TXT_CH_18
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

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
	//NA for P300
	//Can only read...
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_1), ' CHAN_NAME {',NAME_1,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_2), ' CHAN_NAME {',NAME_2,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_3), ' CHAN_NAME {',NAME_3,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_4), ' CHAN_NAME {',NAME_4,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_5), ' CHAN_NAME {',NAME_5,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_6), ' CHAN_NAME {',NAME_6,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_7), ' CHAN_NAME {',NAME_7,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(MIC_8), ' CHAN_NAME {',NAME_8,'} >' "
//    SEND_STRING dvShure, " '< SET ',ITOA(LINE_AUX), ' CHAN_NAME {',NAME_9,'} >' "
//     SEND_STRING dvShure, " '< SET ',ITOA(OUT_B), ' CHAN_NAME {',NAME_19,'} >' "
     
     //Change this to an Array...PLEASE
}
DEFINE_FUNCTION fnMuteMicrophones(INTEGER cIn, CHAR cState[3])
{
    SEND_STRING dvShure, " '< SET ',ITOA(cIn), ' AUDIO_MUTE ',cState, ' >' "
}
DEFINE_FUNCTION fnPresetMicrophones(INTEGER cIn, INTEGER cPreset)
{
    SEND_STRING dvShure, " '< SET ',ITOA(cIn), ' AUDIO_GAIN_HI_RES ',ITOA(cPreset), ' >' "
}
DEFINE_FUNCTION fnSetGainAdjustUP(INTEGER cIn)
{
    SEND_STRING dvShure, " '< SET ',ITOA(cIn), ' AUDIO_GAIN_HI_RES INC 10 >' "
}
DEFINE_FUNCTION fnSetGainAdjustDOWN(INTEGER cIn)
{
    SEND_STRING dvShure, " '< SET ',ITOA(cIn), ' AUDIO_GAIN_HI_RES DEC 10 >' "
}
DEFINE_FUNCTION fnGetShureRep()
{
	SEND_STRING dvShure, " '< GET ',ITOA(MOBILE_IN), ' AUDIO_GAIN_HI_RES >' "
	WAIT 10 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_IN_1), ' AUDIO_GAIN_HI_RES >' "
	WAIT 20 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_IN_2), ' AUDIO_GAIN_HI_RES >' "
	WAIT 30 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_OUT_1), ' AUDIO_GAIN_HI_RES >' "
	WAIT 40 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_OUT_2), ' AUDIO_GAIN_HI_RES >' "
	WAIT 50 SEND_STRING dvShure, " '< GET ',ITOA(MOBILE_IN), ' AUDIO_MUTE >' "
	WAIT 60 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_IN_1), ' AUDIO_MUTE >' "
	WAIT 70 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_IN_2), ' AUDIO_MUTE >' "
	WAIT 80 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_OUT_1), ' AUDIO_MUTE >' "
	WAIT 90 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_OUT_2), ' AUDIO_MUTE >' "
	
	WAIT 120 fnPresetMicrophones(ANALOG_OUT_1, nLevel_Preset)
	WAIT 130 fnPresetMicrophones(ANALOG_OUT_2, cSubPreset)
	
	WAIT 190 SEND_STRING dvShure, " '< GET ',ITOA(MOBILE_IN), ' CHAN_NAME >' "
	WAIT 200 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_IN_1), ' CHAN_NAME >' "
	WAIT 210 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_OUT_1), ' CHAN_NAME >' "
	WAIT 220 SEND_STRING dvShure, " '< GET ',ITOA(ANALOG_OUT_2), ' CHAN_NAME >' "
}
DEFINE_FUNCTION fnReconnect()
{
    fnCloseConnection()
	WAIT 20
	{
	    fnStartConnection()
	    //WAIT 30 fnGetShureRep()
	}
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [cBooted]
CREATE_BUFFER dvShure, cShureBuffer;


WAIT 150
{
    fnStartConnection()
    WAIT 30
    {
	    fnGetShureRep()
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
DATA_EVENT [dvTP_Shure]
{
    ONLINE :
    {
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
	
	WAIT 350 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
	    fnReconnect()
	}
    }
    STRING :
    {
    	LOCAL_VAR CHAR cResponse[100]
	LOCAL_VAR INTEGER cID //Holds Input ID
	LOCAL_VAR INTEGER cLev
	LOCAL_VAR CHAR cChName[30]
    
    	CANCEL_WAIT 'DEVICE COMM/INIT'
	
	WAIT 350 'DEVICE COMM/INIT'
	{
	    OFF [scm820Online]
	    fnReconnect()
	}
	Send_String 0,"'RECEIVING AUDIO ',cShureBuffer"
	
	SELECT
	{
	    ACTIVE (FIND_STRING (cShureBuffer,'< REP ',1)):
	    {
		REMOVE_STRING (cShureBuffer,'< REP ',1)
		
		cResponse = cShureBuffer
		cID = ATOI (LEFT_STRING(cResponse, 2)) //01 -- 14
	    
		    IF (FIND_STRING (cResponse,"ITOA(cId),' AUDIO_MUTE ON >'",1))
		    {
			ON [vdvTP_Shure, nMuteButtons[cID]]
			SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nMixLevels[cId]),',0,Muted'"
		    }
		    IF (FIND_STRING (cResponse,"ITOA(cId),' AUDIO_MUTE OFF >'",1))
		    {
			OFF [vdvTP_Shure, nMuteButtons[cID]]
			WAIT 5
			{
			    SEND_STRING dvShure, " '< GET ',ITOA(nMixLevels[cID]), ' AUDIO_GAIN_HI_RES >' "
			}
				
		    }
		    IF (FIND_STRING (cResponse,"ITOA(cId), ' AUDIO_GAIN_HI_RES '",1))
		    {
			    REMOVE_STRING (cResponse,"ITOA(cId), ' AUDIO_GAIN_HI_RES '",1)
			    cLev = ATOI(cResponse) //Should show remaining number return...
					
			   SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nMixLevels[cID]),',0,',ITOA((cLev / 10) - 40),'%'"
		    }
		    IF (FIND_STRING (cResponse,"ITOA(cID), ' CHAN_NAME {'",1))
		    {
			REMOVE_STRING (cResponse,"ITOA(cID), ' CHAN_NAME {'",1)
			cChName = LEFT_STRING(cResponse,LENGTH_STRING(cResponse)-3)
			
			SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nNameSlot[cId]),',0,',cChName"
		    }
	    }
	}
	cShureBuffer = ''
    }
}
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
		IF (![vdvTP_Shure, BTN_MUTE_MOBILE])
		{
		    fnMuteMicrophones(MOBILE_IN, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(MOBILE_IN, 'OFF')
		}
	    }
	    CASE 2: fnSetGainAdjustUP(MOBILE_IN)
	    CASE 3: fnSetGainAdjustDOWN(MOBILE_IN)
	    CASE 4: fnPresetMicrophones(MOBILE_IN,nLevel_Preset)
	    
	    //Aux...
	    CASE 5: 
	    {
		IF (![vdvTP_Shure, BTN_MUTE_ANALOG_1])
		{
		    fnMuteMicrophones(ANALOG_IN_1, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(ANALOG_IN_1, 'OFF')
		}
	    }
	    CASE 6: fnSetGainAdjustUP(ANALOG_IN_1)
	    CASE 7: fnSetGainAdjustDOWN(ANALOG_IN_1)
	    CASE 8: fnPresetMicrophones(ANALOG_IN_1, nLevel_Preset)
	    
	    //Master Analalog Out1
	    CASE 9:
	    {
		IF (![vdvTP_Shure, BTN_MUTE_MAIN])
		{
		    fnMuteMicrophones(ANALOG_OUT_1, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(ANALOG_OUT_1, 'OFF')
		}
	    }
	    CASE 10: fnSetGainAdjustUP(ANALOG_OUT_1)
	    CASE 11: fnSetGainAdjustDOWN(ANALOG_OUT_1)
	    CASE 12: fnPresetMicrophones(ANALOG_OUT_1, nLevel_Preset)
    
    	    //Master Analalog Out1
	    CASE 13:
	    {
		IF (![vdvTP_Shure, BTN_MUTE_Subs])
		{
		    fnMuteMicrophones(ANALOG_OUT_2, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(ANALOG_OUT_2, 'OFF')
		}
	    }
	    CASE 14: fnSetGainAdjustUP(ANALOG_OUT_2)
	    CASE 15: fnSetGainAdjustDOWN(ANALOG_OUT_2)
	    CASE 16: fnPresetMicrophones(ANALOG_OUT_2, cSubPreset)
    	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nChannelIdx
	
	nChannelIdx = GET_LAST (nShureChannelIdx)
	SWITCH (nChannelIdx)
	{
	    CASE 2: fnSetGainAdjustUP(MOBILE_IN)
	    CASE 3: fnSetGainAdjustDOWN(MOBILE_IN)
    	    CASE 6: fnSetGainAdjustUP(ANALOG_IN_1)
	    CASE 7: fnSetGainAdjustDOWN(ANALOG_IN_1)
    	    CASE 10: fnSetGainAdjustUP(ANALOG_OUT_1)
	    CASE 11: fnSetGainAdjustDOWN(ANALOG_OUT_1)
    	    CASE 14: fnSetGainAdjustUP(ANALOG_OUT_2)
	    CASE 15: fnSetGainAdjustDOWN(ANALOG_OUT_2)
	}
    }
}

(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


