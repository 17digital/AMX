PROGRAM_NAME='Vaddio_Connect'
(***********************************************************)
(*  FILE CREATED ON: 04/28/2017  AT: 17:30:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 08/17/2019  AT: 10:33:31        *)
(***********************************************************)


DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Main
dvTP_Main =			10001:1:0 //MST-701i
#END_IF

#IF_NOT_DEFINED dvTP_Main2
dvTP_Main2 =			10002:1:0 //WallPlate [MSD-701
#END_IF

#IF_NOT_DEFINED dvTP_Main3
dvTP_Main3 =			10003:1:0 //Remote Panel - MXT-700i
#END_IF

#IF_NOT_DEFINED dvBlackMagic
dvBlackMagic =			5001:1:0 //Black Magic 20x20
#END_IF

dvVaddioFront =			5001:5:0 //Above TVs
dvVaddioRear =			5001:7:0 //Rear opposite of TVs
dvVaddioLeft =			5001:4:0 //Facing TV's Left
dvVaddioRight =			5001:6:0 //Facing TV's Right

dvVaddioRearLeft =			5001:8:0
dvVaddioRearRight =		5401:1:0

vdvVaddioFront =			35094:1:0
vdvVaddioRear =			35095:1:0
vdvVaddioLeft =			35096:1:0
vdvVaddioRight =			35097:1:0
vdvVaddioRearLeft =		35098:1:0
vdvVaddioRearRight =		35099:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED POWER_ON
POWER_ON					= 27
#END_IF

#IF_NOT_DEFINED CR 
CR 						= 13
#END_IF

CAM_STOP				= 100
TILT_UP					= 132
TILT_DOWN				= 133
PAN_LEFT				= 134
PAN_RIGHT				= 135
ZOOM_IN 				= 158
ZOOM_OUT				= 159

BTN_CAM_FRONT			= 51
BTN_CAM_FRONT_RIGHT	= 52
BTN_CAM_REAR			= 53
BTN_CAM_FRONT_LEFT		= 54
BTN_CAM_REAR_RIGHT		= 55
BTN_CAM_REAR_LEFT		= 56

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

BTN_BOARD_1					= 96 //Remote Presets..
BTN_BOARD_2					= 97
BTN_BOARD_3					= 98
BTN_BOARD_4					= 99

TXT_CAMERA_SAVED			= 22

//Remote Panel...
BTN_SET_ACTIVE_FRONT		= 151
BTN_SET_ACTIVE_FRONT_RIGHT	= 152
BTN_SET_ACTIVE_REAR			= 153
BTN_SET_ACTIVE_FRONT_LEFT	= 154
BTN_SET_ACTIVE_REAR_RIGHT	= 155
BTN_SET_ACTIVE_REAR_LEFT		= 156

BTN_SWITCH_FRONT			= 251
BTN_SWITCH_FRONT_RIGHT		= 252
BTN_SWITCH_REAR				= 253
BTN_SWITCH_FRONT_LEFT		= 254
BTN_SWITCH_REAR_RIGHT		= 255
BTN_SWITCH_REAR_LEFT		= 256

//BlackMagic....
DESTINATION_REC				= 7 //Physical Source 
DESTINATION_USB				= 8 //Physical Source 

