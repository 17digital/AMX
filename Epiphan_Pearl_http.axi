PROGRAM_NAME='Epiphan_Pearl_V1'
(***********************************************************)
(*  FILE CREATED ON: 02/15/2017  AT: 09:10:34              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 05/02/2020  AT: 11:27:10        *)
(***********************************************************)

(**
    Notes...
    No Feedback or API for USB Transfer...
    Needs Verbose Mode for detailed feedback. Example to query layout only sends back interger. Needs detail of Channel, etc.
    Also no detailed feedback for GET rec Status or Stream Status
    
    Recording Timer returns only seconds...
        
**)
    

DEFINE_DEVICE


dvTP_Recorder =			10001:4:0
dvTP_RecBooth =		10002:4:0
dvTP_RecStudio =		10003:4:0


#IF_NOT_DEFINED dvPearl
dvPearl =					0:3:0
#END_IF

DEFINE_CONSTANT

CHAR PEARL_IP_HOST[]		= '172.21.2.111'
CHAR PEARL_IP_PORT[]		= 80;
CHAR PEARL_USER[]			= 'admin'
CHAR PEARL_PSWD[]		= 'Administrator'

CHAR BASE64_ALPHABET[64]    = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
CHAR BASE64URL_ALPHABET[64] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';
CHAR BASE64_PAD = '=';

HTTP_MAX_MESSAGE_LENGTH = 65535
HTTP_MAX_BODY_LENGTH    = 65535

CHAR HTTP_VERSION_1_0[] = 'HTTP/1.0';
CHAR HTTP_VERSION_1_1[] = 'HTTP/1.1';

#IF_NOT_DEFINED CR
CHAR CR					= $0D;
#END_IF

#IF_NOT_DEFINED	LF 
CHAR LF					= $0A;
#END_IF

// Time Lines
TL_TIMER					= 21; //Recording Timer
TL_TRANSFER				= 22; //Loop for Checking USB Transfer Status...
LONG TL_IPCOMM_CONNECT		= 5001 

TXT_REC_STATUS			= 10
TXT_USB_STATUS			= 11
TXT_TIMER				= 12

CHANNEL_AV_SERVICES		= 3

//Layouts..Defined within Pearl...
LAYOUT_FULL_CAMERA		= 1; //Camera ONLY
LAYOUT_FULL_CONTENT	= 2; //Content ONLY
LAYOUT_EQUAL			= 3; //Camera + Content Side by Side
LAYOUT_CAM_PIP			= 4; //Camera in Corner in Front of BG
LAYOUT_PRODUCTION		= 9; //Camera w/ Green Chroma Key

//Buttons...
BTN_START_REC			= 1
BTN_STOP_REC			= 2
BTN_START_STREAM		= 3
BTN_STOP_STREAM		= 4
BTN_USB_EJECT			= 5

BTN_LAYOUT_FULL_CAM	= 9
BTN_LAYOUT_FULL_CON		= 10
BTN_LAYOUT_EQUAL		= 11
BTN_LAYOUT_CAM_PIP		= 12
BTN_LAYOUT_CONT_PRO	= 13 //Production


//Test Buttons...
BTN_QUERY_LAYOUT			= 101
BTN_QUERY_SYSTEM			= 102
BTN_QUERY_USB				= 103;
BTN_QUERY_TRANSFER			= 104;

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

STRUCT _PearlBox
{
    CHAR iHost[30];
    INTEGER iPort;
    INTEGER iFlag;
    CHAR iOnline;
    CHAR iRec;
    CHAR iDbug;
    CHAR iMacAddress[17];
    CHAR iProduct[10];
    CHAR iFirmware[6];
    INTEGER iLayout;
    CHAR iUsbSpace[15] //Bytes 15711338496
    CHAR iUsbFileName[30];
    INTEGER iTransferInProgress;
    INTEGER iFiles;
}
STRUCT HttpHeader 
{
    CHAR name[100];
    CHAR value[1024];
}
STRUCT HttpRequest 
{
    float version;
    CHAR method[10];
    CHAR requestUri[200];
    HttpHeader headers[20];
    CHAR body[HTTP_MAX_BODY_LENGTH];
}
STRUCT HttpStatus 
{
    integer code;
    CHAR message[100];
}
STRUCT HttpResponse 
{
    float version;
    HttpStatus status;
    HttpHeader headers[20];
    CHAR body[HTTP_MAX_BODY_LENGTH];
}


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE _PearlBox PearlInfo;
 VOLATILE CHAR httpResponseBuffer[2048];

