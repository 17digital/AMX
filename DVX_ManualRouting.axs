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

//Clock Stuff...
CHAR TIME_IP[]				= '130.207.165.28'
CHAR TIME_SERVER[]			= 'ntp1.gatech.edu'
CHAR TIME_LOC[]			= 'NIST, Gatech, ATL'
CHAR TIME_ZONE[]			= 'UTC-05:00' //Eastern
INTEGER TIME_SYNC_PERIOD 	= 60 //1 hour

//System Stuff...
INTEGER MY_SYSTEM			= 1059

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


MUTE_ON					= 'ENABLE'
MUTE_OFF					= 'DISABLE'



//Projector Common Feedback
POWER_CYCLE			= 9
POWER_ON				= 27
POWER_OFF			= 28
WARMING				= 253
COOLING				= 254
ON_LINE				= 251
POWER				= 255
BLANK				= 211

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

VOLATILE CHAR nHelp[15] = '404-894-4669'
VOLATILE CHAR nRoomInfo[30] = 'Boggs 1-23'

VOLATILE INTEGER nSource_TV_1 
VOLATILE INTEGER nSource_TV_2
VOLATILE INTEGER nSource_TV_3
VOLATILE INTEGER nSource_TV_4

VOLATILE INTEGER nSource_Audio
VOLATILE INTEGER nSource_Input
VOLATILE INTEGER nSource_Outputs[4]
VOLATILE CHAR cSwitcher[25]


VOLATILE INTEGER nMode
VOLATILE INTEGER nPop //Popup Tracking...
VOLATILE INTEGER nLockout
VOLATILE INTEGER nTPOnline

VOLATILE LONG lTLFeedback[] = {250}
VOLATILE LONG lTLFlash[] = {500} 
VOLATILE INTEGER iFLASH

VOLATILE CHAR cPopup_Names[][16] =
{
    '_help me',
    '_microphones',
    '_volume',
    '_dvd',
    '_aux'
}
VOLATILE INTEGER nPopupBtns[] =
{
    1001, //Help...
    1002, //mics
    1003,  //volume
    1004,  //Combine Outside TVs...
    1005
}
VOLATILE INTEGER nTelevisionBtns[] =
{
    1, //On
    2, //Off
    
    101, //On
    102, //Off
    
    201,
    202,
    
    301,
    302
}


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
DEFINE_FUNCTION fnSetClock()
{
	WAIT 10 CLKMGR_SET_CLK_SOURCE(CLKMGR_MODE_NETWORK)//1 
	WAIT 30 CLKMGR_SET_TIMEZONE(TIME_ZONE)
	WAIT 60 CLKMGR_SET_RESYNC_PERIOD(TIME_SYNC_PERIOD) 
	WAIT 90 CLKMGR_SET_DAYLIGHTSAVINGS_MODE(TRUE)
	WAIT 110 CLKMGR_ADD_USERDEFINED_TIMESERVER(TIME_IP, TIME_SERVER, TIME_LOC)
	WAIT 140 CLKMGR_SET_ACTIVE_TIMESERVER(TIME_IP) 
}
DEFINE_FUNCTION fnKill()
{
    IF (TIME = '22:00:00')
    {
	fnTelevisionPower ('Off')
    }
    ELSE IF (TIME = '23:00:00')
    {
	fnTelevisionPower ('Off')
    }
}
DEFINE_CALL 'LABEL DVX'
{
    SEND_COMMAND dvVIDEO_1, "'VIDIN_NAME-',INPUT_NAME_1"
    SEND_COMMAND dvVIDEO_2, "'VIDIN_NAME-',INPUT_NAME_2"
    SEND_COMMAND dvVIDEO_3, "'VIDIN_NAME-',INPUT_NAME_3"
    SEND_COMMAND dvVIDEO_4, "'VIDIN_NAME-',INPUT_NAME_4"
    
    SEND_COMMAND dvVIDEO_5, "'VIDIN_NAME-',INPUT_NAME_5"
    SEND_COMMAND dvVIDEO_6, "'VIDIN_NAME-',INPUT_NAME_6"
    SEND_COMMAND dvVIDEO_7, "'VIDIN_NAME-',INPUT_NAME_7"
    SEND_COMMAND dvVIDEO_8, "'VIDIN_NAME-',INPUT_NAME_8"
    
    SEND_COMMAND dvVIDEO_9, "'VIDIN_NAME-',INPUT_NAME_9"
    SEND_COMMAND dvVIDEO_10, "'VIDIN_NAME-',INPUT_NAME_10"
}
DEFINE_FUNCTION fnDVXPull()
{
    WAIT 10 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,1'" //Get INput of 1
    WAIT 20 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,2'" //Get Input of 3
    WAIT 30 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,3'" //Get INput of 1
    WAIT 40 SEND_COMMAND dvDvxSwitcher, "'?INPUT-VIDEO,4'" //Get Input of 3
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
DEFINE_FUNCTION fnTelevisionPower(CHAR cPWR[3])
{
    SWITCH (cPWR)
    {
	CASE 'On':
	{
	    PULSE [vdvSHARPTV_One, POWER_ON] 
	    WAIT 10 PULSE [vdvSHARPTV_Two, POWER_ON]
	    WAIT 20 PULSE [vdvSHARPTV_Three, POWER_ON]
	    WAIT 30 PULSE [vdvSHARPTV_Four, POWER_ON]
	}
	CASE 'Off':
	{
	    PULSE [vdvSHARPTV_One, POWER_OFF] 
	    WAIT 10 PULSE [vdvSHARPTV_Two, POWER_OFF]
	    WAIT 20 PULSE [vdvSHARPTV_Three, POWER_OFF]
	    WAIT 30 PULSE [vdvSHARPTV_Four, POWER_OFF]
	}

    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START

SET_SYSTEM_NUMBER(MY_SYSTEM) //May not see this update until first reboot =)

TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

WAIT 450
{
    fnSetClock()
}

(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)

DEFINE_MODULE 'Sharp_LC90LE657U' TeleModOne(vdvSHARPTV_One,dvSHARPTV_One);
DEFINE_MODULE 'Sharp_LC90LE657U' TeleModTwo(vdvSHARPTV_Two,dvSHARPTV_Two);
DEFINE_MODULE 'Sharp_LC90LE657U' TeleModThree(vdvSHARPTV_Three,dvSHARPTV_Three);
DEFINE_MODULE 'Sharp_LC90LE657U' TeleModFour(vdvSHARPTV_Four,dvSHARPTV_Four);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Main, nPopupBtns]
{
    PUSH :
    {
	SEND_COMMAND dvTP_Main, "'PPON-',cPopup_Names[GET_LAST(nPopupBtns)]"
	nPop = GET_LAST(nPopupBtns)
    }
}
BUTTON_EVENT [dvTP_Main, nTelevisionBtns] //Left Power & Mute...
{
    PUSH:
    {
	STACK_VAR INTEGER nTelevisionIdx
	nTelevisionIdx = GET_LAST (nTelevisionBtns)

	SWITCH (nTelevisionIdx)
	{
	    CASE 1: fnTelevisionPower ('On')
	    CASE 2: fnTelevisionPower ('Off')
	}
    }
}
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
    fnKill()
    fnReboot()
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
    
    [dvTP_Main, 1] = [vdvSHARPTV_One, POWER]
    [dvTP_Main, 2] = ![vdvSHARPTV_One, POWER]
    [dvTP_Main, 601] = [vdvSHARPTV_One, ON_LINE]
    
    [dvTP_Main, 101] = [vdvSHARPTV_Two, POWER]
    [dvTP_Main, 102] = ![vdvSHARPTV_Two, POWER]
    [dvTP_Main, 611] = [vdvSHARPTV_Two, ON_LINE]
    
    [dvTP_Main, 301] = [vdvSHARPTV_Three, POWER]
    [dvTP_Main, 302] = ![vdvSHARPTV_Three, POWER]
    [dvTP_Main, 621] = [vdvSHARPTV_Three, ON_LINE]
    
    [dvTP_Main, 401] = [vdvSHARPTV_Four, POWER]
    [dvTP_Main, 402] = ![vdvSHARPTV_Four, POWER]
    [dvTP_Main, 631] = [vdvSHARPTV_Four, ON_LINE]
    
}
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}

