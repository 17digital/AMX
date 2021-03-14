PROGRAM_NAME='Sharp'
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

(* !! WARNINGS !! *)

(* ON INPUT SELECT PROJ WILL NOT EXCEPT ANY COMMANDS FOR 9+ SECONDS *)
(* FEEDBACK FOR POWER AND INPUT BUTTONS ONLY!!! *)

(* !! WARNINGS !! *)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
dvIP = 0:3:0
dvVirtual = 33001:1:0
dvTP = 10128:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

cRGB1[] = 'input=IRGB   1'
cRGB2[] = 'input=IRGB   2'
cVIDEO1[] = 'input=IVED   1'
cVIDEO2[] = 'input=IVED   2'
cPOWERON[] = 'power=POWR   1'
cPOWEROFF[] = 'power=POWR   0'
cAVMUTEON[] = 'avmute=IMBK   1'
cAVMUTEOFF[] = 'avmute=IMBK   0'
cVOLUME[] = 'volume=VOLA  ' // add a space before single digit volume values

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE
LONG IP_PORT      = 80  // CONNECTION PORT ON IP 
CHAR IP_ADDRESS[] = '192.168.240.199'  // ADDRESS OF IP DETECTION PAGE (PROJ)
CHAR VIRTUAL_BUFFER[10000]
SINTEGER CONNECTED = -1

INTEGER VOL_LVL = 0
INTEGER RAMP_RATE = 5
INTEGER GET_STATUS // 1 GETTING STATUS 0 NOT
INTEGER SENDING_COMMAND // 1 SENDING 0 NOT

INTEGER POWER_STATUS = 0
INTEGER INPUT_STATE
INTEGER VOL_FLAG = 0
INTEGER BUSY = 0
INTEGER BUSY_BTN = 16

INTEGER BTN_ARRAY[]=
{
 1, // POWER OFF
 2, // POWER ON
 3, // RGB1
 4, // RGB2
 5, // VIDEO1
 6, // VIDEO2
 7, // AVMUTE ON
 8 // AVMUTE OFF
}
 
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvTP]
{ 
  ONLINE:
  {
   ON[GET_STATUS]
   SEND_COMMAND dvVIRTUAL,"'GET /status.cgi HTTP/1.1',13,10,
                        'Accept-Language: en-us',13,10,
			'Content-Type: application/x-www-form-urlencoded',13,10,
			'Accept-Encoding: gzip, deflate',13,10,
			'User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)',13,10,
			'Host: ',IP_ADDRESS,13,10,
			'Connection: Keep-Alive',13,10,
			'Cache-Control: no-cache',13,10,
			'Authorization: Basic Og==',13,10,13,10"
  }
}

DATA_EVENT[dvVirtual]
{
   COMMAND:
   {
         IF(!GET_STATUS)
	 ON[SENDING_COMMAND]
         VIRTUAL_BUFFER = DATA.TEXT
	 CONNECTED = IP_CLIENT_OPEN(dvIP.PORT,IP_ADDRESS,IP_PORT,1)
   }

}
DATA_EVENT[dvIP]
{
   ONLINE:
   {
      IF(SENDING_COMMAND)
      {
      SEND_STRING dvIP,"'POST /test.cgi HTTP/1.1',13,10,
			'Accept-Language: en-us',13,10,
			'Content-Type: application/x-www-form-urlencoded',13,10,
			'Accept-Encoding: gzip, deflate',13,10,
			'User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)',13,10,
			'Host: ',IP_ADDRESS,13,10,
			'Content-Length: ',ITOA(LENGTH_STRING(VIRTUAL_BUFFER)),13,10,
			'Connection: Keep-Alive',13,10,
			'Cache-Control: no-cache',13,10,
			'Authorization: Basic Og==',13,10,13,10,
			VIRTUAL_BUFFER,13,10"
      OFF[SENDING_COMMAND]
      IF(!VOL_FLAG)
      {
      WAIT 5
      {
      ON[GET_STATUS]
      SEND_COMMAND dvVIRTUAL,"'GET /status.cgi HTTP/1.1',13,10,
                        'Accept-Language: en-us',13,10,
			'Content-Type: application/x-www-form-urlencoded',13,10,
			'Accept-Encoding: gzip, deflate',13,10,
			'User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)',13,10,
			'Host: ',IP_ADDRESS,13,10,
			'Connection: Keep-Alive',13,10,
			'Cache-Control: no-cache',13,10,
			'Authorization: Basic Og==',13,10,13,10"
      }
      }
      }
      ELSE IF(GET_STATUS)
      {
       SEND_STRING dvIP,VIRTUAL_BUFFER
       OFF[GET_STATUS]
      }
   }
   OFFLINE:
   {
     CONNECTED = -1
   }
   STRING:
   {
      IF (FIND_STRING(DATA.TEXT,'ON',1))
      {
        POWER_STATUS = 1
      }
      IF (FIND_STRING(DATA.TEXT,'STANDBY',1))
      {
        POWER_STATUS = 0
      }
      IF (FIND_STRING(DATA.TEXT,'1 (RGB/Component)',1))
      {
        INPUT_STATE = 1
      }
      IF (FIND_STRING(DATA.TEXT,'2 (RGB/Component)',1))
      {
        INPUT_STATE = 2
      }
      IF (FIND_STRING(DATA.TEXT,'3 (Video)',1))
      {
        INPUT_STATE = 3
      }
      IF (FIND_STRING(DATA.TEXT,'4 (S-Video)',1))
      {
        INPUT_STATE = 4
      }
      IF (FIND_STRING(DATA.TEXT,'OK',1) OR FIND_STRING(DATA.TEXT,'ERR',1))
      {
	 IP_CLIENT_CLOSE(dvIP.PORT)
      }
      ELSE
      {
         IP_CLIENT_CLOSE(dvIP.PORT)
      }
   }   
}

