PROGRAM_NAME='Extron_Recorder'

(*

	Nano1118 Details
	{
	    "Location": Nano-1118",
	    "ModelId": "SMP 351",
	    "Description": "Streaming Media Processor",
	    "Series": "SMP 300 Series",
	    "Serial": "A1REUQN",
	    "Firmware": "3.06",
	    "FeaturesInstalled": Null,
	    "Login": "admin",
	    "Password": "extron"
	}

Guest access:
Login ID : user
Password : password
*)

DEFINE_DEVICE


dvTP_Recorder =			10001:4:0
dvTP_RecBooth =			10004:2:0


#IF_NOT_DEFINED dvExtronRec
dvExtronRec =			5001:2:0
#END_IF


DEFINE_CONSTANT

#IF_NOT_DEFINED __COMMON_ASCII__
#DEFINE __COMMON_ASCII__
CHAR CR 				= $0D;
CHAR LF 				= $0A;
CHAR ESC				= $1B;
#END_IF


SET_REC_DESTINATION		= 3 //Set Recording Destination (2=Front 3=Rear 1=Internal)
SET_VERBOSE_MODE		= 3

RECORDING_STOP			= 0
RECORDING_START			= 1
RECORDING_PAUSE		= 2

TL_TIMER					= 19 //Recording Timer ID

PBP_UL					= 1 //Camera to side Small - Content Full (No Overlay)
PBP_UR					= 2
PBP_ML					= 3
PBP_MR					= 4
PIP_UL						= 5 //BG Fills entire Screen
PIP_UR						= 6 //BG Fills entire Screen
SIDE_SIDE					= 7
FULL_CONTENT			= 9 //FullScreen A
FULL_CAMERA				= 10 //FullScreen B

//Video Input Switching....
VID_IN_CONTENT				= 1 //SVSI
VID_IN_CAMERA				= 4 //Camera 1118 
VID_IN_CAMERA_2				= 2; //Camera 1117

VID_CH_A					= 1;
VID_CH_B					= 2;

//Streaming Stuff...
CH_A_ARCHIVE				= 1; //Current
CH_B_ARCHIVE				= 2; //Dual Channel Mode Only
CH_C_CONFIDENCE			= 3; //

STREAM_STOP				= 0;
STREAM_START				= 1;

//LockOut Modes.. Uncomment the one you want...
LOCK_MODE			= 3 //Use Record Controls Only
//LOCK_MODE			= 0 //Off
//LOCK_MODE			= 2 //Menu Only
//LOCK_MODE			= 1 //Complete Lockout

//Buttons...
BTN_REC_START			= 1
BTN_REC_PAUSE			= 2
BTN_REC_STOP			= 3
BTN_REC_BOOKMARK		= 4 //Chpt Mark

BTN_STREAM_START		= 21;
BTN_STREAM_STOP 		= 20;

BTN_PBP_UL				= 5 //pbp_ul
BTN_PBP_UR				= 6 //pbp_ur
BTN_PBP_ML				= 7 //pbp_ml
BTN_PBP_MR 				= 8 //pbp_mr
BTN_PIP_UL				= 9    
BTN_PIP_UR				= 10
BTN_EQUAL				= 11
BTN_FULL_CONTENT		= 12
BTN_FULL_CAMERA		= 13
BTN_SWAP_SOURCE   		= 15

BTN_INPUT_CONTENT		= 111
BTN_INPUT_ATEM			= 112

TXT_REC_STATUS			= 10 //Readable Text Return
TXT_USB_STATUS			= 11
TXT_TIMER				= 12 //Only holds timer
TXT_STREAM_STATUS		= 13


