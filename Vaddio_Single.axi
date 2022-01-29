PROGRAM_NAME='Vaddio_Connect'


(***********************************************************)
(*  FILE CREATED ON: 04/28/2017  AT: 17:30:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/10/2020  AT: 11:09:16        *)
(***********************************************************)


DEFINE_DEVICE

(** See this -
    This Include file works in Conjunction with my custom Vaddio Module
    **)

#IF_NOT_DEFINED dvVaddioFront
dvVaddioFront =			5001:4:0
#END_IF



#IF_NOT_DEFINED dvTP_Main
dvTP_Main =			10001:1:0
#END_IF

vdvVaddioFront =		35098:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED POWER_ON
POWER_ON					= 27
#END_IF

CAM_STOP					= 100
TILT_UP					= 132
TILT_DOWN				= 133
PAN_LEFT					= 134
PAN_RIGHT				= 135
ZOOM_IN 						= 158
ZOOM_OUT					= 159
AUTO_FOCUS					= 97
AUTO_WB					= 98
IMAGE_FLIP_ON				= 11
IMAGE_FLIP_OFF				= 12

BTN_PRESET_1					= 71
BTN_PRESET_2					= 72
BTN_PRESET_3					= 73
BTN_PRESET_4					= 74
BTN_PRESET_5					= 75
BTN_PRESET_6					= 76
BTN_PRESET_HOME			= 77

TXT_CAMERA_SAVED			= 22
TXT_CAMERA_PAGE			= 23

//Buttons...
BTN_CAM_PWR				= 50

BTN_CAMERA_POPUP		= 245


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nOnline_Front;

VOLATILE INTEGER nPresetSelect[] =
{
    BTN_PRESET_1,
    BTN_PRESET_2,
    BTN_PRESET_3,
    BTN_PRESET_4,
    BTN_PRESET_5,
    BTN_PRESET_6,
    BTN_PRESET_HOME
}
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_PRESET_1]..[dvTP_Main, BTN_PRESET_HOME])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioFrontMod(vdvVaddioFront, dvVaddioFront);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, TILT_UP] 
BUTTON_EVENT [dvTP_Main, TILT_DOWN] 
BUTTON_EVENT [dvTP_Main, PAN_LEFT] 
BUTTON_EVENT [dvTP_Main, PAN_RIGHT] 
BUTTON_EVENT [dvTP_Main, ZOOM_IN] 
BUTTON_EVENT [dvTP_Main, ZOOM_OUT] //Camera Move
{
    PUSH :
    {
	TOTAL_OFF [dvTP_Main, nPresetSelect]
	
	    PULSE [vdvVaddioFront, BUTTON.INPUT.CHANNEL] 
    }
    RELEASE :
    {
	    PULSE [vdvVaddioFront, CAM_STOP]
    }
}
BUTTON_EVENT [dvTP_Main, BTN_PRESET_1]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_2]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_3]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_4]
BUTTON_EVENT [dvTP_Main, BTN_PRESET_5] 
BUTTON_EVENT [dvTP_Main, BTN_PRESET_6] //Store + Recall Presets...
{	
    HOLD [30] :
    {
	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
	
	WAIT 50 
	{
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
	}
    }	
    RELEASE :
    {
	ON [dvTP_Main, BUTTON.INPUT.CHANNEL]
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
    }
}
BUTTON_EVENT [dvTP_Main, BTN_PRESET_HOME] //Custom Home Button - Set your own Default Position!
{
    HOLD [90] :
    {
    	SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESETSAVE-',ITOA(BTN_PRESET_HOME - 70)"
	
	WAIT 20 
	{
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
	}
    }
    RELEASE :
    {
	ON [dvTP_Main, BTN_PRESET_HOME]
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESET-',ITOA(BTN_PRESET_HOME - 70)"
	    
	    WAIT 10 PULSE [vdvVaddioFront, AUTO_FOCUS]
		WAIT 20 PULSE [vdvVaddioFront, AUTO_WB]
    }
}
BUTTON_EVENT [dvTP_Main, BTN_CAMERA_POPUP] //check Power State - Not Necessary with Single Camera
{
    PUSH :
    {
	[dvTP_Main, BTN_CAM_PWR] = nOnline_Front;
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Main]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
    }
}
DATA_EVENT [vdvVaddioFront] //will only work with custom module - Module Sends Messages that will Read Status
{
    COMMAND :
    {
	LOCAL_VAR CHAR cGrabStatus[8]
	
	CHAR cMsg[30]
	cMsg = DATA.TEXT
	
	IF (FIND_STRING (cMsg,'FBPOWER-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
		cGrabStatus = cMsg
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'ON':
		{
		    nOnline_Front = TRUE;
			//[dvTP_Main, BTN_CAM_PWR] = TRUE;
		}
		CASE 'OFF' :
		{
		    nOnline_Front = TRUE;
			//[dvTP_Main, BTN_CAM_PWR] = TRUE;
		}
	    }
	}
	IF (FIND_STRING (cMsg,'FBCAMERA-',1))
	{
	    REMOVE_STRING (cMsg,'-',1)
		cGrabStatus = cMsg
	    
	    SWITCH (cGrabStatus)
	    {
		CASE 'ONLINE':
		{
		    nOnline_Front = TRUE;
		}
		CASE 'OFFLINE' :
		{
		    nOnline_Front = FALSE;
		}
	    }
	}
    }
}



