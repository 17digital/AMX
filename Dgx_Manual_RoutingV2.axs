PROGRAM_NAME='Dgx_Manual_Routing'
(***********************************************************)
(*  FILE CREATED ON: 05/14/2020  AT: 10:49:32              *)
(***********************************************************)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/14/2020  AT: 13:09:50        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    DGX Manual Routing - This was created for the DGX-1600
    Manual Selected Input routed to output.
    On Touch panel create ch buttons to select inputs and outputs
    See Constant values below.
    Also this will Parse the return from DGX and read labels
    and place them on buttons.
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

DGX_REMOTE =				7112

dvTP_Router =				10001:1:0

dvDgx =	 				5002:1:DGX_REMOTE  //DGX 16 System in Rack

dvDGXSLOT_1 =				5002:1:DGX_REMOTE
dvDGXSLOT_2 =				5002:2:DGX_REMOTE
dvDGXSLOT_3 =				5002:3:DGX_REMOTE
dvDGXSLOT_4 =				5002:4:DGX_REMOTE
dvDGXSLOT_5 =				5002:5:DGX_REMOTE
dvDGXSLOT_6 =				5002:6:DGX_REMOTE
dvDGXSLOT_7 =				5002:7:DGX_REMOTE
dvDGXSLOT_8 =				5002:8:DGX_REMOTE
dvDGXSLOT_9 =				5002:9:DGX_REMOTE
dvDGXSLOT_10 =				5002:10:DGX_REMOTE
dvDGXSLOT_11 =				5002:11:DGX_REMOTE
dvDGXSLOT_12 =				5002:12:DGX_REMOTE
dvDGXSLOT_13 =				5002:13:DGX_REMOTE
dvDGXSLOT_14 =				5002:14:DGX_REMOTE
dvDGXSLOT_15 =				5002:15:DGX_REMOTE
dvDGXSLOT_16 =				5002:16:DGX_REMOTE

dvDGXSLOT_17 =				5002:17:DGX_REMOTE //For Balanced Audio Card Channels...
dvDGXSLOT_18 =				5002:18:DGX_REMOTE
dvDGXSLOT_19 =				5002:19:DGX_REMOTE
dvDGXSLOT_20 =				5002:20:DGX_REMOTE
dvDGXSLOT_21 =				5002:21:DGX_REMOTE
dvDGXSLOT_22 =				5002:22:DGX_REMOTE
dvDGXSLOT_23 =				5002:23:DGX_REMOTE
dvDGXSLOT_24 =				5002:24:DGX_REMOTE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//Buttons...
BTN_DGX_IN_1				= 2001
BTN_DGX_IN_2				= 2002
BTN_DGX_IN_3				= 2003
BTN_DGX_IN_4				= 2004
BTN_DGX_IN_5				= 2005
BTN_DGX_IN_6				= 2006
BTN_DGX_IN_7				= 2007
BTN_DGX_IN_8				= 2008
BTN_DGX_IN_9				= 2009
BTN_DGX_IN_10				= 2010
BTN_DGX_IN_11				= 2011
BTN_DGX_IN_12				= 2012
BTN_DGX_IN_13				= 2013
BTN_DGX_IN_14				= 2014
BTN_DGX_IN_15				= 2015
BTN_DGX_IN_16				= 2016

BTN_DGX_OUT_1				= 3001
BTN_DGX_OUT_2				= 3002
BTN_DGX_OUT_3				= 3003
BTN_DGX_OUT_4				= 3004
BTN_DGX_OUT_5				= 3005
BTN_DGX_OUT_6				= 3006
BTN_DGX_OUT_7				= 3007
BTN_DGX_OUT_8				= 3008
BTN_DGX_OUT_9				= 3009
BTN_DGX_OUT_10			= 3010
BTN_DGX_OUT_11			= 3011
BTN_DGX_OUT_12			= 3012
BTN_DGX_OUT_13			= 3013
BTN_DGX_OUT_14			= 3014
BTN_DGX_OUT_15			= 3015
BTN_DGX_OUT_16			= 3016

