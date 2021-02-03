PROGRAM_NAME='Extron_Recorder'
(***********************************************************)
(*  FILE CREATED ON: 02/15/2017  AT: 09:10:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/11/2019  AT: 05:29:47        *)
(***********************************************************)

(**
    Default : No DHCP!!
    IP>>> 192.168.254.254 / 16
    
    http://128.61.218.94/www/
    
    Firmware 2.00
    
    Stream : 
    
    SMP 351
    
    The SMP 300 Series supports FAT32, NTFS, and VFAT long file names, EXT2, EXT3 and
    EXT4 formats for USB drives that are used for file storage.
    
    Auto Time Response when recording??? - SEND "'34I',$0A" -- Send Check USB Function!! (Button)
    
    Could Send " 'I',$0D" so often for USB properties...
    
    May need to add Wait after recording... 10second delay
    
    Verbose Mode...
    1 = verbose mode (default for USB and RS-232 host Control
    2 = tagged responses for queries
    3 = verbose mode and tagged responses for queries
    
        Set DHCP On... "$1B,'1DH',$0D"
    Set DHCP Off...(Default)  "$1B,'0DH',$0D"
    Set IP Address..."$1B,'1*','128.61.95.11/24*128.61.95.1',$0D"
    View Mac Address..."$1B,'CH',$0D" ...
    View Network ..."$1B,'1CISG',$0D"
    View Data/Time ..."$1B,'CT',$0D"
    Set Date/Time..."'$1B,'MM/DD/YY-HH:MM:SS CT',$0D //"$1B,'06/08/17-11:50:00CT',$0D"
    Clear Active Alarms "$1B,'CALRM',$0D"
    View Unit Name..."$1B,'CN',$0D"
    Set Unit Nmae..."$1B,'COB312CN',$0D" (63 Max)
    
        Reboot Network..."$1B,'2BOOT',13"
    Reboot System..."$1B,'1BOOT',13"
    
	**)
    

DEFINE_DEVICE




#IF_NOT_DEFINED dvTP_Recorder
dvTP_Recorder =			10001:4:0
#END_IF

#IF_NOT_DEFINED dvTP_Recorder2
dvTP_Recorder2 =		10002:4:0
#END_IF

#IF_NOT_DEFINED dvTP_Recorder3
dvTP_Recorder3 =		10003:4:0
#END_IF

#IF_NOT_DEFINED dvExtronRec
dvExtronRec =			5001:2:0
#END_IF


DEFINE_CONSTANT
#IF_NOT_DEFINED CR 
CR 					= 13
#END_IF

#IF_NOT_DEFINED LF 
LF 					= 10
#END_IF

ESC					= 27 //Escape

SET_ADDRESS_IP			= '172.21.5.23' //
SET_ADDRESS_SUB			= '255.255.252.0'
SET_ADDRESS_GW			= '172.21.4.1'
SET_DEVICE_NAME			= 'Room-122' //No Spaces + Must Start with Letter
SET_ADDRESS_DNS			= '130.207.244.251'
SET_REC_DESTINATION		= 3 //Set Recording Destination (2=Front 3=Rear 1=Internal)
SET_VERBOSE_MODE			= 3
SET_LOCATION				= 'SEB' //Up to 64 Characters

RECORDING_STOP			= 0
RECORDING_START			= 1
RECORDING_PAUSE			= 2

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
VID_IN_CONTENT				= 1 //DGX
VID_IN_ATEM					= 2 //From Atem
VID_IN_CAMERA				= 5 //

VID_CH_A					= 1
VID_CH_B					= 2

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


DEFINE_VARIABLE

VOLATILE INTEGER lSecondTimer
VOLATILE INTEGER nMinuteStamp
VOLATILE INTEGER nHourStamp

VOLATILE CHAR nExBuffer[100]
VOLATILE LONG lRecordTimer[] = {1000} //1 Second Pull...

VOLATILE DEV vdvTP_Capture[] = 
{
    dvTP_Recorder, 
    dvTP_Recorder2, 
    dvTP_Recorder3
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
    'DGX Content',
    'Atem View',
    'Nothing 3',
    'Nothing 4',
    'Camera'
}
VOLATILE INTEGER nVideoInSources[] =
{
    VID_IN_CONTENT,
    VID_IN_ATEM
}
VOLATILE INTEGER nVideoSwitchBtns[] =
{
    BTN_INPUT_CONTENT,
    BTN_INPUT_ATEM
}

DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Recorder, BTN_PBP_UL]..[dvTP_Recorder, BTN_FULL_CAMERA])
([dvTP_Recorder, BTN_REC_START]..[dvTP_Recorder, BTN_REC_STOP])
([dvTP_Recorder, BTN_INPUT_CONTENT],[dvTP_Recorder, BTN_INPUT_ATEM])

([dvTP_Recorder2, BTN_PBP_UL]..[dvTP_Recorder2, BTN_FULL_CAMERA])
([dvTP_Recorder2, BTN_REC_START]..[dvTP_Recorder2, BTN_REC_STOP])
([dvTP_Recorder2, BTN_INPUT_CONTENT],[dvTP_Recorder2, BTN_INPUT_ATEM])

