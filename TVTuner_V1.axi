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

dvTuner002 =					5001:5:0 //EXB2

vdvTuner =					35015:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)
vdvTuner002 =				35016:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)


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

BTN_TUNER_1			= 51
BTN_TUNER_2			= 52

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE


VOLATILE INTEGER nSelectTuner 

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
    '2-1', //NFL Network
    '5-1', //CBS Sports
    '61-1', //NBC Network
    '63-1', //cnn
    '69-1' , //Fox Live
    '66-2', //Espn
    '88-2', //Weather Channel
    '77-2', //espn u
    '4-1'  //GTCN
}
VOLATILE CHAR nTunerFavLabels[10][15] =
{
    'ABC HD',
    'Fox 5',
    'CBS 46',
    'CNN',
    'Fox News',
    'ESPN',
    'Weather',
    'MSNBC',
    'GTech Feed'
}
VOLATILE INTEGER nTunerPwrBtns[] =
{
    BTN_TUNER_1,
    BTN_TUNER_2
}
VOLATILE DEV dcTuner[] =
{
    vdvTuner,
    vdvTuner002
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Tuner, nFavoriteChBtns[1]]..[dvTP_Tuner, nFavoriteChBtns[9]])
([dvTP_Tuner, BTN_TUNER_1],[dvTP_Tuner, BTN_TUNER_2])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnLoadChannelLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(nFavoriteChBtns); cLoop++)
    {
	SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(nFavoriteChBtns[cLoop]),',0,',nTunerFavLabels[cLoop]"
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

nSelectTuner = 1
ON [vdvTP_Tuner, BTN_TUNER_1]

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
    }
}
BUTTON_EVENT [vdvTP_Tuner, nFavoriteChBtns] //Tuner Presets...
{
    PUSH:
    {
	STACK_VAR INTEGER nTVIdx
	nTVIdx = GET_LAST (nFavoriteChBtns)
	
	    SEND_COMMAND dcTuner[nSelectTuner], "'XCH-',nTunerChannelCall[GET_LAST(nFavoriteChBtns)]" 
	ON [vdvTP_Tuner, nFavoriteChBtns[nTVIdx]] //Send Feedback to Panel...
    }
}
BUTTON_EVENT [vdvTP_Tuner, CHANNEL_DEFAULT] //Default
{
    PUSH :
    {
	    PULSE[dcTuner[nSelectTuner],BUTTON.INPUT.CHANNEL]
		TOTAL_OFF [vdvTP_Tuner, nFavoriteChBtns ]
    }
    RELEASE:
    {
	SET_PULSE_TIME(5)	//Reset Pulse Time 0.5 Seconds
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
CHANNEL_EVENT [vdvTuner, POWER]
{
    ON :
    {
	ON [vdvTP_TUNER, POWER_CYCLE]
    }
    OFF :
    {
	OFF [vdvTP_TUNER, POWER_CYCLE]
    }
}