(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _SMP_STRUCT
{
    CHAR bHost[25];
    CHAR bSubNet[15];
    CHAR bGateway[15];
    CHAR bDeviceName[25]; //No Spaces + Must Start with Letter
    CHAR bDNS[15];
    CHAR bLocation[25]; //Up to 64 Characters
    INTEGER bLive;
}


DEFINE_VARIABLE

VOLATILE _SMP_STRUCT SmpInfo;
VOLATILE CHAR bData[25];
VOLATILE INTEGER bFailed;

VOLATILE INTEGER lSecondTimer;
VOLATILE INTEGER nMinuteStamp;
VOLATILE INTEGER nHourStamp;

VOLATILE CHAR nExBuffer[100];
VOLATILE LONG lRecordTimer[] = {1000} //1 Second Pull...
VOLATILE INTEGER bSmpInitalized;

VOLATILE DEV vdvTP_Capture[] = 
{
    dvTP_Recorder, 
    dvTP_RecBooth
}
VOLATILE INTEGER nRecSends[] =
{
    RECORDING_START,
    RECORDING_PAUSE,
    RECORDING_STOP
}
VOLATILE INTEGER nRecBtns[] =
{
    BTN_REC_START, 
    BTN_REC_PAUSE, 
    BTN_REC_STOP
}
VOLATILE INTEGER nLayoutBtns[] =
{ 
    BTN_PBP_UL,			
    BTN_PBP_UR,			
    BTN_PBP_ML,			
    BTN_PBP_MR,			
    BTN_PIP_UL,			   
    BTN_PIP_UR,			
    BTN_EQUAL,				
    BTN_FULL_CONTENT,
    BTN_FULL_CAMERA	
}
VOLATILE INTEGER nLayoutCall[] =
{
    PBP_UL,				
    PBP_UR,				
    PBP_ML,	
    PBP_MR,				
    PIP_UL,					
    PIP_UR,					
    SIDE_SIDE,				
    FULL_CONTENT,		
    FULL_CAMERA
}
VOLATILE CHAR nExtronInputs[5][16] =
{
    'Content',
    'Camera1117',
    'Nothing 3',
    'Camera1118',
    'Nothing 5'
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Recorder, BTN_PBP_UL]..[dvTP_Recorder, BTN_FULL_CAMERA])
([dvTP_Recorder, BTN_REC_START]..[dvTP_Recorder, BTN_REC_STOP])
([dvTP_Recorder, BTN_INPUT_CONTENT],[dvTP_Recorder, BTN_INPUT_ATEM])

