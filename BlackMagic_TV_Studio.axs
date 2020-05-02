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
    
    HDMI Port to Vaddio Feed??
    Serial Connection for Vaddio ?? Use Port 3
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster 		=			0:1:0	//DVX Master
dvTP_MAIN   	= 			10001:1:0 //Conference...


dvBlackMagic =					5001:5:0 //BlackMagic Studio Production TV
dvRS232_2 =				5001:2:0 //Vaddio Cam Front
dvRS232_3 =				5001:3:0 //Vaddio Cam Rear
dvRS232_4 =				5001:4:0 //Vaddio Cam Interactive Area
dvRS232_5 =				5001:5:0
dvRS232_6 =				5001:6:0

dvRelays =					5001:21:0 //Relays
dvIO =						5001:22:0 //IO's


vdvTelevisionWest =		35011:1:0 //Sony FW-85 Bravia
dvTelevisionWest =			5001:3:0 //Opposite of Conference!!

vdvTelevisionSouth =		35012:1:0 //Sony FW-85 Bravia
dvTelevisionSouth =		5001:4:0 //Front (Behind TV)


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

OSENSOR_ 						= 1

SCREEN_DN					= 1
SCREEN_UP					= 2


//Common Projector Channels..
POWER_CYCLE					= 9
POWER_ON					= 27
POWER_OFF					= 28
WARMING						= 253
COOLING						= 254
ON_LINE						= 251
POWER						= 255
BLANK							= 211

// Times
TL_FEEDBACK					= 1
TL_FLASH						= 2


ONE_SECOND					= 10 //may have to set to 1000
ONE_MINUTE					= 60*ONE_SECOND
ONE_HOUR					= 60*ONE_MINUTE

//Misc
CR 								= 13
LF 								= 10
MAX_LENGTH 					= 10
DVX_SLEEP						= 100 //Power Save State

//TP Addresses
TXT_HELP					= 99
TXT_ROOM					= 100


//Buttons
BTN_SCREEN_UP					= 4
BTN_SCREEN_DN					= 5

BTN_POWER_ON					= 1
BTN_POWER_OFF					= 2
BTN_PC_MAIN					= 11
BTN_LAPTOP_1					= 13
BTN_LAPTOP_2					= 14
BTN_WIFI_VIDEO					= 15

BTN_ONLINE_TV					= 601

INPUT_MERSIVE					= '$01'
INPUT_LAPTOP_1					= '$02'
INPUT_LAPTOP_2					= '$03'
INPUT_DESKTOP					= '$04'
INPUT_CAMERA					= '$05'


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR nHelp[15] = '404-894-4669'
VOLATILE CHAR nRoomInfo[30] = 'Gilbert 4204'

VOLATILE INTEGER nSourceConfRm
VOLATILE INTEGER nSourceAudio

VOLATILE SINTEGER nLevelMicMix = -100
VOLATILE SINTEGER nLevelProgMix = -10 
VOLATILE INTEGER nLevelMixOut = 85 //Mix to Amp

VOLATILE INTEGER nPop //Popup Tracking...
VOLATILE INTEGER nTPOnline

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000}
VOLATILE INTEGER iFLASH 

DEV vdvTP_Main[] = {dvTP_MAIN}

VOLATILE INTEGER nRmSourceBtns[] = 
{
    BTN_PC_MAIN, 
    BTN_LAPTOP_1,
    BTN_LAPTOP_2,
    BTN_WIFI_VIDEO
}

