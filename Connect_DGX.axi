PROGRAM_NAME='Connect_DGX'
(***********************************************************)
(*  FILE CREATED ON: 05/18/2017  AT: 07:10:50              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 01/16/2019  AT: 12:17:50        *)
(***********************************************************)


(* 

    ~ DGX 1600
    functions just like boggs B9
    
    Left Projector  Mirrors Left Monitor
    
    //Break Sources when rooms separate!
*)

DEFINE_DEVICE

DGX_CONN =			8150 //System

dvDGX =				5002:1:DGX_CONN

dvVIDEOIN_1   = 			5002:1:DGX_CONN //Vaddio Cam 1
dvVIDEOIN_2   = 			5002:2:DGX_CONN //Vaddio Cam 2
dvVIDEOIN_3   = 			5002:3:DGX_CONN // Extron SMB 351
dvVIDEOIN_4   = 			5002:4:DGX_CONN //TV Tuner

dvVIDEOIN_5   = 			5002:5:DGX_CONN //Air media
dvVIDEOIN_6  = 			5002:6:DGX_CONN //Smart Kapp IQ Pro (Possible for Future)
dvVIDEOIN_7  = 			5002:7:DGX_CONN //Smart Kapp IQ Pro (Possible for Future)
dvVIDEOIN_8  = 			5002:8:DGX_CONN //Blank

dvVIDEOIN_9   = 			5002:9:DGX_CONN //Desktop Left
dvVIDEOIN_10  = 			5002:10:DGX_CONN //Desktop Right
dvVIDEOIN_11 =			5002:11:DGX_CONN //DxLink TX (AAP Plate)
dvVIDEOIN_12 =			5002:12:DGX_CONN //Doc Cam

dvVIDEOIN_13 =			5002:13:DGX_CONN //Not Used
dvVIDEOIN_14 =			5002:14:DGX_CONN //Not Used
dvVIDEOIN_15 =			5002:15:DGX_CONN //Not Used
dvVIDEOIN_16 =			5002:16:DGX_CONN //Not Used

dvVIDEOIN_17 =				5002:17:DGX_CONN //Not Used
dvVIDEOIN_18 =				5002:18:DGX_CONN //Not Used
dvVIDEOIN_19 =				5002:19:DGX_CONN //Not Used
dvVIDEOIN_20 =				5002:20:DGX_CONN //Not Used

dvVIDEOOUT_1 =				5002:1:DGX_CONN //
dvVIDEOOUT_2 =				5002:2:DGX_CONN
dvVIDEOOUT_3 =				5002:3:DGX_CONN
dvVIDEOOUT_4 =				5002:4:DGX_CONN
dvVIDEOOUT_5 =				5002:5:DGX_CONN
dvVIDEOOUT_6 =				5002:6:DGX_CONN
dvVIDEOOUT_7 =				5002:7:DGX_CONN
dvVIDEOOUT_8 =				5002:8:DGX_CONN
dvVIDEOOUT_9 =				5002:9:DGX_CONN
dvVIDEOOUT_10 =			5002:10:DGX_CONN
dvVIDEOOUT_11 =			5002:11:DGX_CONN
dvVIDEOOUT_12 =			5002:12:DGX_CONN
dvVIDEOOUT_13 =			5002:13:DGX_CONN
dvVIDEOOUT_14 =			5002:14:DGX_CONN
dvVIDEOOUT_15 =			5002:15:DGX_CONN
dvVIDEOOUT_16 =			5002:16:DGX_CONN
dvVIDEOOUT_17 =			5002:17:DGX_CONN
dvVIDEOOUT_18 =			5002:18:DGX_CONN
dvVIDEOOUT_19 =			5002:19:DGX_CONN
dvVIDEOOUT_20 =			5002:20:DGX_CONN
                                        
dvAUDIOUT_33 =				5002:33:DGX_CONN //Main Audio Out A
dvAUDIOUT_34 =				5002:34:DGX_CONN //Main Audio Out B

(**Room A **)
dvProjector_Front_334 =		46009:1:DGX_CONN //334
dvProjector_dxFront_334 =		46009:6:DGX_CONN

dvProjector_Side_334 =		46010:1:DGX_CONN
dvProjector_dxSide_334 =		46010:6:DGX_CONN

dvProjector_Rear_334 =		46011:1:DGX_CONN
dvProjector_dxRear_334 =		46011:6:DGX_CONN

vdvProjector_Front_334 =		35011:1:0
vdvProjector_Side_334 =		35012:1:0
vdvProjector_Rear_334 =		35013:1:0
								    
(**Room B 331 **)
dvProjector_Front_335 =		46013:1:DGX_CONN //
dvProjector_dxFront_335 =		46013:6:DGX_CONN

dvProjector_Side_335 =		46014:1:DGX_CONN
dvProjector_dxSide_335 =		46014:6:DGX_CONN

dvProjector_Rear_335 =		46015:1:DGX_CONN
dvProjector_dxRear_335 =		46015:6:DGX_CONN

vdvProjector_Front_335 =		35014:1:0
vdvProjector_Side_335 =		35015:1:0
vdvProjector_Rear_335 =		35016:1:0


DEFINE_CONSTANT

//Naming - Max Char = 31
INPUT_NAME_1			= 'Desktop Main 330'
INPUT_NAME_2			= 'Desktop Ext 330'
INPUT_NAME_3			= 'Doc Cam 330'
INPUT_NAME_4			= 'VGA HDMI 330'

INPUT_NAME_5			= 'Desktop Main 331'
INPUT_NAME_6			= 'Desktop Ext 331'
INPUT_NAME_7			= 'Doc Cam 331'
INPUT_NAME_8			= 'VGA HDMI 331'

INPUT_NAME_9			= 'Solstice 330'
INPUT_NAME_10			= 'Solstice 331'
INPUT_NAME_11			= 'Extron SMP 330'
INPUT_NAME_12			= 'Extron SMP 331'

INPUT_NAME_13			= 'DL Feed1 330'
INPUT_NAME_14			= 'DL Feed2 330'
INPUT_NAME_15			= 'DL Feed3 330'
INPUT_NAME_16			= 'Not Used'

INPUT_NAME_17			= 'DL Feed1 331'
INPUT_NAME_18			= 'DL Feed2 331'
INPUT_NAME_19			= 'DL Feed3 331'
INPUT_NAME_20			= 'Not Used'
 
OUTPUT_NAME_1			= '330 To DL 1'
OUTPUT_NAME_2			= '330 DL 2'
OUTPUT_NAME_3			= '330 Extron Rec'
OUTPUT_NAME_4			= 'Not Used'