//Address Buttons...
BTN_DGX_VIEW_1			= 3050
BTN_DGX_VIEW_2			= 3051
BTN_DGX_VIEW_3			= 3052
BTN_DGX_VIEW_4			= 3053
BTN_DGX_VIEW_5			= 3054
BTN_DGX_VIEW_6			= 3055
BTN_DGX_VIEW_7			= 3056
BTN_DGX_VIEW_8			= 3057
BTN_DGX_VIEW_9			= 3058
BTN_DGX_VIEW_10			= 3059
BTN_DGX_VIEW_11			= 3060
BTN_DGX_VIEW_12			= 3061
BTN_DGX_VIEW_13			= 3062
BTN_DGX_VIEW_14			= 3063
BTN_DGX_VIEW_15			= 3064
BTN_DGX_VIEW_16			= 3065

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nSelectInput_
VOLATILE INTEGER nSelectOutput_

VOLATILE INTEGER nDgxReadBtns[] =
{
    BTN_DGX_VIEW_1,
    BTN_DGX_VIEW_2,
    BTN_DGX_VIEW_3,
    BTN_DGX_VIEW_4,
    BTN_DGX_VIEW_5,
    BTN_DGX_VIEW_6,
    BTN_DGX_VIEW_7,
    BTN_DGX_VIEW_8,
    BTN_DGX_VIEW_9,
    BTN_DGX_VIEW_10,
    BTN_DGX_VIEW_11,
    BTN_DGX_VIEW_12,
    BTN_DGX_VIEW_13,
    BTN_DGX_VIEW_14,
    BTN_DGX_VIEW_15,
    BTN_DGX_VIEW_16
}
VOLATILE INTEGER nDgxInputBtns[] =
{
    BTN_DGX_IN_1,		
    BTN_DGX_IN_2,		
    BTN_DGX_IN_3,		
    BTN_DGX_IN_4,		
    BTN_DGX_IN_5,				
    BTN_DGX_IN_6,			
    BTN_DGX_IN_7,				
    BTN_DGX_IN_8,				
    BTN_DGX_IN_9,				
    BTN_DGX_IN_10,				
    BTN_DGX_IN_11,				
    BTN_DGX_IN_12,				
    BTN_DGX_IN_13,
    BTN_DGX_IN_14,
    BTN_DGX_IN_15,
    BTN_DGX_IN_16
}
VOLATILE INTEGER nDgxOutputBtns[] =
{
    BTN_DGX_OUT_1,
    BTN_DGX_OUT_2,
    BTN_DGX_OUT_3,
    BTN_DGX_OUT_4,
    BTN_DGX_OUT_5,
    BTN_DGX_OUT_6,
    BTN_DGX_OUT_7,
    BTN_DGX_OUT_8,
    BTN_DGX_OUT_9,
    BTN_DGX_OUT_10,
    BTN_DGX_OUT_11,
    BTN_DGX_OUT_12,
    BTN_DGX_OUT_13,
    BTN_DGX_OUT_14,
    BTN_DGX_OUT_15,
    BTN_DGX_OUT_16
}
VOLATILE CHAR nDgxInputNames[16][25] = //Type in Your Input Labels for DGX
{
    'In Name 1',
    'In Name 2',
    'In Name 3',
    'In Name 4',
    'In Name 5',
    'In Name 6',
    'In Name 7',
    'In Name 8',
    'In Name 9',
    'In Name 10',
    'In Name 11',
    'In Name 12',
    'In Name 13',
    'In Name 14',
    'In Name 15',
    'In Name 16'
}
VOLATILE CHAR nDgxOutputName[16][25] =//Type in Your Output Labels for DGX
{
    'Out Name 1',
    'Out Name 2',
    'Out Name 3',
    'Out Name 4',
    'Out Name 5',
    'Out Name 6',
    'Out Name 7',
    'Out Name 8',
    'Out Name 9',
    'Out Name 10',
    'Out Name 11',
    'Out Name 12',
    'Out Name 13',
    'Out Name 14',
    'Out Name 15',
    'Out Name 16'
}
VOLATILE CHAR nDgxAudioOutName[8][25] = //Type in Audio Output Labels for DGX
{
    'Audio Mix Out',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used',
    'Not Used'
}
VOLATILE DEV dcDGXVideoSlots[] =
{
    dvDGXSLOT_1,
    dvDGXSLOT_2,
    dvDGXSLOT_3,
    dvDGXSLOT_4,
    dvDGXSLOT_5,
    dvDGXSLOT_6,
    dvDGXSLOT_7,
    dvDGXSLOT_8,
    dvDGXSLOT_9,
    dvDGXSLOT_10,
    dvDGXSLOT_11,
    dvDGXSLOT_12,
    dvDGXSLOT_13,
    dvDGXSLOT_14,
    dvDGXSLOT_15,
    dvDGXSLOT_16
}
VOLATILE DEV dcDGXAudioSlots[] =
{
    dvDGXSLOT_17,
    dvDGXSLOT_18,
    dvDGXSLOT_19,
    dvDGXSLOT_20,
    dvDGXSLOT_21,
    dvDGXSLOT_22,
    dvDGXSLOT_23,
    dvDGXSLOT_24
}
    
