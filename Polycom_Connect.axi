PROGRAM_NAME='MySX80'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/28/2018  AT: 11:22:39        *)
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
dvCodec =					5001:4:0
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

DO_NOT_DISTURB			= 'donotdisturb'
DO_DISTURB				= 'no'


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
VOLATILE LONG lTlCodecReCheck[] = {105000} //1:45 
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
VOLATILE INtEGER cCount 
VOLATILE CHAR sEntriesFound[3] = '' //How many directories?
CHAR cFolderGT[4] =''
CHAR cFolderTest[4] =''
CHAR cFolderBlueJeans[4] =''
VOLATILE INTEGER cDialGTBook //Am I using the GT phonebook or naw??

VOLATILE CHAR dialNumber[MAX_TEXT_LENGTH]  // stores the number being dialed

VOLATILE CHAR cSlot_Secondary[14][35] = {'','','','','','','','','','','','','',''} //Hold GT Numbers...
VOLATILE CHAR cSlot_Primary[14][35] = {'','','','','','','','','','','','','',''} //Hold GT Numbers...

VOLATILE CHAR cSlot_Page1[14][35] =
{
    '811marietta201', //1
    '811marietta201a', //2
    'ELAB_21', //3
    'PARB126',//4
    'PARB257', //5
    'carnegie105', //6
    'ccb153', //7
    'cob316', //8
    'cob317', //9
    'consulting129', //10
    'culc.248',//11
    'culc.250', //12
    'culc144',//13
    'ebb1005' //14
}
VOLATILE CHAR cSlot_Page2[14][35] =
{
    'edi419', //1
    'edi420', //2
    'erp107', //3
    'erptraining',//4
    'PARB257', //5
    'glc124', //6
    'glc317', //7
    'glc421', //8
    'glc431', //9
    'glc438', //10
    'gtaps102',//11
    'ibb1128', //12
    'inta.habersham.G17',//13
    'klaus1205' //14
}
VOLATILE CHAR cSlot_Page3[14][35] =
{
    'parb257c40', //1
    'parb261', //2
    'pe.parb.245', //3
    'rich140b',//4
    'rich140test', //5
    'rich209', //6
    'rich213', //7
    'rich219', //8
    'rich223', //9
    'rich242', //10
    'skiles005',//11
    'tep104', //12
    'parb119',//13
    'parb120' //14
}
VOLATILE CHAR cSlot_Page4[14][35] =
{
    'parb257c40', //1
    'parb261', //2
    'pe.parb.245', //3
    'rich140b',//4
    'rich140test', //5
    'rich209', //6
    'rich213', //7
    'rich219', //8
    'rich223', //9
    'rich242', //10
    'skiles005',//11
    'tep104', //12
    'tep208',//13
    'uaw1103' //14
}
VOLATILE CHAR cSlot_BlueJeans[14][35]=
{
    'SIP:meet@sip.bjn.vc',
    'SIP:111@sip.bjn.vc',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
}
VOLATILE CHAR cPIP_Names[][16] =
{
    '0',
    '1',
    '2',
    '3'
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
    SEND_STRING dvCodec, "'pip ',cView,CR"
    WAIT 10
    {
	SEND_STRING dvCodec, "'pip get',CR"
    }
}
DEFINE_FUNCTION fnPresentation(CHAR cPresentation[9])
{
    SWITCH (cPresentation)
    {
	CASE 'START' :
	{
	    SEND_STRING dvCodec, "'vcbutton play 4',CR"
	}
	CASE 'STOP' :
	{
	    SEND_STRING dvCodec, "'vcbutton stop',CR"
	}
    }
}
DEFINE_FUNCTION fnDisturbOrNot(CHAR cState[15])
{
    SEND_STRING dvCodec, "'mpautoanswer ',cState,CR"
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
	{
	    SEND_STRING dvCodec, "'pip location ',cPIP_Names[nPIPCounter],CR"
	}
	CASE 5 :
	{
	    IF (nPIPCounter > 4 )
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
	    SEND_STRING dvCodec, "'answer video',CR"
	    SEND_COMMAND vdvTP_Codec, "'PPOF-_incomingcall'"
	    WAIT 10
	    {
		SEND_COMMAND vdvTP_Codec, "'PAGE-Conference'"
		WAIT 10
		{
		    SEND_COMMAND vdvTP_Codec, "'PPON-VTC_Dialer'"
		    SEND_STRING dvCodec, "'callinfo all',CR" //InCall?
		}
	    }
	}
	CASE 'HANGUP' :
	{
	    SEND_STRING dvCodec, "'hangup all',CR"
	    //SEND_STRING dvCodec, "'xCommand Call DisconnectAll',$0D"
	}
	CASE 'SLEEP' :
	{
	    SEND_STRING dvCodec, "'sleep register',CR"
	}
	CASE 'WAKE' :
	{
	    SEND_STRING dvCodec, "'wake',CR"
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
DEFINE_FUNCTION fnCameraSelect(INTEGER cCamera) //No Work with new Update 8/25/2018 (CR)
{
    SEND_STRING dvCodec, "'camera near ',ITOA(cCamera),CR"
}
DEFINE_FUNCTION fnSetVolumeOut()
{
    SEND_STRING dvCodec, "'xCommand Audio Volume Set Level: ',ITOA(nVolumeOutput),CR"
}
DEFINE_FUNCTION fnPollCodec()
{
    WAIT 10 SEND_STRING dvCodec, "'mpautoanswer get',CR"
    WAIT 20 SEND_STRING dvCodec, "'vcbutton get',CR" //Presentation Source??
    WAIT 30 SEND_STRING dvCodec, "'pip get ',CR"
    //WAIT 40 SEND_STRING dvCodec, "'xStatus Audio Microphones Mute',CR"
    //WAIT 55 SEND_STRING dvCodec, "'xStatus Video Input MainVideoSource',CR" //Which Camera Connected?
    
    //WAIT 70 SEND_STRING dvCodec, "'xStatus Standby',CR" //Sleep or Naw...
    WAIT 90 SEND_STRING dvCodec, "'getcallstate',CR" //InCall? 
    WAIT 110 SEND_STRING dvCodec, "'ipstat',CR" //Get My host name
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
	    ACTIVE (FIND_STRING(cResponse,'*vcbutton ',1)):
	    {
		cTrash = REMOVE_STRING(cResponse,'vcbutton ',1)
		
		IF (FIND_STRING(cResponse,'stop',1))
		{
		    OFF [nPresentation]
		}
		IF (FIND_STRING(cResponse,'play',1))
		{
		    ON [nPresentation]
		}
		cTrash = ''
	    }
	    ACTIVE (FIND_STRING(cResponse,'camera near 1',1)):
	    {
		nCameraSelect = CAMERA_FRONT
	    }
	    ACTIVE (FIND_STRING(cResponse,'*camera near 2',1)):
	    {
		nCameraSelect = CAMERA_REAR
	    }
	    ACTIVE (FIND_STRING(cResponse,'mpatuoanswer no',1)):
	    {
		OFF [nDisturb]
	    }
	    ACTIVE (FIND_STRING(cResponse,'mpautoanswer donotdisturb',1)):
	    {
		ON [nDisturb]
	    }
	    ACTIVE(FIND_STRING(cResponse,'pip is off',1)):
	    {
		OFF [nSelfView]
	    }
	    ACTIVE(FIND_STRING(cResponse,'pip is on',1)):
	    {
		ON [nSelfView]
	    }
	    ACTIVE(FIND_STRING(cResponse,'hostname',1)):
	    {
		REMOVE_STRING(cResponse,'hostname',1)
		sURI = cResponse
		
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_MYSIP),',0,',sURI"
	    }
	    ACTIVE(FIND_STRING(cResponse,'Far site disconnected.',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		OFF [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'hangup all',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		OFF [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'popupinfo: question: The far site is busy. Try the call again later',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Disconnected'"
		//Invalid Address...
		OFF [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'state[BONDING]',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connecting'"
		ON [nCallInProgress ]
	    }
	    ACTIVE(FIND_STRING(cResponse,'state[RINGING]',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connecting'"
		ON [nCallInProgress ]
	    }
	    ACTIVE(FIND_STRING(cResponse,'state[COMPLETE]',1)):
	    {
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Connected'"
		ON [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'*s Audio Microphones Mute: ',1)):
	    {
		cTrash = REMOVE_STRING(cResponse,'*s Audio Microphones Mute: ',1)
		
		IF (FIND_STRING(cResponse,'Off',1))
		{
		    OFF [nVTC_Mic_Mute]
		}
		IF (FIND_STRING(cResponse,'On',1))
		{
		    ON [nVTC_Mic_Mute]
		}
	    }
	    ACTIVE(FIND_STRING(cResponse,'*configchange: powerlight Amber*on*',1)):
	    {
		//Sleep
		OFF [sPowerStatus]
		OFF [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'listen going to sleep',1)):
	    {
		//Sleep
		OFF [sPowerStatus]
		OFF [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'configchange: powerlight Blue*on*',1)):
	    {
		ON [sPowerStatus]
	    }
	    ACTIVE(FIND_STRING(cResponse,'listen waking up',1)):
	    {
		ON [sPowerStatus]
				//SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ready'"
		//OFF [nCallInProgress]
	    }
	    ACTIVE(FIND_STRING(cResponse,'wake',1)):
	    {
		ON [sPowerStatus]
		SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(TXT_STATE),',0,Ready'"
		OFF [nCallInProgress]
	    }
	}
    }
}
DEFINE_FUNCTION fnRegisterFeedback()
{
    WAIT 10 SEND_STRING dvCodec, "'callstate register',CR"
    WAIT 20 SEND_STRING dvCodec, "'listen video',CR"
    WAIT 30 SEND_STRING dvCodec, "'listen sleep',CR"
    WAIT 40 SEND_STRING dvCodec, "'sleep register',CR"
    WAIT 50 SEND_STRING dvCodec, "'notify callstatus',CR"
    WAIT 60 SEND_STRING dvCodec, "'getcallstate',CR" //InCall? 
    //WAIT 60 SEND_STRING dvCodec, "'notify mutestatus',CR" //Audio
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
nCameraSelect = CAMERA_FRONT //default
TIMELINE_CREATE (TL_VTC,lTlCodecFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);

WAIT 600
{
    OFF [nJustBooted]
    TIMELINE_CREATE (TL_RECALL,lTlCodecReCheck,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
}


(***********************************************************)
(*                MODULE DEFINITIONS GO BELOW              *)
(***********************************************************)


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
		     SEND_STRING dvCodec, "'gendial ',ITOA(BUTTON.INPUT.CHANNEL -1),CR"
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
		//SEND_STRING dvCodec, "'dial manual dialstr ',dialNumber,CR"
		SEND_STRING dvCodec, "'dial manual 4096 ',dialNumber,CR"
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_DIAL),',0,',dialNumber"
	    }
	    CASE 15: //DTMF *
	    {
		SEND_STRING dvCodec, "'gendial *',CR"
	    }
	    CASE 16: //DTMF #
	    {
		SEND_STRING dvCodec, "'gendial #',CR"
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
		fnCameraSelect(CAMERA_FRONT)
	    }
	    CASE 42: 
	    {
		fnCameraSelect(CAMERA_REAR)
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
	
		SWITCH (nCamIdx)
		{
		    CASE 1: SEND_STRING dvCodec, "'camera near move up',CR"
		    CASE 2: SEND_STRING dvCodec, "'camera near move down',CR"
		    CASE 3: SEND_STRING dvCodec, "'camera near move left',CR"
		    CASE 4: SEND_STRING dvCodec, "'camera near move right',CR"
		    CASE 5: SEND_STRING dvCodec, "'camera near move zoom+',CR"
		    CASE 6: SEND_STRING dvCodec, "'camera near move zoom-',CR"
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
	    CASE 3:
	    CASE 4: //Stop Tilt
	    CASE 5:
	    CASE 6: //Stop Zoom
	    {
		SEND_STRING dvCodec, "'camera near move Stop',CR"

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
	

		SWITCH (nPresetIdx)
		{
		    CASE 1 : SEND_STRING dvCodec, "'preset near go 1',CR"
		    CASE 2 : SEND_STRING dvCodec, "'preset near go 2',CR"
		    CASE 3 : SEND_STRING dvCodec, "'preset near go 3',CR"
		    CASE 4 : SEND_STRING dvCodec, "'preset near go 4',CR"
		    CASE 5 : SEND_STRING dvCodec, "'preset near go 5',CR"
		    
		    CASE 6 : SEND_STRING dvCodec,"'preset near set 1',CR"
		    CASE 7 : SEND_STRING dvCodec,"'preset near set 2',CR"
		    CASE 8 : SEND_STRING dvCodec,"'preset near set 3',CR"
		    CASE 9 : SEND_STRING dvCodec,"'preset near set 4',CR"
		    CASE 10 : SEND_STRING dvCodec,"'preset near set 5',CR"
		}
    }
    RELEASE :
    {
    	STACK_VAR INTEGER nPresetIdx
	
	nPresetIdx = GET_LAST (nCameraPresets)
	SWITCH (nPresetIdx)
	{
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
	    CASE 7: fnDisturbOrNot(DO_DISTURB)
	    CASE 8: fnDisturbOrNot(DO_NOT_DISTURB)

	    //Presentation
	    CASE 9: fnPresentation('START')
	    CASE 10: 
	    {
		fnPresentation('STOP')
	    }
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
		//SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		WAIT 10
		{
		
		    FOR(cCount=1; cCount <=nListCount; cCount++)
		    {
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[cCount]),',0,',cSlot_Page1[cCount]"
			cSlot_Primary[cCount] = cSlot_Page1[cCount]
		    }
		}
	    }
	    CASE 2:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = SAV_END
		ON [cDialGTBook]
		fnUpdateList()
		//SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		WAIT 10
		{
		
		    FOR(cCount=1; cCount <=nListCount; cCount++)
		    {
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[cCount]),',0,',cSlot_Page2[cCount]"
			cSlot_Primary[cCount] = cSlot_Page2[cCount]
		    }
		}
	    }
	    CASE 3:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = GTL_END 
		ON [cDialGTBook]
		fnUpdateList()
		//SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		WAIT 10
		{
		
		    FOR(cCount=1; cCount <=nListCount; cCount++)
		    {
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[cCount]),',0,',cSlot_Page3[cCount]"
			cSlot_Primary[cCount] = cSlot_Page3[cCount]
		    }
		}                      
	    }
	    CASE 4:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = GT_END
		ON [cDialGTBook]
		fnUpdateList()
		//SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		WAIT 10
		{
		
		    FOR(cCount=1; cCount <=nListCount; cCount++)
		    {
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[cCount]),',0,',cSlot_Page4[cCount]"
			cSlot_Primary[cCount] = cSlot_Page4[cCount]
		    }
		}
	    }
	    CASE 5:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		nPage = BLUE_JEANS 
		OFF [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		
		WAIT 10
		{
		
		    FOR(cCount=1; cCount <=nListCount; cCount++)
		    {
			SEND_COMMAND vdvTP_Codec, "'^TXT-',ITOA(nPhoneSelect[cCount]),',0,',cSlot_BlueJeans[cCount]"
			cSlot_Primary[cCount] = cSlot_BlueJeans[cCount]
		    }
		}
		

	    }
	    CASE 6:
	    {
		TOTAL_OFF [vdvTP_Codec, nPhoneSelect]
		OFF [cDialGTBook]
		fnUpdateList()
		SEND_COMMAND vdvTP_Codec,"'^TXT-',ITOA(TXT_RETURN_ITEMS),',0,Please Wait...'"  
		//SEND_STRING dvCodec, "'xCommand Phonebook Search PhonebookID:0 PhonebookType:Local Offset: 0',CR" //Search Local
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
	   //SEND_STRING dvCodec, "'dial manual dialstr ',dialNumber,CR"
	   SEND_STRING dvCodec, "'dial manual 4096 ',dialNumber,CR"
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
	SEND_COMMAND DATA.DEVICE, 'SET BAUD 9600,N,8,1 485 DISABLED'
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
    WAIT 10 SEND_STRING dvCodec, "'callstate register',CR"

    WAIT 30 SEND_STRING dvCodec, "'listen sleep',CR"
    WAIT 40 SEND_STRING dvCodec, "'sleep register',CR"
    WAIT 50 SEND_STRING dvCodec, "'notify callstatus',CR"
    WAIT 60  SEND_STRING dvCodec, "'getcallstate',CR" //InCall?
}
TIMELINE_EVENT [TL_VTC]
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

}

DEFINE_EVENT


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

