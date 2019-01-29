PROGRAM_NAME='URL Entry'
(***********************************************************)
(*  FILE CREATED ON: 12/18/2018  AT: 09:18:23              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/18/2018  AT: 10:41:10        *)
(***********************************************************)
DEFINE_DEVICE

dvMaster = 0:1:0; // DGX Master Host
 
DEFINE_CONSTANT



DEFINE_VARIABLE


URL_STRUCT myUrlList[2] // Remote Masters

DEFINE_START

myUrlList[1].Flags = '1';
myUrlList[1].Port = 1319;
myUrlList[1].URL = '192.168.001.002';
myUrlList[1].User = 'administrator'; // Optional for ICSPS
myUrlList[1].Password = 'password'; // Optional for ICSPS

myUrlList[2].Flags = '1';
myUrlList[2].Port = 1319;
myUrlList[2].URL = '192.168.001.003';
myUrlList[2].User = 'administrator'; // Optional for ICSPS
myUrlList[2].Password = 'password'; // Optional for ICSPS



DEFINE_EVENT

data_event[dvMaster]
{
	online:
	{
		add_url_entry(dvMaster,myUrlList[1])
		add_url_entry(dvMaster,myUrlList[2])
	}
}
