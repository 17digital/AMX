PROGRAM_NAME='Extron_Recorder'
(***********************************************************)
(*  FILE CREATED ON: 02/15/2017  AT: 09:10:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 01/13/2018  AT: 11:55:11        *)
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

#IF_NOT_DEFINED dvExtronRec
dvExtronRec =			5001:1:0
#END_IF


DEFINE_CONSTANT
REC_DESTINATION		= 3 //Set Recording Destination (2=Front 3=Rear 1=Internal)

RECORDING_STOP		= 0
RECORDING_START		= 1
RECORDING_PAUSE		= 2

TL_CAPTURE			= 18 //Feedback
TL_STATUS			= 19 //Recording Pull Status
TL_GET_USB			= 20


PBP_UL				= 1 //Camera to side Small - Content Full (No Overlay)
PBP_UR				= 2
PBP_ML				= 3
PBP_MR				= 4
PIP_UL				= 5 //BG Fills entire Screen
PIP_UR				= 6 //BG Fills entire Screen
SIDE_SIDE				= 7
FULL_CONTENT			= 9 //FullScreen A
FULL_CAMERA			= 10 //FullScreen B

//LockOut Modes.. Uncomment the one you want...
LOCK_MODE			= 3 //Use Record Controls Only
//LOCK_MODE			= 0 //Off
//LOCK_MODE			= 2 //Menu Only
//LOCK_MODE			= 1 //Complete Lockout


DEFINE_VARIABLE
VOLATILE CHAR nStream[50] = 'rtsp://ic103extronsmp.amx.gatech.edu/extron3'
VOLATILE CHAR nExBuffer[1000] //Temp Buffer

VOLATILE INTEGER nLayout
VOLATILE INTEGER nRecord //Status

//DEV vdvTP_Capture[] = {dvTP_Recorder, dvTP_Recorder2}

VOLATILE CHAR cExtron_Buffer[1000]
VOLATILE LONG lExtronFeedback[] = {250}
VOLATILE LONG lRecordStatus[] = {5000} //5 Second Pull...
VOLATILE LONG lUsbStatus[] = {10000} //10 Second Pull...


VOLATILE INTEGER nRecBtns[] =
{
    1, //Start Rec
    2, //Pause Rec
    3, //Stop
    4, //BookMark (Chpt Mark)
    
    5, //pbp_ul
    6, //pbp_ur
    7, //pbp_ml
    8, //pbp_mr
    
    9, //pip_ul
    10, //pip_ur
    11, //side side
    12, //Full Content
    13,  //Full Camera
    14  //Swap A-B
}