//BlackMagic Video Routing...
SOURCE_CAMERA_FRONT		= 1 //Between TV's - Front of Room
SOURCE_CAMERA_FRONT_RIGHT	= 2 //House Right Front - Above AV Rack
SOURCE_CAMERA_REAR			= 3 //
SOURCE_CAMERA_FRONT_LEFT	= 4
SOURCE_CAMERA_REAR_RIGHT	= 5 //Standing from rear Looking into room
SOURCE_CAMERA_REAR_LEFT	= 6

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nVaddioCameraSelect
VOLATILE INTEGER nVaddioActive_ //Remote Tracking...

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
    BTN_CAM_FRONT_RIGHT,
    BTN_CAM_REAR,
    BTN_CAM_FRONT_LEFT,
    BTN_CAM_REAR_RIGHT,
    BTN_CAM_REAR_LEFT
}
VOLATILE INTEGER nSelectActiveCameraBtns[] =
{
    BTN_SET_ACTIVE_FRONT,
    BTN_SET_ACTIVE_FRONT_RIGHT,
    BTN_SET_ACTIVE_REAR,
    BTN_SET_ACTIVE_FRONT_LEFT,
    BTN_SET_ACTIVE_REAR_RIGHT,
    BTN_SET_ACTIVE_REAR_LEFT
}
VOLATILE INTEGER nSelectVideoBtns[] =
{
    BTN_SWITCH_FRONT,
    BTN_SWITCH_FRONT_RIGHT,
    BTN_SWITCH_REAR,	
    BTN_SWITCH_FRONT_LEFT,
    BTN_SWITCH_REAR_RIGHT,
    BTN_SWITCH_REAR_LEFT
}
VOLATILE INTEGER nSourcesBM[] =
{
    SOURCE_CAMERA_FRONT,
    SOURCE_CAMERA_FRONT_RIGHT,
    SOURCE_CAMERA_REAR	,
    SOURCE_CAMERA_FRONT_LEFT,
    SOURCE_CAMERA_REAR_RIGHT,
    SOURCE_CAMERA_REAR_LEFT
}
VOLATILE DEV dcCameras[] =
{
    vdvVaddioFront,
    vdvVaddioRight,
    vdvVaddioRear,
    vdvVaddioLeft,
    vdvVaddioRearRight,
    vdvVaddioRearLeft
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_CAM_FRONT]..[dvTP_Main, BTN_CAM_REAR_LEFT])
([dvTP_Main, BTN_PRESET_1]..[dvTP_Main, BTN_PRESET_5])

([dvTP_Main2, BTN_CAM_FRONT]..[dvTP_Main2, BTN_CAM_REAR_LEFT])
([dvTP_Main2, BTN_PRESET_1]..[dvTP_Main2, BTN_PRESET_5])

