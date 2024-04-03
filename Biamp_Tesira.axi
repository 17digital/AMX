PROGRAM_NAME='Biamp_Tesira'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/21/2019  AT: 16:03:26        *)
(***********************************************************)

(*
https://support.biamp.com/Tesira/Control/Tesira_command_string_calculator

													*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Biamp
dvTP_Biamp =					10001:5:0
#END_IF

#IF_NOT_DEFINED dvTP_Biamp2
dvTP_Biamp2 =				10002:5:0
#END_IF

#IF_NOT_DEFINED dvTesira 
dvTesira =					5001:1:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR BIAMP_TYPE[]		= 'Tesira VT4';

//RMS Stuff...
BIAMP_INITIALIZED				= 251;

HOLD_MAC_ADDRESS			= 17;
HOLD_IP_ADDRESS				= 15;

MAX_ATTRIBUTES				= 1;
//End RMS....

MAX_COMP			= 88 //Biamp | Value= 1120 | Level=  12
MAX_SPAN			= 6

VOL_UP				= 1
VOL_DN				= -1

MIC_COUNT			= 4;
ID_PRGM_LEV			= 1
ID_CEILING			= 1 //Logic Block

//biamp tags...
TAG_LEV_PRGM		= 'Program'
TAG_LEV_MICS		= 'Microphones'
TAG_MUTE_MICS		= 'MicMutes'
TAG_MUTE_PRGM		= 'ProgramMute'
TAG_CEILING			= 'privacymute'

YES_ON				= 'true'
YES_OFF				= 'false'

//Panel Addresses...
TXT_PRGM			= 11

//Mute Buttons....
BTN_MUTE_PRGM		= 37
BTN_MUTE_CEILING	= 50


#IF_NOT_DEFINED MSG_ETX 
CHAR MSG_ETX		= $0D;
#END_IF

#IF_NOT_DEFINED MSG_LF
CHAR MSG_LF		= $0A;
#END_IF


DEFINE_TYPE

STRUCTURE _BiampStruct
{
    CHAR bHost[20];
    CHAR bMacAddress[HOLD_MAC_ADDRESS];
    CHAR bIPAddress[HOLD_IP_ADDRESS];
    CHAR bSerial[10];
    CHAR bFirmware[12];
    CHAR bBiampOnline;
}
STRUCTURE _BiampPrgm
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
}
STRUCTURE _BiampWm
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
}


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

//RMS Variables....
_BiampStruct MyBiampStruct;
_BiampWm BiampWm[MIC_COUNT];
_BiampPrgm BiampPrgm

VOLATILE CHAR bFound[20];

//End RMS Variables..

VOLATILE SINTEGER nMaximum = 12
VOLATILE SINTEGER nMinimum = -88

VOLATILE CHAR nAudioBuffer[1000];

VOLATILE SINTEGER nProgram_Level_Preset = -10;
VOLATILE SINTEGER nLav_Level_Preset = -18;

VOLATILE INTEGER nCeiling_Mute

