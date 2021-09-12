PROGRAM_NAME='ShureSCM820'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/06/2020  AT: 08:33:28        *)
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


dvShure =			0:2:0 //Shure Mixer See AMX TECH NOTE 937!!! For more Documentation

dvTP_Shure =			10001:5:0

#IF_NOT_DEFINED dvTP_Shure2
dvTP_Shure2 =		10002:5:0
#END_IF



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

TL_FEEDBACK				= 1

//Mic + Line Input IDS...
IN_MIC_1				= 1
IN_MIC_2				= 2
IN_MIC_3				= 3
IN_MIC_4				= 4
IN_MIC_5				= 5
IN_MIC_6				= 6
IN_MIC_7				= 7
IN_MIC_8				= 8
IN_LINE_AUX			= 9
OUT_LINE_A				= 18
OUT_LINE_B				= 19

//Channel Names...Max 31
NAME_1				= 'Roku-L'
NAME_2				= 'Roku-R'
NAME_3				= 'Nothing Here 3'
NAME_4				= 'Nothing Here 4'
NAME_5				= 'Nothing Here 5'
NAME_6				= 'Nothing Here 6'
NAME_7				= 'Nothing Here 7'
NAME_8				= 'Nothing Here 8'
NAME_9				= 'External Aux'
NAME_18				= 'Front Speakers'
NAME_19				= 'SUBZ'

//Buttons..
BTN_MUTE_DAN_1		= 1
BTN_MUTE_DAN_2		= 1
BTN_MUTE_DAN_3		= 1
BTN_MUTE_DAN_4		= 1
BTN_MUTE_DAN_5		= 1
BTN_MUTE_DAN_6		= 1
BTN_MUTE_DAN_7		= 1
BTN_MUTE_DAN_8		= 1
BTN_MUTE_DAN_9		= 1

BTN_MUTE_ANALOG_1		= 5
BTN_MUTE_MAIN			= 9 //Analog Out 1
BTN_MUTE_Subs			= 13 //Analog Out 2

BTN_NET_BOOT			= 1000

//TXT Addresses...
TXT_CH_1				= 311
TXT_CH_2				= 312
TXT_CH_3				= 313
TXT_CH_4				= 314
TXT_CH_5				= 315
TXT_CH_6				= 316
TXT_CH_7				= 317
TXT_CH_8				= 318
TXT_CH_9				= 319
TXT_CH_10				= 320
TXT_CH_11				= 321
TXT_CH_12				= 322
TXT_CH_13				= 323
TXT_CH_14				= 324
TXT_CH_15				= 325
TXT_CH_16				= 326
TXT_CH_17				= 327
TXT_CH_18				= 328
TXT_CH_19				= 329

TXT_DEVICE				= 1001

BTN_MUTE_ROKU			= 1
BTN_MUTE_AUX			= 5
BTN_MUTE_SUB 			= 13


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE


CHAR shureDevice[30] = 'I am Chris' //This will show up on the touchpanel

CHAR shureIP[15]= '172.21.24.30' //Living Dsp

LONG SCM820_Port= 2202 //Port Shure uses!
VOLATILE INTEGER scm820Online
VOLATILE INTEGER cBooted

VOLATILE CHAR cShureBuffer[500]

VOLATILE INTEGER nMic1_Preset = 910
VOLATILE INTEGER nAux_Preset = 800
VOLATILE INTEGER nMasterA_Preset = 1100
VOLATILE INTEGER nMasterB_Preset = 1000

