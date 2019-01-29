PROGRAM_NAME='Codec_C40_Update'
(***********************************************************)
(*  FILE CREATED ON: 04/07/2017  AT: 11:08:05              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/22/2018  AT: 15:17:33        *)
(***********************************************************)


(*
    SEND_STRING dvCodec, "'xConfiguration Audio Input Line 1 Level: 10'" //0-24 dB
    SEND_STRING dvCodec, "'xConfiguration Audio Input Line 2 Level: 10'" //0-24 dB
*)

DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Codec
dvTP_Codec =				10001:2:0
#END_IF

#IF_NOT_DEFINED dvCodec
dvCodec =					5001:6:0
#END_IF



(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


INTEGER MAX_TEXT_LENGTH 	= 100
TXT_CALLID				= 2001
TXT_MYSIP					= 50
TXT_STATE				= 20
TXT_CALLTYPE				= 2004
TXT_DIAL					= 19
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

CAMERA_PRESET_1			= 1
CAMERA_PRESET_2			= 2
CAMERA_PRESET_3			= 3
CAMERA_PRESET_4			= 4
CAMERA_PRESET_5			= 5

SET_ON					= 'On'
SET_OFF					= 'Off'

MIC_MUTE_ON				= 'Mute'
MIC_MUTE_OFF				= 'UnMute'

//Phone Book Directories
ATL_END					= 1
SAV_END					= 2
GTL_END					= 3
GT_END					= 4
BLUE_JEANS				= 5
LOCAL_DIR					= 6
LOCAL_DIR2				= 7

TL_CODEC					= 4


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Codec [] = {dvTP_Codec}

//CHAR nVTCsip[30] = 'OIT.RICH.242'

//Phone Book Directories..
CHAR nAtlEnd[10] = 'PAGE 1'
CHAR nSavEnd[10] = 'PAGE 2'
CHAR nGtlEnd[10] = 'PAGE 3'
CHAR nGtEnd[10] = 'PAGE 4'
CHAR nBjn[10] = 'Test Sites'
CHAR nLocalSearch[10] = 'Local'
CHAR nLocalNext[10] = 'Local'

//Place Caller ID
CHAR cNameReturn[30] =''
CHAR cSecondaryReturn[35] ='' //GT Book Return
CHAR cPrimaryReturn[35] = '' //Blue Jeans + Local Return

VOLATILE INTEGER nC40Online
VOLATILE LONG lTlCodecFeedback[] = {250}
VOLATILE CHAR cC40Buffer[500]

VOLATILE INTEGER nJustBooted

NON_VOLATILE INTEGER nCameraSelect //Front or Rear Tracking
VOLATILE INTEGER nCameraPreset //Preset Track
VOLATILE INTEGER nDisturb
VOLATILE INTEGER nPresentation //Send Presentation on/off
VOLATILE INTEGER nVolumeOutput = 80
VOLATILE INTEGER nLayoutCounter //Layout Counter
VOLATILE INTEGER nPIPCounter //Pip Layout
VOLATILE INTEGER nSelfView

VOLATILE INTEGER nVTC_Mic_Mute
VOLATILE CHAR dialNumber[MAX_TEXT_LENGTH]

//PhoneBook Stuff
VOLATILE INTEGER nPage //Phonebook Page
VOLATILE INTEGER nListCount = 14 //How many list items are we displaying?? 10 is Temp
VOLATILE CHAR sEntriesFound[3] = '' //How many directories?
CHAR cFolderGT[4] =''
CHAR cFolderTest[4] =''
CHAR cFolderBlueJeans[4] =''
VOLATILE INTEGER cDialGTBook //Am I using the GT phonebook or naw??

VOLATILE INTEGER nCallInProgress //??
VOLATILE INTEGER sPowerStatus

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
VOLATILE CHAR nLayoutNames[][25] =
{
    'equal',
    'fullscreen',
    'presentationlargespeaker',
    'presentationsmallspeaker',
    'prominent',
    'single',
    'speaker_full'
}
VOLATILE INTEGER nControlBtns[] =
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
    
    110, //Selfview On/Off
    111, //PIP cycle
    112, //Layout View
     
    113, //Mute Microphone  
    117  //Homebutton Key
}
VOLATILE INTEGER nCameraControls[] =
{
    //Camera
    51, //Pan Left
    52, //Pan Right
    
    53, //Tilt Up
    54, //Tilt Down
    55, //Zoom In
    56  //Zoom Out
}
VOLATILE INTEGER nPresetBtns[] =
{
    //Recall Presets...
    61,62,63,64,65,

    //Save Presets...
    71,72,73,74,75
}
VOLATILE INTEGER nPhonenav[] =
{
    //Contact Page Flips...
    201,
    202,
    203,
    204,
    205,
    206, //Local Page 1
    207  //Local Page 2 - has more addresses
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
DEFINE_FUNCTION fnPresentation(CHAR cFunction[9])
{
    SWITCH (cFunction)
    {
	CASE 'START' :
	{
	    SEND_STRING dvCodec, "'xCommand Presentation Start SendingMode:LocalRemote',CR"
	}
	CASE 'STOP' :
	{
	    SEND_STRING dvCodec, "'xCommand Presentation Stop',CR"
	}
    }
}
DEFINE_FUNCTION fnDisturbOrNot(CHAR cState[3])
{
    SEND_STRING dvCodec, "'xConfiguration Conference 1 DoNOtDisturb Mode:',cState,CR"
}
DEFINE_FUNCTION fnSelfViewMode(CHAR cScreen[3])
{
    SWITCH (cScreen)
    {
	CASE 'ON' :
	{
	    SEND_STRING dvCodec, "'xCommand Video Selfview Set Mode: On',CR"
	    WAIT 20
	    {
		SEND_STRING dvCodec, "'xStatus Video Selfview',CR"
	    }
	    
	}
	CASE 'OFF' :
	{
	    SEND_STRING dvCodec, "'xCommand Video Selfview Set Mode: Off',CR"
	    WAIT 20
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
	CASE 1:
	CASE 2:
	CASE 3:
	CASE 4:
	CASE 5:
	CASE 6:
	{
	    SEND_STRING dvCodec, "'xConfiguration Video SelfviewPosition: ',cPIP_Names[nPIPCounter],CR" //Updated for version 7.3.12
	}
	CASE 7:
	{
	    IF (nPIPCounter > 6 )
	    {
		nPIPCounter = 0
	    }
	}
    }
}
DEFINE_FUNCTION fnLayoutSet(nLayoutCounter)
{
    nLayoutCounter++
    
    SWITCH (nLayoutCounter)
    {
	CASE 1:
	CASE 2:
	CASE 3:
	CASE 4:
	CASE 5:
	CASE 6:
	CASE 7:
	{
	    SEND_STRING dvCodec, "'xCommand Video PictureLayoutSet Target: Local LayoutFamily:',nLayoutNames[nLayoutCounter],CR"
	}
	CASE 8:
	{
	    IF (nLayoutCounter > 7)
	    {
		nLayoutCounter = 0
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
	    SEND_STRING dvCodec, "'xCommand Call DisconnectAll',CR"
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
DEFINE_FUNCTION fnCameraSelect(INTEGER cCamera)
{
    SEND_STRING dvCodec, "'xConfiguration Video MainVideoSource: ',ITOA(cCamera),CR"
    //WAIT 10
    //{
	//SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR"
    //}
}
DEFINE_FUNCTION fnMicrophoneMute(CHAR cMuteState[6])
{
    SEND_STRING dvCodec, "'xCommand Audio Microphones ',cMuteState,CR"
}
DEFINE_FUNCTION fnSetVolumeOut(INTEGER cValueOut)
{
    SEND_STRING dvCodec, "'xCommand Audio Volume Set Level:',ITOA(cValueOut),CR"
}
DEFINE_FUNCTION addToDialNumber(CHAR cNumber[])
{
    IF (LENGTH_STRING(dialNumber) < MAX_TEXT_LENGTH)
    {
	dialNumber = "dialNumber,cNumber"
	SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
    }
}
DEFINE_FUNCTION fnSetVolumeOutput()
{
    SEND_STRING dvCodec, "'xCommand Audio Volume Set Level:',ITOA(nVolumeOutput),CR"
}
DEFINE_FUNCTION fnParsec40Codec()
{
    STACK_VAR CHAR cResponse[500] CHAR cTrash[500]
    LOCAL_VAR CHAR sCallerId[20] //Only displays URI
    LOCAL_VAR CHAR sCallBackNumber[30] //gives actual dialing sip
    LOCAL_VAR CHAR sCallType[15] //Video type??
    LOCAL_VAR CHAR sURI[20] 
    STACK_VAR INTEGER cCount //Used for Phonebook
    
    WHILE(FIND_STRING(cC40Buffer,"CR,LF",1))
    {
	cResponse = REMOVE_STRING(cC40Buffer,"CR,LF",1)
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cResponse,'*r ResultSet Folder 1 FolderId: "',1)):
	    {
		REMOVE_STRING(cResponse,'*r ResultSet Folder 1 FolderId: "',1)
		cFolderGT = cResponse //Example left...c_1"
		cFolderGT = LEFT_STRING(cFolderGT,LENGTH_STRING(cFolderGT)-1) //Should have c_1
		
	    }
	    ACTIVE(FIND_STRING(cResponse,'*r ResultSet Folder 2 FolderId: "',1)):
	    {
		REMOVE_STRING(cResponse,'*r ResultSet Folder 2 FolderId: "',1)
		cFolderBlueJeans = cResponse //Example left...c_1"
		cFolderBlueJeans = LEFT_STRING(cFolderBlueJeans,LENGTH_STRING(cFolderBlueJeans)-1) //Should have c_19
	    }
	    ACTIVE(FIND_STRING(cResponse,'*r ResultSet ResultInfo TotalRows:',1)):
	    {
		REMOVE_STRING(cResponse,'*r ResultSet ResultInfo TotalRows:',1)
		
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,',cResponse,' Entrie(s) Found'"  
	    }
	    ACTIVE(FIND_STRING(cResponse,'*r ResultSet Contact',1)):
	    {
		//Get Name...
		REMOVE_STRING(cResponse,'*r ResultSet Contact',1)
		
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
	    ACTIVE (FIND_STRING (cResponse,'*s Video Selfview Mode: On',1)):
	    {
		nSelfView = IS_ON
	    }
	    ACTIVE (FIND_STRING (cResponse,'*s Video Selfview Mode: Off',1)):
	    {
		nSelfView = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Video Input MainVideoSource: 1'",1)):
	    {
		nCameraSelect = CAMERA_FRONT
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Video Input MainVideoSource: 2'",1)):
	    {
		nCameraSelect = CAMERA_REAR
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Conference DoNotDisturb: Inactive'",1)):
	    {
		nDisturb = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Conference DoNotDisturb: Active'",1)):
	    {
		nDisturb = IS_ON
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Conference Presentation Mode: Off'",1)):
	    {
		nPresentation = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Conference Presentation Mode: On'",1)):
	    {
		nPresentation = IS_ON
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Conference Presentation Mode: Sending'",1)):
	    {
		nPresentation = IS_ON
	    }
	    //Display Incoming Caller Name...
	    ACTIVE(FIND_STRING(cResponse,'DisplayName: "',1)):
	    {

		REMOVE_STRING(cResponse,'DisplayName: "',1)
		sCallerId = cResponse
		SET_LENGTH_STRING (sCallerId,LENGTH_STRING(sCallerId) -1); //Remove Last Quote
	    
		SEND_COMMAND vdvTP_Codec, "'^TXT-22,0,',sCallerId" 
	    }
	    ACTIVE(FIND_STRING(cResponse,'RemoteNumber: "',1)):
	    {
		REMOVE_STRING (cResponse,'RemoteNumber: "',1)
		sCallBackNumber = cResponse
		SET_LENGTH_STRING (sCallBackNumber,LENGTH_STRING(sCallBackNumber) -3)
		
		SEND_COMMAND vdvTP_Codec, "'^TXT-21,0,',sCallBackNumber"
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Audio Microphones Mute: Off'",1)):
	    {
		nVTC_Mic_Mute = IS_OFF
	    }
	    ACTIVE(FIND_STRING(cResponse,"'*s Audio Microphones Mute: On'",1)):
	    {
		nVTC_Mic_Mute = IS_ON
	    }
	    //Call feedback
	    //ACTIVE(FIND_STRING(cResponse,"'*s Call ',ITOA(cRemoteID),' Status:'",1)): //Dialing...
	    ACTIVE(FIND_STRING(cResponse,'Status: ',1)):
	    {
		REMOVE_STRING(cResponse,'Status: ',1)
		
		IF (FIND_STRING(cResponse,'Dialing',1))
		{
		    nCallInProgress = IS_ON
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Dialing..'"
		}
		IF (FIND_STRING(cResponse,'Connecting',1))
		{
		    nCallInProgress = IS_ON
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connecting'"
		}
		IF (FIND_STRING(cResponse,'Connected',1))
		{
		    nCallInProgress = IS_ON
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected!'"
		}
		IF (FIND_STRING(cResponse,'Ringing',1))
		{
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ringing!'"
		    SEND_COMMAND vdvTP_Codec, "'PPON-_incomingcall'" //Show popup...
		}
	    }
	    //Remote Caller Hung Up!
	    ACTIVE(FIND_STRING(cResponse,"'*e CallDisconnect CauseValue:'",1)): //Disconnected
	    {
		nCallInProgress = IS_OFF
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected!'"
		sCallerId =''
		SEND_COMMAND vdvTP_Codec, "'^TXT-22,0,',sCallerId"
	    }
	    //Local Hung up!!
	    ACTIVE(FIND_STRING(cResponse,"'xCommand Call DisconnectAll'",1)): //Disconnected Locally
	    {
		nCallInProgress = IS_OFF
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected!'"
		sCallerId =''
		SEND_COMMAND vdvTP_Codec, "'^TXT-22,0,',sCallerId"
	    }
	    
	    ACTIVE(FIND_STRING(cResponse,'*s Standby Active: ',1)): //Alive!!
	    {
		REMOVE_STRING(cResponse,'*s Standby Active: ',1)
		
		IF (FIND_STRING(cResponse,'Off',1))
		{
		    //I am awake now
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ready'"
		    ON [sPowerStatus]
		}
		IF (FIND_STRING(cResponse,'On',1)) //Sleep
		{
		    //I just went into stand by...
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,StandBy'"
		    OFF [sPowerStatus]
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'CallType: ',1)):
	    {
		REMOVE_STRING(cResponse,'CallType: ',1)
		sCallType = cResponse	//Should be left with Video / Audio etc.	
		SEND_COMMAND vdvTP_Codec, "'^TXT-18,0,',sCallType"
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SystemUnit State System: ',1)):
	    {
		REMOVE_STRING (cResponse,'*s SystemUnit State System: ',1)
		
		IF (FIND_STRING(cResponse,'Initialized',1))
		{
		    nCallInProgress = IS_OFF
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		}
		IF (FIND_STRING(cResponse,'InCall',1))
		{
		    nCallInProgress = IS_ON
		    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected!'"
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s SIP Registration 1 URI: "',1)): //Parse URI 
	    {
		REMOVE_STRING (cResponse,'*s SIP Registration 1 URI: "',1)
		sURI = cResponse
		SET_LENGTH_STRING (sURI,LENGTH_STRING(sURI) -1);

		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_MYSIP),',0,',sURI"
	    }
	}
    }
}
DEFINE_FUNCTION fnPollCodec()
{
    WAIT 10 SEND_STRING dvCodec, "'xStatus Conference DoNotDisturb',CR"
    WAIT 25 SEND_STRING dvCodec, "'xStatus Conference Presentation Mode',CR"
    WAIT 40 SEND_STRING dvCodec, "'xStatus Audio Microphones Mute',CR"
    //WAIT 55 SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR" //Which Camera Connected?
    
    WAIT 70 SEND_STRING dvCodec, "'xStatus Standby Active',CR" //Sleep or Naw...
    WAIT 90 SEND_STRING dvCodec, "'xStatus SystemUnit State System',CR" //InCall? 
    
	//SEND_STRING dvCodec, "'xStatus Call',$0D" //Query on going call
    WAIT 110 SEND_STRING dvCodec, "'xStatus SIP Registration URI',CR" //Get My URI
    WAIT 140 fnSetVolumeOutput()
    WAIT 150 SEND_STRING dvCodec, "'xStatus Video Selfview',CR"
    WAIT 170 SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Corporate Offset:0',CR" //Get Phonebook Folders...
}
DEFINE_FUNCTION fnDirectoryNav()
{
    SEND_COMMAND vdvTP_Codec, "'^TXT-201,0,',nAtlEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-202,0,',nSavEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-203,0,',nGtlEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-204,0,',nGtEnd"
    SEND_COMMAND vdvTP_Codec, "'^TXT-205,0,',nBjn"
    SEND_COMMAND vdvTP_Codec, "'^TXT-206,0,',nLocalSearch"
    SEND_COMMAND vdvTP_Codec, "'^TXT-207,0,',nLocalNext"
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
    WAIT 60 SEND_STRING dvCodec, "'xFeedback register /Status/Standby/Active',CR"
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
CREATE_BUFFER dvCodec,cC40Buffer;


TIMELINE_CREATE(TL_CODEC,lTlCodecFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

WAIT 150
{
    OFF [nJustBooted]
}

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Codec, 1] //0
BUTTON_EVENT [vdvTP_Codec, 2] //1
BUTTON_EVENT [vdvTP_Codec, 3] //2
BUTTON_EVENT [vdvTP_Codec, 4] //3
BUTTON_EVENT [vdvTP_Codec, 5] //4
BUTTON_EVENT [vdvTP_Codec, 6] //5
BUTTON_EVENT [vdvTP_Codec, 7] //6
BUTTON_EVENT [vdvTP_Codec, 8] //7
BUTTON_EVENT [vdvTP_Codec, 9] //8
BUTTON_EVENT [vdvTP_Codec, 10] //9
BUTTON_EVENT [vdvTP_Codec, 11] // . 
BUTTON_EVENT [vdvTP_Codec, 12] //Bksps
BUTTON_EVENT [vdvTP_Codec, 13] //Clear
BUTTON_EVENT [vdvTP_Codec, 14] //Dial
BUTTON_EVENT [vdvTP_Codec, 15] //DTMF -*
BUTTON_EVENT [vdvTP_Codec, 16] //DTMF -#
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
		
		IF (nCallInProgress = IS_ON)
		{	
		    SEND_STRING dvCodec, "'xCommand DTMFSend CallId:0 DTMFString:',ITOA(BUTTON.INPUT.CHANNEL -1),CR"
		}
		ELSE
		{
		    addToDialNumber(ITOA(BUTTON.INPUT.CHANNEL -1))
		}
	    }
	    CASE 11: //Send (DOT!)
	    {
		addToDialNumber('.')
	    }
            CASE 12: //BackSpace...
	    {
		IF (LENGTH_STRING(dialNumber))
		{
		    SET_LENGTH_STRING(dialNumber,LENGTH_STRING(dialNumber) -1);
		    SEND_COMMAND vdvTP_Codec,  "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
		}
	    }
	    CASE 13: //Clear All...
	     {
                dialNumber = ''
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
		}
	    CASE 14: //Dial...
	    {
		SEND_STRING dvCodec, "'xCommand Dial Number:',dialNumber,CR"
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
	    }
	    CASE 15: //DTMF *
	    {
		SEND_STRING dvCodec, "'xCommand DTMFSend CallId:0 DTMFString:*',CR"
	    }
	    CASE 16: //DTMF #
	    {
		SEND_STRING dvCodec, "'xCommand DTMFSend CallId:0 DTMFString:#',CR"
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
		fnCameraSelect(CAMERA_FRONT) //Call Main Camera Source for both cameras!
		nCameraSelect = CAMERA_FRONT
	    }
	    CASE 42: 
	    {
		fnCameraSelect(CAMERA_FRONT) //Call Main Camera Source - splitting from DVX!!
		nCameraSelect = CAMERA_REAR
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nCameraControls]
{
    PUSH :
    {
	STACK_VAR INTEGER nCamIdx
	//OFF [nCameraPreset]
	
	nCamIdx = GET_LAST(nCameraControls)
	
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
		    CASE 5: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Zoom:In ZoomSpeed:12',CR"
		    CASE 6: SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Zoom:Out ZoomSpeed:12',CR"
		}
	    }
	}
    }
    RELEASE :
    {
	STACK_VAR INTEGER nCamIdx
	//OFF [nCameraPreset]
	
	nCamIdx = GET_LAST(nCameraControls)
	SWITCH (nCamIdx)
	{
	    CASE 1:
	    CASE 2: //Stop Panning
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Pan:Stop PanSpeed:1',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Pan:Stop PanSpeed:1',CR"
	    }
	    CASE 3:
	    CASE 4: //Stop Tilt
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Tilt:Stop TiltSpeed:1',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Tilt:Stop TiltSpeed:1',CR"
	    }
	    CASE 5:
	    CASE 6: //Stop Zoom
	    {
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:1 Zoom:Stop ZoomSpeed:12',CR"
		SEND_STRING dvCodec, "'xCommand Camera Ramp CameraId:2 Zoom:Stop ZoomSpeed:12',CR"
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nPresetBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nPresetIdx
	
	nPresetIdx = GET_LAST (nPresetBtns)
	SWITCH (nPresetIdx)
	{
	    //Recall
		    CASE 1: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 1',CR"
		    CASE 2: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 2',CR"
		    CASE 3: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 3',CR"
		    CASE 4: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 4',CR"
		    CASE 5: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 5',CR"
		                                                          
		    //Save Presets...
		    CASE 6: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 5',CR"
		    CASE 7: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 5',CR"
		    CASE 8: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 5',CR"
		    CASE 9: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 5',CR"
		    CASE 10: SEND_STRING dvCodec, "'xCommand Preset Activate PresetId: 5',CR"
	}
    }
}
BUTTON_EVENT [vdvTP_Codec, nControlBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nControlIdx
	
	nControlIdx = GET_LAST (nControlBtns)
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
	    CASE 10: fnPresentation('STOP')
	    
	    //Screen Mode...
	    CASE 11: 
	    {
		IF (nSelfView == IS_OFF)
		{
		    fnSelfViewMode('ON')
		}
		ELSE
		{
		    fnSelfViewMode('OFF')
		}
	    }
	    CASE 12: fnPIPCycle(nPIPCounter)
	    CASE 13: fnLayoutSet(nLayoutCounter)
	    
	    //Mic Mute
	    CASE 14: 
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
	    CASE 15: SEND_STRING dvCodec, "'xCommand Key Click Key:Home',CR"
	}
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
	    CASE 7:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		OFF [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Local Offset: 14',CR" //Search Local
		nPage = LOCAL_DIR2
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
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[1]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[1]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 301]
		    }
		    CASE 2:
		    {
			
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[2]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[2]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 302]
		    }
		    CASE 3:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[3]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[3]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 303]
		    }
		    CASE 4:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[4]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[4]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 304]
		    }
		    CASE 5:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[5]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[5]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 305]
		    }
		    CASE 6:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[6]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[6]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 306]
		    }
		    CASE 7:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[7]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[7]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 307]
		    }
		    CASE 8:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[8]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[8]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 308]
		    }
		    CASE 9:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[9]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[9]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 309]
		    }
		    CASE 10:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[10]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[10]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 310]
		    }
		    CASE 11:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[11]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[11]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 311]
		    }
		    CASE 12:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[12]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[12]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 312]
		    }
		    CASE 13:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[13]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[13]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 313]
		    }
		    CASE 14:
		    {
			IF (cDialGTBook == IS_ON)
			{
			    dialNumber = cSlot_Secondary[14]
			}
			ELSE
			{
			    dialNumber = cSlot_Primary[14]
			}
			send_command vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
			ON [vdvTP_Codec, 314]
		    }
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
BUTTON_EVENT [vdvTP_Codec, 210] //Dial from Contact List...
{
    PUSH :
    {
	TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
	SEND_COMMAND vdvTP_Codec, "'PPOF-VTC_Contacts'"
	WAIT 10
	{
	    SEND_COMMAND vdvTP_Codec, "'@PPG-VTC_Dialer'"
	    //send_command vdvTP_Codec,"'^TXT-19,0,',dialNumber"
	    SEND_STRING dvCodec, "'xCommand Dial Number:',dialNumber,CR"
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
DATA_EVENT [dvCodec]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 38400,N,8,1 485 DISABLED'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"

	ON [nC40Online]
	WAIT 80
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
	OFF [nC40Online]
    }
    STRING :
    {
	fnParsec40Codec()
    }
}
DATA_EVENT [dvTP_Codec.NUMBER:1:0] //Parse from TP
{
    ONLINE :
    {
	fnDirectoryNav()
	
	IF (nJustBooted == IS_OFF)
	{
	    fnUpdateList()
	    fnPollCodec()
	}
	
    }
    STRING :
    {
	CHAR sTmp[40]
	
	sTmp = DATA.TEXT
	IF (FIND_STRING(sTmp,'KEYB-ABORT',1))
	{
	    //Do Nothing
	}
	ELSE IF (FIND_STRING(sTmp,'KEYB-',1))
	{
	    REMOVE_STRING(sTmp,'-',1)
	    dialNumber = sTmp 
	    SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
	}
    }
}

TIMELINE_EVENT [TL_CODEC]
{
    [vdvTP_Codec, POWER] = sPowerStatus
    
    [vdvTP_Codec, 106] = !nDisturb
    [vdvTP_Codec, 107] = nDisturb
    
    [vdvTP_Codec, 109] = !nPresentation
    
    [vdvTP_Codec, 201] = nPage = ATL_END
    [vdvTP_Codec, 202] = nPage = SAV_END
    [vdvTP_Codec, 203] = nPage = GTL_END
    [vdvTP_Codec, 204] = nPage = GT_END
    [vdvTP_Codec, 205] = nPage = BLUE_JEANS
     [vdvTP_Codec, 206] = nPage = LOCAL_DIR
     [vdvTP_Codec, 207] = nPage = LOCAL_DIR2
    
    [vdvTP_Codec, 113] = nVTC_Mic_Mute
    [vdvTP_Codec, 110] = nSelfView
    
    [vdvTP_Codec, 41] = nCameraSelect = CAMERA_FRONT
    [vdvTP_Codec, 42] = nCameraSelect = CAMERA_REAR
}


DEFINE_EVENT







