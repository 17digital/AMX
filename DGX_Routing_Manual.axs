PROGRAM_NAME='DVXMaster'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/17/2019  AT: 23:21:43        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    8/6/13 - modified scaling to 1080p
    Sanyo PDG-DHT8000L = 1920x1080
    
    $History: $
    TO DO List
    
    Call Touch panel Pushes to Booth Master, Remove Virtual Device Calls!!
*)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

DVX_REMOTE =			7110
DGX_REMOTE =			7112

dvMaster = 			0:1:0	//NX-4200
dvMasterDVX =			0:1:DVX_REMOTE //Dvx3155 Lectern
dvDvxSwitcher =			5002:1:DVX_REMOTE //Dvx 3155 Classroom
dvDgx =	 			5002:1:DGX_REMOTE  //DGX 16 System in Rack


dvTP_Main = 			10001:1:0 //Lectern Touchpanel
dvTP_Booth =			10002:1:0 //Booth TouchPanel

dvProjector_Left = 		46001:1:7112  //This will talk to Projector Left
dvProjector_Right = 		46002:1:7112  //This will talk to Projector Right
dvProjector_Center = 		46003:1:7112  //Center Projector

dvDxlink_Left = 			46001:6:7112  //This will talk to Projector Left
dvDxlink_Right = 			46002:6:7112  //This will talk to Projector Right
dvDxlink_Center = 		46003:6:7112  //Center Projector

dvTuner=				5001:6:0
dvTesira =				5001:2:0
dvCodec =				5001:3:0
dvExtronRec =			5001:4:0
dvIOs =				5001:17:0 //IOs

dvAVINPUT1   = 			5002:1:DVX_REMOTE //PC Main
dvAVINPUT2   = 			5002:2:DVX_REMOTE //PC Extended Desktop
dvAVINPUT3   = 			5002:3:DVX_REMOTE //VGA Laptop
dvAVINPUT4   = 			5002:4:DVX_REMOTE //DVI Laptop
dvAVINPUT5   = 			5002:5:DVX_REMOTE //Document Camera
dvAVINPUT6   = 			5002:6:DVX_REMOTE //Blu Ray Player
dvAVINPUT7   = 			5002:7:DVX_REMOTE //Not Used
dvAVINPUT8   = 			5002:8:DVX_REMOTE //Not used
dvAVINPUT9   = 			5002:9:DVX_REMOTE //Cable TV
dvAVINPUT10  = 			5002:10:DVX_REMOTE //OverFlow from 152

dvAVOUTPUT1 = 			5002:1:DVX_REMOTE //DXLink + HDMI -- House Left
dvAVOUTPUT2 = 			5002:2:DVX_REMOTE //HDMI
dvAVOUTPUT3 = 			5002:3:DVX_REMOTE //DXLink + HDMI -- House Right (if Dual Proj)
dvAVOUTPUT4 = 			5002:4:DVX_REMOTE //HDMI

dvDGXSLOT_1 =			5002:1:DGX_REMOTE
dvDGXSLOT_2 =			5002:2:DGX_REMOTE
dvDGXSLOT_3 =			5002:3:DGX_REMOTE
dvDGXSLOT_4 =			5002:4:DGX_REMOTE
dvDGXSLOT_5 =			5002:5:DGX_REMOTE
dvDGXSLOT_6 =			5002:6:DGX_REMOTE
dvDGXSLOT_7 =			5002:7:DGX_REMOTE
dvDGXSLOT_8 =			5002:8:DGX_REMOTE
dvDGXSLOT_9 =			5002:9:DGX_REMOTE
dvDGXSLOT_10 =			5002:10:DGX_REMOTE
dvDGXSLOT_11 =			5002:11:DGX_REMOTE
dvDGXSLOT_12 =			5002:12:DGX_REMOTE
dvDGXSLOT_13 =			5002:13:DGX_REMOTE
dvDGXSLOT_14 =			5002:14:DGX_REMOTE
dvDGXSLOT_15 =			5002:15:DGX_REMOTE
dvDGXSLOT_16 =			5002:16:DGX_REMOTE

vdvProjector_Left = 		33011:1:0 //Virtual Projector Left
vdvProjector_Right = 		33012:1:0 //Virtual Projector Right
vdvProjector_Center = 		33013:1:0 // Virtual Projector Center (Sony Laser



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//DVX Video Channels
VIDEO_PC_MAIN 			= 1 //DVI
VIDEO_PC_EXTENDED 		= 2 //DVI
VIDEO_VGA				= 3 //DVI
VIDEO_DOC_CAM			= 4 //DVI
VIDEO_HDMI			= 5 //HDMI
VIDEO_DVD				= 6 //HDMI.Not Used Anymore
VIDEO_HDMI_7			= 7 //Not Used
VIDEO_HDMI_8			= 8 //Not Used
VIDEO_TUNER			= 9 //Input 9 DxLink
VIDEO_MERSIVE			= 10 //Input 10 for Mersive
//DVX Output Channels..
OUT_DVX_LEFT			= 1 //Left Projector
OUT_DVX_RIGHT			= 3 //Right Projector
OUT_AUDIO_DVX			= 2

//Dvx Input Names
NAME_INPUT_1			= 'Desktop'
NAME_INPUT_2			= 'Dextop Ext'
NAME_INPUT_3			= 'Source VGA'
NAME_INPUT_4			= 'Doc Cam'
NAME_INPUT_5			= 'Source HDMI'
NAME_INPUT_6			= 'Blu Ray'
NAME_INPUT_7			= 'Not Used'
NAME_INPUT_8			= 'Not Used'
NAME_INPUT_9			= 'TV TUner'
NAME_INPUT_10			= 'Mersive'

(******DGX SWITCHING CHANNELS*****)

