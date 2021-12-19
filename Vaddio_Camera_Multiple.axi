PROGRAM_NAME='Vaddio_Connect_IP'


(***********************************************************)
(*  FILE CREATED ON: 04/28/2017  AT: 17:30:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/04/2020  AT: 07:32:56        *)
(***********************************************************)


DEFINE_DEVICE

(** UNCOMMENT 1 of 2 lines below -
    Specify how many camera(s) your room has
    **)
#IF_NOT_DEFINED dvDGX
dvDGX =					5002:1:0
#END_IF

#IF_NOT_DEFINED dvTP_Main
dvTP_Main =			10001:1:0
#END_IF

#IF_NOT_DEFINED dvTP_Wall
dvTP_Wall =			10002:1:0 //MD-702
#END_IF

#IF_NOT_DEFINED dvTP_Rear
dvTP_Rear =			10003:1:0 //MD-702
#END_IF

#IF_NOT_DEFINED dvTP_Booth
dvTP_Booth =			10004:1:0 //MT-1002
#END_IF


dvVaddioHouseLeft =			0:2:0
dvVaddioHouseRight =			0:3:0
dvVaddioStageLeft =			0:4:0
dvVaddioStageRight =			0:5:0

vdvVaddioHouseLeft =			41010:1:0
vdvVaddioHouseRight =			41011:1:0
vdvVaddioStageLeft =			41012:1:0
vdvVaddioStageRight =			41013:1:0


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED POWER_ON
POWER_ON					= 27
#END_IF

#IF_NOT_DEFINED POWER
POWER					= 255
#END_IF

CAM_STOP					= 100
TILT_UP						= 132
TILT_DOWN					= 133
PAN_LEFT					= 134
PAN_RIGHT					= 135
ZOOM_IN 					= 159
ZOOM_OUT					= 158

//Speed Levels...
LEVEL_ZOOM				= 18
LEVEL_TILT				= 30
LEVEL_PAN				= 29
LEVEL_ZOOM_SPEED		= 100 //(0 - 255)
LEVEL_PAN_SPEED			= 80 //(0 - 255)
LEVEL_TILT_SPEED			= 80 //(0 - 255)

BTN_PRESET_1					= 71
BTN_PRESET_2					= 72
BTN_PRESET_3					= 73
BTN_PRESET_4					= 74
BTN_PRESET_5					= 75
BTN_PRESET_6					= 76
BTN_PRESET_HOME			= 77


TXT_CAMERA_SAVED			= 22
TXT_CAMERA_PAGE			= 23

BTN_CAM_PWR				= 50
BTN_CAM_HOUSE_L			= 51
BTN_CAM_HOUSE_R			= 52
BTN_CAM_STAGE_L				= 53
BTN_CAM_STAGE_R				= 54
BTN_PRVW_ACTIVE_CAMERA		= 120
BTN_CAMERA_POPUP			= 245

//Camera Inputs...
IN_CAMERA_HOUSE_L			= 19
IN_CAMERA_HOUSE_R			= 20
IN_CAMERA_STAGE_L			= 18
IN_CAMERA_STAGE_R			= 17

//Out DGX...
OUT_MON_PRVW				= 2
OUT_AV_BRIDGE				= 10
OUT_PEARL					= 12

//Camera IP's
IP_CAMERA_HOUSE_L			= '172.21.2.227'
IP_CAMERA_HOUSE_R			= '172.21.2.228'
IP_CAMERA_STAGE_L			= '172.21.2.229'
IP_CAMERA_STAGE_R			= '172.21.2.230'

CAMERA_USER				= 'admin'
CAMERA_PASSWORD			= 'password'


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER cIndexCamera
VOLATILE INTEGER nLivePreview_ //Is Camera Live or naw..
VOLATILE INTEGER nPwrCount;

VOLATILE INTEGER nOnline_Cam_HL
VOLATILE INTEGER nOnline_Cam_HR
VOLATILE INTEGER nOnline_Cam_SL
VOLATILE INTEGER nOnline_Cam_SR

