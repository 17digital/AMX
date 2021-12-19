//####  SNAPI.axi
//# Legal Notice :
//#    Copyright, AMX LLC, 2004-2008
//#    Private, proprietary information, the sole property of AMX LLC.  The
//#    contents, ideas, and concepts expressed herein are not to be disclosed
//#    except within the confines of a confidential relationship and only
//#    then on a need to know basis.
//#
//#    Any entity in possession of this AMX Software shall not, and shall not
//#    permit any other person to, disclose, display, loan, publish, transfer
//#    (whether by sale, assignment, exchange, gift, operation of law or
//#    otherwise), license, sublicense, copy, or otherwise disseminate this
//#    AMX Software.
//#
//#    This AMX Software is owned by AMX and is protected by United States
//#    copyright laws, patent laws, international treaty provisions, and/or
//#    state of Texas trade secret laws.
//#
//#    Portions of this AMX Software may, from time to time, include
//#    pre-release code and such code may not be at the level of performance,
//#    compatibility and functionality of the final code. The pre-release code
//#    may not operate correctly and may be substantially modified prior to
//#    final release or certain features may not be generally released. AMX is
//#    not obligated to make or support any pre-release code. All pre-release
//#    code is provided "as is" with no warranties.
//#
//#    This AMX Software is provided with restricted rights. Use, duplication,
//#    or disclosure by the Government is subject to restrictions as set forth
//#    in subparagraph (1)(ii) of The Rights in Technical Data and Computer
//#    Software clause at DFARS 252.227-7013 or subparagraphs (1) and (2) of
//#    the Commercial Computer Software Restricted Rights at 48 CFR 52.227-19,
//#    as applicable.
//####
PROGRAM_NAME='SNAPIConstants'
(***********************************************************)
(*{{PS_SOURCE_INFO(PROGRAM STATS)                          *)
(***********************************************************)
(*  ORPHAN_FILE_PLATFORM: 1                                *)
(***********************************************************)
(*}}PS_SOURCE_INFO                                         *)
(***********************************************************)
#IF_NOT_DEFINED __SNAPI_CONST__
#DEFINE __SNAPI_CONST__
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT // SNAPI Version

CHAR SNAPI_AXI_VERSION[]    = '1.14'

(***********************************************************)
(*                      Invalid Values                     *)
(***********************************************************)
                // Invalid Values

LONG INVALID_NUMBER         = $80000000
CHAR INVALID_STRING[]       = ''
CHAR INVALID_ENUM[]         = 'INVALID'

(***********************************************************)
(*                          Limits                         *)
(***********************************************************)
                // Limits

DUET_MIN_LEVEL_VALUE        = 0
DUET_MAX_LEVEL_VALUE        = 255

(***********************************************************)
(*                        Amplifier                        *)
(***********************************************************)
                // Amplifier Channels and Levels

// Amplifier Channels
POWER                  = 9     // Momentary: Cycle power
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
VOL_PRESET             = 138   // Momentary: Cycle volume preset
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Amplifier Levels
VOL_LVL                = 1     // Level: Volume level (0-255)

(***********************************************************)
(*                    Audio Conferencer                    *)
(***********************************************************)
                // Audio Conferencer Channels and Levels

// Audio Conferencer Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
ACONF_PRIVACY          = 145   // Momentary: Cycle privacy
ACONF_PRIVACY_ON       = 146   // Discrete:  Set privacy on or off
ACONF_PRIVACY_FB       = 146   // Feedback:  Privacy feedback
ACONF_TRAIN            = 147   // Momentary: Execute train
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
DIAL_REDIAL            = 201   // Momentary: Redial
DIAL_OFF_HOOK          = 202   // Momentary: Cycle off hook state
MENU_FLASH             = 203   // Momentary: Press menu button flash
DIAL_AUTO_ANSWER       = 204   // Momentary: Cycle auto answer state
DIAL_AUDIBLE_RING      = 205   // Momentary: Cycle audible ring state
DIAL_FLASH_HOOK        = 208   // Momentary: Flash hook
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
DIAL_OFF_HOOK_ON       = 238   // Discrete:  Set the dialer off or on hook
DIAL_OFF_HOOK_FB       = 238   // Feedback:  Dialer's hook state feedback
DIAL_AUTO_ANSWER_ON    = 239   // Discrete:  Set auto answer on or off
DIAL_AUTO_ANSWER_FB    = 239   // Feedback:  Auto answer state feedback
DIAL_AUDIBLE_RING_ON   = 240   // Discrete:  Set the audible ring state on or off
DIAL_AUDIBLE_RING_FB   = 240   // Feedback:  Audible ring state feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Audio Conferencer Levels
VOL_LVL                = 1     // Level: Volume level (0-255)

(***********************************************************)
(*                       Audio Mixer                       *)
(***********************************************************)
                // Audio Mixer Channels and Levels

// Audio Mixer Channels
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
VOL_PRESET             = 138   // Momentary: Cycle volume preset
GAIN_UP                = 140   // Ramping:   Ramp gain up
GAIN_UP_FB             = 140   // Feedback:  Gain ramping up feedback
GAIN_DN                = 141   // Ramping:   Ramp gain down
GAIN_DN_FB             = 141   // Feedback:  Gain ramping down feedback
GAIN_MUTE_ON           = 143   // Discrete:  Set gain mute on
GAIN_MUTE_FB           = 143   // Feedback:  Gain mute feedback
GAIN_MUTE              = 144   // Momentary: Cycle gain mute
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

// Audio Mixer Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
GAIN_LVL               = 5     // Level: Gain level (0-255)

(***********************************************************)
(*                     Audio Processor                     *)
(***********************************************************)
                // Audio Processor Channels and Levels

// Audio Processor Channels
POWER                  = 9     // Momentary: Cycle power
AUDIOPROC_LEVEL_UP     = 24    // Ramping:   Increment the audio processor level
AUDIOPROC_LEVEL_DN     = 25    // Ramping:   Decrement the audio processor level
AUDIOPROC_STATE        = 26    // Momentary: Cycle the audio processor state
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
AUDIOPROC_STATE_ON     = 199   // Discrete:  Set the audio processor state on or off
AUDIOPROC_STATE_FB     = 199   // Feedback:  Audio processor state feedback
AUDIOPROC_PRESET       = 209   // Momentary: Cycle the audio processor preset
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Audio Processor Levels
AUDIOPROC_LVL          = 1     // Level: Audio processor level (0-255)

(***********************************************************)
(*                        Audio Tape                       *)
(***********************************************************)
                // Audio Tape Channels and Levels

// Audio Tape Channels
PLAY                   = 1     // Momentary: Play
STOP                   = 2     // Momentary: Stop
PAUSE                  = 3     // Momentary: Pause
FFWD                   = 4     // Momentary: Fast forward
REW                    = 5     // Momentary: Rewind
SFWD                   = 6     // Momentary: Search forward
SREV                   = 7     // Momentary: Search reverse
RECORD                 = 8     // Momentary: Record
POWER                  = 9     // Momentary: Cycle power
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
CASS_REVERSE_PLAY      = 41    // Momentary: Reverse play
CASS_TAPE_SIDE         = 42    // Momentary: Cycle the audio tape side
SEARCH_SPEED           = 119   // Momentary: Cycle search speed
EJECT                  = 120   // Momentary: Eject tape
RESET_COUNTER          = 121   // Momentary: Reset counter
TAPE_LOADED_FB         = 122   // Feedback:  Tape is loaded
RECORD_LOCK_FB         = 123   // Feedback:  Tape record is locked
CASS_TAPE_SIDE_A       = 126   // Momentary: Set the tape side to A
CASS_TAPE_SIDE_A_FB    = 126   // Feedback:  Tape side set to A feedback
CASS_TAPE_SIDE_B       = 127   // Momentary: Set the tape side to B
CASS_TAPE_SIDE_B_FB    = 127   // Feedback:  Tape side set to B feedback
CASS_RECORD_MUTE       = 128   // Momentary: Cycle record mute
SLOW_FWD               = 188   // Momentary: Slow forward
SLOW_REV               = 189   // Momentary: Slow reverse
CASS_RECORD_MUTE_ON    = 200   // Discrete:  Set the record mute on or off
CASS_RECORD_MUTE_FB    = 200   // Feedback:  Record mute feedback
PLAY_FB                = 241   // Feedback:  Play feedback
STOP_FB                = 242   // Feedback:  Stop feedback
PAUSE_FB               = 243   // Feedback:  Pause feedback
FFWD_FB                = 244   // Feedback:  Fast forward feedback
REW_FB                 = 245   // Feedback:  Rewind feedback
SFWD_FB                = 246   // Feedback:  Search forward feedback
SREV_FB                = 247   // Feedback:  Search reverse feedback
RECORD_FB              = 248   // Feedback:  Record feedback
SLOW_FWD_FB            = 249   // Feedback:  Slow forward feedback
SLOW_REV_FB            = 250   // Feedback:  Slow reverse feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

(***********************************************************)
(*                    Audio Tuner Device                   *)
(***********************************************************)
                // Audio Tuner Device Channels and Levels

// Audio Tuner Device Channels
POWER                  = 9     // Momentary: Cycle power
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

(***********************************************************)
(*                          Camera                         *)
(***********************************************************)
                // Camera Channels and Levels

// Camera Channels
POWER                  = 9     // Momentary: Cycle power
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
TILT_UP                = 132   // Ramping:   Ramp tilt up
TILT_UP_FB             = 132   // Feedback:  Tilt ramp up feedback
TILT_DN                = 133   // Ramping:   Ramp tilt down
TILT_DN_FB             = 133   // Feedback:  Tilt ramp down feedback
PAN_LT                 = 134   // Ramping:   Ramp pan left
PAN_LT_FB              = 134   // Feedback:  Ramp pan left feedback
PAN_RT                 = 135   // Ramping:   Ramp pan right
PAN_RT_FB              = 135   // Feedback:  Ramp pan right feedback
ZOOM_OUT               = 158   // Ramping:   Ramp zoom out
ZOOM_OUT_FB            = 158   // Feedback:  Ramp zoom out feedback
ZOOM_IN                = 159   // Ramping:   Ramp zoom in
ZOOM_IN_FB             = 159   // Feedback:  Ramp zoom in feedback
FOCUS_NEAR             = 160   // Ramping:   Ramp focus near
FOCUS_NEAR_FB          = 160   // Feedback:  Ramp focus near feedback
FOCUS_FAR              = 161   // Ramping:   Ramp focus far
FOCUS_FAR_FB           = 161   // Feedback:  Focus ramp far feedback
AUTO_FOCUS_ON          = 162   // Discrete:  Set auto focus on or off
AUTO_FOCUS_FB          = 162   // Feedback:  Auto focus feedback
AUTO_IRIS_ON           = 163   // Discrete:  Set auto iris on or off
AUTO_IRIS_FB           = 163   // Feedback:  Auto iris feedback
AUTO_FOCUS             = 172   // Momentary: Cycle auto focus
AUTO_IRIS              = 173   // Momentary: Cycle auto iris
IRIS_OPEN              = 174   // Ramping:   Ramp iris open
IRIS_OPEN_FB           = 174   // Feedback:  Ramp iris open feedback
IRIS_CLOSE             = 175   // Ramping:   Ramp iris closed
IRIS_CLOSE_FB          = 175   // Feedback:  Ramp iris closed feedback
CAM_PRESET             = 177   // Momentary: Cycle camera preset
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Camera Levels
ZOOM_LVL               = 15    // Level: Zoom position ( 0=out/Wide, 255= in/Tele) 
FOCUS_LVL              = 16    // Level: Focus position (0=near, 255=far)
IRIS_LVL               = 17    // Level: Iris position (0=closed, 255=open)
ZOOM_SPEED_LVL         = 18    // Level: Zoom ramp speed (0-255) 
FOCUS_SPEED_LVL        = 19    // Level: Focus ramp speed (0-255)
IRIS_SPEED_LVL         = 20    // Level: Iris ramp speed (0-255) 
PAN_LVL                = 27    // Level: Pan position (0=left,255=right) 
TILT_LVL               = 28    // Level: Tilt position (0=down, 255=up) 
PAN_SPEED_LVL          = 29    // Level: Pan ramp speed (0-255)
TILT_SPEED_LVL         = 30    // Level: Tilt ramp speed (0-255) 

(***********************************************************)
(*                  Digital Media Decoder                  *)
(***********************************************************)
                // Digital Media Decoder Channels and Levels

