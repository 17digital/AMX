PROGRAM_NAME='Master'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 02/08/2019  AT: 06:38:33        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    Device: 00000
    Description: DVX-3255HD-T  Master
    Manufacturer: AMX LLC
    Version: v1.6.189
    Firmware ID: 0x049C
    Device ID: 0x01B5
    Serial Number: 190618GX16F0018
    IPv4 Address: 172.21.4.109
    MAC Address: 00:60:9f:9d:0e:89
    IPv6 Address: fe80::0260:9fff:fe9d:0e89
    
    Transmitter Rear ::: 00-60-9F-9C-4D-62 
    
   
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster = 				0:1:0 // dvxMaster
dvDvxSwitcher =			5002:1:0 //DVX Switcher [3255HD -T]

dvTP_Main =				10001:1:0 // MST-701i 

dvCamera_Front =			5001:1:0 //Camera Front
dvCamera_Rear =			5001:2:0 //Camera Rear

dvAVOUTPUT1 = 			5002:1:0 //Content Send to Codec + Monitor Left...
dvAVOUTPUT2 = 			5002:2:0 //Camera Send to Codec - Stays!
dvAVOUTPUT3 = 			5002:3:0 //Monitor Right...
dvAVOUTPUT4 = 			5002:4:0 //Camera(2) Send to Codec - Stays!

dvAUDIOIN_11 =			5002:11:0 //Input 11 from Polycom out

dvProgram =				5002:2:0 //Device for Proprogram Mixing!

dvVIDEOIN_1 =			5002:1:0 
dvVIDEOIN_2 =			5002:2:0 
dvVIDEOIN_3 =			5002:3:0 
dvVIDEOIN_4 =			5002:4:0 
dvVIDEOIN_5 =			5002:5:0 
dvVIDEOIN_6 =			5002:6:0 
dvVIDEOIN_7 =			5002:7:0 
dvVIDEOIN_8 =			5002:8:0 
dvVIDEOIN_9 =			5002:9:0 
dvVIDEOIN_10 =			5002:10:0

dvTableRear =				5401:7:0 //For Vid Input...

dvMonitor_Left =			6002:1:0 //
dvMonitor_dxLeft =			6001:6:0

dvMonitor_Right =			6001:1:0 //
dvMonitor_dxRight =		6002:6:0

vdvMonitor_Left =			35001:1:0 //Sony [Sony FW-85BZ0H] 
vdvMonitor_Right =			35002:1:0 //Sony [Sony FW-85BZ0H] 

//Define Touch Panel Type
#WARN 'Check correct Panel Type'
//#DEFINE G4PANEL
#DEFINE G5PANEL //Ex..MT-702, MT1002, MXT701

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED __COMMON_CONST__
#DEFINE __COMMON_CONST__
POWER						= 255;
TV_VOL_UP					= 24
TV_VOL_DN					= 25
POWER_ON					= 27
POWER_OFF					= 28
VOL_PRESET					= 138
VOL_MUTE					= 199
BLANK						= 211;
ON_LINE						= 251;
WARMING					= 253
COOLING					= 254
SOURCE_TV1					= 30;
SOURCE_VIDEO1				= 31;
SOURCE_VIDEO2				= 32;
#END_IF

#IF_NOT_DEFINED __COMMON_ASCII__
#DEFINE __COMMON_ASCII__
CHAR CR 					= $0D;
CHAR LF 					= $0A;
CHAR ESC					= $1B;
#END_IF

//DVX Video Channels
VIDEO_PC_MAIN 			= 1 
VIDEO_PC_EXTENDED 		= 2 
VIDEO_VGA				= 3 
VIDEO_CODEC_MAIN		= 6 
VIDEO_HDMI				= 5 
VIDEO_CODEC_EXT			= 4 
VIDEO_CAMERA_FRONT		= 7 
VIDEO_CAMERA_REAR		= 8 
VIDEO_TABLE_REAR		= 9 
VIDEO_DXLINK_2			= 40
//DVX Audio Channels
AUDIO_INPUT_11			= 11 //Not Used

OUTPUT_VOLUME			= 1
PROGRAM_MIX			= 41
MICROPHONE_MIX_1		= 42
MICROPHONE_MIX_2		= 43
MAX_LEVEL_OUT				= 85 //Output Audio Level (0-100)

OUT_TELEVISION_LEFT			= 1 //
OUT_TELEVISION_RIGHT			= 3
OUT_AV_BRIDGE				= 2 //
OUT_AUDIO_MIX				= 2

