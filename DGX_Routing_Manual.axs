PROGRAM_NAME='DGX_Routing_Manual'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 11/17/2019  AT: 23:21:43        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    8/6/13 - modified scaling to 1080p
    Sanyo PDG-DHT8000L = 1920x1080
    
    $History: $
    TO DO List
    
    Call Touch panel Pushes to Booth Master, Remove Virtual Device Calls!!
*)


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


DGX_REMOTE =			7112

dvMaster = 			0:1:0	//NX-4200
dvDgx =	 			5002:1:DGX_REMOTE  //DGX 16 System in Rack


dvTP_Main = 			10001:1:0 //Lectern Touchpanel
dvTP_Booth =			10002:1:0 //Booth TouchPanel

dvDGXSLOT_1 =			5002:1:DGX_REMOTE
dvDGXSLOT_2 =			5002:2:DGX_REMOTE
dvDGXSLOT_3 =			5002:3:DGX_REMOTE
dvDGXSLOT_4 =			5002:4:DGX_REMOTE
dvDGXSLOT_5 =			5002:5:DGX_REMOTE
dvDGXSLOT_6 =			5002:6:DGX_REMOTE
dvDGXSLOT_7 =			5002:7:DGX_REMOTE
dvDGXSLOT_8 =			5002:8:DGX_REMOTE
dvDGXSLOT_9 =			5002:9:DGX_REMOTE
dvDGXSLOT_10 =			5002:10:DGX_REMOTE
dvDGXSLOT_11 =			5002:11:DGX_REMOTE
dvDGXSLOT_12 =			5002:12:DGX_REMOTE
dvDGXSLOT_13 =			5002:13:DGX_REMOTE
dvDGXSLOT_14 =			5002:14:DGX_REMOTE
dvDGXSLOT_15 =			5002:15:DGX_REMOTE
dvDGXSLOT_16 =			5002:16:DGX_REMOTE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(******DGX SWITCHING CHANNELS*****)

//DGX Inputs....
INPUT_DVX_LEFT			= 1
INPUT_DVX_RIGHT		= 2
INPUT_152_LEFT			= 3
INPUT_152_RIGHT		= 4
INPUT_AUX				= 5
INPUT_TUNER			= 9
INPUT_CAMERA_			= 10 //From SDI / HDMI Scaler / Converter
INPUT_MERSIVE			= 11
INPUT_SX80			= 12
INPUT_CAMERA_REAR_		= 13
INPUT_CAMERA_FRONT_	= 14
//DGX Outputs...
OUT_PROJECTOR_LEFT		= 1
OUT_PROJECTOR_RIGHT	= 2
OUT_PROJECTOR_CENTER	= 3
OUT_DOWNSTAGE_LEFT	= 5
OUT_DOWNSTAGE_RIGHT	= 6
OUT_DVX_9			= 9 //Routing TV Tuner to DVX
OUT_DVX_10			= 10 //Routing Mersive to DVX
OUT_CAPTURE			= 13 //Extron SMP
OUT_SX80_CONTENT		= 14
OUT_PREVIEW_MON		= 15 //Monitor Preview
OUT_CAMERA_FEED		= 16 //Camera Feed to DA (SX80 / Extron SMP

//DGX Input Names...
NAME_DGXIN_1			= 'DVX OUT 1'
NAME_DGXIN_2			= 'DVX OUT 3'
NAME_DGXIN_3			= '152 IN Left'
NAME_DGXIN_4			= '152 IN Right'
NAME_DGXIN_5			= 'Rear Input'
NAME_DGXIN_6			= 'Not Used'
NAME_DGXIN_7			= 'Not Used'
NAME_DGXIN_8			= 'Not Used'
NAME_DGXIN_9			= 'TV Tuner'
NAME_DGXIN_10			= 'Not Used'
NAME_DGXIN_11			= 'Mersive'
NAME_DGXIN_12			= 'SX80 View'

NAME_DGXIN_13			= 'Camera Rear'
NAME_DGXIN_14			= 'Camera Front'
NAME_DGXIN_15			= 'Not Used'
NAME_DGXIN_16			= 'Not Used'

//DGX Output Names..
NAME_DGXOUT_1				= 'Left Projector'
NAME_DGXOUT_2				= 'Right Projector'
NAME_DGXOUT_3				= 'Center Projector'
NAME_DGXOUT_4				= 'Rear Aux'

