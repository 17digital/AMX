PROGRAM_NAME='BlackMagic_VideoHub'
(***********************************************************)
(*  FILE CREATED ON: 02/07/2019  AT: 10:17:07              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/13/2020  AT: 10:16:36        *)
(***********************************************************)


(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    HDMI Port to Vaddio Feed??
    Serial Connection for Vaddio ?? Use Port 3
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster 		=			0:1:0	//DVX Master
dvTP_MAIN   	= 			10001:1:0 //Conference...


dvVideoHub =					5001:5:0 //BlackMagic Studio Production TV

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//VideoHub Inputs (Base-16)
IN_PROGRAM					= 1
IN_AUX_1					= 2
IN_AUX_2					= 3
IN_SSD_1					= 4
IN_SSD_2					= 5
IN_HDMI						= 6
IN_CAMERA_1					= 7
IN_CAMERA_2					= 8
IN_WALL_HDMI					= 9
IN_WALL_SDI_1					= 10
IN_WALL_SDI_2					= 11
IN_WALL_SDI_3					= 12
IN_WALL_SDI_4					= 13
IN_WALL_SDI_5					= 14
IN_WALL_SDI_6					= 15
IN_QUAD_VIEW					= 17
IN_CAMERA_VADDIO				= 18

OUT_QUAD_MONITOR				= 1
OUT_ROSS_1					= 2
OUT_ROSS_2					= 3
OUT_ROSS_3					= 4
OUT_ROSS_4					= 5
OUT_ROSS_5					= 6
OUT_ROSS_6					= 7
OUT_SSD_1					= 8
OUT_SSD_2					= 9
OUT_USB_REC_1					= 10
OUT_USB_REC_2					= 11
OUT_WALL_3					= 12
OUT_WALL_4					= 13
OUT_CAMERA_FEED					= 14 //Feeds Into Television Studio 
OUT_CONTROL_MON					= 16
OUT_QUAD_A					= 17
OUT_QUAD_B					= 18 
OUT_WALL_SDI_1					= 19
OUT_WALL_SDI_2					= 20

//Misc
CR 								= 13
LF 								= 10

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100


//Manual Routing Buttons
BTN_SOURCE_IN_1					= 801
BTN_SOURCE_IN_2					= 802
BTN_SOURCE_IN_3					= 803
BTN_SOURCE_IN_4					= 804
BTN_SOURCE_IN_5					= 805
BTN_SOURCE_IN_6					= 806
BTN_SOURCE_IN_7					= 807
BTN_SOURCE_IN_8					= 808
BTN_SOURCE_IN_9					= 809
BTN_SOURCE_IN_10				= 810
BTN_SOURCE_IN_11				= 811
BTN_SOURCE_IN_12				= 812
BTN_SOURCE_IN_13				= 813
BTN_SOURCE_IN_14				= 814
BTN_SOURCE_IN_15				= 815
BTN_SOURCE_IN_16				= 816
BTN_SOURCE_IN_17				= 817
BTN_SOURCE_IN_18				= 818
BTN_SOURCE_IN_19				= 819
BTN_SOURCE_IN_20				= 820

BTN_DESTINATION_1				= 901
BTN_DESTINATION_2				= 902
BTN_DESTINATION_3				= 903
BTN_DESTINATION_4				= 904
BTN_DESTINATION_5				= 905
BTN_DESTINATION_6				= 906
BTN_DESTINATION_7				= 907
BTN_DESTINATION_8				= 908
BTN_DESTINATION_9				= 909
BTN_DESTINATION_10				= 910
BTN_DESTINATION_11				= 911
BTN_DESTINATION_12				= 912
BTN_DESTINATION_13				= 913
BTN_DESTINATION_14				= 914
BTN_DESTINATION_15				= 915
BTN_DESTINATION_16				= 916
BTN_DESTINATION_17				= 917
BTN_DESTINATION_18				= 918
BTN_DESTINATION_19				= 919
BTN_DESTINATION_20				= 920



(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE INTEGER nSourceInput_
VOLATILE INTEGER nDestinationOutput_

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_MAIN, BTN_SOURCE_IN_1]..[dvTP_MAIN, BTN_SOURCE_IN_20])
([dvTP_MAIN, BTN_DESTINATION_1]..[dvTP_MAIN, BTN_DESTINATION_20])


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnRouteVideoHubMultiple(INTEGER cDestination1, INTEGER cSource1, INTEGER cDestination2, INTEGER cSource2)
{
    SEND_STRING dvVideoHub, "'@ X:0/',ITOHEX(cDestination1 -1),',',ITOHEX(cSource1 -1),'/',ITOHEX(cDestination2 -1),',',ITOHEX(cSource2 -1),CR"
}
DEFINE_FUNCTION fnRouteVideoHubSingle(INTEGER cDestination, INTEGER cSource)
{
    SEND_STRING dvVideoHub, "'@ X:0/',ITOHEX(cDestination -1),',',ITOHEX(cSource -1),CR"
}
DEFINE_FUNCTION fnRouteVideoPresets()
{
    WAIT 10 fnRouteVideoHubSingle(OUT_SSD_1, IN_PROGRAM)
    WAIT 10 fnRouteVideoHubSingle(OUT_SSD_2, IN_PROGRAM)
    WAIT 10 fnRouteVideoHubSingle(OUT_CONTROL_MON, IN_PROGRAM)
    WAIT 10 fnRouteVideoHubSingle(OUT_USB_REC_1, IN_PROGRAM)
    WAIT 10 fnRouteVideoHubSingle(OUT_WALL_SDI_1, IN_PROGRAM)
    WAIT 10 fnRouteVideoHubSingle(OUT_WALL_SDI_2, IN_PROGRAM)
    WAIT 10 fnRouteVideoHubSingle(OUT_USB_REC_2, IN_AUX_1)
    WAIT 10 fnRouteVideoHubMultiple(OUT_WALL_3, IN_AUX_2, OUT_WALL_4, IN_AUX_2)
    WAIT 10 fnRouteVideoHubMultiple(OUT_ROSS_1, IN_CAMERA_1, OUT_QUAD_A, IN_CAMERA_1)
    WAIT 10 fnRouteVideoHubMultiple(OUT_ROSS_2, IN_CAMERA_2, OUT_QUAD_B, IN_CAMERA_2)
    WAIT 10 fnRouteVideoHubSingle(OUT_CAMERA_FEED, IN_CAMERA_VADDIO)

}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_1] 
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_2]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_3]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_4]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_5]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_6] 
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_7]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_8]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_9]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_10]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_11] 
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_12]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_13]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_14]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_15]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_16] 
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_17]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_18]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_19]
BUTTON_EVENT [dvTp_MAIN, BTN_SOURCE_IN_20]
{
    PUSH:
    {
	ON [dvTP_MAIN, BUTTON.INPUT.CHANNEL]
	
	nSourceInput_ = BUTTON.INPUT.CHANNEL - 800
    }
}
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_1]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_2]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_3]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_4]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_5]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_6]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_7]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_8]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_9]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_10]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_11]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_12]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_13]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_14]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_15]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_16]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_17]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_18]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_19]
BUTTON_EVENT [dvTP_MAIN, BTN_DESTINATION_20]
{
    PUSH :
    {
	ON [dvTP_MAIN, BUTTON.INPUT.CHANNEL]
	nDestinationOutput_ = BUTTON.INPUT.CHANNEL - 900
	
	WAIT 10
	{
	    fnRouteVideoHubSingle(nDestinationOutput_, nSourceInput_)
	}
	
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
    }
}
DATA_EVENT [dvVideoHub]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 9600,N,8,1 422 ENABLE'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 50 SEND_STRING dvVideoHub, "CR" //Start off Session
	WAIT 70 SEND_STRING dvVideoHub, "'@ ?',CR" //Enable Status Reporting...
	
	WAIT 90 fnRouteVideoPresets() //Set Defaults...
	//WAIT 90 SEND_STRING dvBlackMagic, "'@ X?0',ITOA(DES_EXTRON_CAPTURE),CR" //Get Connected Route...

    }
}


(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See “Differences in DEFINE_PROGRAM Program Execution” section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)



