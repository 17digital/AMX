 PROGRAM_NAME='Master'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 07/05/2019  AT: 09:48:54        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    
    SAmsung Wall Notes : 
    All 4 Wall displays are set to ID #1
    All 4 Displays use HDMI -1 for individual source (Wall split function)
    
    Top Left MOnitor is first in signal path for Wall Window. For other moniors to receive same signal from monitor #1, they must be set to display port (Full Wall Video)
    Only need to route video to top Left monitor in full Wall mode. 
    
    Top left monitor can stay on HDMI 1 always. 
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster 		=				0:1:0	//NX-3200
dvDebug =					0:0:0 //Send to Diag
dvTP_Main   	= 				10052:1:0 //MST-701i

//Serial
dvSwitcher =					0:2:0 //Extron DTP Crosspoint (DTPCP108)
dvDisplay_TopLeft =			5001:2:0 //Samsung DM55E
dvDisplay_TopRight =			5001:3:0 //Samsung DM55E
dvDisplay_BottomLeft =			5001:4:0 //Samsung DM55E
dvDisplay_BottomRight =		5001:6:0 //Samsung DM55E
dvSmartBoard =				5001:7:0 //
dvVaddioFront =				5001:8:0 //Vaddio Camera

dvRelays =					5001:21:0 //Relays
dvIO =						5001:22:0 //IO's

vdvDisplay_TopLeft =			35011:1:0 //virtual device
vdvDisplay_TopRight =			35012:1:0 //
vdvDisplay_BottomLeft =			35013:1:0
vdvDisplay_BottomRight =		35014:1:0

vdvSmartBoard =				36015:1:0 

//Define Touch Panel Type
#WARN 'Check correct Panel Type'
#DEFINE G4PANEL //Ex..MST-701, MSD-701, MST-1001
//#DEFINE G5PANEL //Ex..MT-702, MT1002, MXT701

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED __GLOBAL_CONST__
#DEFINE __GLOBAL_CONST__

CR 							= 13
LF 							= 10
ESC							= 27 //Escape
#END_IF

//Extron Volume Values...
MAX_COMP					= 88 //Extron Max +12
VOL_ADJUST					= 10
//Extron Groups... (SEE Dsp Config)
ID_PRGM_LEV					= 1
ID_PRGM_MUTE				= 3 //
ID_MIC_MUTE					= 4

SET_MUTE_ON				= 1
SET_MUTE_OFF				= 0

//Extron I/O's
VIDEO_PC_MAIN				= 1
VIDEO_PC_DISPLAY_2			= 2
VIDEO_PC_DISPLAY_3			= 3
VIDEO_PC_DISPLAY_4			= 4
VIDEO_CAMERA				= 5
VIDEO_IN_6					= 6
VIDEO_IN_7					= 7
VIDEO_LAPTOP_FRONT			= 8
VIDEO_LAPTOP_REAR			= 9
VIDEO_IN_10					= 10

OUT_SMART_PROJECTOR		= 1
OUT_AV_BRIDGE				= 2 
OUT_3						= 3
OUT_4						= 4 
OUT_DISPLAY_UL				= 5
OUT_DISPLAY_UR				= 6
OUT_DISPLAY_LL				= 7
OUT_DISPLAY_LR				= 8
OUT_9						= 9
OUT_10						= 10

OUT_AUDIO_AMP				= 2 //

//More Extron
SET_VERBOSE_MODE			= 3

//Common Projector Channels..
POWER_CYCLE				= 9
POWER_ON					= 27
POWER_OFF					= 28
WARMING					= 253
COOLING					= 254
ON_LINE						= 251
POWER						= 255
BLANK						= 211

// Times
TL_FEEDBACK					= 1
TL_FLASH					= 2
TIME_KILL					= '22:00:00'
TIME_REBOOT					= '06:00:00'

ONE_SECOND					= 10
ONE_MINUTE					= 60 * ONE_SECOND
ONE_HOUR					= 60 * ONE_MINUTE

//Misc
MAX_LENGTH 				= 10

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100

TXT_SMART					= 1
TXT_MON_1					= 2
TXT_MON_2					= 3
TXT_MON_3					= 4
TXT_MON_4					= 5
TXT_PRGM					= 31
TXT_LAMP_HRS				= 29

//Buttons....
BTN_PWR_TV_ON				= 1
BTN_PWR_TV_OFF				= 2

BTN_PWR_PROJ_ON			= 101
BTN_PWR_PROJ_OFF			= 102

BTN_PC_MAIN					= 11
BTN_PC_EXT					= 12
BTN_PC_EXT_3					= 13
BTN_PC_EXT_4					= 14
BTN_LAPTOP_FRONT			= 15
BTN_LAPTOP_REAR				= 16
BTN_CAMERA_FRONT			= 17

