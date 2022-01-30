PROGRAM_NAME='PanasonicCameras'

(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 03/31/2020  AT: 16:25:20        *)
(***********************************************************)

//3c07713b98ab


DEFINE_DEVICE


#IF_NOT_DEFINED dvTP_Camera
dvTP_Camera =					10001:1:0
#END_IF

#IF_NOT_DEFINED dvTP_Camera2
dvTP_Camera2 =					10002:1:0
#END_IF

dvCamFront =						0:4:0
dvCamRear =						0:5:0

vdvCamFront =					41001:1:0
vdvCamRear =					41002:1:0


DEFINE_CONSTANT

#IF_NOT_DEFINED TXT_CAMERA_SAVED
TXT_CAMERA_SAVED			= 22
#END_IF

#IF_NOT_DEFINED POWER 
POWER 						= 255
#END_IF

TILT_UP						= 132
TILT_DN						= 133
PAN_LEFT					= 134
PAN_RIGHT					= 135
ZOOM_OUT					= 158
ZOOM_IN					= 159

BTN_PRESET_1					= 71
BTN_PRESET_2					= 72
BTN_PRESET_3					= 73
BTN_PRESET_4					= 74
BTN_PRESET_5					= 75
BTN_PRESET_6					= 76
BTN_PRESET_HOME			= 77

IP_CAM_FRONT				= '172.21.6.186'
IP_CAM_REAR					= '172.21.6.187'


DEFINE_VARIABLE

VOLATILE DEV vdvTP_Camera[] = 
{
    dvTP_Camera, dvTP_Camera2 }

VOLATILE INTEGER nPresetSelect[] =
{
    BTN_PRESET_1,
    BTN_PRESET_2,
    BTN_PRESET_3,
    BTN_PRESET_4,
    BTN_PRESET_5 
}
VOLATILE DEV dcCameras[] =
{
    vdvCamFront,
    vdvCamRear
}

DEFINE_MUTUALLY_EXCLUSIVE

//([dvTP_Camera, BTN_CAM_FRONT],[dvTP_Camera,BTN_CAM_REAR]) 
//([dvTP_Camera2, BTN_CAM_FRONT],[dvTP_Camera2,BTN_CAM_REAR]) 

([dvTP_Camera, BTN_PRESET_1]..[dvTP_Camera, BTN_PRESET_5])
([dvTP_Camera2, BTN_PRESET_1]..[dvTP_Camera2, BTN_PRESET_5])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

DEFINE_START

DEFINE_MODULE 'Panasonic_AWHE50_IP_Comm_dr1_0_0' CameraFront(vdvCamFront, dvCamFront);
DEFINE_MODULE 'Panasonic_AWHE50_IP_Comm_dr1_0_0' CameraRear(vdvCamRear, dvCamRear);

DEFINE_EVENT
BUTTON_EVENT [vdvTP_Camera, TILT_UP]
BUTTON_EVENT [vdvTP_Camera, TILT_DN]
BUTTON_EVENT [vdvTP_Camera, PAN_LEFT]
BUTTON_EVENT [vdvTP_Camera, PAN_RIGHT]
BUTTON_EVENT [vdvTP_Camera, ZOOM_IN]
BUTTON_EVENT [vdvTP_Camera, ZOOM_OUT] //Move Cameras...
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
 DATA_EVENT [dvTP_Camera]
 DATA_EVENT [dvTP_Camera2]
 {
    ONLINE :
    {
	   SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0A,$0D,'Hold to Save'"
    }
}
DATA_EVENT [vdvCamFront]
{
    ONLINE :
    {
	SEND_COMMAND vdvCamFront, "'PROPERTY-IP_Address,',IP_CAM_FRONT"
	//SEND_COMMAND vdvCamFront, "'PROPERTY,PAN-10000'"
	//SEND_COMMAND vdvCamFront, "'PROPERTY,TILT-10000'"
	SEND_COMMAND vdvCamFront, "'REINIT'"
    }
}
DATA_EVENT [vdvCamRear]
{
    ONLINE :
    {
	SEND_COMMAND vdvCamRear, "'PROPERTY-IP_Address,',IP_CAM_REAR"
	//SEND_COMMAND vdvCamFront, "'PROPERTY,PAN-10000'"
	//SEND_COMMAND vdvCamFront, "'PROPERTY,TILT-10000'"
	SEND_COMMAND vdvCamRear, "'REINIT'"
    }
}
CHANNEL_EVENT [vdvCamFront, POWER]
{
    ON :
    {
	nOnline_Front = TRUE;
    }
    OFF :
    {
	nOnline_Front = FALSE;
    }
}
CHANNEL_EVENT [vdvCamRear, POWER]
{
    ON :
    {
	nOnline_Rear = TRUE;
    }
    OFF :
    {
	nOnline_Rear = FALSE;
    }
}