// Digital Media Decoder Channels
PLAY                   = 1     // Momentary: Play
STOP                   = 2     // Momentary: Stop
PAUSE                  = 3     // Momentary: Pause
FFWD                   = 4     // Momentary: Goto the next track
REW                    = 5     // Momentary: Goto the previous track
SFWD                   = 6     // Momentary: Scan forward
SREV                   = 7     // Momentary: Scan reverse
RECORD                 = 8     // Momentary: Record
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MEDIA_RANDOM           = 124   // Momentary: Cycle the random state
MEDIA_REPEAT           = 125   // Momentary: Cycle the repeat state
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
MEDIA_RANDOM_DISC_ON   = 178   // Momentary: Set the random mode to disc
MEDIA_RANDOM_DISC_FB   = 178   // Feedback:  Random mode disc feedback
MEDIA_RANDOM_ALL_ON    = 179   // Momentary: Set the random mode to all
MEDIA_RANDOM_ALL_FB    = 179   // Feedback:  Random mode all feedback
MEDIA_RANDOM_OFF_ON    = 180   // Momentary: Set the random mode to off
MEDIA_RANDOM_OFF_FB    = 180   // Feedback:  Random mode off feedback
MEDIA_REPEAT_DISC_ON   = 181   // Momentary: Set the repeat mode to disc
MEDIA_REPEAT_DISC_FB   = 181   // Feedback:  Repeat mode disc feedback
MEDIA_REPEAT_TRACK_ON  = 182   // Momentary: Set the repeat mode to track
MEDIA_REPEAT_TRACK_FB  = 182   // Feedback:  Repeat mode track feedback
MEDIA_REPEAT_ALL_ON    = 183   // Momentary: Set the repeat mode to all
MEDIA_REPEAT_ALL_FB    = 183   // Feedback:  Repeat mode all feedback
MEDIA_REPEAT_OFF_ON    = 184   // Momentary: Set the repeat mode to off
MEDIA_REPEAT_OFF_FB    = 184   // Feedback:  Repeat mode off feedback
FRAME_FWD              = 185   // Momentary: Frame forward
FRAME_REV              = 186   // Momentary: Frame reverse
SLOW_FWD               = 188   // Momentary: Slow forward
SLOW_REV               = 189   // Momentary: Slow reverse
SCAN_SPEED             = 192   // Momentary: Cycle the scanning speed
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
PLAY_FB                = 241   // Feedback:  Play feedback
STOP_FB                = 242   // Feedback:  Stop feedback
PAUSE_FB               = 243   // Feedback:  Pause feedback
SFWD_FB                = 246   // Feedback:  Scan forward feedback
SREV_FB                = 247   // Feedback:  Scan reverse feedback
RECORD_FB              = 248   // Feedback:  Record feedback
SLOW_FWD_FB            = 249   // Feedback:  Slow forward feedback
SLOW_REV_FB            = 250   // Feedback:  Slow reverse feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Digital Media Decoder Levels
VOL_LVL                = 1     // Level: Volume level (0-255)

(***********************************************************)
(*                  Digital Media Encoder                  *)
(***********************************************************)
                // Digital Media Encoder Channels and Levels

// Digital Media Encoder Channels
PLAY                   = 1     // Momentary: Play
STOP                   = 2     // Momentary: Stop
PAUSE                  = 3     // Momentary: Pause
FFWD                   = 4     // Momentary: Goto the next track
REW                    = 5     // Momentary: Goto the previous track
SFWD                   = 6     // Momentary: Scan forward
SREV                   = 7     // Momentary: Scan reverse
RECORD                 = 8     // Momentary: Record
POWER                  = 9     // Momentary: Cycle power
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
GAIN_UP                = 140   // Ramping:   Ramp gain up
GAIN_UP_FB             = 140   // Feedback:  Gain ramping up feedback
GAIN_DN                = 141   // Ramping:   Ramp gain down
GAIN_DN_FB             = 141   // Feedback:  Gain ramping down feedback
GAIN_MUTE_ON           = 143   // Discrete:  Set gain mute on
GAIN_MUTE_FB           = 143   // Feedback:  Gain mute feedback
GAIN_MUTE              = 144   // Momentary: Cycle gain mute
FRAME_FWD              = 185   // Momentary: Frame forward
FRAME_REV              = 186   // Momentary: Frame reverse
SLOW_FWD               = 188   // Momentary: Slow forward
SLOW_REV               = 189   // Momentary: Slow reverse
SCAN_SPEED             = 192   // Momentary: Cycle the scanning speed
PLAY_FB                = 241   // Feedback:  Play feedback
STOP_FB                = 242   // Feedback:  Stop feedback
PAUSE_FB               = 243   // Feedback:  Pause feedback
SFWD_FB                = 246   // Feedback:  Scan forward feedback
SREV_FB                = 247   // Feedback:  Scan reverse feedback
RECORD_FB              = 248   // Feedback:  Record feedback
SLOW_FWD_FB            = 249   // Feedback:  Slow forward feedback
SLOW_REV_FB            = 250   // Feedback:  Slow reverse feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Digital Media Encoder Levels
GAIN_LVL               = 5     // Level: Gain level (0-255)

(***********************************************************)
(*                  Digital Media Server                   *)
(***********************************************************)
                // Digital Media Server Channels and Levels

// Digital Media Server Channels
PLAY                   = 1     // Momentary: Play
STOP                   = 2     // Momentary: Stop
PAUSE                  = 3     // Momentary: Pause
FFWD                   = 4     // Momentary: Goto the next track
REW                    = 5     // Momentary: Goto the previous track
SFWD                   = 6     // Momentary: Scan forward
SREV                   = 7     // Momentary: Scan reverse
RECORD                 = 8     // Momentary: Record
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MEDIA_RANDOM           = 124   // Momentary: Cycle the random state
MEDIA_REPEAT           = 125   // Momentary: Cycle the repeat state
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
GAIN_UP                = 140   // Ramping:   Ramp gain up
GAIN_UP_FB             = 140   // Feedback:  Gain ramping up feedback
GAIN_DN                = 141   // Ramping:   Ramp gain down
GAIN_DN_FB             = 141   // Feedback:  Gain ramping down feedback
GAIN_MUTE_ON           = 143   // Discrete:  Set gain mute on
GAIN_MUTE_FB           = 143   // Feedback:  Gain mute feedback
GAIN_MUTE              = 144   // Momentary: Cycle gain mute
MEDIA_RANDOM_DISC_ON   = 178   // Momentary: Set the random mode to disc
MEDIA_RANDOM_DISC_FB   = 178   // Feedback:  Random mode disc feedback
MEDIA_RANDOM_ALL_ON    = 179   // Momentary: Set the random mode to all
MEDIA_RANDOM_ALL_FB    = 179   // Feedback:  Random mode all feedback
MEDIA_RANDOM_OFF_ON    = 180   // Momentary: Set the random mode to off
MEDIA_RANDOM_OFF_FB    = 180   // Feedback:  Random mode off feedback
MEDIA_REPEAT_DISC_ON   = 181   // Momentary: Set the repeat mode to disc
MEDIA_REPEAT_DISC_FB   = 181   // Feedback:  Repeat mode disc feedback
MEDIA_REPEAT_TRACK_ON  = 182   // Momentary: Set the repeat mode to track
MEDIA_REPEAT_TRACK_FB  = 182   // Feedback:  Repeat mode track feedback
MEDIA_REPEAT_ALL_ON    = 183   // Momentary: Set the repeat mode to all
MEDIA_REPEAT_ALL_FB    = 183   // Feedback:  Repeat mode all feedback
MEDIA_REPEAT_OFF_ON    = 184   // Momentary: Set the repeat mode to off
MEDIA_REPEAT_OFF_FB    = 184   // Feedback:  Repeat mode off feedback
FRAME_FWD              = 185   // Momentary: Frame forward
FRAME_REV              = 186   // Momentary: Frame reverse
SLOW_FWD               = 188   // Momentary: Slow forward
SLOW_REV               = 189   // Momentary: Slow reverse
SCAN_SPEED             = 192   // Momentary: Cycle the scanning speed
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
PLAY_FB                = 241   // Feedback:  Play feedback
STOP_FB                = 242   // Feedback:  Stop feedback
PAUSE_FB               = 243   // Feedback:  Pause feedback
SFWD_FB                = 246   // Feedback:  Scan forward feedback
SREV_FB                = 247   // Feedback:  Scan reverse feedback
RECORD_FB              = 248   // Feedback:  Record feedback
SLOW_FWD_FB            = 249   // Feedback:  Slow forward feedback
SLOW_REV_FB            = 250   // Feedback:  Slow reverse feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Digital Media Server Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
GAIN_LVL               = 5     // Level: Gain level (0-255)

(***********************************************************)
(*                Digital Satellite System                 *)
(***********************************************************)
                // Digital Satellite System Channels and Levels

// Digital Satellite System Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
MENU_FLASH             = 203   // Momentary: Press menu button flash
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

(***********************************************************)
(*                  Digital Video Recorder                 *)
(***********************************************************)
                // Digital Video Recorder Channels and Levels

// Digital Video Recorder Channels
PLAY                   = 1     // Momentary: Play
STOP                   = 2     // Momentary: Stop
PAUSE                  = 3     // Momentary: Pause
FFWD                   = 4     // Momentary: Goto the next track
REW                    = 5     // Momentary: Goto the previous track
SFWD                   = 6     // Momentary: Scan forward
SREV                   = 7     // Momentary: Scan reverse
RECORD                 = 8     // Momentary: Record
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
FRAME_FWD              = 185   // Momentary: Frame forward
FRAME_REV              = 186   // Momentary: Frame reverse
SLOW_FWD               = 188   // Momentary: Slow forward
SLOW_REV               = 189   // Momentary: Slow reverse
SCAN_SPEED             = 192   // Momentary: Cycle the scanning speed
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
MENU_FLASH             = 203   // Momentary: Press menu button flash
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
PLAY_FB                = 241   // Feedback:  Play feedback
STOP_FB                = 242   // Feedback:  Stop feedback
PAUSE_FB               = 243   // Feedback:  Pause feedback
SFWD_FB                = 246   // Feedback:  Scan forward feedback
SREV_FB                = 247   // Feedback:  Scan reverse feedback
RECORD_FB              = 248   // Feedback:  Record feedback
SLOW_FWD_FB            = 249   // Feedback:  Slow forward feedback
SLOW_REV_FB            = 250   // Feedback:  Slow reverse feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

(***********************************************************)
(*                       Disc Device                       *)
(***********************************************************)
                // Disc Device Channels and Levels

// Disc Device Channels
PLAY                   = 1     // Momentary: Play
STOP                   = 2     // Momentary: Stop
PAUSE                  = 3     // Momentary: Pause
FFWD                   = 4     // Momentary: Goto the next track
REW                    = 5     // Momentary: Goto the previous track
SFWD                   = 6     // Momentary: Scan forward
SREV                   = 7     // Momentary: Scan reverse
RECORD                 = 8     // Momentary: Record
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
DISC_NEXT              = 55    // Momentary: Goto the next disc
DISC_PREV              = 56    // Momentary: Goto the previous disc
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
DISC_TRAY              = 120   // Momentary: Open/Close disc tray
DISC_RANDOM            = 124   // Momentary: Cycle the random state
DISC_REPEAT            = 125   // Momentary: Cycle the repeat state
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
DISC_RANDOM_DISC_ON    = 178   // Momentary: Set the random mode to disc
DISC_RANDOM_DISC_FB    = 178   // Feedback:  Random mode disc feedback
DISC_RANDOM_ALL_ON     = 179   // Momentary: Set the random mode to all
DISC_RANDOM_ALL_FB     = 179   // Feedback:  Random mode all feedback
DISC_RANDOM_OFF_ON     = 180   // Momentary: Set the random mode to off
DISC_RANDOM_OFF_FB     = 180   // Feedback:  Random mode off feedback
DISC_REPEAT_DISC_ON    = 181   // Momentary: Set the repeat mode to disc
DISC_REPEAT_DISC_FB    = 181   // Feedback:  Repeat mode disc feedback
DISC_REPEAT_TRACK_ON   = 182   // Momentary: Set the repeat mode to track
DISC_REPEAT_TRACK_FB   = 182   // Feedback:  Repeat mode track feedback
DISC_REPEAT_ALL_ON     = 183   // Momentary: Set the repeat mode to all
DISC_REPEAT_ALL_FB     = 183   // Feedback:  Repeat mode all feedback
DISC_REPEAT_OFF_ON     = 184   // Momentary: Set the repeat mode to off
DISC_REPEAT_OFF_FB     = 184   // Feedback:  Repeat mode off feedback
FRAME_FWD              = 185   // Momentary: Frame forward
FRAME_REV              = 186   // Momentary: Frame reverse
SLOW_FWD               = 188   // Momentary: Slow forward
SLOW_REV               = 189   // Momentary: Slow reverse
SCAN_SPEED             = 192   // Momentary: Cycle the scanning speed
MENU_FLASH             = 203   // Momentary: Press menu button flash
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
PLAY_FB                = 241   // Feedback:  Play feedback
STOP_FB                = 242   // Feedback:  Stop feedback
PAUSE_FB               = 243   // Feedback:  Pause feedback
SFWD_FB                = 246   // Feedback:  Scan forward feedback
SREV_FB                = 247   // Feedback:  Scan reverse feedback
RECORD_FB              = 248   // Feedback:  Record feedback
SLOW_FWD_FB            = 249   // Feedback:  Slow forward feedback
SLOW_REV_FB            = 250   // Feedback:  Slow reverse feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

