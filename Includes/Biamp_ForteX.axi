PROGRAM_NAME='Biamp_Conference'

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



#IF_NOT_DEFINED dvTesira 
dvTesira =				0:11:0
#END_IF

#IF_NOT_DEFINED dvTP_Biamp
dvTP_Biamp =						10001:5:0
#END_IF

vdvTesira =				33555:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR BIAMP_IP_HOST[]				= 'coc103dsp.amx.gatech.edu'
BIAMP_IP_PORT					= 23;

CHAR BIAMP_TYPE[]		= 'Tesira ForteX';

//RMS Stuff...
STAT_BIAMP_NORMAL		= 1001;
STAT_BIAMP_FAULT			= 1002;
BIAMP_INITIALIZED			= 251;

HOLD_MAC_ADDRESS			= 17;
HOLD_IP_ADDRESS				= 15;

MAX_ATTRIBUTES				= 1;
//End RMS....

MAX_COMP			= 88 //Biamp | Value= 1120 | Level=  12
MAX_SPAN			= 6

VOL_UP				= 1
VOL_DN				= -1
VOL_SINGLE			= 1;
VOL_MULTI			= 3;

ID_PRGM_LEV			= 1
ID_CEILING			= 1 //Logic Block

//biamp tags...
TAG_LEV_PRGM		= 'Program'
TAG_CEILING			= 'privacymute'
TAG_TCM_MUTE		= 'tcmMute'
TAG_SOURCE_SELECT	= 'SourceSelector1'
SUB_CEILING_MUTE		= 'SubCeilingMute'
SUB_PRGM_MUTE			= 'SubPrgmMute'
SUB_PRGM_LEV			= 'SubPrgmLevel'		

YES_ON				= 'true'
YES_OFF				= 'false'

SOURCE_AUDIO_PC	= 1;
SOURCE_AUDIO_LAPTOP	= 2;
SOURCE_AUDIO_MERSIVE	= 3;

//Panel Addresses...
TXT_PRGM			= 10

BTN_MUTE_PRGM		= 37
BTN_MUTE_CEILING	= 50

#IF_NOT_DEFINED MSG_ETX 
CHAR MSG_ETX		= $0D;
#END_IF

#IF_NOT_DEFINED MSG_LF
CHAR MSG_LF		= $0A;
#END_IF

