PROGRAM_NAME='MySX80'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 08/25/2018  AT: 09:26:49        *)
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
dvTP =					10001:4:0
#END_IF

#IF_NOT_DEFINED dvTP2
dvTP2 =					10002:4:0
#END_IF

#IF_NOT_DEFINED dvCodec
dvCodec =					5001:2:0
#END_IF



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER MAX_TEXT_LENGTH 	= 100
TXT_CALLID				= 2001
TXT_MYSIP					= 2002
TXT_STATE				= 2003
TXT_CALLTYPE				= 2004
TXT_DIAL					= 2019
TXT_RETURN_ITEMS			= 2020

#IF_NOT_DEFINED CR 
CR 						= 13 //~$0D
#END_IF

#IF_NOT_DEFINED LF 
LF						= 10 //~$0A
#END_IF

#IF_NOT_DEFINED IS_ON 
IS_ON					= 1
#END_IF

#IF_NOT_DEFINED IS_OFF 
IS_OFF					= 0 //~$0A
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


//Cam Presets..
PRESET_1				= 1
PRESET_2				= 2
PRESET_3				= 3
PRESET_4				= 4
PRESET_5				= 5
PRESET_6				= 6
PRESET_7				= 7
PRESET_8				= 8

//Phone Book Directories
ATL_END				= 1
SAV_END				= 2
GTL_END				= 3
GT_END				= 4
BLUE_JEANS			= 5
LOCAL_DIR				= 6

TL_VTC				= 7
TL_RECALL				= 8


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Codec[] = {dvTP, dvTP2} //

VOLATILE CHAR nVTCBuffer[1000]
//VOLATILE LONG lVTCTimer[] = {15000} //15Seconds

//Phone Book Directories..
CHAR nAtlEnd[10] = 'PAGE 1'
CHAR nSavEnd[10] = 'PAGE 2'
CHAR nGtlEnd[10] = 'PAGE 3'
CHAR nGtEnd[10] = 'PAGE 4'
CHAR nBjn[10] = 'BlueJeans'
CHAR nLocalSearch[10] = 'Local'

//Place Caller ID
CHAR cNameReturn[30] =''
CHAR cSecondaryReturn[35] ='' //GT Book Return
CHAR cPrimaryReturn[35] = '' //Blue Jeans + Local Return

VOLATILE INTEGER nSX80Online
VOLATILE LONG lTlCodecFeedback[] = {250}
VOLATILE LONG lTlCodecReCheck[] = {300000} //5 Minutes
VOLATILE CHAR cSX80Buffer[500]

VOLATILE INTEGER nJustBooted
VOLATILE INTEGER nCameraSelect //Front or Rear?
VOLATILE INTEGER nCameraPreset 
VOLATILE INTEGER sPowerStatus

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
CHAR cFolderGT[4] =''
CHAR cFolderTest[4] =''
CHAR cFolderBlueJeans[4] =''
VOLATILE INTEGER cDialGTBook //Am I using the GT phonebook or naw??

VOLATILE CHAR dialNumber[MAX_TEXT_LENGTH]  // stores the number being dialed

