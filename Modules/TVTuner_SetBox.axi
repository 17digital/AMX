PROGRAM_NAME='TVTuner'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/26/2019  AT: 05:41:02        *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Tuner
dvTP_Tuner =				10001:3:0
#END_IF

#IF_NOT_DEFINED dvTP_Tuner2
dvTP_Tuner2 =				10002:3:0 //Tuner Controls from Rear Room
#END_IF

#IF_NOT_DEFINED dvTP_TunerConf
dvTP_TunerConf =				10004:3:0 //Tuner Controls from Conference Room
#END_IF


#IF_NOT_DEFINED dvTuner 
dvTuner =					0:3:0
#END_IF

dvTuner002 =				0:4:0 //EXB2
dvTuner003 =				0:5:0 //EXB2
dvTuner004 =				0:6:0 //EXB2
dvTuner005 =				0:7:0 //EXB2

vdvTuner =				35015:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner002 =			35016:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner003 =			35017:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner004 =			35018:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner005 =			35019:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR TV_IP_HOST[]			= '10.136.132.11' // sbb-wardlaw-gordy-1.tv.gatech.edu
CHAR TV_2_IP_HOST[]			= '10.136.132.12' // sbb-wardlaw-gordy-2.tv.gatech.edu
CHAR TV_3_IP_HOST[]			= '10.136.132.13' // sbb-wardlaw-gordy-3.tv.gatech.edu
CHAR TV_4_IP_HOST[]			= '10.136.132.14' // sbb-wardlaw-gordy-4.tv.gatech.edu
CHAR TV_5_IP_HOST[]			= '10.136.132.15' // sbb-wardlaw-gordy-5.tv.gatech.edu

#IF_NOT_DEFINED POWER
POWER 				= 255
#END_IF

#IF_NOT_DEFINED POWER_CYCLE
POWER_CYCLE			= 9
#END_IF

MAX_SPORTS_CH				= 19;
MAX_BOXES					= 4;
TXT_CH_DISPLAY				=1
TXT_LOC_DISPLAY				= 2;
BTN_CH_RELOAD				= 20;

//Tuner Mode
BTN_TUNER_REAR_LEFT			= 53
BTN_TUNER_DONAR			= 52
BTN_TUNER_FRONT			= 51
BTN_TUNER_CONF				= 55
BTN_TUNER_REAR_RIGHT		= 54


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCT _TVChannel {
	CHAR iLabel[15];
	CHAR iChannel[3];
}
STRUCT _Tuner {
    CHAR bIP[15];
    INTEGER bPwr;
    CHAR bFirwmare[10];
    _TVChannel iStation;
}
STRUCT _TVGuide {
	CHAR iLabel[15];
	INTEGER iChannel;
}


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _TVGuide iGuide[MAX_SPORTS_CH];
VOLATILE _Tuner iTuner[MAX_BOXES];

VOLATILE INTEGER nSelectTuner; 
VOLATILE CHAR cSetChannel[5]
VOLATILE CHAR cSendChannel[3];
VOLATILE INTEGER bTest;

VOLATILE DEV vdvTP_Tuner[] = 
{
    dvTP_Tuner, 
    dvTP_Tuner2, //Rear Wall...
    dvTP_TunerConf //Conference...
}
VOLATILE CHAR sFavList[19][15] =
{
    'ABC-WSB-DT',
    'FOX-WAGA-DT',
    'NBC-WXIA HD',
    'CBS-WANF HD', // 4
    'ACC Network',
    'beIn Sport',
    'Big Ten Network',
    'ESPN', // 8
    'ESPN2',
    'ESPNews',
    'ESPNU',
    'Fox Sports 1', // 12
    'Fox Sports 2',
    'SEC Network',
    'Athletics 1',
    'Athletics 2', // 16
    'Athletics 3',
    'Athletics 4',
    'CW'
};
VOLATILE INTEGER sChList[19] =
{
    2, // ABC-WSB-DT
    3, // FOX-WAGA-DT
    4, // NBC-WXIA HD
    8, //CBS-WANF HD
    10, // ACC Network
    11, // beIn Sport
    12, // Big Ten Network
    13, // ESPN
    14, // ESPN2
    15, // ESPNews
    16, // ESPNU
    17, // Fox Sports 1
    18, // Fox Sports 2
    26, // SEC Network
    88, // Athletics 1
    89, // Athletics 2
    90, // Athletics 3
    91, // Athletics 4
    5	// CW
}
VOLATILE INTEGER nFavListBtns[19] =
{
    301,
    302,
    303,
    304,
    305,
    306,
    307,
    308,
    309,
    310,
    311,
    312,
    313,
    314,
    315,
    316,
    317,
    318,
    319
}
VOLATILE INTEGER nTunerPwrBtns[] =
{
    BTN_TUNER_FRONT,
    BTN_TUNER_DONAR,
    BTN_TUNER_REAR_LEFT,
    BTN_TUNER_REAR_RIGHT,
    BTN_TUNER_CONF
}
VOLATILE DEV dcTuner[] =
{
    vdvTuner,
    vdvTuner002,
    vdvTuner003,
    vdvTuner004,
    vdvTuner005  // Conference
}
VOLATILE CHAR sLocations[5][15] =
{
    'Front Wall TV',
    'Side Wall TV',
    'Rear Left TV',
    'Rear Right TV',
    'Conference Area'
}


DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Tuner, nFavListBtns[1]]..[dvTP_Tuner, nFavListBtns[LENGTH_ARRAY(nFavListBtns)]])
([dvTP_Tuner, nTunerPwrBtns[1]]..[dvTP_Tuner, nTunerPwrBtns[LENGTH_ARRAY(nTunerPwrBtns)]])

([dvTP_Tuner2, nFavListBtns[1]]..[dvTP_Tuner2, nFavListBtns[LENGTH_ARRAY(nFavListBtns)]])
([dvTP_Tuner2, nTunerPwrBtns[1]]..[dvTP_Tuner2, nTunerPwrBtns[LENGTH_ARRAY(nTunerPwrBtns)]])

([dvTP_TunerConf, nFavListBtns[1]]..[dvTP_TunerConf, nFavListBtns[LENGTH_ARRAY(nFavListBtns)]])
([dvTP_TunerConf, nTunerPwrBtns[1]]..[dvTP_TunerConf, nTunerPwrBtns[LENGTH_ARRAY(nTunerPwrBtns)]])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnCreateSportsGuide() {
	    STACK_VAR INTEGER b;
	    
	    FOR (b=1; b<=(MAX_SPORTS_CH); b++) {
		    iGuide[b].iLabel = sFavList[b];
		    iGuide[b].iChannel = sChList[b];
			SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(nFavListBtns[b]),',0,',sFavList[b]"
	    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

iTuner[1].bIP = TV_IP_HOST;
iTuner[2].bIP = TV_2_IP_HOST;
iTuner[3].bIP = TV_3_IP_HOST;
iTuner[4].bIP = TV_4_IP_HOST;
//iTuner[5].bIP = TV_5_IP_HOST;

nSelectTuner  = 1;  // Set Main Wall as Active
ON [vdvTP_Tuner, nTunerPwrBtns[nSelectTuner]]	
fnCreateSportsGuide();

DEFINE_MODULE 'TV_SetBox_IP' COMMTUNE(vdvTuner, dvTuner, iTuner[1].bIP);
DEFINE_MODULE 'TV_SetBox_IP' COMMTUNE02(vdvTuner002, dvTuner002, iTuner[2].bIP);
DEFINE_MODULE 'TV_SetBox_IP' COMMTUNE03(vdvTuner003, dvTuner003, iTuner[3].bIP);
DEFINE_MODULE 'TV_SetBox_IP' COMMTUNE04(vdvTuner004, dvTuner004, iTuner[4].bIP);
//DEFINE_MODULE 'TV_SetBox_IP' COMMTUNE05(vdvTuner005, dvTuner005);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Tuner, nTunerPwrBtns] //Set Active Tuner...
{
    PUSH :
    {
	nSelectTuner = GET_LAST (nTunerPwrBtns)
	    ON [vdvTP_Tuner, nTunerPwrBtns[nSelectTuner]]	
	    SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(TXT_LOC_DISPLAY),',0,TV Tuner : ',sLocations[nSelectTuner]";
		SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(TXT_CH_DISPLAY),',0,Channel : ',iTuner[nSelectTuner].iStation.iChannel,'  [',iTuner[nSelectTuner].iStation.iLabel,']'"
		    [vdvTP_Tuner, POWER_CYCLE] = iTuner[nSelectTuner].bPwr;
		    fnCreateSportsGuide();
    }
}
BUTTON_EVENT [vdvTP_Tuner, nFavListBtns] //Tuner Presets...
{
    PUSH:
    {
	STACK_VAR INTEGER b
	b = GET_LAST (nFavListBtns)
	    ON [vdvTP_Tuner, nFavListBtns[b]];
		SEND_COMMAND dcTuner[nSelectTuner], "'SETCHANNEL-',ITOA(iGuide[b].iChannel)"
	
    }
}
BUTTON_EVENT [vdvTP_Tuner, 0] //Default
{
    PUSH :
    {
	STACK_VAR INTEGER nIDX;	    
	STACK_VAR CHAR nChn[1];
	    
	    nIDX = BUTTON.INPUT.CHANNEL;
	
	SWITCH (nIDX)
	{
	    CASE 10 :
	    CASE 11 :
	    CASE 12 :
	    CASE 13 :
	    CASE 14 :
	    CASE 15 :
	    CASE 16 :
	    CASE 17 :
	    CASE 18 :
	    CASE 19 :
	    {
		nChn = ITOA(nIDX -10);
		    cSetChannel = "cSetChannel, nChn"
		    SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(TXT_CH_DISPLAY),',0,Channel : ',cSetChannel" // Print to Touch Panel
		BREAK;
	    }
//	    CASE 20 :
//	    {
//		fnCreateSportsGuide();
//	    }
	    CASE 22: //Ch Up
	    CASE 23: //Ch Dn
	    {
		TOTAL_OFF [vdvTP_Tuner, nFavListBtns];
		    PULSE[dcTuner[nSelectTuner],nIDX];
			cSetChannel = '';
		BREAK;
	    }
	    CASE 27 : {
		    PULSE[dcTuner[nSelectTuner],nIDX];
	    }
	    CASE 110 : //Enter Buttons
	    {
		bTest = ATOI(cSetChannel);
			    bTest = bTest -1;
			    
		SEND_COMMAND dcTuner[nSelectTuner], "'SETCHANNEL-',cSetChannel"
		    TOTAL_OFF [vdvTP_Tuner, nFavListBtns]
			cSetChannel = '';
	    }
	}
    }
}

DEFINE_EVENT
CHANNEL_EVENT [dcTuner, POWER] //channel array test...
{
    ON :
    {
	STACK_VAR INTEGER b;
	    b = GET_LAST (dcTuner);
	        iTuner[b].bPwr = TRUE;
    }
    OFF :
    {
	STACK_VAR INTEGER b;
	    b = GET_LAST (dcTuner);
	        iTuner[b].bPwr = FALSE;
    }
}

DEFINE_EVENT
DATA_EVENT [vdvTuner]
{
    COMMAND :
    {
	CHAR iMsg[50];
	    iMsg = DATA.TEXT;
	    
	    IF (FIND_STRING(iMsg,'ACTIVETVLABEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[1].iStation.iLabel  = iMsg;
		    
	    }
	    IF (FIND_STRING(iMsg,'ACTIVETVCHANNEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[1].iStation.iChannel = iMsg;
	    }
    }
}
DATA_EVENT [vdvTuner002]
{
    COMMAND :
    {
	CHAR iMsg[50];
	    iMsg = DATA.TEXT;
	    
	    IF (FIND_STRING(iMsg,'ACTIVETVLABEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[2].iStation.iLabel = iMsg;
		    
	    }
	    IF (FIND_STRING(iMsg,'ACTIVETVCHANNEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[2].iStation.iChannel = iMsg;
	    }
    }
}
DATA_EVENT [vdvTuner003]
{
    COMMAND :
    {
	CHAR iMsg[50];
	    iMsg = DATA.TEXT;
	    
	    IF (FIND_STRING(iMsg,'ACTIVETVLABEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[3].iStation.iLabel = iMsg;
		    
	    }
	    IF (FIND_STRING(iMsg,'ACTIVETVCHANNEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[3].iStation.iChannel = iMsg;
			    //SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(TXT_CH_DISPLAY),',0,Channel : ',iStation[3].iChannel,'  [',iStation[3].iLabel,']'"
	    }
    }
}
DATA_EVENT [vdvTuner004]
{
    COMMAND :
    {
	CHAR iMsg[50];
	    iMsg = DATA.TEXT;
	    
	    IF (FIND_STRING(iMsg,'ACTIVETVLABEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[4].iStation.iLabel = iMsg;
		    
	    }
	    IF (FIND_STRING(iMsg,'ACTIVETVCHANNEL-',1)) {
		    REMOVE_STRING (iMsg,'-',1);
			iTuner[4].iStation.iChannel = iMsg;
	    }
    }
}


