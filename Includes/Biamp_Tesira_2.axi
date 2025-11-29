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
dvTesira =					5001:2:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR BIAMP_TYPE[]		= 'Tesira CI Dante';

//RMS Stuff...
BIAMP_INITIALIZED			= 251;
STAT_BIAMP_NORMAL		= 1001;
STAT_BIAMP_FAULT			= 1002;

HOLD_MAC_ADDRESS			= 17;
HOLD_IP_ADDRESS				= 15;

MAX_ATTRIBUTES				= 1;
//End RMS....

MAX_COMP			= 88 //Biamp | Value= 1120 | Level=  12
MAX_SPAN			= 6

VOL_UP				= 1
VOL_DN				= -1

MIC_COUNT			= 8;
MUTE_COUNT 		= 3;  // How many mute tags??
LEV_COUNT			= 3;  // How man level tags??
CEILING_COUNT		= 2;

ID_PRGM_LEV			= 1
ID_CEILING			= 1 //Logic Block
ID_FOYER			= 1;

//biamp tags...
TAG_LEV_PRGM		= 'Program'
TAG_LEV_MICS		= 'Microphones'
TAG_MUTE_MICS		= 'Microphones'
TAG_MUTE_PRGM		= 'ProgramMute'
TAG_CEILING			= 'privacymute'
TAG_SOURCE_SELECT	= 'SourceSelector1';
TAG_LEV_FOYER		= 'Foyer';
TAG_COMBINED		= 'COMBINED';
TAG_UNCOMBINED	= 'UNCOMBINED';

YES_ON				= 'true'
YES_OFF				= 'false'

//Panel Addresses...
TXT_PRGM			= 10