VOLATILE CHAR cSlot_Secondary[14][35] = {'','','','','','','','','','','','','',''} //Hold GT Numbers...
VOLATILE CHAR cSlot_Primary[14][35] = {'','','','','','','','','','','','','',''} //Hold GT Numbers...

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
    51, //Tilt Up
    52, //Tilt Down
    53, //Pan Left
    54, //Pan Right
    55, //Zoom Out
    56  //Zoom In
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
VOLATILE INTEGER nPhonenav[] =
{
    //Page Flips...
    201,
    202,
    203,
    204,
    205,
    206
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

([vdvTP_Codec,nPhoneSelect[1]]..[vdvTP_Codec,nPhoneSelect[14]])

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
	    SEND_STRING dvCodec, "'xCommand Presentation Start SendingMode:LocalRemote',CR"
	    WAIT 10
	    {
		SEND_STRING dvCodec, "'xStatus Conference Presentation Mode',CR"
	    }
	}
	CASE 'STOP' :
	{
	    SEND_STRING dvCodec, "'xCommand Presentation Stop',CR"
	    WAIT 10
	    {
		SEND_STRING dvCodec, "'xStatus Conference Presentation Mode',CR"
	    }
	}
    }
}
DEFINE_FUNCTION fnDisturbOrNot(CHAR cState[12])
{
    SEND_STRING dvCodec, "'xCommand Conference DoNotDisturb ',cState,CR"
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
DEFINE_FUNCTION fnDirectoryNav()
{
    SEND_COMMAND vdvTP_Codec, "'^TXT-201,0,',nAtlEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-202,0,',nSavEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-203,0,',nGtlEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-204,0,',nGtEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-205,0,',nBjn"
    SEND_COMMAND vdvTP_Codec, "'^TXT-206,0,',nLocalSearch"
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
    
	//SEND_STRING dvCodec, "'xStatus Call',$0D" //Query on going call
    WAIT 110 SEND_STRING dvCodec, "'xStatus SIP Registration URI',CR" //Get My URI
    WAIT 140 fnSetVolumeOut()
    WAIT 160 SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0',CR" //Get Phonebook Folders...
}
DEFINE_FUNCTION fnSelectCamera(INTEGER cCamera)
{
    SEND_STRING dvCodec, "'xCommand Video Input SetMainVideoSource ConnectorId: ',ITOA(cCamera),CR"
    WAIT 10
    {
	SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
    }
}
DEFINE_FUNCTION fnParseSX80()
{
    STACK_VAR CHAR cResponse[500] CHAR cTrash[500]
    
    LOCAL_VAR CHAR sURI[30]
    LOCAL_VAR CHAR sCallerId[30]
    LOCAL_VAR CHAR sLastDialed[30]
    STACK_VAR INTEGER cCount //Used for Phonebook
    
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
		    IF(FIND_STRING(cResponse,"' ',ITOA(cCount),' ContactMethod 2 Number: "'",1)) //GT Book Found Here...
		    {
			REMOVE_STRING(cResponse,"' ',ITOA(cCount),' ContactMethod 2 Number: "'",1)
			
			    cSecondaryReturn = cResponse //Should Have Number...
			    cSecondaryReturn = LEFT_STRING(cSecondaryReturn,LENGTH_STRING(cSecondaryReturn)-3)
			    
			    cSlot_Secondary[cCount] = cSecondaryReturn //Populate Array 
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
		cTrash = REMOVE_STRING(cResponse,'*s Conference Presentation Mode: ',1)
		
		IF (FIND_STRING(cResponse,'Off',1))
		{
		    nPresentation = IS_OFF 
		}
		IF (FIND_STRING(cResponse,'On',1))
		{
		    nPresentation = IS_ON
		}
		cTrash = ''
	    }
	    ACTIVE (FIND_STRING(cResponse,'xCommand Video Input SetMainVideoSource ConnectorId:2',1)):
	    {
		nCameraSelect = CAMERA_REAR
	    }
	    ACTIVE (FIND_STRING(cResponse,'xCommand Video Input SetMainVideoSource ConnectorId:1',1)):
	    {
		nCameraSelect = CAMERA_FRONT
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Video Input MainVideoSource: 1',1)):
	    {
		nCameraSelect = CAMERA_FRONT
	    }
	    ACTIVE (FIND_STRING(cResponse,'*s Video Input MainVideoSource: 2',1)):
	    {
		nCameraSelect = CAMERA_REAR
	    }

	    ACTIVE (FIND_STRING(cResponse,'xCommand Conference DoNotDisturb DeActivate',1)):
	    {
		nDisturb = IS_OFF
	    }
	    ACTIVE (FIND_STRING(cResponse,'xStatus Conference DoNotDisturb: Inactive',1)):
	    {
		nDisturb = IS_OFF
	    }
	    ACTIVE (FIND_STRING(cResponse,'xStatus Conference DoNotDisturb: Active',1)):
	    {
		nDisturb = IS_ON
	    }
	    ACTIVE (FIND_STRING(cResponse,'xCommand Conference DoNotDisturb Activate',1)):
	    {
		nDisturb = IS_ON
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Video Selfview Mode: Off',1)):
	    {
		nSelfView = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Video Selfview Mode: On',1)):
	    {
		nSelfView = IS_ON
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
		nCallInProgress = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e CallDisconnect CauseType: "NetworkRejected"',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		//Invalid Address...
		nCallInProgress = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,'*e OutgoingCallIndication CallId:',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connecting'"
		nCallInProgress = IS_ON
	    }
	    ACTIVE(FIND_STRING(cResponse,'Status: Connected',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected'"
		nCallInProgress = IS_ON
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Audio Microphones Mute: ',1)):
	    {
		cTrash = REMOVE_STRING(cResponse,'*s Audio Microphones Mute: ',1)
		
		IF (FIND_STRING(cResponse,'Off',1))
		{
		    nVTC_Mic_Mute = IS_OFF
		}
		IF (FIND_STRING(cResponse,'On',1))
		{
		    nVTC_Mic_Mute = IS_ON
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: Standby',1)):
	    {
		//Sleep
		sPowerStatus = IS_OFF
		nCallInProgress = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: Off',1)):
	    {
		sPowerStatus = IS_ON
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Standby State: On',1)):
	    {
		sPowerStatus = IS_OFF
		nCallInProgress = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SystemUnit State System: Initialized',1)):
	    {
		//State Disconnected
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ready'"
		nCallInProgress = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SystemUnit State System: InCall',1)):
	    {
		//State connected
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected'"
		nCallInProgress = IS_ON
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
//TIMELINE_CREATE (TL_VTC,lTlCodecFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

WAIT 600
{
    OFF [nJustBooted]
    TIMELINE_CREATE (TL_RECALL,lTlCodecReCheck,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
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
		IF (nCallInProgress == IS_ON)
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
		    SEND_COMMAND vdvTP_Codec, "'^TXT-19,0,',dialNumber"
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
BUTTON_EVENT [vdvTP_Codec, 41] //Camera Front
BUTTON_EVENT [vdvTP_Codec, 42] //Camera Rear
{
    PUSH :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE 41: 
	    {
		fnSelectCamera(CAMERA_FRONT)
		fnDGXSetCameraDefault()
		//nCameraSelect = CAMERA_FRONT
		fnDGXSwitchCamera(INPUT_CAMERA_FRONT) //Set AVB
	    }
	    CASE 42: 
	    {
		fnSelectCamera(CAMERA_REAR)
		fnDGXSetCameraDefault()
		//nCameraSelect = CAMERA_REAR
		fnDGXSwitchCamera(INPUT_CAMERA_REAR) //Set AVB
	    }
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
		    CASE 1: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Tilt:Up TiltSpeed:1',CR"
		    CASE 2: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Tilt:Down TiltSpeed:1',CR"
		    CASE 3: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Pan:Left PanSpeed:1',CR"
		    CASE 4: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Pan:Right PanSpeed:1',CR"
		    CASE 5: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Zoom:In ZoomSpeed:12',CR"
		    CASE 6: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Zoom:Out ZoomSpeed:12',CR"
		}
	    }
	    ACTIVE ( nCameraSelect == CAMERA_REAR) :
	    {
		SWITCH (nCamIdx)
		{
		    CASE 1: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Tilt:Up TiltSpeed:1',CR"
		    CASE 2: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Tilt:Down TiltSpeed:1',CR"
		    CASE 3: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Pan:Left PanSpeed:1',CR"
		    CASE 4: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Pan:Right PanSpeed:1',CR"
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
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Tilt:Stop',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Tilt:Stop',CR"
	    }
	    CASE 3:
	    CASE 4: //Stop Tilt
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Pan:Stop',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Pan:Stop',CR"
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
		    
		    CASE 6 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:1 CameraId:1 ListPosition:1 Name:Preset1 DefaultPosition:True',CR"
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
		    
		    CASE 6 : SEND_STRING dvCodec,"'xCommand Camera Preset Store PresetId:6 CameraId:2 ListPosition:6 Name:Preset6 DefaultPosition:True',CR"
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
//	    {
//		WAIT 10 SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
//	    }
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
	    CASE 1: fnCallCommands('ACCEPT')
	    CASE 2: fnCallCommands('HANGUP')
	    CASE 3: fnCallCommands('IGNORE')
	    CASE 4: fnCallCommands('REJECT')
	    CASE 5: fnCallCommands('SLEEP')
	    CASE 6: fnCallCommands('WAKE')
	    
	    //Disturb Sign..
	    CASE 7: fnDisturbOrNot(SET_OFF)
	    CASE 8: fnDisturbOrNot(SET_ON)

	    //Presentation
	    CASE 9: fnPresentation('START')
	    CASE 10: 
	    {
		fnPresentation('STOP')
		fnDGXSwitchIn(INPUT_SX80_MAIN,OUTPUT_MON_LEFT)
		fnDGXSwitchIn(INPUT_SX80_EXT,OUTPUT_MON_RIGHT)
	    }
	    CASE 11 : 
	    {
		IF (nSelfView == IS_OFF)
		{
		    fnSelfViewMode(SET_ON)
		}
		ELSE
		{
		    fnSelfViewMode(SET_OFF)
		}
	    }
	    CASE 12 : fnPIPCycle(nPIPCounter)

	    //Mic Mute
	    CASE 13:
	    {
		IF (nVTC_Mic_Mute == IS_OFF)
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
BUTTON_EVENT [vdvTP_Codec, 1500] //keyboard Lectern..
{
    PUSH :
    {	
	//SEND_COMMAND dvTP, "'@AKB'" //Call System Keyboard...
	SEND_COMMAND dvTP, "'PPON-_Keyboard'"
    }
}
BUTTON_EVENT [vdvTP_Codec, nPhonenav]
{
    PUSH :
    {
	STACK_VAR INTEGER nDirectory
	
	nDirectory = GET_LAST (nPhonenav)
	SWITCH (nDirectory)
	{
	    CASE 1: //ATL Enpoints
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = ATL_END  
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"		
		
	    }
	    CASE 2:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = SAV_END
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:14 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"
	    }
	    CASE 3:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = GTL_END 
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:28 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"	                          
	    }
	    CASE 4:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = GT_END
		ON [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:42 FolderId:',cFolderGT,' Limit:',ITOA(nListCount),CR"
	    }
	    CASE 5:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = BLUE_JEANS 
		OFF [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0 FolderId:',cFolderBlueJeans,' Limit:',ITOA(nListCount),CR" 
	    }
	    CASE 6:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		OFF [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Local Offset: 0',CR" //Search Local
		nPage = LOCAL_DIR
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
BUTTON_EVENT [vdvTP_Codec, 210] //Dialing from PhoneBook...
{
    PUSH :
    {
	SEND_COMMAND vdvTP_Codec, "'@PPK-VTC_Contacts'"
	TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
	WAIT 10
	{
	    SEND_COMMAND vdvTP_Codec, "'@PPG-VTC_Dialer'"
	    SEND_STRING dvCodec, "'xCommand Dial Number:',dialNumber,CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, POWER]
{
    PUSH :
    {
	IF (!sPowerStatus)
	{
	    fnCallCommands('WAKE')
	}
	ELSE
	{
	    fnCallCommands('SLEEP')
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
	
DEFINE_EVENT
DATA_EVENT[dvTP.NUMBER:1:0] 
DATA_EVENT[dvTP2.NUMBER:1:0] 
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
	CHAR sTmp[40]
	sTmp = DATA.TEXT
	
	IF (FIND_STRING(sTmp, 'KEYB-ABORT',1))
	{
	    // Do  nothing
	}
	ELSE IF (find_string(sTmp, 'KEYB-', 1))
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
	SEND_COMMAND DATA.DEVICE, 'SET BAUD 115200,N,8,1 485 DISABLED'
	SEND_COMMAND DATA.DEVICE, 'HSOFF'
	SEND_COMMAND DATA.DEVICE, 'RXON'
	SEND_COMMAND DATA.DEVICE, 'XOFF'
	// echo on $OD
	
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
TIMELINE_EVENT [TL_RECALL]
{
    WAIT 10 SEND_STRING dvCodec, "'xFeedback register /Event/IncomingCallIndication',CR"
    WAIT 20 SEND_STRING dvCodec, "'xFeedback register /Event/OutgoingCallIndication',CR"
    WAIT 30 SEND_STRING dvCodec, "'xFeedback register /Event/Standby',CR"
    WAIT 40 SEND_STRING dvCodec, "'xFeedback register /Status/Call',CR"
    WAIT 50 SEND_STRING dvCodec, "'xFeedback register /Event/CallDisconnect',CR"
    WAIT 60 SEND_STRING dvCodec, "'xFeedback register /Status/Camera',CR"
    
}
TIMELINE_EVENT [TL_FEEDBACK]
{
    [vdvTP_Codec, 255] = sPowerStatus
    
    [vdvTP_Codec, 106] = !nDisturb
    [vdvTP_Codec, 107] = nDisturb
    
    [vdvTP_Codec, 109] = nPresentation
                  
    [vdvTP_Codec, 201] = nPage = ATL_END
    [vdvTP_Codec, 202] = nPage = SAV_END
    [vdvTP_Codec, 203] = nPage = GTL_END
    [vdvTP_Codec, 204] = nPage = GT_END
    [vdvTP_Codec, 205] = nPage = BLUE_JEANS
     [vdvTP_Codec, 206] = nPage = LOCAL_DIR

    [vdvTP_Codec, 110] = nSelfView
    [vdvTP_Codec, 113] = nVTC_Mic_Mute
    
    [vdvTP_Codec, 41] = nCameraSelect = CAMERA_FRONT
    [vdvTP_Codec, 42] = nCameraSelect = CAMERA_REAR
    
    WAIT 300
    {
	SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
    }

}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