//DGX Inputs....
INPUT_DVX_LEFT			= 1
INPUT_DVX_RIGHT		= 2
INPUT_152_LEFT			= 3
INPUT_152_RIGHT		= 4
INPUT_AUX				= 5
INPUT_TUNER			= 9
INPUT_CAMERA_			= 10 //From SDI / HDMI Scaler / Converter
INPUT_MERSIVE			= 11
INPUT_SX80			= 12
INPUT_CAMERA_REAR_		= 13
INPUT_CAMERA_FRONT_	= 14
//DGX Outputs...
OUT_PROJECTOR_LEFT		= 1
OUT_PROJECTOR_RIGHT	= 2
OUT_PROJECTOR_CENTER	= 3
OUT_DOWNSTAGE_LEFT	= 5
OUT_DOWNSTAGE_RIGHT	= 6
OUT_DVX_9			= 9 //Routing TV Tuner to DVX
OUT_DVX_10			= 10 //Routing Mersive to DVX
OUT_CAPTURE			= 13 //Extron SMP
OUT_SX80_CONTENT		= 14
OUT_PREVIEW_MON		= 15 //Monitor Preview
OUT_CAMERA_FEED		= 16 //Camera Feed to DA (SX80 / Extron SMP

//DGX Input Names...
NAME_DGXIN_1			= 'DVX OUT 1'
NAME_DGXIN_2			= 'DVX OUT 3'
NAME_DGXIN_3			= '152 IN Left'
NAME_DGXIN_4			= '152 IN Right'
NAME_DGXIN_5			= 'Rear Input'
NAME_DGXIN_6			= 'Not Used'
NAME_DGXIN_7			= 'Not Used'
NAME_DGXIN_8			= 'Not Used'
NAME_DGXIN_9			= 'TV Tuner'
NAME_DGXIN_10			= 'Not Used'
NAME_DGXIN_11			= 'Mersive'
NAME_DGXIN_12			= 'SX80 View'

NAME_DGXIN_13			= 'Camera Rear'
NAME_DGXIN_14			= 'Camera Front'
NAME_DGXIN_15			= 'Not Used'
NAME_DGXIN_16			= 'Not Used'

//DGX Output Names..
NAME_DGXOUT_1				= 'Left Projector'
NAME_DGXOUT_2				= 'Right Projector'
NAME_DGXOUT_3				= 'Center Projector'
NAME_DGXOUT_4				= 'Rear Aux'

NAME_DGXOUT_5				= 'Down Stage Left'
NAME_DGXOUT_6				= 'Down Stage Right'
NAME_DGXOUT_7				= 'Not Used'
NAME_DGXOUT_8				= 'Not Used'

NAME_DGXOUT_9				= 'DVX IN 9'
NAME_DGXOUT_10			= 'DVX IN 10'
NAME_DGXOUT_11			= 'Not Used'
NAME_DGXOUT_12			= 'Not Used'

NAME_DGXOUT_13			= 'Extron SMP Content'
NAME_DGXOUT_14			= 'SX80 Content'
NAME_DGXOUT_15			= 'Monitor Preview'
NAME_DGXOUT_16			= 'Cameras Out'

BTN_CLASSROOM				= 50
BTN_OVERFLOW				= 51
MAX_INPUT					= 15
BTN_CAM_FRONT				= 141
BTN_CAM_REAR				= 142

//DGX Text Slots...
TXT_SLOT_1				= 301
TXT_SLOT_2				= 302
TXT_SLOT_3				= 303
TXT_SLOT_4				= 304
TXT_SLOT_5				= 305
TXT_SLOT_6				= 306
TXT_SLOT_7				= 307
TXT_SLOT_8				= 308
TXT_SLOT_9				= 309
TXT_SLOT_10				= 310
TXT_SLOT_11				= 311
TXT_SLOT_12				= 312
TXT_SLOT_13				= 313
TXT_SLOT_14				= 314
TXT_SLOT_15				= 315
TXT_SLOT_16				= 316

//Projector Common Feedback
POWER_CYCLE			= 9
POWER_ON				= 27
POWER_OFF			= 28
WARMING				= 253
COOLING				= 254
ON_LINE				= 251
POWER				= 255
BLANK				= 211

// Timeline
TL_FEEDBACK			= 1
TL_FLASH				= 2

ONE_SECOND			= 10 //may have to set to 1000
ONE_MINUTE			= 60*ONE_SECOND
ONE_HOUR				= 60*ONE_MINUTE
HALF_HOUR				= 30*ONE_MINUTE

SET_MUTE_ON			= 'ENABLE'
SET_MUTE_OFF			= 'DISABLE'
MAX_CHAR				= 11 //Text Initializer

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR nHelp[15] = '404-894-4669'
VOLATILE CHAR nRoomInfo[30] = 'CULC 144'

DEV vdvTP_Main [] = {dvTP_Main, dvTP_Booth }

VOLATILE INTEGER nSource_Left 
VOLATILE INTEGER nSource_Right
VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nCamera_
VOLATILE INTEGER nOverflowMode

VOLATILE INTEGER nProjector_Mute_Left
VOLATILE INTEGER nProjector_Mute_Right
VOLATILE INTEGER nProjector_Mute_Center

VOLATILE INTEGER nDualProjector_ //Mode
VOLATILE INTEGER nPop //Popup Tracking...
VOLATILE INTEGER nTPOnline
VOLATILE INTEGER cShareReady //??????
//DGX Stuff...
VOLATILE INTEGER nSource_Input
VOLATILE INTEGER nSource_Outputs

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000} 
VOLATILE INTEGER iFLASH