BUTTON_EVENT[dvTP,BTN_ARRAY]
{
  PUSH:
  {
    SWITCH(GET_LAST(BTN_ARRAY))
    {
      CASE 1:
      {
       SEND_COMMAND dvVirtual,"cPOWEROFF"
      }
      CASE 2:
      {
       SEND_COMMAND dvVirtual,"cPOWERON"
      }
      CASE 3:
      {
       SEND_COMMAND dvVirtual,"cRGB1"
       ON[BUSY]
       WAIT 90
       OFF[BUSY]
      }
      CASE 4:
      {
       SEND_COMMAND dvVirtual,"cRGB2"
       ON[BUSY]
       WAIT 90
       OFF[BUSY]
      }
      CASE 5:
      {
       SEND_COMMAND dvVirtual,"cVIDEO1"
       ON[BUSY]
       WAIT 90
       OFF[BUSY]
      }
      CASE 6:
      {
       SEND_COMMAND dvVirtual,"cVIDEO2"
       ON[BUSY]
       WAIT 90
       OFF[BUSY]
      }
      CASE 7:
      {
       SEND_COMMAND dvVirtual,"cAVMUTEON"
       ON[BUSY]
       WAIT 20
       OFF[BUSY]
      }
      CASE 8:
      {
       SEND_COMMAND dvVirtual,"cAVMUTEOFF"
       ON[BUSY]
       WAIT 20
       OFF[BUSY]
      }
    }
  }
}

BUTTON_EVENT[dvTP,9] //vol up
{
 PUSH:
 {
  ON[VOL_FLAG]
  IF(VOL_LVL <= (60-RAMP_RATE))
   VOL_LVL = VOL_LVL+RAMP_RATE
  IF(VOL_LVL < 10)
  SEND_COMMAND dvVirtual,"cVOLUME,' ',ITOA(VOL_LVL)"
  ELSE
  SEND_COMMAND dvVirtual,"cVOLUME,ITOA(VOL_LVL)"
 }
 HOLD[5,REPEAT]:
 {
  IF(VOL_LVL <= (60-RAMP_RATE))
   VOL_LVL = VOL_LVL+RAMP_RATE
  IF(VOL_LVL < 10)
  SEND_COMMAND dvVirtual,"cVOLUME,' ',ITOA(VOL_LVL)"
  ELSE
  SEND_COMMAND dvVirtual,"cVOLUME,ITOA(VOL_LVL)"
 }
 RELEASE:
 {
   WAIT 1
   OFF[VOL_FLAG]
 }
}

BUTTON_EVENT[dvTP,10] //vol dn
{
 PUSH:
 {
  ON[VOL_FLAG]
  IF(VOL_LVL >= (0+RAMP_RATE))
   VOL_LVL = VOL_LVL-RAMP_RATE
   IF(VOL_LVL < 10)
  SEND_COMMAND dvVirtual,"cVOLUME,' ',ITOA(VOL_LVL)"
  ELSE
  SEND_COMMAND dvVirtual,"cVOLUME,ITOA(VOL_LVL)"
 }
 HOLD[5,REPEAT]:
 {
  IF(VOL_LVL >= (0+RAMP_RATE))
   VOL_LVL = VOL_LVL-RAMP_RATE
  IF(VOL_LVL < 10)
  SEND_COMMAND dvVirtual,"cVOLUME,' ',ITOA(VOL_LVL)"
  ELSE
  SEND_COMMAND dvVirtual,"cVOLUME,ITOA(VOL_LVL)"
 }
 RELEASE:
 {
   WAIT 1
   OFF[VOL_FLAG]
 }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,BTN_ARRAY[1]] = (!POWER_STATUS)
[dvTP,BTN_ARRAY[2]] = (POWER_STATUS)
[dvTP,BTN_ARRAY[3]] = (INPUT_STATE = 1)
[dvTP,BTN_ARRAY[4]] = (INPUT_STATE = 2)
[dvTP,BTN_ARRAY[5]] = (INPUT_STATE = 3)
[dvTP,BTN_ARRAY[6]] = (INPUT_STATE = 4) 
[dvTP,BUSY_BTN] = (BUSY)

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