(***********************************************************)
(*                         Display                         *)
(***********************************************************)
                // Display Channels and Levels

// Display Channels
POWER                  = 9     // Momentary: Cycle lamp power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set lamp power on
PWR_OFF                = 28    // Momentary: Set lamp power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
ASPECT_RATIO           = 142   // Momentary: Cycle aspect ratio
BRIGHT_UP              = 148   // Momentary: Increment brightness
BRIGHT_DN              = 149   // Momentary: Decrement brightness
COLOR_UP               = 150   // Momentary: Increment color
COLOR_DN               = 151   // Momentary: Decrement color
CONTRAST_UP            = 152   // Momentary: Increment contrast
CONTRAST_DN            = 153   // Momentary: Decrement contrast
SHARP_UP               = 154   // Momentary: Increment sharpness
SHARP_DN               = 155   // Momentary: Decrement sharpness
TINT_UP                = 156   // Momentary: Increment tint
TINT_DN                = 157   // Momentary: Decrement tint
PIP_POS                = 191   // Momentary: Cycle pip position
PIP_SWAP               = 193   // Momentary: Swap pip
PIP                    = 194   // Momentary: Cycle pip
PIP_ON                 = 195   // Discrete:  Set pip on
PIP_FB                 = 195   // Feedback:  Pip feedback
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
PIC_MUTE               = 210   // Momentary: Cycle picture/video mute
PIC_MUTE_ON            = 211   // Discrete:  Set picture/video mute on
PIC_MUTE_FB            = 211   // Feedback:  Picture/video mute feedback
PIC_FREEZE             = 213   // Momentary: Cycle freeze
PIC_FREEZE_ON          = 214   // Discrete:  Set freeze on
PIC_FREEZE_FB          = 214   // Feedback:  Freeze feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
LAMP_WARMING_FB        = 253   // Feedback:  Lamp is warming up
LAMP_COOLING_FB        = 254   // Feedback:  Lamp is cooling down
POWER_ON               = 255   // Discrete:  Set lamp power state
LAMP_POWER_FB          = 255   // Feedback:  Lamp power state feedback

// Display Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
BRIGHT_LVL             = 10    // Level: Brightness level (0-255)
COLOR_LVL              = 11    // Level: Color level (0-255)
CONTRAST_LVL           = 12    // Level: Contrast level (0-255)
SHARP_LVL              = 13    // Level: Sharpness level (0-255)
TINT_LVL               = 14    // Level: Tint level (0-255)

(***********************************************************)
(*                     Document Camera                     *)
(***********************************************************)
                // Document Camera Channels and Levels

// Document Camera Channels
POWER                  = 9     // Momentary: Cycle power
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
ZOOM_OUT               = 158   // Ramping:   Ramp zoom out
ZOOM_OUT_FB            = 158   // Feedback:  Ramp zoom out feedback
ZOOM_IN                = 159   // Ramping:   Ramp zoom in
ZOOM_IN_FB             = 159   // Feedback:  Ramp zoom in feedback
FOCUS_NEAR             = 160   // Ramping:   Ramp focus near
FOCUS_NEAR_FB          = 160   // Feedback:  Ramp focus near feedback
FOCUS_FAR              = 161   // Ramping:   Ramp focus far
FOCUS_FAR_FB           = 161   // Feedback:  Focus ramp far feedback
AUTO_FOCUS_ON          = 162   // Discrete:  Set auto focus on or off
AUTO_FOCUS_FB          = 162   // Feedback:  Auto focus feedback
AUTO_IRIS_ON           = 163   // Discrete:  Set auto iris on or off
AUTO_IRIS_FB           = 163   // Feedback:  Auto iris feedback
AUTO_FOCUS             = 172   // Momentary: Cycle auto focus
AUTO_IRIS              = 173   // Momentary: Cycle auto iris
IRIS_OPEN              = 174   // Ramping:   Ramp iris open
IRIS_OPEN_FB           = 174   // Feedback:  Ramp iris open feedback
IRIS_CLOSE             = 175   // Ramping:   Ramp iris closed
IRIS_CLOSE_FB          = 175   // Feedback:  Ramp iris closed feedback
DOCCAM_LIGHT           = 176   // Momentary: Cycle light
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
DOCCAM_LOWER_LIGHT_ON  = 197   // Discrete:  Set the lower light on or off
DOCCAM_LOWER_LIGHT_FB  = 197   // Feedback:  Lower light feedback
DOCCAM_UPPER_LIGHT_ON  = 198   // Discrete:  Set the upper light on or off
DOCCAM_UPPER_LIGHT_FB  = 198   // Feedback:  Upper light feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Document Camera Levels
ZOOM_LVL               = 15    // Level: Zoom position (0=out/Wide, 255=in/Tele)
FOCUS_LVL              = 16    // Level: Focus position (0=near, 255=far)
IRIS_LVL               = 17    // Level: Iris position (0=closed, 255=open)
ZOOM_SPEED_LVL         = 18    // Level: Zoom ramp speed (0-255)
FOCUS_SPEED_LVL        = 19    // Level: Focus ramp speed (0-255)
IRIS_SPEED_LVL         = 20    // Level: Iris ramp speed (0-255)

(***********************************************************)
(*                          HVAC                           *)
(***********************************************************)
                // HVAC Channels and Levels

// HVAC Channels
HVAC_COOL_UP           = 140   // Momentary: Increment cooling set point
HVAC_COOL_DN           = 141   // Momentary: Decrement cooling set point
HVAC_HEAT_UP           = 143   // Momentary: Increment heating set point
HVAC_HEAT_DN           = 144   // Momentary: Decrement heating set point
HVAC_HUMIDIFY_UP       = 148   // Momentary: Increment humidifier set point
HVAC_HUMIDIFY_DN       = 149   // Momentary: Decrement humidifier set point
HVAC_DEHUMIDIFY_UP     = 150   // Momentary: Increment dehumidifier set point
HVAC_DEHUMIDIFY_DN     = 151   // Momentary: Decrement dehumidifier set point
HVAC_HOLD_ON           = 211   // Discrete:  Set thermostat hold mode
HVAC_HOLD_FB           = 211   // Feedback:  Thermostat hold feedback
HVAC_LOCK_ON           = 212   // Discrete:  Set thermostat lock state
HVAC_LOCK_FB           = 212   // Feedback:  Thermostat lock state feedback
HVAC_FAN               = 213   // Momentary: Cycle fan state
HVAC_FAN_ON            = 214   // Momentary: Set fan state to on
HVAC_FAN_ON_FB         = 214   // Feedback:  Fan state on feedback
HVAC_FAN_AUTO          = 215   // Momentary: Set fan state to auto
HVAC_FAN_AUTO_FB       = 215   // Feedback:  Auto fan state feedback
HVAC_FAN_STATUS_FB     = 216   // Feedback:  Fan status state feedback
HVAC_HUMIDIFY_STATE    = 217   // Momentary: Cycle the humidify state
HVAC_STATE             = 218   // Momentary: Cycle HVAC state
HVAC_AUTO              = 219   // Momentary: Set HVAC state to automatic
HVAC_AUTO_FB           = 219   // Feedback:  HVAC auto feedback
HVAC_COOL              = 220   // Momentary: Set HVAC state to cooling
HVAC_COOL_FB           = 220   // Feedback:  HVAC cool feedback
HVAC_HEAT              = 221   // Momentary: Set HVAC state to heating
HVAC_HEAT_FB           = 221   // Feedback:  HVAC heat feedback
HVAC_OFF               = 222   // Momentary: Set HVAC state to off
HVAC_OFF_FB            = 222   // Feedback:  HVAC off feedback
HVAC_EHEAT             = 223   // Momentary: Set HVAC state to emergency heat
HVAC_EHEAT_FB          = 223   // Feedback:  HVAC emergency heat feedback
HVAC_COOLING_FB        = 224   // Feedback:  HVAC cooling status feedback
HVAC_HEATING_FB        = 225   // Feedback:  HVAC heating status feedback
HVAC_COOLING2_FB       = 226   // Feedback:  HVAC cooling 2 status feedback
HVAC_EHEATING_FB       = 227   // Feedback:  HVAC emergency heating status feedback
HVAC_HUMIDIFY_AUTO     = 228   // Momentary: Set the humidify state to auto
HVAC_HUMIDIFY_AUTO_FB  = 228   // Feedback:  Humidify state auto feedback
HVAC_DEHUMIDIFY        = 229   // Momentary: Set the humidify state to dehumidify
HVAC_DEHUMIDIFY_FB     = 229   // Feedback:  Dehumidify state feedback
HVAC_HUMIDIFY          = 230   // Momentary: Set the humidify state to humidify
HVAC_HUMIDIFY_FB       = 230   // Feedback:  Humidify state feedback
HVAC_HUMIDIFY_OFF      = 231   // Momentary: Set the humidify state to off
HVAC_HUMIDIFY_OFF_FB   = 231   // Feedback:  Humidify state off feedback
HVAC_DEHUMIDIFING_FB   = 232   // Feedback:  Dehumidify state status feedback
HVAC_HUMIDIFING_FB     = 233   // Feedback:  Humidify state status feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

// HVAC Levels
HVAC_COOL_LVL          = 31    // Level: Cooling set point, range is n..m degrees F or C
HVAC_HEAT_LVL          = 32    // Level: Heating set point, range is n..m degrees F or C
INDOOR_TEMP_LVL        = 33    // Level: Indoor temperature, range is n..m degrees F or C
OUTDOOR_TEMP_LVL       = 34    // Level: Outdoor temperature, range is n..m degrees F or C
INDOOR_HUMID_LVL       = 35    // Level: Indoor humidity, range is 0..100 percent
OUTDOOR_HUMID_LVL      = 36    // Level: Outdoor humidity, range is 0..100 percent
HVAC_HUMIDIFY_LVL      = 37    // Level: Humidifier set point, range is 0..100 percent
HVAC_DEHUMIDIFY_LVL    = 38    // Level: Dehumidifier set point, range is 0..100 percent

(***********************************************************)
(*                        IO Device                        *)
(***********************************************************)
                // IO Device Channels and Levels

// IO Device Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                          Keypad                         *)
(***********************************************************)
                // Keypad Channels and Levels