(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _BiampStruct
{
    CHAR bHost[100];
    INTEGER bPort;
    CHAR bFlag;
    CHAR bOnline;
    INTEGER bTelnetConnected;
    INTEGER bDbug;
}
STRUCTURE _BiampPrgm
{
    INTEGER bMute;
    SINTEGER bLevel;
    SINTEGER bPreset;
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

VOLATILE _BiampStruct MyBiampStruct;
VOLATILE _BiampPrgm BiampPrgm;

VOLATILE SINTEGER nMaximum = 12;
VOLATILE SINTEGER nMinimum = -88;

VOLATILE CHAR nAudioBuffer[1000];
VOLATILE SINTEGER nProgram_Level_Preset = -22;

VOLATILE INTEGER nCeiling_Mute
VOLATILE INTEGER bAudioRun;
VOLATILE INTEGER bAudioSource;

VOLATILE INTEGER nPrgmBtns[] =
{
    //Program
    37,38,39,40
}


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnSetAudioSource (INTEGER cIn) {
	    SEND_STRING dvTesira, "TAG_SOURCE_SELECT,' set sourceSelection ',ITOA(cIn),MSG_ETX"
}
DEFINE_FUNCTION fnMuteLogic(CHAR cTag[], INTEGER cIn, CHAR cToggle[])
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
DEFINE_FUNCTION fnRaiseVolume (CHAR cTag[], INTEGER cId, INTEGER cSize) {
	    SEND_STRING dvTesira, "cTag,' increment level ',ITOA(cId),' ',ITOA(cSize),MSG_ETX"
}
DEFINE_FUNCTION fnLowerVolume (CHAR cTag[], INTEGER cId, INTEGER cSize) {
    SEND_STRING dvTesira, "cTag,' decrement level ',ITOA(cId),' ',ITOA(cSize),MSG_ETX"
}
DEFINE_FUNCTION fnStartDspConnection()
{
    MyBiampStruct.bHost = BIAMP_IP_HOST;
    MyBiampStruct.bPort = BIAMP_IP_PORT;
    MyBiampStruct.bFlag = IP_TCP;
    
    MyBiampStruct.bTelnetConnected = FALSE;
    
    WAIT 20 '2 Seconds' {
        IP_CLIENT_OPEN (dvTesira.PORT, MyBiampStruct.bHost, MyBiampStruct.bPort, MyBiampStruct.bFlag) 
	    SEND_STRING 0, "'Attempt to Start DSP Telnet Connection...'"
    }
}
DEFINE_FUNCTION fnCloseDspConnection() {
	IP_CLIENT_CLOSE (dvTesira.PORT)
	    MyBiampStruct.bTelnetConnected = FALSE;
}
DEFINE_FUNCTION fnSetPresetVar()
{
    //Declare Starting Presets....   
    BiampPrgm.bPreset = nProgram_Level_Preset;
}
DEFINE_FUNCTION fnResetAudio()
{    
    fnSetPresetVar();
 
    WAIT 10 fnRunSubscriptions();
    
    WAIT 60 fnMuteChannel (TAG_LEV_PRGM, ID_PRGM_LEV, YES_OFF);
    WAIT 70 fnSetVolumePreset (TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bPreset);
    WAIT 80 fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF);
    
    WAIT 100 fnSetAudioSource(SOURCE_AUDIO_PC); // Default
    
}
DEFINE_FUNCTION fnRunSubscriptions() {

		    SEND_STRING dvTesira, "TAG_LEV_PRGM,' subscribe mute ',ITOA(ID_PRGM_LEV),' ',SUB_PRGM_MUTE,MSG_ETX" //10Seconds
    WAIT 20 SEND_STRING dvTesira, "TAG_LEV_PRGM,' subscribe level ',ITOA(ID_PRGM_LEV),' ',SUB_PRGM_LEV,MSG_ETX"
    WAIT 40 SEND_STRING dvTesira, "TAG_TCM_MUTE,' subscribe mute ',ITOA(ID_CEILING),' ',SUB_CEILING_MUTE,MSG_ETX"

}
DEFINE_FUNCTION fnTelnetNegotiation() {

    STACK_VAR CHAR sBuild[100];
    STACK_VAR INTEGER bIndex;
    
   // IF (Telnet_Complete == FALSE) {
    
	IF(FIND_STRING(DATA.TEXT, "$FF",1)) {
	    
		    sBuild = DATA.TEXT;
		    bIndex = FIND_STRING(sBuild,"$FF",1)
		    
	    WHILE (bIndex) {
		IF(sBuild[bIndex+1] = "$FD") sBuild[bIndex+1] =type_cast("$FC") //FD > FC (DO > WON'T)

		IF(sBuild[bIndex+1] = "$FB") sBuild[bIndex+1] = type_cast("$FE") //FB > FE (WILL > DON'T)

		bIndex = FIND_STRING(sBuild,"$FF",bIndex+1)
		    
	    }
	    SEND_STRING DATA.DEVICE,sBuild
	}
	ELSE {
	    MyBiampStruct.bTelnetConnected =TRUE;
	}
  //  }
}
DEFINE_FUNCTION fnParseTesira()
{
    STACK_VAR CHAR cResponse[1000];
    
    STACK_VAR INTEGER cID
    STACK_VAR CHAR cMsg[4]
    STACK_VAR CHAR cState[5]
    LOCAL_VAR CHAR cNetHelp[50];
    LOCAL_VAR CHAR cMute[2]
    LOCAL_VAR CHAR cPreset[5];

    WHILE (FIND_STRING(nAudioBuffer,"$0D,$0A",1))
    {	
	cResponse = REMOVE_STRING(nAudioBuffer,"$0D,$0A",1)
	    MyBiampStruct.bOnline = TRUE;
	    SEND_STRING vdvTesira, "'Dsp Telnet : ',cResponse"
	
	SELECT
	{
	    ACTIVE (FIND_STRING(cResponse,'Welcome to the Tesira Text Protocol Server...',1)):
	    {
		SEND_STRING 0, "'Tesira Telnet has Established!'"
			MyBiampStruct.bTelnetConnected = TRUE;
			    fnResetAudio();
	    }
	    ACTIVE (FIND_STRING (cResponse, "'! "publishToken":"SubPrgmLevel" "value":'",1)) :
	    {
		    REMOVE_STRING(cResponse,"'"value":'",1)
			BiampPrgm.bLevel = ATOI(cResponse);
			    SEND_COMMAND dvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm.bLevel + MAX_COMP),'%'"
	    }
	    ACTIVE (FIND_STRING (cResponse, "'! "publishToken":"SubPrgmMute" "value":'",1)) :
	    {
		REMOVE_STRING (cResponse, "'"value":'",1)
		    cState = cResponse;
		    
		IF (FIND_STRING (cState,'true',1)) {
			BiampPrgm.bMute = TRUE;
				ON [dvTP_Biamp, nPrgmBtns[1]]
				    SEND_COMMAND dvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,Muted'"
		} ELSE {
		    BiampPrgm.bMute = FALSE;
			OFF [dvTP_Biamp, nPrgmBtns[1]]
			    SEND_COMMAND dvTP_Biamp, "'^TXT-',ITOA(TXT_PRGM),',0,',ITOA(BiampPrgm.bLevel + MAX_COMP),'%'"
		}
	    }
	    ACTIVE (FIND_STRING (cResponse, "'! "publishToken":"SubCeilingMute" "value":'",1)) : 
	    {
		REMOVE_STRING (cResponse, "'"value":'",1)
		    cState = cResponse;
		    
		IF (FIND_STRING (cState,'true',1)) {
			nCeiling_Mute = TRUE;
				ON [dvTP_Biamp, BTN_MUTE_CEILING]
				    fnPanelColors(dvTP_Biamp, FALSE);
		} ELSE {
		    nCeiling_Mute = FALSE;
				OFF [dvTP_Biamp, BTN_MUTE_CEILING]
				    fnPanelColors(dvTP_Biamp, TRUE);
		}
	    }
	}
    }
}

