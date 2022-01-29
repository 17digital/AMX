PROGRAM_NAME='DL_Link'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 08/18/2018  AT: 09:21:08        *)
(***********************************************************)


DEFINE_DEVICE


#IF_NOT_DEFINED vdvPipe
vdvPipe =			33333:1:0 //Comm From DL Master
#END_IF

#IF_NOT_DEFINED vdvPipeFB
vdvPipeFB =			33333:2:0 //Comm to DL Master...
#END_IF



DEFINE_CONSTANT

//Pipe Channels...
DL_SET_ALL_TVS_ON				= 1001
DL_SET_ALL_TVS_OFF				= 1000

#IF_NOT_DEFINED DL_MUTE_CEILING_MICS
DL_MUTE_CEILING_MICS			= 50 //to change led lighting + Mute...
#END_IF

//Front Left Sharp Display
DL_PWR_ON_LEFT					= 1
DL_PWR_OFF_LEFT					= 2
DL_PC_MAIN_LEFT 					= 11 
DL_PC_EXTENDED_LEFT	 			= 12 
DL_LECTERN_LEFT					= 13 
DL_DOC_CAM_LEFT				= 14 
DL_MERSIVE_LEFT					= 15
DL_KAPTIVO_LEFT					= 16
DL_LIGHT_BOARD_LEFT				= 18 
DL_TIELINE_1_LEFT					= 20
DL_TIELINE_2_LEFT					= 21
DL_TIELINE_3_LEFT					= 22

//Front Right Sharp Display
DL_PWR_ON_RIGHT				= 101
DL_PWR_OFF_RIGHT				= 102
DL_PC_MAIN_RIGHT 				= 111 
DL_PC_EXTENDED_RIGHT	 		= 112 
DL_LECTERN_RIGHT				= 113 
DL_DOC_CAM_RIGHT				= 114 
DL_MERSIVE_RIGHT				= 115 
DL_KAPTIVO_RIGHT				= 116
DL_LIGHT_BOARD_RIGHT			= 118 
DL_TIELINE_1_RIGHT				= 120
DL_TIELINE_2_RIGHT				= 121
DL_TIELINE_3_RIGHT				= 122
//Rear Left (Facing)
DL_PWR_ON_REAR_L				= 201
DL_PWR_OFF_REAR_L				= 202
DL_PC_MAIN_REAR_L				= 211 
DL_PC_EXTENDED_REAR_L			= 212 
DL_LECTERN_REAR_L				= 213
DL_DOC_CAM_REAR_L				= 214
DL_MERSIVE_REAR_L				= 215
DL_KAPTIVO_REAR_L				= 216
DL_LIGHT_BOARD_REAR_L			= 218 
DL_TIELINE_1_REAR_L				= 220
DL_TIELINE_2_REAR_L				= 221
DL_TIELINE_3_REAR_L				= 222
//Rear Right (Facing)
DL_PWR_ON_REAR_R				= 301
DL_PWR_OFF_REAR_R				= 302
DL_PC_MAIN_REAR_R				= 311 
DL_PC_EXTENDED_REAR_R			= 312 
DL_LECTERN_REAR_R				= 313
DL_DOC_CAM_REAR_R				= 314
DL_MERSIVE_REAR_R				= 315
DL_KAPTIVO_REAR_R				= 316
DL_LIGHT_BOARD_REAR_R			= 318 
DL_TIELINE_1_REAR_R				= 320
DL_TIELINE_2_REAR_R				= 321
DL_TIELINE_3_REAR_R				= 322
//Side Left(Teacher Facing)
DL_PWR_ON_SIDE_L				= 401
DL_PWR_OFF_SIDE_L				= 402
DL_PC_MAIN_SIDE_L				= 411 
DL_PC_EXTENDED_SIDE_L			= 412 
DL_LECTERN_SIDE_L				= 413
DL_DOC_CAM_SIDE_L				= 414
DL_MERSIVE_SIDE_L				= 415
DL_KAPTIVO_SIDE_L				= 416
DL_LIGHT_BOARD_SIDE_L			= 418 
DL_TIELINE_1_SIDE_L				= 420
DL_TIELINE_2_SIDE_L				= 421
DL_TIELINE_3_SIDE_L				= 422
//Side Left(Teacher Facing)
DL_PWR_ON_SIDE_R				= 701
DL_PWR_OFF_SIDE_R				= 702
DL_PC_MAIN_SIDE_R				= 711 
DL_PC_EXTENDED_SIDE_R			= 712 
DL_LECTERN_SIDE_R				= 713
DL_DOC_CAM_SIDE_R				= 714
DL_MERSIVE_SIDE_R				= 715
DL_KAPTIVO_SIDE_R				= 716
DL_LIGHT_BOARD_SIDE_R			= 718 
DL_TIELINE_1_SIDE_R				= 720
DL_TIELINE_2_SIDE_R				= 721
DL_TIELINE_3_SIDE_R				= 722
//DL Preview Monitor Buttons...
DL_PC_MAIN_PREVIEW				= 511 
DL_PC_EXTENDED_PREVIEW			= 512 
DL_LECTERN_PREVIEW				= 513
DL_DOC_CAM_PREVIEW				= 514
DL_MERSIVE_PREVIEW				= 515
DL_KAPTIVO_PREVIEW				= 516
DL_LIGHT_BOARD_PREVIEW			= 518

