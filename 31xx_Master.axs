PROGRAM_NAME='31xx_Master'

(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/22/2018  AT: 12:47:58        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    Default DX-RX Network Address...
    If DHCP...169.254.2.2
    If Static...192.168.1.2
    Set Dip Switches 1&3 On (only)
    Telent commands to setup...
    SET IP
    SET CONNECTION
    SET DEVICE
    REBOOT...
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster 		=		0:1:0	//DVX Master
dvTP_MAIN   	= 		10001:1:0
dvDvxSwitcher =			5002:1:0 //DVX Switcher

dvVIDEOIN_1   = 			5002:1:0 //DVI 1
dvVIDEOIN_2  = 			5002:2:0 //DVI 2
dvVIDEOIN_3   = 			5002:3:0 //DVI 3
dvVIDEOIN_4   = 			5002:4:0 //DVI 4
dvVIDEOIN_5   = 			5002:5:0 //HDMI 1
dvVIDEOIN_6   = 			5002:6:0 //HDMI 2
dvVIDEOIN_7  = 			5002:7:0 //HDMI 3
dvVIDEOIN_8   = 			5002:8:0 //HDMI 4
dvVIDEOIN_9  = 			5002:9:0 //DxLink 1
dvVIDEOIN_10  = 		5002:10:0 //DxLink 2

dvAUDIOIN_11 =			5002:11:0 //Analog Audio Input 11
dvAUDIOIN_12 =			5002:12:0 //Analog Audio Input 12
dvAUDIOIN_13 =			5002:13:0 //Analog Audio Input 13
dvAUDIOIN_14 =			5002:14:0 //Analog Audio Input 14

dvAVOUTPUT1 = 			5002:1:0 //DXLink + HDMI -- House Left -- AMP OUT AUDIO
dvAVOUTPUT2 = 			5002:2:0 //HDMI
dvAVOUTPUT3 = 			5002:3:0 //DXLink + HDMI -- House Right (if Dual Proj)
dvAVOUTPUT4 = 			5002:4:0 //HDMI

dvRS232_1 =			5001:1:0
dvRS232_2 =			5001:2:0
dvRS232_3 =			5001:3:0
dvRS232_4 =			5001:4:0
dvRS232_5 =			5001:5:0
dvRS232_6 =			5001:6:0

dvIR_1 =			5001:9:0
dvIR_2 =			5001:10:0
dvIR_3 =			5001:11:0
dvIR_4 =			5001:12:0
dvIR_5 =			5001:13:0
dvIR_6 =			5001:14:0
dvIR_7 =			5001:15:0
dvIR_8 =			5001:16:0

dvRelays =			5001:8:0 //Relays
dvIO =				5001:17:0 //IO's

vdvProjector_left = 		35010:1:0  // Duet Module for Left Projector
vdvProjector_right =		35011:1:0 // Duet Module for Right Projector

dvProjector_left 	=		6001:1:0 // Ties in Duet Module
dvDxlink_left		=	6001:6:0	//Communicate directly to DX-RX

dvProjector_right	=		6002:1:0 // Ties in Duet Modules
dvDxlink_right		=	6002:6:0	//Communicate directly to DX-RX

//vdvRMS =				41025:1:0 //RMS Adapter

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Clock Stuff...
CHAR TIME_IP[]				= '130.207.165.28'
CHAR TIME_SERVER[]			= 'ntp1.gatech.edu'
CHAR TIME_LOC[]			= 'NIST, Gatech, ATL'
CHAR TIME_ZONE[]			= 'UTC-05:00' //Eastern
INTEGER TIME_SYNC_PERIOD 	= 60 //1 hour

//System Stuff...
INTEGER MY_SYSTEM			= 1324

//Relays...
SCREEN_LEFT_UP				= 1
SCREEN_LEFT_DN				= 2
SCREEN_RIGHT_UP			= 3
SCREEN_RIGHT_DN			= 4

//Level Increments / Decrements...
Volume_Up_Single			= 1
Volume_Up_Multiple			= 3
Volume_Down_Single			= -1
Volume_Down_Multiple			= -3

//DVX Channels
VIDEO_PC_MAIN 				= 1 //DVI
VIDEO_PC_EXTENDED 			= 2 //DVI
VIDEO_VGA					= 3 //VGA
VIDEO_DOC_CAMERA			= 4 //DVI
VIDEO_HDMI_5				= 5 //HDMI
VIDEO_HDMI_6				= 6
VIDEO_HDMI_7				= 7 //HDMI
VIDEO_HDMI_8				= 8 //HDMI
VIDEO_DXLINK_9				= 9 //DxLink
VIDEO_DXLINK_10			= 10 //DxLink

AUDIO_INPUT_11				= 11 
AUDIO_INPUT_12				= 12 
AUDIO_INPUT_13				= 13 
AUDIO_INPUT_14				= 14 

OUT_PROJ_LEFT				= 1
OUT_PROJ_RIGHT				= 3
OUT_CAPTURE				= 2
OUT_AMP_MAIN				= 1

//Mix Levels...
OUTPUT_VOLUME				= 1 //Output 
PROGRAM_MIX				= 41
MICROPHONE_MIX_1			= 42 
MICROPHONE_MIX_2			= 43 

//Common Projector Channels..
POWER_CYCLE				= 9
POWER_ON					= 27
POWER_OFF				= 28
WARMING					= 253
COOLING					= 254
ON_LINE					= 251
POWER					= 255
BLANK					= 211

// Times
TL_FEEDBACK				= 1
TL_FLASH					= 2


ONE_SECOND				= 10 //may have to set to 1000
ONE_MINUTE				= 60*ONE_SECOND
ONE_HOUR					= 60*ONE_MINUTE

//Misc
CR 						= 13
LF 						= 10
MAX_LENGTH 				= 10

SET_MUTE_ON				= 'ENABLE'
SET_MUTE_OFF				= 'DISABLE'

//DVX Inputs...
VIDINPUT_1				= 'Desktop Main'
VIDINPUT_2				= 'Desktop Ext'
VIDINPUT_3				= 'Source VGA'
VIDINPUT_4				= 'Doc Camera'
VIDINPUT_5				= 'Source HDMI'
VIDINPUT_6				= 'Not Used'
VIDINPUT_7				= 'Not Used'
VIDINPUT_8				= 'Not Used'
VIDINPUT_9				= 'Not Used'
VIDINPUT_10				= 'Not Used'

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100
TXT_PROGRAM				= 31
TXT_MIC_1					= 32
TXT_MIC_2					= 33

//Set DxLinks...
//Uncomment the Desired Scaling...
#DEFINE AUTO
//#DEFINE MANUAL 
//#DEFINE BYPASS

#IF_DEFINED AUTO
SET_SCALE					= 'AUTO'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

#IF_DEFINED MANUAL
SET_RESOLUTION			= '1920x1080p,60'
SET_SCALE					= 'MANUAL'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

#IF_DEFINED BYPASS
SET_SCALE					= 'BYPASS'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF


BTN_CLOSE					= 1000

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR nHelp[15] = '404-894-4669'
VOLATILE CHAR nRoomInfo[30] = 'Room Here'

VOLATILE INTEGER nSourceLeft
VOLATILE INTEGER nSourceRight
VOLATILE INTEGER nSourceAudio

VOLATILE SINTEGER nProgram_Level
VOLATILE SINTEGER nProgram_Level_Preset = -40
VOLATILE INTEGER nProgram_Mute
VOLATILE SINTEGER nProgram_Hold

VOLATILE SINTEGER nMicrophone1_Level
VOLATILE SINTEGER nMicrophone1_Level_Preset = -50
VOLATILE INTEGER nMicrophone1_Mute
VOLATILE SINTEGER nMicrophone1_Hold

VOLATILE SINTEGER nMicrophone2_Level
VOLATILE SINTEGER nMicrophone2_Level_Preset = -50
VOLATILE INTEGER nMicrophone2_Mute
VOLATILE SINTEGER nMicrophone2_Hold

VOLATILE INTEGER nPop //Popup Tracking...
VOLATILE INTEGER nLockout
VOLATILE INTEGER nMute_left //Mute DxLink Left
VOLATILE INTEGER nMute_right //Mute DxLink Right
VOLATILE INTEGER nTPOnline

VOLATILE LONG lTLFeedback[] = {250}
VOLATILE LONG lTLFlash[] = {500}
VOLATILE INTEGER iFLASH //For Blinky Buttons

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE CHAR cPopup_Names[][16] =
{
    '_help me',
    '_volume',
    '_Phone',
    '_Camera',
    '_DocCam',
    '_lighting'
}
VOLATILE INTEGER nPopupBtns[] =
{
    1001, //Help...
    1002, //Volume
    1003,  //Phone
    1004,  //Camera
    1005, //DocCam
    1006  //Lighting
}
VOLATILE INTEGER nProjectorLeft[] = 
{
    1, //On
    2, //Off
    3, //Mute
    4, //Up
    5,  //Down
    
    11, //Mac Left
    12, //Mac Extended
    13, //VGA 
    14, //HDMI
    15,  //Cam Preview
    16  //Rear Plate..
}
VOLATILE INTEGER nProjectorRight[] = 
{
    101,
    102,
    103,
    104,
    105,

    //Video Sources..
    111, //Mac Left
    112, //Mac Ext
    113, //VGA
    114, //HDMI
    115,  //Cam
    116  //Rear Plate..
}
VOLATILE INTEGER nAudioBtns[] = 
{
    //Program...
    301, //Mute
    302, //Up
    303, //Down
    304, //Preset
    
    //Mic 1 (Wireless)
    305, //Mute
    306, //Up
    307, //Down
    308, //Preset
    
    //Mic 2 (Lectern)
    309,
    310,
    311,
    312
}

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSetClock()
{
	WAIT 100 CLKMGR_SET_CLK_SOURCE(CLKMGR_MODE_NETWORK)//1 
	WAIT 130 CLKMGR_SET_TIMEZONE(TIME_ZONE)
	WAIT 160 CLKMGR_SET_RESYNC_PERIOD(TIME_SYNC_PERIOD) 
	WAIT 190 CLKMGR_SET_DAYLIGHTSAVINGS_MODE(TRUE)
	WAIT 210 CLKMGR_ADD_USERDEFINED_TIMESERVER(TIME_IP, TIME_SERVER, TIME_LOC)
	WAIT 240 CLKMGR_SET_ACTIVE_TIMESERVER(TIME_IP) 
}
DEFINE_FUNCTION fnSCREEN(INTEGER cRelay) //Function Screen Up or Down
{
    PULSE [dvRelays, cRelay]
}
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJ_LEFT)" //Get INput of 1
    WAIT 20 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_PROJ_RIGHT)" //Get Input of 3
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-AUDIO,',ITOA(OUT_AMP_MAIN)" //Get Input of Sound
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '20:00:00')
    {
	fnPowerDisplays('LEFT OFF')
	fnPowerDisplays('RIGHT OFF')
    }
    ELSE IF (TIME = '22:30:00')
    {
	fnPowerDisplays('LEFT OFF')
	fnPowerDisplays('RIGHT OFF')
    }
}
DEFINE_FUNCTION fnPowerDisplays(CHAR cPWR[MAX_LENGTH])
{
    SWITCH (cPWR)
    {
	CASE 'LEFT ON':
	{
	    PULSE [vdvProjector_left, POWER_ON] 
	    fnSCREEN (SCREEN_LEFT_DN)
	}
	CASE 'LEFT OFF':
	{
	    PULSE [vdvProjector_left, POWER_OFF]
	    WAIT 30
	    {
		fnSCREEN(SCREEN_LEFT_UP)
	    }
	}
	CASE 'RIGHT ON':
	{
	    PULSE [vdvProjector_right, POWER_ON]
	    fnSCREEN (SCREEN_RIGHT_DN)
	}
	CASE 'RIGHT OFF':
	{
	    PULSE [vdvProjector_right, POWER_OFF]
	    WAIT 30
	    {
		fnSCREEN (SCREEN_RIGHT_UP)
	    }
	}
    }
}
DEFINE_CALL 'DVX INPUT SETUP' //Setup Input Names...
{
    SEND_COMMAND dvVIDEOIN_1, "'VIDIN_NAME-',VIDINPUT_1"
    SEND_COMMAND dvVIDEOIN_2, "'VIDIN_NAME-',VIDINPUT_2"
    SEND_COMMAND dvVIDEOIN_3, "'VIDIN_NAME-',VIDINPUT_3"
    SEND_COMMAND dvVIDEOIN_4, "'VIDIN_NAME-',VIDINPUT_4"
    SEND_COMMAND dvVIDEOIN_5, "'VIDIN_NAME-',VIDINPUT_5"
    SEND_COMMAND dvVIDEOIN_6, "'VIDIN_NAME-',VIDINPUT_6"
    SEND_COMMAND dvVIDEOIN_7, "'VIDIN_NAME-',VIDINPUT_7"
    SEND_COMMAND dvVIDEOIN_8, "'VIDIN_NAME-',VIDINPUT_8"
    SEND_COMMAND dvVIDEOIN_9, "'VIDIN_NAME-',VIDINPUT_9"
    SEND_COMMAND dvVIDEOIN_10, "'VIDIN_NAME-',VIDINPUT_10"
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = '06:00:00')
    {
	IF (!nTPOnline)
	{
	    REBOOT (dvMaster)
	}
    }
}
DEFINE_FUNCTION fnMuteProjector(DEV cDevice, CHAR cMuteState[MAX_LENGTH])
{
    SEND_COMMAND cDevice, "'VIDOUT_MUTE-',cMuteState"
    WAIT 5
    {
	SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
    }
}
DEFINE_FUNCTION fnMuteStatus(DEV cDevice)
{
    SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
}
DEFINE_CALL 'PROGRAM PRESET'
{
    SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level_Preset
}
DEFINE_CALL 'PROGRAM MUTE'
{
    IF (!nProgram_Mute) 
    {
	nProgram_Hold = nProgram_Level
	SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,-100
	
    }
    ELSE IF (nProgram_Hold = 0)
    {
	CALL 'PROGRAM PRESET'
    }
    ELSE
    {
	nProgram_Level = nProgram_Hold
	SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level
    }
}
DEFINE_CALL 'MIC 1 MUTE'
{
    IF (!nMicrophone1_Mute)
    {
	nMicrophone1_Hold = nMicrophone1_Level
	SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,-100
    }
    ELSE IF (nMicrophone1_Hold = 0)
    {
	CALL 'MIC 1 PRESET'
    }
    ELSE
    {
	nMicrophone1_Level = nMicrophone1_Hold
	SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,nMicrophone1_Level
    }
}
DEFINE_CALL 'MIC 1 PRESET'
{
    SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,nMicrophone1_Level_Preset
}
DEFINE_CALL 'MIC 2 MUTE'
{
    IF (!nMicrophone2_Mute)
    {
	nMicrophone2_Hold = nMicrophone2_Level
	SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,-100
    }
    ELSE IF (nMicrophone2_Hold = 0)
    {
	CALL 'MIC 2 PRESET'
    }
    ELSE
    {
	nMicrophone2_Level = nMicrophone2_Hold
	SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,nMicrophone2_Level
    }
}
DEFINE_CALL 'MIC 2 PRESET'
{
    SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,nMicrophone2_Level_Preset
}
DEFINE_FUNCTION fnRouteVideoLeft (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJ_LEFT)"
    nSourceLeft = cIn 
}
DEFINE_FUNCTION fnRouteVideoRight (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJ_RIGHT)"
    nSourceRight = cIn 
}
DEFINE_FUNCTION fnRouteAudio (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(OUT_AMP_MAIN)"
    nSourceAudio = cIn 
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SET_SYSTEM_NUMBER(MY_SYSTEM) //May not see this update until first reboot =)

TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);