VOLATILE LONG lTLStatusUp[] = {3000} //3 Seconds
VOLATILE LONG lRecordTimer[] = {1000} //1 Second Pull...
VOLATILE LONG lTlIpConnect[] = {30000}; //30-second Query Loop...

VOLATILE CHAR iPassEncode[100]; //Holds Converted Password to Base64

VOLATILE INTEGER lSecondTimer;
VOLATILE INTEGER nMinuteStamp;
VOLATILE INTEGER nHourStamp;

VOLATILE DEV vdvTP_Capture[] =
{
    dvTP_Recorder
};
VOLATILE INTEGER nLayoutSends[] =
{
    LAYOUT_FULL_CAMERA,
    LAYOUT_FULL_CONTENT,
    LAYOUT_EQUAL,
    LAYOUT_CAM_PIP,
    LAYOUT_PRODUCTION
}
VOLATILE INTEGER nLayoutBtns[] =
{
    BTN_LAYOUT_FULL_CAM,
    BTN_LAYOUT_FULL_CON,
    BTN_LAYOUT_EQUAL,
    BTN_LAYOUT_CAM_PIP,
    BTN_LAYOUT_CONT_PRO
}
VOLATILE INTEGER nTransportBtns[] =
{
    BTN_START_REC,
    BTN_STOP_REC,
    BTN_START_STREAM,
    BTN_STOP_STREAM,
    BTN_USB_EJECT
}

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvTP_Recorder, BTN_START_REC],[dvTP_Recorder, BTN_STOP_REC])
([dvTP_Recorder, BTN_LAYOUT_FULL_CAM]..[dvTP_Recorder, BTN_LAYOUT_CONT_PRO])

([dvTP_RecBooth, BTN_START_REC],[dvTP_RecBooth, BTN_STOP_REC])
([dvTP_RecBooth, BTN_LAYOUT_FULL_CAM]..[dvTP_RecBooth, BTN_LAYOUT_CONT_PRO])