VOLATILE DEV vdvTP_Camera[] = 
{
    dvTP_Main, 
    dvTP_Wall, 
    dvTP_Rear, 
    dvTP_Booth
}
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
VOLATILE DEV dcCameras[] =
{
    vdvVaddioHouseLeft,
    vdvVaddioHouseRight,
    vdvVaddioStageLeft,
    vdvVaddioStageRight
}
VOLATILE INTEGER nCameraButtons[] =
{
    BTN_CAM_HOUSE_L,
    BTN_CAM_HOUSE_R,
    BTN_CAM_STAGE_L,
    BTN_CAM_STAGE_R
}
VOLATILE INTEGER nSourceCameraIn[] =
{
    IN_CAMERA_HOUSE_L,
    IN_CAMERA_HOUSE_R,
    IN_CAMERA_STAGE_L,
    IN_CAMERA_STAGE_R
}
VOLATILE CHAR nCameraPageTitles[4][18] =
{
    'Camera House Left',
    'Camera House Right',
    'Camera Stage Left',
    'Camera Stage Right'
}
DEVCHAN dcVaddioPwrFB[] =
{
    {vdvVaddioHouseLeft, POWER},
    {vdvVaddioHouseRight, POWER},
    {vdvVaddioStageLeft, POWER},
    {vdvVaddioStageRight, POWER}
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Main, BTN_CAM_HOUSE_L]..[dvTP_Main, BTN_CAM_STAGE_R])
([dvTP_Main, BTN_PRESET_1]..[dvTP_Main, BTN_PRESET_HOME])

([dvTP_Wall, BTN_CAM_HOUSE_L]..[dvTP_Wall, BTN_CAM_STAGE_R])
([dvTP_Wall, BTN_PRESET_1]..[dvTP_Wall, BTN_PRESET_HOME])

([dvTP_Rear, BTN_CAM_HOUSE_L]..[dvTP_Rear, BTN_CAM_STAGE_R])
([dvTP_Rear, BTN_PRESET_1]..[dvTP_Rear, BTN_PRESET_HOME])