// Keypad Channels
KEYPAD_BTN1            = 1     // Discrete:  Keypad button 1 on
KEYPAD_BTN1_FB         = 1     // Input:     Keypad button 1 feedback
KEYPAD_BTN2            = 2     // Discrete:  Keypad button 2 on
KEYPAD_BTN2_FB         = 2     // Input:     Keypad button 2 feedback
KEYPAD_BTN3            = 3     // Discrete:  Keypad button 3 on
KEYPAD_BTN3_FB         = 3     // Input:     Keypad button 3 feedback
KEYPAD_BTN4            = 4     // Discrete:  Keypad button 4 on
KEYPAD_BTN4_FB         = 4     // Input:     Keypad button 4 feedback
KEYPAD_BTN5            = 5     // Discrete:  Keypad button 5 on
KEYPAD_BTN5_FB         = 5     // Input:     Keypad button 5 feedback
KEYPAD_BTN6            = 6     // Discrete:  Keypad button 6 on
KEYPAD_BTN6_FB         = 6     // Input:     Keypad button 6 feedback
KEYPAD_BTN7            = 7     // Discrete:  Keypad button 7 on
KEYPAD_BTN7_FB         = 7     // Input:     Keypad button 7 feedback
KEYPAD_BTN8            = 8     // Discrete:  Keypad button 8 on
KEYPAD_BTN8_FB         = 8     // Input:     Keypad button 8 feedback
KEYPAD_BTN9            = 9     // Discrete:  Keypad button 9 on
KEYPAD_BTN9_FB         = 9     // Input:     Keypad button 9 feedback
KEYPAD_BTN10           = 10    // Discrete:  Keypad button 10 on
KEYPAD_BTN10_FB        = 10    // Input:     Keypad button 10 feedback
KEYPAD_BTN1_BLINK      = 101   // Discrete:  Keypad button 1 blink
KEYPAD_BTN1_BLINK_FB   = 101   // Feedback:  Keypad button 1 blink feedback
KEYPAD_BTN2_BLINK      = 102   // Discrete:  Keypad button 2 blink
KEYPAD_BTN2_BLINK_FB   = 102   // Feedback:  Keypad button 2 blink feedback
KEYPAD_BTN3_BLINK      = 103   // Discrete:  Keypad button 3 blink
KEYPAD_BTN3_BLINK_FB   = 103   // Feedback:  Keypad button 3 blink feedback
KEYPAD_BTN4_BLINK      = 104   // Discrete:  Keypad button 4 blink
KEYPAD_BTN4_BLINK_FB   = 104   // Feedback:  Keypad button 4 blink feedback
KEYPAD_BTN5_BLINK      = 105   // Discrete:  Keypad button 5 blink
KEYPAD_BTN5_BLINK_FB   = 105   // Feedback:  Keypad button 5 blink feedback
KEYPAD_BTN6_BLINK      = 106   // Discrete:  Keypad button 6 blink
KEYPAD_BTN6_BLINK_FB   = 106   // Feedback:  Keypad button 6 blink feedback
KEYPAD_BTN7_BLINK      = 107   // Discrete:  Keypad button 7 blink
KEYPAD_BTN7_BLINK_FB   = 107   // Feedback:  Keypad button 7 blink feedback
KEYPAD_BTN8_BLINK      = 108   // Discrete:  Keypad button 8 blink
KEYPAD_BTN8_BLINK_FB   = 108   // Feedback:  Keypad button 8 blink feedback
KEYPAD_BTN9_BLINK      = 109   // Discrete:  Keypad button 9 blink
KEYPAD_BTN9_BLINK_FB   = 109   // Feedback:  Keypad button 9 blink feedback
KEYPAD_BTN10_BLINK     = 110   // Discrete:  Keypad button 10 blink
KEYPAD_BTN10_BLINK_FB  = 110   // Feedback:  Keypad button 10 blink feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                          Light                          *)
(***********************************************************)
                // Light Channels and Levels

// Light Channels
KEYPAD_BTN1            = 1     // Discrete:  Keypad button 1 on
KEYPAD_BTN1_FB         = 1     // Input:     Keypad button 1 feedback
KEYPAD_BTN2            = 2     // Discrete:  Keypad button 2 on
KEYPAD_BTN2_FB         = 2     // Input:     Keypad button 2 feedback
KEYPAD_BTN3            = 3     // Discrete:  Keypad button 3 on
KEYPAD_BTN3_FB         = 3     // Input:     Keypad button 3 feedback
KEYPAD_BTN4            = 4     // Discrete:  Keypad button 4 on
KEYPAD_BTN4_FB         = 4     // Input:     Keypad button 4 feedback
KEYPAD_BTN5            = 5     // Discrete:  Keypad button 5 on
KEYPAD_BTN5_FB         = 5     // Input:     Keypad button 5 feedback
KEYPAD_BTN6            = 6     // Discrete:  Keypad button 6 on
KEYPAD_BTN6_FB         = 6     // Input:     Keypad button 6 feedback
KEYPAD_BTN7            = 7     // Discrete:  Keypad button 7 on
KEYPAD_BTN7_FB         = 7     // Input:     Keypad button 7 feedback
KEYPAD_BTN8            = 8     // Discrete:  Keypad button 8 on
KEYPAD_BTN8_FB         = 8     // Input:     Keypad button 8 feedback
KEYPAD_BTN9            = 9     // Discrete:  Keypad button 9 on
KEYPAD_BTN9_FB         = 9     // Input:     Keypad button 9 feedback
KEYPAD_BTN10           = 10    // Discrete:  Keypad button 10 on
KEYPAD_BTN10_FB        = 10    // Input:     Keypad button 10 feedback
KEYPAD_BTN1_BLINK      = 101   // Discrete:  Keypad button 1 blink
KEYPAD_BTN1_BLINK_FB   = 101   // Feedback:  Keypad button 1 blink feedback
KEYPAD_BTN2_BLINK      = 102   // Discrete:  Keypad button 2 blink
KEYPAD_BTN2_BLINK_FB   = 102   // Feedback:  Keypad button 2 blink feedback
KEYPAD_BTN3_BLINK      = 103   // Discrete:  Keypad button 3 blink
KEYPAD_BTN3_BLINK_FB   = 103   // Feedback:  Keypad button 3 blink feedback
KEYPAD_BTN4_BLINK      = 104   // Discrete:  Keypad button 4 blink
KEYPAD_BTN4_BLINK_FB   = 104   // Feedback:  Keypad button 4 blink feedback
KEYPAD_BTN5_BLINK      = 105   // Discrete:  Keypad button 5 blink
KEYPAD_BTN5_BLINK_FB   = 105   // Feedback:  Keypad button 5 blink feedback
KEYPAD_BTN6_BLINK      = 106   // Discrete:  Keypad button 6 blink
KEYPAD_BTN6_BLINK_FB   = 106   // Feedback:  Keypad button 6 blink feedback
KEYPAD_BTN7_BLINK      = 107   // Discrete:  Keypad button 7 blink
KEYPAD_BTN7_BLINK_FB   = 107   // Feedback:  Keypad button 7 blink feedback
KEYPAD_BTN8_BLINK      = 108   // Discrete:  Keypad button 8 blink
KEYPAD_BTN8_BLINK_FB   = 108   // Feedback:  Keypad button 8 blink feedback
KEYPAD_BTN9_BLINK      = 109   // Discrete:  Keypad button 9 blink
KEYPAD_BTN9_BLINK_FB   = 109   // Feedback:  Keypad button 9 blink feedback
KEYPAD_BTN10_BLINK     = 110   // Discrete:  Keypad button 10 blink
KEYPAD_BTN10_BLINK_FB  = 110   // Feedback:  Keypad button 10 blink feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                       LightSystem                       *)
(***********************************************************)
                // LightSystem Channels and Levels

// LightSystem Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                         Monitor                         *)
(***********************************************************)
                // Monitor Channels and Levels

// Monitor Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
ASPECT_RATIO           = 142   // Momentary: Cycle aspect ratio
BRIGHT_UP              = 148   // Momentary: Increment brightness
BRIGHT_DN              = 149   // Momentary: Decrement brightness
COLOR_UP               = 150   // Momentary: Increment color
COLOR_DN               = 151   // Momentary: Decrement color
CONTRAST_UP            = 152   // Momentary: Increment contrast
CONTRAST_DN            = 153   // Momentary: Decrement contrast
SHARP_UP               = 154   // Momentary: Increment sharpness
SHARP_DN               = 155   // Momentary: Decrement sharpness
TINT_UP                = 156   // Momentary: Increment tint
TINT_DN                = 157   // Momentary: Decrement tint
PIP_POS                = 191   // Momentary: Cycle pip position
PIP_SWAP               = 193   // Momentary: Swap pip
PIP                    = 194   // Momentary: Cycle pip
PIP_ON                 = 195   // Discrete:  Set pip on
PIP_FB                 = 195   // Feedback:  Pip feedback
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
PIC_MUTE               = 210   // Momentary: Cycle picture/video mute
PIC_MUTE_ON            = 211   // Discrete:  Set picture/video mute on
PIC_MUTE_FB            = 211   // Feedback:  Picture/video mute feedback
PIC_FREEZE             = 213   // Momentary: Cycle freeze
PIC_FREEZE_ON          = 214   // Discrete:  Set freeze on
PIC_FREEZE_FB          = 214   // Feedback:  Freeze feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Monitor Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
BRIGHT_LVL             = 10    // Level: Brightness level (0-255)
COLOR_LVL              = 11    // Level: Color level (0-255)
CONTRAST_LVL           = 12    // Level: Contrast level (0-255)
SHARP_LVL              = 13    // Level: Sharpness level (0-255)
TINT_LVL               = 14    // Level: Tint level (0-255)

(***********************************************************)
(*                          Motor                          *)
(***********************************************************)
                // Motor Channels and Levels

// Motor Channels
MOTOR_STOP             = 2     // Momentary: Motor stop
MOTOR_STOP_FB          = 2     // Feedback:  Motor stop feedback
MOTOR_OPEN             = 4     // Momentary: Motor open
MOTOR_OPEN_FB          = 4     // Feedback:  Motor open feedback
MOTOR_CLOSE            = 5     // Momentary: Motor close
MOTOR_CLOSE_FB         = 5     // Feedback:  Motor close feedback
MOTOR_PRESET           = 187   // Momentary: Cycle motor preset
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

// Motor Levels
MOTOR_POS_LVL          = 6     // Level: Motor position (0=close, 255=open)

(***********************************************************)
(*                      Multi Window                       *)
(***********************************************************)
                // Multi Window Channels and Levels

// Multi Window Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
PAN_UP                 = 132   // Momentary: Pan up
PAN_DN                 = 133   // Momentary: Pan down
PAN_LT                 = 134   // Momentary: Pan left
PAN_RT                 = 135   // Momentary: Pan right
MULTIWIN_PRESET        = 136   // Momentary: Cycle multi-window preset
BRIGHT_UP              = 148   // Momentary: Increment brightness
BRIGHT_DN              = 149   // Momentary: Decrement brightness
COLOR_UP               = 150   // Momentary: Increment color
COLOR_DN               = 151   // Momentary: Decrement color
CONTRAST_UP            = 152   // Momentary: Increment contrast
CONTRAST_DN            = 153   // Momentary: Decrement contrast
SHARP_UP               = 154   // Momentary: Increment sharpness
SHARP_DN               = 155   // Momentary: Decrement sharpness
TINT_UP                = 156   // Momentary: Increment tint
TINT_DN                = 157   // Momentary: Decrement tint
ZOOM_OUT               = 158   // Momentary: Zoom out
ZOOM_IN                = 159   // Momentary: Zoom in
MENU_FLASH             = 203   // Momentary: Press menu button flash
PIC_MUTE               = 210   // Momentary: Cycle picture/video mute
PIC_MUTE_ON            = 211   // Discrete:  Set picture/video mute on
PIC_MUTE_FB            = 211   // Feedback:  Picture/video mute feedback
PIC_FREEZE             = 213   // Momentary: Cycle freeze
PIC_FREEZE_ON          = 214   // Discrete:  Set freeze on
PIC_FREEZE_FB          = 214   // Feedback:  Freeze feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Multi Window Levels
BRIGHT_LVL             = 10    // Level: Brightness level (0-255)
COLOR_LVL              = 11    // Level: Color level (0-255)
CONTRAST_LVL           = 12    // Level: Contrast level (0-255)
SHARP_LVL              = 13    // Level: Sharpness level (0-255)
TINT_LVL               = 14    // Level: Tint level (0-255)

(***********************************************************)
(*                        Pool Spa                         *)
(***********************************************************)
                // Pool Spa Channels and Levels