([dvTP_RecBooth, BTN_PBP_UL]..[dvTP_RecBooth, BTN_FULL_CAMERA])
([dvTP_RecBooth, BTN_REC_START]..[dvTP_RecBooth, BTN_REC_STOP])
([dvTP_RecBooth, BTN_INPUT_CONTENT],[dvTP_RecBooth, BTN_INPUT_ATEM])


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnQueryStatus()
{
    SEND_STRING dvExtronRec, "ESC,'D',ITOA(SET_REC_DESTINATION),'RCDR',CR" //Default Location
    
    WAIT 20 SEND_STRING dvExtronRec, "ITOA(LOCK_MODE),'X',CR"
    WAIT 30 SEND_STRING dvExtronRec, "ESC,ITOA(SET_VERBOSE_MODE),'CV',CR" 
        WAIT 40 SEND_STRING dvExtronRec, "ESC,'YRCDR',CR" //Record StatusP',CR"
    WAIT 50 SEND_STRING dvExtronRec, "'IN',ITOA(VID_IN_CONTENT),'*',ITOA(VID_CH_A),'!',CR" //Set Active Channel A
    WAIT 60 SEND_STRING dvExtronRec, "'IN',ITOA(VID_IN_CAMERA),'*',ITOA(VID_CH_B),'!',CR" //Force Input on Channel B/2
    WAIT 70 SEND_STRING dvExtronRec, "ESC,'E',ITOA(CH_A_ARCHIVE),'RTMP',CR" //Get RTMP Status...
    
    WAIT 90 fnSetExtronInputNames()
    
    WAIT 120
    {
	IF (LENGTH_STRING(bData) >0 )
	{
	    bFailed = FALSE;
	    SEND_STRING dvExtronRec, "ESC,'1*',SmpInfo.bHost,'*',SmpInfo.bSubNet,'*',SmpInfo.bGateway,'CISG',CR"
	    WAIT 10 SEND_STRING dvExtronRec, "ESC,SmpInfo.bDNS,'DI',CR" 
	    WAIT 20 SEND_STRING dvExtronRec, "ESC,SmpInfo.bDeviceName,'CN',CR"
	    WAIT 30 SEND_STRING dvExtronRec, "ESC,'L',SmpInfo.bLocation,'SNMP',CR"
	}
	ELSE
	{
	    SEND_STRING 0, "'Check SMP Read Parsing'"
		bFailed = TRUE;
		    fnFailoverData();
	}
    }
}
DEFINE_FUNCTION fnFailoverData()
{
    SmpInfo.bHost = '128.61.215.49'
    SmpInfo.bSubNet = '255.255.255.0'
    SmpInfo.bGateway = '128.61.215.1'
    SmpInfo.bDNS = '130.207.244.251'
    SmpInfo.bDeviceName = 'Room-1118'
    SmpInfo.bLocation = 'NanoTech'
    
    WAIT 20
    {
	    SEND_STRING dvExtronRec, "ESC,'1*',SmpInfo.bHost,'*',SmpInfo.bSubNet,'*',SmpInfo.bGateway,'CISG',CR"
	    WAIT 10 SEND_STRING dvExtronRec, "ESC,SmpInfo.bDNS,'DI',CR" 
	    WAIT 20 SEND_STRING dvExtronRec, "ESC,SmpInfo.bDeviceName,'CN',CR"
	    WAIT 30 SEND_STRING dvExtronRec, "ESC,'L',SmpInfo.bLocation,'SNMP',CR"
    }
}
DEFINE_FUNCTION fnSetExtronInputNames()
{
    STACK_VAR INTEGER cLoop;
    
    FOR (cLoop =1; cLoop<=LENGTH_ARRAY(nExtronInputs); cLoop++)
    {
	SEND_STRING dvExtronRec, "ESC,ITOA(cLoop),',',nExtronInputs[cLoop],'NI',CR"
    }
}
DEFINE_FUNCTION fnParseExtron()
{
    STACK_VAR CHAR cMsgs[100];
    STACK_VAR CHAR nPreset[2];
    STACK_VAR INTEGER nRec;
    STACK_VAR CHAR cTimer[50];
    LOCAL_VAR CHAR cUsbname[50];
    LOCAL_VAR CHAR cTrash[50];
    STACK_VAR CHAR cVidIn[8];
    STACK_VAR CHAR cCountdown[1];
    
   WHILE (FIND_STRING(nExBuffer,"CR,LF",1))
   {
	cMsgs = REMOVE_STRING(nExBuffer,"CR,LF",1)
	    bSmpInitalized = TRUE;
    
	SELECT
	{
	    ACTIVE (FIND_STRING (cMsgs,'RecStart0',1)): //Rec Countdown....
	    {
		REMOVE_STRING (cMsgs,'0',1)
		cCountdown = cMsgs;
		SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Begins In ',cCountdown" 
	    }
	    ACTIVE(FIND_STRING(cMsgs,'8Rpr',1)):
	    {
		REMOVE_STRING (cMsgs,'8Rpr',1)
		nPreset = cMsgs;
		
		SWITCH (nPreset)
		{
		    CASE '01' : ON [vdvTP_Capture, BTN_PBP_UL] 
		    CASE '02' : ON [vdvTP_Capture, BTN_PBP_UR]
		    CASE '03' : ON [vdvTP_Capture, BTN_PBP_ML] 
		    CASE '04' : ON [vdvTP_Capture, BTN_PBP_MR] 
		    CASE '05' : ON [vdvTP_Capture, BTN_PIP_UL] 
		    CASE '06' : ON [vdvTP_Capture, BTN_PIP_UR] 
		    CASE '07' : ON [vdvTP_Capture, BTN_EQUAL]
		    CASE '09' : ON [vdvTP_Capture, BTN_FULL_CONTENT] 
		    CASE '10' : ON [vdvTP_Capture, BTN_FULL_CAMERA]
		}
	    }
	    ACTIVE(FIND_STRING(cMsgs,'RcdrY',1)):
	    {
		REMOVE_STRING (cMsgs,'RcdrY',1)
		nRec = ATOI(cMsgs)
		
		SWITCH (nRec)
		{
		    CASE 1 :
		    {
			ON [vdvTP_Capture, BTN_REC_START]
			SEND_STRING dvExtronRec, "'36I',CR" //Get USB Info
			
			//RecStart05
			//RecStart04
			//RecStart03
			//RecStart02
			//RecStart01
			
			//SEND_STRING dvExtronRec, "'35I',CR" //Record Timer...
			IF (TIMELINE_ACTIVE(TL_TIMER))
			{
			    fnStartTimer();
			    TIMELINE_RESTART(TL_TIMER)
			}
			ELSE
			{
			    fnResetTimerToZero();
			    TIMELINE_CREATE(TL_TIMER,lRecordTimer,LENGTH_ARRAY(lRecordTimer),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
			}
			SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Started!'" 
		    }
		    CASE 2 :
		    {
			ON [vdvTP_Capture, BTN_REC_PAUSE]
			SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Paused'" 
			
			IF (TIMELINE_ACTIVE(TL_TIMER))
			{
			    TIMELINE_PAUSE(TL_TIMER)
			}
		    }
		    CASE 0 :
		    {
			ON [vdvTP_Capture, BTN_REC_STOP]

			TIMELINE_KILL(TL_TIMER)
			SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Stopped'" 
			WAIT 50
			{
			    SEND_STRING dvExtronRec, "'36I',CR" //Get Final Results after stop
			    
			}
		    }
		}
	    } 
	    ACTIVE (FIND_STRING(cMsgs,'RtmpE01*',1)) :
	    {
		REMOVE_STRING(cMsgs,'*',1) //Should be left w/ VAR of 1/0
		    SmpInfo.bLive = ATOI(LEFT_STRING(cMsgs, 1));
		    
		    SWITCH (SmpInfo.bLive)
		    {
			CASE  STREAM_START : {
			    ON [vdvTP_Capture, BTN_STREAM_START]
				SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_STREAM_STATUS),',0,Stream is Live!'" 
			}
			DEFAULT : {
			    OFF [vdvTP_Capture, BTN_STREAM_STOP]
				SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_STREAM_STATUS),',0,Not Streaming'" 
			}
		    }
	    }
	    ACTIVE(FIND_STRING(cMsgs,'Inf36*',1)):
	    {
		REMOVE_STRING(cMsgs,'Inf36*',1)
		cUsbname = cMsgs
		
		IF(FIND_STRING(cUsbname,'usbrear/',1))
		{
		    REMOVE_STRING(cUsbname,'usbrear/',1)
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Found : ',cUsbname"
		}
		IF(FIND_STRING(cUsbname,'usbfront/',1))
		{
		    REMOVE_STRING(cUsbname,'usbfront/',1)
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Found : ',cUsbname"
		}
		IF (FIND_STRING(cUsbname,'N/A 00:00:00',1))
		{
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,No USB Detected'"
		}
	    }
	    ACTIVE(FIND_STRING(cMsgs,'Inf35*',1)):
	    {
		REMOVE_STRING(cMsgs,'Inf35*',1)
		cTimer = cMsgs //~should be left with time counter
		
		//SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,',cTimer"
	    }	    
	    ACTIVE(FIND_STRING(cMsgs,'E13',1)):
	    {
		cUsbname =''
		SEND_STRING dvExtronRec, "'39I',CR" //View Active Alarms.. ~ [name:alarm_name]
		WAIT 10
		{
		    SEND_STRING dvExtronRec, "'35I',CR" //Get record timer again for new value
		}
		//send clear alarm...
	    }
	    ACTIVE(FIND_STRING(cMsgs,'Inf39*<name:disk_error',1)):
	    {
		SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Disk Error- Check USB'" 
		SEND_STRING dvExtronRec, "'36I',CR" //Get Details after error
		
		WAIT 60
		{
		    SEND_STRING dvExtronRec, "$1B,'CALRM',CR" //Clear Alarm
		}
	    }
	}
    }
}
DEFINE_FUNCTION fnLayoutSwitch(INTEGER cIn)
{
    SEND_STRING dvExtronRec, "'8*',ITOA(cIn),'.',CR"
}
DEFINE_FUNCTION fnRecordSwitch(INTEGER cIn)
{
    SEND_STRING dvExtronRec, "ESC,'Y',ITOA(cIn),'RCDR',CR"
}
DEFINE_FUNCTION fnStreamRTMP (INTEGER cSwitch) {

    SEND_STRING dvExtronRec, "ESC,'E',ITOA(CH_A_ARCHIVE),'*',ITOA(cSwitch),'RTMP',CR"
}
DEFINE_FUNCTION fnSwitchInput(INTEGER cIn, INTEGER cOut)
{
    SEND_STRING dvExtronRec, "ITOA(cIn),'*',ITOA(cOut),'!',CR"
}
DEFINE_FUNCTION fnStartTimer()
{
    STACK_VAR CHAR iTimeFormated[20];
    LOCAL_VAR CHAR iTimeResult[20];
    
    lSecondTimer = lSecondTimer + 1;
    
    IF (lSecondTimer = 60)
    {
	nMinuteStamp = nMinuteStamp + 1;
	
	IF (nMinuteStamp = 60)
	{
	    nHourStamp = nHourStamp + 1;
	    nMinuteStamp = 0;
	}
	lSecondTimer = 0;
    }
    
    iTimeFormated = FORMAT(': %02d ',lSecondTimer)
	iTimeFormated = "FORMAT(': %02d ',nMinuteStamp),iTimeFormated" //Append the minutes..
	iTimeFormated = "FORMAT(' %02d ', nHourStamp), iTimeFormated" 
	    iTimeResult = iTimeFormated
    
    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,',iTimeResult"
}
DEFINE_FUNCTION fnResetTimerToZero()
{
    nMinuteStamp = 0;
    nHourStamp = 0;
    lSecondTimer = 0;
   SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,00 : 00 : 00'"
}


