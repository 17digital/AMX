PROGRAM_NAME='Vaddio_Connect'
(***********************************************************)
(*  FILE CREATED ON: 04/28/2017  AT: 17:30:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/17/2019  AT: 10:43:38        *)
(***********************************************************)


DEFINE_DEVICE

(** UNCOMMENT 1 of 2 lines below -
    Specify how many camera(s) your room has
    
    "'system reboot',13"
    
    "'network settings get',13" //pull MAC, IP, SUB, GATE
    **)

#IF_NOT_DEFINED dvVaddioMatrix
dvVaddioMatrix =			5001:2:0


#IF_NOT_DEFINED dvTP_MAIN
dvTP_MAIN =			10001:1:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED CR 
CR 				= 13
#END_IF

#IF_NOT_DEFINED LF 
LF 				= 10
#END_IF

//Camera Positions....
CAMERA_FRONT			= 2 //Looking @ Students
CAMERA_REAR			= 1 //Looking @ Instructor
CAMERA_DOC_CAM			= 3

TXT_CAMERA_SAVED			= 22

LOGIN					= 'admin'
PASS						= 'password'
MUTE_ON					= 'on'
MUTE_OFF					= 'off'


OUT_MIX_PROGRAM				= 1 //
IN_PRGM					=	4
IN_WIRELESS				= 3
IN_CEILING_1				= 1
IN_CEILING_2				= 2

VOL_UP					= 1
VOL_DN					= -1

MAX_AUD_VOL				= 12
MIN_AUD_VOL				= -12

BTN_CAMERA_FRONT		= 52
BTN_CAMERA_REAR		= 51
BTN_CAMERA_DOC			= 53
BTN_RESTART				= 90
BTN_ACTIVE_PAGE			= 54

BTN_PRESET_1				= 71
BTN_PRESET_2				= 72
BTN_PRESET_3				= 73
BTN_PRESET_4				= 74
BTN_PRESET_5				= 75

BTN_SAVE_1				= 81
BTN_SAVE_2				= 82
BTN_SAVE_3				= 83
BTN_SAVE_4				= 84
BTN_SAVE_5				= 85

BTN_TILT_UP				= 132
BTN_TILT_DOWN			= 133
BTN_PAN_LEFT			= 134
BTN_PAN_RIGHT			= 135
BTN_ZOOM_IN 			= 158
BTN_ZOOM_OUT			= 159

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER cLocked

VOLATILE SINTEGER nPgrmPreset = 0 //Max = +12
VOLATILE SINTEGER nWirelessPreset = 1 //Max = +12
VOLATILE SINTEGER nPgrmVol 
VOLATILE SINTEGER nWirelessVol 
VOLATILE INTEGER nPgrmMute
VOLATILE INTEGER nWirelessMute
VOLATILE INTEGER nCeilingMute
VOLATILE INTEGER nCameraSelect //Holds Active ID