VOLATILE DEV vdvTP_Biamp[] = 
{
    dvTP_Biamp, 
    dvTP_Biamp2
}
VOLATILE INTEGER nMicChnlbtns[] =
{
    // Lav 1
    1,2,3,4,

    // Lav 2
    5,6,7,8,

    //Mic 3
    9,10,11,12,
    
    //Mic 4
    13,14,15,16
}
VOLATILE INTEGER nPrgmBtns[] =
{
    //Program
    37,38,39,40
}
VOLATILE INTEGER nMicMuteBtns[] =
{
    1, 5, 9, 13, 17
}

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnMuteLogic(CHAR cTag[], INTEGER cIn, CHAR cToggle[]) {

    SEND_STRING dvTesira, "cTag,' set state ',ITOA(cIn),' ',cToggle,MSG_ETX" 
}
DEFINE_FUNCTION fnMuteChannel(CHAR cTag[], INTEGER cIn, CHAR cValue[]) {

    SEND_STRING dvTesira, "cTag,' set mute ',ITOA(cIn),' ',cValue,MSG_ETX"
}
DEFINE_FUNCTION fnSetVolumeUp(CHAR cTag[], INTEGER cIn, SINTEGER cLev) {

    IF (cLev < nMaximum ) {
    	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA( cLev + VOL_UP),MSG_ETX"
    }
}
DEFINE_FUNCTION fnSetVolumeDown(CHAR cTag[], INTEGER cIn, SINTEGER cLev) {

    IF (cLev > nMinimum ) {
    
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev + VOL_DN),MSG_ETX"
    }
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], INTEGER cIn, SINTEGER cLev) {

    SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev),MSG_ETX"
}
DEFINE_FUNCTION fnSetPresetVar() {

    //Declare Starting Presets....
    BiampPrgm.bPreset = nProgram_Level_Preset;
    
    BiampWm[1].bPreset = nLav_Level_Preset;
    BiampWm[2].bPreset = nLav_Level_Preset;
    BiampWm[3].bPreset = nLav_Level_Preset;
    BiampWm[4].bPreset = nLav_Level_Preset;
}
DEFINE_FUNCTION fnSetWmPresets() {

    STACK_VAR INTEGER cIn;
    
    FOR (cIn=1; cIn<=MIC_COUNT; cIn++) {
	fnSetVolumePreset (TAG_LEV_MICS, cIn, BiampWm[cIn].bPreset);
    }
}
DEFINE_FUNCTION fnUnMuteWmMics() {

    STACK_VAR INTEGER cIn;
    
    FOR (cIn=1; cIn<=MIC_COUNT; cIn++) {
    	fnMuteChannel (TAG_MUTE_MICS, cIn, YES_OFF);
    }
}
DEFINE_FUNCTION fnResetAudio()
{
        fnSetPresetVar();
    
    WAIT 20 fnUnMuteWmMics();
    WAIT 60 fnSetWmPresets();
    
    WAIT 90 fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_OFF);
    WAIT 100 fnSetVolumePreset (TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bPreset);
                 
    WAIT 120 fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF);

    WAIT 140 SEND_STRING dvTesira, "'DEVICE get ipStatus control',MSG_ETX"
    WAIT 160 SEND_STRING dvTesira, "'DEVICE get hostname',MSG_ETX"
	
    WAIT 180 SEND_STRING dvTesira, "'DEVICE get serialNumber',MSG_ETX"
	
    WAIT 200 SEND_STRING dvTesira, "'DEVICE get version',MSG_ETX"
    
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[500] 
    STACK_VAR INTEGER cID
    LOCAL_VAR CHAR cMsg[4]
    LOCAL_VAR CHAR cState[5]
    LOCAL_VAR CHAR cNetHelp[50];
    LOCAL_VAR CHAR cMute[2]

    WHILE(FIND_STRING(nAudioBuffer,"$0D,$0A",1))
    {	
	cResponse = REMOVE_STRING(nAudioBuffer,"$0D,$0A",1)
	    MyBiampStruct.bBiampOnline = TRUE;
	    
	SELECT
	{
	    ACTIVE (FIND_STRING(cResponse,'Welcome to the Tesira Text Protocol Server...',1)):
	    {
		SEND_STRING 0, "'Tesira has booted and now Ready'"
			//Load Presets....
			    fnResetAudio();
	    }
	    ACTIVE (FIND_STRING(cResponse,'+OK "value":{"macAddress":"',1)) :
	    {
		REMOVE_STRING (cResponse,'+OK "value":{"macAddress":"',1)
		    MyBiampStruct.bMacAddress = LEFT_STRING (cResponse, HOLD_MAC_ADDRESS)
		//
		REMOVE_STRING (cResponse,'"ip":"',1)
		
		cNetHelp = REMOVE_STRING (cResponse,'" "netmask":"',1)
		//cHelper = cHelp1; //Should give me IP + netmask
			    MyBiampStruct.bIPAddress = LEFT_STRING(cNetHelp,LENGTH_STRING(cNetHelp) -13)
	    }
	    ACTIVE (FIND_STRING (cResponse,'DEVICE get hostname',1)):
	    {
		bFound= 'hostname';
	    }
	    ACTIVE (FIND_STRING (cResponse,'DEVICE get serialNumber',1)):
	    {
		bFound= 'serialNumber';
	    }
	    ACTIVE (FIND_STRING (cResponse,'DEVICE get version',1)):
	    {
		bFound = 'firmware';
	    }
	    ACTIVE (FIND_STRING (cResponse,'+OK "value":',1)) :
	    {
		REMOVE_STRING (cResponse,'+OK "value":',1)
	    
		SWITCH (bFound)
		{
		    CASE 'hostname' :
		    {
			REMOVE_STRING (cResponse,'"',1)
			
			MyBiampStruct.bHost = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -3) //Remove Last Quote + 2Bytes
						    bFound = '';
		    }
		    CASE 'serialNumber' :
		    {
			REMOVE_STRING (cResponse,'"',1)
			
			MyBiampStruct.bSerial = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -3) //Remove Last Quote + 2Bytes
			    bFound = '';
		    }
		    CASE 'firmware' :
		    {
			REMOVE_STRING (cResponse,'"',1)
			
			MyBiampStruct.bFirmware = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -3)
			    bFound = '';
		    }
		}
	    }
	    		//Program Feedback...
	    ACTIVE (FIND_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)) :
	    {
		REMOVE_STRING(cResponse,"TAG_LEV_PRGM,' set level ',ITOA(ID_PRGM_LEV)",1)
		    BiampPrgm.bLevel = ATOI(cResponse)
			SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm.bLevel + MAX_COMP),'%'"
	    }
	    ACTIVE (FIND_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1)) :
	    {
		REMOVE_STRING (cResponse, "TAG_MUTE_PRGM,' set mute ',ITOA(ID_PRGM_LEV),' '",1)
		    cState = cResponse;
		    
			IF (FIND_STRING (cState,'true',1))
			{
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
				ON [vdvTP_Biamp, nPrgmBtns[1]]
				    BiampPrgm.bMute = TRUE;
			}
			ELSE
			{
			    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm.bLevel + MAX_COMP),'%'"
				OFF [vdvTP_Biamp, nPrgmBtns[1]]
				    BiampPrgm.bMute = FALSE;
			}
		}
	    ACTIVE (FIND_STRING(cResponse,"TAG_LEV_MICS,' set level '",1)) :
	    {
		REMOVE_STRING(cResponse,"TAG_LEV_MICS,' set level '",1)
			cID = ATOI(LEFT_STRING(cResponse,1));
			cMsg = MID_STRING (cResponse,3,3);
			
			    BiampWm[cID].bLevel = ATOI(cMsg);
					SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(cID),',0,',ITOA(BiampWm[cID].bLevel + MAX_COMP),'%'"
	    }
		//Wm Mute Parsing...
	    ACTIVE (FIND_STRING (cResponse, "TAG_MUTE_MICS,' set mute '",1)) :
	    {
		    REMOVE_STRING (cResponse,"TAG_MUTE_MICS,' set mute '",1)
			cID = ATOI(LEFT_STRING(cResponse,1))
			    
		    IF (FIND_STRING(cResponse, "ITOA(cID),' true'",1))
		    {
			    BiampWm[cID].bMute = TRUE;
				    ON [vdvTP_Biamp, nMicMuteBtns[cID]]
					SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(cID),',0,Muted'"
		    }
		    ELSE IF (FIND_STRING(cResponse, "ITOA(cID),' false'",1))
		    {
			BiampWm[cID].bMute = FALSE;
			    OFF [vdvTP_Biamp, nMicMuteBtns[cID]]
				SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(cID),',0,',ITOA(BiampWm[cID].bLevel + MAX_COMP),'%'"
		    }
	    }
	    ACTIVE (FIND_STRING (cResponse, 'CEILINGMUTE-',1)) : //My Custom String
	    {
		REMOVE_STRING (cResponse, '-',1)
		cMute = LEFT_STRING (cResponse, 2)
		    
		SWITCH (cMute)
		{
		    CASE 'ON' :
		    {
			    ON [nCeiling_Mute]
				ON [vdvTP_Biamp, BTN_MUTE_CEILING]
				    //SEND_COMMAND vdvTesira, "'TELL-MUTECEILING'"
		    }
		    CASE 'OF' :
		    {
			    OFF [nCeiling_Mute]
				OFF [vdvTP_Biamp, BTN_MUTE_CEILING]
				   // SEND_COMMAND vdvTesira, "'TELL-UNMUTECEILING'"
		    }
		}
	    }
	}
    }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvTesira,nAudioBuffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Biamp, nMicChnlbtns]
{
    PUSH :
    {
	LOCAL_VAR INTEGER iCount;
	LOCAL_VAR INTEGER iGroup;
	
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nMicChnlbtns)
	
	iCount = (((nChnlIdx -1) %4) +1);
	iGroup = (((nChnlIdx -1) / 4) +1);
	
	SWITCH (iCount)
	{
	    //LAV 1
	    CASE 1:
	    {
		IF (BiampWm[iGroup].bMute == FALSE)
		{
		    fnMuteChannel(TAG_MUTE_MICS, iGroup, YES_ON)
		}
		ELSE
		{
		    fnMuteChannel(TAG_MUTE_MICS, iGroup,YES_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp (TAG_LEV_MICS, iGroup, BiampWm[iGroup].bLevel);
	    CASE 3 : fnSetVolumeDown (TAG_LEV_MICS, iGroup, BiampWm[iGroup].bLevel);
	    CASE 4 : fnSetVolumePreset (TAG_LEV_MICS, iGroup, BiampWm[iGroup].bPreset);
	}
    }
    HOLD [2, REPEAT]:
    {
	LOCAL_VAR INTEGER iCount;
	LOCAL_VAR INTEGER iGroup;
	
	STACK_VAR INTEGER nChnlIdx
	
	nChnlIdx = GET_LAST (nMicChnlbtns)
	    iCount = (((nChnlIdx -1) %4) +1);
		iGroup = (((nChnlIdx -1) / 4) +1);

	SWITCH (iCount)
	{
	    CASE 2 : fnSetVolumeUp (TAG_LEV_MICS, iGroup, BiampWm[iGroup].bLevel);
	    CASE 3 : fnSetVolumeDown (TAG_LEV_MICS, iGroup, BiampWm[iGroup].bLevel);
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, nPrgmBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmBtns);
	SWITCH (nPrgmIDX)
	{
	    CASE 1 :
	    {
		IF (BiampPrgm.bMute == FALSE) {
		    fnMuteChannel(TAG_MUTE_PRGM, ID_PRGM_LEV,YES_ON)
		}
		ELSE
		{
		   fnMuteChannel(TAG_MUTE_PRGM, ID_PRGM_LEV,YES_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	    CASE 4 : fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bPreset);
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmBtns);
	SWITCH (nPrgmIDX)
	{
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bLevel);
	}
    }
}
BUTTON_EVENT [vdvTP_Biamp, BTN_MUTE_CEILING]
{
    PUSH :
    {
	IF (nCeiling_Mute == FALSE) {
	    fnMuteLogic(TAG_CEILING, ID_CEILING, YES_ON);
	} ELSE {
		fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF);
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTesira]
{
    ONLINE :
    {
	SEND_STRING 0, "'<======= Biamp Now Online! =======>'"
	    MyBiampStruct.bBiampOnline = TRUE;
	
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 150
	{
	    fnResetAudio()
	}
    }
    OFFLINE :
    {
	MyBiampStruct.bBiampOnline = FALSE;
	    SEND_STRING 0, "'<=======Biamp Now Offline! =======>'" //Dropped off the Bus
    }
    STRING :
    {
	fnParseTesira();
	CANCEL_WAIT 'BIAMP_COMM'
	
	WAIT 3400 'BIAMP_COMM'
	{
	    MyBiampStruct.bBiampOnline = FALSE;
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 2800 'Biamp Pulse'
    {
	SEND_STRING dvTesira, "'DEVICE get hostname',MSG_ETX"
    }
}
    
