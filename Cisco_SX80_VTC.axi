PROGRAM_NAME='SX80_Connect'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/22/2016  AT: 07:09:44        *)
(***********************************************************)

//Notes...

(*
	Fix Camera Preset / Store 


    Add BlueJeans ...
    meet@sip.bjn.vc
    111@sip.bjn.vc
*)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Codec
dvTP_Codec =					10001:2:0
#END_IF


#IF_NOT_DEFINED dvCodec
dvCodec =					5001:2:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED VIDEO_CAMERA_FRONT
VIDEO_CAMERA_FRONT			= 2
#END_IF

#IF_NOT_DEFINED VIDEO_CAMERA_REAR
VIDEO_CAMERA_REAR			= 1
#END_IF

#IF_NOT_DEFINED CR 
CR 						= 13 //~$0D
#END_IF

#IF_NOT_DEFINED LF 
LF						= 10 //~$0A
#END_IF

#IF_NOT_DEFINED POWER 
POWER 					= 255
#END_IF

//Text Fields
MAX_TEXT_LENGTH 		= 100
TXT_CALLID				= 2001
TXT_MYSIP				= 2002
TXT_STATE				= 2003
TXT_CALLTYPE				= 2004
TXT_DIAL					= 2019
TXT_RETURN_ITEMS			= 2020
TXT_CAMERA_SAVED		= 22

SOURCE_CAMERA_FRONT				= 2
SOURCE_CAMERA_REAR				= 1
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
BTN_DISTURB_ALLOW			= 106
BTN_DISTURB_NO				= 107

BTN_START_SHARING		= 108
BTN_STOP_SHARING		= 109
BTN_TOGGLE_SELFVIEW		= 110
BTN_PIP_CYCLE			= 111
BTN_LAYOUT_VIEW			= 112
BTN_MIC_MUTE_VTC		= 113
BTN_HOME_SELECT		= 117

BTN_CAM_FRONT			= 52
BTN_CAM_REAR			= 51

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

BTN_STORE_PRESET_1		= 81
BTN_STORE_PRESET_2		= 82
BTN_STORE_PRESET_3		= 83
BTN_STORE_PRESET_4		= 84
BTN_STORE_PRESET_5		= 85

BTN_CALL_ANSWER		= 100
BTN_CALL_HANGUP		= 101
BTN_CALL_IGNORE			= 102
BTN_CALL_REJECT			= 103
BTN_SYSTEM_SLEEP		= 104
BTN_SYSTEM_WAKE		= 105

BTN_SHOW_KEYB			= 1500

BTN_BJN_SPEED 			= 3001
BTN_DIAL_WEBEX			= 3002
BTN_DIAL_WEBEX_FB		= 3003

BTN_PRESENTATION_ON	= 108
BTN_PRESENTATION_OFF	= 109

//VTC Pages...
BTN_PAGE_DIAL				= 2001
BTN_BJN_DIAL					= 2002
BTN_WEBEX_DIAL				= 2003
BTN_PAGE_PHONEBOOK		= 2004
BTN_PAGE_SHARE			= 2005


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

//Place Caller ID
CHAR cNameReturn[30] =''
CHAR cSecondaryReturn[35] ='' //GT Book Return
CHAR cPrimaryReturn[35] = '' //Blue Jeans + Local Return

VOLATILE CHAR cSX80Buffer[500]
VOLATILE INTEGER nSX80Online

VOLATILE INTEGER nJustBooted
NON_VOLATILE INTEGER nCameraSelect //Front or Rear?
VOLATILE INTEGER nCameraPreset 
VOLATILE INTEGER sPowerStatus
NON_VOLATILE INTEGER nBlueJeansStarted

VOLATILE INTEGER nDisturb
VOLATILE INTEGER nSelfView
VOLATILE INTEGER nPresentation
VOLATILE INTEGER nPIPCounter //PIP Cycle
VOLATILE INTEGER nVolumeOutput = 80 //Volume Max 
VOLATILE INTEGER nVTC_Mic_Mute
VOLATILE INTEGER nCallInProgress //In Call? or Not?

VOLATILE INTEGER nListCount = 14 //How many list items are we displaying from Phonebook?? 10 is Temp
VOLATILE CHAR sEntriesFound[3] = '' //How many directories?
VOLATILE CHAR cFolderGT[4] ='' //Holds pulled ID
VOLATILE CHAR cFolderTest[4] =''
VOLATILE CHAR cFolderBlueJeans[4] =''
VOLATILE INTEGER cDialGTBook //Am I using the GT phonebook or no?? (With Latest Update to Codec...May not be necessary

