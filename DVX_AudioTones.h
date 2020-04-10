

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nToneBtns[] =
{
    901, //off
    902,
    903,
    904,
    905,
    906,
    907,
    909,
    910
}
VOLATILE CHAR nAudioTones[10][12] =
{
    'off',
    '60Hz',
    '250Hz',
    '400Hz',
    '1KHz',
    '3KHz',
    '5KHz',
    '10KHz',
    'PINK NOISE',
    'WHITE NOISE'
}

DEFINE_MUTUALLY_EXCLUSIVE


([dvTp_Main, nToneBtns[1]]..[dvTp_Main, nToneBtns[9]])


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 


DEFINE_START


DEFINE_EVENT
BUTTON_EVENT [dvTp_Main, nToneBtns]
{
		PUSH :
		{
			SEND_COMMAND dvDvxSwitcher, "'AUDOUT_TESTTONE-',nAudioTones[GET_LAST(nToneBtns)]"
				ON [dvTp_Main, [GET_LAST(nToneBtns)]]
		}
}