BTN_SMART_BOARD			= 61
BTN_DISPLAY_TOP_LEFT			= 62
BTN_DISPLAY_TOP_RIGHT		= 63
BTN_DISPLAY_BOTTOM_LEFT		= 64
BTN_DISPLAY_BOTTOM_RIGHT	= 65

BTN_PRGM_MUTE				= 301
BTN_PRGM_UP				= 302
BTN_PRGM_DN				= 303
BTN_PRGM_PRESET				= 304

BTN_MIC_MUTE				= 305

BTN_AUDIO_PC				= 511
BTN_AUDIO_LAPTOP_FRONT		= 515
BTN_AUDIO_LAPTOP_REAR		= 516

BTN_TV_ONLINE				= 601
BTN_PROJ_ONLINE				= 611

BTN_SET_NUMBER				= 1500
BTN_SET_LOCATION			= 1501
BTN_SET_ALL					= 1502
BTN_LOAD_IO					= 1503

BTN_WALL_PRESET_SPLIT		= 1600
BTN_WALL_PRESET_FULL		= 1601
BTN_WALL_CALL				= 1602

BTN_NET_BOOT				= 1000

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

PERSISTENT CHAR nHelp_Phone_[15] //
PERSISTENT CHAR nRoom_Location[30]

VOLATILE INTEGER nTPOnline
VOLATILE INTEGER nPowerTV
VOLATILE INTEGER nPowerProjector
VOLATILE INTEGER nBoot_

CHAR cSwitcherIP[15] = '172.21.5.80' //bunger119matx
LONG nExtron_Port = 23
VOLATILE INTEGER nExtronOnline
VOLATILE CHAR nExtronBuffer[500]

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000}
VOLATILE INTEGER iFLASH

//Extron Switching...
VOLATILE INTEGER nSingleWallSource_
VOLATILE INTEGER nSource_Smart
VOLATILE INTEGER nSource_TV_1 
VOLATILE INTEGER nSource_TV_2
VOLATILE INTEGER nSource_TV_3
VOLATILE INTEGER nSource_TV_4
VOLATILE INTEGER nSourceAudio

VOLATILE INTEGER nSource_Input
VOLATILE INTEGER nBtn_Input
VOLATILE INTEGER nSource_Output
VOLATILE INTEGER nBtn_Output

//Program
VOLATILE SINTEGER nMaximum = 120 //-12dB
VOLATILE SINTEGER nMinimum = -1000 //-100dB

VOLATILE INTEGER nProgram_Mute
VOLATILE SINTEGER nProgram_Level
VOLATILE SINTEGER nProgram_Level_Preset = -220 //-38dB

VOLATILE INTEGER nMicTable_Mute

VOLATILE DEV vdvTP_Main[] = 
{
    dvTP_Main
}
VOLATILE INTEGER nVideoInSources[] =
{
    VIDEO_PC_MAIN,
    VIDEO_LAPTOP_FRONT,
    VIDEO_LAPTOP_REAR,
    VIDEO_CAMERA
}
VOLATILE INTEGER nOutputDisplays[] =
{
    OUT_DISPLAY_UL,
    OUT_DISPLAY_UR,
    OUT_DISPLAY_LL,
    OUT_DISPLAY_LR
}
VOLATILE INTEGER nSourceInputBtns[] =
{
    BTN_PC_MAIN,
    BTN_LAPTOP_FRONT,
    BTN_LAPTOP_REAR,
    BTN_CAMERA_FRONT
}
VOLATILE INTEGER nSourceOutputBtns[] =
{
    BTN_DISPLAY_TOP_LEFT,
    BTN_DISPLAY_TOP_RIGHT,
    BTN_DISPLAY_BOTTOM_LEFT,
    BTN_DISPLAY_BOTTOM_RIGHT
}
VOLATILE INTEGER nAudioBtns[] = 
{
    BTN_PRGM_MUTE,
    BTN_PRGM_UP,
    BTN_PRGM_DN,
    BTN_PRGM_PRESET,
    BTN_MIC_MUTE
}
VOLATILE CHAR nExtronInputNames[10][31] =
{
    'Desktop PC Main',
    'Desktop PC 2',
    'Desktop PC 3',
    'Desktop PC 4',
    'Camera', //5
    'No Input 6', 
    'No Input 7',
    'Table Front', //8
    'Table Rear', //9
    'No Input 10'
}
VOLATILE CHAR nExtronOutputNames[10][31] =
{
    'Smart Board',
    'AV Bridge', //2
    'No Output 3', //3
    'No Output 4',
    'TV Top Left', //5
    'TV Top Right', //6
    'TV Bottom Left',
    'TV Bottom Right' //8
}
VOLATILE DEV dcPwrDisplays[] =
{
    vdvDisplay_TopLeft,
    vdvDisplay_TopRight,
    vdvDisplay_BottomLeft,
    vdvDisplay_BottomRight
}
VOLATILE DEV dcWallDisplays[] =
{
    vdvDisplay_TopRight,
    vdvDisplay_BottomLeft,
    vdvDisplay_BottomRight
}