([dvTP_Booth, BTN_CAM_HOUSE_L]..[dvTP_Booth, BTN_CAM_STAGE_R])
([dvTP_Booth, BTN_PRESET_1]..[dvTP_Booth, BTN_PRESET_HOME])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnRouteCameraToUSB (INTEGER cIn)
{
    IF (nLivePreview_ == TRUE)
    {
	SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(OUT_MON_PRVW),',',ITOA(OUT_AV_BRIDGE),',',ITOA(OUT_PEARL)"
    }
    ELSE
    {
	SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(OUT_AV_BRIDGE),',',ITOA(OUT_PEARL)"
    }
    
    SWITCH (cIn) //Update Online Status
    {
	CASE IN_CAMERA_HOUSE_L : [vdvTP_Camera, BTN_CAM_PWR] = nOnline_Cam_HL;
	CASE IN_CAMERA_HOUSE_R : [vdvTP_Camera, BTN_CAM_PWR] = nOnline_Cam_HR;
	CASE IN_CAMERA_STAGE_L : [vdvTP_Camera, BTN_CAM_PWR] = nOnline_Cam_SL;
	CASE IN_CAMERA_STAGE_R : [vdvTP_Camera, BTN_CAM_PWR] = nOnline_Cam_SR;
    }
}
DEFINE_FUNCTION fnSetCameraSpeeds()
{
    SEND_LEVEL dcCameras,LEVEL_PAN,LEVEL_PAN_SPEED
    WAIT 20 SEND_LEVEL dcCameras,LEVEL_TILT,LEVEL_TILT_SPEED
    WAIT 30 SEND_LEVEL dcCameras,LEVEL_ZOOM,LEVEL_ZOOM_SPEED
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

WAIT 350
{
    cIndexCamera = 1;
	fnRouteCameraToUSB (IN_CAMERA_HOUSE_L)
	    ON [vdvTP_Camera, nCameraButtons[cIndexCamera]]
}

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Vaddio_RoboShot12_IP_Comm_dr1_0_0' VaddioFrontMod(vdvVaddioHouseLeft, dvVaddioHouseLeft);
DEFINE_MODULE 'Vaddio_RoboShot12_IP_Comm_dr1_0_0' VaddioRightMod(vdvVaddioHouseRight, dvVaddioHouseRight);
DEFINE_MODULE 'Vaddio_RoboShot12_IP_Comm_dr1_0_0' VaddioSLeftMod(vdvVaddioStageLeft, dvVaddioStageLeft);
DEFINE_MODULE 'Vaddio_RoboShot12_IP_Comm_dr1_0_0' VaddioSRightMod(vdvVaddioStageRight, dvVaddioStageRight);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Camera, nCameraButtons] //Camera Select Active...
{
    PUSH :
    {
	cIndexCamera = GET_LAST (nCameraButtons);
	    fnRouteCameraToUSB (nSourceCameraIn[cIndexCamera]) //Index correct source..
		TOTAL_OFF [vdvTP_Camera, nPresetSelect]
		    SEND_COMMAND vdvTP_Camera, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Set Correct Title
		PULSE [dcCameras[cIndexCamera], POWER_ON] //Ensure Camera is Pwr On..
	ON [vdvTP_Camera, nCameraButtons[cIndexCamera]] //Set FB
    }
}
BUTTON_EVENT [vdvTP_Camera, BTN_PRVW_ACTIVE_CAMERA] //Sent to Preview Monitor
{
    PUSH :
    {
	IF ( nLivePreview_ == FALSE)
	{
	    ON [vdvTP_Camera, BTN_PRVW_ACTIVE_CAMERA]
		SEND_COMMAND dvDgx, "'VI',ITOA(nSourceCameraIn[cIndexCamera]),'O',ITOA(OUT_MON_PRVW)"
		    nLivePreview_ = TRUE;
	}
	ELSE
	{
	    SEND_COMMAND dvDgx, "'VI',ITOA(nSourceLast),'O',ITOA(OUT_MON_PRVW)"
		OFF [dvTP_Main, BTN_PRVW_ACTIVE_CAMERA]
		    nLivePreview_ = FALSE;
	}
    }
}
BUTTON_EVENT [vdvTP_Camera, BTN_CAMERA_POPUP]
{
    PUSH :
    {
	//SEND_COMMAND dvTP_Main, "'^PPN-',nCameraPages[cIndexCamera]" //Load appropriate Page...
	    SEND_COMMAND vdvTP_Camera, "'^TXT-',ITOA(TXT_CAMERA_PAGE),',0,',nCameraPageTitles[cIndexCamera]" //Load Title
    }
}
BUTTON_EVENT [vdvTP_Camera, TILT_UP] 
BUTTON_EVENT [vdvTP_Camera, TILT_DOWN] 
BUTTON_EVENT [vdvTP_Camera, PAN_LEFT] 
BUTTON_EVENT [vdvTP_Camera, PAN_RIGHT] 
BUTTON_EVENT [vdvTP_Camera, ZOOM_IN] 
BUTTON_EVENT [vdvTP_Camera, ZOOM_OUT] //Camera Movement...
{
    PUSH :
    {
	TOTAL_OFF [vdvTP_Camera, nPresetSelect]
	    ON [dcCameras[cIndexCamera], BUTTON.INPUT.CHANNEL]
    }
    RELEASE :
    {
	OFF [dcCameras[cIndexCamera], BUTTON.INPUT.CHANNEL]
    }
}
BUTTON_EVENT [vdvTP_Camera, BTN_PRESET_1]
BUTTON_EVENT [vdvTP_Camera, BTN_PRESET_2]
BUTTON_EVENT [vdvTP_Camera, BTN_PRESET_3]
BUTTON_EVENT [vdvTP_Camera, BTN_PRESET_4]
BUTTON_EVENT [vdvTP_Camera, BTN_PRESET_5] 
BUTTON_EVENT [vdvTP_Camera, BTN_PRESET_6] //Recall +Store Camera Presets..
{
    HOLD [30] :
    {
	SEND_COMMAND vdvTP_Camera, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	    SEND_COMMAND dcCameras[cIndexCamera], "'CAMERAPRESETSAVE-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
	
	WAIT 50 
	{
	    SEND_COMMAND vdvTP_Camera, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
	}
    }
    RELEASE :
    {
      ON [vdvTP_Camera, BUTTON.INPUT.CHANNEL]
        SEND_COMMAND dcCameras[cIndexCamera], "'CAMERAPRESET-',ITOA(BUTTON.INPUT.CHANNEL - 70)"
    }
}
BUTTON_EVENT [vdvTP_Camera, BTN_PRESET_HOME]
{
    HOLD [90] :
    {
    	SEND_COMMAND vdvTP_Camera, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	    SEND_COMMAND dcCameras[cIndexCamera], "'CAMERAPRESETSAVE-',ITOA(BTN_PRESET_HOME - 70)"
	
	WAIT 20 
	{
	    SEND_COMMAND vdvTP_Camera, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
	}
    }
    RELEASE :
    {
	ON [vdvTP_Camera, BTN_PRESET_HOME]
	    SEND_COMMAND dcCameras[cIndexCamera], "'CAMERAPRESET-',ITOA(BTN_PRESET_HOME - 70)"
    }
}

