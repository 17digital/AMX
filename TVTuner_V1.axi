PROGRAM_NAME='TVTuner'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/28/2019  AT: 09:18:08        *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Tuner
dvTP_Tuner =				10001:3:0
#END_IF

#IF_NOT_DEFINED dvTP_TUNER2
dvTP_TUNER2 =				10002:3:0 //Tuner Controls from Booth...
#END_IF

#IF_NOT_DEFINED dvTuner 
dvTuner =					5001:5:0
#END_IF


vdvTuner =					35015:1:0 ////TV Tuner 232-ATSC+ (Contemporary Research)

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


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Tuner[] = {dvTP_Tuner, dvTP_TUNER2}

VOLATILE INTEGER nChannel
VOLATILE INTEGER nChannelCount = 9

VOLATILE INTEGER nFavoriteFB[]= 
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
    '81-1', //NFL Network
    '61-2', //CBS Sports
    '80-2', //NBC Network
    '69-2', //Fox Sports
    '55-1' , //Fox Live
    '66-2', //Espn
    '67-1', //Espn 2
    '68-1', //espn u
    '4-1'  //GTCN
    
//Big Ten 59-1
//PAC 12 83-1
//SEC 86-2
//Golf 72-1
}
VOLATILE CHAR nTunerFavLabels[10][15] =
{
    'NFL Network',
    'CBS Sports',
    'NBC Sports',
    'Fox Sports',
    'ACC Netw',
    'ESPN',
    'ESPN 2',
    'ESPN U',
    'GTech Feed'
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnLoadChannelLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=nChannelCount; cLoop++)
    {
	SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(nFavoriteFB[cLoop]),',0,',nTunerFavLabels[cLoop]"
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

DEFINE_MODULE 'ContemporaryResearch_232STS' COMMTUNE(vdvTuner, dvTuner);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Tuner, nFavoriteFB] //Tuner Presets...
{
    PUSH:
    {
	STACK_VAR INTEGER nTVIdx
	
	nTVIdx = GET_LAST (nFavoriteFB)

	SEND_COMMAND vdvTuner, "'XCH-',nTunerChannelCall[nTVIdx]" 
		nChannel = nFavoriteFB[nTVIdx]
		//nChannel = GET_LAST(nFavoriteFB)
    }
}
BUTTON_EVENT [vdvTP_Tuner, 0] //Default
{
    PUSH :
    {
	PULSE[vdvTuner,BUTTON.INPUT.CHANNEL]
		OFF [nChannel ]
    }
    RELEASE:
    {
	SET_PULSE_TIME(5)	//Reset Pulse Time 0.5 Seconds
    }
}
DATA_EVENT [dvTP_Tuner]
DATA_EVENT [dvTP_TUNER2]
{
    ONLINE :
    {
	fnLoadChannelLabels()
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    //TV TUNER
    [vdvTP_TUNER,POWER_CYCLE] = [vdvTuner,POWER]
    
    [vdvTP_TUNER,BTN_CH_FAV1] = nChannel = BTN_CH_FAV1
    [vdvTP_TUNER,BTN_CH_FAV2] = nChannel = BTN_CH_FAV2
    [vdvTP_TUNER,BTN_CH_FAV3] = nChannel = BTN_CH_FAV3
    [vdvTP_TUNER,BTN_CH_FAV4] = nChannel = BTN_CH_FAV4
    [vdvTP_TUNER,BTN_CH_FAV5] = nChannel = BTN_CH_FAV5
    [vdvTP_TUNER,BTN_CH_FAV6] = nChannel = BTN_CH_FAV6
    [vdvTP_TUNER,BTN_CH_FAV7] = nChannel = BTN_CH_FAV7
    [vdvTP_TUNER,BTN_CH_FAV8] = nChannel = BTN_CH_FAV8
    [vdvTP_TUNER,BTN_CH_FAV9] = nChannel = BTN_CH_FAV9

}