([dvTP_RecStudio, BTN_START_REC],[dvTP_RecStudio, BTN_STOP_REC])
([dvTP_RecStudio, BTN_LAYOUT_FULL_CAM]..[dvTP_RecStudio, BTN_LAYOUT_CONT_PRO])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *) 
DEFINE_FUNCTION fnStartPearlConnection() {

    WAIT 5 '1 Second' {
	IP_CLIENT_OPEN (dvPearl.PORT, PearlInfo.iHost, PearlInfo.iPort, PearlInfo.iFlag);
		SEND_STRING 0, "'Attempt to Start Pearl-2 Connection...'"
    }
}
DEFINE_FUNCTION fnClosePearlConnection() {
	IP_CLIENT_CLOSE (dvPearl.PORT);
		SEND_STRING 0, "'Closed Pearl-2 Connection...'"
}
DEFINE_FUNCTION char[100] GetPearlIpError (LONG iErrorCode)
{
    CHAR iReturn[100];
    
    SWITCH (iErrorCode)
    {
	CASE 2 : iReturn = "'General failure (Out of Memory) '" ;
	CASE 4 : iReturn = "'Unknown host'";
	CASE 6 : iReturn = "'Connection Refused'";
	CASE 7 : iReturn = "'Connection timed Out'";
	CASE 8 : iReturn = "'Unknown Connection Error'";
	CASE 9 : iReturn = "'Already Closed'";
	CASE 10 : iReturn = "'Binding Error'";
	CASE 11 : iReturn = "'Listening Error'";
	CASE 14 : iReturn = "'Local Port Already Used'";
	CASE 15 : iReturn = "'UDP Socket Already Listening'";
	CASE 16 : iReturn = "'Too Many Open Sockets'";
	CASE 17 : iReturn = "'Local Port Not Open'"
	
	DEFAULT : iReturn = "'(', ITOA(iErrorCode),') Undefined'";
    }
    RETURN iReturn;
}
DEFINE_FUNCTION CHAR[1024] httpBasicAuthentication(CHAR username[], CHAR password[]) {
    STACK_VAR CHAR auth[1024];
    
    auth = "'Basic ',base64Encode("username,':',password")"
    RETURN auth;
    
    //https://github.com/DavidVine/amx-util-library/blob/master/http.axi
    //Line 922
}
define_function char[1024] base64Encode(char data[]) {
	char encodedData[1024];
	char val6Bit;
	integer i;

	// 1. Split into 6-bit values
	// 2. Encode 6-bit values into 8-bit ASCII characters using Base-64 Alphabet
	// 3. Pad with '=' to create string length evenly divisible by 4-char blocks

	for(i=1; i<=length_array(data); i++) {
		if((i == 1) || (i%3 == 1)) {
			val6Bit = type_cast((data[i] BAND $FC) >> 2)
			encodedData = "encodedData,base64AlphabetLookup(val6Bit)"
			if(i == length_array(data)) {
				val6Bit = type_cast((data[i] BAND $3) << 4)
			} else {
				val6Bit = type_cast(((data[i] BAND $3) << 4) BOR ((data[i+1] BAND $F0) >> 4))
			}
			encodedData = "encodedData,base64AlphabetLookup(val6Bit)"
		} else if((i == 2) || (i%3 == 2)) {
			if(i == length_array(data)) {
				val6Bit = type_cast((data[i] BAND $F) << 2)
			} else {
				val6Bit = type_cast(((data[i] BAND $F) << 2) BOR ((data[i+1] BAND $C0) >> 6))
			}
			encodedData = "encodedData,base64AlphabetLookup(val6Bit)"
		} else if((i == 3) || (i%3 == 0)) {
			val6Bit = type_cast(data[i] BAND $3F)
			encodedData = "encodedData,base64AlphabetLookup(val6Bit)"
		}
	}

	// pad if required
	while((length_array(encodedData) % 4) != 0) {
		encodedData = "encodedData,BASE64_PAD";
	}

	return encodedData;	
}
define_function char base64AlphabetLookup(char val) {
	if(val > 63) return type_cast('');
	return BASE64_ALPHABET[val+1];
}
DEFINE_FUNCTION fnConvertPassword() {
    
	iPassEncode = httpBasicAuthentication(PEARL_USER, PEARL_PSWD);
}
DEFINE_FUNCTION sendPearlHttp(CHAR iMode[20], CHAR iCmd[500])
{
    STACK_VAR CHAR iPacket[500];
    
    //Minimum HTTP 1.1 Requirment
    iPacket = "iMode, ' ',iCmd, ' HTTP/1.1',$0D,$0A,
		    'Host: ',PearlInfo.iHost,':',ITOA(PearlInfo.iPort),$0D,$0A,
		    //'Connection: keep-alive',$0D,$0A,
		    'Authorization: ',iPassEncode,$0D,$0A,
		    //'cache_control: max-age=0',$0D,$0A,
		    //'Content-Type: application/x-www-form-urlencoded',$0D,$0A,
		    $0D,$0A"; //Http terminates with the empty line
    
    IF (PearlInfo.iOnline == TRUE)
    {
	SEND_STRING dvPearl, iPacket; //If online/connected - send the actual packet...
    } ELSE {
	//sGitIpQueue = "sGitIpQueue , iPacket"
	    IP_CLIENT_OPEN (dvPearl.PORT, PearlInfo.iHost, PearlInfo.iPort, PearlInfo.iFlag);
		    SEND_STRING dvPearl, iPacket; //If online/connected - send the actual packet...

    }
}
DEFINE_FUNCTION ParseLinesFromPearl(CHAR cMsg[2048]) {

    LOCAL_VAR CHAR iRead[2048];
    LOCAL_VAR CHAR iBug[100];
    LOCAL_VAR CHAR iJson[500]
    
    WHILE(FIND_STRING(httpResponseBuffer,'HTTP/1.1 200 OK',1)) {
	REMOVE_STRING(httpResponseBuffer, 'HTTP/1.1 200 OK',1)
	
	IF (FIND_STRING(httpResponseBuffer,'Content-Type: text/plain; charset=UTF-8',1)) { //Regular Body Message
	    REMOVE_STRING(httpResponseBuffer, 'Content-Type: text/plain; charset=UTF-8',1) //Just Before Body
	    
	    cMsg = httpResponseBuffer;
		iRead = cMsg;
	    
	    IF (FIND_STRING(cMsg,'active_layout =',1)) {
		REMOVE_STRING(cMsg,'= ',1)
		    PearlInfo.iLayout = ATOI(LEFT_STRING(cMsg, 1));
		    
		    SWITCH (PearlInfo.iLayout)
		    {
			CASE LAYOUT_FULL_CAMERA : {
			    ON [vdvTP_Capture, BTN_LAYOUT_FULL_CAM]
				BREAK;
			}
			CASE LAYOUT_FULL_CONTENT : {
			    ON [vdvTP_Capture, BTN_LAYOUT_FULL_CON]
				BREAK;
			}
			CASE LAYOUT_EQUAL : {
			    ON [vdvTP_Capture, BTN_LAYOUT_EQUAL]
				BREAK;
			}
			CASE LAYOUT_CAM_PIP : {
			    ON [vdvTP_Capture, BTN_LAYOUT_CAM_PIP]
				BREAK;
			}
			CASE LAYOUT_PRODUCTION : {
			    ON [vdvTP_Capture, BTN_LAYOUT_CONT_PRO]
				BREAK;
			}
		    
		    }
	    }
	    IF (FIND_STRING(cMsg,'product_name = ',1)) {
		    REMOVE_STRING(cMsg, '= ',1)
			PearlInfo.iProduct = LEFT_STRING(cMsg,LENGTH_STRING(cMsg) -4);
	    }
	    IF (FIND_STRING(cMsg,'mac_address = ',1)) {
		    REMOVE_STRING(cMsg, '= ',1)
			PearlInfo.iMacAddress = LEFT_STRING(cMsg,LENGTH_STRING(cMsg) -2);
	    }
	    IF (FIND_STRING(cMsg,'firmware_version = ',1)) {
		REMOVE_STRING (cMsg,'= ',1)
		    PearlInfo.iFirmware = LEFT_STRING(cMsg, 6);
			iBug = cMsg;
	    }
	    IF (FIND_STRING(cMsg,'rec_enabled =',1)) {
		    REMOVE_STRING (cMsg,'= ',1)
		    IF (FIND_STRING(cMsg,'on',1)) {
			PearlInfo.iRec = TRUE;
			     ON [vdvTP_Capture, nTransportBtns[1]];
				SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Started'"
		    } ELSE {
			PearlInfo.iRec = FALSE;
			     ON [vdvTP_Capture, nTransportBtns[2]];
				SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_REC_STATUS),',0,Recording Stopped'"
				
				IF(TIMELINE_ACTIVE(TL_TIMER)) {
				    TIMELINE_KILL(TL_TIMER)
				}
		    }
	    }
	}
	ELSE IF (FIND_STRING(httpResponseBuffer,'application/json',1)) { //Just Before Json Structure
		    REMOVE_STRING(httpResponseBuffer, 'application/json',1) //Just Before Json Structure
		    
		    cMsg = httpResponseBuffer;
			iJson = cMsg;
			
	    IF (FIND_STRING(cMsg,'"state":"idle"',1)) { //Transfer Status 'Nothing Happening'
	    
		//File Not Transfering...OK to Record....
		SEND_STRING 0, "'No File being Transferred'"
		SEND_COMMAND vdvTP_Capture, "'^PPF-_Warning'"
		    PearlInfo.iTransferInProgress = FALSE;
		
		IF(TIMELINE_ACTIVE(TL_TRANSFER)) {
		    TIMELINE_KILL(TL_TRANSFER)
		}
	    }
	    IF (FIND_STRING(cMsg,'"state":"uploading"',1)) { //Transfer Status 'File Being Uploaded'
		//Start Timeline Repeat....Need to query every 2 seconds if transfer is still happening?
		SEND_COMMAND vdvTP_Capture, "'^PPN-_Warning'"
		     PearlInfo.iTransferInProgress = TRUE;
		//File Not Transfering...OK to Record....
		SEND_STRING 0, "'File being Transferred!'"
		REMOVE_STRING(cMsg,'"id":"VGA.',1)
		    PearlInfo.iUsbFileName = REMOVE_STRING(cMsg,'.mp4',1)
			SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Transfering File : ',PearlInfo.iUsbFileName,' to USB'"
		    
		    IF (!TIMELINE_ACTIVE(TL_TRANSFER)) {
			       TIMELINE_CREATE(TL_TRANSFER, lTLStatusUp, LENGTH_ARRAY(lTLStatusUp), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		    }
	    }
	    IF (FIND_STRING(cMsg,'"state":"error"',1)) { //Files Ready to transfer... but No USB Inserted.
		PearlInfo.iTransferInProgress = FALSE;
		//File Not Transfering...OK to Record....
		SEND_STRING 0, "'No USB Mounted!!!'"
		REMOVE_STRING(cMsg,'"files":',1)
			PearlInfo.iFiles = ATOI(LEFT_STRING(cMsg, 1));
			SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB: No USB drive Mounted'"
	    }
	    IF (FIND_STRING(cMsg,'"state":"ready"',1)) { //USB Insert Status...
		    //USB is in Drive
		    REMOVE_STRING(cMsg,'"state":"ready"',1)
		    REMOVE_STRING(cMsg, '"free":',1)
			PearlInfo.iUsbSpace = REMOVE_STRING(cMsg,'}}',1)
			    PearlInfo.iUsbSpace = LEFT_STRING(PearlInfo.iUsbSpace,LENGTH_STRING(PearlInfo.iUsbSpace) -2);
				fnConvertByteMessage(PearlInfo.iUsbSpace);
				//SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB Ready! | Space Available : ',PearlInfo.iUsbSpace"
	    }
	    IF (FIND_STRING(cMsg,'"state":"nodev"',1)) { //USB Insert Status...
		    //No USB is in Drive
			    PearlInfo.iUsbSpace = 'Not Found'
				PearlInfo.iTransferInProgress = FALSE;
				SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB : ',PearlInfo.iUsbSpace"
				
	    }
	    IF (FIND_STRING(cMsg,'"status":"ok"',1)) { //USB Insert Status...
		PearlInfo.iUsbSpace = 'Not Found'
				PearlInfo.iTransferInProgress = FALSE;
				SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB : Please Remove USB '"
				WAIT 20 {
				    sendPearlHttp( 'GET', '/api/system/storages/external/status'); //Get USB Connection...
				}
	    
	    }
	}
    }
}
DEFINE_FUNCTION fnStartRecTimer() {
    STACK_VAR CHAR iTimeFormated[20];
    LOCAL_VAR CHAR iTimeResult[20];
    
    lSecondTimer = lSecondTimer + 1;
    
    IF (lSecondTimer == 60) {
	    nMinuteStamp = nMinuteStamp + 1;
	
	IF (nMinuteStamp == 60) {
	    nHourStamp = nHourStamp + 1;
		nMinuteStamp = 0;
	}
	lSecondTimer = 0;
    }
    iTimeFormated = FORMAT(': %02d ',lSecondTimer)
	iTimeFormated = "FORMAT(': %02d ',nMinuteStamp),iTimeFormated" //Append the minutes..
	iTimeFormated = "FORMAT(' %02d ', nHourStamp), iTimeFormated" 
	    iTimeResult = iTimeFormated;
    
    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,',iTimeResult"
}
DEFINE_FUNCTION fnResetRecTimerToZero() {
    nMinuteStamp = 0;
    nHourStamp = 0;
    lSecondTimer = 0;
	SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_TIMER),',0,00 : 00 : 00'"
}
DEFINE_FUNCTION fnConvertByteMessage(CHAR cBytes[13]) {
	STACK_VAR CHAR cLead[3];
	STACK_VAR CHAR cTail[3]

	IF(LENGTH_STRING(cBytes) == 13) { //We have 3Digit Gig Number
	    cLead = LEFT_STRING(cBytes, 3);
		cTail = MID_STRING(cBytes, 4, 3);
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB Ready | Space Available : ',cLead,'.',cTail,' GB'"
	}
	ELSE IF(LENGTH_STRING(cBytes) == 12) { //We have 2Digit Gig Number
	    cLead = LEFT_STRING(cBytes, 2);
		cTail = MID_STRING(cBytes, 3, 3);
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB Ready | Space Available : ',cLead,'.',cTail,' GB'"
	}
	ELSE IF(LENGTH_STRING(cBytes) == 10) { //We have 1Digit Gig Number
	    cLead = LEFT_STRING(cBytes, 1);
		cTail = MID_STRING(cBytes, 2, 3);
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB Ready | Space Available : ',cLead,'.',cTail,' GB'"
	}
	ELSE IF(LENGTH_STRING(cBytes) == 9) { //We have 3Digit MegaByte Number
	    cLead = LEFT_STRING(cBytes, 3);
		cTail = MID_STRING(cBytes, 3, 3);
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB Ready | Space Available : ',cLead,'.',cTail,' MB'"
	}
	ELSE
	{
	    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,USB Ready | Space Available : Need More Space!'"
	}
}