(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Router, BTN_DGX_IN_1]..[dvTP_Router, BTN_DGX_IN_16])
([dvTP_Router, BTN_DGX_OUT_1]..[dvTP_Router, BTN_DGX_OUT_16])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_FUNCTION fnLoadTPIOs()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(nDgxInputBtns); cLoop++)
    {
	SEND_COMMAND dvTP_Router, "'^TXT-',ITOA(nDgxInputBtns[cLoop]),',0,',ITOA(cLoop),$0A,$0D,nDgxInputNames[cLoop]"
	SEND_COMMAND dvTP_Router, "'^TXT-',ITOA(nDgxOutputBtns[cLoop]),',0,',ITOA(cLoop),$0A,$0D,nDgxOutputName[cLoop]"
	
	//Test w/ ^UTF- (For G5 X Series)
    }
}
DEFINE_FUNCTION fnLoadDGXVideoLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXVideoSlots); cLoop++)
    {
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDIN_NAME-',nDgxInputNames[cLoop]"
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'VIDOUT_NAME-',nDgxOutputName[cLoop]"
    }
}
DEFINE_FUNCTION fnLoadDGXAudioLabels()
{
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXAudioSlots); cLoop++)
    {
	SEND_COMMAND dcDGXAudioSlots[cLoop], "'AUDOUT_NAME-',nDgxAudioOutName[cLoop]"

    }
}
DEFINE_FUNCTION fnReadDGXRoutes()
{
    //This may be too fast....
    STACK_VAR INTEGER cLoop
    
    FOR (cLoop=1; cLoop<=MAX_LENGTH_ARRAY(dcDGXVideoSlots); cLoop++)
    {
	SEND_COMMAND dcDGXVideoSlots[cLoop], "'?INPUT-VIDEO,',ITOA(cLoop)"
    }
}
DEFINE_FUNCTION fnDGXSwitchIO(INTEGER cIn, INTEGER cOut)
{
    SEND_COMMAND dvDgx, "'VI',ITOA(cIn),'O',ITOA(cOut)"
}


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_1]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_2]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_3]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_4]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_5]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_6]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_7]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_8]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_9]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_10]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_11]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_12]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_13]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_14]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_15]
BUTTON_EVENT [dvTP_Router, BTN_DGX_IN_16]
{
    PUSH :
    {
	ON [dvTP_Router, BUTTON.INPUT.CHANNEL]
	    nSelectInput_ = BUTTON.INPUT.CHANNEL - 2000
    }
}
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_1]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_2]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_3]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_4]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_5]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_6]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_7]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_8]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_9]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_10]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_11]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_12]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_13]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_14]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_15]
BUTTON_EVENT [dvTP_Router, BTN_DGX_OUT_16]
{
    PUSH :
    {
	
	    nSelectOutput_ = BUTTON.INPUT.CHANNEL - 3000
	     ON [dvTP_Router, BUTTON.INPUT.CHANNEL]
	    
	    WAIT 5
	    {
		IF (nSelectInput_ > 0) //Must be something there...
		{
		    fnDGXSwitchIO(nSelectInput_, nSelectOutput_)
		   
		}
	    }
	    WAIT 20
	    {
		OFF [nSelectInput_] //Reset Variable After Selection
		OFF [nSelectOutput_]
		    TOTAL_OFF [dvTP_Router, nDgxInputBtns]
		    TOTAL_OFF [dvTP_Router, nDgxOutputBtns]
		    fnReadDGXRoutes() //may or may not need this. Feedback should be automatic
	    }
    }
}
DATA_EVENT [dvTP_Router]
{
    ONLINE :
    {
	WAIT 100
	{
	    fnLoadTPIOs()
	}
    }
}
DATA_EVENT [dvDGX] 
{
    ONLINE :
    {
	WAIT 250 fnLoadDGXVideoLabels()
	WAIT 300 fnLoadDGXAudioLabels()
	    
	WAIT 350 fnReadDGXRoutes()
    }
    COMMAND : //Parsing to Read Current Routes...
    {
	LOCAL_VAR CHAR cInput[5]
	LOCAL_VAR INTEGER cOutput
	LOCAL_VAR INTEGER cInSource 
	CHAR cGotIt[20]
	
	cGotIt = DATA.TEXT
	
	SELECT
	{
	    ACTIVE (FIND_STRING(cGotIt,"'SWITCH-LVIDEOI'",1)): //Parse Input Changes to Read what is selected
	    {
		REMOVE_STRING(cGotIt,"'SWITCH-LVIDEOI'",1)
		
		cInput = cGotIt //Should Read #O##
		
		REMOVE_STRING(cGotIt,"'O'",1) //Should only be left with Output #
		
		cOutput = ATOI(cGotIt)
		
		SWITCH (cOutput)
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
		    {
			cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-2)
			cInSource = ATOI(cInput)
			    SEND_COMMAND dvTP_Router, "'^TXT-',ITOA(nDgxReadBtns[cOutput]),',0,',nDgxInputNames[cInSource]"
		    }
		    CASE 10 :
		    CASE 11 :
		    CASE 12 :
		    CASE 13 :
		    CASE 14 :
		    CASE 15 :
		    CASE 16 :
		    {
			cInput = LEFT_STRING(cInput,LENGTH_STRING(cInput)-3)
			cInSource = ATOI(cInput)
			    SEND_COMMAND dvTP_Router, "'^TXT-',ITOA(nDgxReadBtns[cOutput]),',0,',nDgxInputNames[cInSource]"
		    }
		}
	    }
	}
    }
}
	
(*****************************************************************)
(*                                                               *)
(*                      !!!! WARNING !!!!                        *)
(*                                                               *)
(* Due to differences in the underlying architecture of the      *)
(* X-Series masters, changing variables in the DEFINE_PROGRAM    *)
(* section of code can negatively impact program performance.    *)
(*                                                               *)
(* See Differences in DEFINE_PROGRAM Program Execution section *)
(* of the NX-Series Controllers WebConsole & Programming Guide   *)
(* for additional and alternate coding methodologies.            *)
(*****************************************************************)

DEFINE_PROGRAM

(*****************************************************************)
(*                       END OF PROGRAM                          *)
(*                                                               *)
(*         !!!  DO NOT PUT ANY CODE BELOW THIS COMMENT  !!!      *)
(*                                                               *)
(*****************************************************************)


