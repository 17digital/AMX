PROGRAM_NAME='MySX80'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/02/2019  AT: 12:45:30        *)
(***********************************************************)

//Notes...

(*
    http://consulting129.vtc.gatech.edu
    admin


    Add BlueJeans ...
    meet@sip.bjn.vc
    111@sip.bjn.vc
*)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP
dvTP =					10001:2:0
#END_IF

#IF_NOT_DEFINED dvTP2
dvTP2 =					10002:2:0
#END_IF

#IF_NOT_DEFINED dvCodec
dvCodec =					5001:3:0 //Cisco WebEx Room Kit Pro 
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

CAMERA_FRONT				= 1
CAMERA_REAR				= 2

SET_ON					= 'On'
SET_OFF					= 'Off'

MIC_MUTE_ON				= 'Mute'
MIC_MUTE_OFF				= 'UnMute'

DO_NOT_DISTURB			= 'Activate'
DO_DISTURB				= 'Deactivate'

//Sharing Source
SHARE_SOURCE				= 3 //DVI INput on SX80

//Cam Presets..
PRESET_1				= 1
PRESET_2				= 2
PRESET_3				= 3
PRESET_4				= 4
PRESET_5				= 5
PRESET_6				= 6
PRESET_7				= 7
PRESET_8				= 8

//Text Address
MAX_TEXT_LENGTH 	= 100
TXT_CALLID				= 2001
TXT_MYSIP					= 2002
TXT_STATE				= 2003
TXT_CALLTYPE				= 2004
TXT_DIAL					= 2019
TXT_RETURN_ITEMS		= 2020

//Buttons..
BTN_NAV_PAGE_1			= 201
BTN_NAV_PAGE_2			= 202
BTN_NAV_PAGE_3			= 203
BTN_NAV_PAGE_4			= 204
BTN_NAV_PAGE_5			= 205
BTN_NAV_PAGE_6			= 206

BTN_NAV_DIAL			= 210
BTN_DISTURB_ALLOW			= 106
BTN_DISTURB_NO				= 107

BTN_START_SHARING		= 108
BTN_STOP_SHARING		= 109
BTN_TOGGLE_SELFVIEW		= 110

BTN_MIC_MUTE_VTC		= 113

BTN_CAMERA_FRONT		= 41
BTN_CAMERA_REAR		= 42

BTN_SHOW_KEYB			= 1500

BTN_BJN_SPEED 			= 3001
BTN_DIAL_WEBEX			= 3002
BTN_DIAL_WEBEX_FB		= 3003

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE


//Place Caller ID
CHAR cNameReturn[30] =''
CHAR cSecondaryReturn[35] ='' //GT Book Return
CHAR cPrimaryReturn[35] = '' //Blue Jeans + Local Return

VOLATILE INTEGER nSX80Online
VOLATILE CHAR cSX80Buffer[500]

VOLATILE INTEGER nJustBooted
VOLATILE INTEGER nCameraSelect //Front or Rear?
VOLATILE INTEGER nCameraPreset 
VOLATILE INTEGER sPowerStatus
NON_VOLATILE INTEGER nBlueJeansStarted

VOLATILE INTEGER nDisturb
VOLATILE INTEGER nSelfView
VOLATILE INTEGER nPresentation
VOLATILE INTEGER nPIPCounter //PIP Cycle
VOLATILE INTEGER nVolumeOutput = 80 //Volume Max 
VOLATILE INTEGER nVTC_Mic_Mute

VOLATILE INTEGER nPowerStatus //Power Track
VOLATILE INTEGER nCallInProgress //In Call? or Not?

VOLATILE INTEGER nPage //Phonebook Page
VOLATILE INTEGER nListCount = 14 //How many list items are we displaying?? 10 is Temp
VOLATILE CHAR sEntriesFound[3] = '' //How many directories?
VOLATILE CHAR cFolderGT[4] =''
VOLATILE CHAR cFolderTest[4] =''
VOLATILE CHAR cFolderBlueJeans[4] =''
VOLATILE INTEGER cDialGTBook //Am I using the GT phonebook or naw??

VOLATILE CHAR dialNumber[MAX_TEXT_LENGTH]  // stores the number being dialed

