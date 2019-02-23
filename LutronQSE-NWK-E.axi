PROGRAM_NAME='LutronLighting103_'
(***********************************************************)
(*  FILE CREATED ON: 02/22/2019  AT: 19:00:28              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 02/23/2019  AT: 07:55:45        *)
(***********************************************************)


DEFINE_DEVICE


#IF_NOT_DEFINED dvLighting
dvLighting =			5001:5:0 //Lutron QSE-CI-NWK-E
#END_IF




DEFINE_CONSTANT

#IF_NOT_DEFINED CR 
CR 						= 13
#END_IF

#IF_NOT_DEFINED LF 
LF 						= 10
#END_IF


BTN_LIGHTING_1				= 801
BTN_LIGHTING_2				= 802
BTN_LIGHTING_3				= 803
BTN_LIGHTING_4				= 804
BTN_LIGHTING_5				= 805

SCENE_OFF					= 0
SCENE_ONE					= 1 //All On
SCENE_TWO				= 2 //Presentaion
SCENE_THREE				= 3 //Show Video...
SCENE_FOUR				= 4
SCENE_FIVE				= 5
SCENE_CONTROLLER			= 141 //Page 75
SCENE_SET					= 7 //Page 76
SCENE_SAVE				= 12
LIGHT_ID_					= 'IC103WALL'
LIGHT_SERIAL_				= '01E38A34' //Serial Number on Wall Panel!


DEFINE_VARIABLE

VOLATILE INTEGER nLightSet_
VOLATILE CHAR nLightingBuffer[500]


DEFINE_START

CREATE_BUFFER dvLighting,nLightingBuffer;

DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, BTN_LIGHTING_1]
BUTTON_EVENT [vdvTP_Main, BTN_LIGHTING_2]
BUTTON_EVENT [vdvTP_Main, BTN_LIGHTING_3]
BUTTON_EVENT [vdvTP_Main, BTN_LIGHTING_4]
BUTTON_EVENT [vdvTP_Main, BTN_LIGHTING_5] //Call + Store Presets...
{
    RELEASE :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_LIGHTING_1 :
	    {
		//SEND_STRING dvLighting, "'#DEVICE,IC103WALL,141,7,3',CR,LF"
		SEND_STRING dvLighting, "'#DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),',',ITOA(SCENE_ONE),CR,LF" 
		nLightSet_ = SCENE_ONE
	    }
	    CASE BTN_LIGHTING_2 :
	    {
		SEND_STRING dvLighting, "'#DEVICE ,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),',',ITOA(SCENE_TWO),CR,LF" 
		nLightSet_ = SCENE_TWO
	    }
	    CASE BTN_LIGHTING_3 :
    	    {
		SEND_STRING dvLighting, "'#DEVICE,' ,LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),',',ITOA(SCENE_THREE),CR,LF" 
		nLightSet_ = SCENE_THREE
	    }
	    CASE BTN_LIGHTING_4 :
    	    {
		SEND_STRING dvLighting, "'#DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),',',ITOA(SCENE_FOUR),CR,LF" 
		nLightSet_ = SCENE_FOUR
	    }
	    CASE BTN_LIGHTING_5 :
	    {
		SEND_STRING dvLighting, "'#DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),',',ITOA(SCENE_FIVE),CR,LF" 
		nLightSet_ = SCENE_FIVE
	    }
	}
    }
    HOLD [50] :
    {
	SWITCH (BUTTON.INPUT.CHANNEL)
	{
	    CASE BTN_LIGHTING_1 :
	    CASE BTN_LIGHTING_2 :
	    CASE BTN_LIGHTING_3 :
	    CASE BTN_LIGHTING_4 :
	    CASE BTN_LIGHTING_5 :
	    {
		SEND_STRING dvLighting, "'#DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SAVE),',',ITOA(BUTTON.INPUT.CHANNEL - 800),CR,LF"
	    }
	}
    }
}
DATA_EVENT [dvLighting]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 115200,N,8,1'" //Default All Dispswitches Down
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	
	WAIT 250
	{
	    //Assign Integration ID to Serial #
	    SEND_STRING dvLighting, "'#INTEGRATIONID,1,0x',LIGHT_SERIAL_,',',LIGHT_ID_,CR,LF"
	}
    }
    STRING :
    {
	STACK_VAR CHAR cResponse [500]
	
	WHILE(FIND_STRING(nLightingBuffer,"CR,LF",1))
	{
	    cResponse = REMOVE_STRING(nLightingBuffer,"CR,LF",1)
	
	    SELECT
	    {
		ACTIVE(FIND_STRING(cResponse,'~DEVICE,IC103WALL,141,7,',1)):
		{
		    REMOVE_STRING(cResponse,'~DEVICE,IC103WALL,141,7,',1)
		    nLightSet_  = ATOI(cResponse) //Should just be left with Number!
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_MAINLINE] //Defined on Main Program...
{

    [vdvTP_Main, BTN_LIGHTING_1] = nLightSet_ = SCENE_ONE
    [vdvTP_Main, BTN_LIGHTING_2] = nLightSet_ = SCENE_TWO
    [vdvTP_Main, BTN_LIGHTING_3] = nLightSet_ = SCENE_THREE
    [vdvTP_Main, BTN_LIGHTING_4] = nLightSet_ = SCENE_FOUR
    [vdvTP_Main, BTN_LIGHTING_5] = nLightSet_ = SCENE_FIVE
    
    WAIT 650
    {
	SEND_STRING dvLighting, "'?DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),CR,LF" 
    }
}