#INCLUDE 'SetMasterClock_' 
#INCLUDE 'Vaddio_Connect'


(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvTP_Main, BTN_PWR_TV_ON],[dvTP_Main, BTN_PWR_TV_OFF])
//([dvTP_Main, BTN_PWR_PROJ_ON],[dvTP_Main, BTN_PWR_PROJ_OFF])

([dvTP_Main, BTN_PC_MAIN]..[dvTP_Main, BTN_CAMERA_FRONT])
([dvTP_Main, BTN_AUDIO_PC]..[dvTP_Main, BTN_AUDIO_LAPTOP_REAR])
([dvTP_Main, BTN_SMART_BOARD]..[dvTP_Main, BTN_DISPLAY_BOTTOM_RIGHT])
([dvTP_Main, BTN_WALL_PRESET_SPLIT]..[dvTP_Main, BTN_WALL_PRESET_FULL])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartExtronConnection()
{
    IP_CLIENT_OPEN (dvSwitcher.PORT,cSwitcherIP,nExtron_Port,1) //TCP
    
    WAIT 20
    {
	fnExtronPull()
    }
}
DEFINE_FUNCTION fnCloseExtronConnection()
{
    IP_CLIENT_CLOSE (dvSwitcher.PORT)
}
DEFINE_FUNCTION fnReconnectExtron()
{
    fnCloseExtronConnection()
    WAIT 10
    {
	fnStartExtronConnection()
    }
}
DEFINE_FUNCTION char[100] GetIpExtronError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '" ;
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
	CASE 17 : iReturn = "'Local Port Not Open'"
	
	DEFAULT : iReturn = "'(', ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION fnSetExtronInputNames()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop =1; cLoop<=LENGTH_ARRAY(nExtronInputNames); cLoop++)
    {
	SEND_STRING dvSwitcher, "ESC,ITOA(cLoop),',',nExtronInputNames[cLoop],'NI',CR"
    }
}
DEFINE_FUNCTION fnSetExtronOutputNames()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop =1; cLoop<=LENGTH_ARRAY(nExtronOutputNames); cLoop++)
    {
	SEND_STRING dvSwitcher, "ESC,ITOA(cLoop),',',nExtronOutputNames[cLoop],'NO',CR"
    }
}
DEFINE_FUNCTION fnExtronPull()
{
    //!! Important - Need correct Verbose..
    SEND_STRING dvSwitcher, "ESC,ITOA(SET_VERBOSE_MODE),'CV',CR" //To Read Response Properly first...
    
    WAIT 10 SEND_STRING dvSwitcher, "ITOA(VIDEO_CAMERA),'*',ITOA(OUT_AV_BRIDGE),'%'" //Video Only
    //Read Video Ties...
    WAIT 20 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_UL),'%'" 
    WAIT 30 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_UR),'%'"
    WAIT 40 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_LL),'%'"
    WAIT 50 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_LR),'%'"
    WAIT 60 SEND_STRING dvSwitcher, "ITOA(OUT_SMART_PROJECTOR),'%'"
    
    WAIT 70 SEND_STRING dvSwitcher, "ITOA(OUT_AUDIO_AMP),'$'" //Read Audio Ties...
    
    //Prgm Unmute...
    WAIT 80 fnMuteChannel (ID_PRGM_MUTE, SET_MUTE_OFF)

    //Set Preset Prgm Audio...
    WAIT 90 fnSetVolumePreset (ID_PRGM_LEV, nProgram_Level_Preset)
    //UnMute Table Mics...
    WAIT 100 fnMuteChannel (ID_MIC_MUTE, SET_MUTE_OFF)
    
    WAIT 200 fnSetExtronInputNames()
    WAIT 250 fnSetExtronOutputNames()
}
DEFINE_FUNCTION fnExtronRep()
{
    SEND_STRING dvSwitcher, "ESC,ITOA(SET_VERBOSE_MODE),'CV',CR" //To Read Response Properly first...

    //Read Video Ties...
    WAIT 20 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_UL),'%'" 
    WAIT 30 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_UR),'%'"
    WAIT 40 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_LL),'%'"
    WAIT 50 SEND_STRING dvSwitcher, "ITOA(OUT_DISPLAY_LR),'%'"
    WAIT 60 SEND_STRING dvSwitcher, "ITOA(OUT_SMART_PROJECTOR),'%'"
    
    //Read Audio Ties...
    WAIT 70 SEND_STRING dvSwitcher, "ITOA(OUT_AUDIO_AMP),'$'"
}
DEFINE_FUNCTION fnMuteChannel (INTEGER cID, INTEGER cState)
{
    SEND_STRING dvSwitcher, "ESC,'D',ITOA(cID),'*',ITOA(cState),'GRPM',CR"
}
DEFINE_FUNCTION fnSetVolumeUp (INTEGER cID)
{
	SEND_STRING dvSwitcher, "ESC,'D',ITOA(cID),'*',ITOA(VOL_ADJUST),'+GRPM',CR"
}
DEFINE_FUNCTION fnSetVolumeDown (INTEGER cID)
{
	SEND_STRING dvSwitcher, "ESC,'D',ITOA(cID),'*',ITOA(VOL_ADJUST),'-GRPM',CR"
}
DEFINE_FUNCTION fnSetVolumePreset (INTEGER cID, SINTEGER cLev)
{
    SEND_STRING dvSwitcher, "ESC,'D',ITOA(cID),'*',ITOA(cLev),'GRPM',CR"
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME == TIME_KILL)
    {
	fnPowerDisplays(BTN_PWR_TV_OFF)
	    fnPowerDisplays(BTN_PWR_PROJ_OFF)
    }
}
DEFINE_FUNCTION fnPowerDisplays(INTEGER cPWR)
{
    SWITCH (cPWR)
    {
	CASE BTN_PWR_TV_ON:
	{
	    PULSE [dcPwrDisplays, POWER_ON]	
	}
	CASE BTN_PWR_TV_OFF:
	{
	    PULSE [dcPwrDisplays, POWER_OFF]
	}
	CASE BTN_PWR_PROJ_ON :
	{
	    PULSE [vdvSmartBoard, POWER_ON]
	}
	CASE BTN_PWR_PROJ_OFF :
	{
	    PULSE [vdvSmartBoard, POWER_OFF]
	}
    }
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
DEFINE_FUNCTION fnRouteVideoWall(INTEGER cIn, INTEGER cOut)
{    
    SEND_STRING dvSwitcher, "ITOA(cIn),'*',ITOA(cOut),'%'" //Video Only
}
DEFINE_FUNCTION fnParseExtron()
{
    STACK_VAR CHAR cExtronResponse[50]
    LOCAL_VAR INTEGER cVidInput
    LOCAL_VAR INTEGER cVidOutput
    LOCAL_VAR INTEGER cAudOutput
    LOCAL_VAR INTEGER cState
    LOCAL_VAR CHAR lbug[25]
    
    WHILE (FIND_STRING(nExtronBuffer,"CR,LF",1))
    {
	cExtronResponse = REMOVE_STRING(nExtronBuffer,"CR,LF",1)
	    AMX_LOG (AMX_INFO, "'dvSwitcher : STRING: ',cExtronResponse");
	
	IF (FIND_STRING(cExtronResponse, "'GrpmD',ITOA(ID_PRGM_LEV),'*'",1)) //Program Volume Adjust....
	{
	    REMOVE_STRING (cExtronResponse, "'GrpmD',ITOA(ID_PRGM_LEV),'*'",1)
	    //nProgram_Level = ATOI(cResponse) //This would give you -420
	    nProgram_Level = ATOI(LEFT_STRING(cExtronResponse,3)); //Give me first 3 only - so -42
		
		//SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA((nProgram_Level / 10) + MAX_COMP),'%'"
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(nProgram_Level + MAX_COMP),'%'"
	}
	IF (FIND_STRING (cExtronResponse, "'GrpmD',ITOA(ID_PRGM_MUTE),'*'",1)) //Mute Prgrm Group...
	{
	    REMOVE_STRING (cExtronResponse, "'GrpmD',ITOA(ID_PRGM_MUTE),'*'",1)
	    cState = ATOI(LEFT_STRING(cExtronResponse,1));
	    
	    SWITCH (cState)
	    {
		CASE SET_MUTE_ON :
		{
		    nProgram_Mute = TRUE;
			ON [vdvTP_Main, BTN_PRGM_MUTE]
		}
		CASE SET_MUTE_OFF :
		{
		    nProgram_Mute = FALSE;
			OFF [vdvTP_Main, BTN_PRGM_MUTE]
		}
	    }
	}
	IF (FIND_STRING (cExtronResponse, "'GrpmD',ITOA(ID_MIC_MUTE),'*'",1))
	{
	    REMOVE_STRING (cExtronResponse, "'GrpmD',ITOA(ID_MIC_MUTE),'*'",1)
	    cState = ATOI(LEFT_STRING(cExtronResponse,1));
	    
	    SWITCH (cState)
	    {
		CASE SET_MUTE_ON :
		{
		    nMicTable_Mute = TRUE;
			ON [vdvTP_Main, BTN_MIC_MUTE]
		}
		CASE SET_MUTE_OFF :
		{
		    nMicTable_Mute = FALSE;
			OFF [vdvTP_Main, BTN_MIC_MUTE]
		}
	    }
	}
	IF (FIND_STRING(cExtronResponse,'Vid',1)) //Vid Route Happened
	{
	    SEND_STRING dvDebug, "'Extron Video Route Made : ', cExtronResponse"
	    lbug = cExtronResponse;
    
		cVidOutput = ATOI (MID_STRING(cExtronResponse,4,1));
		cVidInput = ATOI (MID_STRING (cExtronResponse, 8,1)); //Out1 In9 Vid
		
	    SWITCH (cVidOutput)
	    {
		CASE OUT_SMART_PROJECTOR :
		{
		    nSource_Smart = cVidInput
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SMART),',0,',nExtronInputNames[nSource_Smart]"
		}
		CASE OUT_DISPLAY_UL :
		{
		    nSource_TV_1 = cVidInput
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_MON_1),',0,',nExtronInputNames[nSource_TV_1]"
		}
		CASE OUT_DISPLAY_UR :
		{
		    nSource_TV_2 = cVidInput
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_MON_2),',0,',nExtronInputNames[nSource_TV_2]"
		}
		CASE OUT_DISPLAY_LL :
		{
		    nSource_TV_3 = cVidInput
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_MON_3),',0,',nExtronInputNames[nSource_TV_3]"
		}
		CASE OUT_DISPLAY_LR : 
		{
		    nSource_TV_4 = cVidInput
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_MON_4),',0,',nExtronInputNames[nSource_TV_4]"
		}
	    }
	}
	IF (FIND_STRING(cExtronResponse,'Aud',1)) //Audio Route Happened
	{
	    SEND_STRING dvDebug, "'Extron Audio Route Made : ',cExtronResponse"
		
		    nSourceAudio = ATOI (MID_STRING (cExtronResponse, 8,1));
			cAudOutput = ATOI (MID_STRING(cExtronResponse,4,1));
		
	    SWITCH (cAudOutput)
	    {
		CASE OUT_AUDIO_AMP :
		{
		    SWITCH (nSourceAudio)
		    {
			CASE VIDEO_PC_MAIN : ON [vdvTP_Main, BTN_AUDIO_PC]
			CASE VIDEO_LAPTOP_FRONT : ON [vdvTP_Main, BTN_AUDIO_LAPTOP_FRONT]
			CASE VIDEO_LAPTOP_REAR : ON [vdvTP_Main, BTN_AUDIO_LAPTOP_REAR]
		    }
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnWindowDisplayMode (INTEGER nMode) 
{
    SEND_COMMAND dvTP_Main, "'@PPX'" //Remove First...
    
    SWITCH (nMode)
    {
	CASE BTN_WALL_PRESET_SPLIT :
	{
	    nSingleWallSource_ = FALSE;
	    SEND_COMMAND dvTP_Main, "'@PPG-_Routing_Split'"
	    
	    SEND_COMMAND dcWallDisplays, "'INPUT-HDMI,1'" //Set displays 2,3,4 to HDMI for single source
	    WAIT 30
	    {
	    SEND_STRING dvDisplay_TopLeft, "$AA,$89,$01,$02,$11,$01,$9E" //Sets to Single Layout full
		SEND_STRING dvDisplay_TopRight, "$AA,$89,$01,$02,$11,$01,$9E"
		    SEND_STRING dvDisplay_BottomLeft, "$AA,$89,$01,$02,$11,$01,$9E"
			SEND_STRING dvDisplay_BottomRight, "$AA,$89,$01,$02,$11,$01,$9E"
	    }
	}
	CASE BTN_WALL_PRESET_FULL :
	{
	    nSingleWallSource_ = TRUE;
	    SEND_COMMAND dvTP_Main, "'@PPG-_Routing_Full'"
	    
	    SEND_COMMAND dcWallDisplays, "'INPUT-DISPLAYPORT,1'" //Set displays 2,3,4 to Display port to pull Daisy Chained ouput (wall)
	    WAIT 20
	    {
		    SEND_STRING dvDisplay_TopLeft, "$AA,$89,$01,$02,$22,$01,$AF" //Sets Monitor to Crop Portion of Video
			SEND_STRING dvDisplay_TopRight, "$AA,$89,$01,$02,$22,$02,$B0"
			    SEND_STRING dvDisplay_BottomLeft, "$AA,$89,$01,$02,$22,$03,$B1"
				SEND_STRING dvDisplay_BottomRight, "$AA,$89,$01,$02,$22,$04,$B2"
	    }
	}
    }
}
	
    
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

nBoot_ = TRUE; 

TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    CREATE_BUFFER dvSwitcher,nExtronBuffer;

WAIT 600
{
    nBoot_ = FALSE;
}

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Samsung_DM55E' MODtopLeft (vdvDisplay_TopLeft, dvDisplay_TopLeft);
DEFINE_MODULE 'Samsung_DM55E' MODtopRight (vdvDisplay_TopRight, dvDisplay_TopRight);
DEFINE_MODULE 'Samsung_DM55E' MODBottomLeft (vdvDisplay_BottomLeft, dvDisplay_BottomLeft);
DEFINE_MODULE 'Samsung_DM55E' MODBottomRight (vdvDisplay_BottomRight, dvDisplay_BottomRight);
DEFINE_MODULE 'SmartBoard_800ix_Series' MODDisplay (vdvSmartBoard, dvSmartBoard);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_PWR_TV_ON]
{
    PUSH :
    {
	IF (nPowerTV == FALSE)
	{
	    fnPowerDisplays (BTN_PWR_TV_ON)
	}
	ELSE
	{
	    fnPowerDisplays (BTN_PWR_TV_OFF)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PWR_PROJ_ON]
{
    PUSH :
    {
	IF (nPowerProjector == FALSE)
	{
	    fnPowerDisplays (BTN_PWR_PROJ_ON)
	}
	ELSE
	{
	    fnPowerDisplays (BTN_PWR_PROJ_OFF)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceInputBtns] //Source Input Select
{
    PUSH :
    {
	nBtn_Input = GET_LAST (nSourceInputBtns) //Set Counter
	nSource_Input = nVideoInSources[nBtn_Input] //Set Source from within Array
	    ON [vdvTP_Main, nSourceInputBtns[nBtn_Input]] //Send FB
    }
}
BUTTON_EVENT [vdvTP_Main, nSourceOutputBtns] //Video Wall Select...
{
    PUSH :
    {
	nBtn_Output = GET_LAST (nSourceOutputBtns)
	nSource_Output = nOutputDisplays[nBtn_Output]
	    
	IF (LENGTH_STRING (nSource_Input) > 0) //If there's an input value...allow me to switch..
	{
	    ON [vdvTP_Main, nSourceOutputBtns[nBtn_Output]]
	    
		fnRouteVideoWall (nSource_Input, nSource_Output) //Make Route...

	    SWITCH (nSource_Input)
	    {
		CASE VIDEO_PC_MAIN :
		CASE VIDEO_LAPTOP_FRONT :
		CASE VIDEO_LAPTOP_REAR :
		{
		    SEND_STRING dvSwitcher, "ITOA(nSource_Input),'*',ITOA(OUT_AUDIO_AMP),'$'" //Audio Only
		}
	    }
	}
	
	WAIT 20 //reset FB
	{
	    TOTAL_OFF [vdvTP_Main, nSourceInputBtns] 
		TOTAL_OFF [vdvTP_Main, nSourceOutputBtns]
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SMART_BOARD] //Route Source to Smart Board...
{
    PUSH :
    {
	IF (LENGTH_STRING (nSource_Input) > 0) //If there's an input value...allow me to switch..
	{
	    ON [vdvTP_Main, BTN_SMART_BOARD]
		fnRouteVideoWall (nSource_Input, OUT_SMART_PROJECTOR)

	    SWITCH (nSource_Input)
	    {
		CASE VIDEO_PC_MAIN :
		CASE VIDEO_LAPTOP_FRONT :
		CASE VIDEO_LAPTOP_REAR :
		{
		    SEND_COMMAND dvSwitcher, "ITOA(nSource_Input),'*',ITOA(OUT_AUDIO_AMP),'$'" //Audio Only
		}
	    }
	}
	WAIT 20 //reset FB
	{
	    TOTAL_OFF [vdvTP_Main, nSourceInputBtns]
		OFF [vdvTP_Main, BTN_SMART_BOARD]
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_WALL_PRESET_SPLIT] 
BUTTON_EVENT [vdvTP_Main, BTN_WALL_PRESET_FULL] //Display Presets...
{
    PUSH :
    {
	ON [vdvTP_Main, BUTTON.INPUT.CHANNEL]
	
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_WALL_PRESET_SPLIT : fnWindowDisplayMode (BTN_WALL_PRESET_SPLIT)
	    CASE BTN_WALL_PRESET_FULL : fnWindowDisplayMode (BTN_WALL_PRESET_FULL)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_WALL_CALL]
{
    PUSH :
    {
	IF (nSingleWallSource_ == TRUE)
	{
	    SEND_COMMAND dvTP_Main, "'@PPG-_Routing_Full'"
	}
	ELSE
	{
	    SEND_COMMAND dvTP_Main, "'@PPG-_Routing_Split'"
	}
    }
}
BUTTON_EVENT [vdvTP_Main, nAudioBtns] //Volume Controls....
{
    PUSH :
    {
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nAudioBtns)
	SWITCH (nChnlIdx)
	{
	    CASE 1 :
	    {
		IF (nProgram_Mute == FALSE)
		{
		    fnMuteChannel (ID_PRGM_MUTE, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteChannel (ID_PRGM_MUTE, SET_MUTE_OFF)

		}
	    }
	    CASE 2 : fnSetVolumeUp (ID_PRGM_LEV)
	    CASE 3 : fnSetVolumeDown (ID_PRGM_LEV)
	    CASE 4 : fnSetVolumePreset (ID_PRGM_LEV, nProgram_Level_Preset)

	    CASE 5 :
	    {
		IF (nMicTable_Mute == FALSE)
		{
		    fnMuteChannel (ID_MIC_MUTE, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteChannel (ID_MIC_MUTE, SET_MUTE_OFF)

		}
	    }
	}
    }
    HOLD [2, REPEAT] :
    {
    	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nAudioBtns)
	SWITCH (nChnlIdx)
	{
	    CASE 2 : fnSetVolumeUp (ID_PRGM_LEV)
	    CASE 3 : fnSetVolumeDown (ID_PRGM_LEV)
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SET_NUMBER]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL
	SEND_COMMAND vdvTP_Main, "'@TKP'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND vdvTP_Main, "'^TKP'"
	#END_IF
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SET_LOCATION]
{
    PUSH :
    {
	#IF_DEFINED G4PANEL 
	SEND_COMMAND vdvTP_Main, "'@AKB'"
	#END_IF
	
	#IF_DEFINED G5PANEL
	SEND_COMMAND vdvTP_Main, "'^AKB'"
	#END_IF
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SET_ALL]
{
    PUSH :
    {
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	nTPOnline = TRUE;
	
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	
	SEND_STRING dvDebug, "'Touch Panel Online!'"
	
	IF (nBoot_ == FALSE)
	{
	    fnExtronRep()
	}
    }
    OFFLINE :
    {
	nTPOnline = FALSE;
	    SEND_STRING dvDebug, "'Touch Panel Offline!'"
    }
    STRING :
    {
	LOCAL_VAR CHAR sTmp[30]
	
	sTmp = DATA.TEXT
	
	IF (FIND_STRING(sTmp,'KEYB-',1)OR FIND_STRING(sTmp,'AKB-',1)) //G4 or G5 Parsing
	{
	   REMOVE_STRING(sTmp,'-',1)
	   
		IF (FIND_STRING(sTmp,'ABORT',1))
		{
		    nRoom_Location = 'Set Default'
		    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
		}
		ELSE
		{
		     nRoom_Location = sTmp
		    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoom_Location"
		}
	}
	IF (FIND_STRING(sTmp,'KEYP-',1)OR FIND_STRING(sTmp,'TKP-',1)) //G4 or G5
	{
	    REMOVE_STRING(sTmp,'-',1)
	    
	    IF (FIND_STRING(sTmp,'ABORT',1)) //Keep Default if it was set...
	    {
		nHelp_Phone_ = nHelp_Phone_
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	    ELSE
	    {
		nHelp_Phone_ = sTmp
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp_Phone_"
	    }
	}
    }
}
DATA_EVENT [dvSwitcher]
{
    ONLINE :
    {
	nExtronOnline = TRUE;
	    ON [vdvTP_Main, BTN_NET_BOOT]
    }
    OFFLINE :
    {
	nExtronOnline = FALSE;
	    OFF [vdvTP_Main, BTN_NET_BOOT]
    }
    ONERROR :
    {
	AMX_LOG (AMX_ERROR, "'dvSwitcher : onerror : ',GetIpExtronError(DATA.NUMBER)");
	    SEND_STRING dvDebug, "'Extron onerror : ',GetIpExtronError(DATA.NUMBER)";
	    
	SWITCH (DATA.NUMBER)
	{
	    CASE 17 :
	    {
		nExtronOnline = FALSE;
		    OFF [vdvTP_Main, BTN_NET_BOOT]
			fnReconnectExtron()
	    }
	    DEFAULT :
	    {
		nExtronOnline = FALSE;
		    OFF [vdvTP_Main, BTN_NET_BOOT]
	    }
	}
    }
    STRING:
    {
	nExtronOnline = TRUE;
	    ON [vdvTP_Main, BTN_NET_BOOT]
	    
	fnParseExtron()
    }
}
DATA_EVENT [vdvSmartBoard]
{
    COMMAND :
    {
	STACK_VAR CHAR cGrabStatus[8]
	LOCAL_VAR CHAR cHrs[4]
	
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	
	 SEND_STRING dvDebug, "'vdvSmartBoard : ',cMsg"
	
	IF (FIND_STRING (cMsg, 'LAMPHRS-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
	    cHrs = cMsg
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_LAMP_HRS),',0,Lamp Hours ',cHrs"
	}
	IF (FIND_STRING (cMsg,'FBPROJECTOR-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
	   
		cGrabStatus = cMsg
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'PWRON':
		{
		    ON [vdvTP_Main, BTN_PWR_PROJ_ON]
			nPowerProjector = TRUE;
		}
		CASE 'PWROFF' :
		{
		    OFF [vdvTP_Main, BTN_PWR_PROJ_ON]
			nPowerProjector = FALSE;
		}
		CASE 'ONLINE':
		{
		    ON [vdvTP_Main, BTN_PROJ_ONLINE]
			SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
		}
		CASE 'OFFLINE' :
		{
		    OFF [vdvTP_Main, BTN_PROJ_ONLINE]
			SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
		}
	    }
	}
    }
}
DATA_EVENT [vdvDisplay_TopLeft] //Main Display to Track...
{
    COMMAND :
    {
	STACK_VAR CHAR cGrabStatus[10]
	
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	
	    SEND_STRING dvDebug, "'vdvDisplay_TopLeft : ',cMsg"
	
	IF (FIND_STRING (cMsg,'FBTELEVISION-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
		cGrabStatus = cMsg
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'PWRON':
		{
		    ON [vdvTP_Main, BTN_PWR_TV_ON]
			nPowerTV = TRUE;
		}
		CASE 'PWROFF' :
		{
		    OFF [vdvTP_Main, BTN_PWR_TV_ON]
			nPowerTV = FALSE;
		}
		CASE 'ONLINE':
		{
		    ON [vdvTP_Main, BTN_TV_ONLINE]
			//SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
		}
		CASE 'OFFLINE' :
		{
		    OFF [vdvTP_Main, BTN_TV_ONLINE]
			//SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
		}
		CASE 'WALLSINGLE' :
		{
		    nSingleWallSource_ = TRUE;
			ON [vdvTP_Main, BTN_WALL_PRESET_FULL]
		}
		CASE 'WALLSPLIT' :
		{
		    nSingleWallSource_ = FALSE;
			ON [vdvTP_Main, BTN_WALL_PRESET_SPLIT]
		}
	    }
	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvDisplay_TopLeft, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE WARMING :
	    CASE COOLING :
	    {
		//SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_TV_ON]
		    nPowerTV = TRUE;
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE WARMING :
	    CASE COOLING :
	    {
		//SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE POWER :
	    {
		OFF [vdvTP_Main, BTN_PWR_TV_ON]
		    nPowerTV = FALSE;
	    }
	}
    }
}
CHANNEL_EVENT [vdvSmartBoard, 0]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE WARMING :
	    CASE COOLING :
	    {
		//SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [vdvTP_Main, BTN_PWR_PROJ_ON]
		    nPowerProjector = TRUE;
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE WARMING :
	    CASE COOLING :
	    {
		//SEND_COMMAND vdvTP_Main, "'^BMF-101.102,0,%OP255'"
	    }
	    CASE POWER :
	    {
		OFF [vdvTP_Main, BTN_PWR_PROJ_ON]	
		    nPowerProjector = FALSE;
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
   
   //Smart Board Warm/Cool
   IF ([vdvSmartBoard, WARMING])
   {
	[vdvTP_Main, 612] = iFLASH
    }
    ELSE IF ([vdvSmartBoard, COOLING])
    {
	[vdvTP_Main, 613] = iFLASH
    }
    ELSE
    {
	[vdvTP_Main, 612] = [vdvSmartBoard, WARMING]
	[vdvTP_Main, 613] = [vdvSmartBoard, COOLING]
    }

    //Extron Checkup...
    WAIT 450
    {
	IF (nExtronOnline == FALSE)
	{
	    fnStartExtronConnection()
	}
	ELSE
	{
	    fnExtronRep()
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