OUTPUT_NAME_5			= '331 To DL 1'
OUTPUT_NAME_6			= '331 To DL 2'
OUTPUT_NAME_7			= '331 Extron Rec'
OUTPUT_NAME_8			= 'Not Used'

OUTPUT_NAME_9			= '330 Proj Left'
OUTPUT_NAME_10		= '330 Proj Right'
OUTPUT_NAME_11		= '330 Proj Rear'
OUTPUT_NAME_12		= 'Not Used'

OUTPUT_NAME_13		= '331 Proj Left'
OUTPUT_NAME_14		= '331 Proj Right'
OUTPUT_NAME_15		= '331 Proj Rear'
OUTPUT_NAME_16		= 'Not Used'

OUTPUT_NAME_17		= '330 Mon Left'
OUTPUT_NAME_18		= '330 Mon Right'
OUTPUT_NAME_19		= '331 Mon Right'
OUTPUT_NAME_20		= '331 Mon Right'

AUDIO_OUTPUT_NAME_33	= 'Main Out 334'
AUDIO_OUTPUT_NAME_34	= 'Main Out 335'

//Offical DGX Routing Numbers...
IN_DESKTOP_330			= 1
IN_DESK_EXT_330		= 2
IN_EXTERNAL_330		= 3
IN_DOCCAM_330			= 4

IN_DESKTOP_331			= 5
IN_DESK_EXT_331		= 6
IN_EXTERNAL_331		= 8
IN_DOCCAM_331			= 7

IN_AIRMEDIA_330		= 9 //Solstice
IN_AIRMEDIA_331		= 10 //Solstice
IN_EXTRON_330			= 11 
IN_EXTRON_331			= 12 

IN_DL_1_330			= 13 //DL In Left
IN_DL_2_330			= 14 //DL In Right
IN_DL_3_330			= 15 //DL In Rear
//Blank				= 16

IN_DL_1_331			= 17 //DL In 1
IN_DL_2_331			= 18 //DL In 2
IN_DL_3_331			= 19 //DL In 3
//Blank				= 20

//DGX Outs...
OUT_PROJLEFT_330		= 9
OUT_PROJRIGHT_330		= 10
OUT_PROJREAR_330		= 11
//Blank				= 4

OUT_PROJLEFT_331		= 13
OUT_PROJRIGHT_331		= 14
OUT_PROJREAR_331 		= 15
//Blank				= 8

OUT_MONLEFT_330			= 17
OUT_MONRIGHT_330		= 18
OUT_MONLEFT_331			= 19
OUT_MONRIGHT_331		= 20

OUT_DL1_330			= 1
OUT_DL2_330			= 2
OUT_SMP_330			= 3
//Blank				= 4
OUT_DL1_331			= 5
OUT_DL2_331			= 6
OUT_SMP_331			= 7
//Blank				= 20

AUDIO_OUT_330			= 4 //Due to Extract Card
AUDIO_OUT_331			= 8 //Due to Extract Card

SET_MUTE_ON			= 'ENABLE'
SET_MUTE_OFF			= 'DISABLE'

TL_FEEDBACK			= 2
TL_FLASH				= 3


//Common Feedback...
POWER_CYCLE			= 9
POWER_ON				= 27
POWER_OFF			= 28
WARMING				= 253
COOLING				= 254
ON_LINE				= 251
POWER				= 255
BLANK				= 211



DEFINE_VARIABLE


//Room A
NON_VOLATILE INTEGER nSource_Left_330  
NON_VOLATILE INTEGER nSource_Right_330
VOLATILE INTEGER nSource_Audio_330
VOLATILE INTEGER nFollow_Rear_330 //Rear Tracking
VOLATILE INTEGER nMasterMode330

VOLATILE INTEGER nMuteProjLeft_330
VOLATILE INTEGER nMuteProjRight_330
VOLATILE INTEGER nMuteProjRear_330

//Room B
NON_VOLATILE INTEGER nSource_Right_331  
NON_VOLATILE INTEGER nSource_Left_331
VOLATILE INTEGER nSource_Audio_331
VOLATILE INTEGER nFollow_Rear_331 //Rear Tracking
VOLATILE INTEGER nMasterMode331

VOLATILE INTEGER nMuteProjLeft_331
VOLATILE INTEGER nMuteProjRight_331
VOLATILE INTEGER nMuteProjRear_331


VOLATILE INTEGER iFlash
VOLATILE LONG lTLFeedback[] = {250}
VOLATILE LONG lTLFlash[] = {500}


VOLATILE INTEGER nStartUp_Btns[] =
{
    21, //separate
    22, //330 Master
    23, //331 Master
    24, //Break / stop)
    25, //Shutdown 330
    26  //Shutdown 331
}
VOLATILE INTEGER nLeft_Display_334[] =
{
    //Projector
    1, //on
    2, //off
    3,  //mute
    4, //Screen Upqa
    5,  //Down
    
    //Sources..
    11, //Main
    12, //Desk Ext
    13, //External Source
    14, //Doc
    15,  //Solstice
    
    18 //DL 1
}
VOLATILE INTEGER nRight_Display_334[] =
{
    //Projector
    101, //on
    102, //off
    103,  //mute
    104, //Up
    105, //Down

    //Sources...
    111, //Main
    112, //Desk Ext
    113, //External
    114, //Doc Cam
    115, //Air Media
    
    116,  //Preview Notes...
    117,  //Preview Recording...
    
    118 //DL 1
}
VOLATILE INTEGER nRear_Display_334[] =
{
    201, //On
    202, //off
    203, //Blank
    204, //Up
    205,  //Down
    
    //Sources...
    211, //Follow Left
    212, //Ext Desktop (Notes)
    
    218 //DL 1
}
VOLATILE INTEGER nLeft_Display_335[] =
{
    //Projector
    1001, //on
    1002, //off
    1003,  //mute
    1004, //Screen Up
    1005,  //Down
    
    //Sources..
    1011, //Main
    1012, //Desk Ext
    1013, //External Source
    1014, //Doc
    1015,  //Solstice
    
    1018 //DL 1
}
VOLATILE INTEGER nRight_Display_335[] =
{
    //Projector
    1101, //on
    1102, //off
    1103,  //mute
    1104, //Up
    1105, //Down

    //Sources...
    1111, //Main
    1112, //Desk Ext
    1113, //External
    1114, //Doc Cam
    1115, //Solstice
    
    //Monitor Only...
    1116,  //Preview Notes...
    1117,  //Preview Recording...
    
    //DL Sources...
    1118
}
VOLATILE INTEGER nRear_Display_335[] =
{
    1201, //On
    1202, //off
    1203, //Blank
    1204, //Up
    1205,  //Down
    
    //Sources...
    1211, //Follow Left
    1212, //Ext Desktop (Notes)
    
    1218 //DL 1
}



