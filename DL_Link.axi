PROGRAM_NAME='DL_Link'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 08/18/2018  AT: 09:21:08        *)
(***********************************************************)



DEFINE_DEVICE

vdvPipe =			33333:1:0 //Comm to DL Master...



DEFINE_CONSTANT

PROJECTOR_LEFT_ON			= 1
PROJECTOR_LEFT_OFF			= 2
PROJECTOR_LEFT_MUTE		= 3
SCREEN_LEFT_UP				= 4
SCREEN_LEFT_DN				= 5

PROJECTOR_RIGHT_ON		= 101
PROJECTOR_RIGHT_OFF		= 102
PROJECTOR_RIGHT_MUTE		= 103
SCREEN_RIGHT_UP				= 104
SCREEN_RIGHT_DN				= 105

PROJECTOR_REAR_ON			= 201
PROJECTOR_REAR_OFF			= 202
PROJECTOR_REAR_MUTE		= 203
SCREEN_REAR_UP				= 204
SCREEN_REAR_DN				= 205 

DL_PC_MAIN_LEFT 				= 11 //Input 1 DVI
DL_PC_EXTENDED_LEFT	 	= 12 //Input 2 DVI
DL_EXTERNAL_LEFT				= 13 //Input 3 DVI
DL_DOC_CAM_LEFT			= 14 //Input 4 DVI
DL_MERSIVE_LEFT				= 15 //Input 5 HDMI
DL_TIELINE_LEFT				= 18 //Input 8 HDMI
DL_TESTPAT_LEFT				= 20

DL_PC_MAIN_RIGHT 			= 111 //Input 1 DVI
DL_PC_EXTENDED_RIGHT	 	= 112 //Input 2 DVI
DL_EXTERNAL_RIGHT			= 113 //Input 3 DVI
DL_DOC_CAM_RIGHT			= 114 //Input 4 DVI
DL_MERSIVE_RIGHT			= 115 //Input 5 HDMI
DL_TIELINE_RIGHT				= 118 //Input 8 HDMI
DL_TESTPAT_RIGHT				= 120

DL_PC_MAIN_REAR			= 211 //Mirror Left Source
DL_PC_EXTENDED_REAR		= 212 //Notes
DL_EXTERNAL_REAR			= 213
DL_DOC_CAM_REAR			= 214
DL_MERSIVE_REAR				= 215
DL_TIELINE_REAR				= 218 //
DL_TESTPAT_REAR				= 220

DL_MODE_ON					= 255
DL_FOLLOW_LAST				= 256


DEFINE_VARIABLE