DEFINE_START

PearlInfo.iHost = PEARL_IP_HOST;
PearlInfo.iPort = PEARL_IP_PORT;
PearlInfo.iFlag = IP_TCP;

fnConvertPassword();

    TIMELINE_CREATE (TL_IPCOMM_CONNECT,lTlIpConnect,LENGTH_ARRAY(lTlIpConnect),TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
	CREATE_BUFFER dvPearl, httpResponseBuffer;
	
WAIT 600
{
	SEND_STRING 0, "'Master Completed Boot ',__TIME__"
	    SEND_STRING 0, "'Today is : ',__DATE__"
}

DEFINE_EVENT
BUTTON_EVENT [vdvTP_Capture, nTransportBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER b;
	    b = GET_LAST (nTransportBtns)
	    
	SWITCH (b)
	{
	    CASE 1 : { //Start Recording....
		    ON [vdvTP_Capture, nTransportBtns[1]];
			sendPearlHttp( 'GET', "'/admin/channel',ITOA(CHANNEL_AV_SERVICES),'/set_params.cgi?rec_enabled=on'");
			    PearlInfo.iRec = TRUE;
				fnResetRecTimerToZero();
			    
		    IF(!TIMELINE_ACTIVE(TL_TIMER)) {
			    TIMELINE_CREATE(TL_TIMER,lRecordTimer,LENGTH_ARRAY(lRecordTimer),TIMELINE_ABSOLUTE,TIMELINE_REPEAT);
		    }
	    }
	    CASE 2 : { //Stop Recording
		ON [vdvTP_Capture, nTransportBtns[2]];
			sendPearlHttp( 'GET', "'/admin/channel',ITOA(CHANNEL_AV_SERVICES),'/set_params.cgi?rec_enabled=off'");
			
		    IF(TIMELINE_ACTIVE(TL_TIMER)) { //Kill Rec Timeline if it was running...
				    TIMELINE_KILL(TL_TIMER)
		    }
		    WAIT 20 'Check Transfer Status' {
			sendPearlHttp( 'GET', '/api/afu/0/status');
		    }
	    }
	    CASE 3 : //Stream On (if Available)
	    {
		sendPearlHttp( 'GET', "'/admin/channel',ITOA(CHANNEL_AV_SERVICES),'/set_params.cgi?published_enabled=on'");
		    ON [vdvTP_Capture, nTransportBtns[3]];
	    }
	    CASE 4 : //Stream Off
	    {
		    sendPearlHttp( 'GET', "'/admin/channel',ITOA(CHANNEL_AV_SERVICES),'/set_params.cgi?published_enabled=off'");
			ON [vdvTP_Capture, nTransportBtns[4]];
	    }
	    CASE 5 : //USB Eject...
	    {
		IF (PearlInfo.iTransferInProgress == TRUE) {
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Transfering File : Still In Progress'"
		
		}
		ELSE IF (PearlInfo.iRec == TRUE) {
		    SEND_COMMAND vdvTP_Capture, "'^TXT-',ITOA(TXT_USB_STATUS),',0,Recording : Still In Progress'"
		} ELSE {
		    sendPearlHttp( 'SET', '/api/system/storages/external/eject');
		}
	    }
	}
    }
}
BUTTON_EVENT [vdvTP_Capture, nLayoutBtns]
{
    PUSH :
    {
	STACK_VAR INTEGER i;
	    i = GET_LAST (nLayoutBtns);
		sendPearlHttp( 'GET', "'/admin/channel',ITOA(CHANNEL_AV_SERVICES),'/set_params.cgi?active_layout=',ITOA(nLayoutSends[i])");
		    ON [vdvTP_Capture, nLayoutBtns[i]];
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_QUERY_SYSTEM]
{
    PUSH :
    {
	sendPearlHttp( 'GET', '/admin/channel3/get_params.cgi?product_name&mac_address&firmware_version');
    }
}
BUTTON_EVENT [vdvTP_Capture, BTN_QUERY_TRANSFER] //Transfer Must Be Enabled
{
    PUSH :
    {
	sendPearlHttp( 'GET', '/api/afu/0/status');
    }
}

DEFINE_EVENT
DATA_EVENT [dvTP_Recorder]
{
    ONLINE :
    {
	WAIT 20 { 
	    IF (TIMELINE_ACTIVE (TL_IPCOMM_CONNECT)) {
	    	    TIMELINE_SET(TL_IPCOMM_CONNECT, lTlIpConnect[LENGTH_ARRAY(lTlIpConnect)] -100); //Set to Just before the end - speed things up
	    }
	}
    }
}
DATA_EVENT [dvPearl]
{
    ONLINE :
    {
	PearlInfo.iOnline = TRUE;
    }
    OFFLINE :
    {
	PearlInfo.iOnline = FALSE;
    }
    ONERROR :
    {
	SEND_STRING 0, "'<-- Could Not Reach Config.amx !!-->',GetPearlIpError(DATA.NUMBER)";
	    PearlInfo.iOnline = FALSE;
    }
    STRING :
    {
	STACK_VAR response[2048];
	    response = httpResponseBuffer;
	    ParseLinesFromPearl(response);
	    
		CLEAR_BUFFER httpResponseBuffer;
		    //process the Http request Object..

    }
}
TIMELINE_EVENT [TL_IPCOMM_CONNECT] //Call the Constant ID ...
{
    SEND_STRING 0, "'30 Seconds has Passed since -  '__TIME__"
	sendPearlHttp( 'GET', "'/admin/channel',ITOA(CHANNEL_AV_SERVICES),'/get_params.cgi?rec_enabled'"); //Get Rec Status...
	
	WAIT 30 {
	    sendPearlHttp( 'GET', '/api/system/storages/external/status'); //Get USB Connection...
	}
	WAIT 60 {
		sendPearlHttp( 'GET', "'/admin/channel',ITOA(CHANNEL_AV_SERVICES),'/get_params.cgi?active_layout'");
	}
}
TIMELINE_EVENT [TL_TIMER]
{
    fnStartRecTimer();
}
TIMELINE_EVENT [TL_TRANSFER]
{
    sendPearlHttp( 'GET', '/api/afu/0/status');
}
