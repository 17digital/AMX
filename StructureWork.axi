PROGRAM_NAME='StructureWork'


//fun with using Structures....



(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Structure 
dvTP_Structure =			10002:3:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

MAX_ALBUM_NAME_LENGTH = 24
MAX_ALBUM_SONG			= 12


(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _time
{
    INTEGER hour;
    INTEGER minute;
    INTEGER seconds;
}	

STRUCTURE _song
{
    CHAR title[MAX_ALBUM_NAME_LENGTH];
    _time ALBUMTIME; //Pull from other structure and Name it...
}



(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER TXT_ALBUM_TITLE[] =
{
    1,2,3,4,5,6
}

VOLATILE INTEGER TXT_ALBUM_TIME[] =
{
    11,12,13,14,15,16
}

_song uAlbumName[MAX_ALBUM_SONG];


(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

uAlbumName[1].title = 'Women'
uAlbumName[1].ALBUMTIME.minute = 5;
uAlbumName[1].ALBUMTIME.seconds	=42;

uAlbumName[2].title = 'Rocket'
uAlbumName[2].ALBUMTIME.minute = 3;
uAlbumName[2].ALBUMTIME.seconds	=42;

uAlbumName[3].title = 'Rocket Love'
uAlbumName[3].ALBUMTIME.minute = 4;
uAlbumName[3].ALBUMTIME.seconds	=2;

uAlbumName[4].title = 'Rocket Remix'
uAlbumName[4].ALBUMTIME.minute = 3;
uAlbumName[4].ALBUMTIME.seconds	=40;

uAlbumName[5].title = 'Rocket Remastered'
uAlbumName[5].ALBUMTIME.minute = 5;
uAlbumName[5].ALBUMTIME.seconds	=32;

uAlbumName[6].title = 'Rocket Deluxe Edition'
uAlbumName[6].ALBUMTIME.minute = 3;
uAlbumName[6].ALBUMTIME.seconds	=22;

uAlbumName[7].title = 'Rocket Unedited'
uAlbumName[7].ALBUMTIME.minute = 2;
uAlbumName[7].ALBUMTIME.seconds	=32;

(***********************************************************)
(*                  THE EVENTS GO BELOW                    *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT [dvTP_Structure]
{
    ONLINE :
    {
	STACK_VAR INTEGER iSong;
	 STACK_VAR CHAR iTimeFormated[20];
	
	FOR (iSong = 1; iSong<= MAX_LENGTH_ARRAY(TXT_ALBUM_TITLE); iSong++)
	{
	    SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ALBUM_TITLE[iSong]),',0,',uAlbumName[iSong].title "
	    
	    iTimeFormated = FORMAT(':%02d', uAlbumName[iSong].ALBUMTIME.seconds);
	    iTimeFormated = "ITOA(uAlbumName[iSong].ALBUMTIME.minute), iTimeFormated" //Append Minutes
	    
	    SEND_COMMAND DATA.DEVICE, "'^TXT-',ITOA(TXT_ALBUM_TIME[iSong]),',0,',iTimeFormated"
	}
    }
}




