PROGRAM_NAME='Clearone'
(***********************************************************)
(*  FILE CREATED ON: 09/22/2016  AT: 13:13:30              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/07/2016  AT: 12:02:50        *)
(***********************************************************)

 (*   // PPON-_Phone
    
    User = Clearone
    Pass = Converge
    
    *)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Clear
dvTP_Clear =				10001:3:0
#END_IF

#IF_NOT_DEFINED dvClearOne
dvClearOne =				5001:1:0
#END_IF


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

DEVICE_TYPE			= 30
PHONE_HANGUP			= 0
PHONE_CONNECTED		= 1

#IF_NOT_DEFINED
IS_ON				= 1
IS_OFF				= 0
#END_IF

TL_CLEARONE			= 25


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE LONG lTLClearOne[] = {50}
VOLATILE CHAR nBufferClear [100]

CHAR nMyPhone[15] = '404-385-7227'

VOLATILE CHAR sPhoneNumber[20] //Number to Dial
VOLATILE CHAR sLastNumber[20] //Hold Last Number
VOLATILE CHAR sIncomingCall[20] //Incoming Phone Number
VOLATILE INTEGER nPhoneState //Track On or Off Hook..
VOLATILE CHAR sCallDuration[9]

VOLATILE INTEGER nMuteCaller
VOLATILE INTEGER nMutePhone //Myself...


(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)  
DEFINE_FUNCTION fnMuteCaller()
{
    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' MUTE 1 R 1',$0D"
}
DEFINE_FUNCTION fnUnMuteCaller()
{
    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' MUTE 1 R 0',$0D"
}
DEFINE_FUNCTION fnMutePhoneOut()
{
    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' MUTE 1 T 1',$0D"
}
DEFINE_FUNCTION fnUnMutePhoneOut()
{
    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' MUTE 1 T 0',$0D"
}
DEFINE_FUNCTION fnMuteMicrophoneOut()
{

}
DEFINE_FUNCTION fnUnMuteMicrophoneOut()
{

}
DEFINE_FUNCTION fnGetSystemStatus()
{
    WAIT 10 SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' MUTE 1 R',$0D"
    WAIT 20 SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' MUTE 1 T',$0D"
    WAIT 30 SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1',$0D"//Hook State..
}


