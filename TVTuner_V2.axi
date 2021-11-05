PROGRAM_NAME='TVTuner_'
(***********************************************************)
(*  FILE CREATED ON: 05/08/2020  AT: 10:00:18              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/11/2020  AT: 22:43:11        *)
(***********************************************************)

DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Tuner
dvTP_Tuner =				10001:3:0
#END_IF

#IF_NOT_DEFINED dvTP_TUNER2
dvTP_TUNER2 =				10002:3:0 //Tuner Controls from Booth...
#END_IF

#IF_NOT_DEFINED dvTuner 
dvTuner =					5001:4:0
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
BTN_CH_FAV5			= 135
BTN_CH_FAV6			= 136
BTN_CH_FAV7			= 137
BTN_CH_FAV8			= 138
BTN_CH_FAV9			= 139
CHANNEL_DEFAULT		= 0

TXT_CH_DISPLAY				=1

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR cSetChannel[5]

VOLATILE DEV vdvTP_Tuner[] = 
{
    dvTP_Tuner, 
    dvTP_TUNER2
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

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Tuner, BTN_CH_FAV1]..[dvTP_Tuner, BTN_CH_FAV9])
([dvTP_Tuner2, BTN_CH_FAV1]..[dvTP_Tuner2, BTN_CH_FAV9])

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

DEFINE_MODULE 'ContemporaryResearch_232STS' COMMTUNE(vdvTuner, dvTuner);


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Tuner, nFavoriteChBtns] //Tuner Presets...
{
    PUSH:
    {
	STACK_VAR INTEGER nTVIdx
	nTVIdx = GET_LAST (nFavoriteChBtns)
	
	    SEND_COMMAND vdvTuner, "'XCH-',nTunerChannelCall[nTVIdx]" 
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
	
	    PULSE[vdvTuner,nIDX]
		
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
	    }
	}
	cSetChannel = "cSetChannel, nChn"
	SEND_COMMAND vdvTP_Tuner, "'^TXT-',ITOA(TXT_CH_DISPLAY),',0,',cSetChannel"
    }
    RELEASE:
    {
	SET_PULSE_TIME (5)	//Reset Pulse Time 0.5 Seconds
    }
}

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