// Pool Spa Channels
POOL_HEAT              = 123   // Momentary: Cycle pool heat state
SPA_HEAT               = 124   // Momentary: Cycle spa heat state
SPA_JETS               = 125   // Momentary: Cycle spa jets
POOL_HEAT_UP           = 152   // Momentary: Increment pool setpoint
POOL_HEAT_DN           = 153   // Momentary: Decrement pool setpoint
SPA_HEAT_UP            = 154   // Momentary: Increment spa setpoint
SPA_HEAT_DN            = 155   // Momentary: Decrement spa setpoint
POOL_PUMP_ON           = 170   // Discrete:  Set pool pump state on or off
POOL_PUMP_FB           = 170   // Feedback:  Pool pump feedback
SPA_PUMP_ON            = 171   // Discrete:  Set spa pump state on or off
SPA_PUMP_FB            = 171   // Feedback:  Spa pump feedback
POOL_LIGHT_ON          = 172   // Discrete:  Set pool lights on or off
POOL_LIGHT_FB          = 172   // Feedback:  Pool light feedback
SPA_LIGHT_ON           = 173   // Discrete:  Set spa lights on or off
SPA_LIGHT_FB           = 173   // Feedback:  Spa light feedback
POOL_HEAT_OFF          = 174   // Momentary: Set pool heat to off
POOL_HEAT_OFF_FB       = 174   // Feedback:  Pool heat set to off feedback
POOL_HEATER            = 175   // Momentary: Set pool heat to heater
POOL_HEATER_FB         = 175   // Feedback:  Pool heat set to heater feedback
POOL_SOLAR             = 176   // Momentary: Set pool heat to solar preferred
POOL_SOLAR_FB          = 176   // Feedback:  Pool heat set to solar feedback
POOL_SOLAR_PREF        = 177   // Momentary: Set pool heat to solar preferred
POOL_SOLAR_PREF_FB     = 177   // Feedback:  Pool heat set to solar preferred feedback
SPA_HEAT_OFF           = 178   // Momentary: Set spa heat to off
SPA_HEAT_OFF_FB        = 178   // Feedback:  Set spa heat to off feedback
SPA_HEATER             = 179   // Momentary: Set spa heat to heater
SPA_HEATER_FB          = 179   // Feedback:  Set spa heat to heater feedback
SPA_SOLAR              = 180   // Momentary: Set spa heat to solar
SPA_SOLAR_FB           = 180   // Feedback:  Set spa heat to solar feedback
SPA_SOLAR_PREF         = 181   // Momentary: Set spa heat to solar preferred
SPA_SOLAR_PREF_FB      = 181   // Feedback:  Set spa heat to solar preferred feedback
SPA_JETS_OFF           = 182   // Momentary: Set spa jets to off
SPA_JETS_OFF_FB        = 182   // Feedback:  Spa jets off feedback
SPA_JETS_LO            = 183   // Momentary: Set spa jets to low
SPA_JETS_LO_FB         = 183   // Feedback:  Spa jets on low feedback
SPA_JETS_MED           = 184   // Momentary: Set spa jets to medium
SPA_JETS_MED_FB        = 184   // Feedback:  Spa jets on medium feedback
SPA_JETS_HI            = 185   // Momentary: Set spa jets to high
SPA_JETS_HI_FB         = 185   // Feedback:  Spa jets on high feedback
SPA_BLOWER_ON          = 186   // Discrete:  Set spa blower on or off
SPA_BLOWER_FB          = 186   // Feedback:  Spa blower feedback
POOL_HEATING           = 187   // Feedback:  Pool is heating using heater
POOL_HEATING_SOLAR     = 188   // Feedback:  Pool is heating using solar
SPA_HEATING            = 189   // Feedback:  Spa is heating using heater
SPA_HEATING_SOLAR      = 190   // Feedback:  Spa is heating using solar
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

// Pool Spa Levels
OUTDOOR_TEMP_LVL       = 34    // Level: Pool/Spa outdoor temperature, range is n..m degrees F or C
POOL_HEAT_LVL          = 39    // Level: Pool heating set point, range is n..m degrees F or C
SPA_HEAT_LVL           = 40    // Level: Spa heating set point, range is n..m degrees F or C
POOL_TEMP_LVL          = 41    // Level: Pool water temperature, range is n..m degrees F or C
SPA_TEMP_LVL           = 42    // Level: Spa water temperature, range is n..m degrees F or C

(***********************************************************)
(*            Pre Amp Surround Sound Processor             *)
(***********************************************************)
                // Pre Amp Surround Sound Processor Channels and Levels

// Pre Amp Surround Sound Processor Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
BALANCE_UP             = 164   // Ramping:   Increment balance
BALANCE_DN             = 165   // Ramping:   Decrement balance
BASS_UP                = 166   // Ramping:   Increment bass
BASS_DN                = 167   // Ramping:   Decrement bass
TREBLE_UP              = 168   // Ramping:   Increment treble 
TREBLE_DN              = 169   // Ramping:   Decrement treble
SURROUND_NEXT          = 170   // Momentary: Next surround sound mode
SURROUND_PREV          = 171   // Momentary: Previous surround sound mode
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
LOUDNESS               = 206   // Momentary: Cycle loudness
LOUDNESS_ON            = 207   // Discrete:  Set loudness state
LOUDNESS_FB            = 207   // Feedback:  Loudness state feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Pre Amp Surround Sound Processor Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
BALANCE_LVL            = 2     // Level: Balance level (0=left, 255=right)
BASS_LVL               = 3     // Level: Bass level (0-255)
TREBLE_LVL             = 4     // Level: Treble level (0-255)

(***********************************************************)
(*                        Receiver                         *)
(***********************************************************)
                // Receiver Channels and Levels

// Receiver Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
BALANCE_UP             = 164   // Ramping:   Increment balance
BALANCE_DN             = 165   // Ramping:   Decrement balance
BASS_UP                = 166   // Ramping:   Increment bass
BASS_DN                = 167   // Ramping:   Decrement bass
TREBLE_UP              = 168   // Ramping:   Increment treble 
TREBLE_DN              = 169   // Ramping:   Decrement treble
SURROUND_NEXT          = 170   // Momentary: Next surround sound mode
SURROUND_PREV          = 171   // Momentary: Previous surround sound mode
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
LOUDNESS               = 206   // Momentary: Cycle loudness
LOUDNESS_ON            = 207   // Discrete:  Set loudness state
LOUDNESS_FB            = 207   // Feedback:  Loudness state feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Receiver Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
BALANCE_LVL            = 2     // Level: Balance level (0=left, 255=right)
BASS_LVL               = 3     // Level: Bass level (0-255)
TREBLE_LVL             = 4     // Level: Treble level (0-255)

(***********************************************************)
(*                      Relay Device                       *)
(***********************************************************)
                // Relay Device Channels and Levels

// Relay Device Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                        RFIDSystem                       *)
(***********************************************************)
                // RFIDSystem Channels and Levels

// RFIDSystem Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                     Security System                     *)
(***********************************************************)
                // Security System Channels and Levels

// Security System Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                      Sensor Device                      *)
(***********************************************************)
                // Sensor Device Channels and Levels

// Sensor Device Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
SENSOR_FB              = 255   // Feedback:  Sensor feedback

// Sensor Device Levels
SENSOR_VALUE           = 7     // Level: Sensor value

(***********************************************************)
(*                        Settop Box                       *)
(***********************************************************)
                // Settop Box Channels and Levels

// Settop Box Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
CABLE_AB               = 42    // Momentary: Cycle AB switch
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
CABLE_B_ON             = 212   // Discrete:  Set B switch on or off
CABLE_B_FB             = 212   // Feedback:  AB switch feedback 
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Settop Box Levels
VOL_LVL                = 1     // Level: Volume level (0-255)

(***********************************************************)
(*                     Slide Projector                     *)
(***********************************************************)
                // Slide Projector Channels and Levels

// Slide Projector Channels
SLIDE_NEXT             = 4     // Momentary: Goto next slide
SLIDE_PREV             = 5     // Momentary: Goto previous slide
POWER                  = 9     // Momentary: Cycle lamp power
PWR_ON                 = 27    // Momentary: Set lamp power on
PWR_OFF                = 28    // Momentary: Set lamp power off
FOCUS_NEAR             = 160   // Ramping:   Ramp focus near
FOCUS_NEAR_FB          = 160   // Feedback:  Ramp focus near feedback
FOCUS_FAR              = 161   // Ramping:   Ramp focus far
FOCUS_FAR_FB           = 161   // Feedback:  Ramp focus far feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
LAMP_WARMING_FB        = 253   // Feedback:  Lamp is warming up
LAMP_COOLING_FB        = 254   // Feedback:  Lamp is cooling down
POWER_ON               = 255   // Discrete:  Set lamp power state
LAMP_POWER_FB          = 255   // Feedback:  Lamp power state feedback

(***********************************************************)
(*                        Switcher                         *)
(***********************************************************)
                // Switcher Channels and Levels

// Switcher Channels
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
VOL_PRESET             = 138   // Momentary: Cycle volume preset
GAIN_UP                = 140   // Ramping:   Ramp gain up
GAIN_UP_FB             = 140   // Feedback:  Gain ramping up feedback
GAIN_DN                = 141   // Ramping:   Ramp gain down
GAIN_DN_FB             = 141   // Feedback:  Gain ramping down feedback
GAIN_MUTE_ON           = 143   // Discrete:  Set gain mute on
GAIN_MUTE_FB           = 143   // Feedback:  Gain mute feedback
GAIN_MUTE              = 144   // Momentary: Cycle gain mute
BALANCE_UP             = 164   // Ramping:   Increment balance
BALANCE_DN             = 165   // Ramping:   Decrement balance
BASS_UP                = 166   // Ramping:   Increment bass
BASS_DN                = 167   // Ramping:   Decrement bass
TREBLE_UP              = 168   // Ramping:   Increment treble 
TREBLE_DN              = 169   // Ramping:   Decrement treble
SURROUND_NEXT          = 170   // Momentary: Next surround sound mode
SURROUND_PREV          = 171   // Momentary: Previous surround sound mode
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
LOUDNESS               = 206   // Momentary: Cycle loudness
LOUDNESS_ON            = 207   // Discrete:  Set loudness state
LOUDNESS_FB            = 207   // Feedback:  Loudness state feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

// Switcher Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
BALANCE_LVL            = 2     // Level: Balance level (0=left, 255=right)
BASS_LVL               = 3     // Level: Bass level (0-255)
TREBLE_LVL             = 4     // Level: Treble level (0-255)
GAIN_LVL               = 5     // Level: Gain level (0-255)

(***********************************************************)
(*                       Text Keypad                       *)
(***********************************************************)
                // Text Keypad Channels and Levels

// Text Keypad Channels
KEYPAD_BTN1            = 1     // Discrete:  Keypad button 1 on
KEYPAD_BTN1_FB         = 1     // Input:     Keypad button 1 feedback
KEYPAD_BTN2            = 2     // Discrete:  Keypad button 2 on
KEYPAD_BTN2_FB         = 2     // Input:     Keypad button 2 feedback
KEYPAD_BTN3            = 3     // Discrete:  Keypad button 3 on
KEYPAD_BTN3_FB         = 3     // Input:     Keypad button 3 feedback
KEYPAD_BTN4            = 4     // Discrete:  Keypad button 4 on
KEYPAD_BTN4_FB         = 4     // Input:     Keypad button 4 feedback
KEYPAD_BTN5            = 5     // Discrete:  Keypad button 5 on
KEYPAD_BTN5_FB         = 5     // Input:     Keypad button 5 feedback
KEYPAD_BTN6            = 6     // Discrete:  Keypad button 6 on
KEYPAD_BTN6_FB         = 6     // Input:     Keypad button 6 feedback
KEYPAD_BTN7            = 7     // Discrete:  Keypad button 7 on
KEYPAD_BTN7_FB         = 7     // Input:     Keypad button 7 feedback
KEYPAD_BTN8            = 8     // Discrete:  Keypad button 8 on
KEYPAD_BTN8_FB         = 8     // Input:     Keypad button 8 feedback
KEYPAD_BTN9            = 9     // Discrete:  Keypad button 9 on
KEYPAD_BTN9_FB         = 9     // Input:     Keypad button 9 feedback
KEYPAD_BTN10           = 10    // Discrete:  Keypad button 10 on
KEYPAD_BTN10_FB        = 10    // Input:     Keypad button 10 feedback
KEYPAD_BTN1_BLINK      = 101   // Discrete:  Keypad button 1 blink
KEYPAD_BTN1_BLINK_FB   = 101   // Feedback:  Keypad button 1 blink feedback
KEYPAD_BTN2_BLINK      = 102   // Discrete:  Keypad button 2 blink
KEYPAD_BTN2_BLINK_FB   = 102   // Feedback:  Keypad button 2 blink feedback
KEYPAD_BTN3_BLINK      = 103   // Discrete:  Keypad button 3 blink
KEYPAD_BTN3_BLINK_FB   = 103   // Feedback:  Keypad button 3 blink feedback
KEYPAD_BTN4_BLINK      = 104   // Discrete:  Keypad button 4 blink
KEYPAD_BTN4_BLINK_FB   = 104   // Feedback:  Keypad button 4 blink feedback
KEYPAD_BTN5_BLINK      = 105   // Discrete:  Keypad button 5 blink
KEYPAD_BTN5_BLINK_FB   = 105   // Feedback:  Keypad button 5 blink feedback
KEYPAD_BTN6_BLINK      = 106   // Discrete:  Keypad button 6 blink
KEYPAD_BTN6_BLINK_FB   = 106   // Feedback:  Keypad button 6 blink feedback
KEYPAD_BTN7_BLINK      = 107   // Discrete:  Keypad button 7 blink
KEYPAD_BTN7_BLINK_FB   = 107   // Feedback:  Keypad button 7 blink feedback
KEYPAD_BTN8_BLINK      = 108   // Discrete:  Keypad button 8 blink
KEYPAD_BTN8_BLINK_FB   = 108   // Feedback:  Keypad button 8 blink feedback
KEYPAD_BTN9_BLINK      = 109   // Discrete:  Keypad button 9 blink
KEYPAD_BTN9_BLINK_FB   = 109   // Feedback:  Keypad button 9 blink feedback
KEYPAD_BTN10_BLINK     = 110   // Discrete:  Keypad button 10 blink
KEYPAD_BTN10_BLINK_FB  = 110   // Feedback:  Keypad button 10 blink feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                            TV                           *)
(***********************************************************)
                // TV Channels and Levels