(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

CREATE_BUFFER dvClearOne,nBufferClear;
TIMELINE_CREATE (TL_CLEARONE,lTLClearOne,1,TIMELINE_ABSOLUTE,TIMELINE_REPEAT);


(***********************************************************)
(*                  THE EVENTS GO BELOW                    *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT [dvTP_Clear, 1]
BUTTON_EVENT [dvTP_Clear, 2]
BUTTON_EVENT [dvTP_Clear, 3]
BUTTON_EVENT [dvTP_Clear, 4]
BUTTON_EVENT [dvTP_Clear, 5]
BUTTON_EVENT [dvTP_Clear, 6]
BUTTON_EVENT [dvTP_Clear, 7]
BUTTON_EVENT [dvTP_Clear, 8]
BUTTON_EVENT [dvTP_Clear, 9]
BUTTON_EVENT [dvTP_Clear, 10]
BUTTON_EVENT [dvTP_Clear, 11]
BUTTON_EVENT [dvTP_Clear, 12] //Dialer...
{                                  
    PUSH :
    {
	STACK_VAR INTEGER nPhoneBtns
	STACK_VAR CHAR nDigit[1];
	
	nPhoneBtns = BUTTON.INPUT.CHANNEL -1;
	TO [BUTTON.INPUT];
	
	SWITCH (nPhoneBtns)
	{
	    CASE 10 :
	    {
		nDigit = '*';
		BREAK;
	    }
	    CASE 11 :
	    {
		nDigit = '#';
		BREAK;
	    }
	    DEFAULT :
	    {
		nDigit = ITOA(nPhoneBtns)
	    }
	}
	sPhoneNumber = "sPhoneNumber, nDigit"
	
	IF (nPhoneState = PHONE_CONNECTED)
	{
	    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' XDIAL 1 R ',nDigit,$0D"
	}
	SEND_COMMAND dvTP_Clear, "'^TXT-17,0,',sPhoneNumber";
    }
}
BUTTON_EVENT [dvTP_Clear, 13] //BackSpace
{
    PUSH :
    {
	IF (LENGTH_STRING(sPhoneNumber))
	{
	    TO [BUTTON.INPUT];
	    SET_LENGTH_STRING(sPhoneNumber,LENGTH_STRING(sPhoneNumber) -1);
	    SEND_COMMAND dvTP_Clear, "'^TXT-17,0,',sPhoneNumber";
	}
    }
}
BUTTON_EVENT [dvTP_Clear, 14] //Clear...
{
    PUSH :
    {
	sPhoneNumber = '';
	SEND_COMMAND dvTP_Clear, "'^TXT-17,0,',sPhoneNumber";
    }
}
BUTTON_EVENT [dvTP_Clear, 15] //Dial...
{
    PUSH :
    {
	IF (LENGTH_STRING (sPhoneNumber) > 0)
	{
	    TO [BUTTON.INPUT]
	    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' XDIAL 1 R ',sPhoneNumber,$0D"
	}
    }
}
BUTTON_EVENT [dvTP_Clear, 16] //Redial...
{
    PUSH :
    {
	TO [BUTTON.INPUT]
	nPhoneState = PHONE_HANGUP
	SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1 0',$0D"
	WAIT 10
	{
	    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' XREDIAL 1 R',$0D"
	}
    }
}
BUTTON_EVENT [dvTP_Clear, 17] //HangUp...
{
    PUSH :
    {
	TO [BUTTON.INPUT]
	SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1 0',$0D"
	WAIT 10
	{
	    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1',$0D" //Get Status...
	}
    }
}
BUTTON_EVENT [dvTP_Clear, 50] //Answer...
{
    PUSH :
    {
	TO [BUTTON.INPUT]
	SEND_COMMAND dvTP_Clear, "'PPOF-IncomingCall'"
	SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1 1',$0D"
	WAIT 10
	{
	    SEND_COMMAND dvTP_Clear, "'PPON-_Phone'"
	    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1',$0D" //Get hook State
	}
    }
}
BUTTON_EVENT [dvTP_Clear, 51] //Ignore...
{
    PUSH :
    {
	TO [BUTTON.INPUT]
	SEND_COMMAND dvTP_Clear, "'PPOF-IncomingCall'"
	SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1 0',$0D"
	{
	    SEND_STRING dvClearOne, "'#',ITOA(DEVICE_TYPE), ' TE 1',$0D" //Get hook State
	}
    }
}
BUTTON_EVENT [dvTP_Clear, 35] //Mute Myself	
{
    PUSH :
    {
	IF ( nMutePhone == IS_OFF)
	{
	    fnMutePhoneOut()
	}
	ELSE
	{
	    fnUnMutePhoneOut()
	}
    }
}
BUTTON_EVENT [dvTP_Clear, 31] //Mute Caller...
{
    PUSH :
    {
	IF ( nMuteCaller == IS_OFF)
	{
	    fnMuteCaller()
	}
	ELSE
	{
	    fnUnMuteCaller()
	}
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Clear]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'^TXT-20,0,',nMyPhone"
    }
}
DATA_EVENT [dvClearOne]
{
    ONLINE :
    {
	SEND_COMMAND DATA.DEVICE, "'SET BAUD 57600,N,8,1'"
	SEND_COMMAND DATA.DEVICE, "'RXON'"
	SEND_COMMAND DATA.DEVICE, "'HSOFF'"
	SEND_COMMAND DATA.DEVICE, "'SOFF'"
	
	WAIT 30 fnGetSystemStatus() 
    }
    STRING :
    {
	SELECT
	{
	    ACTIVE(FIND_STRING(nBufferClear,'#30 CALLDUR 1',1)):
	    {
		REMOVE_STRING(nBufferClear,'#30 CALLDUR 1',1)
		
		sCallDuration = nBufferClear
		SEND_COMMAND dvTP_Clear, "'^TXT-80,0,',sCallDuration"
		
		WAIT 50
		{
		    sCallDuration = ''
		    SEND_COMMAND dvTP_Clear, "'^TXT-80,0,',sCallDuration"
		}
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 TE 1 1',1)):
	    {
		nPhoneState = PHONE_CONNECTED
		SEND_COMMAND dvTP_Clear, "'^TXT-21,0,Connected'"		
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 TE 1 0',1)): //On Hook
	    {
		nPhoneState = PHONE_HANGUP 
		SEND_COMMAND dvTP_Clear, "'^TXT-21,0,Disconnected'"
		WAIT 150
		{
		    sCallDuration =''
		    SEND_COMMAND dvTP_Clear, "'^TXT-80,0,',sCallDuration"
		}
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 CALLERID 1',1)):
	    {
		sIncomingCall = nBufferClear
		SEND_COMMAND dvTP_Clear, "'^TXT-19,0,',sIncomingCall"
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'Dialing in Progress',1)): //Need This...
	    {
		nPhoneState = PHONE_CONNECTED
		SEND_COMMAND dvTP_Clear, "'^TXT-21,0,Dialing...'"
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'Dialing in Progress',1)): //Need This...
	    {
		nPhoneState = PHONE_CONNECTED
		SEND_COMMAND dvTP_Clear, "'^TXT-21,0,Dialing...'"
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 MUTE 1 T 1',1)):
	    {
		nMutePhone = IS_ON
		    
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 MUTE 1 T 0',1)):
	    {
		nMutePhone = IS_OFF
		    
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 MUTE 1 R 1',1)):
	    {
		nMuteCaller = IS_ON
		    
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 MUTE 1 R 0',1)):
	    {
		nMuteCaller = IS_OFF
		    
	    }
	    ACTIVE(FIND_STRING(nBufferClear,'#30 XDIAL 1 R',1)):
	    {
		REMOVE_STRING(nBufferClear,'#30 XDIAL 1 R',1)
		sLastNumber = nBufferClear //Store Dialed Number
	    }
	}
    nBufferClear = ''
    }
}

TIMELINE_EVENT [TL_CLEARONE]
{
	//Feedback Here...
    [dvTP_Clear, 35] = nMutePhone
    [dvTP_Clear, 31] = nMuteCaller
}