VOLATILE CHAR cSlot_Secondary[14][35] = {'','','','','','','','','','','','','',''} //Hold GT Numbers...
VOLATILE CHAR cSlot_Primary[14][35] = {'','','','','','','','','','','','','',''} //Hold GT Numbers...
INTEGER cCount //Used for Phonebook

VOLATILE DEV vdvTP_Codec[] = 
{
    dvTP, 
    dvTP2
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
VOLATILE INTEGER nCameraControlBtns[] =
{
    51, //Left
    52, //Right
    53, //Up
    54, //Down
    55, //Zoom In
    56  //Zoom Out
}
VOLATILE INTEGER nCameraPresets[] =
{
    //Recall..
    61,62,63,64,65,
    
    //Save...
    71,72,73,74,75
}
VOLATILE INTEGER nVTCControlBtns[] =
{
    100, //Answer
    101, //Hangup
    102, //Ignore
    103, //Reject
    104, //Sleep
    105, //Wake
    
    106, //Do not disturb (Available)
    107, //Do not distub (No Calls!!)
    
    108, //Presentation On
    109, //Presentation off
    
    110, //Selfview On /Off
    111, //PIP cycle
     
    113, //Mute Microphone
    114, //Output Volume Up
    115, //Output Volume Dn
    116  //Output Preset
    
}
VOLATILE INTEGER nPhonenavBtns[] =
{
    BTN_NAV_PAGE_1,
    BTN_NAV_PAGE_2,
    BTN_NAV_PAGE_3,
    BTN_NAV_PAGE_4,
    BTN_NAV_PAGE_5,
    BTN_NAV_PAGE_6
}
VOLATILE CHAR nPhoneNavNames[6][10] =
{
    'PAGE 1',
    'PAGE 2',
    'PAGE 3',
    'PAGE 4',
    'PAGE 5',
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

([dvTP,nPhoneSelect[1]]..[dvTP,nPhoneSelect[14]])
([dvTP, BTN_NAV_PAGE_1]..[dvTP, BTN_NAV_PAGE_6])
([dvTP, BTN_CAMERA_FRONT],[dvTP, BTN_CAMERA_REAR])
([dvTP, BTN_DISTURB_ALLOW],[dvTP, BTN_DISTURB_NO])
([dvTP, BTN_START_SHARING],[dvTP, BTN_STOP_SHARING])

//#2 
([dvTP2,nPhoneSelect[1]]..[dvTP2,nPhoneSelect[14]])
([dvTP2, BTN_NAV_PAGE_1]..[dvTP2, BTN_NAV_PAGE_6])
([dvTP2, BTN_CAMERA_FRONT],[dvTP2, BTN_CAMERA_REAR])
([dvTP2, BTN_DISTURB_ALLOW],[dvTP2, BTN_DISTURB_NO])
([dvTP2, BTN_START_SHARING],[dvTP2, BTN_STOP_SHARING])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION addToDialNumber(char cNumber[])
{
    IF (length_string(dialNumber) < MAX_TEXT_LENGTH)
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
	    SEND_STRING dvCodec, "'xCommand Presentation Start SendingMode:LocalRemote ConnectorId:',ITOA(SHARE_SOURCE),CR"
	    ON [vdvTP_Codec, BTN_START_SHARING]
				fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_ON)
	}
	CASE 'STOP' :
	{
	    SEND_STRING dvCodec, "'xCommand Presentation Stop',CR"
	    ON [vdvTP_Codec, BTN_STOP_SHARING]
		fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_OFF)
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
DEFINE_FUNCTION fnCallCommands(CHAR cCommand[15])
{
    SWITCH (cCommand)
    {
	CASE 'ACCEPT' :
	{
	    SEND_STRING dvCodec, "'xCommand Call Accept CallId:0',CR"
	    SEND_COMMAND vdvTP_Codec, "'PPOF-_incomingcall'"
	    WAIT 10
	    {
		SEND_COMMAND vdvTP_Codec, "'PAGE-Conference'"
		WAIT 10
		{
		    SEND_COMMAND vdvTP_Codec, "'PPON-VTC_Dialer'"
		    SEND_STRING dvCodec, "'xStatus SystemUnit State System',CR" //InCall?
		}
	    }
	}
	CASE 'HANGUP' :
	{
	    SEND_STRING dvCodec, "'xCommand Call Disconnect CallId:0',CR"
	    //SEND_STRING dvCodec, "'xCommand Call DisconnectAll',$0D"
	}
	CASE 'SLEEP' :
	{
	    SEND_STRING dvCodec, "'xCommand Standby Activate',CR"
	}
	CASE 'WAKE' :
	{
	    SEND_STRING dvCodec, "'xCommand Standby Deactivate',CR"
	    WAIT 10
	    {
		SEND_STRING dvCodec, "'xCommand Standby ResetHalfwakeTimer Delay: 480',CR" 
	    }
	}
	CASE 'REJECT':
	{
	    SEND_STRING dvCodec, "'xCommand Call Reject CallId:0',CR"
	    SEND_COMMAND vdvTP_Codec, "'PPOF-_incomingcall'"
	}
	CASE 'IGNORE':
	{
	    SEND_STRING dvCodec, "'xCommand Call Ignore CallId:0',CR"
	    SEND_COMMAND vdvTP_Codec, "'PPOF-_incomingcall'"
	}
    }
}
DEFINE_FUNCTION fnDirectoryNav() //Populate Contact Navigation
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
}
DEFINE_FUNCTION fnSelectCamera(INTEGER cCamera)
{
    SEND_STRING dvCodec, "'xCommand Video Input SetMainVideoSource ConnectorId: ',ITOA(cCamera), CR"
    WAIT 10
    {
	SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
    }
}
DEFINE_FUNCTION fnParseSX80()
{
    STACK_VAR CHAR cResponse[500]
    
    LOCAL_VAR CHAR sURI[30]
    LOCAL_VAR CHAR sCallerId[30]
    LOCAL_VAR CHAR sLastDialed[30]
    
    
    WHILE(FIND_STRING(cSX80Buffer,"CR,LF",1))
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
	    //ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect CauseType: "RemoteDisconnect"',1)):
	    ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		OFF [nCallInProgress]
		    OFF [vdvTP_Codec, BTN_BJN_SPEED ]
			OFF [vdvTP_Codec, BTN_DIAL_WEBEX_FB]
			fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_OFF)
			    OFF [nBlueJeansStarted]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect CauseType: "NetworkRejected"',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		//Invalid Address...
		OFF [nCallInProgress]
		    OFF [vdvTP_Codec, BTN_BJN_SPEED ]
			OFF [vdvTP_Codec, BTN_DIAL_WEBEX_FB]
			fnMuteChannel (TAG_MUTE_PRGM, ID_PRGM_LEV, YES_OFF)
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
	    ACTIVE(FIND_STRING(cResponse,'*s Video Input MainVideoSource: 1',1)):
	    {
		nCameraSelect = CAMERA_FRONT
		ON [vdvTP_Codec, BTN_CAMERA_FRONT] 
	    }
	    ACTIVE(FIND_STRING(cResponse,'xCommand Video Input SetMainVideoSource ConnectorId: 1',1)):
	    {
		nCameraSelect = CAMERA_FRONT
		    ON [vdvTP_Codec, BTN_CAMERA_FRONT] 
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Video Input MainVideoSource: 2',1)):
	    {
		nCameraSelect = CAMERA_REAR
		    ON [vdvTP_Codec, BTN_CAMERA_REAR] 
	    }
	    ACTIVE(FIND_STRING(cResponse,'xCommand Video Input SetMainVideoSource ConnectorId: 2',1)):
	    {
		nCameraSelect = CAMERA_REAR
		    ON [vdvTP_Codec, BTN_CAMERA_REAR] 
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
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: Off',1)):
	    {
		ON [sPowerStatus]
		    ON [vdvTP_Codec, POWER]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: On',1)):
	    {
		OFF [sPowerStatus]
		OFF [nCallInProgress]	
		    OFF [vdvTP_Codec, POWER]
			OFF [vdvTP_Codec, BTN_BJN_SPEED ]
			    OFF [nBlueJeansStarted]
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
		OFF [nCallInProgress]
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
    WAIT 110 SEND_STRING dvCodec, "'xFeedback register /Status/Conference',CR"
    //Event IncomingCallIndication CallId
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


WAIT 300
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
	    }
	    CASE 16: //DTMF #
	    {
		SEND_STRING dvCodec, "'xCommand Call DTMFSend CallId:0 DTMFString:#',CR"
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_CAMERA_FRONT]
BUTTON_EVENT [vdvTP_Codec, BTN_CAMERA_REAR] 
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_CAMERA_FRONT: fnSelectCamera(CAMERA_FRONT)
	    CASE BTN_CAMERA_REAR: fnSelectCamera(CAMERA_REAR)
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nCameraControlBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nCamIdx
	//OFF [nCameraPreset]
	
	nCamIdx = GET_LAST(nCameraControlBtns)
	
	SELECT
	{
	    ACTIVE ( nCameraSelect == CAMERA_FRONT) :
	    {
		SWITCH (nCamIdx)
		{
		    CASE 1: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Pan:Left PanSpeed:1',CR"
		    CASE 2: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Pan:Right PanSpeed:1',CR"
		    CASE 3: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Tilt:Up TiltSpeed:1',CR"
		    CASE 4: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Tilt:Down TiltSpeed:1',CR"
		    CASE 5: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Zoom:In ZoomSpeed:12',CR"
		    CASE 6: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Zoom:Out ZoomSpeed:12',CR"
		}
	    }
	    ACTIVE ( nCameraSelect == CAMERA_REAR) :
	    {
		SWITCH (nCamIdx)
		{
		    CASE 1: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Pan:Left PanSpeed:1',CR"
		    CASE 2: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Pan:Right PanSpeed:1',CR"
		    CASE 3: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Tilt:Up TiltSpeed:1',CR"
		    CASE 4: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Tilt:Down TiltSpeed:1',CR"
		    CASE 5: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Zoom:In ZoomSpeed:1',CR"
		    CASE 6: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Zoom:Out ZoomSpeed:1',CR"
		}
	    }
	}
    }
    RELEASE :
    {
	STACK_VAR INTEGER nCamIdx
	//OFF [nCameraPreset]
	
	nCamIdx = GET_LAST(nCameraControlBtns)
	SWITCH (nCamIdx)
	{
	    CASE 1:
	    CASE 2: //Stop Panning
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Pan:Stop',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Pan:Stop',CR"
	    }
	    CASE 3:
	    CASE 4: //Stop Tilt
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Tilt:Stop',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Tilt:Stop',CR"
	    }
	    CASE 5:
	    CASE 6: //Stop Zoom
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Zoom:Stop',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Zoom:Stop',CR"
	    }
	}
    }
} 
BUTTON_EVENT [vdvTP_Codec, nCameraPresets]
{
    PUSH :
    {
	STACK_VAR INTEGER nPresetIdx
	
	nPresetIdx = GET_LAST (nCameraPresets)
	
	SELECT
	{
	    ACTIVE (nCameraSelect == CAMERA_FRONT):
	    {
		SWITCH (nPresetIdx)
		{
		    CASE 1 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:1',CR"
		    CASE 2 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:2',CR"
		    CASE 3 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:3',CR"
		    CASE 4 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:4',CR"
		    CASE 5 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:5',CR"
		    
		    CASE 6 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:1 CameraId:1 ListPosition:1 Name:Preset1',CR"
		    CASE 7 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:2 CameraId:1 ListPosition:2 Name:Preset2',CR"
		    CASE 8 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:3 CameraId:1 ListPosition:3 Name:Preset3',CR"
		    CASE 9 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:4 CameraId:1 ListPosition:4 Name:Preset4',CR"
		    CASE 10 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:5 CameraId:1 ListPosition:5 Name:Preset5',CR"
		}
	    }
	    ACTIVE (nCameraSelect == CAMERA_REAR):
	    {
		SWITCH (nPresetIdx)
		{
		    CASE 1 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:6',CR"
		    CASE 2 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:7',CR"
		    CASE 3 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:8',CR"
		    CASE 4 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:9',CR"
		    CASE 5 : SEND_STRING dvCodec, "'xCommand Camera Preset Activate PresetId:10',CR"
		    
		    CASE 6 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:6 CameraId:2 ListPosition:6 Name:Preset6',CR"
		    CASE 7 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:7 CameraId:2 ListPosition:7 Name:Preset7',CR"
		    CASE 8 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:8 CameraId:2 ListPosition:8 Name:Preset8',CR"
		    CASE 9 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:9 CameraId:2 ListPosition:9 Name:Preset9',CR"
		    CASE 10 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:10 CameraId:2 ListPosition:10 Name:Preset10',CR"
		}
	    }
	}
    }
    RELEASE :
    {
    	STACK_VAR INTEGER nPresetIdx
	
	nPresetIdx = GET_LAST (nCameraPresets)
	SWITCH (nPresetIdx)
	{
	    CASE 1: 
	    CASE 2: 
	    CASE 3: 
	    CASE 4:
	    CASE 5:
	    {
		WAIT 10 SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
	    }
	    CASE 6:
	    CASE 7:
	    CASE 8:
	    CASE 9:
	    CASE 10:
	    {
		SEND_COMMAND vdvTP_Codec, "'ADBEEP'"
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nVTCControlBtns] //Codec Controls...
{
    PUSH :
    {
	STACK_VAR INTEGER nControlIdx
	
	nControlIdx = GET_LAST (nVTCControlBtns)
	SWITCH (nControlIdx)
	{
	    CASE 1: fnCallCommands ('ACCEPT')
	    CASE 2: fnCallCommands ('HANGUP')
	    CASE 3: fnCallCommands ('IGNORE')
	    CASE 4: fnCallCommands ('REJECT')
	    CASE 5: fnCallCommands ('SLEEP')
	    CASE 6: fnCallCommands ('WAKE')
	    
	    //Disturb Sign..
	    CASE 7: fnDisturbOrNot (DO_DISTURB)
	    CASE 8: fnDisturbOrNot (DO_NOT_DISTURB)

	    //Presentation
	    CASE 9: fnPresentation ('START')
	    CASE 10: fnPresentation ('STOP')
	
	    CASE 11 : 
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
	    CASE 12 : fnPIPCycle (nPIPCounter)

	    //Mic Mute
	    CASE 13:
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
    }
}
BUTTON_EVENT [dvTP2, BTN_SHOW_KEYB] //keyboard Lectern..
{
    PUSH :
    {	
	SEND_COMMAND dvTP2, "'^AKB'" //Call System Keyboard...
    }
}
BUTTON_EVENT [dvTP, BTN_SHOW_KEYB] //keyboard Lectern..
{
    PUSH :
    {	
	SEND_COMMAND dvTP, "'^AKB'" //Call System Keyboard...
    }
}
BUTTON_EVENT [vdvTP_Codec, nPhonenavBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nDirectory
	
	nDirectory = GET_LAST (nPhonenavBtns)
	SWITCH (nDirectory)
	{
	    CASE 1: //ATL Enpoints
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		ON [vdvTP_Codec, BTN_NAV_PAGE_1] 
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"		
	    }
	    CASE 2:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		ON [vdvTP_Codec, BTN_NAV_PAGE_2] 
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:14 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"
	    }
	    CASE 3:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		ON [vdvTP_Codec, BTN_NAV_PAGE_3] 
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:28 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"	                          
	    }
	    CASE 4:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		ON [vdvTP_Codec, BTN_NAV_PAGE_4] 
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:42 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"
	    }
	    CASE 5:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		ON [vdvTP_Codec, BTN_NAV_PAGE_5] 
		OFF [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0 FolderId:',cFolderBlueJeans,' Limit:',ITOA(nListCount),CR" 
	    }
	    CASE 6:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		ON [vdvTP_Codec, BTN_NAV_PAGE_6] 
		OFF [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
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
	
	TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
	dialNumber = ''
	
		SWITCH (nDirectorySet)
		{
		    CASE 1:
		    {
			dialNumber = cSlot_Primary[1]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 301]
		    }
		    CASE 2:
		    {
			dialNumber = cSlot_Primary[2]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 302]
		    }
		    CASE 3:
		    {
			dialNumber = cSlot_Primary[3]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 303]
		    }
		    CASE 4:
		    {

			dialNumber = cSlot_Primary[4]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 304]
		    }
		    CASE 5:
		    {
			    dialNumber = cSlot_Primary[5]
			
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 305]
		    }
		    CASE 6:
		    {
			    dialNumber = cSlot_Primary[6]
		    
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 306]
		    }
		    CASE 7:
		    {
			dialNumber = cSlot_Primary[7]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 307]
		    }
		    CASE 8:
		    {
			    dialNumber = cSlot_Primary[8]
			
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 308]
		    }
		    CASE 9:
		    {
			dialNumber = cSlot_Primary[9]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 309]
		    }
		    CASE 10:
		    {
			dialNumber = cSlot_Primary[10]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 310]
		    }
		    CASE 11:
		    {
			    dialNumber = cSlot_Primary[11]
			
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 311]
		    }
		    CASE 12:
		    {
			    dialNumber = cSlot_Primary[12]
			
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 312]
		    }
		    CASE 13:
		    {
			    dialNumber = cSlot_Primary[13]
			
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 313]
		    }
		    CASE 14:
		    {
			    dialNumber = cSlot_Primary[14]
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 314]
		    }
		}
	    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_NAV_DIAL] //Dialing from PhoneBook...
{
    PUSH :
    {
	SEND_COMMAND vdvTP_Codec, "'^PPX-VTC_Contacts'"
	TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
	WAIT 10
	{
	    SEND_COMMAND vdvTP_Codec, "'^PPN-VTC_Dialer'"
	    SEND_STRING dvCodec, "'xCommand Dial Number:',dialNumber,CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, POWER]
{
    PUSH :
    {
	IF (!sPowerStatus )
	{
	    fnCallCommands('WAKE')
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, TXT_DIAL]
{
    HOLD [30]:
    {
	SEND_STRING dvCodec, "'xCommand Phonebook Contact Add Name: "',dialNumber,'" Number:',dialNumber,CR"
	SEND_COMMAND vdvTP_Codec, "'ADBEEP'"
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_BJN_SPEED]
{
    PUSH :
    {
	IF (!nBlueJeansStarted)
	{
	    SEND_STRING dvCodec, "'xCommand Dial Number: meet@bjn.vc',CR"
		ON [vdvTP_Codec, BTN_BJN_SPEED ]
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_CALLID),',0,meet@bjn.vc'"
		    ON [nBlueJeansStarted]
	}
	ELSE
	{
	    SEND_COMMAND vdvTP_Codec, "'^PPN-VTC_BlueJeans'"
	}
	
    }
}
BUTTON_EVENT [vdvTP_Codec, BTN_DIAL_WEBEX]
{
    PUSH :
    {
	SEND_STRING dvCodec, "'xCommand Webex Join Number: "',dialNumber,'"',CR"
	    ON [vdvTP_Codec, BTN_DIAL_WEBEX_FB]
		
		IF(LENGTH_STRING(dialNumber) =9)
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
DATA_EVENT[dvTP] 
DATA_EVENT[dvTP2] 
{
    ONLINE :
    {
	fnDirectoryNav()
	
	IF (!nJustBooted)
	{
	    fnUpdateList() //Reset List to Blank...
	    fnPollCodec()
	}
    }
    STRING:
    {
	LOCAL_VAR CHAR sTmp[40]
	sTmp = DATA.TEXT
	
	IF (find_string(sTmp, 'AKB-', 1))
	{
	    REMOVE_STRING(sTmp, '-', 1)
	    dialNumber = sTmp
	    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
	}
    }
}
DATA_EVENT [dvCodec]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1 485 DISABLED'" //Changed baud rate due to old processor! Cant handle 115200
	SEND_COMMAND DATA.DEVICE, 'HSOFF'
	SEND_COMMAND DATA.DEVICE, 'RXON'

	// echo on $OD
	
	ON [nSX80Online]
	WAIT 80
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
    
    WAIT 4500
    {
	SEND_STRING dvCodec, "'xCommand Standby ResetHalfwakeTimer Delay: 480',CR" 
	WAIT 50
	{
	    fnRegisterFeedback()
	}
    }

}