DEFINE_EVENT
DATA_EVENT [dvDvxSwitcher] 
{
    ONLINE:
    {
	WAIT 100 
	{
	    fnDVXPull()
	    WAIT 50
	    {
		CALL 'LABEL DVX'
	    }
	}
    }
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
DATA_EVENT [dvTp_Main] //TouchPanel Online
{
    ONLINE:
    {
	ON [nTPOnline]
	SEND_COMMAND dvTP_Main, "'ADBEEP'"
	SEND_COMMAND dvTp_Main, "'^TXT-100,0,',nRoomInfo"
	SEND_COMMAND dvTp_Main, "'^TXT-99,0,',nHelp"
    }
    OFFLINE :
    {
	OFF [nTPOnline]
    }
}

DEFINE_EVENT
CHANNEL_EVENT [vdvSHARPTV_One, ON_LINE] 
{
    ON:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE:
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-1.2,0,%OP255'" 
	    }
	}
    }
    OFF:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE:
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-1.2,0,%OP30'" 
	    }
	}
    }
}
CHANNEL_EVENT [vdvSHARPTV_Two,ON_LINE] 
{
    ON:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE:
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP255'" 
	    }
	}
    }
    OFF:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-101.102,0,%OP30'"
	    }
	}
    }
}
CHANNEL_EVENT [vdvSHARPTV_Three,ON_LINE]
{
    ON:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE:
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-301.302,0,%OP255'" 
	    }
	}
    }
    OFF:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-301.302,0,%OP30'" 
	    }
	}
    }
} 
CHANNEL_EVENT [vdvSHARPTV_Four,ON_LINE] 
{
    ON:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE:
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-401.402,0,%OP255'" 
	    }
	}
    }
    OFF:
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE ON_LINE :
	    {
		SEND_COMMAND dvTP_Main, "'^BMF-401.402,0,%OP30'" 
	    }
	}
    }
}

DEFINE_EVENT



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