VOLATILE INTEGER nPresetSelect[] =
{
    BTN_PRESET_1,
    BTN_PRESET_2,
    BTN_PRESET_3,
    BTN_PRESET_4,
    BTN_PRESET_5
} 
VOLATILE INTEGER nVaddioCameraBtns[] =
{
    BTN_TILT_UP,					
    BTN_TILT_DOWN,				
    BTN_PAN_LEFT,					
    BTN_PAN_RIGHT,				
    BTN_ZOOM_IN, 						
    BTN_ZOOM_OUT					
}
VOLATILE INTEGER nSelectCameraBtns[] =
{
    BTN_CAMERA_REAR,
    BTN_CAMERA_FRONT,
    BTN_CAMERA_DOC
}
VOLATILE INTEGER nCameraIDs[] =
{
    CAMERA_REAR,
    CAMERA_FRONT,
    CAMERA_DOC_CAM
}
VOLATILE CHAR nPopUpPages[3][15] =
{
    'VTC_Cameras',
    'VTC_Cameras',
    'DocCam'
}
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_MAIN, BTN_CAMERA_REAR]..[dvTP_MAIN, BTN_CAMERA_DOC])
([dvTP_Main, BTN_PRESET_1]..[dvTP_Main, BTN_PRESET_5])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnMuteCeilingMics(CHAR cMute)
{
    SEND_STRING dvVaddioMatrix, "'audio usb_record mute ',cMute,CR"
}
DEFINE_FUNCTION fnMuteWireless(CHAR cMute)
{
    SEND_STRING dvVaddioMatrix, "'audio line_in_',ITOA(IN_WIRELESS),' mute ',cMute,CR"
}
DEFINE_FUNCTION fnMuteProgram(CHAR cMute)
{
    SEND_STRING dvVaddioMatrix, "'audio line_in_',ITOA(IN_PRGM),' mute ',cMute,CR"
}
DEFINE_FUNCTION fnProgramPreset()
{
    SEND_STRING dvVaddioMatrix, "'audio line_out_',ITOA(OUT_MIX_PROGRAM),' crosspoint-gain line_in_',ITOA(IN_PRGM),' set ',ITOA(nPgrmPreset),CR"
}
DEFINE_FUNCTION fnVolumeUP(SINTEGER cVol)
{
    IF (cVol < MAX_AUD_VOL)
    {
	SEND_STRING dvVaddioMatrix, "'audio line_out_',ITOA(OUT_MIX_PROGRAM),' crosspoint-gain line_in_',ITOA(IN_PRGM),' set ',ITOA(cVol + VOL_UP),CR"
    }
}
DEFINE_FUNCTION fnVolumeDN(SINTEGER cVol)
{
    IF (cVol > MIN_AUD_VOL)
    {
	SEND_STRING dvVaddioMatrix, "'audio line_out_',ITOA(OUT_MIX_PROGRAM),' crosspoint-gain line_in_',ITOA(IN_PRGM),' set ',ITOA(cVol + VOL_DN),CR"
    }
}
DEFINE_FUNCTION fnVaddioRouteCamera(INTEGER cIn)
{    
    SEND_STRING dvVaddioMatrix, "'camera ',ITOA(cIn),' standby off',CR"
    
    
    WAIT 10
    {
       SEND_STRING dvVaddioMatrix, "'video program source set input',ITOA(cIn),CR"
	    SEND_STRING dvVaddioMatrix, "'video stream source set input',ITOA(cIn),CR" //Switches USB
    }
}
DEFINE_FUNCTION fnVaddioMatrixLogin()
{
    SEND_STRING dvVaddioMatrix, "LOGIN,CR"
    
    WAIT 20
    {
	SEND_STRING dvVaddioMatrix, "PASS,CR"
    }
}
DEFINE_FUNCTION fnParseVaddio()
{
    LOCAL_VAR CHAR cData[1000]
    LOCAL_VAR INTEGER cInput
    LOCAL_VAR CHAR cLookup[100]
    
    cData = DATA.TEXT
    
    SELECT
    {
	ACTIVE(FIND_STRING(cData,'source: input',1)): //Query Response...
	{
		REMOVE_STRING(cData,'source: input',1)
		cInput = ATOI(cData)
		OFF [cLocked]
		
		SWITCH (cInput)
		{
		    CASE CAMERA_REAR : 
		    {
			ON [dvTP_MAIN, BTN_CAMERA_REAR]
			    nCameraSelect = CAMERA_REAR
		    }
		    CASE CAMERA_FRONT :
		    {
			ON [dvTP_MAIN, BTN_CAMERA_FRONT]
			    nCameraSelect = CAMERA_FRONT
		    }
		    CASE CAMERA_DOC_CAM :
		    {
			ON [dvTP_MAIN, BTN_CAMERA_DOC]
			    nCameraSelect = CAMERA_DOC_CAM
		    }
		}
	}
	ACTIVE(FIND_STRING(cData,'Password:',1)):
	{
		//That mean password is needed son! - may want to lock this out to prevent other commands..
		ON [cLocked]
		
		WAIT 20
		{
		    SEND_STRING dvVaddioMatrix, "PASS,CR"
		}
	}
	ACTIVE(FIND_STRING(cData,'login:',1)):
	{
		ON [cLocked]
		
		WAIT 20
		{
		    fnVaddioMatrixLogin()
		}
	}
	ACTIVE(FIND_STRING(cData,'Login incorrect',1)):
	 {
		ON [cLocked]
		
		WAIT 50
		{
		    fnVaddioMatrixLogin()
		}
	}
	ACTIVE(FIND_STRING(cData,'Welcome admin',1)):
	{
		OFF [cLocked]
	}
	ACTIVE(FIND_STRING(cData,'Authorized Access Only',1)):
	{
		OFF [cLocked]
	}
	ACTIVE(FIND_STRING(cData,'Login timed out after',1)):
	{
		ON [cLocked]

		WAIT 50
		{
		    fnVaddioMatrixLogin()
		}
	}
    }
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

WAIT 80
{
    SEND_STRING dvVaddioMatrix, "'video program source get',CR"
}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_MAIN, BTN_ACTIVE_PAGE]
{
    PUSH :
    {
	SEND_COMMAND dvTP_MAIN, "'^PPN-',nPopUpPages[nCameraSelect]" //"nCamersSelect...should Pull Correct Array Order 
    }
}
BUTTON_EVENT [dvTP_Main, nSelectCameraBtns] //Select Active Camera...
{
    PUSH :
    {
	nCameraSelect = GET_LAST (nSelectCameraBtns)
	SEND_COMMAND dvTP_MAIN, "'^PPX'" //Remove PopUp First...
		    
		    SEND_COMMAND dvTP_MAIN, "'^PPN-',nPopUpPages[GET_LAST(nSelectCameraBtns)]"
	
	IF (!cLocked)
	{
	    fnVaddioRouteCamera(nCameraIDs[GET_LAST(nSelectCameraBtns)])
		    ON [dvTP_MAIN, nCameraSelect+50]
	}
    }
}
BUTTON_EVENT [dvTP_Main, BTN_TILT_UP]
BUTTON_EVENT [dvTP_Main, BTN_TILT_DOWN]				
BUTTON_EVENT [dvTP_Main, BTN_PAN_LEFT]				
BUTTON_EVENT [dvTP_Main, BTN_PAN_RIGHT]				
BUTTON_EVENT [dvTP_Main, BTN_ZOOM_IN]			
BUTTON_EVENT [dvTP_Main, BTN_ZOOM_OUT]						
{
    PUSH :
    {
	TOTAL_OFF [dvTP_MAIN, nPresetSelect]

	    SWITCH (BUTTON.INPUT.CHANNEL)
	    {
		    CASE BTN_TILT_UP : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' tilt up 6',CR"
		    CASE BTN_TILT_DOWN : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' tilt down 6',CR"
		    CASE BTN_PAN_LEFT : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' pan left 6',CR"
		    CASE BTN_PAN_RIGHT : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' pan right 6',CR"
		    CASE BTN_ZOOM_IN : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' zoom in 3',CR"
		    CASE BTN_ZOOM_OUT : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' zoom out 3'  ,CR"
	    }
    }
    RELEASE :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_TILT_UP :
	    CASE BTN_TILT_DOWN :
	    {
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' tilt stop',CR"
	    }
	    CASE BTN_PAN_LEFT :
	    CASE BTN_PAN_RIGHT :
	    {
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' pan stop',CR"
	    }
	    CASE BTN_ZOOM_IN :
	    CASE BTN_ZOOM_OUT :
	    {
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' zoom stop',CR"
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main, BTN_PRESET_1]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_2]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_3]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_4]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_5] //Recall Presets...
{	
    PUSH :
    {
	ON [dvTP_Main, BUTTON.INPUT.CHANNEL]
	
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' preset recall ',ITOA(BUTTON.INPUT.CHANNEL -70),CR"
    }
}
BUTTON_EVENT [dvTP_Main, BTN_SAVE_1] 
BUTTON_EVENT [dvTP_Main, BTN_SAVE_2]
BUTTON_EVENT [dvTP_Main, BTN_SAVE_3]
BUTTON_EVENT [dvTP_Main, BTN_SAVE_4]
BUTTON_EVENT [dvTP_Main, BTN_SAVE_5]
{
    HOLD [30] :
    {
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	
	SEND_STRING dvVaddioMatrix, "'camera ',ITOA(nCameraSelect),' preset store ',ITOA(BUTTON.INPUT.CHANNEL -80),CR"

	WAIT 50 
	{
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	}
    }
}
BUTTON_EVENT [dvTP_MAIN, BTN_RESTART] //Re Input Password
{
    PUSH :
    {
	fnVaddioMatrixLogin()
    }
}


DEFINE_EVENT
DATA_EVENT [dvVaddioMatrix]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 38400,N,8,1'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
    }
    STRING :
    {
	fnParseVaddio()
    }
}
DATA_EVENT [dvTP_Main]
{
    ONLINE :
    {
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
    }
}
                                                               