([dvTP_Recorder3, BTN_PBP_UL]..[dvTP_Recorder3, BTN_FULL_CAMERA])
([dvTP_Recorder3, BTN_REC_START]..[dvTP_Recorder3, BTN_REC_STOP])
([dvTP_Recorder3, BTN_INPUT_CONTENT],[dvTP_Recorder3, BTN_INPUT_ATEM])


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
    WAIT 50 SEND_STRING dvExtronRec, "ESC,'1*',SET_ADDRESS_IP,'*',SET_ADDRESS_SUB,'*',SET_ADDRESS_GW,'CISG',CR"
    WAIT 60 SEND_STRING dvExtronRec, "ESC,SET_ADDRESS_DNS,'DI',CR" 
    WAIT 70 SEND_STRING dvExtronRec, "ESC,SET_DEVICE_NAME,'CN',CR"
    WAIT 80 SEND_STRING dvExtronRec, "ESC,'L',SET_LOCATION,'SNMP',CR"
    WAIT 100 SEND_STRING dvExtronRec, "ESC,'YRCDR',CR" //Record StatusP',CR"
    WAIT 130 SEND_STRING dvExtronRec, "ITOA(VID_CH_A),'!',CR" //Get Active Input
    WAIT 150 SEND_STRING dvExtronRec, "ITOA(VID_IN_CAMERA),'*',ITOA(VID_CH_B),'!',CR" //Force Input on Channel B/2
    
    WAIT 200 fnSetExtronInputNames()
}
DEFINE_FUNCTION fnSetExtronInputNames()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop =1; cLoop<=MAX_LENGTH_ARRAY(nExtronInputs); cLoop++)
    {
	SEND_STRING dvExtronRec, "ESC,ITOA(cLoop),',',nExtronInputs[cLoop],'NI',CR"
    }
}
DEFINE_FUNCTION fnParseExtron()
{
    STACK_VAR CHAR cMsgs[100]
    LOCAL_VAR CHAR nPreset[2]
    LOCAL_VAR INTEGER nRec
    LOCAL_VAR CHAR cTimer[50]
    LOCAL_VAR CHAR cUsbname[50]
    LOCAL_VAR CHAR cTrash[50]
    LOCAL_VAR CHAR cVidIn[8]
    
   WHILE (FIND_STRING(nExBuffer,"CR,LF",1))
   {
	cMsgs = REMOVE_STRING(nExBuffer,"CR,LF",1)
    
	SELECT
	{
	    ACTIVE(FIND_STRING(cMsgs,'8Rpr',1)):
	    {
		REMOVE_STRING (cMsgs,'8Rpr',1)
		nPreset = cMsgs
		
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
			    fnPausedTimer()
			    TIMELINE_RESTART(TL_TIMER)
			}
			ELSE
			{
			    fnResetTimerToZero()
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
	    ACTIVE(FIND_STRING(cMsgs,'In0',1)):
	    {
		REMOVE_STRING(cMsgs,'In0',1)
		cVidIn = cMsgs
		
		IF(FIND_STRING(cVidIn,"ITOA(VID_IN_CONTENT),'*0',ITOA(VID_CH_A)",1))
		{
		    ON [vdvTP_Capture, BTN_INPUT_CONTENT]
		}
    		IF(FIND_STRING(cVidIn,"ITOA(VID_IN_ATEM),'*0',ITOA(VID_CH_A)",1))
		{
		    ON [vdvTP_Capture, BTN_INPUT_ATEM]
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
DEFINE_FUNCTION fnSwitchInput(INTEGER cIn, INTEGER cOut)
{
    SEND_STRING dvExtronRec, "ITOA(cIn),'*',ITOA(cOut),'!',CR"
}
DEFINE_FUNCTION fnStartTimer()
{
    lSecondTimer = lSecondTimer + 1
    
    IF (lSecondTimer = 60)
    {
	nMinuteStamp = nMinuteStamp + 1
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 00'"
	
	IF (nMinuteStamp = 60)
	{
	    nHourStamp = (nHourStamp + 1)
	    nMinuteStamp = 0
	}
	lSecondTimer = 0
    }
    ELSE IF (lSecondTimer <10)
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 0',ITOA(lSecondTimer)"
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : ',ITOA(lSecondTimer)"
    }
}
DEFINE_FUNCTION fnResetTimerToZero()
{
    nMinuteStamp = 0
    nHourStamp = 0
    lSecondTimer = 0
   SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 00'"
}
DEFINE_FUNCTION fnPausedTimer()
{
    lSecondTimer = lSecondTimer + 1
    
    IF (lSecondTimer < 10)
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : 0',ITOA(lSecondTimer)"
    }
    ELSE
    {
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,Timer',$0A,$0D,ITOA(nHourStamp),' Hr(s) : ',ITOA(nMinuteStamp),' Min(s) : ',ITOA(lSecondTimer)"
    }
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
	WAIT 100
	{
	    fnQueryStatus()
	}
    }
    STRING :
    {
	fnParseExtron()
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
BUTTON_EVENT [vdvTP_Capture, nVideoSwitchBtns]
{
    PUSH :
    {
	fnSwitchInput(nVideoInSources[GET_LAST(nVideoSwitchBtns)],VID_CH_A)
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
    
    WAIT 100 //Get USB Status...
    {
	SEND_STRING dvExtronRec, "'36I',CR" 
    }
    
    WAIT 8500
    {
	SEND_STRING dvExtronRec, "ESC,ITOA(SET_VERBOSE_MODE),'CV',CR"
    }
}
