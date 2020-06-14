PROGRAM_NAME='Vaddio_Connect'


(***********************************************************)
(*  FILE CREATED ON: 04/28/2017  AT: 17:30:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/10/2020  AT: 11:09:16        *)
(***********************************************************)


DEFINE_DEVICE

(** UNCOMMENT 1 of 2 lines below -
    Specify how many camera(s) your room has
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

CAM_PRESET_1				= 1
CAM_PRESET_2				= 2
CAM_PRESET_3				= 3
CAM_PRESET_4				= 4
CAM_PRESET_5				= 5 

CAM_PRESET_6				= 6
CAM_PRESET_7				= 7
CAM_PRESET_8				= 8
CAM_PRESET_9				= 9

TXT_CAMERA_SAVED			= 22

BTN_CAM_FRONT				= 51
BTN_CAM_REAR				= 52

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


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

//DEV vdvTP_Camera[] = {dvTP_Main}

VOLATILE INTEGER nPresetSelect[] =
{
    BTN_PRESET_1,
    BTN_PRESET_2,
    BTN_PRESET_3,
    BTN_PRESET_4,
    BTN_PRESET_5
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_CAM_FRONT],[dvTP_Main, BTN_CAM_REAR])

([dvTP_Main, BTN_PRESET_1]..[dvTP_Main, BTN_PRESET_5]) 

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

WAIT 300
{
    ON [vdvVaddioFront, POWER]
}

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioFrontMod(vdvVaddioFront, dvVaddioFront);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, BTN_CAM_FRONT] //Front
{
    PUSH :
    {
	PULSE [vdvVaddioFront, POWER_ON]
	ON [dvTP_Main, BTN_CAM_FRONT]
    }
}
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
BUTTON_EVENT [dvTP_Main, BTN_PRESET_5] //Recall Presets...
{	
    PUSH :
    {
	ON [dvTP_Main, BUTTON.INPUT.CHANNEL]
	
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
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
    
	SEND_COMMAND vdvVaddioFront, "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL - 80)"
    
	WAIT 50 
	{
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	}

    }
}
CHANNEL_EVENT [vdvVaddioFront, POWER]
{
    ON :
    {
	ON [dvTP_Main, BTN_CAM_FRONT]
    }
    OFF :
    {
	OFF [dvTP_Main, BTN_CAM_FRONT]
    }
}
DATA_EVENT [dvTP_Main]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	WAIT 150 ON [vdvVaddioFront, POWER]
    }
}


