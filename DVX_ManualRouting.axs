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


dvMaster = 				0:1:0	//3100

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

dvSHARPTV_One = 			6001:1:0  //This will talk to Projector Left
dvSHARPTV_Two = 			6002:1:0  //This will talk to Projector Right
dvSHARPTV_Three = 			5001:3:0  //Center Projector
dvSHARPTV_Four =			5001:4:0 //



vdvSHARPTV_One = 			33011:1:0 //Sharp LC60LE661U
vdvSHARPTV_Two = 			33012:1:0 //Sharp LC60LE661U
vdvSHARPTV_Three = 			33013:1:0 // Sharp LC60LE661U
vdvSHARPTV_Four = 			33014:1:0 //Sharp LC60LE661U

(*Notes - Please Set Quick Start on **)

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


// Timeline
TL_FEEDBACK			= 1
TL_FLASH				= 2


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE



(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nSource_TV_1 
VOLATILE INTEGER nSource_TV_2
VOLATILE INTEGER nSource_TV_3
VOLATILE INTEGER nSource_TV_4

VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nSource_Input
VOLATILE INTEGER nSource_Outputs[4]
VOLATILE CHAR cSwitcher[25]

VOLATILE LONG lTLFeedback[] = {250}
VOLATILE LONG lTLFlash[] = {500} 
VOLATILE INTEGER iFLASH

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

TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);


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

DEFINE_EVENT
TIMELINE_EVENT [TL_FEEDBACK] 
{
 [dvTP_Switch, VIDEO_IN_MAC_3] = nSource_Input = VIDEO_IN_MAC_3
 [dvTP_Switch, VIDEO_IN_LAPTOP_2] = nSource_Input = VIDEO_IN_LAPTOP_2
 [dvTP_Switch, VIDEO_IN_MAC_2] = nSource_Input = VIDEO_IN_MAC_2
 [dvTP_Switch, VIDEO_IN_LAPTOP_1] = nSource_Input = VIDEO_IN_LAPTOP_1
 [dvTP_Switch, VIDEO_IN_MAC_1] = nSource_Input = VIDEO_IN_MAC_1
 [dvTP_Switch, VIDEO_IN_LAPTOP_4] = nSource_Input = VIDEO_IN_LAPTOP_4
 [dvTP_Switch, VIDEO_IN_MAC_5] = nSource_Input = VIDEO_IN_MAC_5
 [dvTP_Switch, VIDEO_IN_MAC_4] = nSource_Input = VIDEO_IN_MAC_4
 [dvTP_Switch, VIDEO_IN_LAPTOP_3] = nSource_Input = VIDEO_IN_LAPTOP_3
 [dvTP_Switch, VIDEO_IN_DXLINK_10] = nSource_Input = VIDEO_IN_DXLINK_10
    
}
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}

DEFINE_EVENT
DATA_EVENT [dvDvxSwitcher] 
{
    COMMAND:
    {
	SELECT
	{
	    //Output 1
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI1O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_1"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI2O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_2"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI3O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_3"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI4O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_4"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI5O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_5"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI6O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_6"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI7O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_7"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI8O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_8"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI9O1',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_1_OUTPUT),',0,',INPUT_NAME_9"
	    }
	    //Output 2
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI1O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_1"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI2O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_2"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI3O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_3"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI4O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_4"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI5O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_5"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI6O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_6"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI7O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_7"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI8O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_8"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI9O2',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_2_OUTPUT),',0,',INPUT_NAME_9"
	    }
	    //Output 3
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI1O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_1"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI2O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_2"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI3O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_3"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI4O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_4"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI5O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_5"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI6O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_6"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI7O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_7"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI8O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_8"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI9O3',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_3_OUTPUT),',0,',INPUT_NAME_9"
	    }
	    //Output 4
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI1O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_1"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI2O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_2"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI3O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_3"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI4O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_4"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI5O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_5"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI6O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_6"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI7O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_7"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI8O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_8"
	    }
	    ACTIVE(FIND_STRING(DATA.TEXT,'SWITCH-LVIDEOI9O4',1)): 
	    {
		SEND_COMMAND dvTp_Main, "'^TXT-',ITOA(TXT_4_OUTPUT),',0,',INPUT_NAME_9"
	    }
	}
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

