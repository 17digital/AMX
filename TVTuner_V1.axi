PROGRAM_NAME='TVTuner'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/10/2019  AT: 05:46:04        *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Tuner
dvTP_Tuner =				10001:3:0
#END_IF

#IF_NOT_DEFINED dvTuner 
dvTuner =					5001:4:0
#END_IF

dvTuner002 =				5304:1:0 //EXB2
dvTuner003 =				5304:2:0 //EXB2
dvTuner004 =				5305:1:0 //EXB2
dvTuner005 =				5305:2:0 //EXB2

vdvTuner =				35015:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner002 =			35016:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner003 =			35017:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner004 =			35018:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner005 =			35019:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED POWER
POWER 				= 255
#END_IF

#IF_NOT_DEFINED POWER_CYCLE
POWER_CYCLE			= 9
#END_IF

#IF_NOT_DEFINED POWER_ON
POWER_ON			= 27
#END_IF

//Tuner
BTN_CH_FAV1			= 131
BTN_CH_FAV2			= 132
BTN_CH_FAV3			= 133
BTN_CH_FAV4			= 134
BTN_CH_FAV5		= 135
BTN_CH_FAV6			= 136
BTN_CH_FAV7			= 137
BTN_CH_FAV8			= 138
BTN_CH_FAV9			= 139
CHANNEL_DEFAULT		= 0

TXT_CH_DISPLAY				=1

BTN_TUNER_REAR_LEFT			= 51
BTN_TUNER_DONAR			= 52
BTN_TUNER_FRONT			= 53
BTN_TUNER_CONF				= 54
BTN_TUNER_REAR_RIGHT		= 55

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nSelectTuner 
VOLATILE CHAR cSetChannel[5]

VOLATILE INTEGER nPwrCount
VOLATILE INTEGER nPwrTuner1
VOLATILE INTEGER nPwrTuner2
VOLATILE INTEGER nPwrTuner3
VOLATILE INTEGER nPwrTuner4
VOLATILE INTEGER nPwrTuner5

VOLATILE DEV vdvTP_Tuner[] =
{
    dvTP_Tuner
}
VOLATILE INTEGER nFavoriteChBtns[]= 
{
    BTN_CH_FAV1,
    BTN_CH_FAV2,
    BTN_CH_FAV3,
    BTN_CH_FAV4,
    BTN_CH_FAV5,
    BTN_CH_FAV6,
    BTN_CH_FAV7,
    BTN_CH_FAV8,
    BTN_CH_FAV9
}
VOLATILE CHAR nTunerChannelCall[10][5] =
{
    '67-1', //NFL Network
    '55-1', //See Below
    '61-2', //See Below
    '66-2', //4
    '68-1' , //5
    '69-2', //6
    '80-2', //7
    '86-2', //8
    '4-1'  //GTCN
}
VOLATILE CHAR nTunerFavLabels[10][15] =
{
    'ESPN 2',
    'ACC Network',
    'CBS Sports',
    'ESPN', //4
    'ESPN U', //5
    'Fox Sports 1 HD', //6
    'NBC Sports', //7
    'SEC', //8
    'GTech Feed'
}
VOLATILE INTEGER nTunerPwrBtns[] =
{
    BTN_TUNER_REAR_LEFT,
    BTN_TUNER_DONAR,
    BTN_TUNER_FRONT,
    BTN_TUNER_CONF,
    BTN_TUNER_REAR_RIGHT
}
VOLATILE DEV dcTuner[] =
{
    vdvTuner,
    vdvTuner002,
    vdvTuner003,
    vdvTuner004,
    vdvTuner005
}
DEVCHAN dcTunerChannelFB[] =
{
    { vdvTuner, POWER },
    { vdvTuner002, POWER },
    { vdvTuner003, POWER },
    { vdvTuner004, POWER },
    { vdvTuner005, POWER }
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Tuner, BTN_CH_FAV1]..[dvTP_Tuner, BTN_CH_FAV9])
([dvTP_Tuner, BTN_TUNER_REAR_LEFT]..[dvTP_Tuner, BTN_TUNER_REAR_RIGHT])