// TV Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
ASPECT_RATIO           = 142   // Momentary: Cycle aspect ratio
BRIGHT_UP              = 148   // Momentary: Increment brightness
BRIGHT_DN              = 149   // Momentary: Decrement brightness
COLOR_UP               = 150   // Momentary: Increment color
COLOR_DN               = 151   // Momentary: Decrement color
CONTRAST_UP            = 152   // Momentary: Increment contrast
CONTRAST_DN            = 153   // Momentary: Decrement contrast
SHARP_UP               = 154   // Momentary: Increment sharpness
SHARP_DN               = 155   // Momentary: Decrement sharpness
TINT_UP                = 156   // Momentary: Increment tint
TINT_DN                = 157   // Momentary: Decrement tint
PIP_POS                = 191   // Momentary: Cycle pip position
PIP_SWAP               = 193   // Momentary: Swap pip
PIP                    = 194   // Momentary: Cycle pip
PIP_ON                 = 195   // Discrete:  Set pip on
PIP_FB                 = 195   // Feedback:  Pip feedback
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
PIC_MUTE               = 210   // Momentary: Cycle picture/video mute
PIC_MUTE_ON            = 211   // Discrete:  Set picture/video mute on
PIC_MUTE_FB            = 211   // Feedback:  Picture/video mute feedback
PIC_FREEZE             = 213   // Momentary: Cycle freeze
PIC_FREEZE_ON          = 214   // Discrete:  Set freeze on
PIC_FREEZE_FB          = 214   // Feedback:  Freeze feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// TV Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
BRIGHT_LVL             = 10    // Level: Brightness level (0-255)
COLOR_LVL              = 11    // Level: Color level (0-255)
CONTRAST_LVL           = 12    // Level: Contrast level (0-255)
SHARP_LVL              = 13    // Level: Sharpness level (0-255)
TINT_LVL               = 14    // Level: Tint level (0-255)

(***********************************************************)
(*                           UPS                           *)
(***********************************************************)
                // UPS Channels and Levels

// UPS Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                         Utility                         *)
(***********************************************************)
                // Utility Channels and Levels

// Utility Channels
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

(***********************************************************)
(*                           VCR                           *)
(***********************************************************)
                // VCR Channels and Levels

// VCR Channels
PLAY                   = 1     // Momentary: Play
STOP                   = 2     // Momentary: Stop
PAUSE                  = 3     // Momentary: Pause
FFWD                   = 4     // Momentary: Fast forward
REW                    = 5     // Momentary: Rewind
SFWD                   = 6     // Momentary: Search forward
SREV                   = 7     // Momentary: Search reverse
RECORD                 = 8     // Momentary: Record
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
CHAN_UP                = 22    // Momentary: Next station preset
CHAN_DN                = 23    // Momentary: Previous station preset
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
TUNER_BAND             = 40    // Momentary: Cycle tuner band 
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
SEARCH_SPEED           = 119   // Momentary: Cycle search speed
EJECT                  = 120   // Momentary: Eject tape
RESET_COUNTER          = 121   // Momentary: Reset counter
TAPE_LOADED_FB         = 122   // Feedback:  Tape is loaded
RECORD_LOCK_FB         = 123   // Feedback:  Tape record is locked
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
SLOW_FWD               = 188   // Momentary: Slow forward
SLOW_REV               = 189   // Momentary: Slow reverse
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
MENU_FLASH             = 203   // Momentary: Press menu button flash
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
TUNER_PRESET_GROUP     = 224   // Momentary: Cycle station preset group
TUNER_STATION_UP       = 225   // Momentary: Increment tuner station
TUNER_STATION_DN       = 226   // Momentary: Decrement tuner station
TUNER_SCAN_FWD         = 227   // Momentary: Station scan forward
TUNER_SCAN_REV         = 228   // Momentary: Station scan backward/reverse
TUNER_SEEK_FWD         = 229   // Momentary: Station seek forward
TUNER_SEEK_REV         = 230   // Momentary: Station seek backward/reverse
TUNER_OSD              = 234   // Momentary: Cycle on-screen or front panel display info
TUNER_PREV             = 235   // Momentary: Goto previous tuner station
PLAY_FB                = 241   // Feedback:  Play feedback
STOP_FB                = 242   // Feedback:  Stop feedback
PAUSE_FB               = 243   // Feedback:  Pause feedback
FFWD_FB                = 244   // Feedback:  Fast forward feedback
REW_FB                 = 245   // Feedback:  Rewind feedback
SFWD_FB                = 246   // Feedback:  Search forward feedback
SREV_FB                = 247   // Feedback:  Search reverse feedback
RECORD_FB              = 248   // Feedback:  Record feedback
SLOW_FWD_FB            = 249   // Feedback:  Slow forward feedback
SLOW_REV_FB            = 250   // Feedback:  Slow reverse feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

(***********************************************************)
(*                    Video Conferencer                    *)
(***********************************************************)
                // Video Conferencer Channels and Levels

// Video Conferencer Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
TILT_UP                = 132   // Ramping:   Ramp tilt up
TILT_UP_FB             = 132   // Feedback:  Tilt ramp up feedback
TILT_DN                = 133   // Ramping:   Ramp tilt down
TILT_DN_FB             = 133   // Feedback:  Tilt ramp down feedback
PAN_LT                 = 134   // Ramping:   Ramp pan left
PAN_LT_FB              = 134   // Feedback:  Ramp pan left feedback
PAN_RT                 = 135   // Ramping:   Ramp pan right
PAN_RT_FB              = 135   // Feedback:  Ramp pan right feedback
VOL_PRESET             = 138   // Momentary: Cycle volume preset
VCONF_PRIVACY          = 145   // Momentary: Cycle privacy
VCONF_PRIVACY_ON       = 146   // Discrete:  Set privacy on or off
VCONF_PRIVACY_FB       = 146   // Feedback:  Privacy feedback
VCONF_TRAIN            = 147   // Momentary: Execute train
ZOOM_OUT               = 158   // Ramping:   Ramp zoom out
ZOOM_OUT_FB            = 158   // Feedback:  Ramp zoom out feedback
ZOOM_IN                = 159   // Ramping:   Ramp zoom in
ZOOM_IN_FB             = 159   // Feedback:  Ramp zoom in feedback
FOCUS_NEAR             = 160   // Ramping:   Ramp focus near
FOCUS_NEAR_FB          = 160   // Feedback:  Ramp focus near feedback
FOCUS_FAR              = 161   // Ramping:   Ramp focus far
FOCUS_FAR_FB           = 161   // Feedback:  Focus ramp far feedback
AUTO_FOCUS_ON          = 162   // Discrete:  Set auto focus on or off
AUTO_FOCUS_FB          = 162   // Feedback:  Auto focus feedback
AUTO_IRIS_ON           = 163   // Discrete:  Set auto iris on or off
AUTO_IRIS_FB           = 163   // Feedback:  Auto iris feedback
AUTO_FOCUS             = 172   // Momentary: Cycle auto focus
AUTO_IRIS              = 173   // Momentary: Cycle auto iris
IRIS_OPEN              = 174   // Ramping:   Ramp iris open
IRIS_OPEN_FB           = 174   // Feedback:  Ramp iris open feedback
IRIS_CLOSE             = 175   // Ramping:   Ramp iris closed
IRIS_CLOSE_FB          = 175   // Feedback:  Ramp iris closed feedback
CAM_PRESET             = 177   // Momentary: Cycle camera preset
PIP_POS                = 191   // Momentary: Cycle pip position
PIP_SWAP               = 193   // Momentary: Swap pip
PIP                    = 194   // Momentary: Cycle pip
PIP_ON                 = 195   // Discrete:  Set pip on or off
PIP_FB                 = 195   // Feedback:  Pip feedback
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
DIAL_REDIAL            = 201   // Momentary: Redial
DIAL_OFF_HOOK          = 202   // Momentary: Cycle off hook state
MENU_FLASH             = 203   // Momentary: Press menu button flash
DIAL_AUTO_ANSWER       = 204   // Momentary: Cycle auto answer state
DIAL_AUDIBLE_RING      = 205   // Momentary: Cycle audible ring state
DIAL_FLASH_HOOK        = 208   // Momentary: Flash hook
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
DIAL_OFF_HOOK_ON       = 238   // Discrete:  Set the dialer off or on hook
DIAL_OFF_HOOK_FB       = 238   // Feedback:  Dialer's hook state feedback
DIAL_AUTO_ANSWER_ON    = 239   // Discrete:  Set auto answer on or off
DIAL_AUTO_ANSWER_FB    = 239   // Feedback:  Auto answer state feedback
DIAL_AUDIBLE_RING_ON   = 240   // Discrete:  Set the audible ring state on or off
DIAL_AUDIBLE_RING_FB   = 240   // Feedback:  Audible ring state feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Video Conferencer Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
ZOOM_LVL               = 15    // Level: Zoom position ( 0=out/Wide, 255= in/Tele) 
FOCUS_LVL              = 16    // Level: Focus position (0=near, 255=far)
IRIS_LVL               = 17    // Level: Iris position (0=closed, 255=open)
ZOOM_SPEED_LVL         = 18    // Level: Zoom ramp speed (0-255) 
FOCUS_SPEED_LVL        = 19    // Level: Focus ramp speed (0-255)
IRIS_SPEED_LVL         = 20    // Level: Iris ramp speed (0-255) 
PAN_LVL                = 27    // Level: Pan position (0=left,255=right) 
TILT_LVL               = 28    // Level: Tilt position (0=down, 255=up) 
PAN_SPEED_LVL          = 29    // Level: Pan ramp speed (0-255)
TILT_SPEED_LVL         = 30    // Level: Tilt ramp speed (0-255) 

(***********************************************************)
(*                     Video Processor                     *)
(***********************************************************)
                // Video Processor Channels and Levels

// Video Processor Channels
POWER                  = 9     // Momentary: Cycle power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VPROC_PRESET           = 137   // Momentary: Cycle video processor preset
ASPECT_RATIO           = 142   // Momentary: Cycle aspect ratio
BRIGHT_UP              = 148   // Momentary: Increment brightness
BRIGHT_DN              = 149   // Momentary: Decrement brightness
COLOR_UP               = 150   // Momentary: Increment color
COLOR_DN               = 151   // Momentary: Decrement color
CONTRAST_UP            = 152   // Momentary: Increment contrast
CONTRAST_DN            = 153   // Momentary: Decrement contrast
SHARP_UP               = 154   // Momentary: Increment sharpness
SHARP_DN               = 155   // Momentary: Decrement sharpness
TINT_UP                = 156   // Momentary: Increment tint
TINT_DN                = 157   // Momentary: Decrement tint
PIP_POS                = 191   // Momentary: Cycle pip position
PIP_SWAP               = 193   // Momentary: Swap pip
PIP                    = 194   // Momentary: Cycle pip
PIP_ON                 = 195   // Discrete:  Set pip on
PIP_FB                 = 195   // Feedback:  Pip feedback
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
MENU_FLASH             = 203   // Momentary: Press menu button flash
PIC_MUTE               = 210   // Momentary: Cycle picture/video mute
PIC_MUTE_ON            = 211   // Discrete:  Set picture/video mute on
PIC_MUTE_FB            = 211   // Feedback:  Picture/video mute feedback
PIC_FREEZE             = 213   // Momentary: Cycle freeze
PIC_FREEZE_ON          = 214   // Discrete:  Set freeze on
PIC_FREEZE_FB          = 214   // Feedback:  Freeze feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Video Processor Levels
BRIGHT_LVL             = 10    // Level: Brightness level (0-255)
COLOR_LVL              = 11    // Level: Color level (0-255)
CONTRAST_LVL           = 12    // Level: Contrast level (0-255)
SHARP_LVL              = 13    // Level: Sharpness level (0-255)
TINT_LVL               = 14    // Level: Tint level (0-255)

(***********************************************************)
(*                     Video Projector                     *)
(***********************************************************)
                // Video Projector Channels and Levels

