PROGRAM_NAME='Master'
(***********************************************************)
(*  FILE CREATED ON: 05/18/2017  AT: 06:30:24              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/31/2020  AT: 11:41:38        *)
(***********************************************************)
(* System Type : 

    NetLinx     
    Master Type [ NI-3200 ]
    Need to add code for Black Magic..

    *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

DGX_CONN =			8090 //System


dvMaster =				0:1:0
dvDGXMaster =				0:1:DGX_CONN
dvTP_Main =			10001:1:0 

dvRS232_2 =			5001:2:0 //Tesira Top
dvRS232_3 =			5001:3:0 //Tesira Bottom (Main Connections)
dvRS232_4 =			5001:4:0 //Tesira DL
dvRS232_5 =			5001:5:0 //Extron SMP 301
dvRS232_6 =			5001:6:0 //Not Used
dvRS232_7 =			5001:7:0 //Not Used
dvRS232_8 =			5001:8:0 //Not used

dvIR_1 =				5001:11:0
dvIR_2 =				5001:12:0
dvIR_3 =				5001:13:0
dvIR_4 =				5001:14:0
dvIR_5 =				5001:15:0
dvIR_6 =				5001:16:0
dvIR_7 =				5001:17:0
dvIR_8 =				5001:18:0
                                         
dvRelays =				5001:21:0 //
dvIOs =				5001:22:0 //

dvDGX =				5002:1:DGX_CONN

dvVIDEOIN_1   = 			5002:1:DGX_CONN 
dvVIDEOIN_2   = 			5002:2:DGX_CONN 
dvVIDEOIN_3   = 			5002:3:DGX_CONN 
dvVIDEOIN_4   = 			5002:4:DGX_CONN 
dvVIDEOIN_5   = 			5002:5:DGX_CONN 
dvVIDEOIN_6  = 			5002:6:DGX_CONN 
dvVIDEOIN_7  = 			5002:7:DGX_CONN 
dvVIDEOIN_8  = 			5002:8:DGX_CONN 
dvVIDEOIN_9   = 			5002:9:DGX_CONN //
dvVIDEOIN_10  = 			5002:10:DGX_CONN //
dvVIDEOIN_11 =			5002:11:DGX_CONN //
dvVIDEOIN_12 =			5002:12:DGX_CONN //
dvVIDEOIN_13 =			5002:13:DGX_CONN //Not Used
dvVIDEOIN_14 =			5002:14:DGX_CONN //Not Used
dvVIDEOIN_15 =			5002:15:DGX_CONN //Not Used
dvVIDEOIN_16 =			5002:16:DGX_CONN //Not Used

dvAUDIOUT_17 =			5002:17:DGX_CONN //Main Audio Out
dvAUDIOUT_18 =			5002:18:DGX_CONN
dvAUDIOUT_19 =			5002:19:DGX_CONN
dvAUDIOUT_20 =			5002:20:DGX_CONN
dvAUDIOUT_21 =			5002:21:DGX_CONN
dvAUDIOUT_22 =			5002:22:DGX_CONN
dvAUDIOUT_23 =			5002:23:DGX_CONN
dvAUDIOUT_24 =			5002:24:DGX_CONN

dvProjector_Left =			46001:1:DGX_CONN
dvProjector_dxLeft =		46001:6:DGX_CONN

dvProjector_Right =		46002:1:DGX_CONN
dvProjector_dxRight =		46002:6:DGX_CONN

dvProjector_Rear =		46003:1:DGX_CONN
dvProjector_dxRear =		46003:6:DGX_CONN

vdvProjector_Left =		35011:1:0
vdvProjector_Right =		35012:1:0
vdvProjector_Rear =		35013:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//TP Addresses
TXT_HELP				= 99
TXT_ROOM				= 100
MY_ROOM =				'GLCC 225'
MY_HELP_PHONE				= '404-894-4669'

ONE_SECOND			= 10 //may have to set to 1000
ONE_MINUTE			= 60*ONE_SECOND
ONE_HOUR				= 60*ONE_MINUTE

//Misc
CR 					= 13 //Carage Returen
LF 					= 10 //Line Feed...
TL_FEEDBACK			= 1
TL_FLASH			= 2
TIME_REBOOT				= '06:00:00'
TIME_KILL					= '22:00:00'

//Screen Relays...
UP_LEFT				= 1
DN_LEFT				= 2
UP_RIGHT				= 3
DN_RIGHT				= 4
UP_REAR				= 5
DN_REAR				= 6

//Common Feedback...
POWER_CYCLE			= 9
POWER_ON			= 27
POWER_OFF			= 28
WARMING				= 253
COOLING				= 254
ON_LINE				= 251
POWER				= 255
BLANK					= 211


//DGX Routing Numbers...
VIDEO_PC_MAIN			= 1
VIDEO_PC_EXT				= 2
VIDEO_EXTERNAL			= 3
VIDEO_DOC_CAM			= 4
VIDEO_IN_FLOOR			= 5
VIDEO_DL_1				= 13 //DL In 1
VIDEO_DL_2				= 14 //DL In 2
VIDEO_DL_3				= 15 //DL In 3
VIDEO_MERSIVE			= 9 //Solstice...
VIDEO_RECORD				= 11 //Extron Input for Preview

OUT_PROJECTOR_LEFT			= 1
OUT_PROJECTOR_RIGHT			= 2
OUT_TELEVISION_REAR				= 3
OUT_LECTERN_MON_LEFT			= 5
OUT_LECTERN_MON_RIGHT			= 6
OUT_DL_PREV_1			= 10 //DL Send
OUT_DL_PREV_2			= 11//DL Send 2
OUT_REC_CONTENT		= 9

AUDIO_OUT_MAIN		= 17 

SET_MUTE_ON			= 'ENABLE'
SET_MUTE_OFF			= 'DISABLE'

//Buttons...
BTN_PWR_ON_L				= 1
BTN_PWR_OFF_L				= 2
BTN_MUTE_PROJ_L			= 3

BTN_PC_MAIN_L				= 11
BTN_PC_EXT_L				= 12
BTN_EXTERNAL_L				= 13
BTN_DOC_CAM_L				= 14
BTN_MERSIVE_L				= 15

BTN_PWR_ON_R				= 101
BTN_PWR_OFF_R				= 102
BTN_MUTE_PROJ_R			= 103

BTN_PC_MAIN_R				= 111
BTN_PC_EXT_R				= 112
BTN_EXTERNAL_R				= 113
BTN_DOC_CAM_R				= 114
BTN_MERSIVE_R				= 115

BTN_PREVIEW_EXT			= 117
BTN_PREVIEW_REC			= 118

BTN_PWR_ON_REAR				= 201
BTN_PWR_OFF_REAR			= 202
BTN_MUTE_PROJ_REAR			= 203
BTN_FOLLOW_LEFT				= 211
BTN_FOLLOW_NOTES			= 212

BTN_AUDIO_PC				= 511
BTN_AUDIO_LECTERN			= 513
BTN_AUDIO_MERSIVE			= 515

BTN_ONLINE_L				= 601
BTN_WARMING_L				= 602
BTN_COOLING_L				= 603

BTN_ONLINE_R				= 611
BTN_WARMING_R				= 612
BTN_COOLING_R				= 613

BTN_ONLINE_REAR				= 621

BTN_TECH_PAGE				= 999
BTN_REBOOT_DGX				= 888

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE INTEGER nSource_Left  
VOLATILE INTEGER nSource_Right
VOLATILE INTEGER nSource_Rear
VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nRearFollowLeft
VOLATILE INTEGER nTPOnline
VOLATILE INTEGER nDGXOnline

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000}
VOLATILE INTEGER iFlash

