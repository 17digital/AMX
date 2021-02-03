PROGRAM_NAME='Vaddio_Connect'


(***********************************************************)
(*  FILE CREATED ON: 04/28/2017  AT: 17:30:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 03/30/2020  AT: 20:32:33        *)
(***********************************************************)


DEFINE_DEVICE

(** UNCOMMENT 1 of 2 lines below -
    Specify how many camera(s) your room has
    **)

#IF_NOT_DEFINED dvVaddioFront
dvVaddioFront =			5001:4:0
#END_IF

#IF_NOT_DEFINED dvVaddioRear
dvVaddioRear =			5001:6:0
#END_IF

#IF_NOT_DEFINED dvTP_Main
dvTP_Main =			10001:1:0
#END_IF

vdvVaddioFront =		35098:1:0
vdvVaddioRear =			35099:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED POWER_ON
POWER_ON					= 27
#END_IF

#IF_NOT_DEFINED INPUT_CAMERA_FRONT
INPUT_CAMERA_FRONT		= 7 // Front Camera
#END_IF

#IF_NOT_DEFINED INPUT_CAMERA_REAR
INPUT_CAMERA_REAR			= 8 // Rear Camera
#END_IF

#IF_NOT_DEFINED OUTPUT_SMP_CAMERA
OUTPUT_SMP_CAMERA		= 5
#END_IF

#IF_NOT_DEFINED OUTPUT_AVB
OUTPUT_AVB					= 6 
#END_IF

CAM_STOP					= 100
TILT_UP					= 132
TILT_DOWN				= 133
PAN_LEFT					= 134
PAN_RIGHT				= 135
ZOOM_IN 						= 158
ZOOM_OUT					= 159

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

BTN_BOARD_1					= 96
BTN_BOARD_2					= 97
BTN_BOARD_3					= 98
BTN_BOARD_4					= 99

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nVaddioCameraSelect

VOLATILE INTEGER nPresetSelect[] =
{
    BTN_PRESET_1,
    BTN_PRESET_2,
    BTN_PRESET_3,
    BTN_PRESET_4,
    BTN_PRESET_5
}
VOLATILE INTEGER nBoardSelect[] =
{
    BTN_BOARD_1,
    BTN_BOARD_2,
    BTN_BOARD_3,
    BTN_BOARD_4
}
VOLATILE INTEGER nCameraVaddioBtns[] =
{
    BTN_CAM_FRONT,
    BTN_CAM_REAR
}
VOLATILE INTEGER nSourceInputs[] =
{
    INPUT_CAMERA_FRONT,
    INPUT_CAMERA_REAR
}
VOLATILE DEV dcCameras[] =
{
    vdvVaddioFront,
    vdvVaddioRear
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_CAM_FRONT],[dvTP_Main, BTN_CAM_REAR])
([dvTP_Main, BTN_PRESET_1]..[dvTP_Main, BTN_PRESET_5])

([dvTP_Main2, BTN_CAM_FRONT]..[dvTP_Main2, BTN_CAM_REAR_LEFT])
([dvTP_Main2, BTN_PRESET_1]..[dvTP_Main2, BTN_PRESET_5])


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnRouteCamera(INTEGER cIn) //This is for DGX Switching...May not be needed
{
    SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(OUTPUT_SMP_CAMERA),',',ITOA(OUTPUT_AVB)"
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

WAIT 350
{
	fnRouteCamera(INPUT_CAMERA_REAR)
		nVaddioCameraSelect = 2 //Rear Camera is #2 in the Array!
	ON [vdvTp_Main, BTN_CAM_REAR]
}

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioFrontMod(vdvVaddioFront, dvVaddioFront);
DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioRearMod(vdvVaddioRear, dvVaddioRear);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, nCameraVaddioBtns] //Sets the Active Camera and Powers On..
{
    PUSH :
    {
       fnRouteCamera(nSourceInputs[GET_LAST(nCameraVaddioBtns)]) //
       
	    nVaddioCameraSelect = GET_LAST (nCameraVaddioBtns) 
	    WAIT 10
	    {
		PULSE [dcCameras[nVaddioCameraSelect], POWER_ON]
		    ON [vdvTP_Main, nVaddioCameraSelect + 50]
	    }
    }
}
BUTTON_EVENT [vdvTP_Main, TILT_UP] 
BUTTON_EVENT [vdvTP_Main, TILT_DOWN] 
BUTTON_EVENT [vdvTP_Main, PAN_LEFT] 
BUTTON_EVENT [vdvTP_Main, PAN_RIGHT] 
BUTTON_EVENT [vdvTP_Main, ZOOM_IN] 
BUTTON_EVENT [vdvTP_Main, ZOOM_OUT] //Camera Move
{
    PUSH :
    {
	TOTAL_OFF [vdvTP_Main, nPresetSelect]
	
	    TO [dcCameras[nVaddioCameraSelect], BUTTON.INPUT.CHANNEL]
    }
    RELEASE :
    {
	PULSE [dcCameras[nVaddioCameraSelect], CAM_STOP]
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_PRESET_1]
BUTTON_EVENT [vdvTP_Main, BTN_PRESET_2]
BUTTON_EVENT [vdvTP_Main, BTN_PRESET_3]
BUTTON_EVENT [vdvTP_Main, BTN_PRESET_4]
BUTTON_EVENT [vdvTP_Main, BTN_PRESET_5] //Recall Presets...
{	
    PUSH :
    {
	ON [vdvTP_Main, BUTTON.INPUT.CHANNEL]
	
	    SEND_COMMAND dcCameras[nVaddioCameraSelect], "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_SAVE_1]
BUTTON_EVENT [vdvTP_Main, BTN_SAVE_2]
BUTTON_EVENT [vdvTP_Main, BTN_SAVE_3]
BUTTON_EVENT [vdvTP_Main, BTN_SAVE_4]
BUTTON_EVENT [vdvTP_Main, BTN_SAVE_5] //Save Preset from Local Room
{	
    HOLD [30] :
    {
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	    SEND_COMMAND dcCameras[nVaddioCameraSelect], "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL - 80)"
	
	WAIT 50 
	{
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	}
    }
}
BUTTON_EVENT [vdvTP_Main, BTN_BOARD_1]
BUTTON_EVENT [vdvTP_Main, BTN_BOARD_2]
BUTTON_EVENT [vdvTP_Main, BTN_BOARD_3]
BUTTON_EVENT [vdvTP_Main, BTN_BOARD_4] //Store + Recall Board Presets....
{
    HOLD [50] :
    {   
	SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"

	SEND_COMMAND dcCameras[nVaddioCameraSelect], "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL -90)"

    	WAIT 50 
	{
	    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	}
    }
    RELEASE :
    {
	    SEND_COMMAND dcCameras[nVaddioCameraSelect], "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 90)"
		ON [vdvTP_Main, BUTTON.INPUT.CHANNEL]
    }
}

DATA_EVENT [dvTP_Main]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
    }
}
                             