([dvTP_Tuner2, BTN_CH_FAV1]..[dvTP_Tuner2, BTN_CH_FAV9])
([dvTP_Tuner2, BTN_TUNER_REAR_LEFT]..[dvTP_Tuner2, BTN_TUNER_REAR_RIGHT])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnLoadChannelLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=LENGTH_ARRAY(nFavoriteChBtns); cLoop++)
    {
	SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(nFavoriteChBtns[cLoop]),',0,',nTunerFavLabels[cLoop]"
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

nSelectTuner = 1; //Default Select
[vdvTP_Tuner, POWER_CYCLE] = nPwrTuner1

DEFINE_MODULE 'ContemporaryResearch_232STS' COMMTUNE(vdvTuner, dvTuner);
DEFINE_MODULE 'ContemporaryResearch_232STS' COMMTUNE02(vdvTuner002, dvTuner002);

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Tuner, nTunerPwrBtns] //Set Active Camera
{
    PUSH :
    {
	nSelectTuner = GET_LAST (nTunerPwrBtns)
	    ON [vdvTP_Tuner, nTunerPwrBtns[nSelectTuner]]
	    
	   SWITCH (nSelectTuner)
	    {
		CASE 1 :  [vdvTP_Tuner, POWER_CYCLE] = nPwrTuner1
		CASE 2 :  [vdvTP_Tuner, POWER_CYCLE] = nPwrTuner2
		CASE 3 :  [vdvTP_Tuner, POWER_CYCLE] = nPwrTuner3
		CASE 4 :  [vdvTP_Tuner, POWER_CYCLE] = nPwrTuner4
		CASE 5 :  [vdvTP_Tuner, POWER_CYCLE] = nPwrTuner5
	    }
    }
}
BUTTON_EVENT [vdvTP_Tuner, nFavoriteChBtns] //Tuner Presets...
{
    PUSH:
    {
	STACK_VAR INTEGER nTVIdx
	nTVIdx = GET_LAST (nFavoriteChBtns)
	
	    SEND_COMMAND dcTuner[nSelectTuner], "'XCH-',nTunerChannelCall[nTVIdx]" 
	ON [vdvTP_Tuner, nFavoriteChBtns[nTVIdx]] //Send Feedback to Panel...
	
	    SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(TXT_CH_DISPLAY),',0,',nTunerFavLabels[nTVIdx]"
    }
}
BUTTON_EVENT [vdvTP_Tuner, CHANNEL_DEFAULT] //Default
{
    PUSH :
    {
	STACK_VAR INTEGER nIDX
	STACK_VAR CHAR nChn[1];
	nIDX = BUTTON.INPUT.CHANNEL;
	
	PULSE[dcTuner[nSelectTuner],nIDX]
		
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
		BREAK;
	    }
	    CASE 22: //Ch Up
	    CASE 23: //Ch Dn
	    CASE 101: //Previous
	    {
		TOTAL_OFF [vdvTP_Tuner, nFavoriteChBtns ]
	    }
	    CASE 90 :
	    {
		nChn = '-';
		BREAK;
	    }
	    CASE 110 : //Enter Buttons
	    {
		cSetChannel = ' ';
		TOTAL_OFF [vdvTP_Tuner, nFavoriteChBtns ]
		BREAK;
	    }
	}
	cSetChannel = "cSetChannel, nChn"
	SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(TXT_CH_DISPLAY),',0,',cSetChannel"
    }
    RELEASE:
    {
	SET_PULSE_TIME(5)	//Reset Pulse Time 0.5 Seconds
    }
}

DEFINE_EVENT
CHANNEL_EVENT [dcTunerChannelFB] //channel array test...
{
    ON :
    {
	nPwrCount = GET_LAST (dcTunerChannelFB)
	
        SWITCH (nPwrCount)
	{
	    CASE 1 : nPwrTuner1 = TRUE;
	    CASE 2 : nPwrTuner2 = TRUE;
	    CASE 3 : nPwrTuner3 = TRUE;
	    CASE 4 : nPwrTuner4 = TRUE;
	    CASE 5 : nPwrTuner5 = TRUE;
	}
    }
    OFF :
    {
	nPwrCount = GET_LAST (dcTunerChannelFB)
	
        SWITCH (nPwrCount)
	{
	    CASE 1 : nPwrTuner1 = FALSE;
	    CASE 2 : nPwrTuner2 = FALSE;
	    CASE 3 : nPwrTuner3 = FALSE;
	    CASE 4 : nPwrTuner4 = FALSE;
	    CASE 5 : nPwrTuner5 = FALSE;
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Tuner]
{
    ONLINE :
    {
	fnLoadChannelLabels()
    }
}