// Video Projector Channels
POWER                  = 9     // Momentary: Cycle lamp power
DIGIT_0                = 10    // Momentary: Press menu button digit 0
DIGIT_1                = 11    // Momentary: Press menu button digit 1
DIGIT_2                = 12    // Momentary: Press menu button digit 2
DIGIT_3                = 13    // Momentary: Press menu button digit 3
DIGIT_4                = 14    // Momentary: Press menu button digit 4
DIGIT_5                = 15    // Momentary: Press menu button digit 5
DIGIT_6                = 16    // Momentary: Press menu button digit 6
DIGIT_7                = 17    // Momentary: Press menu button digit 7
DIGIT_8                = 18    // Momentary: Press menu button digit 8
DIGIT_9                = 19    // Momentary: Press menu button digit 9
MENU_PLUS_10           = 20    // Momentary: Press menu button plus_10
MENU_ENTER             = 21    // Momentary: Press menu button enter
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
PWR_ON                 = 27    // Momentary: Set lamp power on
PWR_OFF                = 28    // Momentary: Set lamp power off
SOURCE_TV1             = 30    // Momentary: *deprecated Input Source in favor of Input Select* TV 1 source select
SOURCE_VIDEO1          = 31    // Momentary: *deprecated Input Source in favor of Input Select* Video 1 source select
SOURCE_VIDEO2          = 32    // Momentary: *deprecated Input Source in favor of Input Select* Video 2 source select
SOURCE_VIDEO3          = 33    // Momentary: *deprecated Input Source in favor of Input Select* Video 3 source select
SOURCE_TAPE1           = 34    // Momentary: *deprecated Input Source in favor of Input Select* Tape 1 source select
SOURCE_TAPE2           = 35    // Momentary: *deprecated Input Source in favor of Input Select* Tape 2 source select
SOURCE_CD1             = 36    // Momentary: *deprecated Input Source in favor of Input Select* CD 1 source select
SOURCE_TUNER1          = 37    // Momentary: *deprecated Input Source in favor of Input Select* Tuner 1 source select
SOURCE_PHONO1          = 38    // Momentary: *deprecated Input Source in favor of Input Select* Phono 1 source select
SOURCE_AUX1            = 39    // Momentary: *deprecated Input Source in favor of Input Select* Auxiliary 1 source select
MENU_CANCEL            = 43    // Momentary: Press menu button cancel
MENU_FUNC              = 44    // Momentary: Press menu button menu
MENU_UP                = 45    // Momentary: Press menu up button
MENU_DN                = 46    // Momentary: Press menu down button
MENU_LT                = 47    // Momentary: Press menu left button
MENU_RT                = 48    // Momentary: Press menu right button
MENU_SELECT            = 49    // Momentary: Press menu Select button (select current item under cursor)
MENU_EXIT              = 50    // Momentary: Press menu button exit
MENU_UP_LT             = 51    // Momentary: Press menu up left button
MENU_UP_RT             = 52    // Momentary: Press menu up right button
MENU_DN_LT             = 53    // Momentary: Press menu down left button
MENU_DN_RT             = 54    // Momentary: Press menu down right button
MENU_VIDEO             = 57    // Momentary: Press menu button video
MENU_THUMBS_DN         = 58    // Momentary: Press menu button thumbs down
MENU_THUMBS_UP         = 59    // Momentary: Press menu button thumbs up
MENU_ACCEPT            = 60    // Momentary: Press menu button accept
MENU_REJECT            = 61    // Momentary: Press menu button reject
MENU_LIVE_TV           = 62    // Momentary: Press menu button live TV
MENU_SLEEP             = 63    // Momentary: Press menu button sleep
MENU_PPV               = 64    // Momentary: Press menu button PPV
MENU_FUNCTION          = 65    // Momentary: Press menu button function
MENU_SETUP             = 66    // Momentary: Press menu button setup
MENU_XM                = 77    // Momentary: Press menu button xm
MENU_FM                = 78    // Momentary: Press menu button fm
MENU_AM                = 79    // Momentary: Press menu button am
MENU_CLEAR             = 80    // Momentary: Press menu button clear
MENU_BACK              = 81    // Momentary: Press menu button back
MENU_FORWARD           = 82    // Momentary: Press menu button forward
MENU_ADVANCE           = 83    // Momentary: Press menu button advance
MENU_DIMMER            = 84    // Momentary: Press menu button dimmer
MENU_HOLD              = 85    // Momentary: Press menu button hold
MENU_LIST              = 86    // Momentary: Press menu button list
MENU_LT_PAREN          = 87    // Momentary: Press menu button left paren
MENU_RT_PAREN          = 88    // Momentary: Press menu button right paren
MENU_UNDERSCORE        = 89    // Momentary: Press menu button underscore
MENU_DASH              = 90    // Momentary: Press menu button dash
MENU_ASTERISK          = 91    // Momentary: Press menu button asterisk
MENU_DOT               = 92    // Momentary: Press menu button dot
MENU_POUND             = 93    // Momentary: Press menu button pound
MENU_COMMA             = 94    // Momentary: Press menu button comma
MENU_DIAL              = 95    // Momentary: Press menu button dial
MENU_CONFERENCE        = 96    // Momentary: Press menu button conference
MENU_PLUS_100          = 97    // Momentary: Press menu button plus_100
MENU_PLUS_1000         = 98    // Momentary: Press menu button plus_1000
MENU_DISPLAY           = 99    // Momentary: Press menu button display
MENU_SUBTITLE          = 100   // Momentary: Press menu button subtitle
MENU_INFO              = 101   // Momentary: Press menu button info
MENU_FAVORITES         = 102   // Momentary: Press menu button favorites
MENU_CONTINUE          = 103   // Momentary: Press menu button continue
MENU_RETURN            = 104   // Momentary: Press menu button return
MENU_GUIDE             = 105   // Momentary: Press menu button guide
MENU_PAGE_UP           = 106   // Momentary: Press menu button page up
MENU_PAGE_DN           = 107   // Momentary: Press menu button page down
MENU_DECK_A_B          = 108   // Momentary: Press menu button deck AB
MENU_TV_VCR            = 109   // Momentary: Press menu button TV VCR
MENU_RECORD_SPEED      = 110   // Momentary: Press menu button record speed
MENU_PROGRAM           = 111   // Momentary: Press menu button program
MENU_AB_REPEAT         = 112   // Momentary: Press menu button AB repeat
MENU_HELP              = 113   // Momentary: Press menu button help
MENU_TITLE             = 114   // Momentary: Press menu button title
MENU_TOP_MENU          = 115   // Momentary: Press menu button top menu
MENU_ZOOM              = 116   // Momentary: Press menu button zoom
MENU_ANGLE             = 117   // Momentary: Press menu button angle
MENU_AUDIO             = 118   // Momentary: Press menu button audio
MENU_PREVIEW_INPUT     = 129   // Momentary: Press menu button preview input
MENU_SEND_INPUT        = 130   // Momentary: Press menu button send input
MENU_SEND_GRAPHICS     = 131   // Momentary: Press menu button send graphics
VOL_PRESET             = 138   // Momentary: Cycle volume preset
ASPECT_RATIO           = 142   // Momentary: Cycle aspect ratio
BRIGHT_UP              = 148   // Momentary: Increment brightness
BRIGHT_DN              = 149   // Momentary: Decrement brightness
COLOR_UP               = 150   // Momentary: Increment color
COLOR_DN               = 151   // Momentary: Decrement color
CONTRAST_UP            = 152   // Momentary: Increment contrast
CONTRAST_DN            = 153   // Momentary: Decrement contrast
SHARP_UP               = 154   // Momentary: Increment sharpness
SHARP_DN               = 155   // Momentary: Decrement sharpness
TINT_UP                = 156   // Momentary: Increment tint
TINT_DN                = 157   // Momentary: Decrement tint
PIP_POS                = 191   // Momentary: Cycle pip position
PIP_SWAP               = 193   // Momentary: Swap pip
PIP                    = 194   // Momentary: Cycle pip
PIP_ON                 = 195   // Discrete:  Set pip on
PIP_FB                 = 195   // Feedback:  Pip feedback
SOURCE_CYCLE           = 196   // Momentary: *deprecated Input Source in favor of Input Select* Cycle source select
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
MENU_FLASH             = 203   // Momentary: Press menu button flash
PIC_MUTE               = 210   // Momentary: Cycle picture/video mute
PIC_MUTE_ON            = 211   // Discrete:  Set picture/video mute on
PIC_MUTE_FB            = 211   // Feedback:  Picture/video mute feedback
PIC_FREEZE             = 213   // Momentary: Cycle freeze
PIC_FREEZE_ON          = 214   // Discrete:  Set freeze on
PIC_FREEZE_FB          = 214   // Feedback:  Freeze feedback
MENU_RESET             = 215   // Momentary: Press menu button reset
MENU_INSTANT_REPLAY    = 218   // Momentary: Press menu button instant replay
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
LAMP_WARMING_FB        = 253   // Feedback:  Lamp is warming up
LAMP_COOLING_FB        = 254   // Feedback:  Lamp is cooling down
POWER_ON               = 255   // Discrete:  Set lamp power state
LAMP_POWER_FB          = 255   // Feedback:  Lamp power state feedback

// Video Projector Levels
VOL_LVL                = 1     // Level: Volume level (0-255)
BRIGHT_LVL             = 10    // Level: Brightness level (0-255)
COLOR_LVL              = 11    // Level: Color level (0-255)
CONTRAST_LVL           = 12    // Level: Contrast level (0-255)
SHARP_LVL              = 13    // Level: Sharpness level (0-255)
TINT_LVL               = 14    // Level: Tint level (0-255)

(***********************************************************)
(*                        Video Wall                       *)
(***********************************************************)
                // Video Wall Channels and Levels

// Video Wall Channels
POWER                  = 9     // Momentary: Cycle power
PWR_ON                 = 27    // Momentary: Set power on
PWR_OFF                = 28    // Momentary: Set power off
PAN_UP                 = 132   // Momentary: Pan up
PAN_DN                 = 133   // Momentary: Pan down
PAN_LT                 = 134   // Momentary: Pan left
PAN_RT                 = 135   // Momentary: Pan right
BRIGHT_UP              = 148   // Momentary: Increment brightness
BRIGHT_DN              = 149   // Momentary: Decrement brightness
COLOR_UP               = 150   // Momentary: Increment color
COLOR_DN               = 151   // Momentary: Decrement color
CONTRAST_UP            = 152   // Momentary: Increment contrast
CONTRAST_DN            = 153   // Momentary: Decrement contrast
SHARP_UP               = 154   // Momentary: Increment sharpness
SHARP_DN               = 155   // Momentary: Decrement sharpness
TINT_UP                = 156   // Momentary: Increment tint
TINT_DN                = 157   // Momentary: Decrement tint
ZOOM_OUT               = 158   // Momentary: Zoom out
ZOOM_IN                = 159   // Momentary: Zoom in
PIC_MUTE               = 210   // Momentary: Cycle picture/video mute
PIC_MUTE_ON            = 211   // Discrete:  Set picture/video mute on
PIC_MUTE_FB            = 211   // Feedback:  Picture/video mute feedback
PIC_FREEZE             = 213   // Momentary: Cycle freeze
PIC_FREEZE_ON          = 214   // Discrete:  Set freeze on
PIC_FREEZE_FB          = 214   // Feedback:  Freeze feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event
POWER_ON               = 255   // Discrete:  Set power
POWER_FB               = 255   // Feedback:  Power feedback

// Video Wall Levels
BRIGHT_LVL             = 10    // Level: Brightness level (0-255)
COLOR_LVL              = 11    // Level: Color level (0-255)
CONTRAST_LVL           = 12    // Level: Contrast level (0-255)
SHARP_LVL              = 13    // Level: Sharpness level (0-255)
TINT_LVL               = 14    // Level: Tint level (0-255)

(***********************************************************)
(*                    Volume Controller                    *)
(***********************************************************)
                // Volume Controller Channels and Levels

// Volume Controller Channels
VOL_UP                 = 24    // Ramping:   Ramp volume up
VOL_UP_FB              = 24    // Feedback:  Volume ramp up feedback
VOL_DN                 = 25    // Ramping:   Ramp volume down
VOL_DN_FB              = 25    // Feedback:  Volume ramp down feedback
VOL_MUTE               = 26    // Momentary: Cycle volume mute
VOL_PRESET             = 138   // Momentary: Cycle volume preset
VOL_MUTE_ON            = 199   // Discrete:  Set volume mute
VOL_MUTE_FB            = 199   // Feedback:  Volume mute feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

// Volume Controller Levels
VOL_LVL                = 1     // Level: Volume level (0-255)

(***********************************************************)
(*                         Weather                         *)
(***********************************************************)
                // Weather Channels and Levels

// Weather Channels
WEATHER_FORCE_READING  = 208   // Momentary: Force new readings
WEATHER_RAINING        = 230   // Feedback:  Weather condition indicates rain
WEATHER_FREEZING       = 231   // Feedback:  Outdoor temperature is at or below freezing
WEATHER_BAR_RISING     = 232   // Feedback:  Barometric pressure rising feedback
WEATHER_BAR_FALLING    = 233   // Feedback:  Barometric pressure falling feedback
DEVICE_COMMUNICATING   = 251   // Feedback:  Device online event
DATA_INITIALIZED       = 252   // Feedback:  Data initialized event