#INCLUDE 'System_Setup_' 
#INCLUDE 'SingleCamera'
#INCLUDE 'Epiphan_Pearl_V1'

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_MAIN, BTN_SCREEN_UP],[dvTP_MAIN, BTN_SCREEN_DN])
([dvTP_MAIN, BTN_PC_MAIN]..[dvTP_MAIN, BTN_WIFI_VIDEO])
([dvTP_MAIN, BTN_POWER_ON],[dvTP_MAIN, BTN_POWER_OFF])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnSCREEN(INTEGER cRelay) //Function Screen Up or Down
{
    PULSE [dvRelays, cRelay]
    
    SWITCH (cRelay)
    {
	CASE SCREEN_UP : ON [dvTP_MAIN, BTN_SCREEN_UP]
	CASE SCREEN_DN : ON [dvTP_MAIN, BTN_SCREEN_DN]
    }
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '22:00:00')
    {
	fnPowerDisplays('OFF')
    }
}
DEFINE_FUNCTION fnPowerDisplays(CHAR cPWR[MAX_LENGTH])
{
    SWITCH (cPWR)
    {
	CASE 'ON':
	{
	    PULSE [vdvTelevisionWest, POWER_ON]
	    PULSE [vdvTelevisionSouth, POWER_ON]
	}
	CASE 'OFF':
	{
	    PULSE [vdvTelevisionWest, POWER_OFF]
	    PULSE [vdvTelevisionSouth, POWER_OFF]
		//Call Camera Preset...
	}
    }
}
DEFINE_FUNCTION fnReboot()
{
    IF (TIME = '06:00:00')
    {
	IF (!nTPOnline)
	{
	    REBOOT (dvMaster)
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START



WAIT 250
{
    TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
}


DEFINE_MODULE 'Sony_FWD65x750D' ModSonyTVSouth(vdvTelevisionSouth, dvTelevisionSouth);
DEFINE_MODULE 'Sony_FWD65x750D' ModSonyTVWest(vdvTelevisionWest, dvTelevisionWest);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTp_MAIN, BTN_POWER_ON] 
BUTTON_EVENT [dvTP_MAIN, BTN_POWER_OFF]
BUTTON_EVENT [dvTP_MAIN, BTN_SCREEN_UP]
BUTTON_EVENT [dvTP_MAIN, BTN_SCREEN_DN]
{
    PUSH:
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_POWER_ON: fnPowerDisplays ('ON')
	    CASE BTN_POWER_OFF: fnPowerDisplays ('OFF')
	    CASE BTN_SCREEN_UP : fnSCREEN (SCREEN_UP)
	    CASE BTN_SCREEN_DN : fnSCREEN (SCREEN_DN)
	}
    }
}
BUTTON_EVENT [dvTP_MAIN, BTN_PC_MAIN]
BUTTON_EVENT [dvTP_MAIN, BTN_LAPTOP_1]
BUTTON_EVENT [dvTP_MAIN, BTN_LAPTOP_2]
BUTTON_EVENT [dvTP_MAIN, BTN_WIFI_VIDEO]
{
    PUSH :
    {
	SEND_COMMAND dvBlackMagic, "'ESCSEQON'"
	
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    //SEE AMX PI >> SEND_STRING Escape Sequences
	    CASE BTN_PC_MAIN :
	    {
		ON [dvTP_MAIN, BTN_PC_MAIN]
		SEND_STRING dvBlackMagic, "27,17,50" //Insert a time delay before transmitting the next character
		WAIT 2
		{
		    SEND_COMMAND dvBlackMagic, "'ESCSEQOFF'"
		    SEND_STRING dvBlackMagic, "$30,$03,$01,$C1,$04"
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

DEFINE_EVENT
CHANNEL_EVENT [vdvTelevisionSouth, ON_LINE]
CHANNEL_EVENT [vdvTelevisionSouth, WARMING]
CHANNEL_EVENT [vdvTelevisionSouth, COOLING]
CHANNEL_EVENT [vdvTelevisionSouth, POWER]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
		ON [dvTP_MAIN, BTN_ONLINE_TV]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_MAIN, BTN_POWER_ON]
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP30'"
		OFF [dvTP_MAIN, BTN_ONLINE_TV]
	    }
	    CASE WARMING :
	    CASE COOLING :
	    {
		SEND_COMMAND vdvTP_Main, "'^BMF-1.2,0,%OP255'"
	    }
	    CASE POWER :
	    {
		ON [dvTP_MAIN, BTN_POWER_OFF]
	    }
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTp_Main]
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND DATA.DEVICE, "'ADBEEP'"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ROOM),',0,',nRoomInfo"
	SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_HELP),',0,',nHelp"
    }
    OFFLINE :
    {
	OFF [nTPOnline]
    }
}
DATA_EVENT [dvBlackMagic]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 38400,O,8,1 422 ENABLE'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	SEND_COMMAND DATA.DEVICE, "'CHARDM-100'" //0-255
    }
}


DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    fnKill() 
	fnReboot()


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