(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([vdvPipe, SCREEN_LEFT_UP], [vdvPipe, SCREEN_LEFT_DN])
([vdvPipe, DL_PC_MAIN_LEFT]..[vdvPipe, DL_TIELINE_LEFT]) //Front Left Source

([vdvPipe, SCREEN_RIGHT_UP], [vdvPipe, SCREEN_RIGHT_DN])
([vdvPipe, DL_PC_MAIN_RIGHT]..[vdvPipe, DL_TIELINE_RIGHT]) //Front Right Source

([vdvPipe, SCREEN_REAR_UP], [vdvPipe, SCREEN_REAR_DN])
([vdvPipe, DL_PC_MAIN_REAR]..[vdvPipe, DL_TIELINE_REAR]) //Front Right Source


DEFINE_START


DEFINE_EVENT
CHANNEL_EVENT [vdvPipe, PROJECTOR_LEFT_ON]			
CHANNEL_EVENT [vdvPipe, PROJECTOR_LEFT_OFF]		
CHANNEL_EVENT [vdvPipe, PROJECTOR_LEFT_MUTE]		
CHANNEL_EVENT [vdvPipe, SCREEN_LEFT_UP	]		
CHANNEL_EVENT [vdvPipe, SCREEN_LEFT_DN	]
CHANNEL_EVENT [vdvPipe, DL_PC_MAIN_LEFT]
CHANNEL_EVENT [vdvPipe,DL_PC_EXTENDED_LEFT]
CHANNEL_EVENT [vdvPipe,DL_EXTERNAL_LEFT]
CHANNEL_EVENT [vdvPipe,DL_DOC_CAM_LEFT]
CHANNEL_EVENT [vdvPipe,DL_MERSIVE_LEFT]
CHANNEL_EVENT [vdvPipe,DL_TIELINE_LEFT]
CHANNEL_EVENT [vdvPipe, DL_TESTPAT_LEFT] //Left Control / Source...
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE PROJECTOR_LEFT_ON : fnDisplayPWR ('PROJ LEFT ON')
	    CASE PROJECTOR_LEFT_OFF : fnDisplayPWR ('PROJ LEFT OFF')
	    CASE PROJECTOR_LEFT_MUTE :
	    {
		IF (!nMuteProjLeft)
		{
		    fnMuteDisplay(dvProjector_dxLeft, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteDisplay(dvProjector_dxLeft, SET_MUTE_OFF)
		}
	    
	    }
	    CASE SCREEN_LEFT_UP : fnRelayDirection(UP_LEFT)
	    CASE SCREEN_LEFT_DN : fnRelayDirection(DN_LEFT)
    
	//Video Switching
	    CASE DL_PC_MAIN_LEFT : fnSetDGXRouteLeft(IN_DESKTOP)
	    CASE DL_PC_EXTENDED_LEFT : fnSetDGXRouteLeft(IN_DESK_EXT)
	    CASE DL_EXTERNAL_LEFT : fnSetDGXRouteLeft(IN_EXTERNAL)
	    CASE DL_DOC_CAM_LEFT : fnSetDGXRouteLeft(IN_DOCCAM)
	    CASE DL_MERSIVE_LEFT : fnSetDGXRouteLeft(IN_AIRMEDIA)
	    CASE DL_TIELINE_LEFT : fnSetDGXRoutePreview(IN_DL_1,OUT_PROJLEFT)
	    CASE DL_TESTPAT_LEFT : 
	    {
		SEND_COMMAND dvProjector_dxLeft, "'VIDOUT_TESTPAT-Color Bar'"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_TESTPAT_LEFT :
	    {
		SEND_COMMAND dvProjector_dxLeft, "'VIDOUT_TESTPAT-off'"
	    }
	}
    }
}
CHANNEL_EVENT [vdvPipe, PROJECTOR_RIGHT_ON]			
CHANNEL_EVENT [vdvPipe, PROJECTOR_RIGHT_OFF]		
CHANNEL_EVENT [vdvPipe, PROJECTOR_RIGHT_MUTE]		
CHANNEL_EVENT [vdvPipe, SCREEN_RIGHT_UP	]		
CHANNEL_EVENT [vdvPipe, SCREEN_RIGHT_DN	]
CHANNEL_EVENT [vdvPipe, DL_PC_MAIN_RIGHT]
CHANNEL_EVENT [vdvPipe,DL_PC_EXTENDED_RIGHT]
CHANNEL_EVENT [vdvPipe,DL_EXTERNAL_RIGHT]
CHANNEL_EVENT [vdvPipe,DL_DOC_CAM_RIGHT]
CHANNEL_EVENT [vdvPipe,DL_MERSIVE_RIGHT]
CHANNEL_EVENT [vdvPipe,DL_TIELINE_RIGHT]
CHANNEL_EVENT [vdvPipe, DL_TESTPAT_RIGHT] //Right Control + Source...
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE PROJECTOR_RIGHT_ON : fnDisplayPWR ('PROJ RIGHT ON')
	    CASE PROJECTOR_RIGHT_OFF : fnDisplayPWR ('PROJ RIGHT OFF')
	    CASE PROJECTOR_RIGHT_MUTE :
	    {
		IF (!nMuteProjRight)
		{
		    fnMuteDisplay(dvProjector_dxRight, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteDisplay(dvProjector_dxRight, SET_MUTE_OFF)
		}
	    }
	    CASE SCREEN_RIGHT_UP : fnRelayDirection(UP_LEFT)
	    CASE SCREEN_RIGHT_DN : fnRelayDirection(DN_LEFT)
	    //Video Routing Calls...
	    CASE DL_PC_MAIN_RIGHT : fnSetDGXRouteRight(IN_DESKTOP)
	    CASE DL_PC_EXTENDED_RIGHT : fnSetDGXRouteRight(IN_DESK_EXT)
	    CASE DL_EXTERNAL_RIGHT : fnSetDGXRouteRight(IN_EXTERNAL)
	    CASE DL_DOC_CAM_RIGHT : fnSetDGXRouteRight(IN_DOCCAM)
	    CASE DL_MERSIVE_RIGHT : fnSetDGXRouteRight(IN_AIRMEDIA)
	    CASE DL_TIELINE_RIGHT : fnSetDGXRoutePreview(IN_DL_2,OUT_PROJRIGHT)
	    CASE DL_TESTPAT_RIGHT : 
	    {
		SEND_COMMAND dvProjector_dxRight, "'VIDOUT_TESTPAT-Color Bar'"
	    }
	}
    }
    OFF :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_TESTPAT_LEFT :
	    {
		SEND_COMMAND dvProjector_dxRight, "'VIDOUT_TESTPAT-off'"
	    }
	}
    }
}
CHANNEL_EVENT [vdvPipe, PROJECTOR_REAR_ON]			
CHANNEL_EVENT [vdvPipe, PROJECTOR_REAR_OFF]		
CHANNEL_EVENT [vdvPipe, PROJECTOR_REAR_MUTE]		
CHANNEL_EVENT [vdvPipe, SCREEN_REAR_UP	]		
CHANNEL_EVENT [vdvPipe, SCREEN_REAR_DN	]
CHANNEL_EVENT [vdvPipe, DL_PC_MAIN_REAR]
CHANNEL_EVENT [vdvPipe,DL_PC_EXTENDED_REAR]
CHANNEL_EVENT [vdvPipe,DL_EXTERNAL_REAR]
CHANNEL_EVENT [vdvPipe,DL_DOC_CAM_REAR]
CHANNEL_EVENT [vdvPipe,DL_MERSIVE_REAR]
CHANNEL_EVENT [vdvPipe,DL_TIELINE_REAR]
CHANNEL_EVENT [vdvPipe, DL_TESTPAT_REAR]
CHANNEL_EVENT [vdvPipe, DL_MODE_ON]
CHANNEL_EVENT [vdvPipe, DL_FOLLOW_LAST] //Rear Control + Source...
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE PROJECTOR_REAR_ON : fnDisplayPWR ('PROJ RIGHT ON')
	    CASE PROJECTOR_REAR_OFF : fnDisplayPWR ('PROJ RIGHT OFF')
	    CASE PROJECTOR_REAR_MUTE :
	    {
		IF (!nMuteProjRight)
		{
		    fnMuteDisplay(dvProjector_dxRight, SET_MUTE_ON)
		}
		ELSE
		{
		    fnMuteDisplay(dvProjector_dxRight, SET_MUTE_OFF)
		}
	    }
	    CASE DL_PC_MAIN_Rear :fnSetDGXRoutePreview(IN_DESKTOP,OUT_REAR)
	    CASE DL_PC_EXTENDED_RIGHT : fnSetDGXRoutePreview(IN_DESK_EXT,OUT_REAR)
	    CASE DL_EXTERNAL_REAR : fnSetDGXRoutePreview(IN_EXTERNAL,OUT_REAR)
	    CASE DL_DOC_CAM_REAR : fnSetDGXRoutePreview(IN_DOCCAM,OUT_REAR)
	    CASE DL_MERSIVE_REAR : fnSetDGXRoutePreview(IN_AIRMEDIA,OUT_REAR)
	    CASE DL_TIELINE_REAR : fnSetDGXRoutePreview(IN_DL_3,OUT_REAR)
	    CASE DL_TESTPAT_REAR : 
	    {
		SEND_COMMAND dvProjector_dxRear, "'VIDOUT_TESTPAT-Color Bar'"
	    }
	    //Modes...
	    CASE DL_MODE_ON :
	    {
		ON [nDLMode]
	    }
	    CASE DL_FOLLOW_LAST :
	    {
		ON [nDLFollow]
	    }
	}
    }
    OFF :
    {
	SWITCH(CHANNEL.CHANNEL)
	{
	    CASE DL_TESTPAT_LEFT :
	    {
		SEND_COMMAND dvProjector_dxRear, "'VIDOUT_TESTPAT-off'"
	    }
	    CASE DL_MODE_ON :
	    {
		OFF [nDLMode]
	    }
	    CASE DL_FOLLOW_LAST :
	    {
		OFF [nDLFollow]
	    }
	}
    }
}

