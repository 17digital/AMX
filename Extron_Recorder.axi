PROGRAM_NAME='Extron_Recorder'
(***********************************************************)
(*  FILE CREATED ON: 02/15/2017  AT: 09:10:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/10/2019  AT: 11:57:42        *)
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
    
    Reboot Network..."$1B,'2BOOT',$0D"
    
	**)
    

DEFINE_DEVICE


#IF_NOT_DEFINED dvTP_Recorder
dvTP_Recorder =			10001:4:0
#END_IF

#IF_NOT_DEFINED dvTP_Recorder2
dvTP_Recorder2 =		10002:4:0

#IF_NOT_DEFINED dvExtronRec
dvExtronRec =			5001:3:0
#END_IF


DEFINE_CONSTANT

SET_ADDRESS_IP		= '172.21.1.21'
SET_ADDRESS_SUB		= '255.255.252.0'
SET_ADDRESS_GW		= '172.21.0.1'
SET_DEVICE_NAME		= 'B170'
SET_ADDRESS_DNS		= '130.207.244.251'
SET_REC_DESTINATION		= 3 //Set Recording Destination (2=Front 3=Rear 1=Internal)
SET_VERBOSE_MODE		= 3 //Full Feedback Query
SET_LOCATION			= 'Crosland Library' //Up to 64 Characters

RECORDING_STOP		= 0
RECORDING_START		= 1
RECORDING_PAUSE		= 2

TL_STATUS				= 19 //Recording Pull Status

PBP_UL				= 1 //Camera to side Small - Content Full (No Overlay)
PBP_UR				= 2
PBP_ML				= 3
PBP_MR				= 4
PIP_UL					= 5 //BG Fills entire Screen
PIP_UR					= 6 //BG Fills entire Screen
SIDE_SIDE				= 7
FULL_CONTENT		= 9 //FullScreen A
FULL_CAMERA			= 10 //FullScreen B


BTN_SWAP_SOURCE   = 15

//LockOut Modes.. Uncomment the one you want...
LOCK_MODE			= 3 //Use Record Controls Only
//LOCK_MODE			= 0 //Off
//LOCK_MODE			= 2 //Menu Only
//LOCK_MODE			= 1 //Complete Lockout

#IF_NOT_DEFINED CR 
CR 					= 13
#END_IF

#IF_NOT_DEFINED LF 
LF 					= 10
#END_IF


DEFINE_VARIABLE
VOLATILE CHAR nExBuffer[1000] //Temp Buffer

VOLATILE INTEGER nLayout
VOLATILE INTEGER nRecord //Status

DEV vdvTP_Capture[] = {dvTP_Recorder, dvTP_Recorder2}

VOLATILE CHAR cExtron_Buffer[1000]
VOLATILE LONG lRecordStatus[] = {5000} //5 Second Pull...

