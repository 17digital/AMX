PROGRAM_NAME='Qsys_Audio'

(*
    Q-SYS Help
    https://q-syshelp.qsc.com/Content/External_Control_APIs/ECP/ECP_Commands.htm
    
    TCP-PORT - 1702
    Serial Port Baud 57600 N 8 1
*)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED	dvQsysAudio
//dvQsysAudio			= 5001:7:0	// QSC CORE 510i 500I, 57600,8,N,1
dvQsysAudio = 				0:3:0
#END_IF

#IF_NOT_DEFINED dvTP_Audio
dvTP_Audio =					10001:5:0
#END_IF


#IF_NOT_DEFINED dvTP_AudioLectern
dvTP_AudioLectern =			10002:5:0
#END_IF


vdvQsysAudio =				35999:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

MAX_LEVEL				= 10
MIN_LEVEL				= -100
COMPENSATE_LEV			= 90 //Equal to 100 on touch panel...
//MinLevel for QSys...

MIC_COUNT				= 5; // Podium + 4Wm
QSYS_PORT				= 1702
CHAR QSYS_IP[]			= 'na-gymdsp.amx.gatech.edu' // 172.21.12.139

//Qsys Control Tags....
TAG_LEV_PRGM			= 'ProgLevel'
TAG_MUTE_PRGM			= 'ProgMute'
TAG_LEV_PRGM2			= 'Prog2V'
TAG_MUTE_PRGM2			= 'Prog2M'

TAG_LEV_WL1				= 'WM1Level'
TAG_LEV_WL2				= 'WM2Level'
TAG_LEV_WL3				= 'WM3Level'
TAG_LEV_WL4				= 'WM4Level'
TAG_LEV_WL5				= 'WM5Level'
TAG_LEV_WL6				= 'WM6Level'

TAG_MUTE_WL1			= 'WM1Mute'
TAG_MUTE_WL2			= 'WM2Mute'
TAG_MUTE_WL3			= 'WM3Mute'
TAG_MUTE_WL4			= 'WM4Mute'
TAG_MUTE_WL5			= 'WM5Mute'
TAG_MUTE_WL6			= 'WM6Mute'

TAG_MUTE_PODIUM		= 'PodiumMute'
TAG_LEV_PODIUM			= 'PodiumLevel'

TAG_MUTE_MASTER		= 'MainM';
TAG_LEV_MASTER			= 'MainV';

TAG_MUTE_CLASSROOM	= 'ClassroomM'
TAG_LEV_CLASSROOM		= 'ClassroomV'

TAG_MODE_CLASSROOM	= 'ClassMute'; // 3 speakers [Alighs w/ L+R Projector]
TAG_MODE_CONCERT		= 'ConcertMute'; // Line Arrays [Aligns w/ Main Projector]
TAG_MODE_AUDIO_ONLY	= 'AudioOnlyMute' // Far outside speakers (Surround)

//More Tags....
(*
    Concert level runs this string >>> SEND_STRING MIXER,"'csp SysMute 0',$0A"

*)
TXT_PRGM				= 10

MUTE_ON				= 1;
MUTE_OFF 				= 0;

#IF_NOT_DEFINED MSG_LF
CHAR MSG_LF		= $0A;
#END_IF

(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _QsysStruct
{
    INTEGER bQsysOnline;
    CHAR bIP[255];
    INTEGER bPort;
    CHAR bProject[100];
}
STRUCTURE _QsysMix
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
}

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

_QsysStruct MyQsysStruct;
_QsysMix QsysPrgm;
_QsysMix QsysMics[7];
VOLATILE CHAR cQsysBuffer[500];

//Presets....
VOLATILE SINTEGER nPodium_Preset = -10;
VOLATILE SINTEGER nMic_Preset = -15;
VOLATILE SINTEGER nProgram_Level_Preset = -12;
VOLATILE INTEGER bAudioRun;