DEFINE_EVENT
CHANNEL_EVENT [dcVaddioPwrFB] //Track Active Camera Power
{
    ON :
    {
	nPwrCount = GET_LAST (dcVaddioPwrFB)
	
	SWITCH (nPwrCount)
	{
	    CASE 1 : nOnline_Cam_HL = TRUE;
	    CASE 2 : nOnline_Cam_HR = TRUE;
	    CASE 3 : nOnline_Cam_SL = TRUE;
	    CASE 4 : nOnline_Cam_SR = TRUE;
	}
    }
    OFF :
    {
	nPwrCount = GET_LAST (dcVaddioPwrFB)
	
	SWITCH (nPwrCount)
	{
	    CASE 1 : nOnline_Cam_HL = FALSE;
	    CASE 2 : nOnline_Cam_HR = FALSE;
	    CASE 3 : nOnline_Cam_SL = FALSE;
	    CASE 4 : nOnline_Cam_SR = FALSE;
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Main]
DATA_EVENT [dvTP_Rear]
DATA_EVENT [dvTP_Wall]
DATA_EVENT [dvTP_Booth] //Set Inital Text..
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
    }
}
DATA_EVENT [vdvVaddioHouseLeft]
{
    ONLINE :
    {
	SEND_COMMAND vdvVaddioHouseLeft, "'PROPERTY-IP_Address,',IP_CAMERA_HOUSE_L"
	SEND_COMMAND vdvVaddioHouseLeft, "'PROPERTY-User_Name,',CAMERA_USER"
	SEND_COMMAND vdvVaddioHouseLeft, "'PROPERTY-Password,',CAMERA_PASSWORD"
	SEND_COMMAND vdvVaddioHouseLeft, "'REINIT'"
	
	WAIT 50
	{
	    fnSetCameraSpeeds()
	}
    }
}
DATA_EVENT [vdvVaddioHouseRight]
{
    ONLINE :
    {
	SEND_COMMAND vdvVaddioHouseRight, "'PROPERTY-IP_Address,',IP_CAMERA_HOUSE_R"
	SEND_COMMAND vdvVaddioHouseRight, "'PROPERTY-User_Name,',CAMERA_USER"
	SEND_COMMAND vdvVaddioHouseRight, "'PROPERTY-Password,',CAMERA_PASSWORD"
	SEND_COMMAND vdvVaddioHouseRight, "'REINIT'"
    }
}
DATA_EVENT [vdvVaddioStageLeft]
{
    ONLINE :
    {
	SEND_COMMAND vdvVaddioStageLeft, "'PROPERTY-IP_Address,',IP_CAMERA_STAGE_L"
	SEND_COMMAND vdvVaddioStageLeft, "'PROPERTY-User_Name,',CAMERA_USER"
	SEND_COMMAND vdvVaddioStageLeft, "'PROPERTY-Password,',CAMERA_PASSWORD"
	SEND_COMMAND vdvVaddioStageLeft, "'REINIT'"
    }
}
DATA_EVENT [vdvVaddioStageRight]
{
    ONLINE :
    {
	SEND_COMMAND vdvVaddioStageRight, "'PROPERTY-IP_Address,',IP_CAMERA_STAGE_R"
	SEND_COMMAND vdvVaddioStageRight, "'PROPERTY-User_Name,',CAMERA_USER"
	SEND_COMMAND vdvVaddioStageRight, "'PROPERTY-Password,',CAMERA_PASSWORD"
	SEND_COMMAND vdvVaddioStageRight, "'REINIT'"
    }
}