NAME_DGXOUT_5				= 'Down Stage Left'
NAME_DGXOUT_6				= 'Down Stage Right'
NAME_DGXOUT_7				= 'Not Used'
NAME_DGXOUT_8				= 'Not Used'

NAME_DGXOUT_9				= 'DVX IN 9'
NAME_DGXOUT_10			= 'DVX IN 10'
NAME_DGXOUT_11			= 'Not Used'
NAME_DGXOUT_12			= 'Not Used'

NAME_DGXOUT_13			= 'Extron SMP Content'
NAME_DGXOUT_14			= 'SX80 Content'
NAME_DGXOUT_15			= 'Monitor Preview'
NAME_DGXOUT_16			= 'Cameras Out'

//DGX Text Slots...
TXT_SLOT_1				= 301
TXT_SLOT_2				= 302
TXT_SLOT_3				= 303
TXT_SLOT_4				= 304
TXT_SLOT_5				= 305
TXT_SLOT_6				= 306
TXT_SLOT_7				= 307
TXT_SLOT_8				= 308
TXT_SLOT_9				= 309
TXT_SLOT_10				= 310
TXT_SLOT_11				= 311
TXT_SLOT_12				= 312
TXT_SLOT_13				= 313
TXT_SLOT_14				= 314
TXT_SLOT_15				= 315
TXT_SLOT_16				= 316

// Timeline
TL_FEEDBACK			= 1
TL_FLASH				= 2

ONE_SECOND			= 10 //may have to set to 1000
ONE_MINUTE			= 60*ONE_SECOND
ONE_HOUR				= 60*ONE_MINUTE
HALF_HOUR				= 30*ONE_MINUTE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvTP_Main [] = {dvTP_Main, dvTP_Booth }

//DGX Stuff...
VOLATILE INTEGER nSource_Input
VOLATILE INTEGER nSource_Outputs

VOLATILE LONG lTLFeedback[] = {500}
VOLATILE LONG lTLFlash[] = {1000} 
VOLATILE INTEGER iFLASH

