PROGRAM_NAME='Master-XL-Conf'
(***********************************************************)
(*  FILE CREATED ON: 02/07/2019  AT: 10:17:07              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/01/2020  AT: 08:48:04        *)
(***********************************************************)


(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
    
    This is how you control the BlackMagic Television Studio HD via Serial Port
    
    The ATEM does support serial control via a limited implementation of the GVG100 protocol via RS422. 
    !! BlackMagic MUST be set to GVG100 inside System settings
    
    The GVG100 protocol is not owned by Blackmagic (it belongs to Grass Valley) so, 
    unfortunately, we aren't able to distribute any resources for it. However, you may 
    be able to find the specifications online.
    
    Connection Parameters (See DATA_EVENT Below) UnCommon Baud Rate Used
    
    When using the GVG100 protocol, the listener interface (the ATEM) must be transitioned from idle 
    to active prior to your message being sent. Sending a serial break and then the address byte does this.
    
    For example, to switch "Program BACKGROUND Bus" to Input 2:
    
    <SERIAL BREAK> 
	0x30 0x03 0x02 0xC1 0x02 (ie. Byte Count Byte, Effects Address Byte, Command Code Byte,  message 
	[0 is black, 9 is bkgd, 1-8 are inputs]) 
	The ATEM should always return a response, even if the message/command is invalid. 
    
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster 		=			0:1:0	//DVX Master
dvTP_MAIN   	= 			10001:1:0 //Conference...


dvBlackMagic =					5001:5:0 //BlackMagic Studio Production TV

dvRelays =					5001:21:0 //Relays
dvIO =						5001:22:0 //IO's



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

ONE_SECOND					= 10 //may have to set to 1000
ONE_MINUTE					= 60*ONE_SECOND
ONE_HOUR					= 60*ONE_MINUTE


BTN_POWER_ON					= 1
BTN_POWER_OFF					= 2
BTN_PC_MAIN					= 11
BTN_LAPTOP_1					= 13
BTN_LAPTOP_2					= 14
BTN_WIFI_VIDEO					= 15

INPUT_MERSIVE					= '$01'
INPUT_LAPTOP_1					= '$02'
INPUT_LAPTOP_2					= '$03'
INPUT_DESKTOP					= '$04'
INPUT_CAMERA					= '$05'


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

//Will Update this later..
VOLATILE INTEGER nRmSourceBtns[] = 
{
    BTN_PC_MAIN, 
    BTN_LAPTOP_1,
    BTN_LAPTOP_2,
    BTN_WIFI_VIDEO
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_MAIN, BTN_PC_MAIN]..[dvTP_MAIN, BTN_WIFI_VIDEO])


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
BUTTON_EVENT [dvTP_MAIN, BTN_PC_MAIN]
BUTTON_EVENT [dvTP_MAIN, BTN_LAPTOP_1]
BUTTON_EVENT [dvTP_MAIN, BTN_LAPTOP_2]
BUTTON_EVENT [dvTP_MAIN, BTN_WIFI_VIDEO]
{
    PUSH :
    {
	SEND_COMMAND dvBlackMagic, "'ESCSEQON'" //SEE AMX PI >> SEND_STRING Escape Sequences
	
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    
	    CASE BTN_PC_MAIN :
	    {
		ON [dvTP_MAIN, BTN_PC_MAIN]
		SEND_STRING dvBlackMagic, "27,17,50" //Insert Break for 50Ms...
		WAIT 2
		{
		    SEND_COMMAND dvBlackMagic, "'ESCSEQOFF'"
		    SEND_STRING dvBlackMagic, "$30,$03,$01,$C1,$04" //TX Actual String through Serial..
		}
	    }
	    CASE BTN_LAPTOP_1 :
	    {
		ON [dvTP_MAIN, BTN_LAPTOP_1]
		SEND_STRING dvBlackMagic, "27,17,50"
		WAIT 2
		{
		    SEND_COMMAND dvBlackMagic, "'ESCSEQOFF'"
		    SEND_STRING dvBlackMagic, "$30,$03,$01,$C1,$03"
		}
	    }
	    CASE BTN_LAPTOP_2 :
	    {
		ON [dvTP_MAIN, BTN_LAPTOP_2]
		SEND_STRING dvBlackMagic, "27,17,50"
		WAIT 2
		{
		    SEND_COMMAND dvBlackMagic, "'ESCSEQOFF'"
		    SEND_STRING dvBlackMagic, "$30,$03,$01,$C1,$02"
		}
	    }
	    CASE BTN_WIFI_VIDEO :
	    {
		ON [dvTP_MAIN, BTN_WIFI_VIDEO]
		SEND_STRING dvBlackMagic, "27,17,50"
		WAIT 2
		{
		    SEND_COMMAND dvBlackMagic, "'ESCSEQOFF'"
		    SEND_STRING dvBlackMagic, "$30,$03,$01,$C1,$01"
		}
	    }
	}
    }
}

DATA_EVENT [dvBlackMagic] //Take Note of Baud Rate...Not typical!
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 38400,O,8,1 422 ENABLE'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	SEND_COMMAND DATA.DEVICE, "'CHARDM-100'" //0-255
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
(* See Differences in DEFINE_PROGRAM Program Execution section *)
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



