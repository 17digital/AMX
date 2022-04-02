PROGRAM_NAME='Cisco_SX80_CE9_4'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 03/17/2020  AT: 13:44:40        *)
(***********************************************************)

//Notes...

(*
    Includes Blue Jeans Dial + Zoom
*)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Codec
dvTP_Codec =					10001:2:0
#END_IF


#IF_NOT_DEFINED dvCodec
dvCodec =					5001:1:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED CR 
CR 						= 13 //~$0D
#END_IF

#IF_NOT_DEFINED LF 
LF						= 10 //~$0A
#END_IF

#IF_NOT_DEFINED POWER 
POWER 					= 255
#END_IF

MAX_TEXT_LENGTH 		= 100

//Text Fields
TXT_CALLID				= 2001
TXT_MYSIP				= 2002
TXT_STATE				= 2003
TXT_CALLTYPE				= 2004
TXT_DIAL					= 2019
TXT_RETURN_ITEMS		= 2020
TXT_CALLID				= 2001
TXT_MYSIP				= 2002
TXT_STATE				= 2003
TXT_CALLTYPE				= 2004
TXT_DIAL					= 2019
TXT_RETURN_ITEMS		= 2020
TXT_CAMERA_SAVED		= 22

//Input Sources..
SOURCE_CAMERA_FRONT			= 1
SOURCE_CAMERA_REAR				= 2
SOURCE_CONTENT_SHARE			= 3

SET_ON					= 'On'
SET_OFF					= 'Off'

MIC_MUTE_ON				= 'Mute'
MIC_MUTE_OFF				= 'UnMute'

DO_NOT_DISTURB			= 'Activate'
DO_DISTURB				= 'Deactivate'


//Btns...
BTN_NAV_PAGE_1			= 201
BTN_NAV_PAGE_2			= 202
BTN_NAV_PAGE_3			= 203
BTN_NAV_PAGE_4			= 204
BTN_NAV_PAGE_5			= 205
BTN_NAV_PAGE_6			= 206
BTN_NAV_PAGE_7			= 207

BTN_NAV_DIAL			= 210
BTN_DISTURB_ALLOW		= 106
BTN_DISTURB_NO			= 107

BTN_START_SHARING		= 108
BTN_STOP_SHARING		= 109
BTN_TOGGLE_SELFVIEW		= 110
BTN_PIP_CYCLE			= 111
BTN_LAYOUT_VIEW			= 112
BTN_MIC_MUTE_VTC		= 113
BTN_HOME_SELECT		= 117

BTN_CAM_FRONT			= 51
BTN_CAM_REAR			= 52

BTN_TILT_UP				= 61
BTN_TILT_DOWN			= 62
BTN_PAN_LEFT			= 63
BTN_PAN_RIGHT			= 64
BTN_ZOOM_IN 			= 65
BTN_ZOOM_OUT			= 66

BTN_RECALL_PRESET_1		= 71
BTN_RECALL_PRESET_2		= 72
BTN_RECALL_PRESET_3		= 73
BTN_RECALL_PRESET_4		= 74
BTN_RECALL_PRESET_5		= 75
BTN_RECALL_PRESET_6		= 76
BTN_RECALL_PRESET_7		= 77

BTN_CALL_ANSWER		= 100
BTN_CALL_HANGUP		= 101
BTN_CALL_IGNORE			= 102
BTN_CALL_REJECT			= 103
BTN_SYSTEM_SLEEP		= 104
BTN_SYSTEM_WAKE		= 105

BTN_SHOW_KEYB			= 1500

BTN_BJN_SPEED 			= 3001
BTN_DIAL_ZOOM			= 3004

BTN_PRESENTATION_ON	= 108
BTN_PRESENTATION_OFF	= 109

BTN_PAGE_PREV			= 2006
BTN_PAGE_NEXT			= 2007

BTN_SEARCH_CORPORATE	= 2009
BTN_SEARCH_LOCAL		= 2010

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE CHAR cSX80Buffer[500];
VOLATILE INTEGER nSX80Online

VOLATILE INTEGER nJustBooted
VOLATILE INTEGER nCameraSelect //Front or Rear?
VOLATILE INTEGER nCameraPreset 
VOLATILE INTEGER sPowerStatus
NON_VOLATILE INTEGER nBlueJeansStarted

VOLATILE CHAR dialNumber[MAX_TEXT_LENGTH]  // stores the number being dialed
VOLATILE INTEGER nDisturb
VOLATILE INTEGER nSelfView
VOLATILE INTEGER nPresentation
VOLATILE INTEGER nPIPCounter //PIP Cycle
VOLATILE INTEGER nVolumeOutput = 80 //Volume Max 
VOLATILE INTEGER nVTC_Mic_Mute
VOLATILE INTEGER nCallInProgress //In Call? or Not?

//Phonebook Stuff...
VOLATILE INTEGER cTotalRows
VOLATILE INTEGER nSearchOffset[] = { 0,14,28,42,56} //Offset Search Results
VOLATILE CHAR cSlot_Primary[14][35] = {'','','','','','','','','','','','','',''} //Hold Main Numbers...
VOLATILE CHAR cSlot_FolderNames[6][35] = {'','','','','',''} //Holds the Folder Name for Each Phonebook Result
VOLATILE CHAR cSlot_FolderIDs[7][4] = {'','','','','',''} //Holds the Folder ID for Each Phonebook Result
VOLATILE CHAR cNameReturn[30] ='' //Name Results within Directory...
VOLATILE CHAR cPrimaryReturn[35] = '' //Number Results within Directory...
VOLATILE CHAR cFolderName[35] = '' //Holds the Main Directory Names
VOLATILE CHAR cFolderID[8] = '' //Hold the ID for Directory Name
VOLATILE INTEGER nDirectorySwitch
VOLATILE INTEGER nListCount = 14 //How many list items are we displaying from Phonebook?? 10 is Temp
VOLATILE INTEGER nPageTrack =1
VOLATILE INTEGER nCorporateSearch