SOURCE_PC			= 1;
SOURCE_LECTERN		= 2;

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
    INTEGER bBiampOnline;
}
STRUCTURE _BiampWm
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
}
STRUCTURE _BiampPrgm
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
    INTEGER bSource;
}
STRUCTURE _BiampCeiling
{
    INTEGER bMute;
}
STRUCTURE _BiampFaults
{
    INTEGER bStatus; // GVE Alert
    CHAR bError[45];
    CHAR bMessage[100];
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR bFound[20];

//RMS Variables....
_BiampStruct MyBiampStruct;
_BiampWm BiampWm[MIC_COUNT];
_BiampPrgm BiampPrgm[2];
_BiampCeiling BiampCeiling[2];
_BiampFaults BiampFaults;

VOLATILE SINTEGER nMaximum = 12;
VOLATILE SINTEGER nMinimum = -88;

VOLATILE CHAR nAudioBuffer[1000];

//Preset Levels
VOLATILE SINTEGER nLav_Level_Preset = -8;
VOLATILE SINTEGER nMic_Level_Preset = -10;
VOLATILE SINTEGER nProgram_Level_Preset = -10;

VOLATILE INTEGER bAudioRun;

VOLATILE DEV vdvTP_Biamp[] = 
{
    dvTP_Biamp, 
    dvTP_Biamp2
}
VOLATILE INTEGER nMicChnlbtns[] =
{
    // Wm1
    1,2,3,4,

    // Wm2
    5,6,7,8,

    //Wm3
    9,10,11,12,
    
    //Wm4
    13,14,15,16,
    
    //Wm5
    17, 18, 19, 20,
    
    //Wm6
    21, 22, 23, 24
};
VOLATILE INTEGER nMicMuteBtns[] =
{
    1, 5, 9, 13, 17, 21
};
VOLATILE INTEGER nPrgmBtns[] =
{
    //Program
    37,38,39,40
};
VOLATILE CHAR nTagLevels[3][11] =  // Biamp Level Tags
{
    'Microphones',
    'Level3',
    'Level13'
}
VOLATILE CHAR nTagMutes[3][11] =
{
    'Microphones',
    'Level3',
    'Level13'
}
VOLATILE CHAR nTagSource[2][15] =
{
    'SourceSelector1',
    'SourceSelector2'
};
VOLATILE CHAR nPrivacyTagMute[2][14] =
{
    'privacymute114',
    'privacymute115'
};

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnSetAudioSource (CHAR cTag[], INTEGER cIn) {
	    SEND_STRING dvTesira, "cTag,' set sourceSelection ',ITOA(cIn),MSG_ETX"
}
DEFINE_FUNCTION CHAR[50] fnRecallPreset(CHAR cPreset[]) {
		   SEND_STRING dvTesira, "'DEVICE recallPresetByName ',cPreset,MSG_ETX"
			RETURN cPreset;
}
DEFINE_FUNCTION fnMuteLogic(CHAR cTag[], INTEGER cIn, CHAR cToggle[MAX_SPAN])
{
    SEND_STRING dvTesira, "cTag,' set state ',ITOA(cIn),' ',cToggle,MSG_ETX" 
}
DEFINE_FUNCTION fnMuteChannel(CHAR cTag[], INTEGER cIn, CHAR cValue[])
{
    SEND_STRING dvTesira, "cTag,' set mute ',ITOA(cIn),' ',cValue,MSG_ETX"
}
DEFINE_FUNCTION fnSetVolumeUp(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    IF (cLev < nMaximum) {
	SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA( cLev + VOL_UP),MSG_ETX"
    }
}
DEFINE_FUNCTION fnSetVolumeDown(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    IF (cLev > nMinimum) {
	    SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev + VOL_DN),MSG_ETX"
    }
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], INTEGER cIn, SINTEGER cLev)
{
    SEND_STRING dvTesira, "cTag,' set level ',ITOA(cIn),' ',ITOA(cLev),MSG_ETX"
}
DEFINE_FUNCTION fnSetPresetVar()
{
    //Declare Starting Presets....
    BiampWm[1].bPreset = nLav_Level_Preset;
    BiampWm[2].bPreset = nLav_Level_Preset;
    BiampWm[3].bPreset = nMic_Level_Preset;
    BiampWm[4].bPreset = nLav_Level_Preset;
    BiampWm[5].bPreset = nLav_Level_Preset;
    BiampWm[6].bPreset = nMic_Level_Preset;
    BiampWm[7].bPreset = nMic_Level_Preset;
    BiampWm[8].bPreset = nMic_Level_Preset;

    BiampPrgm[1].bPreset = nProgram_Level_Preset;  // 114
    BiampPrgm[2].bPreset = nProgram_Level_Preset;  // 115
}
DEFINE_FUNCTION fnSetWmPresets()
{
    STACK_VAR INTEGER cIn;
    
    FOR (cIn=1; cIn<=MIC_COUNT; cIn++) {
	fnSetVolumePreset (TAG_LEV_MICS, cIn, BiampWm[cIn].bPreset);
    }
}
DEFINE_FUNCTION fnUnMuteWmMics()
{
    STACK_VAR INTEGER cIn;
    
    FOR (cIn=1; cIn<=MIC_COUNT; cIn++) {
	fnMuteChannel (TAG_MUTE_MICS, cIn, YES_OFF);
    }
}
DEFINE_FUNCTION fnUnMuteCeilingAll()
{
    STACK_VAR INTEGER cIn;
    
    FOR (cIn=1; cIn<=CEILING_COUNT; cIn++) {
	fnMuteLogic (nPrivacyTagMute[cIn], ID_CEILING, YES_OFF);
    }
}
DEFINE_FUNCTION fnResetAudio()
{

    bAudioRun = TRUE;
    fnSetPresetVar();
    
    WAIT 20 fnUnMuteWmMics();
    WAIT 70 fnSetWmPresets();
    WAIT 120 fnMuteChannel (nTagMutes[2], ID_PRGM_LEV, YES_OFF);
    WAIT 130 fnSetVolumePreset (nTagLevels[2], ID_PRGM_LEV, BiampPrgm[1].bPreset);
    
    WAIT 140 fnMuteChannel (nTagMutes[3], ID_PRGM_LEV, YES_OFF);
    WAIT 150 fnSetVolumePreset (nTagLevels[3], ID_PRGM_LEV, BiampPrgm[2].bPreset);
    
    WAIT 170 fnUnMuteCeilingAll();
    
    WAIT 190 SEND_STRING dvTesira, "nTagSource[1],' get sourceSelection',MSG_ETX"

    WAIT 210 SEND_STRING dvTesira, "'DEVICE get ipStatus control',MSG_ETX"
    WAIT 230 SEND_STRING dvTesira, "'DEVICE get hostname',MSG_ETX"
	
    WAIT 250 SEND_STRING dvTesira, "'DEVICE get serialNumber',MSG_ETX"
	
    WAIT 270 SEND_STRING dvTesira, "'DEVICE get version',MSG_ETX"
    WAIT 300 SEND_STRING dvTesira, "'DEVICE get activeFaultList',MSG_ETX"
    
    WAIT 300 bAudioRun = FALSE;
    
}
DEFINE_FUNCTION fnAudioPanelReset() {

    fnSetPresetVar();
	bAudioRun = TRUE;
    
    WAIT 20 fnUnMuteWmMics();
    WAIT 60 fnSetWmPresets();
    WAIT 90 fnMuteChannel (nTagMutes[2], ID_PRGM_LEV, YES_OFF);
    WAIT 100 fnSetVolumePreset (nTagLevels[2], ID_PRGM_LEV, BiampPrgm[1].bPreset);
    
    WAIT 110 fnMuteChannel (nTagMutes[3], ID_PRGM_LEV, YES_OFF);
    WAIT 120 fnSetVolumePreset (nTagLevels[3], ID_PRGM_LEV, BiampPrgm[2].bPreset);
    
    WAIT 130 fnUnMuteCeilingAll();

	WAIT 150 bAudioRun = FALSE;
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[500]; 
    STACK_VAR INTEGER cID; // Biamp Component ID holder
    STACK_VAR INTEGER b;  // Counter
    STACK_VAR CHAR cMsg[4];
    STACK_VAR CHAR cTag[50]; // Holds the Biamp Tag
    STACK_VAR CHAR cGet[20];
    
    LOCAL_VAR CHAR cState[15];
    LOCAL_VAR CHAR cNetHelp[50];
    LOCAL_VAR CHAR cMute[2]
    LOCAL_VAR CHAR cPreset[5];

    WHILE (FIND_STRING(nAudioBuffer,"$0D,$0A",1))
    {	
	cResponse = REMOVE_STRING(nAudioBuffer,"$0D,$0A",1)
	    MyBiampStruct.bBiampOnline = TRUE;
	    
	SELECT
	{
	    ACTIVE (FIND_STRING(cResponse,'Welcome to the Tesira Text Protocol Server...',1)):
	    {
		SEND_STRING 0, "'Tesira has booted and now Ready'"
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
	    ACTIVE (FIND_STRING (cResponse, "' get sourceSelection'",1)) :
	    {
		cTag = LEFT_STRING(cResponse, 15); // Will grab the full tag of source selector
		    bFound = cTag;
	    }
	    ACTIVE (FIND_STRING (cResponse,"'DEVICE get '",1)) :  // Grab the Header!
	    {
		REMOVE_STRING (cResponse, "'DEVICE get '",1);
		    bFound = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -2);
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
		    CASE 'version' :
		    {
			REMOVE_STRING (cResponse,'"',1)
			
			MyBiampStruct.bFirmware = LEFT_STRING(cResponse,LENGTH_STRING(cResponse) -3)
			    bFound = '';
		    }
		    CASE 'SourceSelector1' :
		    {
			BiampPrgm[1].bSource = ATOI(cResponse);
			    bFound = '';
		    }
		    CASE 'SourceSelector2' :
		    {
			BiampPrgm[2].bSource = ATOI(cResponse);
			    bFound = '';
		    }
		    CASE 'activeFaultList' :
		    {
			
			STACK_VAR CHAR iError[45];
			    STACK_VAR CHAR iSubError[100];
			    bFound = '';
			    
			REMOVE_STRING(cResponse, '[{"id":',1);
			    iError = REMOVE_STRING(cResponse, '"name"',1);
				BiampFaults.bError = LEFT_STRING(iError,LENGTH_STRING(iError) -7); //Grab Error Header
				    //SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(nPanelTXT[3]),',0,',BiampFaults.bError"
				    
				SWITCH (BiampFaults.bError)
				{
				    CASE 'INDICATOR_NONE_IN_DEVICE' : // All Good in da Hood
				    {
					iSubError = 'No Errors';
					    BiampFaults.bMessage = 'No Biamp Faults';
						BiampFaults.bStatus = STAT_BIAMP_NORMAL;
					    //SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(nPanelTXT[4]),',0,',iSubError"
				    }
				    DEFAULT :
				    {
					    REMOVE_STRING(cResponse,'"faults":[{"id":',1);
					REMOVE_STRING (cResponse, '"name":"',1)
					    iSubError = REMOVE_STRING (cResponse, '"} {"id":',1);
						BiampFaults.bMessage = LEFT_STRING(iSubError,LENGTH_STRING(iSubError) -9); 
						    BiampFaults.bStatus = STAT_BIAMP_FAULT;
					    //SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(nPanelTXT[4]),',0,',BiampFaults.bMessage"
				    }
				}
		    }
		}
	    }
	    ACTIVE (FIND_STRING(cResponse,"' set level '",1)) : // Microphones set level 1 -11
	    {
		cTag = REMOVE_STRING(cResponse,"' set level '",1) // 1 -11
		    cTag = LEFT_STRING(cTag,LENGTH_STRING(cTag) -11);  // Removes the ' set level ' and leaves remaining tag
			    
		FOR (b=1; b<=(LEV_COUNT); b++) {
			
		    IF (FIND_STRING(cTag, nTagLevels[b],1)) {
			    cID = ATOI(LEFT_STRING(cResponse,1));
			    cMsg = MID_STRING (cResponse,3,3);
			    
			    SWITCH (b)  // Tag
			    {
				CASE 1 : {
				    BiampWm[cID].bLevel = ATOI(cMsg);
					    SEND_COMMAND vdvTP_Biamp, "'^TXT-',ITOA(cID),',0,',ITOA(BiampWm[cID].bLevel + MAX_COMP),'%'"
				}
				CASE 2 : {
				    BiampPrgm[1].bLevel = ATOI(cMsg);
					SEND_COMMAND vdvTP_Biamp[1], "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm[1].bLevel + MAX_COMP),'%'"
				}
				CASE 3 : {
				    BiampPrgm[2].bLevel = ATOI(cMsg);
					SEND_COMMAND vdvTP_Biamp[2], "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm[2].bLevel + MAX_COMP),'%'"
				}
			    }
		    }
		}
	    }
	    ACTIVE (FIND_STRING (cResponse, "' set mute '",1)) :  // ProgramMute002 set mute 1 true
	    {
		cTag = REMOVE_STRING (cResponse,"' set mute '",1);
		    cTag = LEFT_STRING(cTag,LENGTH_STRING(cTag) -10);  // Removes the ' set mute ' and leaves remaining tag
		    
		FOR (b=1; b<=(MUTE_COUNT); b++) {
		
		    IF (FIND_STRING(cTag, nTagMutes[b],1)) {
			cID = ATOI(LEFT_STRING(cResponse,1))  // Grab Tag ID - 
			    cState = cResponse;
			 
			 SWITCH (b)
			 {
			    CASE 1 : {   // I have found Mic mutes - First in the array I declared up top
			    
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
			    CASE 2 : {  // 114 Program Mute
				    IF (FIND_STRING(cResponse, "ITOA(ID_PRGM_LEV),' true'",1))
				    {
					    BiampPrgm[1].bMute = TRUE;
						    ON [vdvTP_Biamp[1], nPrgmBtns[1]]
							SEND_COMMAND vdvTP_Biamp[1], "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
				    }
				    ELSE IF (FIND_STRING(cResponse, "ITOA(ID_PRGM_LEV),' false'",1))
				    {
					BiampPrgm[1].bMute = FALSE;
					    OFF [vdvTP_Biamp[1], nPrgmBtns[1]]
						SEND_COMMAND vdvTP_Biamp[1], "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm[1].bLevel + MAX_COMP),'%'"
				    }
			    
			    }
			    CASE 3 : {
				    IF (FIND_STRING(cResponse, "ITOA(ID_PRGM_LEV),' true'",1))
				    {
					    BiampPrgm[2].bMute = TRUE;
						    ON [vdvTP_Biamp[2], nPrgmBtns[1]]
							SEND_COMMAND vdvTP_Biamp[2], "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
				    }
				    ELSE IF (FIND_STRING(cResponse, "ITOA(ID_PRGM_LEV),' false'",1))
				    {
					BiampPrgm[2].bMute = FALSE;
					    OFF [vdvTP_Biamp[2], nPrgmBtns[1]]
						SEND_COMMAND vdvTP_Biamp[2], "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm[2].bLevel + MAX_COMP),'%'"
				    }
			    }
			}
		    }
		}
	    }
	    ACTIVE (FIND_STRING (cResponse, "' set state '",1)) : //My Custom String 
	    {
		cTag = REMOVE_STRING (cResponse,"' set state '",1);
		    cTag = LEFT_STRING(cTag,LENGTH_STRING(cTag) -11);  // Removes the ' set level ' and leaves remaining tag
		    
		FOR (b=1; b<=(CEILING_COUNT); b++) {
		
		    IF (FIND_STRING(cTag, nPrivacyTagMute[b],1)) {
			 
			    IF (FIND_STRING(cResponse, "ITOA(ID_CEILING),' true'",1))
			    {
				    BiampCeiling[b].bMute = TRUE;
					    ON [vdvTP_Biamp[b], BTN_MUTE_CEILING];
			    }
			    ELSE IF (FIND_STRING(cResponse, "ITOA(ID_CEILING),' false'",1))
			    {
				BiampCeiling[b].bMute = FALSE;
				    OFF [vdvTP_Biamp[b], BTN_MUTE_CEILING];
			    }
		    }
		}
	    }
	    ACTIVE (FIND_STRING (cResponse, "' set sourceSelection '",1)) : // My Custom String 
	    {
		cTag = REMOVE_STRING (cResponse,"' set sourceSelection '",1);
		    cTag = LEFT_STRING(cTag,LENGTH_STRING(cTag) -21);  // Removes the ' set sourceSelection ' and leaves remaining tag
		    
		FOR (b=1; b<=2; b++) {
		
		    IF (FIND_STRING(cTag, nTagSource[b],1)) {
			    BiampPrgm[b].bSource = ATOI(LEFT_STRING(cResponse,1));
			    
//			    SWITCH (BiampPrgm[b].bSource)
//			    {
//				CASE SOURCE_PC : {  // 114
//				    ON [vdvTP_Main[b], BTN_AUDIO_PC];
//				}
//				CASE SOURCE_LECTERN : {
//				    ON [vdvTP_Main[b], BTN_AUDIO_LECTERN];
//				}
//			    }
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

CREATE_BUFFER dvTesira, nAudioBuffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Biamp, nMicChnlbtns]  // All Mics
{
    PUSH :
    {
	LOCAL_VAR INTEGER iCount;
	LOCAL_VAR INTEGER iGroup;
	
	STACK_VAR INTEGER nChnlIdx;
	
	nChnlIdx = GET_LAST (nMicChnlbtns)
	
	iCount = (((nChnlIdx -1) %4) +1);
	iGroup = (((nChnlIdx -1) / 4) +1);
	
	SWITCH (iCount)
	{
	    //LAV 1
	    CASE 1:
	    {
		IF (BiampWm[iGroup].bMute == FALSE) {
		    fnMuteChannel(TAG_MUTE_MICS, iGroup, YES_ON)
		} ELSE {
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
	
	STACK_VAR INTEGER nChnlIdx;
	    	
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
BUTTON_EVENT [dvTP_Biamp, nPrgmBtns] // 114
{
    PUSH :
    {
	STACK_VAR INTEGER nPrgmIDX;
	    nPrgmIDX = GET_LAST (nPrgmBtns);
	
	SWITCH (nPrgmIDX)
	{
	    CASE 1 :
	    {
		IF (BiampPrgm[1].bMute == FALSE) {
		    fnMuteChannel(nTagMutes[2], ID_PRGM_LEV,YES_ON)
		} ELSE {
			fnMuteChannel(nTagMutes[2], ID_PRGM_LEV,YES_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp(nTagLevels[2], ID_PRGM_LEV, BiampPrgm[1].bLevel);
	    CASE 3 : fnSetVolumeDown(nTagLevels[2], ID_PRGM_LEV, BiampPrgm[1].bLevel);
	    CASE 4 : fnSetVolumePreset(nTagLevels[2], ID_PRGM_LEV, BiampPrgm[1].bPreset);
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmBtns);
	SWITCH (nPrgmIDX)
	{
	    CASE 2 : fnSetVolumeUp(nTagLevels[2], ID_PRGM_LEV, BiampPrgm[1].bLevel);
	    CASE 3 : fnSetVolumeDown(nTagLevels[2], ID_PRGM_LEV, BiampPrgm[1].bLevel);
	}
    }
}
BUTTON_EVENT [dvTP_Biamp, BTN_MUTE_CEILING]
{
    PUSH :
    {	
	IF (BiampCeiling[1].bMute == FALSE) {
	    fnMuteLogic(nPrivacyTagMute[1], ID_CEILING, YES_ON)
	} ELSE {
		fnMuteLogic(nPrivacyTagMute[1], ID_CEILING, YES_OFF)
	}
    }
}

DEFINE_EVENT // Rm 115
BUTTON_EVENT [dvTP_Biamp2, nPrgmBtns] // 114
{
    PUSH :
    {
	STACK_VAR INTEGER nPrgmIDX;
	    nPrgmIDX = GET_LAST (nPrgmBtns);
	
	SWITCH (nPrgmIDX)
	{
	    CASE 1 :
	    {
		IF (BiampPrgm[2].bMute == FALSE) {
		    fnMuteChannel(nTagMutes[3], ID_PRGM_LEV,YES_ON)
		} ELSE {
			fnMuteChannel(nTagMutes[3], ID_PRGM_LEV,YES_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp(nTagLevels[3], ID_PRGM_LEV, BiampPrgm[2].bLevel);
	    CASE 3 : fnSetVolumeDown(nTagLevels[3], ID_PRGM_LEV, BiampPrgm[2].bLevel);
	    CASE 4 : fnSetVolumePreset(nTagLevels[3], ID_PRGM_LEV, BiampPrgm[2].bPreset);
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmBtns);
	SWITCH (nPrgmIDX)
	{
	    CASE 2 : fnSetVolumeUp(nTagLevels[3], ID_PRGM_LEV, BiampPrgm[2].bLevel);
	    CASE 3 : fnSetVolumeDown(nTagLevels[3], ID_PRGM_LEV, BiampPrgm[2].bLevel);
	}
    }
}
BUTTON_EVENT [dvTP_Biamp2, BTN_MUTE_CEILING]
{
    PUSH :
    {	
	IF (BiampCeiling[2].bMute == FALSE) {
	    fnMuteLogic(nPrivacyTagMute[2], ID_CEILING, YES_ON)
	} ELSE {
		fnMuteLogic(nPrivacyTagMute[2], ID_CEILING, YES_OFF)
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
	
	WAIT 2400 'BIAMP_COMM' {
	    MyBiampStruct.bBiampOnline = FALSE;
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 1200 'Biamp Pulse' {
	IF (bAudioRun == TRUE) {
		SEND_STRING 0, "'Biamp Resetting Audio'"
	} ELSE {
	    SEND_STRING dvTesira, "'DEVICE get activeFaultList',MSG_ETX"
		WAIT 30 {
		    SEND_STRING dvTesira, "nTagSource[1],' get sourceSelection',MSG_ETX"
	    }
	}
    }
}
	