//Remote Panel
([dvTP_Main3, BTN_SWITCH_FRONT]..[dvTP_Main3, BTN_SWITCH_REAR_LEFT])
([dvTP_Main3, BTN_SET_ACTIVE_FRONT]..[dvTP_Main3, BTN_SET_ACTIVE_REAR_LEFT])
([dvTP_Main3, BTN_BOARD_1]..[dvTP_Main3, BTN_BOARD_4])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnRouteCameraBoth(INTEGER cIn) //Classroom Side....
{
    SEND_STRING dvBlackMagic, "'@ X:0/',ITOA(DESTINATION_REC -1),',',ITOA(cIn -1),'/',ITOA(DESTINATION_USB -1),',',ITOA(cIn -1),CR"
}
DEFINE_FUNCTION fnRouteCameraVideoOnly(INTEGER cIn)
{
    SEND_STRING dvBlackMagic, "'@ X:0/',ITOA(DESTINATION_REC -1),',',ITOA(cIn -1),CR"
    
    SWITCH (cIn)
    {
	CASE SOURCE_CAMERA_FRONT : ON [dvTP_Main3, BTN_SWITCH_FRONT]
	CASE SOURCE_CAMERA_FRONT_RIGHT : ON [dvTP_Main3, BTN_SWITCH_FRONT_RIGHT]
	CASE SOURCE_CAMERA_REAR : ON [dvTP_Main3, BTN_SWITCH_REAR]
	CASE SOURCE_CAMERA_FRONT_LEFT : ON [dvTP_Main3, BTN_SWITCH_FRONT_LEFT]
	CASE SOURCE_CAMERA_REAR_RIGHT : ON [dvTP_Main3, BTN_SWITCH_REAR_RIGHT]
	CASE SOURCE_CAMERA_REAR_LEFT : ON [dvTP_Main3, BTN_SWITCH_REAR_LEFT]
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

WAIT 300
{
    fnRouteCameraBoth(SOURCE_CAMERA_FRONT)
	nVaddioCameraSelect = 1
	ON [vdvTp_Main, BTN_CAM_FRONT]
}

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioFrontMod(vdvVaddioFront, dvVaddioFront);
DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioRearMod(vdvVaddioRear, dvVaddioRear);
DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioLeftMod(vdvVaddioLeft, dvVaddioLeft);
DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioRightMod(vdvVaddioRight, dvVaddioRight);

DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioRearLeftMod(vdvVaddioRearLeft, dvVaddioRearLeft);
DEFINE_MODULE 'Vaddio_RoboShot12_Comm' VaddioRearRightMod(vdvVaddioRearRight, dvVaddioRearRight);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, nCameraVaddioBtns] //Set Active Room Camera (Local)...
{
    PUSH :
    {
	fnRouteCameraBoth (nSourcesBM[GET_LAST(nCameraVaddioBtns)])
	
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
BUTTON_EVENT [vdvTP_Main, ZOOM_OUT] //Local Camera Controls
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
BUTTON_EVENT [vdvTP_Main, BTN_PRESET_5] //Call Presets from Room
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
BUTTON_EVENT [dvTP_Main3, BTN_SET_ACTIVE_FRONT] 
BUTTON_EVENT [dvTP_Main3, BTN_SET_ACTIVE_FRONT_RIGHT]
BUTTON_EVENT [dvTP_Main3, BTN_SET_ACTIVE_REAR] 
BUTTON_EVENT [dvTP_Main3, BTN_SET_ACTIVE_FRONT_LEFT]
BUTTON_EVENT [dvTP_Main3, BTN_SET_ACTIVE_REAR_RIGHT]
BUTTON_EVENT [dvTP_Main3, BTN_SET_ACTIVE_REAR_LEFT] //Remote Room Camera Select...
{
    PUSH :
    {
	nVaddioActive_ = BUTTON.INPUT.CHANNEL -150
		ON [dvTP_Main3, BUTTON.INPUT.CHANNEL]
    }
}
BUTTON_EVENT [dvTP_Main3, nSelectVideoBtns]
{
    PUSH :
    {
	fnRouteCameraVideoOnly (nSourcesBM[GET_LAST(nSelectVideoBtns)])
    }
}
BUTTON_EVENT [dvTP_Main3, TILT_UP] 
BUTTON_EVENT [dvTP_Main3, TILT_DOWN] 
BUTTON_EVENT [dvTP_Main3, PAN_LEFT] 
BUTTON_EVENT [dvTP_Main3, PAN_RIGHT] 
BUTTON_EVENT [dvTP_Main3, ZOOM_IN] 
BUTTON_EVENT [dvTP_Main3, ZOOM_OUT] //Remote Camera Controls
{
    PUSH :
    {	
	TOTAL_OFF [dvTP_Main3, nBoardSelect]
	    TO [dcCameras[nVaddioActive_], BUTTON.INPUT.CHANNEL]
    }
    RELEASE :
    {
	PULSE [dcCameras[nVaddioActive_], CAM_STOP]
    }
}
 BUTTON_EVENT [dvTP_Main3, BTN_BOARD_1]
BUTTON_EVENT [dvTP_Main3, BTN_BOARD_2]
BUTTON_EVENT [dvTP_Main3, BTN_BOARD_3]
BUTTON_EVENT [dvTP_Main3, BTN_BOARD_4] //Store + Recall Board Presets (Remote)....
{
    HOLD [50] :
    {   
	SEND_COMMAND dvTP_Main3, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"

	SEND_COMMAND dcCameras[nVaddioActive_], "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL -90)"

    	WAIT 50 
	{
	    SEND_COMMAND dvTP_Main3, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	}
    }
    RELEASE :
    {
	    SEND_COMMAND dcCameras[nVaddioActive_], "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 90)"
		ON [dvTP_Main3, BUTTON.INPUT.CHANNEL]
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Main]
DATA_EVENT [dvTP_Main2]
DATA_EVENT [dvTP_Main3]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
    }
}
DATA_EVENT [dvBlackMagic]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 9600,N,8,1 485 ENABLE'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	WAIT 50 SEND_STRING dvBlackMagic, "CR" //Start off Session
	WAIT 70 SEND_STRING dvBlackMagic, "'@ ?',CR" //Enable Status Reporting...
	//WAIT 90 SEND_STRING dvBlackMagic, "'@ X?0',ITOA(DES_EXTRON_CAPTURE),CR" //Get Connected Route...
    }
}