VOLATILE CHAR cPopup_Names[][16] =
{
    '_help me',
    '_microphones',
    '_volume',
    '_dvd',
    '_aux'
}
VOLATILE INTEGER nPopupBtns[] =
{
    1001, //Help...
    1002, //mics
    1003,  //volume
    1004,  //Combine Outside TVs...
    1005
}
VOLATILE INTEGER nMode_BTNS[] = 
{
    20, // Center Projector - Start
    21, // Dual
    23, // Exit to Start
    24  // Shutdown
}
VOLATILE INTEGER nLeft_Projector[] =
{
    1, //Power On Left
    2, //Power Off Left
    3  //Mute Projector Left
}
VOLATILE INTEGER nRight_Projector[] =
{
    101, //Power on Right
    102, //Power off Right
    103  //Mute Projector Right
}
VOLATILE INTEGER nCenter_Projector[] =
{
    201, //Power on Right
    202, //Power off Right
    203  //Mute Projector Right
}
VOLATILE INTEGER nVideoLeft[] = 
{
    11, //PC Left
    12, //PC Extended
    13, //VGA 
    14, //HDMI
    15, //Doc Cam
    16,  //Mersive
    17,  //Tuner
    18  //Codec Left 	
}
VOLATILE INTEGER nVideoRight[] = 
{
    111, //PC Left
    112, //PC Extended
    113, //VGA 
    114, //HDMI
    115, //Doc Cam
    116,  //Mersive
    117,  //Tuner  
    118  //Codec Right	
}

VOLATILE CHAR nSwitchInputNames[16][35] = 
{
    'DVX Out 1', //1
    'DVX Out 3', //2
    '152 In Left', //3
    '152 In Right', //4
    '144 Rear Aux', //5
    'Not Used', //6
    'Not Used', //7
    'Not Used', //8
    'TV Tuner', //9
    'Not Used', //10
    'Mersive', //11
    'Cisco SX80', //12
    'Camera Rear', //13
    'Camera Front', //14
    'Not Used', //15
    'Not Used' //16
}