VOLATILE CHAR dialNumber[MAX_TEXT_LENGTH]  // stores the number being dialed

VOLATILE CHAR cSlot_Secondary[14][35] = {'','','','','','','','','','','','','',''} //Hold PhoneBook Numbers...
VOLATILE CHAR cSlot_Primary[14][35] = {'','','','','','','','','','','','','',''} //Hold GT Numbers...

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
VOLATILE INTEGER nVTC_PageBtns[] =
{
    BTN_PAGE_DIAL,
    BTN_BJN_DIAL,
    BTN_WEBEX_DIAL,
    BTN_PAGE_PHONEBOOK,
    BTN_PAGE_SHARE
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
    BTN_RECALL_PRESET_5
}
VOLATILE INTEGER nPresetStoreBtns[] =
{
    BTN_STORE_PRESET_1,
    BTN_STORE_PRESET_2,
    BTN_STORE_PRESET_3,
    BTN_STORE_PRESET_4,
    BTN_STORE_PRESET_5
}
VOLATILE INTEGER nSelectCameraBtns[] =
{
    BTN_CAM_REAR,
    BTN_CAM_FRONT
}
VOLATILE INTEGER nCameraIds[] =
{
    SOURCE_CAMERA_REAR,
    SOURCE_CAMERA_FRONT
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
VOLATILE CHAR nPhoneNavNames[7][10] =
{
    'PAGE 1',
    'PAGE 2',
    'PAGE 3',
    'PAGE 4',
    'Blue Jeans',
    'Local',
    'Local'
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
([dvTP_Codec, BTN_RECALL_PRESET_1]..[dvTP_Codec, BTN_RECALL_PRESET_5])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION addToDialNumber(char cNumber[])
{
    IF ( length_string(dialNumber) < MAX_TEXT_LENGTH)
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
	    WAIT 10
	    {
		SEND_STRING dvCodec, "'xStatus Video Selfview',CR"
	    }
	}
	CASE 'OFF' :
	{
	    SEND_STRING dvCodec, "'xCommand Video Selfview Set FullscreenMode: Off',CR"
	    WAIT 10
	    {
		SEND_STRING dvCodec, "'xStatus Video Selfview',CR"
	    }
	}
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
		nPIPCounter = 0
	    }
	}
    }
}
DEFINE_FUNCTION fnDirectoryNav()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(nPhonenavBtns); cLoop++)
    {
	SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhonenavBtns[cLoop]),',0,',nPhoneNavNames[cLoop]"
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
    WAIT 90 SEND_STRING dvCodec, "'xStatus Call',CR" // 
    
    WAIT 100 SEND_STRING dvCodec, "'xCommand Standby ResetHalfwakeTimer Delay: 480',CR" 
    WAIT 110 SEND_STRING dvCodec, "'xStatus SIP Registration URI',CR" //Get My URI
    WAIT 140 fnSetVolumeOut()
    WAIT 160 SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0',CR" //Get Phonebook Folders...
}
DEFINE_FUNCTION fnParseSX80()
{
    STACK_VAR CHAR cResponse[500] 
    
    LOCAL_VAR CHAR sURI[30]
    LOCAL_VAR CHAR sCallerId[40] //CallBack Number (Includes SIP)
    STACK_VAR INTEGER cCount //Used for Phonebook
    LOCAL_VAR CHAR cRemoteNumber[40] //Generic Details
    LOCAL_VAR CHAR cRemoteDisplay[40] //Display Name
    
    WHILE( FIND_STRING(cSX80Buffer,"CR,LF",1))
    {
	cResponse = REMOVE_STRING(cSX80Buffer,"CR,LF",1)
	
	SELECT
	{
	//Retrieve Folder ID's for Searching!
	    ACTIVE(FIND_STRING(cResponse,'*r PhonebookSearchResult Folder',1)):
	    {
		REMOVE_STRING(cResponse,'*r PhonebookSearchResult Folder',1)
		{
		    IF(FIND_STRING(cResponse,'1 FolderId: "',1)) //GT Endpoints...
		    {
			REMOVE_STRING(cResponse,'1 FolderId: "',1)
			{
			   cFolderGT = cResponse
			    cFolderGT = LEFT_STRING(cFolderGT,LENGTH_STRING(cFolderGT)-1)
			}
		    }
		    IF(FIND_STRING(cResponse,'2 FolderId: "',1)) //Blue Jeans...
		    {
			REMOVE_STRING(cResponse,'2 FolderId: "',1)
			{
			    cFolderBlueJeans = cResponse
			    //cFolderBlueJeans = LEFT_STRING(cFolderBlueJeans,LENGTH_STRING(cFolderBlueJeans)-1)
			}
		    }
		}
	    }
	    //Display Entries Found...
	    ACTIVE(FIND_STRING(cResponse,'*r PhonebookSearchResult ResultInfo TotalRows:',1)):
	    {
		    REMOVE_STRING(cResponse,'*r PhonebookSearchResult ResultInfo TotalRows:',1)
		    SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,',cResponse,' Entrie(s) Found'" //Send total number of entries found
	    }
	    //Official Search...
	    ACTIVE(FIND_STRING(cResponse,'*r PhonebookSearchResult Contact',1)):
	    {
		REMOVE_STRING(cResponse,'*r PhonebookSearchResult Contact',1)
	    
		FOR(cCount=1; cCount <=nListCount; cCount++) 
		{
		    IF(FIND_STRING(cResponse,"' ',ITOA(cCount),' Name: "'",1))
		    //IF(FIND_STRING(cResponse,' 1 Name: "',1))
		    {
			REMOVE_STRING(cResponse,"' ',ITOA(cCount),' Name: "'",1)
			cNameReturn = cResponse
			cNameReturn = LEFT_STRING(cNameReturn,LENGTH_STRING(cNameReturn)-3) //Take off last quote plus CR/LF
			
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[cCount]),',0,',cNameReturn"
		    }		    
		    IF(FIND_STRING(cResponse,"' ',ITOA(cCount),' ContactMethod 1 Number: "'",1)) //Blue Jeans + Local Book Found Here...
		    {
			REMOVE_STRING(cResponse,"' ',ITOA(cCount),' ContactMethod 1 Number: "'",1)
			
			    cPrimaryReturn = cResponse //Should Have Number...
			    cPrimaryReturn = LEFT_STRING(cPrimaryReturn,LENGTH_STRING(cPrimaryReturn)-3)
			    
			    cSlot_Primary[cCount] = cPrimaryReturn //Populate Array 
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
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Video Input MainVideoSource: 2',1)):
	    {
		nCameraSelect = SOURCE_CAMERA_FRONT
		    ON [vdvTP_Codec, BTN_CAM_FRONT]
		    fnRouteCamera(VIDEO_CAMERA_FRONT) //From Main Prgm
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Video Input MainVideoSource: 1',1)):
	    {
		nCameraSelect = SOURCE_CAMERA_REAR
		    ON [vdvTP_Codec, BTN_CAM_REAR]
			fnRouteCamera(VIDEO_CAMERA_REAR) //From Main Prgm
	    }
	    ACTIVE(FIND_STRING(cResponse,'xCommand Video Input SetMainVideoSource ConnectorId: 2',1)):
	    {
		nCameraSelect = SOURCE_CAMERA_FRONT
		     ON [vdvTP_Codec, BTN_CAM_FRONT]
			fnRouteCamera(VIDEO_CAMERA_FRONT) //From Main Prgm
	    }
	    ACTIVE(FIND_STRING(cResponse,'xCommand Video Input SetMainVideoSource ConnectorId: 1',1)):
	    {
		nCameraSelect = SOURCE_CAMERA_REAR
		     ON [vdvTP_Codec, BTN_CAM_REAR]
			fnRouteCamera(VIDEO_CAMERA_REAR) //From Main Prgm
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Conference DoNotDisturb: Inactive',1)):
	    {
		OFF [nDisturb]
		    ON [vdvTP_Codec, BTN_DISTURB_ALLOW]
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Conference DoNotDisturb: Active',1)):
	    {
		ON [nDisturb]
		    ON [vdvTP_Codec, BTN_DISTURB_NO]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Video Selfview Mode: Off',1)):
	    {
		OFF [nSelfView]
		    OFF [vdvTP_Codec, BTN_TOGGLE_SELFVIEW]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Video Selfview Mode: On',1)):
	    {
		ON [nSelfView]
		    ON [vdvTP_Codec, BTN_TOGGLE_SELFVIEW]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e IncomingCallIndication RemoteURI: "sip:',1)):
	    {
		REMOVE_STRING(cResponse,'*e IncomingCallIndication RemoteURI: "sip:',1)
		sCallerId = cResponse
		SET_LENGTH_STRING(sCallerId,LENGTH_STRING(sCallerId) -3);
		
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',sCallerId" 
		    SEND_COMMAND vdvTP_Codec, "'PPON-_incomingcall'"
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SIP Registration 1 URI: "',1)):
	    {
		REMOVE_STRING(cResponse,'*s SIP Registration 1 URI: "',1)
		sURI = cResponse
		
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
		sCallerId = cResponse
		SET_LENGTH_STRING (sCallerId,LENGTH_STRING(sCallerId) -3)
		
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',sCallerId"
	    }
	    ACTIVE(FIND_STRING(cResponse,'RemoteNumber: "',1)):
	    {
		REMOVE_STRING (cResponse,'RemoteNumber: "',1)
		cRemoteNumber = cResponse
		SET_LENGTH_STRING (cRemoteNumber,LENGTH_STRING(cRemoteNumber) -3)
		
		//SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',sCallerId"
	    }
    	    ACTIVE(FIND_STRING(cResponse,'DisplayName: "',1)):
	    {
		REMOVE_STRING (cResponse,'DisplayName: "',1)
		cRemoteDisplay = cResponse
		SET_LENGTH_STRING (cRemoteDisplay,LENGTH_STRING(cRemoteDisplay) -3)
		
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLTYPE),',0,',cRemoteDisplay"
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		OFF [nCallInProgress]
		    OFF [vdvTP_Codec, BTN_BJN_SPEED ]
		    OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect CauseType: "NetworkRejected"',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		//Invalid Address...
		OFF [nCallInProgress]
		    OFF [vdvTP_Codec, BTN_BJN_SPEED ]
			    OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e OutgoingCallIndication CallId:',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connecting'"
		ON [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'Status: Connected',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected'"
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
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: Standby',1)):
	    {
		//Sleep
		OFF [sPowerStatus]
		    OFF [nCallInProgress]
			OFF [vdvTP_Codec, POWER]
			    OFF [vdvTP_Codec, BTN_BJN_SPEED ]
				OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: On',1)):
	    {
		OFF [sPowerStatus]
		OFF [nCallInProgress]	
		    OFF [vdvTP_Codec, POWER]
			OFF [vdvTP_Codec, BTN_BJN_SPEED ]
			    OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: Off',1)):
	    {
		ON [sPowerStatus]
		    ON [vdvTP_Codec, POWER]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SystemUnit State System: Initialized',1)):
	    {
		//State Disconnected
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ready'"
		OFF [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SystemUnit State System: InCall',1)):
	    {
		//State connected
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected'"
		ON [nCallInProgress]
	    }
	}
    }
}
DEFINE_FUNCTION fnRegisterFeedback()
{
    (*Check Current
    SEND_STRING dvCodec, "'xFeedback List',$0D"
    
    DeRegister
    "'xFeedback deregister /Event/TStrings',$0D"
    *)
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
   WAIT 130 SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
}
DEFINE_FUNCTION fnUpdateList()
{
    STACK_VAR INTEGER nLoop
    
    FOR (nLoop =1; nLoop <=nListCount; nLoop++)
    {
	SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[nLoop]),',0,'" //Set them all blank...
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
		IF (nCallInProgress)
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
BUTTON_EVENT [vdvTP_Codec, nSelectCameraBtns] //Camera Select
{
    PUSH :
    {
	//nCameraSelect = GET_LAST (nSelectCameraBtns)
	TOTAL_OFF [vdvTP_Codec, nPresetSelectBtns]
	
        fnSelectCamera(nCameraIds[GET_LAST(nSelectCameraBtns)])
		//ON [dvTP_Codec, nSelectCameraBtns[nCameraSelect] //Set Feedback
    }
}
BUTTON_EVENT [vdvTP_Codec, nCameraControlsBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nCamIdx
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
	STACK_VAR INTEGER nCamIdx
	
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
BUTTON_EVENT [vdvTP_Codec, nPresetSelectBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nPresetIdx
	
	nPresetIdx = GET_LAST (nPresetSelectBtns)
	 ON [vdvTP_Codec, nPresetSelectBtns[nPresetIdx]] //Send Feedback
	
	IF (nCameraSelect = SOURCE_CAMERA_REAR)
	{
	    SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:',ITOA(nPresetIdx),CR"
	}
	ELSE
	{
	    SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:',ITOA(nPresetIdx + 5),CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nPresetStoreBtns]
{
    HOLD [30] :
    {
	STACK_VAR INTEGER nStoreIdx
	
	nStoreIdx = GET_LAST (nPresetStoreBtns)
	SEND_COMMAND dvTP_Codec, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Preset Saved!'"
	
	IF (nCameraSelect = SOURCE_CAMERA_REAR)
	{
	    SEND_STRING dvCodec, "'xCommand Camera Preset Store PresetId: ',ITOA(nStoreIdx), ' CameraId: ',ITOA(nCameraSelect), ' ListPosition:',ITOA(nStoreIdx),CR"
	}
	ELSE
	{
	    SEND_STRING dvCodec, "'xCommand Camera Preset Store PresetId: ',ITOA(nStoreIdx +5), ' CameraId: ',ITOA(nCameraSelect), ' ListPosition:',ITOA(nStoreIdx +5),CR"
	}
	    
	    WAIT 50
	    {
		 SEND_COMMAND dvTP_Codec, "'^TXT-',ITOA(TXT_CAMERA_SAVED),',0,Hold for 3 Seconds to Save Camera Presets'"
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
BUTTON_EVENT [vdvTP_Codec, nPhonenavBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nDirectory
	nDirectory = GET_LAST (nPhonenavBtns)
	
	TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
	    SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		ON [vdvTP_Codec, nPhonenavBtns[nDirectory]] //Send Feedback..
	fnUpdateList()
	
	SWITCH (nDirectory)
	{
	    CASE 1: //ATL Enpoints
	    {
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"		
	    }
	    CASE 2:
	    {
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:14 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"
	    }
	    CASE 3:
	    {
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:28 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"	                          
	    }
	    CASE 4:
	    {
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:42 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"
	    }
	    CASE 5:
	    {
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0 FolderId:',cFolderBlueJeans,' Limit:',ITOA(nListCount),CR" 
	    }
	    CASE 6:
	    {
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Local Offset: 0',CR" //Search Local
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nPhoneSelect]
{
    PUSH :
    {

	STACK_VAR INTEGER nDirectorySet
	nDirectorySet = GET_LAST (nPhoneSelect)
	
	    //ON [vdvTP_Codec, nDirectorySet + 300] //Send Feedback..
		ON [vdvTP_Codec, nPhoneSelect[nDirectorySet]]
	
	    dialNumber = cSlot_Primary[nDirectorySet]
		send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
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
BUTTON_EVENT [vdvTP_Codec, POWER]
{
    PUSH :
    {
	IF (!sPowerStatus)
	{
	    SEND_STRING dvCodec, "'xCommand Standby Deactivate',CR"
		ON [vdvTP_Codec, POWER]
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_SHOW_KEYB] //keyboard Lectern..
{
    PUSH :
    {	
	SEND_COMMAND dvTP_Codec, "'^AKB'" //Call System Keyboard for G5...
	//SEND_COMMAND dvTP_Codec, "'@AKB'" //Call System Keyboard for G4...
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_BJN_SPEED]
{
    PUSH :
    {
	    SEND_STRING dvCodec, "'xCommand Dial Number: meet@bjn.vc',CR"
		ON [vdvTP_Codec, BTN_BJN_SPEED ]
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,meet@bjn.vc'"
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_DIAL_WEBEX]
{
    PUSH :
    {
	SEND_STRING dvCodec, "'xCommand Webex Join Number: "',dialNumber,'"',CR"
	    ON [vdvTP_Codec, BTN_DIAL_WEBEX_FB]
		
		IF(LENGTH_STRING(dialNumber) >=9)
		{
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',dialNumber,'@webex.com'"
		}
		ELSE
		{
		     SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,',dialNumber"
		}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Codec]
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
	LOCAL_VAR CHAR sMsgs[40]
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
		dialNumber = sMsgs
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
	    fnRegisterFeedback()
	    WAIT 200
	    {
		fnUpdateList() //Reset List to Blank...
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
    
    WAIT 8800
    {
	SEND_STRING dvCodec, "'xCommand Standby ResetHalfwakeTimer Delay: 480',CR" 
	WAIT 50
	{
	    fnRegisterFeedback()
	}
    }
}