// Weather Levels
INDOOR_TEMP_LVL        = 33    // Level: Indoor temperature, range is n..m degrees F or C
OUTDOOR_TEMP_LVL       = 34    // Level: Outdoor temperature, range is n..m degrees F or C
INDOOR_HUMID_LVL       = 35    // Level: Indoor humidity range is 0..100 percent
OUTDOOR_HUMID_LVL      = 36    // Level: Outdoor humidity, range is 0..100 percent
WEATHER_HI_TEMP_LVL    = 43    // Level: Today's actual high temperature, range is n..m degrees F or C
WEATHER_LO_TEMP_LVL    = 44    // Level: Today's actual low temperature, range is n..m degrees F or C
WEATHER_WIND_CHILL_LVL = 45    // Level: Wind chill, range is n..m degrees F or C
WEATHER_HEAT_INDEX_LVL = 46    // Level: Heat index, range is n..m degrees F or C
WEATHER_DEWPOINT_LVL   = 47    // Level: Dew point, range is n..m degrees F or C
WEATHER_BAR_LVL        = 48    // Level: Barometric pressure, range is n..m in inches hg or millimeter hg/torr

(***********************************************************)
(*                    Deprecated constants                 *)
(***********************************************************)
                // Deprecated constants

// Menu Component
MENU_AUDIO_MENU        = 118   // Momentary: Press menu button audio, replaced by MENU_AUDIO
MENU_ADVANCED          = 83    // Momentary: Press menu button advance, replaced by MENU_ADVANCE

// HVAC Component
HVAC_HOLD              = 211   // Discrete:  Set thermostat hold mode, replaced by HVAC_HOLD_ON
HVAC_LOCK              = 212   // Discrete:  Set thermostat lock state, replaced by HVAC_LOCK_ON

(***********************************************************)
(*                   Command/Param Lengths                 *)
(***********************************************************)
                // Command/Param Lengths

#IF_NOT_DEFINED DUET_MAX_CMD_LEN
DUET_MAX_CMD_LEN       = 1000  // Maximum command length for parsing/packing functions
#END_IF

#IF_NOT_DEFINED DUET_MAX_PARAM_LEN
DUET_MAX_PARAM_LEN     = 100   // Maximum parameter length for parsing/packing functions
#END_IF

#IF_NOT_DEFINED DUET_MAX_HDR_LEN
DUET_MAX_HDR_LEN       = 100   // Maximum command header length for parsing/packing functions
#END_IF

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)

(***********************************************************)
(*                          Ramping                        *)
(***********************************************************)
DEFINE_VARIABLE // Ramping

INTEGER DUET_RAMPING_REPEAT = 3

(***********************************************************)
(*           SUBROUTINE DEFINITIONS GO BELOW               *)
(***********************************************************)

// Name   : ==== DuetPackCmdHeader ====
// Purpose: To package header for module send_command or send_string
// Params : (1) IN - sndcmd/str header
// Returns: Packed header with command separator added if missing
// Notes  : Adds the command header to the string and adds the command if missing
//          This function assumes the standard Duet command separator '-'
//
DEFINE_FUNCTION CHAR[DUET_MAX_HDR_LEN] DuetPackCmdHeader(CHAR cHdr[])
{
  STACK_VAR CHAR cSep[1]
  cSep = '-'

  IF (RIGHT_STRING(cHdr,LENGTH_STRING(cSep)) != cSep)
      RETURN "cHdr,cSep";

  RETURN cHdr;
}

// Name   : ==== DuetPackCmdParam ====
// Purpose: To package parameter for module send_command or send_string
// Params : (1) IN - sndcmd/str to which parameter will be added
//          (2) IN - sndcmd/str parameter
// Returns: Packed parameter wrapped in double-quotes if needed, added to the command
// Notes  : Wraps the parameter in double-quotes if it contains the separator
//          This function assumes the standard Duet parameter separator ','
//
DEFINE_FUNCTION CHAR[DUET_MAX_CMD_LEN] DuetPackCmdParam(CHAR cCmd[], CHAR cParam[])
{
  STACK_VAR CHAR cTemp[DUET_MAX_CMD_LEN]
  STACK_VAR CHAR cTempParam[DUET_MAX_CMD_LEN]
  STACK_VAR CHAR cCmdSep[1]
  STACK_VAR CHAR cParamSep[1]
  STACK_VAR INTEGER nLoop
  cCmdSep = '-'
  cParamSep = ','

  // Not the first param?  Add the param separator
  cTemp = cCmd
  IF (FIND_STRING(cCmd,cCmdSep,1) != (LENGTH_STRING(cCmd)-LENGTH_STRING(cCmdSep)+1))
    cTemp = "cTemp,cParamSep"

  // Escape any quotes
  FOR (nLoop = 1; nLoop <= LENGTH_ARRAY(cParam); nLoop++)
  {
    IF (cParam[nLoop] == '"')
      cTempParam = "cTempParam,'"'"
    cTempParam = "cTempParam,cParam[nLoop]"
  }

  // Add the param, wrapped in double-quotes if needed
  IF (FIND_STRING(cTempParam,cParamSep,1) > 0)
      cTemp = "cTemp,'"',cTempParam,'"'"
  ELSE
      cTemp = "cTemp,cTempParam"

  RETURN cTemp;
}

// Name   : ==== DuetPackCmdParamArray ====
// Purpose: To package parameters for module send_command or send_string
// Params : (1) IN - sndcmd/str to which parameter will be added
//          (2) IN - sndcmd/str parameter array
// Returns: packed parameters wrapped in double-quotes if needed
// Notes  : Wraps the parameter in double-quotes if it contains the separator
//          and separates them using the separator sequence
//          This function assumes the standard Duet parameter separator ','
//
DEFINE_FUNCTION CHAR[DUET_MAX_CMD_LEN] DuetPackCmdParamArray(CHAR cCmd[], CHAR cParams[][])
{
  STACK_VAR CHAR    cTemp[DUET_MAX_CMD_LEN]
  STACK_VAR INTEGER nLoop
  STACK_VAR INTEGER nMax
  STACK_VAR CHAR cCmdSep[1]
  STACK_VAR CHAR cParamSep[1]
  cCmdSep = '-'
  cParamSep = ','

  nMax = LENGTH_ARRAY(cParams)
  IF (nMax == 0)
    nMax = MAX_LENGTH_ARRAY(cParams)

  cTemp = cCmd
  FOR (nLoop = 1; nLoop <= nMax; nLoop++)
    cTemp = DuetPackCmdParam(cTemp,cParams[nLoop])

  RETURN cTemp;
}

// Name   : ==== DuetPackCmdSimple ====
// Purpose: To package header and 1 parameter for module send_command or send_string
// Params : (1) IN - sndcmd/str header
//          (2) IN - sndcmd/str parameter
// Returns: Packed header with command separator added if missing and parameter
// Notes  : Adds the command header to the string and adds the command if missing
//          This function assumes the standard Duet command separator '-'
//          This function also adds a parameter to the command
//
DEFINE_FUNCTION CHAR[DUET_MAX_CMD_LEN] DuetPackCmdSimple(CHAR cHdr[], CHAR cParam[])
{
  STACK_VAR CHAR cCmd[DUET_MAX_CMD_LEN]

  cCmd = DuetPackCmdHeader(cHdr)
  cCmd = DuetPackCmdParam(cCmd,cParam)
  RETURN cCmd;
}

// Name   : ==== DuetParseCmdHeader ====
// Purpose: To parse out parameters from module send_command or send_string
// Params : (1) IN/OUT  - sndcmd/str data
// Returns: parsed property/method name, still includes the leading '?' if present
// Notes  : Parses the strings sent to or from modules extracting the command header.
//          Command separating character assumed to be '-', Duet standard
//
DEFINE_FUNCTION CHAR[DUET_MAX_HDR_LEN] DuetParseCmdHeader(CHAR cCmd[])
{
  STACK_VAR CHAR cTemp[DUET_MAX_HDR_LEN]
  STACK_VAR CHAR cSep[1]
  cSep = '-'

  // Assume the argument to be the command
  cTemp = cCmd

  // If we find the seperator, remove it from the command
  IF (FIND_STRING(cCmd,cSep,1) > 0)
  {
    cTemp = REMOVE_STRING(cCmd,cSep,1) 
    IF (LENGTH_STRING(cTemp))
      cTemp = LEFT_STRING(cTemp,LENGTH_STRING(cTemp)-LENGTH_STRING(cSep))
  }

  // Did not find seperator, argument is the command (like ?SOMETHING)
  ELSE
    cCmd = ""

  RETURN cTemp;
}

// Name   : ==== DuetParseCmdParam ====
// Purpose: To parse out parameters from module send_command or send_string
// Params : (1) IN/OUT  - sndcmd/str data
// Returns: Parse parameter from the front of the string not including the separator
// Notes  : Parses the strings sent to or from modules extracting the parameters.
//          A single param is picked of the cmd string and removed, through the separator.
//          The separator is NOT returned from the function.
//          If the first character of the param is a double quote, the function will 
//          remove up to (and including) the next double-quote and the separator without spaces.
//          The double quotes will then be stripped from the parameter before it is returned.
//          If the double-quote/separator sequence is not found, the function will remove up to (and including)
//          the separator character and the leading double quote will NOT be removed.
//          If the separator is not found, the entire remained of the command is removed.
//          Command separating character assumed to be ',', Duet standard
//
DEFINE_FUNCTION CHAR[DUET_MAX_PARAM_LEN] DuetParseCmdParam(CHAR cCmd[])
{
  STACK_VAR CHAR cTemp[DUET_MAX_PARAM_LEN]
  STACK_VAR CHAR cSep[1]
  STACK_VAR CHAR chC
  STACK_VAR INTEGER nLoop
  STACK_VAR INTEGER nState
  STACK_VAR CHAR bInquotes
  STACK_VAR CHAR bDone
  cSep = ','

  // Reset state
  nState = 1; //ST_START
  bInquotes = FALSE;
  bDone = FALSE;

  // Loop the command and escape it
  FOR (nLoop = 1; nLoop <= LENGTH_ARRAY(cCmd); nLoop++)
  {
    // Grab characters and process it based on state machine
    chC = cCmd[nLoop];
    Switch (nState)
    {
      // Start or string: end of string bails us out
      CASE 1: //ST_START
      {
        // Starts with a quote?
        // If so, skip it, set flag and move to collect.
        IF (chC == '"')
        {
          nState = 2; //ST_COLLECT
          bInquotes = TRUE;
        }

        // Starts with a comma?  Empty param
        ELSE IF (chC == ',')
        {
          // I am done
          bDone = TRUE;
        }

        // Not a quote or a comma?  Add it to the string and move to collection
        Else
        {
          cTemp = "cTemp, chC"
          nState = 2; //ST_COLLECT
        }
        BREAK;
      }

      // Collect string.
      CASE 2: //ST_COLLECT
      {
        // If in quotes, just grab the characters
        IF (bInquotes)
        {
          // Ah...found a quote, jump to end quote state
          IF (chC == '"' )
          {
            nState = 3; //ST_END_QUOTE
            BREAK;
          }
        }

        // Not in quotes, look for commas
        ELSE IF (chC == ',')
        {
          // I am done
          bDone = TRUE;
          BREAK;
        }

        // Not in quotes, look for quotes (this would be wrong)
        // But instead of barfing, I will just add the quote (below)
        ELSE IF (chC == '"' )
        {
          // I will check to see if it should be escaped
          IF (nLoop < LENGTH_ARRAY(cCmd))
          {
            // If this is 2 uqotes back to back, just include the one
            IF (cCmd[nLoop+1] = '"')
              nLoop++;
          }
        }

        // Add character to collection
        cTemp = "cTemp,chC"
        BREAK;
      }

      // End Quote
      CASE 3: //ST_END_QUOTE
      {
        // Hit a comma
        IF (chC == ',')
        {
          // I am done
          bDone = TRUE;
        }

        // OK, found a quote right after another quote.  So this is escaped.
        ELSE IF (chC == '"')
        {
          cTemp = "cTemp,chC"
          nState = 2; //ST_COLLECT
        }
        BREAK;
      }
    }

    // OK, if end of string or done, process and exit
    IF (bDone == TRUE || nLoop >= LENGTH_ARRAY(cCmd))
    {
      // remove cTemp from cCmd
      cCmd = MID_STRING(cCmd, nLoop + 1, LENGTH_STRING(cCmd) - nLoop)

      // cTemp is done
      RETURN cTemp;
    }
  }

  // Well...we should never hit this
  RETURN "";
}

#END_IF //  __SNAPI_CONST__
(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