#INCLUDE 'Biamp_Tesira'
#INCLUDE 'TVTuner'
#INCLUDE 'SX80_Connect'
//#INCLUDE 'Extron_Recorder'
//#INCLUDE '_SonyH900_Serial'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvIOs,nTimelineIO[1]]..[dvIOs,nTimelineIO[8]])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '22:00:00')
    {
	CALL 'Mode'('SHUTDOWN')
    }
    ELSE IF (TIME = '23:00:00')
    {
	CALL 'Mode'('SHUTDOWN')
    }
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = '06:00:00')
    {
	    REBOOT (dvMaster)
    }
}
DEFINE_FUNCTION fnMuteProjector(DEV cDevice, CHAR cState[MAX_CHAR])
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
DEFINE_FUNCTION fnProjectorPower(CHAR cVALUE[MAX_CHAR])
{
    SWITCH (cVALUE)
    {
	CASE 'LEFT ON':
	{
	    PULSE [vdvProjector_Left, POWER_ON] 
	}
	CASE 'LEFT OFF':
	{
	    PULSE [vdvProjector_Left, POWER_OFF]
	}
	CASE 'RIGHT ON':
	{
	    PULSE [vdvProjector_Right, POWER_ON]
	}
	CASE 'RIGHT OFF':
	{
	    PULSE [vdvProjector_Right, POWER_OFF]
	}
	CASE 'CENTER ON':
	{
	    PULSE [vdvProjector_Center, POWER_ON]
	}
	CASE 'CENTER OFF':
	{
	    PULSE [vdvProjector_Center, POWER_OFF]
	}
    }
}
DEFINE_FUNCTION fnClassRoutes(CHAR cROOM[MAX_INPUT])
{
    SWITCH (cROOM)
    {
	CASE 'CLASSROOM' :
	{
	    OFF [nOverflowMode]
	    SEND_COMMAND dvTP_Main, "'PAGE-SelectDual'" 
	    
	    //Biamp Stuff...
	    fnMuteOverFlow() 
	    
	    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
	    WAIT 10 fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
	    WAIT 20 fnDGXSwitchIn(INPUT_TUNER,OUT_DVX_9)
	    WAIT 30 fnDGXSwitchIn(INPUT_MERSIVE,OUT_DVX_10)
	    WAIT 40 fnDGXSwitchIn(INPUT_DVX_LEFT, OUT_CAPTURE) //Extron SMP Content
	    WAIT 50 fnDGXSwitchIn(INPUT_DVX_LEFT, OUT_SX80_CONTENT)
	    //WAIT 60 fnDGXSwitchIn(INPUT_CAMERA_, OUT_SX80_CAMERA)
	}
	CASE 'OVERFLOW' :
	{
	    ON [nOverflowMode]
	    
	    //SEND_COMMAND dvTP_Main, "'PAGE-SelectOverflow'" 
	    
	    //Biamp Stuff....
	    fnUnMuteOverflow()
	    
	    IF ([vdvProjector_Center, POWER]) //If its on...
	    {
		fnProjectorPower ('CENTER OFF') //Don't need it on
	    }
	    fnRouteDGXLeftProjector(INPUT_152_LEFT)

	    WAIT 20 
	    {
		fnRouteDGXRightProjector(INPUT_152_RIGHT)
	    }
	}
    }
}
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_DVX_LEFT)" //Get INput of 1
    WAIT 20 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_DVX_RIGHT)" //Get Input of 3
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-AUDIO,',ITOA(OUT_AUDIO_DVX)" //Get Input of Sound
}
DEFINE_CALL 'DVX INPUT SETUP' //Setup Input Names...
{
    SEND_COMMAND dvAVINPUT1, "'VIDIN_NAME-',NAME_INPUT_1"
    SEND_COMMAND dvAVINPUT2, "'VIDIN_NAME-',NAME_INPUT_2"
    SEND_COMMAND dvAVINPUT3, "'VIDIN_NAME-',NAME_INPUT_3"
    SEND_COMMAND dvAVINPUT4, "'VIDIN_NAME-',NAME_INPUT_4"
    SEND_COMMAND dvAVINPUT5, "'VIDIN_NAME-',NAME_INPUT_5"
    SEND_COMMAND dvAVINPUT6, "'VIDIN_NAME-',NAME_INPUT_6"
    SEND_COMMAND dvAVINPUT7, "'VIDIN_NAME-',NAME_INPUT_7"
    SEND_COMMAND dvAVINPUT8, "'VIDIN_NAME-',NAME_INPUT_8"
    SEND_COMMAND dvAVINPUT9, "'VIDIN_NAME-',NAME_INPUT_9"
    SEND_COMMAND dvAVINPUT10, "'VIDIN_NAME-',NAME_INPUT_10"
    
    WAIT 80
    {
	fnDVXPull()
    }
}
DEFINE_CALL 'DGX SLOT NAME'
{
    SEND_COMMAND dvDGXSLOT_1, "'VIDIN_NAME-',NAME_DGXIN_1"
    SEND_COMMAND dvDGXSLOT_2, "'VIDIN_NAME-',NAME_DGXIN_2"
    SEND_COMMAND dvDGXSLOT_3, "'VIDIN_NAME-',NAME_DGXIN_3"
    SEND_COMMAND dvDGXSLOT_4, "'VIDIN_NAME-',NAME_DGXIN_4"
    SEND_COMMAND dvDGXSLOT_5, "'VIDIN_NAME-',NAME_DGXIN_5"
    SEND_COMMAND dvDGXSLOT_6, "'VIDIN_NAME-',NAME_DGXIN_6"
    SEND_COMMAND dvDGXSLOT_7, "'VIDIN_NAME-',NAME_DGXIN_7"
    SEND_COMMAND dvDGXSLOT_8, "'VIDIN_NAME-',NAME_DGXIN_8"
    SEND_COMMAND dvDGXSLOT_9, "'VIDIN_NAME-',NAME_DGXIN_9"
    SEND_COMMAND dvDGXSLOT_10, "'VIDIN_NAME-',NAME_DGXIN_10"
    SEND_COMMAND dvDGXSLOT_11, "'VIDIN_NAME-',NAME_DGXIN_11"
    SEND_COMMAND dvDGXSLOT_12, "'VIDIN_NAME-',NAME_DGXIN_12"
    SEND_COMMAND dvDGXSLOT_13, "'VIDIN_NAME-',NAME_DGXIN_13"
    SEND_COMMAND dvDGXSLOT_14, "'VIDIN_NAME-',NAME_DGXIN_14"
    SEND_COMMAND dvDGXSLOT_15, "'VIDIN_NAME-',NAME_DGXIN_15"
    SEND_COMMAND dvDGXSLOT_16, "'VIDIN_NAME-',NAME_DGXIN_16"
    WAIT 30
    {
	SEND_COMMAND dvDGXSLOT_1, "'VIDOUT_NAME-',NAME_DGXOUT_1"
	SEND_COMMAND dvDGXSLOT_2, "'VIDOUT_NAME-',NAME_DGXOUT_2"
	SEND_COMMAND dvDGXSLOT_3, "'VIDOUT_NAME-',NAME_DGXOUT_3"
	SEND_COMMAND dvDGXSLOT_4, "'VIDOUT_NAME-',NAME_DGXOUT_4"
	SEND_COMMAND dvDGXSLOT_5, "'VIDOUT_NAME-',NAME_DGXOUT_5"
	SEND_COMMAND dvDGXSLOT_6, "'VIDOUT_NAME-',NAME_DGXOUT_6"
	SEND_COMMAND dvDGXSLOT_7, "'VIDOUT_NAME-',NAME_DGXOUT_7"
	SEND_COMMAND dvDGXSLOT_8, "'VIDOUT_NAME-',NAME_DGXOUT_8"
	SEND_COMMAND dvDGXSLOT_9, "'VIDOUT_NAME-',NAME_DGXOUT_9"
	SEND_COMMAND dvDGXSLOT_10, "'VIDOUT_NAME-',NAME_DGXOUT_10"
	SEND_COMMAND dvDGXSLOT_11, "'VIDOUT_NAME-',NAME_DGXOUT_11"
	SEND_COMMAND dvDGXSLOT_12, "'VIDOUT_NAME-',NAME_DGXOUT_12"
	SEND_COMMAND dvDGXSLOT_13, "'VIDOUT_NAME-',NAME_DGXOUT_13"
	SEND_COMMAND dvDGXSLOT_14, "'VIDOUT_NAME-',NAME_DGXOUT_14"
	SEND_COMMAND dvDGXSLOT_15, "'VIDOUT_NAME-',NAME_DGXOUT_15"
	SEND_COMMAND dvDGXSLOT_16, "'VIDOUT_NAME-',NAME_DGXOUT_16"
    }  
    WAIT 100
    {
	WAIT 10 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_LEFT)"
	WAIT 20 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_RIGHT)"
	WAIT 30 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_CENTER)"
	WAIT 40 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DOWNSTAGE_LEFT)"
	WAIT 50 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DOWNSTAGE_RIGHT)"
	WAIT 60 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DVX_9)"
	WAIT 70 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DVX_10)"
	//WAIT 80 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_CAPTURE)"
	//WAIT 90 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_SX80_CONTENT)"
	//WAIT 100 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PREVIEW_MON)"
	//WAIT 110 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_CAMERA_FEED)"
    }
} 
DEFINE_CALL 'Mode' (CHAR cValue[9])
{
    SWITCH(cValue)
    {
	CASE 'CENTER' : //20
	{
	    OFF [nDualProjector_]
	    fnRouteDVXRightOut (VIDEO_PC_EXTENDED) //Set as Confidence Monitor
	    fnClassRoutes('CLASSROOM')
	}
	CASE 'DUAL' : //21
	{
	    ON [nDualProjector_]
	    fnClassRoutes('CLASSROOM')
	}
	CASE 'START' : //23
	{
	    IF (nDualProjector_)
	    {
		fnProjectorPower ('LEFT OFF')
		    fnProjectorPower ('RIGHT OFF')
	    }
	    ELSE
	    {
		fnProjectorPower ('CENTER OFF')
	    }
	}
	CASE 'SHUTDOWN': //24
	{
	    fnProjectorPower ('LEFT OFF')
	    fnProjectorPower ('RIGHT OFF')
	    fnProjectorPower ('CENTER OFF')
	}
    }
}
DEFINE_FUNCTION fnRouteDVXLeftOut(INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_DVX_LEFT)"
}
DEFINE_FUNCTION fnRouteDVXRightOut(INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_DVX_RIGHT)"
}
DEFINE_FUNCTION fnRouteDVXAudio(INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(OUT_AUDIO_DVX)"
}
DEFINE_FUNCTION fnRouteDGXLeftProjector(INTEGER cIn)
{
    SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_LEFT),',',ITOA(OUT_PROJECTOR_CENTER)"
}
DEFINE_FUNCTION fnRouteDGXRightProjector(INTEGER cIn)
{
    SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_RIGHT)"
}
DEFINE_FUNCTION fnDGXSwitchIn(INTEGER cIn, INTEGER cOut)
{
    SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(cOut)"
}
                                                                      

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START