//Commong Feedback...
ONE_SECOND					= 10
ONE_MINUTE					= ONE_SECOND * 60
ONE_HOUR					= ONE_MINUTE * 60

TL_FEEDBACK				= 91;
TL_STATUS_L				= 92;
TL_STATUS_R				= 93
TL_BLANK_L				= 95;
TL_BLANK_R				= 96;
TL_SHUTDOWN			= 100
SET_RUN_TIME			= 10 //10 Second Startup/Shutdown..
SET_SHUT_TIME			= 60; //Total Time I'd like Shutdown time to last

//Address Here...
TXT_HELP				= 99
TXT_ROOM				= 100
TXT_CAMERA_PAGE		= 23
TXT_PRGM_ACTIVE			= 15

//Set DxLinks...
//Uncomment the Desired Scaling...
//#DEFINE AUTO
#DEFINE MANUAL 
//#DEFINE BYPASS

#IF_DEFINED AUTO
SET_SCALE					= 'AUTO'
SET_ASPECT					= 'STRETCH'
//SET_ASPECT					= 'MAINTAIN'
//SET_ASPECT					= 'ANAMORPHIC'
#END_IF

#IF_DEFINED MANUAL
SET_RESOLUTION			= '1920x1080,60'
SET_SCALE					= 'MANUAL'
SET_ASPECT				= 'STRETCH'
//SET_ASPECT				= 'MAINTAIN'
//SET_ASPECT				= 'ANAMORPHIC'
#END_IF

#IF_DEFINED BYPASS
SET_SCALE					= 'BYPASS'
SET_ASPECT					= 'STRETCH'
//SET_ASPECT					= 'MAINTAIN'
//SET_ASPECT					= 'ANAMORPHIC'
#END_IF

//Buttons...
BTN_PWR_ON_L			= 1
BTN_PWR_OFF_L			= 2

BTN_PC_MAIN_L			= 11
BTN_PC_EXT_L				= 12
BTN_VGA_L				= 13
BTN_HDMI_L				= 14
BTN_TABLE_L				= 15
BTN_CODEC_L				= 16

BTN_PWR_ON_R			= 101
BTN_PWR_OFF_R			= 102

BTN_PC_MAIN_R			= 111
BTN_PC_EXT_R			= 112
BTN_VGA_R				= 113
BTN_HDMI_R				= 114
BTN_TABLE_R				= 115
BTN_CODEC_R				= 116

BTN_AUDIO_PC			= 511
BTN_AUDIO_VGA			= 513
BTN_AUDIO_HDMI			= 514
BTN_AUDIO_TABLE			= 515

BTN_ONLINE_L			= 601
BTN_ONLINE_R			= 611

BTN_SET_NUMBER			= 1500
BTN_SET_LOCATION		= 1501
BTN_SET_ALL				= 1502

BTN_CAM_PWR				= 50
BTN_CAM_FRONT				= 51
BTN_CAM_REAR 				= 52 
BTN_CAMERA_POPUP			= 245;
BTN_PRVW_CAMERA			= 120;