DEFINE_LATCHING

DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_CALL 'DGX NAMING'
{
    SEND_COMMAND dvVIDEOIN_1, "'VIDIN_NAME-',INPUT_NAME_1"
    SEND_COMMAND dvVIDEOIN_2, "'VIDIN_NAME-',INPUT_NAME_2"
    SEND_COMMAND dvVIDEOIN_3, "'VIDIN_NAME-',INPUT_NAME_3"
    SEND_COMMAND dvVIDEOIN_4, "'VIDIN_NAME-',INPUT_NAME_4"
    SEND_COMMAND dvVIDEOIN_5, "'VIDIN_NAME-',INPUT_NAME_5"
    SEND_COMMAND dvVIDEOIN_6, "'VIDIN_NAME-',INPUT_NAME_6"
    SEND_COMMAND dvVIDEOIN_7, "'VIDIN_NAME-',INPUT_NAME_7"
    SEND_COMMAND dvVIDEOIN_8, "'VIDIN_NAME-',INPUT_NAME_8"
    SEND_COMMAND dvVIDEOIN_9, "'VIDIN_NAME-',INPUT_NAME_9"
    SEND_COMMAND dvVIDEOIN_10, "'VIDIN_NAME-',INPUT_NAME_10"
    SEND_COMMAND dvVIDEOIN_11, "'VIDIN_NAME-',INPUT_NAME_11"
    SEND_COMMAND dvVIDEOIN_12, "'VIDIN_NAME-',INPUT_NAME_12"
    SEND_COMMAND dvVIDEOIN_13, "'VIDIN_NAME-',INPUT_NAME_13"
    SEND_COMMAND dvVIDEOIN_14, "'VIDIN_NAME-',INPUT_NAME_14"
    SEND_COMMAND dvVIDEOIN_15, "'VIDIN_NAME-',INPUT_NAME_15"
    SEND_COMMAND dvVIDEOIN_16, "'VIDIN_NAME-',INPUT_NAME_16"
    
    WAIT 20
    {
	SEND_COMMAND dvVIDEOOUT_1, "'VIDOUT_NAME-',OUTPUT_NAME_1"
	SEND_COMMAND dvVIDEOOUT_2, "'VIDOUT_NAME-',OUTPUT_NAME_2"
	SEND_COMMAND dvVIDEOOUT_3, "'VIDOUT_NAME-',OUTPUT_NAME_3"
	SEND_COMMAND dvVIDEOOUT_4, "'VIDOUT_NAME-',OUTPUT_NAME_4"
	SEND_COMMAND dvVIDEOOUT_5, "'VIDOUT_NAME-',OUTPUT_NAME_5"
	SEND_COMMAND dvVIDEOOUT_6, "'VIDOUT_NAME-',OUTPUT_NAME_6"
	SEND_COMMAND dvVIDEOOUT_7, "'VIDOUT_NAME-',OUTPUT_NAME_7"
	SEND_COMMAND dvVIDEOOUT_8, "'VIDOUT_NAME-',OUTPUT_NAME_8"
	SEND_COMMAND dvVIDEOOUT_9, "'VIDOUT_NAME-',OUTPUT_NAME_9"
	SEND_COMMAND dvVIDEOOUT_10, "'VIDOUT_NAME-',OUTPUT_NAME_10"
	SEND_COMMAND dvVIDEOOUT_11, "'VIDOUT_NAME-',OUTPUT_NAME_11"
	SEND_COMMAND dvVIDEOOUT_12, "'VIDOUT_NAME-',OUTPUT_NAME_12"
	SEND_COMMAND dvVIDEOOUT_13, "'VIDOUT_NAME-',OUTPUT_NAME_13"
	SEND_COMMAND dvVIDEOOUT_14, "'VIDOUT_NAME-',OUTPUT_NAME_14"
	SEND_COMMAND dvVIDEOOUT_15, "'VIDOUT_NAME-',OUTPUT_NAME_15"
	SEND_COMMAND dvVIDEOOUT_16, "'VIDOUT_NAME-',OUTPUT_NAME_16"
	
	WAIT 10
	{
	    SEND_COMMAND dvAUDIOUT_33, "'AUDOUT_NAME-',AUDIO_OUTPUT_NAME_33"
	}
    }
}
DEFINE_FUNCTION fnVideoLeft330(INTEGER cIn)
{
    nSource_Left_330 = cIn 
    
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_SMP_330),',',ITOA(OUT_PROJLEFT_330),',',ITOA(OUT_MONLEFT_330)"
    
    IF (nFollow_Rear_330)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_330)"
    }
    
    IF (nMasterMode330)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJLEFT_331)"
    }
    
    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL1_330)"
    }
}
DEFINE_FUNCTION fnVideoRight330(INTEGER cIn)
{
    nSource_Right_330 = cIn 
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_330),',',ITOA(OUT_MONRIGHT_330)"
    
    
    IF (nMasterMode330)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_331)"
    }
    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL2_330)"
    }
}
DEFINE_FUNCTION fnAudio330(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'CI',ITOA(cIn),'O',ITOA(AUDIO_OUT_330)" //Due to Extract Card
    nSource_Audio_330 = cIn
}
DEFINE_FUNCTION fnVideoLeft331(INTEGER cIn)
{
    nSource_Left_331 = cIn 
    
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_SMP_331),',',ITOA(OUT_PROJLEFT_331),',',ITOA(OUT_MONLEFT_331)"
    
    IF (nFollow_Rear_331)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJREAR_331)"
    }
    
    IF (nMasterMode331)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJLEFT_330)"
    }
    
    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL1_331)"
    }
}
DEFINE_FUNCTION fnVideoRight331(INTEGER cIn)
{
    nSource_Right_331 = cIn 
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_331),',',ITOA(OUT_MONRIGHT_331)"
    
    
    IF (nMasterMode331)
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJRIGHT_330)"
    }
    WAIT 20
    {
	SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL2_331)"
    }
}
DEFINE_FUNCTION fnAudio331(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'CI',ITOA(cIn),'O',ITOA(AUDIO_OUT_331)" //Due to Extract Card
    nSource_Audio_331 = cIn
}
DEFINE_FUNCTION fnDGXRoutePreview(INTEGER cIn, INTEGER cOut)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(cOut)"
}
DEFINE_FUNCTION fnDisplayPWR(CHAR cPwr[20])
{
    SWITCH (cPwr)
    {
	CASE '330 LEFT ON' :
	{
	    PULSE [vdvProjector_Front_334, POWER_ON]
	    fnRelayDirection(DN_LEFT_334)
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Front_335, POWER_ON]
		fnRelayDirection(DN_LEFT_335)
	    }

	}
	CASE '330 LEFT OFF' :
	{
	    PULSE [vdvProjector_Front_334, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(UP_LEFT_334)
	    }
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Front_335, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection(UP_LEFT_335)
		}
	    }
	}
	CASE '330 RIGHT ON' :
	{
	    PULSE [vdvProjector_Side_334, POWER_ON]
	    fnRelayDirection(DN_RIGHT_334)
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Rear_335, POWER_ON]
		    fnRelayAddDirection(DN_RIGHT_335)
	    }
	}
	CASE '330 RIGHT OFF' :
	{
	    PULSE [vdvProjector_Side_334, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(UP_RIGHT_334)
	    }
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Side_335, POWER_OFF]
		WAIT 30
		{
		    fnRelayAddDirection(UP_RIGHT_335)
		}
	    }
	}
	CASE '330 REAR ON' :
	{
	    PULSE [vdvProjector_Rear_334, POWER_ON]
	    fnRelayDirection(DN_REAR_334)
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Rear_335, POWER_ON]
		fnRelayAddDirection(DN_REAR_335)
	    }
	
	}
	CASE '330 REAR OFF' :
	{
	    PULSE [vdvProjector_Rear_334, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(UP_REAR_334)
	    }
	    
	    IF (nMasterMode330)
	    {
		PULSE [vdvProjector_Rear_335, POWER_OFF]
		WAIT 30
		{
		    fnRelayAddDirection(UP_REAR_335)
		}
	    }
	}
	//331
	CASE '331 LEFT ON' :
	{
	    PULSE [vdvProjector_Front_335, POWER_ON]
	    fnRelayDirection(DN_LEFT_335)
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Front_334, POWER_ON]
		fnRelayDirection(DN_LEFT_334)
	    }
	}
	CASE '331 LEFT OFF' :
	{
	    PULSE [vdvProjector_Front_335, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(UP_LEFT_335)
	    }
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Front_334, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection(UP_LEFT_334)
		}
	    }
	}
	CASE '331 RIGHT ON' :
	{
	    PULSE [vdvProjector_Side_335, POWER_ON]
	    fnRelayAddDirection(DN_RIGHT_335)
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Side_334, POWER_ON]
		fnRelayDirection(DN_RIGHT_334)
	    }
	}
	CASE '331 RIGHT OFF' :
	{
	    PULSE [vdvProjector_Side_335, POWER_OFF]
	    WAIT 30
	    {
		fnRelayAddDirection(UP_RIGHT_335)
	    }
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Side_334, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection(UP_RIGHT_334)
		}
	    }
	}
	CASE '331 REAR ON' :
	{
	    PULSE [vdvProjector_Rear_335, POWER_ON]
	    fnRelayAddDirection(DN_REAR_335)
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Rear_334, POWER_ON]
		fnRelayAddDirection(DN_REAR_334)
	    }
	}
	CASE '331 REAR OFF' :
	{
	    PULSE [vdvProjector_Rear_335, POWER_OFF]
	    WAIT 30
	    {
		fnRelayAddDirection(UP_REAR_335)
	    }
	    
	    IF (nMasterMode331)
	    {
		PULSE [vdvProjector_Rear_334, POWER_OFF]
		WAIT 30
		{
		    fnRelayAddDirection(UP_REAR_334)
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnDisplayMute(DEV cDevice, CHAR cState[8])
{
    SEND_COMMAND cDevice, "'VIDOUT_MUTE-',cState"
    WAIT 5
    {
	SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
    }
}
DEFINE_FUNCTION fnMuteCheck(DEV cDevice)
{
    SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
}
DEFINE_CALL 'ROOM MODE' (CHAR cMode[20])
{
    SWITCH (cMode)
    {
	CASE 'SEPARATE' :
	{
	    OFF [nMasterMode330]
	    OFF [nMasterMode331]
	    //Audio Break...
	    fnAudioMode('UnCombine')
	}
	CASE 'MASTER 330' :
	{
	    ON [nMasterMode330]
	    OFF [nMasterMode331]
	    //Audio Combine Preset..
	    fnAudioMode('Combine')
	    //Lock other touch Panel...
	    SEND_COMMAND dvTP_Main2, "'PAGE-Locked'"
	    
	    IF ([vdvProjector_Front_334, POWER])
	    {
		fnDisplayPWR ('331 LEFT ON')
	    }
	    IF ([vdvProjector_Side_334, POWER])
	    {
		fnDisplayPWR ('331 RIGHT ON')
	    }
	    IF ([vdvProjector_Rear_334, POWER])
	    {
		fnDisplayPWR ('331 REAR ON')
	    }
	    //Mirror DGX Roughts to other room
	    fnDGXRoutePreview(nSource_Left_330,OUT_PROJLEFT_331)
	    WAIT 10 fnDGXRoutePreview(nSource_Right_330, OUT_PROJRIGHT_331)
	    WAIT 20 fnDGXRoutePreview(nSource_Left_330, OUT_PROJREAR_331)
	    
	}
	CASE 'MASTER 331' :
	{
	    ON [nMasterMode331]
	    OFF [nMasterMode330]
	    //Audio Combine...
	    fnAudioMode('Combine')
	    
	    SEND_COMMAND dvTP_Main, "'PAGE-Locked'" //Locks 334...
	    
	    IF ([vdvProjector_Front_335, POWER])
	    {
		fnDisplayPWR ('330 LEFT ON')
	    }
	    IF ([vdvProjector_Side_335, POWER])
	    {
		fnDisplayPWR ('330 RIGHT ON')
	    }
	    IF ([vdvProjector_Rear_335, POWER])
	    {
		fnDisplayPWR ('330 REAR ON')
	    }
	    //Mirror DGX Roughts to other room
	    fnDGXRoutePreview(nSource_Left_331,OUT_PROJLEFT_330)
	    WAIT 10 fnDGXRoutePreview(nSource_Right_331, OUT_PROJRIGHT_330)
	    WAIT 20 fnDGXRoutePreview(nSource_Left_331, OUT_PROJREAR_330)
	}
	CASE 'BREAK' : //Resets 335
	{
	    OFF [nMasterMode330]
	    OFF [nMasterMode331]
	    SEND_COMMAND vdvTP_Main, "'PAGE-Start'"
	    //Audio Break
	    fnAudioMode('UnCombine')
	    fnDGXRoutePreview(nSource_Left_330,OUT_PROJLEFT_330)
	    WAIT 10 fnDGXRoutePreview(nSource_Right_330, OUT_PROJRIGHT_330)
	    WAIT 20 fnDGXRoutePreview(nSource_Left_330, OUT_PROJREAR_330)

	    WAIT 30 fnDGXRoutePreview(nSource_Left_331,OUT_PROJLEFT_331)
	    WAIT 40 fnDGXRoutePreview(nSource_Right_331, OUT_PROJRIGHT_331)
	    WAIT 50 fnDGXRoutePreview(nSource_Left_331, OUT_PROJREAR_331)
	}
	CASE 'OFF 330' :
	{
	    fnDisplayPWR ('330 LEFT OFF')
	    fnDisplayPWR ('330 RIGHT OFF')
	    fnDisplayPWR ('330 REAR OFF')
	}
	CASE 'OFF 331' :
	{
	    fnDisplayPWR ('331 LEFT OFF')
	    fnDisplayPWR ('331 RIGHT OFF')
	    fnDisplayPWR ('331 REAR OFF')
	}
    }
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '22:00:00')
    {
	SEND_COMMAND vdvTP_Main, "'PAGE-Start'" //334 + 335
	
	 fnDisplayPWR ('PROJ 334 LEFT OFF')
	WAIT 10 fnDisplayPWR ('PROJ 334 RIGHT OFF')
	WAIT 20 fnDisplayPWR ('PROJ 334 REAR OFF')
	 
	WAIT 30 fnDisplayPWR ('PROJ 335 LEFT OFF')
	WAIT 40 fnDisplayPWR ('PROJ 335 RIGHT OFF')
	WAIT 50 fnDisplayPWR ('PROJ 335 REAR OFF')
    }
}

DEFINE_START


TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

OFF [nFollow_Rear_330]
OFF [nFollow_Rear_331]


DEFINE_MODULE 'Sony_FHZ700L' PROJMODLEFT(vdvProjector_Front_334, dvProjector_Front_334);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODRIGHT(vdvProjector_Side_334, dvProjector_Side_334);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODREAR(vdvProjector_Rear_334, dvProjector_Rear_334);

DEFINE_MODULE 'Sony_FHZ700L' PROJMODFRONT(vdvProjector_Front_335, dvProjector_Front_335);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODSIDE(vdvProjector_Side_335, dvProjector_Side_335);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODREAREND(vdvProjector_Rear_335, dvProjector_Rear_335);


DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, nStartUp_Btns]
{
    PUSH :
    {
	STACK_VAR INTEGER nModeIDX
	
	nModeIDX = GET_LAST (nStartUp_Btns)
	SWITCH (nModeIDX)
	{
	    CASE 1 : CALL 'ROOM MODE' ('SEPARATE')
	    CASE 2 : CALL 'ROOM MODE' ('MASTER 330')
	    CASE 3 : CALL 'ROOM MODE' ('MASTER 331')
	    CASE 4 : CALL 'ROOM MODE' ('BREAK')

	    CASE 5 : CALL 'ROOM MODE' ('OFF 330')
	    CASE 6 : CALL 'ROOM MODE' ('OFF 331')
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nLeft_Display_334]
{
    PUSH :
    {
	STACK_VAR INTEGER nLeft_DisplayIDX
	
	nLeft_DisplayIDX = GET_LAST (nLeft_Display_334)
	

		SWITCH (nLeft_DisplayIDX)
		{
		    CASE 1 : fnDisplayPWR ('330 LEFT ON')
		    CASE 2 : fnDisplayPWR ('330 LEFT OFF')
		    CASE 3 :
		    {
			IF (!nMuteProjLeft_330)
			{
			    fnDisplayMute(dvProjector_dxFront_334, SET_MUTE_ON)
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxFront_335, SET_MUTE_ON)
			    }
			}
			ELSE
			{
			    fnDisplayMute(dvProjector_dxFront_334, SET_MUTE_OFF)
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxFront_335, SET_MUTE_OFF)
			    }
			}
		    }
	    
		    CASE 4 : fnRelayDirection(UP_LEFT_334)
		    CASE 5 : fnRelayDirection(DN_LEFT_334)
		    
		    CASE 6 :
		    {
			fnVideoLeft330(IN_DESKTOP_330) 
			fnAudio330(IN_DESKTOP_330)
		    }
		    CASE 7 :
		    {
			fnVideoLeft330(IN_DESK_EXT_330) 
			fnAudio330(IN_DESKTOP_330)
		    }
		    CASE 8 :
		    {
			fnVideoLeft330(IN_EXTERNAL_330) 
			fnAudio330(IN_EXTERNAL_330)
		    }
		    CASE 9 :
		    {
			fnVideoLeft330(IN_DOCCAM_330) 
		    }
		    CASE 10 :
		    {
			fnVideoLeft330(IN_AIRMEDIA_330) 
			fnAudio330(IN_AIRMEDIA_330)
		    }
		    CASE 11 :
		    {
			fnDGXRoutePreview (IN_DL_1_330, OUT_PROJLEFT_330)
			IF (nMasterMode330)
			{
			    fnDGXRoutePreview(IN_DL_1_330, OUT_PROJLEFT_331)
			}
		    }

		}
    }
}
BUTTON_EVENT [vdvTP_Main, nRight_Display_334]
{
    PUSH :
    {
	STACK_VAR INTEGER nRight_DisplayIDX
	
	nRight_DisplayIDX = GET_LAST (nRight_Display_334)
	
	SWITCH (nRight_DisplayIDX)
	{
		    CASE 1 : fnDisplayPWR ('330 RIGHT ON')
		    CASE 2 : fnDisplayPWR ('330 RIGHT OFF')
		    CASE 3 :
		    {
			IF (!nMuteProjRight_330)
			{
			    fnDisplayMute(dvProjector_dxSide_334, SET_MUTE_ON)
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxSide_335, SET_MUTE_ON)
			    }
			}
			ELSE
			{
			    fnDisplayMute(dvProjector_dxSide_334, SET_MUTE_OFF)
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxSide_335, SET_MUTE_OFF)
			    }
			}
		    }
	    
		    CASE 4 : fnRelayDirection(UP_LEFT_334)
		    CASE 5 : fnRelayDirection(DN_LEFT_334)
		    
		    CASE 6 :
		    {
			fnVideoRight330(IN_DESKTOP_330) 
			fnAudio330(IN_DESKTOP_330)
		    }
		    CASE 7 :
		    {
			fnVideoRight330(IN_DESK_EXT_330) 
			fnAudio330(IN_DESKTOP_330)
		    }
		    CASE 8 :
		    {
			fnVideoRight330(IN_EXTERNAL_330) 
			fnAudio330(IN_EXTERNAL_330)
		    }
		    CASE 9 :
		    {
			fnVideoRight330(IN_DOCCAM_330) 
		    }
		    CASE 10 :
		    {
			fnVideoRight330(IN_AIRMEDIA_330) 
			fnAudio330(IN_AIRMEDIA_330)
		    }
		    CASE 11 :
		    {
			fnDGXRoutePreview (IN_DESK_EXT_330, OUT_MONRIGHT_330)
		    }
		    CASE 12 :
		    {
			fnDGXRoutePreview (IN_EXTRON_330, OUT_MONRIGHT_330)
		    }
		    CASE 13 :
		    {
			fnDGXRoutePreview (IN_DL_1_330, OUT_PROJRIGHT_330)
			IF (nMasterMode330)
			{
			    fnDGXRoutePreview(IN_DL_1_330, OUT_PROJRIGHT_331)
			}
		    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nRear_Display_334]
{
    PUSH :
    {
	STACK_VAR INTEGER nRear_DisplayIDX
	
	nRear_DisplayIDX = GET_LAST (nRear_Display_334)
	SWITCH (nRear_DisplayIDX)
	{
	    CASE 1 : fnDisplayPWR ('330 REAR ON')
	    CASE 2 : fnDisplayPWR ('330 REAR OFF')
		    CASE 3 :
		    {
			IF (!nMuteProjRear_330)
			{
			    fnDisplayMute(dvProjector_dxRear_334, SET_MUTE_ON)
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxRear_335, SET_MUTE_ON)
			    }
			}
			ELSE
			{
			    fnDisplayMute(dvProjector_dxRear_334, SET_MUTE_OFF)
			    
			    IF (nMasterMode330)
			    {
				fnDisplayMute(dvProjector_dxRear_335, SET_MUTE_ON)
			    }
			}
		    }
	    
		    CASE 4 : fnRelayDirection(UP_REAR_334)
		    CASE 5 : fnRelayDirection(DN_REAR_334)
		    
		    CASE 6 : //Follow Left...
		    {
			ON [nFollow_Rear_330]
			fnDGXRoutePreview(nSource_Left_330, OUT_PROJREAR_330)
		    }
		    CASE 7 : //Extended Only...
		    {
			OFF [nFollow_Rear_330]
			fnDGXRoutePreview(IN_DESK_EXT_330, OUT_PROJREAR_330)

		    }
		    CASE 8 :
		    {

			fnDGXRoutePreview(IN_DL_3_330, OUT_PROJREAR_330)

		    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nLeft_Display_335] //335 Video Routing
{
    PUSH :
    {
	STACK_VAR INTEGER nLeft_Display335IDX
	
	nLeft_Display335IDX = GET_LAST (nLeft_Display_335)
	SWITCH (nLeft_Display335IDX)
	{
		    CASE 1 : fnDisplayPWR ('331 LEFT ON')
		    CASE 2 : fnDisplayPWR ('331 LEFT OFF')
		    CASE 3 :
		    {
			IF (!nMuteProjLeft_331)
			{
			    fnDisplayMute(dvProjector_dxFront_335, SET_MUTE_ON)
			    
			    IF (nMasterMode331)
			    {
				fnDisplayMute(dvProjector_dxFront_334, SET_MUTE_ON)
			    }
			}
			ELSE
			{
			    fnDisplayMute(dvProjector_dxFront_334, SET_MUTE_OFF)
			    
			    IF (nMasterMode331)
			    {
				fnDisplayMute(dvProjector_dxFront_334, SET_MUTE_OFF)
			    }
			}
		    }
	    
		    CASE 4 : fnRelayDirection(UP_LEFT_334)
		    CASE 5 : fnRelayDirection(DN_LEFT_334)
		    
		    CASE 6 :
		    {
			fnVideoLeft331(IN_DESKTOP_331) 
			fnAudio331(IN_DESKTOP_331)
		    }
		    CASE 7 :
		    {
			fnVideoLeft331(IN_DESK_EXT_331) 
			fnAudio331(IN_DESKTOP_331)
		    }
		    CASE 8 :
		    {
			fnVideoLeft331(IN_EXTERNAL_331) 
			fnAudio331(IN_EXTERNAL_331)
		    }
		    CASE 9 :
		    {
			fnVideoLeft331(IN_DOCCAM_331) 
		    }
		    CASE 10 :
		    {
			fnVideoLeft331(IN_AIRMEDIA_331) 
			fnAudio331(IN_AIRMEDIA_331)
		    }
		    CASE 11 :
		    {
			fnDGXRoutePreview (IN_DL_1_331, OUT_PROJLEFT_331)
			IF (nMasterMode331)
			{
			    fnDGXRoutePreview(IN_DL_1_331, OUT_PROJLEFT_330)
			}
		    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nRight_Display_335]
{
    PUSH :
    {
	STACK_VAR INTEGER nRight_Display335IDX
	
	nRight_Display335IDX = GET_LAST (nRight_Display_335)
	SWITCH (nRight_Display335IDX)
	{
		    CASE 1 : fnDisplayPWR ('331 RIGHT ON')
		    CASE 2 : fnDisplayPWR ('331 RIGHT OFF')
		    CASE 3 :
		    {
			IF (!nMuteProjRight_331)
			{
			    fnDisplayMute(dvProjector_dxSide_335, SET_MUTE_ON)
			    
			    IF (nMasterMode331)
			    {
				fnDisplayMute(dvProjector_dxSide_334, SET_MUTE_ON)
			    }
			}
			ELSE
			{
			    fnDisplayMute(dvProjector_dxSide_335, SET_MUTE_OFF)
			    
			    IF (nMasterMode331)
			    {
				fnDisplayMute(dvProjector_dxSide_334, SET_MUTE_OFF)
			    }
			}
		    }
	    
		    CASE 4 : fnRelayDirection(UP_LEFT_334)
		    CASE 5 : fnRelayDirection(DN_LEFT_334)
		    
		    CASE 6 :
		    {
			fnVideoRight331(IN_DESKTOP_331) 
			fnAudio331(IN_DESKTOP_331)
		    }
		    CASE 7 :
		    {
			fnVideoRight331(IN_DESK_EXT_331) 
			fnAudio331(IN_DESKTOP_331)
		    }
		    CASE 8 :
		    {
			fnVideoRight331(IN_EXTERNAL_331) 
			fnAudio331(IN_EXTERNAL_331)
		    }
		    CASE 9 :
		    {
			fnVideoRight331(IN_DOCCAM_331) 
		    }
		    CASE 10 :
		    {
			fnVideoRight331(IN_AIRMEDIA_331) 
			fnAudio331(IN_AIRMEDIA_331)
		    }
		    CASE 11 :
		    {
			fnDGXRoutePreview (IN_DESK_EXT_331, OUT_MONRIGHT_331)
		    }
		    CASE 12 :
		    {
			fnDGXRoutePreview (IN_EXTRON_331, OUT_MONRIGHT_331)
		    }
		    CASE 13 :
		    {
			fnDGXRoutePreview (IN_DL_2_331, OUT_PROJRIGHT_331)
			IF (nMasterMode331)
			{
			    fnDGXRoutePreview(IN_DL_2_331, OUT_PROJRIGHT_330)
			}
		    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nRear_Display_335]
{
    PUSH :
    {
	STACK_VAR INTEGER nRear_Display335IDX
	
	nRear_Display335IDX = GET_LAST (nRear_Display_335)
	SWITCH (nRear_Display335IDX)
	{
	    CASE 1 : fnDisplayPWR ('331 REAR ON')
	    CASE 2 : fnDisplayPWR ('331 REAR OFF')
		    CASE 3 :
		    {
			IF (!nMuteProjRear_331)
			{
			    fnDisplayMute(dvProjector_dxRear_335, SET_MUTE_ON)
			    
			    IF (nMasterMode331)
			    {
				fnDisplayMute(dvProjector_dxRear_334, SET_MUTE_ON)
			    }
			}
			ELSE
			{
			    fnDisplayMute(dvProjector_dxRear_335, SET_MUTE_OFF)
			    
			    IF (nMasterMode331)
			    {
				fnDisplayMute(dvProjector_dxRear_334, SET_MUTE_ON)
			    }
			}
		    }
	    
		    CASE 4 : fnRelayDirection(UP_REAR_334)
		    CASE 5 : fnRelayDirection(DN_REAR_334)
		    
		    CASE 6 : //Follow Left...
		    {
			ON [nFollow_Rear_331]
			fnDGXRoutePreview(nSource_Left_331, OUT_PROJREAR_331)
		    }
		    CASE 7 : //Extended Only...
		    {
			OFF [nFollow_Rear_331]
			fnDGXRoutePreview(IN_DESK_EXT_331, OUT_PROJREAR_331)

		    }
		    CASE 8 :
		    {

			fnDGXRoutePreview(IN_DL_3_331, OUT_PROJREAR_331)

		    }

	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_Front_334, ON_LINE]
CHANNEL_EVENT [vdvProjector_Front_334, WARMING]
CHANNEL_EVENT [vdvProjector_Front_334, COOLING] //330 Left Projector
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	}
    }
}
CHANNEL_EVENT [vdvProjector_Side_334, ON_LINE]
CHANNEL_EVENT [vdvProjector_Side_334, WARMING]
CHANNEL_EVENT [vdvProjector_Side_334, COOLING] //330 Right Projector
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    CASE WARMING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	    CASE COOLING :
	    {
	    SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	}
	
    }
}
CHANNEL_EVENT [vdvProjector_Rear_334, ON_LINE]
CHANNEL_EVENT [vdvProjector_Rear_334, WARMING]
CHANNEL_EVENT [vdvProjector_Rear_334, COOLING] //330 Rear Projector
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP255'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP30'"
	    }
	}
    }
    OFF :
    {	
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-201.202,0,%OP255'"
	    }
	}
	
    }
}
CHANNEL_EVENT [vdvProjector_Front_335, ON_LINE]
CHANNEL_EVENT [vdvProjector_Front_335, WARMING]
CHANNEL_EVENT [vdvProjector_Front_335, COOLING] //331 Left Projector
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1001.1002,0,%OP255'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1001.1002,0,%OP30'"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1001.1002,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1001.1002,0,%OP255'"
	    }
	}
    }
}
CHANNEL_EVENT [vdvProjector_Side_335, ON_LINE]
CHANNEL_EVENT [vdvProjector_Side_335, WARMING]
CHANNEL_EVENT [vdvProjector_Side_335, COOLING] //331 Right Projector
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1101.1102,0,%OP255'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1101.1102,0,%OP30'"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1101.1102,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1101.1102,0,%OP255'"
	    }
	}
    }
}
CHANNEL_EVENT [vdvProjector_Rear_335, ON_LINE]
CHANNEL_EVENT [vdvProjector_Rear_335, WARMING]
CHANNEL_EVENT [vdvProjector_Rear_335, COOLING] //331 Rear Projector
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1201.1202,0,%OP255'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1201.1202,0,%OP30'"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1201.1202,0,%OP30'"
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1201.1202,0,%OP255'"
	    }
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvDGX]
{
    ONLINE :
    {
	WAIT 80
	{
	    CALL 'DGX NAMING'
	}
    }
}
DATA_EVENT [dvProjector_dxFront_334] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 50 SEND_COMMAND dvProjector_dxFront_334, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMuteProjLeft_330]

	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMuteProjLeft_330]
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxSide_334] //Projector Port...
{
    ONLINE :
    {
	WAIT 50 SEND_COMMAND dvProjector_dxSide_334, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMuteProjRight_330]
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMuteProjRight_330]
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxRear_334] //Projector Port...
{
    ONLINE :
    {
	WAIT 50 SEND_COMMAND dvProjector_dxRear_334, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMuteProjRear_330]
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMuteProjRear_330]
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxFront_335] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 50 SEND_COMMAND dvProjector_dxFront_335, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMuteProjLeft_331]

	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMuteProjLeft_331]
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxSide_335] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 50 SEND_COMMAND dvProjector_dxSide_335, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMuteProjRight_331]

	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMuteProjRight_331]
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxRear_335] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 50 SEND_COMMAND dvProjector_dxRear_335, "'?VIDOUT_MUTE'"
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMuteProjRear_331]

	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMuteProjRear_331]
	    }
	}
    }
}