VOLATILE INTEGER nVideoSources[] =
{
    VIDEO_PC_MAIN,
    VIDEO_PC_EXT,
    VIDEO_EXTERNAL,
    VIDEO_DOC_CAM,
    VIDEO_MERSIVE
}
VOLATILE INTEGER nProjectorLeftVidBtns[] =
{
    BTN_PC_MAIN_L,
    BTN_PC_EXT_L,
    BTN_EXTERNAL_L,
    BTN_DOC_CAM_L,
    BTN_MERSIVE_L
}
VOLATILE INTEGER nProjectorRightVidBtns[] =
{
    BTN_PC_MAIN_R,
    BTN_PC_EXT_R,
    BTN_EXTERNAL_R,
    BTN_DOC_CAM_R,
    BTN_MERSIVE_R
}
VOLATILE CHAR nDgxInputNames[16][31] =
{
    'Desktop Main',
    'Desktop Ext',
    'Lectern',
    'Doc Cam',
    'Floor Input',
    'Not Used',
    'Not Used',
    'Not Used',
    'Mersive POD', //9
    'Not Used',
    'Extron SMP',
    'Not Used',
    'DL Feed 1',
    'DL Feed 2',
    'DL Feed 3',
    'Not Used'
}
VOLATILE CHAR nDgxOutputNames[16][31] =
{
    'Projector Left',
    'Projector Right',
    'Projector Rear',
    'Not Used',
    'Monitor Left',
    'Monitor Right',
    'Not Used',
    'Not Used',
    'SMP Content',
    'TO DL 1',
    'TO DL 2',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used'
}
VOLATILE CHAR nDgxAudioOutName[8][31] =
{
    'Audio Mix Out',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used'
}
VOLATILE DEV dcDGXVideoSlots[] =
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
    dvVIDEOIN_10,
    dvVIDEOIN_11,
    dvVIDEOIN_12,
    dvVIDEOIN_13,
    dvVIDEOIN_14,
    dvVIDEOIN_15,
    dvVIDEOIN_16
}
VOLATILE DEV dcDGXAudioSlots[] =
{
    dvAUDIOUT_17,
    dvAUDIOUT_18,
    dvAUDIOUT_19,
    dvAUDIOUT_20,
    dvAUDIOUT_21,
    dvAUDIOUT_22,
    dvAUDIOUT_23,
    dvAUDIOUT_24
}