(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnQueryStatus()
{
    SEND_STRING dvExtronRec, "$1B,'D',ITOA(REC_DESTINATION),'RCDR',$0D" //Default Location
    //SEND_STRING dvExtronRec, "$1B,'CV',$0D" //Check Verbose Mode... 
    WAIT 20 SEND_STRING dvExtronRec, "ITOA(LOCK_MODE),'X',$0D"
    WAIT 30 SEND_STRING dvExtronRec, "$1B,'3CV',$0D" //Set Verbose Mode (Should be 2/3 for best feedback...)    
}
DEFINE_FUNCTION fnParseCrestron()
{
    LOCAL_VAR CHAR cResponse[100]
    LOCAL_VAR CHAR cTimer[50]
    LOCAL_VAR CHAR cUsbname[50]
    LOCAL_VAR CHAR cTrash[50]
    
    //cResponse = DATA.TEXT
    //cResponse = REMOVE_STRING(nExBuffer,"$0D,$0A",1)
    
    SELECT
    {
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr01',1)):
	    {
		nLayout = PBP_UL
	    }    
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr02',1)):
	    {
		nLayout = PBP_UR
	    } 
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr03',1)):
	    {
		nLayout = PBP_ML
	    } 
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr04',1)):
	    {
		nLayout = PBP_MR
	    }  
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr05',1)):
	    {
		nLayout = PIP_UL
	    }  
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr06',1)):
	    {
		nLayout = PIP_UR
	    }   
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr07',1)):
	    {
		nLayout = SIDE_SIDE
	    }  
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr09',1)): //CH A
	    {
		nLayout = FULL_CONTENT
	    }  
	    ACTIVE(FIND_STRING(nExBuffer,'8Rpr10',1)): //CH B
	    {
		nLayout = FULL_CAMERA
	    }      
	    ACTIVE(FIND_STRING(nExBuffer,'RcdrY1',1)):
	    {
		nRecord = RECORDING_START
		SEND_STRING dvExtronRec, "'36I',$0D" //Get USB Info
		SEND_STRING dvExtronRec, "'35I',$0D" //Record Timer...
		//Start Timer~Timeline...
		IF (TIMELINE_ACTIVE(TL_STATUS))
		{
		    TIMELINE_RESTART(TL_STATUS)
		}
		ELSE
		{
		    TIMELINE_CREATE(TL_STATUS,lRecordStatus,LENGTH_ARRAY(lRecordStatus),TIMELINE_ABSOLUTE,TIMELINE_REPEAT)
		}
		SEND_COMMAND dvTP_Recorder, "'^TXT-10,0,Recording Started'" 
	    }
	    ACTIVE(FIND_STRING(nExBuffer,'RcdrY2',1)):
	    {
		nRecord = RECORDING_PAUSE
		//Pause Timeline
		TIMELINE_PAUSE(TL_STATUS)
		SEND_COMMAND dvTP_Recorder, "'^TXT-10,0,Recording Pause'" 
	    } 
	    ACTIVE(FIND_STRING(nExBuffer,'RcdrY0',1)):
	    {
		nRecord = RECORDING_STOP

		TIMELINE_KILL(TL_STATUS)
		SEND_COMMAND dvTP_Recorder, "'^TXT-10,0,Recording Stopped'" 
		WAIT 50
		{
		    SEND_STRING dvExtronRec, "'36I',$0D" //Get Final Results after stop
		    
		}
	    }  
	    ACTIVE(FIND_STRING(nExBuffer,'Inf36*usbrear/',1)):
	    {
		REMOVE_STRING(nExBuffer,'Inf36*usbrear/',1)
		cUsbname = nExBuffer //~should be left with ~USB Name/ Time Remaining
		
		SEND_COMMAND dvTP_Recorder, "'^TXT-11,0,',cUsbname"
	    }
	    ACTIVE(FIND_STRING(nExBuffer,'Inf36*usbfront/',1)):
	    {
		REMOVE_STRING(nExBuffer,'Inf36*usbfront/',1)
		cUsbname = nExBuffer //~should be left with ~USB Name/ Time Remaining
		
		SEND_COMMAND dvTP_Recorder, "'^TXT-11,0,',cUsbname"
	    }
	    ACTIVE(FIND_STRING(nExBuffer,'Inf35*',1)):
	    {
		REMOVE_STRING(nExBuffer,'Inf35*',1)
		cTimer = nExBuffer //~should be left with time counter
		
		SEND_COMMAND dvTP_Recorder, "'^TXT-12,0,',cTimer"
	    }	    
	    ACTIVE(FIND_STRING(nExBuffer,'Inf36*N/A 00:00:00',1)):
	    {
		SEND_COMMAND dvTP_Recorder, "'^TXT-11,0,No USB Detected'"
	    }
	    ACTIVE(FIND_STRING(nExBuffer,'E13',1)):
	    {
		cUsbname =''
		SEND_STRING dvExtronRec, "'39I',$0D" //View Active Alarms.. ~ [name:alarm_name]
		WAIT 10
		{
		    SEND_STRING dvExtronRec, "'35I',$0D" //Get record timer again for new value
		}
		//send clear alarm...
	    }
	    ACTIVE(FIND_STRING(nExBuffer,'Inf39*<name:disk_error',1)):
	    {
		SEND_COMMAND dvTP_Recorder, "'^TXT-11,0,Disk Error- Check USB'" 
		SEND_STRING dvExtronRec, "'36I',$0D" //Get Details after error
		WAIT 60
		{
		    SEND_STRING dvExtronRec, "$1B,'CALRM',$0D" //Clear Alarm
		}
	    }
	}
    nExBuffer = ''
}



DEFINE_START

CREATE_BUFFER dvExtronRec,nExBuffer;
WAIT 150
{
    TIMELINE_CREATE (TL_CAPTURE,lExtronFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    TIMELINE_CREATE (TL_GET_USB,lUsbStatus,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
}


DEFINE_EVENT
DATA_EVENT [dvExtronRec]
{
    ONLINE:
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 9600,N,8,1 485 DISABLED'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	WAIT 50
	{
	    fnQueryStatus()
	}
    }
    STRING :
    {
	fnParseCrestron()
    }
}
BUTTON_EVENT [dvTP_Recorder, nRecBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER nRecIdx
	
	nRecIdx = GET_LAST (nRecBtns)
	SWITCH (nRecIdx)
	{
	    CASE 1 : SEND_STRING dvExtronRec, "$1B,'Y',ITOA(RECORDING_START),'RCDR',$0D"
	    CASE 2 : SEND_STRING dvExtronRec, "$1B,'Y',ITOA(RECORDING_PAUSE),'RCDR',$0D"
	    CASE 3 : SEND_STRING dvExtronRec, "$1B,'Y',ITOA(RECORDING_STOP),'RCDR',$0D"
	    CASE 4 : SEND_STRING dvExtronRec, "$1B,'BRCDR',$0D" //BookMark
	    CASE 5 : SEND_STRING dvExtronRec, "'8*',ITOA(PBP_UL),'.',$0D"
	    CASE 6 : SEND_STRING dvExtronRec, "'8*',ITOA(PBP_UR),'.',$0D"
	    CASE 7 : SEND_STRING dvExtronRec, "'8*',ITOA(PBP_ML),'.',$0D"
	    CASE 8 : SEND_STRING dvExtronRec, "'8*',ITOA(PBP_MR),'.',$0D"
	    CASE 9 : SEND_STRING dvExtronRec, "'8*',ITOA(PIP_UL),'.',$0D"
	    CASE 10 : SEND_STRING dvExtronRec, "'8*',ITOA(PIP_UR),'.',$0D"
	    CASE 11 : SEND_STRING dvExtronRec, "'8*',ITOA(SIDE_SIDE),'.',$0D"
	    CASE 12 : SEND_STRING dvExtronRec, "'8*',ITOA(FULL_CONTENT),'.',$0D"
	    CASE 13 : SEND_STRING dvExtronRec, "'8*',ITOA(FULL_CAMERA),'.',$0D"
	    CASE 14 : SEND_STRING dvExtronRec, "'%',$0D"
	}
    }
}
TIMELINE_EVENT [TL_STATUS]
{
    SEND_STRING dvExtronRec, "'35I',$0D" //Record Timer...
}
TIMELINE_EVENT [TL_GET_USB]
{
    SEND_STRING dvExtronRec, "'36I',$0D" 

}
TIMELINE_EVENT [TL_CAPTURE] //Feedback...
{
    [dvTP_Recorder, 1] = nRecord = RECORDING_START
    [dvTP_Recorder, 2] = nRecord = RECORDING_PAUSE
    [dvTP_Recorder, 3] = nRecord = RECORDING_STOP
    
    [dvTP_Recorder, 5] = nLayout = PBP_UL
    [dvTP_Recorder, 6] = nLayout = PBP_UR
    [dvTP_Recorder, 7] = nLayout = PBP_ML
    [dvTP_Recorder, 8] = nLayout = PBP_MR
    [dvTP_Recorder, 9] = nLayout = PIP_UL
    [dvTP_Recorder, 10] = nLayout = PIP_UR
    [dvTP_Recorder, 11] = nLayout = SIDE_SIDE
    [dvTP_Recorder, 12] = nLayout = FULL_CONTENT
    [dvTP_Recorder, 13] = nLayout = FULL_CAMERA
                       
}



