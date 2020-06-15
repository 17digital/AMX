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

CAMERA_FRONT			= 2
CAMERA_REAR				= 1


CAM_PRESET_1				= 1
CAM_PRESET_2				= 2
CAM_PRESET_3				= 3
CAM_PRESET_4				= 4
CAM_PRESET_5				= 5 

TL_CAM_FEEDBACK			= 5

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

CAM_FRNT_BTN					= 51
CAM_REAR_BTN					= 52
RESTART_BTN					= 90

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

//DEV vdvTP_Camera[] = {dvTP_Main}

VOLATILE INTEGER nVaddioCameraSelect
VOLATILE INTEGER nVaddioPresets
VOLATILE CHAR nVaddioBuffer[1000] //Temp Buffer
VOLATILE INTEGER cLocked

VOLATILE SINTEGER nPgrmPreset = 0 //Max = +12
VOLATILE SINTEGER nWirelessPreset = 1 //Max = +12
VOLATILE SINTEGER nPgrmVol 
VOLATILE SINTEGER nWirelessVol 
VOLATILE INTEGER nPgrmMute
VOLATILE INTEGER nWirelessMute
VOLATILE INTEGER nCeilingMute

VOLATILE LONG lTLVaddioFeedback[] = {250};

VOLATILE INTEGER nCameraVaddioBtns[] =
{
    61, //Tilt Up
    62, //Tilt Down
    63, //Left
    64, //Right
    65, //Zoom In
    66  //Zoom Out
}
VOLATILE INTEGER nPresetVaddioBtns[] =
{
    //Call Presets..
    71,72,73,74,75,
    
    //Save...
    81,82,83,84,85
}  

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
DEFINE_FUNCTION fnRunStart()
{
    SEND_STRING dvVaddioMatrix, "LOGIN,CR"
    WAIT 10
    {
	SEND_STRING dvVaddioMatrix, "PASS,CR"
    }
}
DEFINE_FUNCTION fnParseVaddio()
{
    STACK_VAR CHAR cResponse[100]
    
    WHILE(FIND_STRING(nVaddioBuffer,"CR,LF",1))
    {
    
	cResponse = REMOVE_STRING(nVaddioBuffer,"CR,LF",1)
    
	SELECT
	{

	    ACTIVE(FIND_STRING(cResponse,'source: input1',1)):
	    {
		nVaddioCameraSelect = CAMERA_REAR
		OFF [cLocked]
	    }
	    ACTIVE(FIND_STRING(cResponse,'source: input2',1)):
	    {
		nVaddioCameraSelect = CAMERA_FRONT
		OFF [cLocked]
	    }
	    ACTIVE(FIND_STRING(cResponse,'Password:',1)):
	    {
		//That mean password is needed son! - may want to lock this out to prevent other commands..
		ON [cLocked]
		WAIT 20
		{
		    fnRunStart()
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'login:',1)):
	    {
		ON [cLocked]
		WAIT 20
		{
		    fnRunStart()
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'Login incorrect',1)):
	    {
		ON [cLocked]
		WAIT 20
		{
		    fnRunStart()
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'Welcome admin',1)):
	    {
		OFF [cLocked]
	    }
	    ACTIVE(FIND_STRING(cResponse,'Authorized Access Only',1)):
	    {
		OFF [cLocked]
	    }
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvVaddioMatrix,nVaddioBuffer;

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, CAM_FRNT_BTN] //Front
BUTTON_EVENT [dvTP_Main, CAM_REAR_BTN] //Rear
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE CAM_FRNT_BTN :
	    {
		IF (!cLocked)
		{
		    nVaddioCameraSelect = CAMERA_FRONT
		    SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' standby off',CR"
		    WAIT 10
		    {
			SEND_STRING dvVaddioMatrix, "'video program source set input',ITOA(CAMERA_FRONT),CR"
			SEND_STRING dvVaddioMatrix, "'video stream source set input',ITOA(CAMERA_FRONT),CR"
		    }
		}
		
	    }
	    CASE CAM_REAR_BTN :
	    {
		IF(!cLocked)
		{
		    SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' standby off',CR"
		    nVaddioCameraSelect = CAMERA_REAR
		    WAIT 10
		    {
			SEND_STRING dvVaddioMatrix, "'video program source set input',ITOA(CAMERA_REAR),CR"
			SEND_STRING dvVaddioMatrix, "'video stream source set input',ITOA(CAMERA_REAR),CR"
		    }
		}
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Main, nCameraVaddioBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nCameraIdx
	
	OFF [nVaddioPresets]
	nCameraIdx = GET_LAST (nCameraVaddioBtns)
	
	SELECT
	{
	    ACTIVE ( nVaddioCameraSelect == CAMERA_FRONT):
	    {
		SWITCH (nCameraIdx)
		{
		    CASE 1 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' tilt up',CR"
		    CASE 2 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' tilt down',CR"
		    CASE 3 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' pan left',CR"
		    CASE 4 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' pan right',CR"
		    CASE 5 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' zoom in 4',CR"
		    CASE 6 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' zoom out 4'  ,CR"
		}
	    }
	    
	    ACTIVE (nVaddioCameraSelect == CAMERA_REAR):
	    {
		SWITCH (nCameraIdx)
		{
		    CASE 1 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' tilt up',CR"
		    CASE 2 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' tilt down',CR"
		    CASE 3 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' pan left',CR"
		    CASE 4 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' pan right',CR"
		    CASE 5 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' zoom in 4',CR"
		    CASE 6 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' zoom out 4',CR"
		}
	    }
	}
    }
    RELEASE :
    {
	//SET_PULSE_TIME (3) 
	STACK_VAR INTEGER nCameraIdx
	
	nCameraIdx = GET_LAST (nCameraVaddioBtns)
	SWITCH (nCameraIdx)
	{
	    CASE 1 :
	    CASE 2 :
	    {
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' tilt stop',CR"
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' tilt stop',CR"
	    }
	    CASE 3 :
	    CASE 4 :
	    {
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' pan stop',CR"
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' pan stop',CR"
	    }
	    CASE 5 :
	    CASE 6 :
	    {
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' zoom stop',CR"
		SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' zoom stop',CR"
	    }
	    
	}
    }
}
BUTTON_EVENT [dvTP_Main, nPresetVaddioBtns]
{	
    PUSH :
    {
	STACK_VAR INTEGER nPresetIdx
	
	nPresetIdx = GET_LAST (nPresetVaddioBtns)
	
	SELECT
	{
	    ACTIVE (nVaddioCameraSelect == CAMERA_REAR):
	    {
		SWITCH (nPresetIdx)
		{
		    CASE 1 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset recall 1',CR"
		    CASE 2 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset recall 2',CR"
		    CASE 3 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset recall 3',CR"
		    CASE 4 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset recall 4',CR"
		    CASE 5 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset recall 5',CR"
		    
		    CASE 6 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset store 1',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 7 :
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset store 2',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 8 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset store 3',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 9 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset store 4',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 10 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_REAR),' preset store 5',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		}                                                                                           
	    }	    
	    ACTIVE (nVaddioCameraSelect == CAMERA_FRONT) :
	    {
		SWITCH (nPresetIdx)
		{
		    CASE 1 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset recall 1',CR"
		    CASE 2 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset recall 2',CR"
		    CASE 3 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset recall 3',CR"
		    CASE 4 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset recall 4',CR"
		    CASE 5 : SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset recall 5',CR"
		    
		    CASE 6 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset store 1',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 7 :
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset store 2',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 8 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset store 3',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 9 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset store 4',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		    CASE 10 : 
		    {
			SEND_STRING dvVaddioMatrix, "'camera ',ITOA(CAMERA_FRONT),' preset store 5',CR"
			SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
				WAIT 50 
				{
				    SEND_COMMAND dvTP_Main, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
				}
		    }
		}                                                                              
	    }
	}
    }
}
BUTTON_EVENT [dvTP_MAIN, RESTART_BTN] //Re Input Password
{
    PUSH :
    {
	fnRunStart()
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
	
	WAIT 50
	{
	    SEND_STRING dvVaddioMatrix, "'video program source get',CR"
	}
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
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Save Camera Presets'"
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    [dvTP_Main, CAM_FRNT_BTN] = nVaddioCameraSelect = CAMERA_FRONT
    [dvTP_Main, CAM_REAR_BTN] = nVaddioCameraSelect = CAMERA_REAR
    
    [dvTP_MAIN, RESTART_BTN] = cLocked
    
	[dvTP_Main, 61] = nVaddioPresets = CAM_PRESET_1
	[dvTP_Main, 62] = nVaddioPresets = CAM_PRESET_2
	[dvTP_Main, 63] = nVaddioPresets = CAM_PRESET_3
}                                                                