#INCLUDE 'Tesira_Phone2'
#INCLUDE 'Extron_Recorder'
#INCLUDE 'PanasonicCameras'
#INCLUDE 'DGX_Routing'

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PWR_ON_L],[dvTP_Main, BTN_PWR_OFF_L])
([dvTP_Main, BTN_PC_MAIN_L]..[dvTP_Main, BTN_MERSIVE_L])

([dvTP_Main, BTN_PWR_ON_R],[dvTP_Main, BTN_PWR_OFF_R])
([dvTP_Main, BTN_PC_MAIN_R]..[dvTP_Main, BTN_MERSIVE_R])

([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_MERSIVE])

([dvTP_Main, BTN_PWR_ON_REAR],[dvTP_Main, BTN_PWR_OFF_REAR])
([dvTP_Main, BTN_PREVIEW_EXT],[dvTP_Main, BTN_PREVIEW_REC])

([dvTP_Main, BTN_FOLLOW_LEFT],[dvTP_Main, BTN_FOLLOW_NOTES])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnRelayDirection(INTEGER cDirection)
{
    PULSE [dvRelays, cDirection]
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = TIME_REBOOT)
    {
	IF (!nTPOnline)
	{
	    REBOOT (dvMaster)
	}
    }
}
DEFINE_FUNCTION fnDGXPull()
{
    WAIT 10 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_LECTERN_MON_LEFT)" 
    WAIT 20 SEND_COMMAND dvDGX, "'?INPUT-VIDEO,',ITOA(OUT_LECTERN_MON_RIGHT)" 
    WAIT 30 SEND_COMMAND dvDGX, "'?INPUT-AUDIO,',ITOA(AUDIO_OUT_MAIN)" 
}
DEFINE_FUNCTION fnLoadDGXVideoLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXVideoSlots); cLoop++)
    {
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDIN_NAME-',nDgxInputNames[cLoop]"
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDOUT_NAME-',nDgxOutputNames[cLoop]"
    }
}
DEFINE_FUNCTION fnLoadDGXAudioLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXAudioSlots); cLoop++)
    {
	SEND_COMMAND dcDGXAudioSlots[cLoop], "'VIDOUT_NAME-',nDgxAudioOutName[cLoop]"
    }
}
DEFINE_CALL 'DGX NAMING'
{
    fnDGXPull()
    
    WAIT 120
    {
	fnLoadDGXAudioLabels()
    }
    WAIT 180
    {
	fnLoadDGXVideoLabels()
    }
}
DEFINE_FUNCTION fnRouteVideoLeft(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_LEFT),',',ITOA(OUT_LECTERN_MON_LEFT),',',ITOA(OUT_REC_CONTENT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
    }
    IF (nRearFollowLeft)
    {
	WAIT 10
	{
	    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TELEVISION_REAR)"
	}
    }
    WAIT 20
    {
	    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL_PREV_1)"
    }
}
DEFINE_FUNCTION fnRouteVideoRight(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_PROJECTOR_RIGHT),',',ITOA(OUT_LECTERN_MON_RIGHT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_MAIN :
	CASE VIDEO_PC_EXT :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(VIDEO_PC_MAIN),'O',ITOA(AUDIO_OUT_MAIN)"
	}
	CASE VIDEO_EXTERNAL :
	CASE VIDEO_MERSIVE :
	{
	    SEND_COMMAND dvDGX, "'AI',ITOA(cIn),'O',ITOA(AUDIO_OUT_MAIN)"
	}
    }
    WAIT 10
    {
	    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_DL_PREV_1)"
    }
}
DEFINE_FUNCTION fnRouteVideoPreview(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_LECTERN_MON_RIGHT)"
    
    SWITCH (cIn)
    {
	CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PREVIEW_EXT]
	CASE VIDEO_RECORD : ON [vdvTP_Main, BTN_PREVIEW_REC]
    }
}
DEFINE_FUNCTION fnPowerDisplays(INTEGER cPwr)
{
    SWITCH (cPwr)
    {
	CASE BTN_PWR_ON_L :
	{
	    PULSE [vdvProjector_Left, POWER_ON]
	    fnRelayDirection(DN_LEFT)

	}
	CASE BTN_PWR_OFF_L :
	{
	    PULSE [vdvProjector_Left, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(UP_LEFT)
	    }
	}
	CASE BTN_PWR_ON_R :
	{
	    PULSE [vdvProjector_Right, POWER_ON]
	    fnRelayDirection(DN_RIGHT)
	}
	CASE BTN_PWR_OFF_R :
	{
	    PULSE [vdvProjector_Right, POWER_OFF]
	    WAIT 30
	    {
		fnRelayDirection(UP_RIGHT)
	    }
	}
	CASE BTN_PWR_ON_REAR :
	{
	    PULSE [vdvProjector_Rear, POWER_ON]
	    fnRelayDirection(DN_REAR)
	}
	CASE BTN_PWR_OFF_REAR :
	{
	    WAIT 10
	    {
		PULSE [vdvProjector_Rear, POWER_OFF]
		WAIT 30
		{
		    fnRelayDirection (UP_REAR)
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnMuteProjector(DEV cDevice, CHAR cToggle[])
{
    SEND_COMMAND cDevice, "'VIDOUT_MUTE-',cToggle"
    
    WAIT 5
    {
	SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
    }
}
DEFINE_FUNCTION fnMuteCheck(DEV cDevice)
{
    SEND_COMMAND cDevice, "'?VIDOUT_MUTE'"
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = TIME_KILL)
    {
	IF (([vdvProjector_Left, POWER]) || ([vdvProjector_Right, POWER]))
	{
	    fnPowerDisplays (BTN_PWR_OFF_L)
		fnPowerDisplays (BTN_PWR_OFF_R)
	}
    }
}
DEFINE_FUNCTION fnToggleChannels()
{
    ON [vdvProjector_Left, POWER]
	ON [vdvProjector_Right, POWER]
	    ON [vdvProjector_Rear, POWER]
}
DEFINE_FUNCTION fnRouteVideoRear(INTEGER cIn)
{
    SEND_COMMAND dvDGX, "'VI',ITOA(cIn),'O',ITOA(OUT_TELEVISION_REAR)"
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

ON [nRearFollowLeft]

WAIT 250
{
    TIMELINE_CREATE (TL_FEEDBACK,lTLFeedback,LENGTH_ARRAY(lTLFeedback),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    TIMELINE_CREATE (TL_FLASH,lTLFlash,LENGTH_ARRAY(lTLFlash),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    
    fnToggleChannels()
}

DEFINE_MODULE 'Sony_FHZ700L' PROJMODLEFT(vdvProjector_Left, dvProjector_Left);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODRIGHT(vdvProjector_Right, dvProjector_Right);
DEFINE_MODULE 'Sony_FHZ700L' PROJMODREAR(vdvProjector_Rear, dvProjector_Rear);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_L]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_L]
BUTTON_EVENT [vdvTP_Main, BTN_MUTE_PROJ_L] //Left Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_L : fnPowerDisplays(BTN_PWR_ON_L)
	    CASE BTN_PWR_OFF_L : fnPowerDisplays(BTN_PWR_OFF_L)
	    
	    CASE BTN_MUTE_PROJ_L :
	    {
		IF (![vdvTP_Main, BTN_MUTE_PROJ_L])
		{
		    fnMuteProjector(dvProjector_dxLeft, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvProjector_dxLeft, SET_MUTE_OFF)
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_R]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_R]
BUTTON_EVENT [vdvTP_Main, BTN_MUTE_PROJ_R] //Right Pwr Controls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_R : fnPowerDisplays(BTN_PWR_ON_R)
	    CASE BTN_PWR_OFF_R : fnPowerDisplays(BTN_PWR_OFF_R)
	    
	    CASE BTN_MUTE_PROJ_R :
	    {
		IF (![vdvTP_Main, BTN_MUTE_PROJ_R])
		{
		    fnMuteProjector(dvProjector_dxRight, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvProjector_dxRight, SET_MUTE_OFF)
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_ON_REAR]
BUTTON_EVENT [vdvTP_Main, BTN_PWR_OFF_REAR]
BUTTON_EVENT [vdvTP_Main, BTN_MUTE_PROJ_REAR] //Rear Pwr Controls...
BUTTON_EVENT [vdvTP_Main, BTN_FOLLOW_LEFT]
BUTTON_EVENT [vdvTP_Main, BTN_FOLLOW_NOTES]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PWR_ON_REAR : fnPowerDisplays(BTN_PWR_ON_REAR)
	    CASE BTN_PWR_OFF_REAR : fnPowerDisplays(BTN_PWR_OFF_REAR)
	    
	    CASE BTN_MUTE_PROJ_REAR :
	    {
		IF (![vdvTP_Main, BTN_MUTE_PROJ_REAR])
		{
		    fnMuteProjector(dvProjector_dxRear, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteProjector(dvProjector_dxRear, SET_MUTE_OFF)
		}
	    }
	    CASE BTN_FOLLOW_LEFT :
	    {
		ON [dvTP_Main, BTN_FOLLOW_LEFT]
		    ON [nRearFollowLeft]
			fnRouteVideoRear(nSource_Left)
	    }
	    CASE BTN_FOLLOW_NOTES :
	    {
		ON [dvTP_Main, BTN_FOLLOW_NOTES]
		    OFF [nRearFollowLeft]
			fnRouteVideoRear(VIDEO_PC_EXT)
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nProjectorLeftVidBtns]
{
    PUSH :
    {
	fnRouteVideoLeft(nVideoSources[GET_LAST(nProjectorLeftVidBtns)])
    }
}
BUTTON_EVENT [vdvTP_Main, nProjectorRightVidBtns]
{
    PUSH :
    {
	fnRouteVideoRight(nVideoSources[GET_LAST(nProjectorRightVidBtns)])
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PREVIEW_EXT]
BUTTON_EVENT [vdvTP_Main, BTN_PREVIEW_REC]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PREVIEW_EXT :
	    {
		fnRouteVideoPreview(VIDEO_PC_EXT)
	    }
	    CASE BTN_PREVIEW_REC :
	    {
		fnRouteVideoPreview(VIDEO_RECORD)
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_TECH_PAGE]
{
    HOLD [50] :
    {
	SEND_COMMAND dvTP_Main, "'PAGE-Select_Tech'"
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_REBOOT_DGX]
{
    PUSH :
    {
	REBOOT (dvDGXMaster)
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvProjector_Left, ON_LINE]
CHANNEL_EVENT [vdvProjector_Left, WARMING]
CHANNEL_EVENT [vdvProjector_Left, COOLING]
CHANNEL_EVENT [vdvProjector_Left, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
		ON [vdvTP_Main, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_L]
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
		OFF [vdvTP_Main, BTN_ONLINE_L]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_L]
	    }
	 }   
    }
}
CHANNEL_EVENT [vdvProjector_Right, ON_LINE]
CHANNEL_EVENT [vdvProjector_Right, WARMING]
CHANNEL_EVENT [vdvProjector_Right, COOLING]
CHANNEL_EVENT [vdvProjector_Right, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
		ON [vdvTP_Main, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_R]
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
		OFF [vdvTP_Main, BTN_ONLINE_R]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_R]
	    }
	 }   
    }
}
CHANNEL_EVENT [vdvProjector_Rear, ON_LINE]
CHANNEL_EVENT [vdvProjector_Rear, WARMING]
CHANNEL_EVENT [vdvProjector_Rear, COOLING]
CHANNEL_EVENT [vdvProjector_Rear, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP255'"
		ON [vdvTP_Main, BTN_ONLINE_REAR]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_ON_REAR]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP30'"
		OFF [vdvTP_Main, BTN_ONLINE_REAR]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-201.202,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_OFF_REAR]
	    }
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',MY_ROOM"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',MY_HELP_PHONE"
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
	ON [nDGXOnline]
	WAIT 120
	{
	    CALL 'DGX NAMING'
	}
    }
    OFFLINE :
    {
	OFF [nDGXOnline]
    }
    COMMAND :
    {
	LOCAL_VAR CHAR cAudio[4] // I5O33
	LOCAL_VAR CHAR cData[5]
	LOCAL_VAR CHAR cLeftTmp[4]
	LOCAL_VAR CHAR cRightTmp[4]
	LOCAL_VAR CHAR cRearTmp[4]
	
	CHAR cMsg[20]
	cMsg = DATA.TEXT
	
	SELECT
	{
    	    //Video Source Parsing...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LVIDEOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LVIDEOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_LECTERN_MON_LEFT)",1))
		{
		    cLeftTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    nSource_Left = ATOI(cLeftTmp)
		    
		    SWITCH (nSource_Left)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_L]
			CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_L]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_L]
			CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_L]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_L]
		    }
		}
    		IF (FIND_STRING(cMsg,"'O',ITOA(OUT_LECTERN_MON_RIGHT)",1))
		{
		    cRightTmp = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
		    nSource_Right = ATOI(cRightTmp)
		    
		    SWITCH (nSource_Right)
		    {
			    CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_PC_MAIN_R]
			    CASE VIDEO_PC_EXT : ON [vdvTP_Main, BTN_PC_EXT_R]
			    CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_EXTERNAL_R]
			    CASE VIDEO_DOC_CAM : ON [vdvTP_Main, BTN_DOC_CAM_R]
			    CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_MERSIVE_R]
		    }
		}
	    }	
	    //Audio Feedback...
	    ACTIVE(FIND_STRING(cMsg,"'SWITCH-LAUDIOI'",1)): 
	    {
		REMOVE_STRING(cMsg,"'SWITCH-LAUDIOI'",1)
		
		IF (FIND_STRING(cMsg,"'O',ITOA(AUDIO_OUT_MAIN)",1))
		{
		    cAudio = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-3)	
		    nSource_Audio = ATOI(cAudio)
		    
		    SWITCH (nSource_Audio)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_AUDIO_PC]
			CASE VIDEO_EXTERNAL : ON [vdvTP_Main, BTN_AUDIO_LECTERN]
			CASE VIDEO_MERSIVE : ON [vdvTP_Main, BTN_AUDIO_MERSIVE]
		    }
		}
	    }
	}
    }
}
DATA_EVENT [dvProjector_dxLeft] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxLeft, "'?VIDOUT_MUTE'"
    }
    COMMAND :
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
			ON [vdvTP_Main, BTN_MUTE_PROJ_L]
		    }
		    CASE 'DISABLE' :
		    {
			OFF [vdvTP_Main, BTN_MUTE_PROJ_L]
		    }
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxRight] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxRight, "'?VIDOUT_MUTE'"
    }
    COMMAND :
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
			ON [vdvTP_Main, BTN_MUTE_PROJ_R]
		    }
		    CASE 'DISABLE' :
		    {
			OFF [vdvTP_Main, BTN_MUTE_PROJ_R]
		    }
		}
	    }	
	}
    }
}
DATA_EVENT [dvProjector_dxRear] //Left Projector Port...
{
    ONLINE :
    {
	WAIT 80 SEND_COMMAND dvProjector_dxRear, "'?VIDOUT_MUTE'"
    }
    COMMAND :
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
			ON [vdvTP_Main, BTN_MUTE_PROJ_REAR]
		    }
		    CASE 'DISABLE' :
		    {
			OFF [vdvTP_Main, BTN_MUTE_PROJ_REAR]
		    }
		}
	    }	
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFlash = !iFlash
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnReboot()
    fnKill()
    
    [vdvTP_Main, BTN_REBOOT_DGX] = nDGXOnline
    
    //Left Flagging..
    IF ([vdvProjector_Left, WARMING])
    {
	[vdvTP_Main, BTN_WARMING_L] = iFlash
    }
    ELSE IF ([vdvProjector_Left, COOLING])
    {
	[vdvTP_Main, BTN_COOLING_L] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, BTN_WARMING_L] = [vdvProjector_Left, WARMING]
	[vdvTP_Main, BTN_COOLING_L] = [vdvProjector_Left, COOLING]
    }
    
    //Right Flagging...
    IF ([vdvProjector_Right, WARMING])
    {
	[vdvTP_Main, BTN_WARMING_R] = iFlash
    }
    ELSE IF ([vdvProjector_Right, COOLING])
    {
	[vdvTP_Main, BTN_COOLING_R] = iFlash
    }
    ELSE
    {
	[vdvTP_Main, BTN_WARMING_R] = [vdvProjector_Right, WARMING]
	[vdvTP_Main, BTN_COOLING_R] = [vdvProjector_Right, COOLING]
    }

    //Query Mutes...
    WAIT ONE_MINUTE
    {
        fnMuteCheck(dvProjector_dxLeft)
	WAIT ONE_SECOND fnMuteCheck(dvProjector_dxRight) 
	WAIT 20 fnMuteCheck(dvProjector_dxRear)
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

