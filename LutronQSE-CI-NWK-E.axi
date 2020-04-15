PROGRAM_NAME='LutronLighting_'
(***********************************************************)
(*  FILE CREATED ON: 02/22/2019  AT: 19:00:28              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/13/2020  AT: 19:17:57        *)
(***********************************************************)


DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_MAIN
dvTP_MAIN   	= 		10001:1:0
#END_IF

#IF_NOT_DEFINED dvTP_Wall
dvTP_Wall =			10002:1:0
#END_IF

#IF_NOT_DEFINED dvLighting
dvLighting =			5001:6:0 //Lutron QSE-CI-NWK-E
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
LIGHT_ID_					= 'GIL1280WALL'
LIGHT_SERIAL_				= '00E9474B' //Serial Number on Wall Panel!


DEFINE_VARIABLE


VOLATILE CHAR nLightingBuffer[500]

VOLATILE INTEGER nLightSet_[] =
{
    SCENE_OFF,
    SCENE_ONE,
    SCENE_TWO,
    SCENE_THREE,
    SCENE_FOUR
}
VOLATILE INTEGER nLightingBtns[] =
{
    BTN_LIGHTING_1,
    BTN_LIGHTING_2,
    BTN_LIGHTING_3,
    BTN_LIGHTING_4,
    BTN_LIGHTING_5
}

DEFINE_MUTUALLY_EXCLUSIVE
([dvTP_MAIN, BTN_LIGHTING_1]..[dvTP_MAIN, BTN_LIGHTING_5])
([dvTP_Wall, BTN_LIGHTING_1]..[dvTP_Wall, BTN_LIGHTING_5])


DEFINE_START

CREATE_BUFFER dvLighting,nLightingBuffer;

DEFINE_EVENT
BUTTON_EVENT [vdvTP_Main, nLightingBtns]
{
    RELEASE :
    {
	//SEND_STRING dvLighting, "'#DEVICE,IC103WALL,141,7,3',CR,LF"
	SEND_STRING dvLighting, "'#DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),',',ITOA(nLightSet_[GET_LAST(nLightingBtns)]),CR,LF" 
    }
    HOLD [50] :
    {
	SEND_STRING dvLighting, "'#DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SAVE),',',ITOA(nLightSet_[GET_LAST(nLightingBtns)]),CR,LF"
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
	STACK_VAR CHAR cGrab [500]
	STACK_VAR INTEGER nScene
	LOCAL_VAR INTEGER cDbug
	LOCAL_VAR CHAR cCopy[100]
	
	WHILE(FIND_STRING(nLightingBuffer,"CR,LF",1))
	{
	    cGrab = REMOVE_STRING(nLightingBuffer,"CR,LF",1)
	
	    SELECT
	    {
		ACTIVE(FIND_STRING(cGrab,"'~DEVICE,',LIGHT_ID_,',141,7,'",1)):
		{
		    REMOVE_STRING(cGrab,"'~DEVICE,',LIGHT_ID_,',141,7,'",1)
		    cCopy = cGrab
		    nScene  = ATOI(cGrab) //Should just be left with Number!
		    cDbug = nScene
		    
		    
		    SWITCH (nScene)
		    {
			CASE 0 :
			{
			    ON [vdvTP_Main, BTN_LIGHTING_1]
			}
			CASE 1 :
			{
			    ON [vdvTP_Main, BTN_LIGHTING_2]
			}
			CASE 3 : 
			{
			    ON [vdvTP_Main, BTN_LIGHTING_4]
			}
			CASE 2 :
			{
			    ON [vdvTP_Main, BTN_LIGHTING_3]
			}
			CASE 4 :
			{
			    ON [vdvTP_Main, BTN_LIGHTING_5]
			}
		    }
		}
	    }
	}
    }
}
TIMELINE_EVENT [TL_FEEDBACK] //Defined on Main Program...
{
    
    WAIT ONE_MINUTE
    {
	SEND_STRING dvLighting, "'?DEVICE,',LIGHT_ID_,',',ITOA(SCENE_CONTROLLER),',',ITOA(SCENE_SET),CR,LF" 
    }
}

