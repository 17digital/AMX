PROGRAM_NAME='RoomInfo'


(*
File Results...
 >0 = Handle to file (open was successful)
 -2 = Invalid file path or name
 -3 = Invalid value supplied for IOFlag
 -5 = Disk I/O error
 -14 = Maximum number of files are already open (max is 10)
 -15 = Invalid file format

Retreive Error via Diagnostic or Debug
*)


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

#IF_NOT_DEFINED DUET_MAX_PARAM_LEN
DUET_MAX_PARAM_LEN     = 100   // Maximum parameter length for parsing/packing functions
#END_IF

#IF_NOT_DEFINED __COMMON_TXT__
#DEFINE __COMMON_TXT__
TXT_HELP					= 99
TXT_ROOM					= 100
#END_IF


(***********************************************************)
(*              STRUCTURE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCTURE _BuildingInfo
{
    CHAR bBuilding[100]
    CHAR bHelp[25];
    INTEGER bPass;
    SINTEGER bReboot;
    SINTEGER bShutdown;
}

DEFINE_VARIABLE

VOLATILE _BuildingInfo uHelpInfo;


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
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
DEFINE_FUNCTION readStuffFromFile(CHAR cFileName[]) {
	STACK_VAR SLONG slFileHandle;
	LOCAL_VAR SLONG slResult;
	STACK_VAR CHAR oneline[2000];
	STACK_VAR INTEGER INC;
	
	slFileHandle = FILE_OPEN(cFileName,FILE_READ_ONLY) // Open file from beginning
	
	IF (slFileHandle>0) {
	    slResult = 1
	    
	    WHILE(slResult>0)
	    {
		slResult = FILE_READ_LINE(slFileHandle,oneline,MAX_LENGTH_STRING(oneline)) // Grab Oneline from file
		parseAnotherLine(oneline)
	    }
	    FILE_CLOSE(slFileHandle)
	} ELSE {
	    SEND_STRING 0, " ' FILE OPEN ERROR: ', ITOA(slFileHandle)"
		SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',INFO_ROOM"
		    SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',INFO_NUM"
	}
}
DEFINE_FUNCTION parseAnotherLine(CHAR aLine[]) {
	STACK_VAR CHAR iParam[DUET_MAX_PARAM_LEN];
	
	iParam = DuetParseCmdParam(aLine);
	    SEND_STRING 0, "'Reading : ',iParam"
	
	IF (FIND_STRING(iParam,'THISROOM=',1)) {
		REMOVE_STRING(iParam,'=',1)
		    uHelpInfo.bBuilding = iParam;
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_ROOM),',0,',uHelpInfo.bBuilding"
	}
	IF (FIND_STRING(iParam,'THISPHONE=',1)) {
		REMOVE_STRING(iParam,'=',1)
		    uHelpInfo.bHelp = iParam;
			SEND_COMMAND vdvTP_Main, "'^TXT-',ITOA(TXT_HELP),',0,',uHelpInfo.bHelp"
	}
	IF (FIND_STRING(iParam,'THISCODE=',1)) {
		REMOVE_STRING(iParam,'=',1)
		    uHelpInfo.bPass = ATOI(iParam);
	}
	IF (FIND_STRING(iParam,'THISREBOOT=',1)) {
		REMOVE_STRING(iParam,'=',1)
		    uHelpInfo.bReboot = ATOI(iParam);
	}
	IF (FIND_STRING(iParam,'THISSHUTDOWN=',1)) {
		REMOVE_STRING(iParam,'=',1)
		    uHelpInfo.bShutdown = ATOI(iParam);
	}
}


DEFINE_START

readStuffFromFile('building.txt');

(***********************************************************)
(*                  THE EVENTS GO BELOW                    *)
(***********************************************************)
DEFINE_EVENT
TIMELINE_EVENT [TL_FEEDBACK]
{
    WAIT 3000 '5 Minos'
    {
	    readStuffFromFile('building.txt'); // Reads Repeat Data (Users)
    }
}




