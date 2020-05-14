PROGRAM_NAME='DVX3155'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/29/2018  AT: 13:45:05        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    8/6/13 - modified scaling to 1080p
    Sanyo PDG-DHT8000L = 1920x1080
    
    $History: $
    TO DO List
    
    Call Touch panel Pushes to Booth Master, Remove Virtual Device Calls!!
    
    Remove 
    
*)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvTP_Main = 				10001:1:0 //Lectern Touchpanel
dvTP_Switch =				10001:2:0 //Switching
dvDvxSwitcher =	 			5002:1:0  //DGX 16 System in Rack

dvVIDEO_1	=			5002:1:0
dvVIDEO_2 =				5002:2:0
dvVIDEO_3	=			5002:3:0
dvVIDEO_4	=			5002:4:0
dvVIDEO_5	=			5002:5:0
dvVIDEO_6	=			5002:6:0
dvVIDEO_7	=			5002:7:0
dvVIDEO_8	=			5002:8:0
dvVIDEO_9	=			5002:9:0
dvVIDEO_10 =				5002:10:0

dvAVOUT_1 =				5002:1:0
dvAVOUT_2 =				5002:2:0
dvAVOUT_3 =				5002:3:0
dvAVOUT_4 =				5002:4:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//DGX Channels...
//Inputs...
VIDEO_IN_MAC_3				= 1 
VIDEO_IN_LAPTOP_2				= 2
VIDEO_IN_MAC_2				= 3
VIDEO_IN_LAPTOP_1				= 4 //Default Sound

VIDEO_IN_MAC_1				= 5
VIDEO_IN_LAPTOP_4				= 6
VIDEO_IN_MAC_5				= 7
VIDEO_IN_MAC_4				= 8

VIDEO_IN_LAPTOP_3				= 9
VIDEO_IN_DXLINK_10			= 10

//OUTs...
OUTPUT_TV_1				= 61 //DxLink
OUTPUT_TV_2				= 63 //DxLink
OUTPUT_TV_3				= 62 //Hdmi
OUTPUT_TV_4				= 64 //Hdmi

INPUT_NAME_1				= 'iMac 3'
INPUT_NAME_2				= 'Laptop 2'
INPUT_NAME_3				= 'iMac 2'
INPUT_NAME_4				= 'Laptop 1'
INPUT_NAME_5				= 'iMac 1'
INPUT_NAME_6				= 'Laptop 4'
INPUT_NAME_7				= 'iMac 5'
INPUT_NAME_8				= 'iMac 4'
INPUT_NAME_9				= 'Laptop 3'
INPUT_NAME_10				= 'Not Used'

TXT_1_OUTPUT				= 1
TXT_2_OUTPUT				= 2
TXT_3_OUTPUT				= 3
TXT_4_OUTPUT				= 4

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nSource_Input
VOLATILE INTEGER nSource_Outputs[4]
VOLATILE CHAR cSwitcher[25]

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvIOs,nTimelineIO[1]]..[dvIOs,nTimelineIO[8]])

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
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_MAC_3]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_LAPTOP_2]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_MAC_2]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_LAPTOP_1]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_MAC_1]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_LAPTOP_4]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_MAC_5]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_MAC_4]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_LAPTOP_3]
BUTTON_EVENT [dvTP_Switch, VIDEO_IN_DXLINK_10]
{
    PUSH :
    {
	nSource_Input = BUTTON.INPUT.CHANNEL //- 40
    }
}
BUTTON_EVENT [dvTP_Switch, OUTPUT_TV_1]
BUTTON_EVENT [dvTP_Switch, OUTPUT_TV_3]
BUTTON_EVENT [dvTP_Switch, OUTPUT_TV_2]
BUTTON_EVENT [dvTP_Switch, OUTPUT_TV_4] //All my Video Out Friends...
{
    PUSH :
    {
	nSource_Outputs[BUTTON.INPUT.CHANNEL - 60] = nSource_Input
    }
}
BUTTON_EVENT [dvTP_Switch, 100] //Video Take
{
    PUSH :
    {
	LOCAL_VAR INTEGER x 
	
	//cSwitcher = 'VI' 
	cSwitcher = "'VI',ITOA(nSource_Input),'O'"
	
	FOR (x=1;x<5;x++)
	{
	    IF (nSource_Input == nSource_Outputs[x])
	    {
		cSwitcher = "cSwitcher,ITOA(x),',' "
	    }
	}
	cSwitcher = LEFT_STRING(cSwitcher,LENGTH_STRING(cSwitcher)-1)
	
	SEND_COMMAND dvDvxSwitcher, "cSwitcher"
    }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