VOLATILE DEV vdvTP_Qsys[] =
{
    dvTP_Audio,
    dvTP_AudioLectern
}
VOLATILE INTEGER nMicChnlbtns[] =
{
    // Lectern
    1,2,3,4,

    // Lav 1
    5,6,7,8,

    //Mic 2
    9,10,11,12,
    
    //Mic 3
    13,14,15,16,
    
    //Mic 4
    17, 18, 19, 20
};
VOLATILE CHAR nMicTagLevel[5][12] =
{
    'PodiumLevel',
    'WM1Level',
    'WM2Level',
    'WM3Level',
    'WM4Level'
};
VOLATILE CHAR nMicTagMute[5][12] =
{
    'PodiumMute',
    'WM1Mute',
    'WM2Mute',
    'WM3Mute',
    'WM4Mute'
};
VOLATILE INTEGER nMicMuteBtns[] =
{
    1, 5, 9, 13, 17
};
VOLATILE INTEGER nPrgmBtns[] =
{
    //Program
    37,38,39,40
};

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnStartQsysConnection() {
	    
	    MyQsysStruct.bIP = QSYS_IP;
	    MyQsysStruct.bPort = QSYS_PORT;
	    
	    WAIT 10 {
		IP_CLIENT_OPEN(dvQsysAudio.PORT, MyQsysStruct.bIP, MyQsysStruct.bPort, IP_TCP);
		    SEND_STRING 0, "'Attempt Qsys 510i Core IP Connection'"
		    WAIT 20 {
			fnResetAudio();
		    }
	    }    
}
DEFINE_FUNCTION fnCloseQsysConnection() {
	IP_CLIENT_CLOSE (dvQsysAudio.PORT);
		//SEND_STRING vdvDevice, "'Closed TV IP Connection...'"
}
DEFINE_FUNCTION CHAR[100] GetQsysIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '" ;
	CASE 4 : iReturn = "'Unknown host'";
	CASE 6 : iReturn = "'Connection Refused'";
	CASE 7 : iReturn = "'Connection timed Out'";
	CASE 8 : iReturn = "'Unknown Connection Error'";
	CASE 9 : iReturn = "'Already Closed'";
	CASE 10 : iReturn = "'Binding Error'";
	CASE 11 : iReturn = "'Listening Error'";
	CASE 14 : iReturn = "'Local Port Already Used'";
	CASE 15 : iReturn = "'UDP Socket Already Listening'";
	CASE 16 : iReturn = "'Too Many Open Sockets'";
	CASE 17 : iReturn = "'Local Port Not Open'"
	
	DEFAULT : iReturn = "'(', ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION fnMuteChannel (CHAR cTag[], INTEGER cState) {
			SEND_STRING dvQsysAudio, "'csp ',cTag,' ',ITOA(cState),MSG_LF"  // Control Set Position
}
DEFINE_FUNCTION fnSetVolumePreset(CHAR cTag[], SINTEGER cPreset) {
			SEND_STRING dvQsysAudio, "'csv ',cTag,' ',ITOA(cPreset),MSG_LF" // Control Set Value
}
DEFINE_FUNCTION fnSetVolumeUp (CHAR cTag[]) {
			SEND_STRING dvQsysAudio, "'css ' ,cTag,' ++1',MSG_LF"   // Contro Set String
}
DEFINE_FUNCTION fnSetVolumeDown (CHAR cTag[]) {
			SEND_STRING dvQsysAudio, "'css ' ,cTag,'  --1',MSG_LF" 
}
DEFINE_FUNCTION fnSetPresetVar() {
			QsysMics[1].bPreset = nPodium_Preset;
			QsysMics[2].bPreset = nMic_Preset;
			QsysMics[3].bPreset = nMic_Preset;
			QsysMics[4].bPreset = nMic_Preset;
			QsysMics[5].bPreset = nMic_Preset;
			QsysMics[6].bPreset = nMic_Preset;
			QsysMics[7].bPreset = nMic_Preset;
			QsysPrgm.bPreset = nProgram_Level_Preset;
}
DEFINE_FUNCTION fnSetAllMicPresets()
{
    STACK_VAR INTEGER cIn;
    
    FOR (cIn=1; cIn<=MIC_COUNT; cIn++) {
	    fnSetVolumePreset (nMicTagLevel[cIn], QsysMics[cIn].bPreset);
    }
}
DEFINE_FUNCTION fnUnMuteAll()
{
    STACK_VAR INTEGER cIn;
    
        FOR (cIn=1; cIn<=MIC_COUNT; cIn++) {
	    fnMuteChannel (nMicTagMute[cIn], MUTE_OFF);
    }
}
DEFINE_FUNCTION fnResetAudio()
{
    bAudioRun = TRUE;
    fnSetPresetVar();
    
    WAIT 20 fnUnMuteAll();
    WAIT 60 fnSetAllMicPresets();
    WAIT 100 fnMuteChannel (TAG_MUTE_PRGM, MUTE_OFF);
    WAIT 110 fnSetVolumePreset (TAG_LEV_PRGM, QsysPrgm.bPreset);
    
    WAIT 120 bAudioRun = FALSE;
}
DEFINE_FUNCTION fnParseQsys()
{
    STACK_VAR CHAR cResponse[100]
    STACK_VAR CHAR cTag[30]
    LOCAL_VAR CHAR cProject[30];
    STACK_VAR CHAR cMsg[4]; // Was Local!
    LOCAL_VAR INTEGER b;
    
    WHILE (FIND_STRING(cQsysBuffer,"$0D,$0A",1))
    {
	cResponse = REMOVE_STRING (cQsysBuffer,"$0D,$0A",1)
	    MyQsysStruct.bQsysOnline = TRUE;
	
	SELECT
	{
	    ACTIVE (FIND_STRING(cResponse, "'sr "'",1)) :
	    {
		SEND_STRING vdvQsysAudio, "'Found the Qsys Core'"
		
		    REMOVE_STRING (cResponse, "'sr "'",1);
			cProject = cResponse;
			cProject = REMOVE_STRING (cProject, '"',1); // The next Quote...
			    MyQsysStruct.bProject = LEFT_STRING(cProject,LENGTH_STRING(cProject)-1);  // Should provide Tag
			
	    }
	    //parse Volume Changes
	    ACTIVE (FIND_STRING(cResponse,"'cv "'",1)): //Grab level changes....
	    {
		REMOVE_STRING(cResponse,"'cv "'",1)
		cTag = REMOVE_STRING(cResponse,'" "',1)
		cMsg = cResponse //Grab Remaining...
		cTag = LEFT_STRING(cTag,LENGTH_STRING(cTag)-3);  // Should provide Tag
		
		FOR (b=1; b<=MIC_COUNT; b++) {

		    IF (FIND_STRING(cTag, nMicTagLevel[b],1)) {  // Retreive Levels

			QsysMics[b].bLevel = ATOI(cMsg);
			    SEND_COMMAND vdvTP_Qsys, "'^TXT-',ITOA(b),',0,',ITOA(QsysMics[b].bLevel + COMPENSATE_LEV),'%'"
		    }
		    IF (FIND_STRING(cTag, nMicTagMute[b],1)) { // Retreive Mute State { cv "WM4Mute" "muted" 1 1
			
			    IF (FIND_STRING(cMsg, "'mute'",1)) {
				QsysMics[b].bMute = TRUE;
				    ON [vdvTP_Qsys, nMicMuteBtns[b]];
					SEND_COMMAND vdvTP_Qsys, "'^TXT-',ITOA(b),',0,Muted'"
			    } ELSE {
				 QsysMics[b].bMute = FALSE;
				    OFF [vdvTP_Qsys, nMicMuteBtns[b]]
					SEND_COMMAND vdvTP_Qsys, "'^TXT-',ITOA(b),',0,',ITOA(QsysMics[b].bLevel + COMPENSATE_LEV),'%'"   
			    }
		    }
		}
		IF (FIND_STRING(cTag, TAG_LEV_PRGM,1)) {
		    QsysPrgm.bLevel = ATOI(cMsg);
			    SEND_COMMAND vdvTP_Qsys, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(QsysPrgm.bLevel + COMPENSATE_LEV),'%'"
		}
		IF (FIND_STRING(cTag, TAG_MUTE_PRGM,1)) {
			IF (FIND_STRING(cMsg, "'mute'",1)) {
				QsysPrgm.bMute = TRUE;
				    ON [vdvTP_Qsys, nPrgmBtns[1]];
					SEND_COMMAND vdvTP_Qsys, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
			    } ELSE {
				 QsysPrgm.bMute = FALSE;
				    OFF [vdvTP_Qsys, nPrgmBtns[1]]
					SEND_COMMAND vdvTP_Qsys, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(QsysPrgm.bLevel + COMPENSATE_LEV),'%'"   
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

CREATE_BUFFER dvQsysAudio, cQsysBuffer;

WAIT 100 '10 Seconds' {
    fnStartQsysConnection();
}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Qsys, nMicChnlbtns]
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
	    CASE 1:
	    {
		IF (QsysMics[iGroup].bMute == FALSE) {
		    fnMuteChannel (nMicTagMute[iGroup], MUTE_ON);
		} ELSE {
			fnMuteChannel (nMicTagMute[iGroup], MUTE_OFF);
		}
	    }
	    CASE 2 : fnSetVolumeUp (nMicTagLevel[iGroup]);
	    CASE 3 : fnSetVolumeDown (nMicTagLevel[iGroup]);
	    CASE 4 : fnSetVolumePreset (nMicTagLevel[iGroup], QsysMics[iGroup].bPreset);
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
	    CASE 2 : fnSetVolumeUp (nMicTagLevel[iGroup]);
	    CASE 3 : fnSetVolumeDown (nMicTagLevel[iGroup]);
	}
    }
}
BUTTON_EVENT [vdvTP_Qsys, nPrgmBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nPrgmIDX;
		nPrgmIDX = GET_LAST (nPrgmBtns);
		
	SWITCH (nPrgmIDX)
	{
	    CASE 1 :
	    {
		IF (QsysPrgm.bMute == FALSE) 	{
		    fnMuteChannel(TAG_MUTE_PRGM, MUTE_ON)
		} ELSE {
			fnMuteChannel(TAG_MUTE_PRGM, MUTE_OFF)
		}
	    }
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM);
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM);
	    CASE 4 : fnSetVolumePreset(TAG_LEV_PRGM, QsysPrgm.bPreset);
	}
    }
    HOLD [2, REPEAT]:
    {
	STACK_VAR INTEGER nPrgmIDX;
	
	nPrgmIDX = GET_LAST (nPrgmBtns);
	SWITCH (nPrgmIDX)
	{
	    CASE 2 : fnSetVolumeUp(TAG_LEV_PRGM);
	    CASE 3 : fnSetVolumeDown(TAG_LEV_PRGM);
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvQsysAudio]
{
    ONLINE :
    {
	SEND_STRING 0, "'<======= Qsys Now Online! =======>'"
	
//	SEND_COMMAND DATA.DEVICE, "'SET BAUD 57600,N,8,1'"
//	SEND_COMMAND DATA.DEVICE, "'RXON'"
//	SEND_COMMAND DATA.DEVICE, "'HSOFF'"	
	
	MyQsysStruct.bQsysOnline = TRUE;
    }
    OFFLINE :
    {
	SEND_STRING 0, "'<=======Qsys Now Offline! =======>'" //Dropped off the Bus
	    MyQsysStruct.bQsysOnline = FALSE;
    }
    ONERROR : 
    {
	//AMX_LOG (AMX_ERROR, "'dvController : onerror : ',GetSVSIIpError(DATA.NUMBER)");
	SEND_STRING vdvQsysAudio, "'Qsys onerror : ',GetQsysIpError(DATA.NUMBER)";
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14 :
	    {
		    fnCloseQsysConnection();
	    }
	}
    }
    STRING :
    {
	SEND_STRING vdvQsysAudio, "'QSYS Core, ',cQsysBuffer";
	
	fnParseQsys();
	CANCEL_WAIT 'QSYS_COMM'
	    WAIT 1200 'QSYS_COMM' {
		   MyQsysStruct.bQsysOnline = FALSE; 
	    }
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 450 'Qsys Pulse'
    {
	IF (MyQsysStruct.bQsysOnline == FALSE) {
	    fnStartQsysConnection();
		SEND_STRING vdvQsysAudio, "'Qsys IP Connection in progress'"
	} ELSE {
	    SEND_STRING dvQsysAudio, "'sg',MSG_LF" // Keep Alive
	}
    }
}