VOLATILE DEV vdvTP_Shure[] = 
{
    dvTP_Shure,
    dvTP_Shure2
}
VOLATILE INTEGER nShureChannelIdx[] = //Microphone Channels
{    
    //DVX In..
    1, 2, 3, 4, 
    
    //Aux In
    5,6,7,8, 
    
    //Master A
    9,10, 11,12, 
    
    //Master B
    13,14, 15,16 
}
VOLATILE INTEGER nMixLevels[] = //Basically All Shure Channel ID's...
{
    //Mic 1-8
    1, //Btn
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9, //Aux Btn
    //Direct Outputs..
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18, //Output A
    19	//Output B
}
VOLATILE INTEGER nMuteButtons[] =
{
    //Mic 1-8
    1, //Btn
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    5, //Aux Btn
    //Direct Outputs..
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18, //Output A
    13	//Output B
}
VOLATILE CHAR cShureNames[19][31]= //3 Max Text Length
{
    'Roku-L',
    'Roku-R',
    'Not-Used3',
    'Not-Used4',
    'Not-Used5',
    'Not-Used6',
    'Not-Used7',
    'Not-Used8',
    'Aux-Source',
    'DirectOut10',
    'DirectOut11',
    'DirectOut12',
    'DirectOut13',
    'DirectOut14',
    'DirectOut15',
    'DirectOut16',
    'DirectOut17',
    'Main-Out',
    'Subs-Out'
    
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
    TXT_CH_18,
    TXT_CH_19
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
    STACK_VAR INTEGER b;
    
    FOR (b =1; b <=MAX_LENGTH_ARRAY(nNameSlot); b++)
    {
	SEND_STRING dvShure, " '< SET ',ITOA(b), ' CHAN_NAME {',cShureNames[b],'} >'"
	    SEND_COMMAND dvTP_Shure, "'^TXT-',ITOA(nNameSlot[b]),',0,',cShureNames[b]"
    }
}
DEFINE_FUNCTION fnShureID() //Set Shure Id
{
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
CREATE_BUFFER dvShure, cShureBuffer;

TIMELINE_CREATE (TL_FEEDBACK, lTlFeedback,LENGTH_ARRAY(lTlFeedback),TIMELINE_ABSOLUTE, TIMELINE_REPEAT);

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
	scm820Online = TRUE;
	ON [vdvTP_Shure, BTN_NET_BOOT]
    }
     OFFLINE :
    {
	scm820Online = FALSE;
	    OFF [vdvTP_Shure, BTN_NET_BOOT]
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvShure:onerror: ',GetIpError(DATA.NUMBER)");
		Send_String 0,"'Shure onerror : ',GetIpError(DATA.NUMBER)"; 
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 7 : //Connection Time Out...
	    {
		scm820Online = FALSE;
		    fnReconnect()
	    }
	    DEFAULT :
	    {
		//fnReconnect()
		scm820Online = FALSE;
	    }
	}
    }
    STRING :
    {
    	STACK_VAR CHAR cResponse[100]
	STACK_VAR INTEGER cID //Holds Input ID
	STACK_VAR INTEGER cLev
	LOCAL_VAR CHAR cChName[20]
	
	Send_String 0,"'RECEIVING AUDIO ',cShureBuffer" 
	AMX_LOG (AMX_INFO, "'dvShure:STRING: ',cShureBuffer");
	
	scm820Online = TRUE;
	    ON [vdvTP_Shure, BTN_NET_BOOT]
	
	WHILE (FIND_STRING(cShureBuffer,'>',1))
	{
	    cResponse = REMOVE_STRING(cShureBuffer,'>',1)

	    IF (FIND_STRING (cResponse,'< REP ',1))
	    {
	       REMOVE_STRING (cResponse,'< REP ',1)

	       cID = ATOI (LEFT_STRING(cResponse, 2)) //01 -- 14 (
	    
	        IF (FIND_STRING (cResponse,"ITOA(cId),' AUDIO_MUTE ON >'",1))
	        {
		  ON [vdvTP_Shure, nMuteButtons[cID]]
		    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(nMixLevels[cId]),',0,Muted'"
	         }
	        IF (FIND_STRING (cResponse,"ITOA(cId),' AUDIO_MUTE OFF >'",1))
	        {
		   OFF [vdvTP_Shure, nMuteButtons[cID]]
		    SEND_STRING dvShure, " '< GET ',ITOA(nMixLevels[cID]), ' AUDIO_GAIN_HI_RES >' "
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
	      IF (FIND_STRING (cResponse,'DEVICE_ID {',1))
	      {
		REMOVE_STRING (cResponse,'DEVICE_ID {',1)
		    shureDevice = LEFT_STRING(cResponse,LENGTH_STRING(cResponse)-3)
			    SEND_COMMAND vdvTP_Shure, "'^TXT-',ITOA(TXT_DEVICE),',0,',shureDevice"
	      }
	}
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
		IF (![vdvTP_Shure, BTN_MUTE_ROKU])
		{
		    fnMuteMicrophones(IN_MIC_1, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(IN_MIC_1, 'OFF')
		}
	    }
	    CASE 2: fnSetGainAdjustUP(IN_MIC_1)
	    CASE 3: fnSetGainAdjustDOWN(IN_MIC_1)
	    CASE 4: fnPresetMicrophones(IN_MIC_1,nMic1_Preset)
	    
	    //Aux...
	    CASE 5: 
	    {
		IF (![vdvTP_Shure, BTN_MUTE_AUX])
		{
		    fnMuteMicrophones(IN_LINE_AUX, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(IN_LINE_AUX, 'OFF')
		}
	    }
	    CASE 6: fnSetGainAdjustUP(IN_LINE_AUX)
	    CASE 7: fnSetGainAdjustDOWN(IN_LINE_AUX)
	    CASE 8: fnPresetMicrophones(IN_LINE_AUX,nAux_Preset)
	    
	    //Master A
	    CASE 9:
	    {
		IF (![vdvTP_Shure, BTN_MUTE_SUB])
		{
		    fnMuteMicrophones(OUT_LINE_A, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(OUT_LINE_A, 'OFF')
		}
	    }
	    CASE 10: fnSetGainAdjustUP(OUT_LINE_A)
	    CASE 11: fnSetGainAdjustDOWN(OUT_LINE_A)
	    CASE 12: fnPresetMicrophones(OUT_LINE_A,nMasterA_Preset)
	    
	    //Master B
	    CASE 13:
	    {
		IF (![vdvTP_Shure, BTN_MUTE_SUB])
		{
		    fnMuteMicrophones(OUT_LINE_B, 'ON')
		}
		ELSE
		{
		    fnMuteMicrophones(OUT_LINE_B, 'OFF')
		}
	    }
	    CASE 14: fnSetGainAdjustUP(OUT_LINE_B)
	    CASE 15: fnSetGainAdjustDOWN(OUT_LINE_B)
	    CASE 16: fnPresetMicrophones(OUT_LINE_B,nMasterB_Preset)
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nChannelIdx
	
	nChannelIdx = GET_LAST (nShureChannelIdx)
	SWITCH (nChannelIdx)
	{
	    CASE 2: fnSetGainAdjustUP(IN_MIC_1)
	    CASE 3: fnSetGainAdjustDOWN(IN_MIC_1)
	    CASE 6: fnSetGainAdjustUP(IN_LINE_AUX)
	    CASE 7: fnSetGainAdjustDOWN(IN_LINE_AUX)
	    CASE 14: fnSetGainAdjustUP(OUT_LINE_B)
	    CASE 15: fnSetGainAdjustDOWN(OUT_LINE_B)
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
TIMELINE_EVENT [TL_FEEDBACK] //Feedback /Hearbeat Check...
{
    WAIT 300
    {
	IF (scm820Online == FALSE)
	{
	    fnStartConnection()
	    WAIT 20
	    {
		fnChannelNames()
		WAIT 50
		{
		    fnGetShureRep()
		}
	    }
	}
	ELSE
	{
	    SEND_STRING dvShure, '< GET DEVICE_ID >'
	}
    }
}
   