DEFINE_START

CREATE_BUFFER dvTesira, nAudioBuffer;


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Biamp, nPrgmBtns]
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
		    fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV,YES_ON)
		} ELSE {
			fnMuteChannel(TAG_LEV_PRGM, ID_PRGM_LEV,YES_OFF)
		}
	    }
	    CASE 2 :  fnRaiseVolume (TAG_LEV_PRGM, ID_PRGM_LEV, VOL_MULTI);
	    CASE 3 : fnLowerVolume (TAG_LEV_PRGM, ID_PRGM_LEV, VOL_MULTI);
	    CASE 4 : fnSetVolumePreset(TAG_LEV_PRGM, ID_PRGM_LEV, BiampPrgm.bPreset);
	}
    }
//    HOLD [5, REPEAT]:
//    {
//	STACK_VAR INTEGER nPrgmIDX;
//	
//	nPrgmIDX = GET_LAST (nPrgmBtns);
//	SWITCH (nPrgmIDX)
//	{
//	    CASE 2 :  fnRaiseVolume (TAG_LEV_PRGM, ID_PRGM_LEV, VOL_SINGLE);
//	    CASE 3 : fnLowerVolume (TAG_LEV_PRGM, ID_PRGM_LEV, VOL_SINGLE);
//	}
//    }
}
BUTTON_EVENT [dvTP_Biamp, BTN_MUTE_CEILING]
{
    PUSH :
    {
	IF (nCeiling_Mute == FALSE) {
	    fnMuteLogic(TAG_CEILING, ID_CEILING, YES_ON)
	} ELSE {
	    fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF)
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTesira]
{
    ONLINE :
    {
	//DspConference.bOnline = TRUE;
    }
    OFFLINE :
    {
	MyBiampStruct.bOnline = FALSE;
    }
   ONERROR :
    {
	//AMX_LOG (AMX_ERROR, "'dvController : onerror : ',GetSVSIIpError(DATA.NUMBER)");
	MyBiampStruct.bOnline = FALSE;
	    MyBiampStruct.bTelnetConnected = FALSE;
	
	SWITCH (DATA.NUMBER)
	{
	    CASE 14 :
	    {
		fnCloseDspConnection();
	    }
	}
    }
    STRING :
    {
	IF(MyBiampStruct.bTelnetConnected == TRUE) {
	    fnParseTesira();
	    
	} ELSE {
	   fnTelnetNegotiation();
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 300 '30 Seconds' {
	IF ((MyBiampStruct.bOnline == FALSE) && (MyBiampStruct.bTelnetConnected == FALSE)) {
	    fnStartDspConnection();
	}
	ELSE IF ((MyBiampStruct.bOnline == TRUE) && (MyBiampStruct.bTelnetConnected == FALSE)) {
	    fnCloseDspConnection()
	} ELSE {
	    SEND_STRING dvTesira, "'DEVICE get hostname',MSG_ETX"
	}
    }
    WAIT 3000 '5 minutes' {
	fnRunSubscriptions();
    }
}