DEFINE_START

CREATE_BUFFER dvExtronRec,nExBuffer;

DEFINE_EVENT
DATA_EVENT [dvExtronRec]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 9600,N,8,1 485 DISABLED'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 400
	{
	    fnQueryStatus()
	}
    }
    STRING :
    {
	fnParseExtron();
		CANCEL_WAIT 'EXTRON RX'
	WAIT 300 'EXTRON RX'
	{
	    bSmpInitalized = FALSE;
	}
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_STREAM_START]
{
    PUSH :
    {
	IF (SmpInfo.bLive == FALSE) {
	
		fnStreamRTMP(STREAM_START);
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_STREAM_STATUS),',0,Stream Starting, Please wait...'" 
	}
	ELSE {
	    fnStreamRTMP(STREAM_STOP);
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_STREAM_STATUS),',0,Stream Stopping...'" 
	}
    }	    
}
BUTTON_EVENT [vdvTP_Capture, nLayoutBtns]
{
    PUSH :
    {
	fnLayoutSwitch(nLayoutCall[GET_LAST(nLayoutBtns)])
    }
}
BUTTON_EVENT [vdvTP_Capture, nRecBtns]
{
    PUSH :
    {
	fnRecordSwitch(nRecSends[GET_LAST(nRecBtns)])
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_REC_BOOKMARK]
{
    PUSH :
    {
	SEND_STRING dvExtronRec, "ESC,'BRCDR',CR"
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_SWAP_SOURCE] //Swap Sources...
{
    PUSH :
    {
	 SEND_STRING dvExtronRec, "'%',CR"
    }
}
TIMELINE_EVENT [TL_TIMER]
{
    fnStartTimer() //Record Timer...
}
TIMELINE_EVENT [TL_FEEDBACK] //Feedback...
{
    
    WAIT 100 { //Get USB + Stream Status...
    	SEND_STRING dvExtronRec, "'36I',CR" 
	WAIT 20 {
	    SEND_STRING dvExtronRec, "ESC,'E',ITOA(CH_A_ARCHIVE),'RTMP',CR"
	}
    }
    
    WAIT 6500 //5 minutes
    {
	fnQueryStatus();
    }
}