VOLATILE DEV vdvTP_Codec[] = 
{
    dvTP_Codec
}
VOLATILE CHAR cPIP_Names[][16] =
{
    'UpperLeft',
    'UpperCenter',
    'UpperRight',
    'CenterRight',
    'LowerRight',
    'LowerLeft'
}
VOLATILE INTEGER nCameraControlsBtns[] =
{
    BTN_TILT_UP,					
    BTN_TILT_DOWN,				
    BTN_PAN_LEFT,					
    BTN_PAN_RIGHT,				
    BTN_ZOOM_IN, 						
    BTN_ZOOM_OUT
}
VOLATILE INTEGER nPresetSelectBtns[] =
{
    BTN_RECALL_PRESET_1,
    BTN_RECALL_PRESET_2,
    BTN_RECALL_PRESET_3,
    BTN_RECALL_PRESET_4,
    BTN_RECALL_PRESET_5,
    BTN_RECALL_PRESET_6,
    BTN_RECALL_PRESET_7
}
VOLATILE INTEGER nSelectCameraBtns[] =
{
    BTN_CAM_FRONT,
    BTN_CAM_REAR
}
VOLATILE INTEGER nCameraIds[] =
{
    SOURCE_CAMERA_FRONT,
    SOURCE_CAMERA_REAR
}
VOLATILE INTEGER nPhonenavBtns[] =
{
    BTN_NAV_PAGE_1,
    BTN_NAV_PAGE_2,
    BTN_NAV_PAGE_3,
    BTN_NAV_PAGE_4,
    BTN_NAV_PAGE_5,
    BTN_NAV_PAGE_6,
    BTN_NAV_PAGE_7
}
VOLATILE INTEGER nPhoneSelect[] =
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
    314
}


(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Codec,nPhoneSelect[1]]..[dvTP_Codec,nPhoneSelect[14]])

