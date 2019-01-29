PROGRAM_NAME='Vaddio_Connect'
(***********************************************************)
(*  FILE CREATED ON: 04/28/2017  AT: 17:30:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 01/19/2019  AT: 12:12:33        *)
(***********************************************************)


DEFINE_DEVICE

(** UNCOMMENT 1 of 2 lines below -
    Specify how many camera(s) your room has
    **)

#IF_NOT_DEFINED dvVaddioFront
dvVaddioFront =			5001:4:0
#END_IF

#IF_NOT_DEFINED dvVaddioRear
dvVaddioRear =			5001:5:0
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

#IF_NOT_DEFINED POWER_OFF
POWER_OFF				= 28
#END_IF

CAM_STOP					= 100
TILT_UP					= 132
TILT_DOWN				= 133
PAN_LEFT					= 134
PAN_RIGHT					= 135
ZOOM_IN 					= 158
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

TL_CAM_FEEDBACK				= 7

TXT_CAMERA_SAVED			= 8


BTN_CAM_FRONT				= 51
BTN_CAM_REAR				= 52

BTN_BOARD_1				= 96
BTN_BOARD_2				= 97
BTN_BOARD_3				= 98
BTN_BOARD_4				= 99

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

VOLATILE INTEGER nVaddioCameraSelect
VOLATILE INTEGER nVaddioPresets

VOLATILE LONG lTLVaddioFeedback[] = {500};



(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

WAIT 200
{
	nVaddioCameraSelect = BTN_CAM_FRONT
}
//TIMELINE_CREATE (TL_CAM_FEEDBACK,lTLVaddioFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);


(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioFrontMod(vdvVaddioFront, dvVaddioFront);
DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioRearMod(vdvVaddioRear, dvVaddioRear);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, BTN_CAM_FRONT] //Front
BUTTON_EVENT [dvTP_Main, BTN_CAM_REAR] //Rear
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_CAM_FRONT :
	    {
		PULSE [vdvVaddioFront, POWER_ON]
		nVaddioCameraSelect = BTN_CAM_FRONT
		fnSetDGXRouteCamera(IN_CAM1)
	    }
	    CASE BTN_CAM_REAR :
	    {
		PULSE [vdvVaddioRear, POWER_ON]
		nVaddioCameraSelect = BTN_CAM_REAR
		fnSetDGXRouteCamera(IN_CAM2)
	    }
	}
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
	OFF [nVaddioPresets]
	
	IF (nVaddioCameraSelect = BTN_CAM_FRONT)
	{
	    PULSE [vdvVaddioFront, BUTTON.INPUT.CHANNEL] 
	}
	ELSE
	{
	    PULSE [vdvVaddioRear, BUTTON.INPUT.CHANNEL ]
	}
    }
    RELEASE :
    {
	    PULSE [vdvVaddioFront, CAM_STOP]
		PULSE [vdvVaddioRear, CAM_STOP]
    }
}
BUTTON_EVENT [dvTP_Main, BTN_BOARD_1]
BUTTON_EVENT [dvTP_Main, BTN_BOARD_2]
BUTTON_EVENT [dvTP_Main, BTN_BOARD_3]
BUTTON_EVENT [dvTP_Main, BTN_BOARD_4] //Save + Recall Board Presets...
{
    HOLD [50] : //Save Presets...
    {
	nVaddioCameraSelect = BTN_CAM_REAR
	//Preset 6,7,8,9
	
	SEND_COMMAND vdvVaddioRear, "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL - 90)"
		    
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
		WAIT 50 
		{
		    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
		}
    }
    RELEASE :
    {
	nVaddioCameraSelect = BTN_CAM_REAR
	
	SEND_COMMAND vdvVaddioRear, "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 90)"
		
		fnSetDGXRouteCamera(IN_CAM2)
		nVaddioPresets = BUTTON.INPUT.CHANNEL - 90 
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
	
	IF (nVaddioCameraSelect = BTN_CAM_FRONT)
	{
		
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
	}
	ELSE
	{
	    SEND_COMMAND vdvVaddioRear, "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
	}
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
			
	IF (nVaddioCameraSelect = BTN_CAM_FRONT)
	{
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL - 80)"
	}
	ELSE
	{
	    SEND_COMMAND vdvVaddioFront, "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL - 80)"
	}
	
	WAIT 50 
	{
	    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	}

    }
}

DATA_EVENT [dvTP_Main]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
    }
}
TIMELINE_EVENT [TIMELINE_MAIN]
{
    [dvTP_Main, BTN_CAM_FRONT] = nVaddioCameraSelect = BTN_CAM_FRONT
    [dvTP_Main, BTN_CAM_REAR] = nVaddioCameraSelect = BTN_CAM_REAR
    
    [dvTP_Main, BTN_BOARD_1] = nVaddioPresets = CAM_PRESET_6
    [dvTP_Main, BTN_BOARD_2] = nVaddioPresets = CAM_PRESET_7
    [dvTP_Main, BTN_BOARD_3] = nVaddioPresets = CAM_PRESET_8
    [dvTP_Main, BTN_BOARD_4] = nVaddioPresets = CAM_PRESET_9
}                                                                