VOLATILE CHAR nSwitchInputNames[16][35] = 
{
    'DVX Out 1', //1
    'DVX Out 3', //2
    '152 In Left', //3
    '152 In Right', //4
    '144 Rear Aux', //5
    'Not Used', //6
    'Not Used', //7
    'Not Used', //8
    'TV Tuner', //9
    'Not Used', //10
    'Mersive', //11
    'Cisco SX80', //12
    'Camera Rear', //13
    'Camera Front', //14
    'Not Used', //15
    'Not Used' //16
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvIOs,nTimelineIO[1]]..[dvIOs,nTimelineIO[8]])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_CALL 'DGX SLOT NAME'
{
    SEND_COMMAND dvDGXSLOT_1, "'VIDIN_NAME-',NAME_DGXIN_1"
    SEND_COMMAND dvDGXSLOT_2, "'VIDIN_NAME-',NAME_DGXIN_2"
    SEND_COMMAND dvDGXSLOT_3, "'VIDIN_NAME-',NAME_DGXIN_3"
    SEND_COMMAND dvDGXSLOT_4, "'VIDIN_NAME-',NAME_DGXIN_4"
    SEND_COMMAND dvDGXSLOT_5, "'VIDIN_NAME-',NAME_DGXIN_5"
    SEND_COMMAND dvDGXSLOT_6, "'VIDIN_NAME-',NAME_DGXIN_6"
    SEND_COMMAND dvDGXSLOT_7, "'VIDIN_NAME-',NAME_DGXIN_7"
    SEND_COMMAND dvDGXSLOT_8, "'VIDIN_NAME-',NAME_DGXIN_8"
    SEND_COMMAND dvDGXSLOT_9, "'VIDIN_NAME-',NAME_DGXIN_9"
    SEND_COMMAND dvDGXSLOT_10, "'VIDIN_NAME-',NAME_DGXIN_10"
    SEND_COMMAND dvDGXSLOT_11, "'VIDIN_NAME-',NAME_DGXIN_11"
    SEND_COMMAND dvDGXSLOT_12, "'VIDIN_NAME-',NAME_DGXIN_12"
    SEND_COMMAND dvDGXSLOT_13, "'VIDIN_NAME-',NAME_DGXIN_13"
    SEND_COMMAND dvDGXSLOT_14, "'VIDIN_NAME-',NAME_DGXIN_14"
    SEND_COMMAND dvDGXSLOT_15, "'VIDIN_NAME-',NAME_DGXIN_15"
    SEND_COMMAND dvDGXSLOT_16, "'VIDIN_NAME-',NAME_DGXIN_16"
    WAIT 30
    {
	SEND_COMMAND dvDGXSLOT_1, "'VIDOUT_NAME-',NAME_DGXOUT_1"
	SEND_COMMAND dvDGXSLOT_2, "'VIDOUT_NAME-',NAME_DGXOUT_2"
	SEND_COMMAND dvDGXSLOT_3, "'VIDOUT_NAME-',NAME_DGXOUT_3"
	SEND_COMMAND dvDGXSLOT_4, "'VIDOUT_NAME-',NAME_DGXOUT_4"
	SEND_COMMAND dvDGXSLOT_5, "'VIDOUT_NAME-',NAME_DGXOUT_5"
	SEND_COMMAND dvDGXSLOT_6, "'VIDOUT_NAME-',NAME_DGXOUT_6"
	SEND_COMMAND dvDGXSLOT_7, "'VIDOUT_NAME-',NAME_DGXOUT_7"
	SEND_COMMAND dvDGXSLOT_8, "'VIDOUT_NAME-',NAME_DGXOUT_8"
	SEND_COMMAND dvDGXSLOT_9, "'VIDOUT_NAME-',NAME_DGXOUT_9"
	SEND_COMMAND dvDGXSLOT_10, "'VIDOUT_NAME-',NAME_DGXOUT_10"
	SEND_COMMAND dvDGXSLOT_11, "'VIDOUT_NAME-',NAME_DGXOUT_11"
	SEND_COMMAND dvDGXSLOT_12, "'VIDOUT_NAME-',NAME_DGXOUT_12"
	SEND_COMMAND dvDGXSLOT_13, "'VIDOUT_NAME-',NAME_DGXOUT_13"
	SEND_COMMAND dvDGXSLOT_14, "'VIDOUT_NAME-',NAME_DGXOUT_14"
	SEND_COMMAND dvDGXSLOT_15, "'VIDOUT_NAME-',NAME_DGXOUT_15"
	SEND_COMMAND dvDGXSLOT_16, "'VIDOUT_NAME-',NAME_DGXOUT_16"
    }  
    WAIT 100
    {
	WAIT 10 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_LEFT)"
	WAIT 20 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_RIGHT)"
	WAIT 30 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PROJECTOR_CENTER)"
	WAIT 40 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DOWNSTAGE_LEFT)"
	WAIT 50 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DOWNSTAGE_RIGHT)"
	WAIT 60 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DVX_9)"
	WAIT 70 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_DVX_10)"
	//WAIT 80 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_CAPTURE)"
	//WAIT 90 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_SX80_CONTENT)"
	//WAIT 100 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_PREVIEW_MON)"
	//WAIT 110 SEND_COMMAND dvDgx, "'?INPUT-VIDEO,',ITOA(OUT_CAMERA_FEED)"
    }
} 
DEFINE_FUNCTION fnDGXSwitchIn(INTEGER cIn, INTEGER cOut)
{
    SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(cOut)"
}                                                                     

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START