([dvTP_Codec, BTN_CAM_FRONT],[dvTP_Codec, BTN_CAM_REAR])
([dvTP_Codec, BTN_NAV_PAGE_1]..[dvTP_Codec, BTN_NAV_PAGE_7])
([dvTP_Codec, BTN_DISTURB_ALLOW],[dvTP_Codec, BTN_DISTURB_NO])
([dvTP_Codec, BTN_START_SHARING],[dvTP_Codec, BTN_STOP_SHARING])
([dvTP_Codec, BTN_PRESENTATION_ON],[dvTP_Codec, BTN_PRESENTATION_OFF])
([dvTP_Codec, BTN_RECALL_PRESET_1]..[dvTP_Codec, BTN_RECALL_PRESET_7])
([dvTP_Codec, BTN_SEARCH_CORPORATE],[dvTP_Codec, BTN_SEARCH_LOCAL])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION addToDialNumber(CHAR cNumber[])
{
    IF (LENGTH_STRING(dialNumber) < MAX_TEXT_LENGTH) 
    {
        dialNumber = "dialNumber,cNumber"
       SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
    }
}
DEFINE_FUNCTION fnSelfViewMode(CHAR cView[3]) 
{
    SEND_STRING dvCodec, "'xCommand Video Selfview Set Mode: ',cView,CR"
    WAIT 10
    {
	SEND_STRING dvCodec, "'xStatus Video Selfview',CR"
    }
}
DEFINE_FUNCTION fnPresentation(CHAR cPresentation[9])
{
    SWITCH (cPresentation)
    {
	CASE 'START' :
	{
	    SEND_STRING dvCodec, "'xCommand Presentation Start SendingMode:LocalRemote ConnectorId:',ITOA(SOURCE_CONTENT_SHARE),CR"
		ON [vdvTP_Codec, BTN_START_SHARING]
	}
	CASE 'STOP' :
	{
	    SEND_STRING dvCodec, "'xCommand Presentation Stop',CR"
		ON [vdvTP_Codec, BTN_STOP_SHARING]
	}
    }
}
DEFINE_FUNCTION fnDisturbOrNot(CHAR cState[12])
{
    SEND_STRING dvCodec, "'xCommand Conference DoNotDisturb ',cState,CR"

    SWITCH (cState)
    {
	CASE DO_NOT_DISTURB :
	{
	    OFF [nDisturb]
		    ON [vdvTP_Codec, BTN_DISTURB_ALLOW]
	}
	CASE DO_DISTURB :
	{
	    ON [nDisturb]
		    ON [vdvTP_Codec, BTN_DISTURB_NO]
	}
    }    
}
DEFINE_FUNCTION fnFullScreenMode(CHAR cScreen[3])
{
    SWITCH (cScreen)
    {
	CASE 'ON' :
	{
	    //SelfView Must be on to see this work...
	    SEND_STRING dvCodec, "'xCommand Video Selfview Set Mode: On FullscreenMode: On',CR"
	}
	CASE 'OFF' :
	{
	    SEND_STRING dvCodec, "'xCommand Video Selfview Set FullscreenMode: Off',CR"
	}
    }
	    WAIT 10
	    {
		SEND_STRING dvCodec, "'xStatus Video Selfview',CR"
	    }
}
DEFINE_FUNCTION fnPIPCycle(nPIPCounter)
{
    nPIPCounter++

    SWITCH (nPIPCounter)
    {
	CASE 1 :
	CASE 2 :
	CASE 3 :
	CASE 4 :
	CASE 5 :
	CASE 6 :
	{
	    SEND_STRING dvCodec, "'xCommand Video Selfview Set PIPPosition: ',cPIP_Names[nPIPCounter],CR"
	}
	CASE 7 :
	{
	    IF (nPIPCounter > 6 )
	    {
		nPIPCounter = 0;
	    }
	}
    }
}
DEFINE_FUNCTION fnDirectoryNav()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop=1; cLoop<=LENGTH_ARRAY(nPhonenavBtns); cLoop++)
    {
	SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhonenavBtns[cLoop]),',0,',cSlot_FolderNames[cLoop]"
    }
}
DEFINE_FUNCTION fnMicrophoneMute(CHAR cMuteState[6])
{
    SEND_STRING dvCodec, "'xCommand Audio Microphones ',cMuteState,CR"
    WAIT 10
    {
	SEND_STRING dvCodec, "'xStatus Audio Microphones Mute',CR"
    }
}
DEFINE_FUNCTION fnSelectCamera(INTEGER cIn)
{
    SEND_STRING dvCodec, "'xCommand Video Input SetMainVideoSource ConnectorId: ',ITOA(cIn),CR"
    WAIT 10
    {
	SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
    }
}
DEFINE_FUNCTION fnSetVolumeOut()
{
    SEND_STRING dvCodec, "'xCommand Audio Volume Set Level: ',ITOA(nVolumeOutput),CR"
}
DEFINE_FUNCTION fnPollCodec()
{
    WAIT 10 SEND_STRING dvCodec, "'xStatus Conference DoNotDisturb',CR"
    WAIT 25 SEND_STRING dvCodec, "'xStatus Conference Presentation Mode',CR"
    WAIT 40 SEND_STRING dvCodec, "'xStatus Audio Microphones Mute',CR"
    WAIT 55 SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR" //Which Camera Connected?
    
    WAIT 70 SEND_STRING dvCodec, "'xStatus Standby',CR" //Sleep or Naw...
    WAIT 90 SEND_STRING dvCodec, "'xStatus SystemUnit State System',CR" //InCall? 
    
    WAIT 100 SEND_STRING dvCodec, "'xCommand Standby ResetHalfwakeTimer Delay: 480',CR" 
    WAIT 110 SEND_STRING dvCodec, "'xStatus SIP Registration URI',CR" //Get My URI
    WAIT 140 fnSetVolumeOut()
    WAIT 160 SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0',CR" //Get Phonebook Folders...
    
    WAIT 250 fnDirectoryNav()
}
DEFINE_FUNCTION fnParseSX80()
{
   STACK_VAR CHAR cResponse[500]; 
    
    LOCAL_VAR CHAR sURI[30]
    LOCAL_VAR CHAR sCallerId[40] //CallBack Number (Includes SIP)
    STACK_VAR INTEGER cCount //Used for Phonebook
    LOCAL_VAR CHAR cRemoteNumber[40] //Generic Details
    LOCAL_VAR CHAR cRemoteDisplay[40] //Display Name
    LOCAL_VAR CHAR sCallType[15] //Video type??
    
    LOCAL_VAR CHAR nDbugger[15]
    
    LOCAL_VAR CHAR sCallState[25]
    LOCAL_VAR INTEGER cActiveCamera;
    LOCAL_VAR CHAR cStandby[2];
    
    WHILE( FIND_STRING(cSX80Buffer,"CR,LF",1))
    {
	cResponse = REMOVE_STRING(cSX80Buffer,"CR,LF",1)
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cResponse,'*r PhonebookSearchResult ResultInfo TotalRows:',1)):
	    {
		REMOVE_STRING(cResponse,'*r PhonebookSearchResult ResultInfo TotalRows:',1)
		    cTotalRows = ATOI(cResponse) 
			SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,',cResponse,' Entrie(s) Found'" //Send total number of entries found+
			
			WAIT 10 fnDirectoryNav()
	    }
	    ACTIVE(FIND_STRING(cResponse,'*r PhonebookSearchResult Folder',1)):
	    {
		REMOVE_STRING(cResponse,'*r PhonebookSearchResult Folder',1)

		FOR (cCount=1; cCount<=(cTotalRows); cCount++)
		{
		    IF (FIND_STRING(cResponse,"ITOA(cCount),' FolderId: "'",1))
		    {
			REMOVE_STRING(cResponse,"ITOA(cCount),' FolderId: "'",1)
			{
			    cFolderID = cResponse
				    cFolderID = LEFT_STRING(cFolderID,LENGTH_STRING(cFolderID)-3) //Should have c_1
					cSlot_FolderIDs[cCount] = cFolderID //Populate Array
			}
		    }
		    IF(FIND_STRING(cResponse,"ITOA(cCount),' Name: "'",1)) //Blue Jeans...
		    {
			REMOVE_STRING(cResponse,"ITOA(cCount),' Name: "'",1)
			{
			    cFolderName = cResponse
				cFolderName = LEFT_STRING(cFolderName,LENGTH_STRING(cFolderName)-3)
			    cSlot_FolderNames[cCount] = cFolderName; 
			}
		    }
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*r PhonebookSearchResult Contact',1)):
	    {
		REMOVE_STRING(cResponse,'*r PhonebookSearchResult Contact',1)
	    
		FOR(cCount=1; cCount <=nListCount; cCount++) 
		{
		    IF(FIND_STRING(cResponse,"' ',ITOA(cCount),' Name: "'",1))
		    //IF(FIND_STRING(cResponse,' 1 Name: "',1))
		    {
			REMOVE_STRING(cResponse,"' ',ITOA(cCount),' Name: "'",1)
			cNameReturn = cResponse;
			cNameReturn = LEFT_STRING(cNameReturn,LENGTH_STRING(cNameReturn)-3) //Take off last quote plus CR/LF
			
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[cCount]),',0,',cNameReturn"
		    }		    
		    IF(FIND_STRING(cResponse,"' ',ITOA(cCount),' ContactMethod 1 Number: "'",1)) //Blue Jeans + Local Book Found Here...
		    {
			REMOVE_STRING(cResponse,"' ',ITOA(cCount),' ContactMethod 1 Number: "'",1)
			
			    cPrimaryReturn = cResponse //Should Have Number...
			    cPrimaryReturn = LEFT_STRING(cPrimaryReturn,LENGTH_STRING(cPrimaryReturn)-3)
			    
			    cSlot_Primary[cCount] = cPrimaryReturn; //Populate Array 
		    }
		}
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Conference Presentation Mode: ',1)):
	    {
		REMOVE_STRING(cResponse,'*s Conference Presentation Mode: ',1)
		
		IF (FIND_STRING(cResponse,'Off',1))
		{
		    OFF [nPresentation]
			ON [vdvTP_Codec, BTN_STOP_SHARING]
		}
		IF (FIND_STRING(cResponse,'Sending',1))
		{
		    ON [ nPresentation]
			ON [vdvTP_Codec, BTN_START_SHARING]
		}
		IF (FIND_STRING(cResponse,'On',1))
		{
		    ON [ nPresentation]
			ON [vdvTP_Codec, BTN_START_SHARING]
		}
		IF (FIND_STRING(cResponse,'Receiving',1)) //Incoming Presentation
		{
		    		    OFF [nPresentation]
			ON [vdvTP_Codec, BTN_STOP_SHARING]
		}
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Video Input MainVideoSource: ',1)):
	    {
		REMOVE_STRING (cResponse, '*s Video Input MainVideoSource: ',1)
		    nCameraSelect = ATOI (LEFT_STRING (cResponse, 1))
		    
		    SWITCH (nCameraSelect)
		    {
			CASE SOURCE_CAMERA_FRONT :
			{
			    ON [vdvTP_Codec, BTN_CAM_FRONT]
				fnRouteCameraAVB (VIDEO_CAM_FRONT) //From Main Prgm
			}
			CASE SOURCE_CAMERA_REAR :
			{
					    ON [vdvTP_Codec, BTN_CAM_REAR]
			    fnRouteCameraAVB (VIDEO_CAM_REAR) //From Main Prgm
			}
		    }
	    }
	    ACTIVE(FIND_STRING(cResponse,'xCommand Video Input SetMainVideoSource ConnectorId: ',1)):
	    {
		REMOVE_STRING (cResponse, 'xCommand Video Input SetMainVideoSource ConnectorId: ',1)
		    nCameraSelect = ATOI (LEFT_STRING (cResponse, 1))
		    
		    SWITCH (nCameraSelect)
		    {
			CASE SOURCE_CAMERA_FRONT :
			{
			    ON [vdvTP_Codec, BTN_CAM_FRONT]
				fnRouteCameraAVB (VIDEO_CAM_FRONT) //From Main Prgm
			}
			CASE SOURCE_CAMERA_REAR :
			{
					    ON [vdvTP_Codec, BTN_CAM_REAR]
			    fnRouteCameraAVB (VIDEO_CAM_REAR) //From Main Prgm
			}
		    }
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Conference DoNotDisturb: ',1)):
	    {
		REMOVE_STRING (cResponse, '*s Conference DoNotDisturb: ',1)
		
		IF (FIND_STRING (cResponse, 'Inactive',1))
		{
		    OFF [nDisturb]
			ON [vdvTP_Codec, BTN_DISTURB_ALLOW]
		}
		IF (FIND_STRING (cResponse, 'Active',1))
		{
		    ON [nDisturb]
			ON [vdvTP_Codec, BTN_DISTURB_NO]
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Video Selfview Mode: ',1)):
	    {
		REMOVE_STRING (cResponse, '*s Video Selfview Mode: ',1)
		
		IF (FIND_STRING(cResponse,'Off',1))
		{
		    OFF [nSelfView]
			OFF [vdvTP_Codec, BTN_TOGGLE_SELFVIEW]
		}
		IF (FIND_STRING (cResponse,'On',1))
		{
		    ON [nSelfView]
			ON [vdvTP_Codec, BTN_TOGGLE_SELFVIEW]
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e IncomingCallIndication RemoteURI: "sip:',1)):
	    {
		REMOVE_STRING(cResponse,'*e IncomingCallIndication RemoteURI: "sip:',1)
		sCallerId = cResponse;
		SET_LENGTH_STRING(sCallerId,LENGTH_STRING(sCallerId) -3);
		
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',sCallerId" 
		    SEND_COMMAND vdvTP_Codec, "'PPON-_incomingcall'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SIP Registration 1 URI: "',1)):
	    {
		REMOVE_STRING(cResponse,'*s SIP Registration 1 URI: "',1)
		sURI = cResponse;
		
		SET_LENGTH_STRING(sURI,LENGTH_STRING(sURI) -3); //Set to -18 to leave only host name
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_MYSIP),',0,',sURI"
	    }
	    ACTIVE(FIND_STRING(cResponse,'*xCommand Call Disconnect CallId:0',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		OFF [nCallInProgress]
		    OFF [vdvTP_Codec, BTN_BJN_SPEED ]
		    OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'CallbackNumber: "',1)):
	    {
		REMOVE_STRING (cResponse,'CallbackNumber: "',1)
		sCallerId = cResponse;
		    SET_LENGTH_STRING (sCallerId,LENGTH_STRING(sCallerId) -3)
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',sCallerId"
	    }
	    ACTIVE(FIND_STRING(cResponse,'RemoteNumber: "',1)):
	    {
		REMOVE_STRING (cResponse,'RemoteNumber: "',1)
		cRemoteNumber = cResponse;
		SET_LENGTH_STRING (cRemoteNumber,LENGTH_STRING(cRemoteNumber) -3)
		
		//SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',sCallerId"
	    }
    	    ACTIVE(FIND_STRING(cResponse,'DisplayName: "',1)):
	    {
		REMOVE_STRING (cResponse,'DisplayName: "',1)
		cRemoteDisplay = cResponse;
		    SET_LENGTH_STRING (cRemoteDisplay,LENGTH_STRING(cRemoteDisplay) -1)
		
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLTYPE),',0,',cRemoteDisplay"
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		OFF [nCallInProgress]
		    OFF [vdvTP_Codec, BTN_BJN_SPEED]
			OFF [vdvTP_Codec, BTN_DIAL_ZOOM]
		    OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect CauseType: "NetworkRejected"',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		//Invalid Address...
		OFF [nCallInProgress]
		    OFF [vdvTP_Codec, BTN_BJN_SPEED]
			OFF [vdvTP_Codec, BTN_DIAL_ZOOM]
			    OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e OutgoingCallIndication CallId:',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connecting'"
		ON [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Audio Microphones Mute: ',1)):
	    {
		REMOVE_STRING(cResponse,'*s Audio Microphones Mute: ',1)
		
		IF (FIND_STRING(cResponse,'Off',1))
		{
		     OFF [nVTC_Mic_Mute]
			OFF [vdvTP_Codec, BTN_MIC_MUTE_VTC]
		}
		IF (FIND_STRING(cResponse,'On',1))
		{
		    ON [nVTC_Mic_Mute]
			ON [vdvTP_Codec, BTN_MIC_MUTE_VTC]
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: ',1)):
	    {
		REMOVE_STRING (cResponse,'*s Standby State: ',1)
		
		cStandby = LEFT_STRING (cResponse,2);
		
		SWITCH (cStandby)
		{
		    CASE 'St' : //Standby
		    CASE 'On' : //Off
		    {
			//Sleep
			OFF [sPowerStatus]
			    OFF [nCallInProgress]
				OFF [vdvTP_Codec, POWER]
				    OFF [vdvTP_Codec, BTN_BJN_SPEED ]
					OFF [nBlueJeansStarted]
		    }
		    CASE 'Of' :
		    {
		    		ON [sPowerStatus]
			ON [vdvTP_Codec, POWER]
		    }
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SystemUnit State System: ',1)):
	    {
		REMOVE_STRING (cResponse,'*s SystemUnit State System: ',1)
		
		IF (FIND_STRING (cResponse,'Initialized',1))
		{
		    //State Disconnected
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ready'"
			OFF [nCallInProgress]
		}
		IF (FIND_STRING(cResponse,'InCall',1))
		{
		    //State connected
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected'"
			ON [nCallInProgress]
		}
	    }
	    //Call feedback
	    ACTIVE(FIND_STRING(cResponse,'Status: ',1)):
	    {
		REMOVE_STRING(cResponse,'Status: ',1)
		sCallState = cResponse;
		
		IF (FIND_STRING(sCallState,'Dialing',1))
		{
		    ON [nCallInProgress]
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Dialing..'"
		}
		IF (FIND_STRING(sCallState,'Connecting',1))
		{
		    ON [nCallInProgress]
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connecting'"
		}
		IF (FIND_STRING(sCallState,'Connected',1))
		{
		    ON [nCallInProgress]
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected!'"
		}
		IF (FIND_STRING(sCallState,'Ringing',1))
		{
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ringing!'"
		    SEND_COMMAND vdvTP_Codec, "'^PPN-_incomingcall'" //Show popup...
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnRegisterFeedback()
{
    WAIT 10 SEND_STRING dvCodec, "'xFeedback register /Event/IncomingCallIndication',CR"
    WAIT 20 SEND_STRING dvCodec, "'xFeedback register /Event/OutgoingCallIndication',CR"
    WAIT 30 SEND_STRING dvCodec, "'xFeedback register /Event/Standby',CR"
    WAIT 40 SEND_STRING dvCodec, "'xFeedback register /Status/Audio/Microphones/Mute',CR"
    WAIT 50 SEND_STRING dvCodec, "'xFeedback register /Status/Call',CR"
    WAIT 60 SEND_STRING dvCodec, "'xFeedback register /Status/Standby',CR"
    WAIT 70 SEND_STRING dvCodec, "'xFeedback register /Event/CallDisconnect',CR"
    WAIT 80 SEND_STRING dvCodec, "'xFeedback register /Configuration/Video/MainVideoSource',CR"
    WAIT 90 SEND_STRING dvCodec, "'xFeedback register /Status/Camera',CR"
    WAIT 100 SEND_STRING dvCodec, "'xFeedback register /Status/Conference',CR"
    WAIT 120 SEND_STRING dvCodec, "'xFeedback register /Status/Standby/Active',CR"

}
DEFINE_FUNCTION fnUpdateList()
{
    STACK_VAR INTEGER nLoop;
    
    FOR (nLoop =1; nLoop <=nListCount; nLoop++)
    {
	SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[nLoop]),',0,'" //Set them all blank...
    }
}
DEFINE_FUNCTION fnDirectoryClearMenu()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop=1; cLoop<=LENGTH_ARRAY(nPhonenavBtns); cLoop++)
    {
	cSlot_FolderNames[cLoop] = ''  //Clear Names
	SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhonenavBtns[cLoop]),',0, '"
	
    }
}

DEFINE_START

ON [nJustBooted]
CREATE_BUFFER dvCodec, cSX80Buffer;

WAIT 600
{
    OFF [nJustBooted]
}


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Codec, 1]
BUTTON_EVENT [vdvTP_Codec, 2]
BUTTON_EVENT [vdvTP_Codec, 3]
BUTTON_EVENT [vdvTP_Codec, 4]
BUTTON_EVENT [vdvTP_Codec, 5]
BUTTON_EVENT [vdvTP_Codec, 6]
BUTTON_EVENT [vdvTP_Codec, 7]
BUTTON_EVENT [vdvTP_Codec, 8]
BUTTON_EVENT [vdvTP_Codec, 9]
BUTTON_EVENT [vdvTP_Codec, 10]
BUTTON_EVENT [vdvTP_Codec, 11] //.
BUTTON_EVENT [vdvTP_Codec, 12] //Bkspce
BUTTON_EVENT [vdvTP_Codec, 13] //Clear
BUTTON_EVENT [vdvTP_Codec, 14] //Dial
BUTTON_EVENT [vdvTP_Codec, 15] //DTMF- **
BUTTON_EVENT [vdvTP_Codec, 16] //DTMF- ##
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE 1 :
	    CASE 2 :
	    CASE 3 :
	    CASE 4 :
	    CASE 5 :
	    CASE 6 :
	    CASE 7 :
	    CASE 8 :
	    CASE 9 :
	    CASE 10:	
	    {
		IF (nCallInProgress == TRUE)
		{
		     SEND_STRING dvCodec, "'xCommand Call DTMFSend CallId:0 DTMFString:',ITOA(BUTTON.INPUT.CHANNEL -1),CR"
			 addToDialNumber(ITOA(BUTTON.INPUT.CHANNEL -1))
		}
		ELSE
		{
		    addToDialNumber(ITOA(BUTTON.INPUT.CHANNEL -1))
		}
		
	    }
	    CASE 11 : //This should be button 12 on TP
	    {
		addToDialNumber('.')
	    }
	    CASE 12 : //Tbackspace
	    {
		IF (LENGTH_STRING(dialNumber))
		{
		    SET_LENGTH_STRING(dialNumber,LENGTH_STRING(dialNumber) -1);
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
		}
	    }
	    CASE 13 :
	    {
                dialNumber = ''
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
	    }
	    CASE 14 :
	    {
		SEND_STRING dvCodec, "'xCommand Dial Number:',dialNumber,CR"
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
	    }
	    CASE 15: //DTMF *
	    {
		SEND_STRING dvCodec, "'xCommand Call DTMFSend CallId:0 DTMFString:*',CR"
		    addToDialNumber('*')
	    }
	    CASE 16: //DTMF #
	    {
		SEND_STRING dvCodec, "'xCommand Call DTMFSend CallId:0 DTMFString:#',CR"
		    addToDialNumber('#')
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nSelectCameraBtns] //Camera Selection
{
    PUSH :
    {
	nCameraSelect = GET_LAST (nSelectCameraBtns)
	    fnSelectCamera(nCameraIds[nCameraSelect])
	        TOTAL_OFF [vdvTP_Codec, nPresetSelectBtns]
    }
}
BUTTON_EVENT [vdvTP_Codec, nCameraControlsBtns] //Camera Controls..
{
    PUSH :
    {
	STACK_VAR INTEGER nCamIdx;
	TOTAL_OFF [vdvTP_Codec, nPresetSelectBtns]
	
	nCamIdx = GET_LAST(nCameraControlsBtns)
	
	SWITCH (nCamIdx)
	{
	    CASE 1: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Tilt:Up TiltSpeed:1',CR" //Speeds 1-12
	    CASE 2: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Tilt:Down TiltSpeed:1',CR"
	    CASE 3: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Pan:Left PanSpeed:1',CR"
	    CASE 4: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Pan:Right PanSpeed:1',CR"
	    CASE 5: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Zoom:In ZoomSpeed:4',CR"
	    CASE 6: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Zoom:Out ZoomSpeed:4',CR"
	}
    }
    RELEASE :
    {
	STACK_VAR INTEGER nCamIdx;
	
	nCamIdx = GET_LAST(nCameraControlsBtns)
	SWITCH (nCamIdx)
	{
	    CASE 1:
	    CASE 2: //Stop Panning
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Pan:Stop',CR"
	    }
	    CASE 3:
	    CASE 4: //Stop Tilt
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Tilt:Stop',CR"
	    }
	    CASE 5:
	    CASE 6: //Stop Zoom
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:',ITOA(nCameraSelect),' Zoom:Stop',CR"
	    }
	}
    }
} 
BUTTON_EVENT [vdvTP_Codec, nPresetSelectBtns] //Store + Recall Presets...
{
    HOLD [30] : //Store After 3 Second Hold
    {
	STACK_VAR INTEGER nPresetIdx;
	    nPresetIdx = GET_LAST (nPresetSelectBtns)
		SEND_COMMAND dvTP_Codec, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
		
	    SELECT
	    {
		ACTIVE (nCameraSelect == SOURCE_CAMERA_FRONT) :
		{
		    SEND_STRING dvCodec, "'xCommand Camera Preset Store PresetId: ',ITOA(nPresetIdx), ' CameraId: ',ITOA(nCameraSelect), ' ListPosition:',ITOA(nPresetIdx),CR" //Camera 1 Calls Slots 1-7
		}
		ACTIVE (nCameraSelect == SOURCE_CAMERA_REAR) :
		{
		    SEND_STRING dvCodec, "'xCommand Camera Preset Store PresetId: ',ITOA(nPresetIdx + 7), ' CameraId: ',ITOA(nCameraSelect), ' ListPosition:',ITOA(nPresetIdx + 7),CR" //Camera 2 Call Slots 8-10
		}
	    }
	WAIT 50
	{
	    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Press to Recall',$0D,'Hold to Save'"
	}
    }
    RELEASE :
    {
	STACK_VAR INTEGER nPresetIdx;
	    nPresetIdx = GET_LAST (nPresetSelectBtns)
		ON [vdvTP_Codec, nPresetSelectBtns[nPresetIdx]]
	
	SELECT
	{
	    ACTIVE (nCameraSelect == SOURCE_CAMERA_FRONT) :
	    {
		SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:',ITOA(nPresetIdx),CR" //Camera 1 Calls Slots 1-5
	    }
	    ACTIVE (nCameraSelect == SOURCE_CAMERA_REAR) :
	    {
		SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:',ITOA(nPresetIdx + 7),CR" //Camera 2 Call Slots 6-10
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_CALL_ANSWER]
BUTTON_EVENT [vdvTP_Codec, BTN_CALL_HANGUP]
BUTTON_EVENT [vdvTP_Codec, BTN_CALL_IGNORE]
BUTTON_EVENT [vdvTP_Codec, BTN_CALL_REJECT] //Receiving Calls...
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_CALL_ANSWER :
	    {
		SEND_STRING dvCodec, "'xCommand Call Accept CallId:0',CR"
		ON [nCallInProgress]
		
		WAIT 20
		{
		    SEND_STRING dvCodec, "'xStatus SystemUnit State System',CR" //InCall?
		}
	    }
	    CASE BTN_CALL_HANGUP :
	    {
		SEND_STRING dvCodec, "'xCommand Call Disconnect CallId:0',CR"
		    OFF [nCallInProgress]
	    }
	    CASE BTN_CALL_IGNORE :
	    {
		SEND_STRING dvCodec, "'xCommand Call Ignore CallId:0',CR"
	    }
	    CASE BTN_CALL_REJECT :
	    {
		SEND_STRING dvCodec, "'xCommand Call Reject CallId:0',CR"
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_DISTURB_NO]
BUTTON_EVENT [vdvTP_Codec, BTN_DISTURB_ALLOW]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_DISTURB_NO : fnDisturbOrNot(DO_NOT_DISTURB)
	    CASE BTN_DISTURB_ALLOW : fnDisturbOrNot(DO_DISTURB)
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_TOGGLE_SELFVIEW]
{
    PUSH :
    {
	IF (!nSelfView)
	{
	    fnSelfViewMode(SET_ON)
	}
	ELSE
	{
	    fnSelfViewMode(SET_OFF)
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_PRESENTATION_ON]
BUTTON_EVENT [vdvTP_Codec, BTN_PRESENTATION_OFF]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_PRESENTATION_ON : fnPresentation('START')
	    CASE BTN_PRESENTATION_OFF : fnPresentation('STOP')
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_PIP_CYCLE]
{
    PUSH :
    {
	fnPIPCycle(nPIPCounter)
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_MIC_MUTE_VTC]
{
    PUSH :
    {
	IF (!nVTC_Mic_Mute)
	{
	    fnMicrophoneMute(MIC_MUTE_ON)
	}
	ELSE
	{
	    fnMicrophoneMute(MIC_MUTE_OFF)
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_HOME_SELECT]
{
    PUSH :
    {
	SEND_STRING dvCodec, "'xCommand Key Click Key:Home',CR"
    }
}
BUTTON_EVENT [vdvTP_Codec, nPhonenavBtns]
{
    PUSH :
    {
	nDirectorySwitch = GET_LAST (nPhonenavBtns)
	
	TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
	    SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'" 
		ON [vdvTP_Codec, nPhonenavBtns[nDirectorySwitch]] //Send Feedback..
		fnUpdateList()
	    nPageTrack = 1;
	    ON [vdvTP_Codec, BTN_PAGE_NEXT]
	    OFF [vdvTP_Codec, BTN_PAGE_PREV]
	    ON [nCorporateSearch]
	
	//Display first Entries.
	SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0 FolderId:',cSlot_FolderIDs[nDirectorySwitch],' Limit:',ITOA(nListCount),CR"
	
	SWITCH (nDirectorySwitch)
	{
	    CASE 7:
	    {
		OFF [nCorporateSearch]
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Local Offset: 0',CR" //Search Local
	    }
	    CASE 8:
	    {
		OFF [nCorporateSearch]
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Local Offset: 14',CR" //Search Local
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nPhoneSelect]
{
    PUSH :
    {
	STACK_VAR INTEGER nDirectorySet;
	nDirectorySet = GET_LAST (nPhoneSelect)
	
		ON [vdvTP_Codec, nPhoneSelect[nDirectorySet]]
	
	    dialNumber = cSlot_Primary[nDirectorySet]
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_NAV_DIAL] //Dial from Contact List...
{
    PUSH :
    {
	TOTAL_OFF [vdvTP_Codec, nPhoneSelect]

	    SEND_STRING dvCodec, "'xCommand Dial Number:',dialNumber,CR"
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_PAGE_NEXT]
{
    PUSH :
    {	
	nPageTrack++
	
	SWITCH (nPageTrack)
	{
	    CASE 1: 
	    CASE 2:
	    CASE 3:
	    CASE 4:
	    {
		ON [dvTP_Codec, BTN_PAGE_PREV]
		    ON [dvTP_Codec, BTN_PAGE_NEXT]
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"
		fnUpdateList()
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:',ITOA(nSearchOffset[nPageTrack]),' FolderId:',cSlot_FolderIDs[GET_LAST(nPhonenavBtns)],' Limit:',ITOA(nListCount),CR"		
	    }
	    CASE 5 :
	    {
		IF (nPageTrack > 4 )
		{
		    OFF [dvTP_Codec, BTN_PAGE_NEXT]
		    nPageTrack = 4 //Stop Here
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_PAGE_PREV]
{
    PUSH :
    {
	nPageTrack--
	
	SWITCH (nPageTrack)
	{
	    CASE 0 :
	    {
		
		IF (nPageTrack < 1 )
		{
		    nPageTrack = 1 //Stop Here
		    OFF [dvTP_Codec, BTN_PAGE_PREV]
		}
	    }
	    CASE 1 : 
	    CASE 2 :
	    CASE 3 :
	    CASE 4 :
	    {
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		fnUpdateList()
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:',ITOA(nSearchOffset[nPageTrack]),' FolderId:',cSlot_FolderIDs[GET_LAST(nPhonenavBtns)],' Limit:',ITOA(nListCount),CR"
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_SEARCH_CORPORATE]
BUTTON_EVENT [vdvTP_Codec, BTN_SEARCH_LOCAL]
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_SEARCH_CORPORATE :
	    {
		fnDirectoryClearMenu()
		fnUpdateList()
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0',CR" //Get Phonebook Folders...
		    ON [nCorporateSearch]
			ON [dvTP_Codec, BTN_SEARCH_CORPORATE]
			    OFF [vdvTP_Codec, BTN_PAGE_NEXT]
	    }
	    CASE BTN_SEARCH_LOCAL :
	    {
		fnDirectoryClearMenu()
		fnUpdateList()
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Local Offset: 0',CR" //Search Local
		    OFF [nCorporateSearch]
			ON [dvTP_Codec, BTN_SEARCH_LOCAL]
			
		    WAIT 20
		    {
			IF (cTotalRows > nListCount)
			{
			    ON [vdvTP_Codec, BTN_PAGE_NEXT]
			}
		    }
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_BJN_SPEED]
{
    PUSH :
    {
	IF (nCallInProgress ==TRUE)
	{
	    //SEND_COMMAND vdvTP_Codec, "'^PPN-VTC_BlueJeans'"
	}
	ELSE
	{
	    SEND_STRING dvCodec, "'xCommand Dial Number: meet@bjn.vc',CR"
		ON [vdvTP_Codec, BTN_BJN_SPEED ]
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,meet@bjn.vc'"
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_DIAL_ZOOM]
{
    PUSH :
    {
	IF (nCallInProgress == TRUE)
	{
	    //Nothing...
	}
	ELSE
	{
	    SEND_STRING dvCodec, "'xCommand Dial Number: meet@zoomcrc.com',CR"
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,meet@zoomcrc.com'"
		    ON [vdvTP_Codec, BTN_DIAL_ZOOM]
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, POWER]
{
    PUSH :
    {
	IF (!sPowerStatus)
	{
	    SEND_STRING dvCodec, "'xCommand Standby Deactivate',CR"
		ON [vdvTP_Codec, POWER]
		WAIT 10
		{
		    SEND_STRING dvCodec, "'xCommand Key Click Key:Home',CR"
		}
	}
    }
}
	
DEFINE_EVENT
DATA_EVENT[dvTP_Codec] //UnComment if Using G5 Panel!!
{
    ONLINE :
    {
	fnDirectoryNav()
	    SEND_COMMAND dvTP_Codec, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
	
	IF (!nJustBooted)
	{
	    fnUpdateList() //Reset List to Blank...
	    fnPollCodec()
	}
    }
    STRING:
    {
	LOCAL_VAR CHAR sMsgs[40];
	sMsgs = DATA.TEXT
	
	IF (FIND_STRING(sMsgs,'KEYBCALL-',1)OR FIND_STRING(sMsgs,'AKB-',1)) //G4 or G5 Parsing
	{
	    REMOVE_STRING (sMsgs,'-',1)
	    
	    IF (FIND_STRING(sMsgs,'ABORT',1))
	    {
		dialNumber = ''
	    }
	    ELSE
	    {
		dialNumber = sMsgs;
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
	    }
	}
    }
}
DATA_EVENT [dvCodec]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, 'SET BAUD 115200,N,8,1 485 DISABLED'
	SEND_COMMAND DATA.DEVICE, 'HSOFF'
	SEND_COMMAND DATA.DEVICE, 'RXON'
	SEND_COMMAND DATA.DEVICE, 'XOFF'
	
	ON [nSX80Online]
	WAIT 50
	{
	    fnUpdateList() //Reset List to Blank...
	    fnRegisterFeedback()
	    
	    WAIT 200
	    {
		
		fnPollCodec()
	    }
	}
    }
    OFFLINE :
    {
	OFF [nSX80Online]
    }
    STRING :
    {
	fnParseSX80()
    }
}


DEFINE_EVENT
TIMELINE_EVENT [TL_FEEDBACK]
{   
    WAIT 6500
    {
	SEND_STRING dvCodec, "'xCommand Standby ResetHalfwakeTimer Delay: 480',CR" 
	WAIT 50
	{
	    fnRegisterFeedback()
	}
    }
}