#INCLUDE 'Vars' 

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _TVStruct
{
    INTEGER bOnline;
    INTEGER bPwr;
    INTEGER bSource;
    INTEGER bMute;
    INTEGER bWarming;
    CHAR bInput[15];
}
STRUCTURE _DVXMix
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
    SINTEGER bHold;
}
STRUCTURE _DVXInputs
{
    CHAR bName[31];
    CHAR bEdid[15];
}
STRUCTURE _DVXSwitcher 
{
    CHAR bOnline;
    CHAR bTpOnline;
    INTEGER bAudioSource;
    INTEGER bAVBSource;
    INTEGER bDxlinkLeft;
    INTEGER bDxLinkRight;
    INTEGER bDxLinkTable;
    _DVXMix bMix[LEVEL_COUNT];
    _DVXInputs bInput[DVX_INPUT_COUNT];
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _TVStruct TVInfo[TV_COUNT];
VOLATILE _DVXSwitcher bSwitcher;

VOLATILE SINTEGER nProgram_Level_Preset = -10;

VOLATILE LONG lTLFeedback[] = {500};
VOLATILE LONG lTLPwrStatus[] = {1000};
VOLATILE LONG lTLMuteStatus[] = {500};

VOLATILE DEV vdvTp_Main[] =
{
    dvTP_Main
}
VOLATILE INTEGER nVideoSources[] =
{
    VIDEO_PC_MAIN,			
    VIDEO_PC_EXTENDED,				
    VIDEO_VGA,
    VIDEO_HDMI,
    VIDEO_TABLE_REAR
}
VOLATILE INTEGER nVideoLeftBtns[] = 
{
    BTN_PC_MAIN_L,				
    BTN_PC_EXT_L,				
    BTN_VGA_L,	
    BTN_HDMI_L,
    BTN_TABLE_L				
}
VOLATILE INTEGER nVideoRightBtns[] = 
{
    BTN_PC_MAIN_R,				
    BTN_PC_EXT_R,				
    BTN_VGA_R,	
    BTN_HDMI_R,
    BTN_TABLE_R
}
VOLATILE CHAR nGveInputNames[5][31] =
{
    'PC MAIN',
    'PC-EXTENDED',
    'DOC CAM',
    'LAPTOP HDMI', //N/A
    'WI-FI VIDEO' 
}
VOLATILE CHAR nAudioSourceName[4][15] =
{
    'Desktop',
    'VGA Front',
    'HDMI Front',
    'Rear Table'
}
VOLATILE DEV dcDVXVideoSlots[] =
{
    dvVIDEOIN_1,
    dvVIDEOIN_2,
    dvVIDEOIN_3,
    dvVIDEOIN_4,
    dvVIDEOIN_5,
    dvVIDEOIN_6,
    dvVIDEOIN_7,
    dvVIDEOIN_8,
    dvVIDEOIN_9,
    dvVIDEOIN_10
}
VOLATILE INTEGER nCameraBtns[] =
{
    BTN_CAM_FRONT,
    BTN_CAM_REAR
};
VOLATILE CHAR nCameraPageTitles[3][30] =
{
    'Audience Camera',
    'Presenter Camera'
}
VOLATILE INTEGER nSourceCameraIn[] =
{
    VIDEO_CAMERA_FRONT,
    VIDEO_CAMERA_REAR
}


#INCLUDE 'Tesira_'
#INCLUDE 'readJson'
#INCLUDE 'SetMasterClock_'
#INCLUDE 'Vaddio_Connect'
#INCLUDE '_RMS_Inventory'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_CODEC_L])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_CODEC_R])
([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_TABLE])
([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main, BTN_PWR_OFF_L])
([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main, BTN_PWR_OFF_R])
([dvTP_Main, BTN_CAM_FRONT], [dvTP_Main, BTN_CAM_REAR])


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnDVXInputSetup() {

    bSwitcher.bInput[1].bName = 'Main Desktop'
    bSwitcher.bInput[2].bName ='Extend Desktop'
    bSwitcher.bInput[3].bName = 'Credenza VGA'
    bSwitcher.bInput[4].bName ='Not Used'
    bSwitcher.bInput[5].bName ='Credenza HDMI'
    bSwitcher.bInput[6].bName ='Not Used'
    bSwitcher.bInput[7].bName ='Camera Front'
    bSwitcher.bInput[8].bName ='Camera Rear'
    bSwitcher.bInput[9].bName ='Table Rear'
    bSwitcher.bInput[10].bName ='Not Used'
    
    bSwitcher.bInput[1].bEdid = '1280x720,60'
    bSwitcher.bInput[2].bEdid = '1280x720,60'
    bSwitcher.bInput[3].bEdid = '1280x720,60'
    bSwitcher.bInput[4].bEdid = '1280x720,60'
    bSwitcher.bInput[5].bEdid = '1920x1080,60'
    bSwitcher.bInput[6].bEdid = '1280x720,60'
    bSwitcher.bInput[7].bEdid = '1920x1080,60'
    bSwitcher.bInput[8].bEdid = '1920x1080,60'
    bSwitcher.bInput[9].bEdid = '1920x1080,60'
    bSwitcher.bInput[10].bEdid = '1920x1080,60'

}
DEFINE_FUNCTION fnLoadDVXVideoLabels()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop=1; cLoop<=(DVX_INPUT_COUNT); cLoop++) {
	    SEND_COMMAND dcDVXVideoSlots[cLoop], "'VIDIN_NAME-',bSwitcher.bInput[cLoop].bName"
    }
}
DEFINE_FUNCTION fnLoadDVXEdids()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=(DVX_INPUT_COUNT); cLoop++) {
	    SEND_COMMAND dcDVXVideoSlots[cLoop], "'VIDIN_PREF_EDID-',bSwitcher.bInput[cLoop].bEdid"
    }
}
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_TELEVISION_LEFT)" 
    WAIT 20 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_TELEVISION_RIGHT)"
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,',ITOA(OUT_AV_BRIDGE)"
    WAIT 40 SEND_COMMAND dvDvxSwitcher, "'?INPUT-AUDIO,',ITOA(OUT_AUDIO_MIX)"
}
DEFINE_FUNCTION fnSetAudioLevels()
{
    bSwitcher.bMix[1].bLevel = nProgram_Level_Preset;
    bSwitcher.bMix[2].bLevel = -100;
    bSwitcher.bMix[3].bLevel = -100;
    
    WAIT 10 SEND_LEVEL dvProgram, OUTPUT_VOLUME, MAX_LEVEL_OUT;
    WAIT 20 SEND_LEVEL dvProgram, PROGRAM_MIX, bSwitcher.bMix[1].bLevel;
    WAIT 30 SEND_LEVEL dvProgram, MICROPHONE_MIX_1,bSwitcher.bMix[2].bLevel;
    WAIT 40 SEND_LEVEL dvProgram, MICROPHONE_MIX_2,bSwitcher.bMix[3].bLevel;
}
DEFINE_CALL 'DVX INPUT SETUP' //Setup Input Names...
{
    fnDVXInputSetup();
    
    WAIT 20 {
		fnDVXPull();
    }
    WAIT 80 {
		fnSetAudioLevels()
    }
    WAIT 150 {
		fnLoadDVXEdids()
    }
    WAIT 250 'Network Traffic' {
    	SEND_COMMAND dvVIDEOIN_9, "'DXLINK_IN_ETH-auto'"
	    SEND_COMMAND dvVIDEOIN_10, "'DXLINK_IN_ETH-off'"
		SEND_COMMAND dvAVOUTPUT1, "'DXLINK_ETH-auto'"
		    SEND_COMMAND dvAVOUTPUT3, "'DXLINK_ETH-auto'"
    }
    WAIT 300 {
		fnLoadDVXVideoLabels()
    }
}
DEFINE_FUNCTION fnREBOOT() 
{
    STACK_VAR SINTEGER iHour, iMinute;
    STACK_VAR SINTEGER iDay;
    
    iMinute = TIME_TO_MINUTE(TIME); 
    iHour = TIME_TO_HOUR(TIME); 
    
    IF ((iHour == cInfo[ROOM_ID].bReset) && (iMinute == 0)) {
	    REBOOT (dvMaster) //Say it aint so...
    }
    ELSE IF ((iHour == cInfo[ROOM_ID].bHour) && (iMinute == cInfo[ROOM_ID].bMinute)) {
    
	fnKill();
    }
}
DEFINE_FUNCTION fnKill()
{
    IF (!TIMELINE_ACTIVE (TL_SHUTDOWN)) {
	TIMELINE_CREATE (TL_SHUTDOWN, lTLPwrStatus, LENGTH_ARRAY (lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
    }
}
DEFINE_FUNCTION fnRouteVideoLeft (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_TELEVISION_LEFT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXTENDED :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(OUT_AUDIO_MIX)"
	}
	DEFAULT :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(OUT_AUDIO_MIX)"
	}
    }
}
DEFINE_FUNCTION fnRouteVideoRight (INTEGER cIn)
{
    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(OUT_TELEVISION_RIGHT)"

    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXTENDED :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(OUT_AUDIO_MIX)"
	}
	DEFAULT :
	{
	    SEND_COMMAND dvDvxSwitcher, "'AI',ITOA(cIn),'O',ITOA(OUT_AUDIO_MIX)"
	}
    }
}
DEFINE_FUNCTION fnRouteSingleVideo(INTEGER cIn, INTEGER cOut) {

    SEND_COMMAND dvDvxSwitcher, "'VI',ITOA(cIn),'O',ITOA(cOut)"
}
DEFINE_FUNCTION fnSetScale(DEV cDev)
{
    WAIT 80
    {
      #IF_DEFINED AUTO 
      SEND_COMMAND cDev, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDev, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      #END_IF
	
      #IF_DEFINED MANUAL
      SEND_COMMAND cDev, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDev, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      WAIT 20
      {
	SEND_COMMAND cDev, "'VIDOUT_RES_REF-',SET_RESOLUTION" 
	}
      
      #END_IF
	
      #IF_DEFINED BYPASS
      SEND_COMMAND cDev, "'VIDOUT_SCALE-',SET_SCALE"
      SEND_COMMAND cDev, "'VIDOUT_ASPECT_RATIO-',SET_ASPECT"
      #END_IF
    }
}
DEFINE_FUNCTION fnToggleChannels()
{
    ON [vdvMonitor_Left, POWER]
	ON [vdvMonitor_Left, POWER]
	
	    OFF [vdvMonitor_Right, ON_LINE]
	OFF [vdvMonitor_Right, ON_LINE]
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [nBoot_]

WAIT 100
{
    TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,LENGTH_ARRAY(lTLFeedback),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	fnToggleChannels()
}

WAIT ONE_MINUTE
{
    OFF [nBoot_]
}

(***********************************************************)
(*                MODULES GOES BELOW                  *)
(***********************************************************)


DEFINE_MODULE 'Sony_FWD65X750D' MonitorLeft(vdvMonitor_Left, dvMonitor_Left);
DEFINE_MODULE 'Sony_FWD65X750D' MonitorRight(vdvMonitor_Right, dvMonitor_Right);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_L]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_L]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L : PULSE [vdvMonitor_Left, POWER_ON];
	    CASE BTN_PWR_OFF_L : PULSE [vdvMonitor_Left, POWER_OFF];
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_R]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_R]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R : PULSE [vdvMonitor_Right, POWER_ON];
	    CASE BTN_PWR_OFF_R : PULSE [vdvMonitor_Right, POWER_OFF];
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nVideoLeftBtns] //Video Source Left Buttons
{
    PUSH:
    {
	STACK_VAR INTEGER b; 
	    b = GET_LAST (nVideoLeftBtns)
		fnRouteVideoLeft(nVideoSources[b]);
    }
}
BUTTON_EVENT [vdvTP_Main, nVideoRightBtns] //Video Source Right Buttons
{
    PUSH:
    {
	STACK_VAR INTEGER b; 
	    b = GET_LAST (nVideoRightBtns)
		fnRouteVideoRight(nVideoSources[b]);
		
		nLivePreview_ = FALSE;
			[vdvTp_Main, BTN_PRVW_CAMERA] = nLivePreview_;
    }
}
BUTTON_EVENT [vdvTP_Main, nCameraBtns] //Rear
{
    PUSH :
    {
	cIndexCamera = GET_LAST (nCameraBtns);
	    TOTAL_OFF [vdvTP_Main, nPresetSelect]
		fnRouteSingleVideo(nSourceCameraIn[cIndexCamera], OUT_AV_BRIDGE);

		    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Set Correct Title
	    ON [vdvTP_Main, nCameraBtns[cIndexCamera]] //Set FB
	    
	IF (nLivePreview_ == TRUE) {
		fnRouteSingleVideo(nSourceCameraIn[cIndexCamera], OUT_TELEVISION_RIGHT);
	}
    }
}
BUTTON_EVENT [vdvTp_Main, BTN_PRVW_CAMERA]
{
    PUSH :
    {
	IF (nLivePreview_ == FALSE) {
		fnRouteSingleVideo(bSwitcher.bAVBSource, OUT_TELEVISION_RIGHT);
		    nLivePreview_ = TRUE;
			[vdvTp_Main, BTN_PRVW_CAMERA] = nLivePreview_;
	} ELSE {
	    fnRouteSingleVideo(nSource_Prev, OUT_TELEVISION_RIGHT);
		    nLivePreview_ = FALSE;
			[vdvTp_Main, BTN_PRVW_CAMERA] = nLivePreview_;
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_CAMERA_POPUP]
{
    PUSH :
    {
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Load Title
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main] //TouchPanel Online
{
    ONLINE:
    {
	#IF_DEFINED G4PANEL
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'" //Make Your Presence Known...
	#END_IF
	
	#IF_DEFINED G5PANEL 
	SEND_COMMAND DATA.DEVICE, "'^ADP'" //Make Your Presence Known...
	#END_IF
	
	bSwitcher.bTpOnline = TRUE;
	
	IF (nBoot_ == FALSE) {
		    fnToggleChannels();
	}
    }
    OFFLINE :
    {
	bSwitcher.bTpOnline = FALSE;
    }
}
DATA_EVENT [dvDvxSwitcher] //DVX SWitcher Online / Offline Events
{
    ONLINE:
    {
	SEND_STRING 0, "'DVX Switcher : Now Online!'"
	    bSwitcher.bOnline = TRUE;
	
	WAIT 80 {
		CALL 'DVX INPUT SETUP'
	}
    }
    OFFLINE :
    {
	bSwitcher.bOnline = FALSE;
    }
    COMMAND:
    {
	STACK_VAR CHAR cAudio[4];
	STACK_VAR CHAR cVideo[4];
	
	CHAR cMsg[20];
	cMsg = DATA.TEXT
	
	SELECT
	{
	    //Video Source Parsing...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LVIDEOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LVIDEOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_TELEVISION_LEFT)",1))
		{
		    TVInfo[1].bSource = ATOI (LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2));
		    
    		    SWITCH (TVInfo[1].bSource)
		    {
			CASE VIDEO_PC_MAIN : {
			    ON [vdvTP_MAIN, BTN_PC_MAIN_L]
				TVInfo[1].bInput = nGveInputNames[1];
			}
			CASE VIDEO_PC_EXTENDED : {
			    ON [vdvTP_MAIN, BTN_PC_EXT_L]
				TVInfo[1].bInput = nGveInputNames[2];
			}
			CASE VIDEO_VGA : {
			    ON [vdvTP_MAIN, BTN_VGA_L]
				TVInfo[1].bInput = nGveInputNames[4];
			}
			CASE VIDEO_TABLE_REAR : {
			    ON [vdvTP_MAIN, BTN_TABLE_L]
				TVInfo[1].bInput = nGveInputNames[4];
			}
			CASE VIDEO_HDMI : {
			    ON [vdvTP_MAIN, BTN_HDMI_L]
				TVInfo[1].bInput = nGveInputNames[4];
			}
		    }
		}
    		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_TELEVISION_RIGHT)",1))
		{
		   TVInfo[2].bSource = ATOI (LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2));
		    
    		    SWITCH (TVInfo[2].bSource)
		    {
			CASE VIDEO_PC_MAIN : {
			    ON [vdvTP_MAIN, BTN_PC_MAIN_R]
				TVInfo[2].bInput = nGveInputNames[1];
				    nSource_Prev = TVInfo[2].bSource;
			}
			CASE VIDEO_PC_EXTENDED : {
			    ON [vdvTP_MAIN, BTN_PC_EXT_R]
				TVInfo[2].bInput = nGveInputNames[2];
				    nSource_Prev = TVInfo[2].bSource;
			}
			CASE VIDEO_VGA : {
			    ON [vdvTP_MAIN, BTN_VGA_R]
				TVInfo[2].bInput = nGveInputNames[4];
				    nSource_Prev = TVInfo[2].bSource;
			}
			CASE VIDEO_TABLE_REAR : {
			    ON [vdvTP_MAIN, BTN_TABLE_R]
				TVInfo[2].bInput = nGveInputNames[4];
				    nSource_Prev = TVInfo[2].bSource;
			}
			CASE VIDEO_HDMI : {
			    ON [vdvTP_MAIN, BTN_HDMI_R]
				TVInfo[2].bInput = nGveInputNames[4];
				    nSource_Prev = TVInfo[2].bSource;
			}
		    }
		}
		IF (FIND_STRING(cMsg, "'O',ITOA(OUT_AV_BRIDGE)",1))
		{
		    bSwitcher.bAVBSource = ATOI(LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2));
		    
		    SWITCH (bSwitcher.bAVBSource)
		    {
			CASE VIDEO_CAMERA_FRONT : {
			    cIndexCamera = 1;
				[vdvTP_Main, BTN_CAM_PWR] = vaddioStruct[1].uOnline;
				    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]"
					ON [vdvTP_Main, BTN_CAM_FRONT]
			}
			CASE VIDEO_CAMERA_REAR : {
			    cIndexCamera = 2;
				[vdvTP_Main, BTN_CAM_PWR] = vaddioStruct[2].uOnline;
				    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]"
					ON [vdvTP_Main, BTN_CAM_REAR]
			}
			DEFAULT : { //Nothing routed so make this the default
				fnRouteSingleVideo(VIDEO_CAMERA_REAR, OUT_AV_BRIDGE);
			}
		    }
		}
	    }
	    //Audio Feedback...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LAUDIOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LAUDIOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_AUDIO_MIX)",1))
		{
		    bSwitcher.bAudioSource = ATOI(LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2));	
		    
		    SWITCH (bSwitcher.bAudioSource)
		    {
			CASE VIDEO_PC_MAIN : {
			    ON [vdvTP_Main, BTN_AUDIO_PC]
				SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_PRGM_ACTIVE),',0,',nAudioSourceName[1]"
			}
			CASE VIDEO_VGA : {
			    ON [vdvTP_Main, BTN_AUDIO_VGA]
				SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_PRGM_ACTIVE),',0,',nAudioSourceName[2]"
			}
			CASE VIDEO_HDMI : {
			    ON [vdvTP_Main, BTN_AUDIO_HDMI]
				SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_PRGM_ACTIVE),',0,',nAudioSourceName[3]"
			}
			CASE VIDEO_TABLE_REAR : {
			    ON [vdvTP_Main, BTN_AUDIO_TABLE]
				SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_PRGM_ACTIVE),',0,',nAudioSourceName[4]"
			}
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvMonitor_dxLeft] 
{
    ONLINE:
    {
	WAIT 80 { 
	    fnSetScale(dvMonitor_dxLeft)
		bSwitcher.bDxlinkLeft = TRUE;
	}
    }
    OFFLINE :
    {
	bSwitcher.bDxlinkLeft = FALSE;
    }
}
DATA_EVENT [dvMonitor_dxRight] 
{
    ONLINE:
    {
	WAIT 80 {
	    fnSetScale(dvMonitor_dxRight);
		bSwitcher.bDxlinkRight = TRUE;
	}
    }
    OFFLINE :
    {
	bSwitcher.bDxlinkRight = FALSE;
    }
}
DATA_EVENT [dvTableRear]
{
    ONLINE :
    {
	bSwitcher.bDxLinkTable = TRUE;
    }
    OFFLINE :
    {
	bSwitcher.bDxLinkTable = FALSE;
    }
}
DATA_EVENT [dvAVOUTPUT1]
DATA_EVENT [dvAVOUTPUT3]
{
    ONLINE :
    {
	WAIT 150 
	{
	    fnSetScale(dvAVOUTPUT1)
	    WAIT ONE_SECOND
	    {
		fnSetScale(dvAVOUTPUT3)
	    }
	}
    }
}
DATA_EVENT [vdvMonitor_Left]
{
    COMMAND :
    {
	STACK_VAR CHAR cGrabStatus[8];
	
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	
	IF (FIND_STRING (cMsg,'FBTELEVISION-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
		SEND_STRING 0, "'vdvMonitor_Left : Response: ',cMsg"
	    
	    cGrabStatus = cMsg;
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'PWRON':
		{
		    ON [vdvTP_Main, BTN_PWR_ON_L]
			TVInfo[1].bPwr = TRUE;
		}
		CASE 'PWROFF' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_L]
			TVInfo[1].bPwr = FALSE;
		}
		CASE 'ONLINE':
		{
		    SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_MAX)"
			TVInfo[1].bOnline = TRUE;
			    [vdvTP_Main, BTN_ONLINE_L] = TVInfo[1].bOnline;
		}
		CASE 'OFFLINE' :
		{
		    SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_LOW)"
			TVInfo[1].bOnline = FALSE;
			    [vdvTP_Main, BTN_ONLINE_L] = TVInfo[1].bOnline;
		}
	    }
	}
    }
}
DATA_EVENT [vdvMonitor_Right]
{
    COMMAND :
    {
	STACK_VAR CHAR cGrabStatus[8];
	
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	
	IF (FIND_STRING (cMsg,'FBTELEVISION-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
		SEND_STRING 0, "'vdvMonitor_Right : Response: ',cMsg"
	    
	    cGrabStatus = cMsg;
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'PWRON':
		{
		    ON [vdvTP_Main, BTN_PWR_ON_R]
			TVInfo[2].bPwr = TRUE;
		}
		CASE 'PWROFF' :
		{
		    ON [vdvTP_Main, BTN_PWR_OFF_R]
			TVInfo[2].bPwr = FALSE;
		}
		CASE 'ONLINE':
		{
		    SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_MAX)"
			TVInfo[2].bOnline = TRUE;
			    [vdvTP_Main, BTN_ONLINE_R] = TVInfo[2].bOnline;
		}
		CASE 'OFFLINE' :
		{
		    SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_LOW)"
			TVInfo[2].bOnline = FALSE;
			    [vdvTP_Main, BTN_ONLINE_R] = TVInfo[2].bOnline;
		}
	    }
	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvMonitor_Left, 0] 
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE POWER_ON :
	    {
		TVInfo[1].bWarming = TRUE;
	    }
	    CASE POWER_OFF :
	    {
		TVInfo[1].bWarming = FALSE;
	    }
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_MAX)"
		    ON [vdvTP_Main, BTN_ONLINE_L]
			TVInfo[1].bOnline = TRUE;
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		IF (!TIMELINE_ACTIVE(TL_STATUS_L)) {
			TIMELINE_CREATE (TL_STATUS_L, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		}
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_L]
		    TVInfo[1].bPwr = TRUE;
	    }
	}
    }
    OFF:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_LOW)"
		    OFF [vdvTP_Main, BTN_ONLINE_L]
			TVInfo[1].bOnline = FALSE;
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_L]
		    TVInfo[1].bPwr = FALSE;
	    }
	}
    }
}
CHANNEL_EVENT [vdvMonitor_Right, 0]
{
    ON:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE POWER_ON :
	    {
		TVInfo[2].bWarming = TRUE;
	    }
	    CASE POWER_OFF :
	    {
		TVInfo[2].bWarming = FALSE;
	    }
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_MAX)"
		    ON [vdvTP_Main, BTN_ONLINE_R]
			TVInfo[2].bOnline = TRUE;
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		IF (!TIMELINE_ACTIVE(TL_STATUS_R)) {
			TIMELINE_CREATE (TL_STATUS_R, lTLPwrStatus, LENGTH_ARRAY(lTLPwrStatus), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		}
	    }
    	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_R]
		    TVInfo[2].bPwr = TRUE;
	    }
	}
    }
    OFF:
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_LOW)"
		    OFF [vdvTP_Main, BTN_ONLINE_R]
			TVInfo[2].bOnline = FALSE;
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_R]
		    TVInfo[2].bPwr = FALSE;
	    }
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_STATUS_L]
{
    IF (TIMELINE.REPETITION < SET_RUN_TIME)
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_LOW)"
	    cLockOutLeft = TRUE;
	
	SWITCH (TVInfo[1].bWarming)
	{
	    CASE 1 : //Warming...
	    {
		[vdvTP_Main, 602] = ![vdvTP_Main, 602]
	    }
	    DEFAULT :
	    {
		[vdvTP_Main, 603] = ![vdvTP_Main, 603]
	    }
	}
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_MAX)"
	TIMELINE_KILL (TL_STATUS_L)
	    cLockOutLeft = FALSE;
		OFF [vdvTP_Main, 602]
		OFF [vdvTP_Main, 603]
    }
}
TIMELINE_EVENT [TL_STATUS_R]
{
    IF (TIMELINE.REPETITION < SET_RUN_TIME)
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_LOW)"
	    cLockoutRight = TRUE;
	
	SWITCH (TVInfo[2].bWarming)
	{
	    CASE 1 : //Warming...
	    {
		[vdvTP_Main, 612] = ![vdvTP_Main, 612]
	    }
	    DEFAULT :
	    {
		[vdvTP_Main, 613] = ![vdvTP_Main, 613]
	    }
	}
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_MAX)"
	TIMELINE_KILL (TL_STATUS_R)
	    cLockoutRight = FALSE;
		OFF [vdvTP_Main, 612]
		OFF [vdvTP_Main, 613]
    }
}
TIMELINE_EVENT [TL_SHUTDOWN]
{
    IF (TIMELINE.REPETITION < SET_SHUT_TIME) {
    
	LONG iSandwich;
	iSandwich = TIMELINE.REPETITION + 1;
	    SEND_STRING 0, "'Shutdown Timeline Running : ',ITOA(iSandwich),' of ',ITOA(SET_SHUT_TIME)"
	    
	SWITCH (iSandwich)
	{
	    CASE 1 : {
	    
		cLockOutLeft = TRUE;
		cLockOutRight = TRUE;
		    SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_OFF)"
			SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_OFF)"
	    }
	    CASE 2 : {
		IF (TVInfo[1].bPwr == TRUE) {
		    PULSE [vdvMonitor_Left, POWER_OFF];
		}
	    }
	    CASE 3 : {
	    
		IF (TVInfo[2].bPwr == TRUE) {
		    PULSE [vdvMonitor_Right, POWER_OFF];
		}
	    }
	    CASE 4 : {
		//Audio Preset
		    BREAK;
	    }
	    CASE 5 : {
	    
		fnRouteVideoLeft (VIDEO_PC_MAIN);
	    }
	    CASE 6 : {
		fnRouteVideoRight (VIDEO_PC_EXTENDED);

	    }
	}
    }
    ELSE {
		cLockOutLeft = FALSE;
		cLockOutRight = FALSE;
		    SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_L),'.',ITOA(BTN_PWR_OFF_L),',0,%OP',ITOA(SET_OP_MAX)"
			SEND_COMMAND vdvTP_Main, "'^BMF-',ITOA(BTN_PWR_ON_R),'.',ITOA(BTN_PWR_OFF_R),',0,%OP',ITOA(SET_OP_MAX)"
	TIMELINE_KILL(TL_SHUTDOWN);
    }
}
TIMELINE_EVENT[TL_FEEDBACK]
{
//    WAIT ONE_MINUTE {
//	    fnREBOOT();
//    }
    WAIT 1200 '2 Minutes' {
	fnDVXPull();
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