WAIT 250
{
    TIMELINE_CREATE(TL_FEEDBACK,lTLFeedback,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
	TIMELINE_CREATE(TL_FLASH,lTLFlash,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
    }

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, 61]
BUTTON_EVENT [vdvTP_Main, 62]
BUTTON_EVENT [vdvTP_Main, 63]
BUTTON_EVENT [vdvTP_Main, 64]
BUTTON_EVENT [vdvTP_Main, 65]
BUTTON_EVENT [vdvTP_Main, 66]
BUTTON_EVENT [vdvTP_Main, 67]
BUTTON_EVENT [vdvTP_Main, 68]
BUTTON_EVENT [vdvTP_Main, 69]
BUTTON_EVENT [vdvTP_Main, 70]
BUTTON_EVENT [vdvTP_Main, 71]
BUTTON_EVENT [vdvTP_Main, 72]
BUTTON_EVENT [vdvTP_Main, 73]
BUTTON_EVENT [vdvTP_Main, 74]
BUTTON_EVENT [vdvTP_Main, 75]
BUTTON_EVENT [vdvTP_Main, 76] //DGX Input Buttons (Manual Routing)...
{
    PUSH :
    {
	nSource_Input = BUTTON.INPUT.CHANNEL - 60
    }
}
BUTTON_EVENT [vdvTP_Main, 81]
BUTTON_EVENT [vdvTP_Main, 82]
BUTTON_EVENT [vdvTP_Main, 83]
BUTTON_EVENT [vdvTP_Main, 84]
BUTTON_EVENT [vdvTP_Main, 85]
BUTTON_EVENT [vdvTP_Main, 86]
BUTTON_EVENT [vdvTP_Main, 87]
BUTTON_EVENT [vdvTP_Main, 88]
BUTTON_EVENT [vdvTP_Main, 89]
BUTTON_EVENT [vdvTP_Main, 90]
BUTTON_EVENT [vdvTP_Main, 91]
BUTTON_EVENT [vdvTP_Main, 92]
BUTTON_EVENT [vdvTP_Main, 93]
BUTTON_EVENT [vdvTP_Main, 94]
BUTTON_EVENT [vdvTP_Main, 95]
BUTTON_EVENT [vdvTP_Main, 96] //DGX Output Buttons (Manual Routing)
{
    PUSH :
    {
	nSource_Outputs = BUTTON.INPUT.CHANNEL - 80
    
	fnDGXSwitchIn(nSource_Input, nSource_Outputs) //This makes the switch happen
	ON [vdvTP_Main, BUTTON.INPUT.CHANNEL]
	
	OFF [nSource_Outputs]
    }
}

DEFINE_EVENT
DATA_EVENT [dvDGX] 
{
    ONLINE :
    {
	WAIT 250
	{
	    CALL 'DGX SLOT NAME'
	}
    }
    COMMAND :
    {
	INTEGER cSlot1
	INTEGER cSlot2
	INTEGER cSlot3
	INTEGER cSlot5
	INTEGER cSlot6
	INTEGER cSlot9
	INTEGER cSlot10
	INTEGER cSlot11
	INTEGER cSlot16
	
	LOCAL_VAR CHAR cDebug[5]
	LOCAL_VAR CHAR cMsg[5]
    
	CHAR cData[19] // [ SWITCH-LVIDEOI12O14 ]
	cData = DATA.TEXT
	
	SELECT
	{
	    ACTIVE(FIND_STRING(cData,"'SWITCH-LVIDEOI'",1)): 
	    {
		REMOVE_STRING(cData,"'SWITCH-LVIDEOI'",1)
		
		cDebug = cData 
		cMsg = cData
		    IF (FIND_STRING(cMsg,"'O10'",1))  // 01 ~ 010
		    {
//			IF (LENGTH_STRING (cMsg) =5) //Must be Output 10! [ 1O10] This is the full string
//			{
			    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-3)
			    cSlot10 = ATOI(cMsg)
			
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_10),',0,',nSwitchInputNames[cSlot10]"
		    }
		    IF (FIND_STRING(cMsg,"'O1'",1)) //We can only be referencing Output 1 [ 1O1 ]
		    {
			
			    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-2)
			    cSlot1 = ATOI(cMsg)
			    
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_1),',0,',nSwitchInputNames[cSlot1]"
			
		    }
    		    IF (FIND_STRING(cMsg,"'O16'",1))  
		    {

			    cMsg = LEFT_STRING(cMsg,LENGTH_STRING(cMsg)-3)
			    cSlot16 = ATOI(cMsg)
			
			    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_16),',0,',nSwitchInputNames[cSlot16]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_PROJECTOR_RIGHT)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot2 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_2),',0,',nSwitchInputNames[cSlot2]"
		    }
		    IF (FIND_STRING(cData,"'O',ITOA(OUT_PROJECTOR_CENTER)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot3 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_3),',0,',nSwitchInputNames[cSlot3]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_DOWNSTAGE_LEFT)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot5 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_5),',0,',nSwitchInputNames[cSlot5]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_DOWNSTAGE_RIGHT)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot6 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_6),',0,',nSwitchInputNames[cSlot6]"
		    }
		    IF (FIND_STRING(cData,"'O',ITOA(OUT_DVX_9)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot9 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_9),',0,',nSwitchInputNames[cSlot9]"
		    }
		    IF(FIND_STRING(cData,"'O',ITOA(OUT_DVX_10)",1))
		    {
			cData = LEFT_STRING(cData,LENGTH_STRING(cData)-2)
			cSlot10 = ATOI(cData)
			
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_SLOT_10),',0,',nSwitchInputNames[cSlot10]"
		    }
		}
	}
    }
}

	
DEFINE_EVENT
TIMELINE_EVENT [TL_FLASH]
{
    iFLASH = !iFLASH
}
TIMELINE_EVENT [TL_FEEDBACK] 
{
   //Feedback Updating Here...
}



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM





(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