WAIT 250
{
    TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    }


(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Sony_FHZ700L' ProjLeft(vdvProjector_Left,dvProjector_Left);
DEFINE_MODULE 'Sony_FHZ700L' ProjRight(vdvProjector_Right,dvProjector_Right);
DEFINE_MODULE 'Sony_FHZ700L' ProjCenter(vdvProjector_Center,dvProjector_Center);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, nPopupBtns]
{
    PUSH :
    {
	SEND_COMMAND dvTP_Main, "'PPON-',cPopup_Names[GET_LAST(nPopupBtns)]"
	nPop = GET_LAST(nPopupBtns)
    }
}
BUTTON_EVENT [dvTP_Main,nMode_BTNS] //Starts and Ends
{
  PUSH:
  {
    STACK_VAR INTEGER nBtnIdx
    
    nBtnIdx = GET_LAST(nMode_BTNS)
	SWITCH(nBtnIdx)
	{
	    CASE 1: CALL 'Mode' ('CENTER')	    
	    CASE 2: CALL 'Mode' ('DUAL')
	    CASE 3: CALL 'Mode'('START')
	    CASE 4: CALL 'Mode'('SHUTDOWN')
	}          
  }
}
BUTTON_EVENT [vdvTP_Main, BTN_CLASSROOM]
BUTTON_EVENT [vdvTP_Main, BTN_OVERFLOW]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_CLASSROOM : fnClassRoutes('CLASSROOM')
	    CASE BTN_OVERFLOW : fnClassRoutes('OVERFLOW')
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nLeft_Projector] //Left Power & Mute...
{
    PUSH:
    {
	STACK_VAR INTEGER nProjLeftIdx
	
	nProjLeftIdx = GET_LAST (nLeft_Projector)
	SWITCH (nProjLeftIdx)
	{
	    CASE 1: fnProjectorPower ('LEFT ON')
	    CASE 2: fnProjectorPower ('LEFT OFF')
	    CASE 3: 
	    {
		IF (!nProjector_Mute_Left)
		{
		    fnMuteProjector(dvDxlink_Left, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvDxlink_Left, SET_MUTE_OFF)
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nRight_Projector] //Right Power & Mute...
{
    PUSH:
    {
	STACK_VAR INTEGER nProjRightIdx
	nProjRightIdx = GET_LAST (nRight_Projector)

	SWITCH (nProjRightIdx)
	{
	    CASE 1: fnProjectorPower ('RIGHT ON')
	    CASE 2: fnProjectorPower ('RIGHT OFF')
	    CASE 3: 
	    {
		IF (!nProjector_Mute_Right)
		{
		    fnMuteProjector(dvDxlink_Right, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvDxlink_Right, SET_MUTE_OFF)
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nCenter_Projector] //Power & Mute Center
{
    PUSH:
    {
	STACK_VAR INTEGER nProjCenterIdx
	
	nProjCenterIdx = GET_LAST (nCenter_Projector)
	SWITCH (nProjCenterIdx)
	{
	    CASE 1: fnProjectorPower ('CENTER ON')
	    CASE 2: fnProjectorPower ('CENTER OFF')
	    CASE 3: 
	    {
		IF (!nProjector_Mute_Center)
		{
		    fnMuteProjector(dvDxlink_Center, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvDxlink_Center, SET_MUTE_OFF)
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nVideoLeft] //Left Input Switching
{
    PUSH:
    {
	STACK_VAR INTEGER nVidLeftIdx
	nVidLeftIdx = GET_LAST (nVideoLeft)

	SWITCH (nVidLeftIdx)
	{
	    CASE 1: //PC Main
	    {
		fnRouteDVXLeftOut (VIDEO_PC_MAIN)
		fnRouteDVXAudio(VIDEO_PC_MAIN)
		WAIT 10 //Force DGX...
		{
		    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
		}
	    }
	    CASE 2: //PC Extended
	    {
		fnRouteDVXLeftOut (VIDEO_PC_EXTENDED)
		fnRouteDVXAudio(VIDEO_PC_MAIN)
		WAIT 10 //Force DGX...
		{
		    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
		}
	    }
	    CASE 3: //VGA
	    {
		fnRouteDVXLeftOut (VIDEO_VGA)
		fnRouteDVXAudio(VIDEO_VGA)
		WAIT 10 //Force DGX...
		{
		    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
		}
	    }
	    CASE 4: //HDMI Device
	    {
		fnRouteDVXLeftOut (VIDEO_HDMI)
		fnRouteDVXAudio(VIDEO_HDMI)
		WAIT 10 //Force DGX...
		{
		    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
		}
	    }
	    CASE 5: //Doc Cam
	    {
		fnRouteDVXLeftOut (VIDEO_DOC_CAM)
		WAIT 10 //Force DGX...
		{
		    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
		}
	    }
	    CASE 6: //Mersive...
	    {
		fnRouteDVXLeftOut (VIDEO_MERSIVE)
		fnRouteDVXAudio(VIDEO_MERSIVE)
		WAIT 10 //Force DGX...
		{
		    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
		    fnDGXSwitchIn(INPUT_MERSIVE,OUT_DVX_10) //Send to DVX to Receive Signal and Preview
		}
	    }
	    CASE 7: //Tuner
	    {
		fnRouteDVXLeftOut (VIDEO_TUNER)
		fnRouteDVXAudio(VIDEO_TUNER)
		WAIT 10
		{
		    fnRouteDGXLeftProjector(INPUT_DVX_LEFT)
		    fnDGXSwitchIn(INPUT_TUNER,OUT_DVX_9)
		}
	    }
	    CASE 8: //SX80
	    {
		fnRouteDGXLeftProjector(INPUT_SX80)
	    }
	}    
    }
}
BUTTON_EVENT [vdvTP_Main, nVideoRight] //Left Input Switching
{
    PUSH:
    {
	STACK_VAR INTEGER nVidRightIdx
	
	nVidRightIdx = GET_LAST (nVideoRight)
	SWITCH (nVidRightIdx)
	{
	    CASE 1: //PC Main
	    {
		fnRouteDVXRightOut (VIDEO_PC_MAIN)
		fnRouteDVXAudio(VIDEO_PC_MAIN)
		WAIT 10 //Force DGX Route on Right Projector...
		{
		    fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
		}

	    }
	    CASE 2: //PC Extended
	    {
		fnRouteDVXRightOut (VIDEO_PC_EXTENDED)
		fnRouteDVXAudio(VIDEO_PC_MAIN)
		WAIT 10 //Force DGX Route on Right Projector...
		{
		    fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
		}
	    }
	    CASE 3: //VGA
	    {
		fnRouteDVXRightOut (VIDEO_VGA)
		fnRouteDVXAudio(VIDEO_VGA)
		WAIT 10 //Force DGX Route on Right Projector...
		{
		    fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
		}
	    }
	    CASE 4: //HDMI Device
	    {
		fnRouteDVXRightOut (VIDEO_HDMI)
		fnRouteDVXAudio(VIDEO_HDMI)
		WAIT 10 //Force DGX Route on Right Projector...
		{
		    fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
		}
	    }
	    CASE 5: //Doc Cam
	    {
		fnRouteDVXRightOut (VIDEO_DOC_CAM)
		WAIT 10 //Force DGX Route on Right Projector...
		{
		    fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
		}
	    }
	    CASE 6: //Mersive
	    {
		fnRouteDVXRightOut (VIDEO_MERSIVE)
		fnRouteDVXAudio(VIDEO_MERSIVE)
		WAIT 10 //Force DGX Route on Right Projector...
		{
		    fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
		    fnDGXSwitchIn(INPUT_MERSIVE,OUT_DVX_10) //Force Just in Case...
		}
	    }
	    CASE 7: //Tuner
	    {
		fnRouteDVXRightOut (VIDEO_TUNER)
		fnRouteDVXAudio(VIDEO_TUNER)

		WAIT 10
		{
		    fnRouteDGXRightProjector(INPUT_DVX_RIGHT)
		    fnDGXSwitchIn(INPUT_TUNER,OUT_DVX_9)
		}
	    }
	    CASE 8: //SX 80
	    {
		fnRouteDGXRightProjector(INPUT_SX80) //Only needs to get to screen
	    }
	}    
    }
}
BUTTON_EVENT [dvTp_Main, 1006] //Global Close..
{
    PUSH:
    {
	SEND_COMMAND dvTP_Main, "'@PPX'"
	OFF [nPop]
    }
}
BUTTON_EVENT [vdvTP_Main, 61]
BUTTON_EVENT [vdvTP_Main, 62]
BUTTON_EVENT [vdvTP_Main, 63]
BUTTON_EVENT [vdvTP_Main, 64]
BUTTON_EVENT [vdvTP_Main, 65]
BUTTON_EVENT [vdvTP_Main, 66]
BUTTON_EVENT [vdvTP_Main, 67]
BUTTON_EVENT [vdvTP_Main, 68]
BUTTON_EVENT [vdvTP_Main, 69]
BUTTON_EVENT [vdvTP_Main, 70]
BUTTON_EVENT [vdvTP_Main, 71]
BUTTON_EVENT [vdvTP_Main, 72]
BUTTON_EVENT [vdvTP_Main, 73]
BUTTON_EVENT [vdvTP_Main, 74]
BUTTON_EVENT [vdvTP_Main, 75]
BUTTON_EVENT [vdvTP_Main, 76] //DGX Input Buttons (Manual Routing)...
{
    PUSH :
    {
	nSource_Input = BUTTON.INPUT.CHANNEL - 60
    }
}
BUTTON_EVENT [vdvTP_Main, 81]
BUTTON_EVENT [vdvTP_Main, 82]
BUTTON_EVENT [vdvTP_Main, 83]
BUTTON_EVENT [vdvTP_Main, 84]
BUTTON_EVENT [vdvTP_Main, 85]
BUTTON_EVENT [vdvTP_Main, 86]
BUTTON_EVENT [vdvTP_Main, 87]
BUTTON_EVENT [vdvTP_Main, 88]
BUTTON_EVENT [vdvTP_Main, 89]
BUTTON_EVENT [vdvTP_Main, 90]
BUTTON_EVENT [vdvTP_Main, 91]
BUTTON_EVENT [vdvTP_Main, 92]
BUTTON_EVENT [vdvTP_Main, 93]
BUTTON_EVENT [vdvTP_Main, 94]
BUTTON_EVENT [vdvTP_Main, 95]
BUTTON_EVENT [vdvTP_Main, 96] //DGX Output Buttons (Manual Routing)
{
    PUSH :
    {
	nSource_Outputs = BUTTON.INPUT.CHANNEL - 80
    
	fnDGXSwitchIn(nSource_Input, nSource_Outputs) //This makes the switch happen
	ON [vdvTP_Main, BUTTON.INPUT.CHANNEL]
	
	OFF [nSource_Outputs]
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main] 
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND dvTP_Main, "'ADBEEP'"
	SEND_COMMAND dvTp_Main, "'^TXT-100,0,',nRoomInfo"
	SEND_COMMAND dvTp_Main, "'^TXT-99,0,',nHelp"

	IF (nDualProjector_)
	{
	    SEND_COMMAND dvTp_Main, "'PAGE-SelectCenter'"

	}
	ELSE 
	{
	    SEND_COMMAND dvTp_Main, "'PAGE-Splash'"
	}
    }
    OFFLINE :
    {
	OFF [nTPOnline]
    }
}
DATA_EVENT [dvDGX] 
{
    ONLINE :
    {
	WAIT 250
	{
	    CALL 'DGX SLOT NAME'
	}
    }
    COMMAND :
    {
	INTEGER cSlot1
	INTEGER cSlot2
	INTEGER cSlot3
	INTEGER cSlot5
	INTEGER cSlot6
	INTEGER cSlot9
	INTEGER cSlot10
	INTEGER cSlot11
	INTEGER cSlot16
	
	LOCAL_VAR CHAR cDebug[5]
	LOCAL_VAR CHAR cMsg[5]
    
	CHAR cData[19] // [ SWITCH-LVIDEOI12O14 ]
	cData = DATA.TEXT
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cData,"'SWITCH-LVIDEOI'",1)): 
	    {
		REMOVE_STRING(cData,"'SWITCH-LVIDEOI'",1)
		
		cDebug = cData 
		cMsg = cData
		    IF (FIND_STRING(cMsg,"'O10'",1))  // 01 ~ 010
		    {
//			IF (LENGTH_STRING (cMsg) =5) //Must be Output 10! [ 1O10] This is the full string
//			{
			    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-3)
			    cSlot10 = ATOI(cMsg)
			
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_10),',0,',nSwitchInputNames[cSlot10]"
		    }
		    IF (FIND_STRING(cMsg,"'O1'",1)) //We can only be referencing Output 1 [ 1O1 ]
		    {
			
			    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
			    cSlot1 = ATOI(cMsg)
			    
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_1),',0,',nSwitchInputNames[cSlot1]"
			
		    }
    		    IF (FIND_STRING(cMsg,"'O16'",1))  
		    {

			    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-3)
			    cSlot16 = ATOI(cMsg)
			
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_16),',0,',nSwitchInputNames[cSlot16]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_PROJECTOR_RIGHT)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot2 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_2),',0,',nSwitchInputNames[cSlot2]"
		    }
		    IF (FIND_STRING(cData,"'O',ITOA(OUT_PROJECTOR_CENTER)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot3 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_3),',0,',nSwitchInputNames[cSlot3]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_DOWNSTAGE_LEFT)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot5 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_5),',0,',nSwitchInputNames[cSlot5]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_DOWNSTAGE_RIGHT)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot6 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_6),',0,',nSwitchInputNames[cSlot6]"
		    }
		    IF (FIND_STRING(cData,"'O',ITOA(OUT_DVX_9)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot9 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_9),',0,',nSwitchInputNames[cSlot9]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_DVX_10)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot10 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_10),',0,',nSwitchInputNames[cSlot10]"
		    }
		}
	}
    }
}
DATA_EVENT [dvDvxSwitcher] //DVX SWitcher Online / Offline Events
{
    ONLINE:
    {
	WAIT 80
	{
	    CALL 'DVX INPUT SETUP'
	}
    }
    COMMAND:
    {
	LOCAL_VAR CHAR cAudio[5]

	LOCAL_VAR CHAR cLeftDone[5]
	LOCAL_VAR CHAR cRightDone[5]
	
	CHAR cMsg[20]
	cMsg = DATA.TEXT
	
	SELECT
	{
	    //Left Source...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LVIDEOI'",1)): 
	    {
		
		REMOVE_STRING(cMsg,"'SWITCH-LVIDEOI'",1)
		
		IF(FIND_STRING(cMsg,"'O',ITOA(OUT_DVX_LEFT)",1))
		{
		    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    cLeftDone = cMsg
		    nSource_Left = ATOI(cLeftDone)
		}
		//Right Source...
		IF(FIND_STRING(cMsg,"'O',ITOA(OUT_DVX_RIGHT)",1))
		{
		    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    
		    cRightDone = cMsg
		    nSource_Right = ATOI(cRightDone)
		}
	    }
	    //Audio Feedback...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LAUDIOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LAUDIOI'",1)
		
		cAudio = cMsg
		cAudio = LEFT_STRING(cAudio,LENGTH_STRING(cAudio)-2)	
		
		nSource_Audio = ATOI(cAudio)
	    }
	}
    }
}
DATA_EVENT [dvDxlink_Left]
{
    ONLINE:
    {
	WAIT 50
	{
	    SEND_COMMAND data.device, "'?VIDOUT_MUTE'"
	}
    }
    COMMAND:
    {
    	LOCAL_VAR CHAR cTmp[8]
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsg,'VIDOUT_MUTE-',1)):
	    {
	    	REMOVE_STRING (cMsg,'VIDOUT_MUTE-',1)
		
		cTmp = cMsg
		SWITCH (cTmp)
		{
		   CASE 'ENABLE' :
		   {
			ON [nProjector_Mute_Left]
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [nProjector_Mute_Left]
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvDxlink_Right]
{
    ONLINE:
    {

	WAIT 50
	{
	    SEND_COMMAND data.device, "'?VIDOUT_MUTE'"
	}
    }
    COMMAND:
    {
    	LOCAL_VAR CHAR cTmp[8]
	CHAR cMsg[30]
	
	cMsg = DATA.TEXT
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsg,'VIDOUT_MUTE-',1)):
	    {
	    	REMOVE_STRING (cMsg,'VIDOUT_MUTE-',1)
		
		cTmp = cMsg
		SWITCH (cTmp)
		{
		   CASE 'ENABLE' :
		   {
			ON [nProjector_Mute_Right]
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [nProjector_Mute_Right]
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvDxlink_Center]
{
    ONLINE:
    {

	WAIT 50
	{
	    SEND_COMMAND dvDxlink_Center, "'?VIDOUT_MUTE'"
	}
    }
    COMMAND:
    {
    	LOCAL_VAR CHAR cTmp[8]
	CHAR cMsg[30]
	
	cMsg = DATA.TEXT
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsg,'VIDOUT_MUTE-',1)):
	    {
	    	REMOVE_STRING (cMsg,'VIDOUT_MUTE-',1)
		cTmp = cMsg
		SWITCH (cTmp)
		{
		   CASE 'ENABLE' :
		   {
			ON [nProjector_Mute_Center]
		   }
		   CASE 'DISABLE' :
	    	   {
		        OFF [nProjector_Mute_Center]
		    }
		}
	    }
	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_Left,ON_LINE] 
CHANNEL_EVENT [vdvProjector_Left,WARMING] 
CHANNEL_EVENT [vdvProjector_Left,COOLING] 
{
    ON:
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
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'" 
	    }
	}
    }
    OFF:
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
CHANNEL_EVENT [vdvProjector_Right,ON_LINE] 
CHANNEL_EVENT [vdvProjector_Right,WARMING] 
CHANNEL_EVENT [vdvProjector_Right,COOLING] 
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'" 
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'" 
	    }
	}
    }
    OFF:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'" 
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'" 
	    }
	}
    }
}
CHANNEL_EVENT [vdvProjector_Center,ON_LINE] 
CHANNEL_EVENT [vdvProjector_Center,WARMING] 
CHANNEL_EVENT [vdvProjector_Center,COOLING] 
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
	        SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP255'" 
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP30'" 
	    }
	}
    }
    OFF:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP30'" 
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP255'" 
	    }
	}
    }
}
	
DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}
TIMELINE_EVENT [TL_FEEDBACK] 
{
    fnKill()
    fnReboot()
    
    [vdvTP_Main, BTN_CLASSROOM] = !nOverflowMode
    [vdvTP_Main, BTN_OVERFLOW] = nOverflowMode
    
    // Left Video
    [vdvTP_Main,11] = nSource_Left = VIDEO_PC_MAIN
    [vdvTP_Main,12] = nSource_Left = VIDEO_PC_EXTENDED
    [vdvTP_Main,13] = nSource_Left = VIDEO_VGA
    [vdvTP_Main,14] = nSource_Left = VIDEO_HDMI
    [vdvTP_Main,15] = nSource_Left = VIDEO_DOC_CAM
    [vdvTP_Main,16] = nSource_Left = VIDEO_MERSIVE
    [vdvTP_Main,17] = nSource_Left = VIDEO_TUNER
    [vdvTP_Main,18] = nSource_Left = INPUT_SX80
    //Right Video
    [vdvTP_Main,111] = nSource_Right = VIDEO_PC_MAIN
    [vdvTP_Main,112] = nSource_Right = VIDEO_PC_EXTENDED
    [vdvTP_Main,113] = nSource_Right = VIDEO_VGA
    [vdvTP_Main,114] = nSource_Right = VIDEO_HDMI
    [vdvTP_Main,115] = nSource_Right = VIDEO_DOC_CAM
    [vdvTP_Main,116] = nSource_Right = VIDEO_MERSIVE
    [vdvTP_Main,117] = nSource_Right = VIDEO_TUNER
    [vdvTP_Main,118] = nSource_Right = INPUT_SX80
    //Center Video
    [vdvTP_Main,511] = nSource_Audio = VIDEO_PC_MAIN
    [vdvTP_Main,513] = nSource_Audio = VIDEO_VGA
    [vdvTP_Main,514] = nSource_Audio = VIDEO_HDMI
    [vdvTP_Main,516] = nSource_Audio = VIDEO_MERSIVE
    [vdvTP_Main,517] = nSource_Audio = VIDEO_TUNER
    
    //Left Projector
    [vdvTP_Main,1]	= [vdvProjector_Left,POWER] 
    [vdvTP_Main,2]	= ![vdvProjector_Left,POWER] 
    [vdvTP_Main,3]	= nProjector_Mute_Left
    [vdvTP_Main,601] 	= [vdvProjector_Left,ON_LINE] 
    
    IF ([vdvProjector_Left, WARMING])
    {
	[vdvTP_Main, 602] = iFLASH
    }
    ELSE IF ([vdvProjector_Left, COOLING])
    {
	[vdvTP_Main, 603] = iFLASH
    }
    ELSE
    {
	[vdvTP_Main, 602] = [vdvProjector_Left, WARMING]
	[vdvTP_Main, 603] = [vdvProjector_Left, COOLING]
    }
    //Righ Projector
    [vdvTP_Main, 101]		= [vdvProjector_Right, POWER]
    [vdvTP_Main, 102]		= ![vdvProjector_Right, POWER]
    [vdvTP_Main, 103]		= nProjector_Mute_Right
    [vdvTP_Main,611] 	=	 [vdvProjector_Left,ON_LINE] 
    
    IF ([vdvProjector_Right, WARMING])
    {
	[vdvTP_Main, 612] = iFLASH
    }
    ELSE IF ([vdvProjector_Right, COOLING])
    {
	[vdvTP_Main, 613] = iFLASH
    }
    ELSE
    {
	[vdvTP_Main, 612] = [vdvProjector_Right, WARMING]
	[vdvTP_Main, 613] = [vdvProjector_Right, COOLING]
    }
    //Center Projector
    [vdvTP_Main, 201]	= [vdvProjector_Center, POWER]
    [vdvTP_Main, 202]	= ![vdvProjector_Center, POWER]
    [vdvTP_Main, 203]	= nProjector_Mute_Center
    [vdvTP_Main,621] 	= [vdvProjector_Center,ON_LINE] 
    
    IF ([vdvProjector_Center, WARMING])
    {
	[vdvTP_Main, 622] = iFLASH
    }
    ELSE IF ([vdvProjector_Center, COOLING])
    {
	[vdvTP_Main, 623] = iFLASH
    }
    ELSE
    {
	[vdvTP_Main, 622] = [vdvProjector_Center, WARMING]
	[vdvTP_Main, 623] = [vdvProjector_Center, COOLING]
    }
    
    WAIT ONE_MINUTE //Periodic Mute Check ...
    {
	fnMuteCheck (dvDxlink_Center)
	WAIT 10 fnMuteCheck(dvDxlink_Left)
	WAIT 20 fnMuteCheck(dvDxlink_Right)
    }
}



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