VOLATILE INTEGER nRecBtns[] =
{
    1, //Start Rec
    2, //Pause Rec
    3, //Stop
    4 //BookMark (Chpt Mark)
}
 VOLATILE INTEGER nLayoutBtns[] =
{ 
    5, //pbp_ul
    6, //pbp_ur
    7, //pbp_ml
    8, //pbp_mr
    
    9, //pip_ul
    10, //pip_ur
    11, //side side
    12, //Full Content
    13  //Full Camera
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

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnQueryStatus()
{
    SEND_STRING dvExtronRec, "$1B,'D',ITOA(SET_REC_DESTINATION),'RCDR',CR"

    WAIT 20 SEND_STRING dvExtronRec, "ITOA(LOCK_MODE),'X',CR"
    WAIT 30 SEND_STRING dvExtronRec, "$1B,ITOA(SET_VERBOSE_MODE),'CV',CR" 
    WAIT 50 SEND_STRING dvExtronRec, "$1B,'1*',SET_ADDRESS_IP,'*',SET_ADDRESS_SUB,'*',SET_ADDRESS_GW,'CISG',CR"
    WAIT 80 SEND_STRING dvExtronRec, "$1B,SET_ADDRESS_DNS,'DI',CR" 
    WAIT 100 SEND_STRING dvExtronRec, "$1B,SET_DEVICE_NAME,'CN',CR"
    WAIT 120 SEND_STRING dvExtronRec, "$1B,'L',SET_LOCATION,'SNMP',CR"
}
DEFINE_FUNCTION fnParseCrestron()
{
    STACK_VAR CHAR cMsgs[100]
    LOCAL_VAR CHAR nPreset[2]
    LOCAL_VAR CHAR cTimer[50]
    LOCAL_VAR CHAR cUsbname[50]
    LOCAL_VAR CHAR cTrash[50]
    
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
		    CASE '01' : nLayout = PBP_UL
		    CASE '02' : nLayout = PBP_UR
		    CASE '03' : nLayout = PBP_ML
		    CASE '04' : nLayout = PBP_MR
		    CASE '05' : nLayout = PIP_UL
		    CASE '06' : nLayout = PIP_UR
		    CASE '07': nLayout = SIDE_SIDE
		    CASE '09' : nLayout = FULL_CONTENT
		    CASE '10' : nLayout = FULL_CAMERA
		}
	    }
	    ACTIVE(FIND_STRING(cMsgs,'RcdrY1',1)):
	    {
		nRecord = RECORDING_START
		SEND_STRING dvExtronRec, "'36I',CR" //Get USB Info
		SEND_STRING dvExtronRec, "'35I',CR" //Record Timer...
		//Start Timer~Timeline...
		IF (TIMELINE_ACTIVE(TL_STATUS))
		{
		    TIMELINE_RESTART(TL_STATUS)
		}
		ELSE
		{
		    TIMELINE_CREATE(TL_STATUS,lRecordStatus,LENGTH_ARRAY(lRecordStatus),TIMELINE_ABSOLUTE,TIMELINE_REPEAT)
		}
		SEND_COMMAND vdvTP_Capture, "'^TXT-10,0,Recording Started'" 
	    }
	    ACTIVE(FIND_STRING(cMsgs,'RcdrY2',1)):
	    {
		nRecord = RECORDING_PAUSE
		//Pause Timeline
		TIMELINE_PAUSE(TL_STATUS)
		SEND_COMMAND vdvTP_Capture, "'^TXT-10,0,Recording Pause'" 
	    } 
	    ACTIVE(FIND_STRING(cMsgs,'RcdrY0',1)):
	    {
		nRecord = RECORDING_STOP

		TIMELINE_KILL(TL_STATUS)
		SEND_COMMAND vdvTP_Capture, "'^TXT-10,0,Recording Stopped'" 
		WAIT 50
		{
		    SEND_STRING dvExtronRec, "'36I',CR" //Get Final Results after stop
		    
		}
	    }  
	    ACTIVE(FIND_STRING(cMsgs,'Inf36*usbrear/',1)):
	    {
		REMOVE_STRING(cMsgs,'Inf36*usbrear/',1)
		cUsbname = cMsgs //~should be left with ~USB Name/ Time Remaining
		
		SEND_COMMAND vdvTP_Capture, "'^TXT-11,0,',cUsbname"
	    }
	    ACTIVE(FIND_STRING(cMsgs,'Inf36*usbfront/',1)):
	    {
		REMOVE_STRING(cMsgs,'Inf36*usbfront/',1)
		cUsbname = cMsgs //~should be left with ~USB Name/ Time Remaining
		
		SEND_COMMAND vdvTP_Capture, "'^TXT-11,0,',cUsbname"
	    }
	    ACTIVE(FIND_STRING(cMsgs,'Inf35*',1)):
	    {
		REMOVE_STRING(cMsgs,'Inf35*',1)
		cTimer = cMsgs //~should be left with time counter
		
		SEND_COMMAND vdvTP_Capture, "'^TXT-11,0,',cTimer"
	    }	    
	    ACTIVE(FIND_STRING(cMsgs,'Inf36*N/A 00:00:00',1)):
	    {
		SEND_COMMAND vdvTP_Capture, "'^TXT-11,0,No USB Detected'"
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
		SEND_COMMAND vdvTP_Capture, "'^TXT-11,0,Disk Error- Check USB'" 
		SEND_STRING dvExtronRec, "'36I',CR" //Get Details after error
		WAIT 60
		{
		    SEND_STRING dvExtronRec, "$1B,'CALRM',CR" //Clear Alarm
		}
	    }
	}
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
	fnParseCrestron()
    }
}
BUTTON_EVENT [vdvTP_Capture, nRecBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nRecIdx
	
	nRecIdx = GET_LAST (nRecBtns)
	SWITCH (nRecIdx)
	{
	    CASE 1 : SEND_STRING dvExtronRec, "$1B,'Y',ITOA(RECORDING_START),'RCDR',CR"
	    CASE 2 : SEND_STRING dvExtronRec, "$1B,'Y',ITOA(RECORDING_PAUSE),'RCDR',CR"
	    CASE 3 : SEND_STRING dvExtronRec, "$1B,'Y',ITOA(RECORDING_STOP),'RCDR',CR"
	    CASE 4 : SEND_STRING dvExtronRec, "$1B,'BRCDR',CR" //BookMark
	}
    }
}
BUTTON_EVENT [vdvTP_Capture, nLayoutBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nLayoutIDX
	
	nLayoutIDX = GET_LAST(nLayoutBtns)
	SEND_STRING dvExtronRec, "'8*',ITOA(nLayoutCall[nLayoutIDX]),'.',CR"
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_SWAP_SOURCE] //Swap Sources...
{
    PUSH :
    {
	    SEND_STRING dvExtronRec, "'%',CR"
    }
}
TIMELINE_EVENT [TL_STATUS]
{
    SEND_STRING dvExtronRec, "'35I',CR" //Record Timer...
}
TIMELINE_EVENT [TL_MAINLINE] //Feedback...
{
    [vdvTP_Capture, 1] = nRecord = RECORDING_START
    [vdvTP_Capture, 2] = nRecord = RECORDING_PAUSE
    [vdvTP_Capture, 3] = nRecord = RECORDING_STOP
    
    [vdvTP_Capture, 5] = nLayout = PBP_UL
    [vdvTP_Capture, 6] = nLayout = PBP_UR
    [vdvTP_Capture, 7] = nLayout = PBP_ML
    [vdvTP_Capture, 8] = nLayout = PBP_MR
    [vdvTP_Capture, 9] = nLayout = PIP_UL
    [vdvTP_Capture, 10] = nLayout = PIP_UR
    [vdvTP_Capture, 11] = nLayout = SIDE_SIDE
    [vdvTP_Capture, 12] = nLayout = FULL_CONTENT
    [vdvTP_Capture, 13] = nLayout = FULL_CAMERA
    
    WAIT 100
    {
	SEND_STRING dvExtronRec, "'36I',CR" 
    }
    
    WAIT ONE_MINUTE
    {
	SEND_STRING dvExtronRec, "$1B,ITOA(SET_VERBOSE_MODE),'CV',CR"
    }
                       
}