//End Pipe Channels

DEFINE_VARIABLE

VOLATILE INTEGER nDisplayFrontLeft
VOLATILE INTEGER nDisplayFrontRight
VOLATILE INTEGER nDisplayRearLeft
VOLATILE INTEGER nDisplayRearRight
VOLATILE INTEGER nDisplaySideLeft
VOLATILE INTEGER nDisplaySideRight
VOLATILE INTEGER nDLPreview

VOLATILE INTEGER dcChanFrontVidLeft[]  =
{
    DL_PC_MAIN_LEFT,
    DL_PC_EXTENDED_LEFT,
    DL_LECTERN_LEFT,
    DL_DOC_CAM_LEFT,
    DL_MERSIVE_LEFT,
    DL_KAPTIVO_LEFT,
    DL_LIGHT_BOARD_LEFT,
    DL_TIELINE_1_LEFT,
    DL_TIELINE_2_LEFT,
    DL_TIELINE_3_LEFT
}
VOLATILE INTEGER dcChanFrontVidRight[]  =
{
    DL_PC_MAIN_RIGHT,
    DL_PC_EXTENDED_RIGHT,
    DL_LECTERN_RIGHT,
    DL_DOC_CAM_RIGHT,
    DL_MERSIVE_RIGHT,
    DL_KAPTIVO_RIGHT,
    DL_LIGHT_BOARD_RIGHT,
    DL_TIELINE_1_RIGHT,
    DL_TIELINE_2_RIGHT,
    DL_TIELINE_3_RIGHT
}
VOLATILE INTEGER dcChanRearVidLeft[]  =
{
    DL_PC_MAIN_REAR_L,
    DL_PC_EXTENDED_REAR_L,
    DL_LECTERN_REAR_L,
    DL_DOC_CAM_REAR_L,
    DL_MERSIVE_REAR_L,
    DL_KAPTIVO_REAR_L,
    DL_LIGHT_BOARD_REAR_L,
    DL_TIELINE_1_REAR_L,
    DL_TIELINE_2_REAR_L,
    DL_TIELINE_3_REAR_L
}
VOLATILE INTEGER dcChanRearVidRight[]  =
{
    DL_PC_MAIN_REAR_R,
    DL_PC_EXTENDED_REAR_R,
    DL_LECTERN_REAR_R,
    DL_DOC_CAM_REAR_R,
    DL_MERSIVE_REAR_R,
    DL_KAPTIVO_REAR_R,
    DL_LIGHT_BOARD_REAR_R,
    DL_TIELINE_1_REAR_R,
    DL_TIELINE_2_REAR_R,
    DL_TIELINE_3_REAR_R
}
VOLATILE INTEGER dcChanSideVidLeft[]  =
{
    DL_PC_MAIN_SIDE_L,
    DL_PC_EXTENDED_SIDE_L,
    DL_LECTERN_SIDE_L,
    DL_DOC_CAM_SIDE_L,
    DL_MERSIVE_SIDE_L,
    DL_KAPTIVO_SIDE_L,
    DL_LIGHT_BOARD_SIDE_L,
    DL_TIELINE_1_SIDE_L,
    DL_TIELINE_2_SIDE_L,
    DL_TIELINE_3_SIDE_L
}
VOLATILE INTEGER dcChanSideVidRight[]  =
{
    DL_PC_MAIN_SIDE_R,
    DL_PC_EXTENDED_SIDE_R,
    DL_LECTERN_SIDE_R,
    DL_DOC_CAM_SIDE_R,
    DL_MERSIVE_SIDE_R,
    DL_KAPTIVO_SIDE_R,
    DL_LIGHT_BOARD_SIDE_R,
    DL_TIELINE_1_SIDE_R,
    DL_TIELINE_2_SIDE_R,
    DL_TIELINE_3_SIDE_R
}
VOLATILE INTEGER dcChanPreview[]  =
{
    DL_PC_MAIN_PREVIEW,
    DL_PC_EXTENDED_PREVIEW,
    DL_LECTERN_PREVIEW,
    DL_DOC_CAM_PREVIEW,
    DL_MERSIVE_PREVIEW,
    DL_KAPTIVO_PREVIEW,
    DL_LIGHT_BOARD_PREVIEW
}
DEVCHAN dcDLDefaultFB[] =
{
    { vdvPipeFB, DL_PC_MAIN_LEFT },
    { vdvPipeFB, DL_PC_EXTENDED_RIGHT },
    { vdvPipeFB, DL_PC_MAIN_REAR_L },
    { vdvPipeFB, DL_PC_MAIN_REAR_R },
    { vdvPipeFB, DL_PC_MAIN_SIDE_L },
    { vdvPipeFB, DL_PC_MAIN_SIDE_R }
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([vdvPipe, DL_PWR_ON_LEFT],[vdvPipe, DL_PWR_OFF_LEFT])
([vdvPipe, DL_PWR_ON_RIGHT],[vdvPipe, DL_PWR_OFF_RIGHT])
([vdvPipe, DL_PWR_ON_REAR_L],[vdvPipe, DL_PWR_OFF_REAR_L])
([vdvPipe, DL_PWR_ON_REAR_R],[vdvPipe, DL_PWR_OFF_REAR_R])
([vdvPipe, DL_PWR_ON_SIDE_L],[vdvPipe, DL_PWR_OFF_SIDE_L])
([vdvPipe, DL_PWR_ON_SIDE_R],[vdvPipe, DL_PWR_OFF_SIDE_R])

([vdvPipe, DL_PC_MAIN_LEFT]..[vdvPipe, DL_TIELINE_3_LEFT]) //Left Sources...
([vdvPipe, DL_PC_MAIN_RIGHT]..[vdvPipe, DL_TIELINE_3_RIGHT]) //Right Sources...
([vdvPipe, DL_PC_MAIN_REAR_L]..[vdvPipe, DL_TIELINE_3_REAR_L]) //
([vdvPipe, DL_PC_MAIN_REAR_R]..[vdvPipe, DL_TIELINE_3_REAR_R]) //
([vdvPipe, DL_PC_MAIN_SIDE_L]..[vdvPipe, DL_TIELINE_3_SIDE_L]) //
([vdvPipe, DL_PC_MAIN_SIDE_R]..[vdvPipe, DL_TIELINE_3_SIDE_R]) //
([vdvPipe, DL_PC_MAIN_PREVIEW]..[vdvPipe, DL_LIGHT_BOARD_PREVIEW]) //Preview Sources...

([vdvPipeFB, DL_PWR_ON_LEFT],[vdvPipeFB, DL_PWR_OFF_LEFT])
([vdvPipeFB, DL_PWR_ON_RIGHT],[vdvPipeFB, DL_PWR_OFF_RIGHT])
([vdvPipeFB, DL_PWR_ON_REAR_L],[vdvPipeFB, DL_PWR_OFF_REAR_L])
([vdvPipeFB, DL_PWR_ON_REAR_R],[vdvPipeFB, DL_PWR_OFF_REAR_R])
([vdvPipeFB, DL_PWR_ON_SIDE_L],[vdvPipeFB, DL_PWR_OFF_SIDE_L])
([vdvPipeFB, DL_PWR_ON_SIDE_R],[vdvPipeFB, DL_PWR_OFF_SIDE_R])

([vdvPipeFB, DL_PC_MAIN_LEFT]..[vdvPipeFB, DL_TIELINE_3_LEFT]) //Left Sources...
([vdvPipeFB, DL_PC_MAIN_RIGHT]..[vdvPipeFB, DL_TIELINE_3_RIGHT]) //Right Sources...
([vdvPipeFB, DL_PC_MAIN_REAR_L]..[vdvPipeFB, DL_TIELINE_3_REAR_L]) //
([vdvPipeFB, DL_PC_MAIN_REAR_R]..[vdvPipeFB, DL_TIELINE_3_REAR_R]) //
([vdvPipeFB, DL_PC_MAIN_SIDE_L]..[vdvPipeFB, DL_TIELINE_3_SIDE_L]) //
([vdvPipeFB, DL_PC_MAIN_SIDE_R]..[vdvPipeFB, DL_TIELINE_3_SIDE_R]) //
([vdvPipeFB, DL_PC_MAIN_PREVIEW]..[vdvPipeFB, DL_LIGHT_BOARD_PREVIEW]) //Preview Sources...


DEFINE_START

//This needs to be on DL- Master...
WAIT 50
{
    SET_VIRTUAL_PORT_COUNT(vdvPipe, 2) //Must Set this first in order for vdvPipeFB to set desired Channels! - since by default port 2 does not exist yet.
    WAIT 20
    {
	SET_VIRTUAL_CHANNEL_COUNT (vdvPipe, 1001)
	    SET_VIRTUAL_CHANNEL_COUNT (vdvPipeFB, 1001)
    }
	    
}

//file_write

DEFINE_EVENT
CHANNEL_EVENT [vdvPipe, DL_PWR_ON_LEFT]
CHANNEL_EVENT [vdvPipe, DL_PWR_OFF_LEFT] //Pwr On Left
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_PWR_ON_LEFT : fnPowerDisplays (BTN_PWR_ON_L)
	    CASE DL_PWR_OFF_LEFT : fnPowerDisplays (BTN_PWR_OFF_L)
	}
    }
}
CHANNEL_EVENT [vdvPipe, DL_PWR_ON_RIGHT]
CHANNEL_EVENT [vdvPipe, DL_PWR_OFF_RIGHT] //Pwr On Right
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_PWR_ON_RIGHT : fnPowerDisplays (BTN_PWR_ON_R)
	    CASE DL_PWR_OFF_RIGHT : fnPowerDisplays (BTN_PWR_OFF_R)
	}
    }
}
CHANNEL_EVENT [vdvPipe, DL_PWR_ON_REAR_L]
CHANNEL_EVENT [vdvPipe, DL_PWR_OFF_REAR_L]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	   CASE DL_PWR_ON_REAR_L : fnPowerDisplays (BTN_PWR_ON_REAR_L)
	    CASE DL_PWR_OFF_REAR_L : fnPowerDisplays (BTN_PWR_OFF_REAR_L)
	}
    }
}
CHANNEL_EVENT [vdvPipe, DL_PWR_ON_REAR_R]
CHANNEL_EVENT [vdvPipe, DL_PWR_OFF_REAR_R]
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_PWR_ON_REAR_R : fnPowerDisplays (BTN_PWR_ON_REAR_R)
	    CASE DL_PWR_OFF_REAR_R : fnPowerDisplays (BTN_PWR_OFF_REAR_R)
	}
    }
}
CHANNEL_EVENT [vdvPipe, DL_PWR_ON_SIDE_L]
CHANNEL_EVENT [vdvPipe, DL_PWR_OFF_SIDE_L] //Pwr Sides Left..
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_PWR_ON_SIDE_L : fnPowerDisplays (BTN_PWR_ON_SIDE_L)
	    CASE DL_PWR_OFF_SIDE_L : fnPowerDisplays (BTN_PWR_OFF_SIDE_L)
	}
    }
}
CHANNEL_EVENT [vdvPipe, DL_PWR_ON_SIDE_R]
CHANNEL_EVENT [vdvPipe, DL_PWR_OFF_SIDE_R] //Pwr Sides Right...
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_PWR_ON_SIDE_R : fnPowerDisplays (BTN_PWR_ON_SIDE_R)
	    CASE DL_PWR_OFF_SIDE_R : fnPowerDisplays (BTN_PWR_OFF_SIDE_R)
	}
    }
}
CHANNEL_EVENT [vdvPipe, dcChanFrontVidLeft] //Front Video Route..
{
    ON :
    {
	nDisplayFrontLeft = GET_LAST (dcChanFrontVidLeft)
	
	    fnRouteVideoScriptLeft(nStreamSend[nDisplayFrontLeft])
		ON [vdvPipeFB, dcChanFrontVidLeft[nDisplayFrontLeft]]
    }
}
CHANNEL_EVENT [vdvPipe, dcChanFrontVidRight] //Front Right Video Route..
{
    ON :
    {
	nDisplayFrontRight = GET_LAST (dcChanFrontVidRight)
	
	    fnRouteVideoScriptRight(nStreamSend[nDisplayFrontRight])
		ON [vdvPipeFB, dcChanFrontVidRight[nDisplayFrontRight]]
    }
}
CHANNEL_EVENT [vdvPipe, dcChanRearVidLeft] //Rear Left Video
{
    ON :
    {
	nDisplayRearLeft = GET_LAST (dcChanRearVidLeft)
	
	    fnRouteVideoRearLeft(nStreamSend[nDisplayRearLeft])
		ON [vdvPipeFB, dcChanRearVidLeft[nDisplayRearLeft]]
    }
}
CHANNEL_EVENT [vdvPipe, dcChanRearVidRight] //Rear Right Video
{
    ON :
    {
	nDisplayRearRight = GET_LAST (dcChanRearVidRight)
	
	    fnRouteVideoRearRight(nStreamSend[nDisplayRearRight])
		ON [vdvPipeFB, dcChanRearVidRight[nDisplayRearRight]]
    }
}
CHANNEL_EVENT [vdvPipe, dcChanSideVidLeft] //Side Left Video
{
    ON :
    {
	nDisplaySideLeft = GET_LAST (dcChanSideVidLeft)
	
	    fnRouteVideoSideLeft (nStreamSend[nDisplaySideLeft])
		ON [vdvPipeFB, dcChanSideVidLeft[nDisplaySideLeft]]
    }
}
CHANNEL_EVENT [vdvPipe, dcChanSideVidRight] //Side Right Video
{
    ON :
    {
	nDisplaySideRight = GET_LAST (dcChanSideVidRight)
	
	    fnRouteVideoSideRight (nStreamSend[nDisplaySideRight])
		ON [vdvPipeFB, dcChanSideVidRight[nDisplaySideRight]]
    }
}
CHANNEL_EVENT [vdvPipe, dcChanPreview] //DL Preview..
{
    ON :
    {
	nDLPreview = GET_LAST (dcChanPreview)
	
	    fnRouteVideoDLPreview (nStreamSend[nDLPreview])
		ON [vdvPipeFB, dcChanPreview[nDLPreview]]
    }
}
CHANNEL_EVENT [vdvPipe, DL_SET_ALL_TVS_OFF]
CHANNEL_EVENT [vdvPipe, DL_SET_ALL_TVS_ON] //Full Pwr On / Off
{
    ON :
    {
	SWITCH (CHANNEL.CHANNEL)
	{
	    CASE DL_SET_ALL_TVS_OFF : fnSystemCall (BTN_START_PRESENTATION)
	    CASE DL_SET_ALL_TVS_ON : fnSystemCall (BTN_TV_ALL_SHUT)

	}
    }
}
CHANNEL_EVENT [vdvPipe, DL_MUTE_CEILING_MICS] //Mute Classroom Mics...
{
    ON :
    {
	fnMuteLogic(TAG_CEILING, ID_CEILING, YES_ON)
    }
    OFF :
    {
	fnMuteLogic(TAG_CEILING, ID_CEILING, YES_OFF)
    }
}