WAIT 50
{
    fnSetClock()
}



(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

//DEFINE_MODULE 'Sharp_LC90LE657U' LeftMON(vdvProjector_left, dvProjector_left);
//DEFINE_MODULE 'Sharp_LC90LE657U' RightMON(vdvProjector_right, dvProjector_right);
//DEFINE_MODULE 'RmsNetLinxAdapter_dr4_0_0' md1RMSNetLinx(vdvRMS)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, nPopupBtns]
{
    PUSH :
    {
	SEND_COMMAND vdvTP_Main, "'PPON-',cPopup_Names[GET_LAST(nPopupBtns)]"
	nPop = GET_LAST(nPopupBtns)
    }
}
BUTTON_EVENT [vdvTp_Main,nProjectorLeft] //Projector Power / Muting
{
    PUSH:
    {
	STACK_VAR INTEGER nProjLeftIdx
	
	nProjLeftIdx = GET_LAST (nProjectorLeft)
	SWITCH (nProjLeftIdx)
	{
	    CASE 1: fnPowerDisplays ('LEFT ON')
	    CASE 2: fnPowerDisplays ('LEFT OFF')
	    CASE 3:
	    {
		IF (!nMute_left)
		{
		    fnMuteProjector(dvDxlink_left, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvDxlink_left, SET_MUTE_OFF)
		}
	    }
	    CASE 4: fnSCREEN(SCREEN_LEFT_UP)
	    CASE 5: fnSCREEN(SCREEN_LEFT_DN)

	    //Video Switching...
	    CASE 6: //PC MAIN LEFT
	    {
		fnRouteVideoLeft(VIDEO_PC_MAIN)
		fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 7: //PC EXTENDED LEFT
	    {
		fnRouteVideoLeft(VIDEO_PC_EXTENDED)
		fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 8: //VGA LEFT
	    {
		fnRouteVideoLeft(VIDEO_VGA)
		fnRouteAudio(VIDEO_VGA)
	    }
	    CASE 9: //HDMI LEFT
	    {
		fnRouteVideoLeft(VIDEO_HDMI_5)
		fnRouteAudio(VIDEO_HDMI_5)
	    }
	    CASE 10: //Doc Cam
	    {
		fnRouteVideoLeft(VIDEO_DOC_CAMERA)
	    }
	}
    }
}
BUTTON_EVENT [vdvTp_Main,nProjectorRight] //Projector Power / Muting
{
    PUSH:
    {
	STACK_VAR INTEGER nProjRightIdx
	nProjRightIdx = GET_LAST (nProjectorRight)

	SWITCH (nProjRightIdx)
	{
	    CASE 1: fnPowerDisplays('RIGHT ON')
	    CASE 2: fnPowerDisplays('RIGHT OFF')
	    CASE 3:
	    {
		IF (!nMute_right)
		{
		    fnMuteProjector(dvDxlink_right, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvDxlink_right, SET_MUTE_OFF)
		}
	    }
	    CASE 4: fnSCREEN(SCREEN_RIGHT_UP)
	    CASE 5: fnSCREEN(SCREEN_RIGHT_DN)
	    
	    CASE 6: //PC MAIN LEFT
	    {
		fnRouteVideoRight(VIDEO_PC_MAIN)
		fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 7: //PC EXTENDED LEFT
	    {
		fnRouteVideoRight(VIDEO_PC_EXTENDED)
		fnRouteAudio(VIDEO_PC_MAIN)
	    }
	    CASE 8: //VGA LEFT
	    {
		fnRouteVideoRight(VIDEO_VGA)
		fnRouteAudio(VIDEO_VGA)
	    }
	    CASE 9: //HDMI LEFT
	    {
		fnRouteVideoRight(VIDEO_HDMI_5)
		fnRouteAudio(VIDEO_HDMI_5)
	    }
	    CASE 10: //Doc Cam
	    {
		fnRouteVideoRight(VIDEO_DOC_CAMERA)
	    }
	}
    }
}
BUTTON_EVENT [vdvTp_Main, nAudioBtns] 
{
    PUSH:
    {
	STACK_VAR INTEGER nVolumeIdx
	
	    nVolumeIdx = GET_LAST (nAudioBtns)
	    SWITCH (nVolumeIdx)
	    {
		//Program...
		CASE 1: CALL 'PROGRAM MUTE'
		CASE 2: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Up_Single
		CASE 3: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Down_Single
		CASE 4: CALL 'PROGRAM PRESET'
		
		//Microphone 1...
		CASE 5: CALL 'MIC 1 MUTE'
		CASE 6: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,nMicrophone1_Level + Volume_Up_Single
		CASE 7: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,nMicrophone1_Level + Volume_Down_Single
		CASE 8: CALL 'MIC 1 PRESET'
		
		//Microphone 1...
		CASE 9: CALL 'MIC 2 MUTE'
		CASE 10: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,nMicrophone2_Level + Volume_Up_Single
		CASE 11: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,nMicrophone2_Level + Volume_Down_Single
		CASE 12: CALL 'MIC 2 PRESET'
	    }
    }
    
    HOLD [2,REPEAT]: 
    {
	STACK_VAR INTEGER nVolumeIdx
	
	    nVolumeIdx = GET_LAST (nAudioBtns)
	    SWITCH (nVolumeIdx)
	{
		CASE 2: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Up_Multiple
		CASE 3: SEND_LEVEL dvAVOUTPUT2,PROGRAM_MIX,nProgram_Level + Volume_Down_Multiple
		CASE 6: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,nMicrophone1_Level + Volume_Up_Multiple
		CASE 7: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_1,nMicrophone1_Level + Volume_Down_Multiple
		CASE 10: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,nMicrophone2_Level + Volume_Up_Multiple
		CASE 11: SEND_LEVEL dvAVOUTPUT2,MICROPHONE_MIX_2,nMicrophone2_Level + Volume_Down_Multiple
	}
    }
}
BUTTON_EVENT [vdvTp_Main, BTN_CLOSE] //Generic Close..
{
    PUSH:
    {
	SEND_COMMAND vdvTP_Main, "'@PPX'"
	TO [BUTTON.INPUT.CHANNEL]
    }
}

DEFINE_EVENT
LEVEL_EVENT [dvAVOUTPUT2,PROGRAM_MIX]
{
    nProgram_Level = LEVEL.VALUE
    SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PROGRAM),',0,',ITOA(nProgram_Level + 100),'%'"
    
    IF (nProgram_Level <= -100)
    {
	ON [nProgram_Mute]
	 SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PROGRAM),',0,Muted'" 
    }
    ELSE
    {
	OFF [nProgram_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_PROGRAM),',0,',ITOA(nProgram_Level + 100),'%'"
    }
}
LEVEL_EVENT [dvAVOUTPUT2,MICROPHONE_MIX_1]
{
    nMicrophone1_Level = LEVEL.VALUE
     SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nMicrophone1_Level + 100),'%'"
     
     IF (nMicrophone1_Level <= -100)
     {
	ON [nMicrophone1_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,Muted'"
    }
    ELSE
    {
	OFF [nMicrophone1_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_1),',0,',ITOA(nMicrophone1_Level + 100),'%'"
    }
}
LEVEL_EVENT [dvAVOUTPUT2,MICROPHONE_MIX_2]
{
    nMicrophone2_Level = LEVEL.VALUE
     SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_2),',0,',ITOA(nMicrophone2_Level + 100),'%'"
     
     IF (nMicrophone2_Level <= -100)
     {
	ON [nMicrophone2_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_2),',0,Muted'"
    }
    ELSE
    {
	OFF [nMicrophone2_Mute]
	SEND_COMMAND vdvTP_MAIN, "'^TXT-',ITOA(TXT_MIC_2),',0,',ITOA(nMicrophone2_Level + 100),'%'"
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_Left, ON_LINE]
CHANNEL_EVENT [vdvProjector_Left, WARMING]
CHANNEL_EVENT [vdvProjector_Left, COOLING]
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
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
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
CHANNEL_EVENT [vdvProjector_Right, ON_LINE]
CHANNEL_EVENT [vdvProjector_Right, WARMING]
CHANNEL_EVENT [vdvProjector_Right, COOLING]
{
    ON :
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
    OFF :
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

DEFINE_EVENT
DATA_EVENT [dvDvxSwitcher] 
{
    ONLINE:
    {
	WAIT 80
	{
	    CALL 'DVX INPUT SETUP'
	    WAIT 40
	    {
		fnDVXPull()
	    }
	}
    }
    COMMAND:
    {
	CHAR cTmp[20]
	cTmp = DATA.TEXT
	
	SELECT
	{
	    //Left Source...
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI1O1',1)): 
	    {
		nSourceLeft = VIDEO_PC_MAIN
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI2O1',1)):
	    {
		nSourceLeft = VIDEO_PC_EXTENDED
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI3O1',1)):
	    {
		nSourceLeft = VIDEO_VGA
		
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI4O1',1)):
	    {
		nSourceLeft = VIDEO_DOC_CAMERA
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI5O1',1)):
	    {
		nSourceLeft = VIDEO_HDMI_5
	    }
	    //Source Right
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI1O3',1)): 
	    {
		nSourceRight = VIDEO_PC_MAIN
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI2O3',1)):
	    {
		nSourceRight = VIDEO_PC_EXTENDED
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI3O3',1)):
	    {
		nSourceRight = VIDEO_VGA
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI4O3',1)):
	    {
		nSourceRight = VIDEO_DOC_CAMERA
	    }
	    ACTIVE (FIND_STRING(cTmp,'SWITCH-LVIDEOI5O3',1)):
	    {
		nSourceRight = VIDEO_HDMI_5
	    }
	    //Audio Feedback...
	    ACTIVE(FIND_STRING(cTmp,'SWITCH-LAUDIOI1O2',1)):
	    {
		nSourceAudio = VIDEO_PC_MAIN
	    }
	    ACTIVE(FIND_STRING(cTmp,'SWITCH-LAUDIOI3O2',1)):
	    {
		nSourceAudio = VIDEO_VGA
	    }
	    ACTIVE(FIND_STRING(cTmp,'SWITCH-LAUDIOI5O2',1)):
	    {
		nSourceAudio = VIDEO_HDMI_5
	    }
	}
    }
}
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoomInfo"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp"
    }
    OFFLINE :
    {
	OFF [nTPOnline]
    }
}
DATA_EVENT [dvDxlink_left]
{
    ONLINE:
    {
	#IF_DEFINED AUTO 
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	#IF_DEFINED MANUAL
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_RES_REF-',SET_RESOLUTION" 
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	#IF_DEFINED BYPASS
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	WAIT 50 
	{
	    SEND_COMMAND DATA.DEVICE, "'?VIDOUT_MUTE'"
	}
	
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMute_left]
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMute_left]
	    }
	}
    }
}
DATA_EVENT [dvDxlink_right]
{
    ONLINE:
    {
	#IF_DEFINED AUTO 
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	#IF_DEFINED MANUAL
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_RES_REF-',SET_RESOLUTION" 
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	#IF_DEFINED BYPASS
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_SCALE-',SET_SCALE"
	SEND_COMMAND DATA.DEVICE, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
	#END_IF
	
	WAIT 50 
	{
	    SEND_COMMAND DATA.DEVICE, "'?VIDOUT_MUTE'"
	}
    }
    COMMAND :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-ENABLE',1)):
	    {
		ON [nMute_right]
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'VIDOUT_MUTE-DISABLE',1)):
	    {
		OFF [nMute_right]
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
    // Left, 
    [vdvTP_MAIN,11] = nSourceLeft = VIDEO_PC_MAIN
    [vdvTP_MAIN,12] = nSourceLeft = VIDEO_PC_EXTENDED
    [vdvTP_MAIN,13] = nSourceLeft = VIDEO_VGA
    [vdvTP_MAIN,14] = nSourceLeft = VIDEO_HDMI_5
    [vdvTP_MAIN,15] = nSourceLeft = VIDEO_DOC_CAMERA
    
    [vdvTP_MAIN,111] = nSourceRight = VIDEO_PC_MAIN
    [vdvTP_MAIN,112] = nSourceRight = VIDEO_PC_EXTENDED
    [vdvTP_MAIN,113] = nSourceRight = VIDEO_VGA
    [vdvTP_MAIN,114] = nSourceRight = VIDEO_HDMI_5
    [vdvTP_MAIN,115] = nSourceRight = VIDEO_DOC_CAMERA
    
    [vdvTP_MAIN,511] = nSourceAudio = VIDEO_PC_MAIN
    [vdvTP_MAIN,513] = nSourceAudio = VIDEO_VGA
    [vdvTP_MAIN,514] = nSourceAudio = VIDEO_HDMI_5
        
    //Left Projector
    [vdvTP_MAIN,1]	= [vdvProjector_left,POWER]
    [vdvTP_MAIN,2]	= ![vdvProjector_left, POWER]
    [vdvTP_MAIN,3]	= nMute_left
    [vdvTP_MAIN, 601] = [vdvProjector_left, ON_LINE] 

    IF ([vdvProjector_left, WARMING])
    {
	[vdvTP_Main, 602] = iFLASH
    }
    ELSE IF ([vdvProjector_left, COOLING])
    {
	[vdvTP_Main, 603] = iFLASH
    }
    ELSE
    {
	[vdvTP_Main, 602] = [vdvProjector_left, WARMING]
	[vdvTP_Main, 603] = [vdvProjector_left, COOLING]
    }
    
    //Right Projector
    [vdvTP_MAIN,101] = [vdvProjector_right,POWER]
    [vdvTP_MAIN,102] = ![vdvProjector_right,POWER]
    [vdvTP_MAIN,103]	= nMute_right
    [vdvTP_MAIN, 611] = [vdvProjector_right, ON_LINE] 
    
    IF ([vdvProjector_right, WARMING])
    {
	[vdvTP_Main, 612] = iFLASH
    }
    ELSE IF ([vdvProjector_left, COOLING])
    {
	[vdvTP_Main, 613] = iFLASH
    }
    ELSE
    {
	[vdvTP_Main, 612] = [vdvProjector_right, WARMING]
	[vdvTP_Main, 613] = [vdvProjector_right, COOLING]
    }
    
    [vdvTP_Main, 301] = nProgram_Mute
    [vdvTP_Main, 305] = nMicrophone1_Mute
    [vdvTP_Main, 309] = nMicrophone2_Mute

    WAIT ONE_MINUTE
    {
	fnMuteStatus (dvDxlink_right)
	fnMuteStatus (dvDxlink_left)
    }
}

DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)