DEFINE_EVENT 
TIMELINE_EVENT [TL_FLASH]
{
    iFlash = !iFlash
}
TIMELINE_EVENT [TL_MAINLINE]
{
    [vdvTP_Main, 11] = nSource_Left_330 = IN_DESKTOP_330
    [vdvTP_Main, 12] = nSource_Left_330 = IN_DESK_EXT_330
    [vdvTP_Main, 13] = nSource_Left_330 = IN_EXTERNAL_330
    [vdvTP_Main, 14] = nSource_Left_330 = IN_DOCCAM_330
    [vdvTP_Main, 15] = nSource_Left_330 = IN_AIRMEDIA_330
    
    [vdvTP_Main, 111] = nSource_Right_330 = IN_DESKTOP_330
    [vdvTP_Main, 112] = nSource_Right_330 = IN_DESK_EXT_330
    [vdvTP_Main, 113] = nSource_Right_330 = IN_EXTERNAL_330
    [vdvTP_Main, 114] = nSource_Right_330 = IN_DOCCAM_330
    [vdvTP_Main, 115] = nSource_Right_330 = IN_AIRMEDIA_330
    
    [vdvTP_Main, 211] = nFollow_Rear_330
    [VDVtp_Main, 212] = !nFollow_Rear_330
    
    [vdvTP_Main, 511] = nSource_Audio_330 = IN_DESKTOP_330
    [vdvTP_Main, 513] = nSource_Audio_330 = IN_EXTERNAL_330
    [vdvTP_Main, 515] = nSource_Audio_330 = IN_AIRMEDIA_330
    
    [vdvTP_Main, 1] = [vdvProjector_Front_334, POWER]
    [vdvTP_Main, 2] = ![vdvProjector_Front_334, POWER]
    [vdvTP_Main, 3] = nMuteProjLeft_330
    [vdvTP_Main, 601] = [vdvProjector_Front_334, ON_LINE]
    
    
    //Left Projector
    IF ([vdvProjector_Front_334, WARMING])
    {
	[vdvTP_Main, 602] = iFlash
    }
    ELSE IF ([vdvProjector_Front_334, COOLING])
    {
	[vdvTP_Main, 603] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, 602] = [vdvProjector_Front_334, WARMING]
	[vdvTP_Main, 603] = [vdvProjector_Front_334, COOLING]
    }
    
    //Right Projector
    [vdvTP_Main, 101] = [vdvProjector_Side_334, POWER]
    [vdvTP_Main, 102] = ![vdvProjector_Side_334, POWER]
   [vdvTP_Main, 103] = nMuteProjRight_330
    [vdvTP_Main, 611] = [vdvProjector_Side_334, ON_LINE]
    
    IF ([vdvProjector_Side_334, WARMING])
    {
	[vdvTP_Main, 612] = iFlash
    }
    ELSE IF ([vdvProjector_Side_334, COOLING])
    {
	[vdvTP_Main, 613] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, 612] = [vdvProjector_Side_334, WARMING]
	[vdvTP_Main, 613] = [vdvProjector_Side_334, COOLING]
    }
    
    //Rear Projector
    [vdvTP_Main, 201] = [vdvProjector_Rear_334, POWER]
    [vdvTP_Main, 202] = ![vdvProjector_Rear_334, POWER]
    [vdvTP_Main, 203] = nMuteProjRear_330
    [vdvTP_Main, 621] = [vdvProjector_Rear_334, ON_LINE]

    IF ([vdvProjector_Rear_334, WARMING])
    {
	[vdvTP_Main, 622] = iFlash
    }
    ELSE IF ([vdvProjector_Rear_334, COOLING])
    {
	[vdvTP_Main, 623] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, 622] = [vdvProjector_Rear_334, WARMING]
	[vdvTP_Main, 623] = [vdvProjector_Rear_334, COOLING]
    }
    
    //Room 335...
    [vdvTP_Main, 1011] = nSource_Left_331 = IN_DESKTOP_331
    [vdvTP_Main, 1012] = nSource_Left_331 = IN_DESK_EXT_331
    [vdvTP_Main, 1013] = nSource_Left_331 = IN_EXTERNAL_331
    [vdvTP_Main, 1014] = nSource_Left_331 = IN_DOCCAM_331
    [vdvTP_Main, 1015] = nSource_Left_331 = IN_AIRMEDIA_331
    
    [vdvTP_Main, 1111] = nSource_Right_331 = IN_DESKTOP_331
    [vdvTP_Main, 1112] = nSource_Right_331 = IN_DESK_EXT_331
    [vdvTP_Main, 1113] = nSource_Right_331 = IN_EXTERNAL_331
    [vdvTP_Main, 1114] = nSource_Right_331 = IN_DOCCAM_331
    [vdvTP_Main, 1115] = nSource_Right_331 = IN_AIRMEDIA_331
    
    [vdvTP_Main, 1211] = nFollow_Rear_331
    [vdvTP_Main, 1212] = !nFollow_Rear_331
    
    [vdvTP_Main, 1711] = nSource_Audio_331 = IN_DESKTOP_331
    [vdvTP_Main, 1713] = nSource_Audio_331 = IN_EXTERNAL_331
    [vdvTP_Main, 1715] = nSource_Audio_331 = IN_AIRMEDIA_331
    
    //Left Projector 335
    [vdvTP_Main, 1001] = [vdvProjector_Front_335, POWER]
    [vdvTP_Main, 1002] = ![vdvProjector_Front_335, POWER]
    [vdvTP_Main, 1003] = nMuteProjLeft_331
    [vdvTP_Main, 1601] = [vdvProjector_Front_335, ON_LINE]
    
    IF ([vdvProjector_Front_335, WARMING])
    {
	[vdvTP_Main, 1602] = iFlash
    }
    ELSE IF ([vdvProjector_Front_335, COOLING])
    {
	[vdvTP_Main, 1603] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, 1602] = [vdvProjector_Front_335, WARMING]
	[vdvTP_Main, 1603] = [vdvProjector_Front_335, COOLING]
    }
    //Right Proj 335
    [vdvTP_Main, 1101] = [vdvProjector_Side_335, POWER]
    [vdvTP_Main, 1102] = ![vdvProjector_Side_335, POWER]
   [vdvTP_Main, 1103] = nMuteProjRight_331
    [vdvTP_Main, 1611] = [vdvProjector_Side_335, ON_LINE]
    
    IF ([vdvProjector_Side_335, WARMING])
    {
	[vdvTP_Main, 1612] = iFlash
    }
    ELSE IF ([vdvProjector_Side_335, COOLING])
    {
	[vdvTP_Main, 1613] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, 1612] = [vdvProjector_Side_335, WARMING]
	[vdvTP_Main, 1613] = [vdvProjector_Side_335, COOLING]
    }
    //Rear 335
    //Rear Projector
    [vdvTP_Main, 1201] = [vdvProjector_Rear_335, POWER]
    [vdvTP_Main, 1202] = ![vdvProjector_Rear_335, POWER]
    [vdvTP_Main, 1203] = nMuteProjRear_331
    [vdvTP_Main, 1621] = [vdvProjector_Rear_335, ON_LINE]

    IF ([vdvProjector_Rear_335, WARMING])
    {
	[vdvTP_Main, 1622] = iFlash
    }
    ELSE IF ([vdvProjector_Rear_335, COOLING])
    {
	[vdvTP_Main, 1623] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, 1622] = [vdvProjector_Rear_335, WARMING]
	[vdvTP_Main, 1623] = [vdvProjector_Rear_335, COOLING]
    }
    
    WAIT 900
    {
	fnMuteCheck(dvProjector_Front_334)
	fnMuteCheck(dvProjector_Side_334)
	fnMuteCheck(dvProjector_Rear_334)

	//
	fnMuteCheck(dvProjector_Front_335)
	fnMuteCheck(dvProjector_Side_335)
	fnMuteCheck(dvProjector_Rear_335)
    }
    
}

DEFINE_EVENT
                                           