DEFINE_EVENT
TIMELINE_EVENT [TL_MAINLINE] //Used from Main Source
{
    //Left...
     [vdvPipe,   PROJECTOR_LEFT_ON] =  [vdvProjector_Left, POWER]
    [vdvPipe, PROJECTOR_LEFT_OFF] = ![vdvProjector_Left, POWER]
   // [vdvPipe, PROJECTOR_LEFT_MUTE] = nMuteProjLeft
    [vdvPipe, 601] =	[vdvProjector_Left, ON_LINE]
    
    [vdvPipe, DL_PC_MAIN_LEFT] = nSource_Left = IN_DESKTOP
    [vdvPipe, DL_PC_EXTENDED_LEFT] = nSource_Left = IN_DESK_EXT
    [vdvPipe, DL_EXTERNAL_LEFT] = nSource_Left = IN_EXTERNAL
    [vdvPipe, DL_DOC_CAM_LEFT] = nSource_Left = IN_DOCCAM
    [vdvPipe, DL_MERSIVE_LEFT] = nSource_Left = IN_AIRMEDIA
    
    
    //Right...
    //Right Projector
    [vdvPipe, PROJECTOR_RIGHT_ON] = [vdvProjector_Right, POWER]
    [vdvPipe, PROJECTOR_RIGHT_OFF] = ![vdvProjector_Right, POWER]
   // [vdvPipe, PROJECTOR_RIGHT_MUTE] = nMuteProjRight
    [vdvPipe, 611] = [vdvProjector_Right, ON_LINE]
    
    //Rear
    //Rear Projector
    [vdvPipe, PROJECTOR_REAR_ON] = [vdvProjector_Rear, POWER]
    [vdvPipe, PROJECTOR_REAR_OFF] = ![vdvProjector_Rear, POWER]
   // [vdvPipe, PROJECTOR_REAR_MUTE] = nMuteProjRear
    [vdvPipe, 621] = [vdvProjector_Rear, ON_LINE]
    
}

DEFINE_EVENT
