PROGRAM_NAME='SET_IP'
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 01/28/2019  AT: 11:58:14        *)
(***********************************************************)

DEFINE_DEVICE

#IF_NOT_DEFINED dvMaster
dvMaster =			0:1:0
#END_IF


DEFINE_VARIABLE

IP_ADDRESS_STRUCT myIPSet[1]
DNS_STRUCT myDNS[1]



DEFINE_START


myIPSet[1].FLAGS = 0 //Use Static... 1 for DHCP
myIPSet[1].HOSTNAME = 'Skiles006Master'
myIPSet[1].IPADDRESS = '172.21.1.128'
myIPSet[1].SUBNETMASK = '255.255.252.0'
myIPSet[1].GATEWAY = '172.21.0.1'

//Dns...
myDNS[1].DomainName = 'amx.gatech.edu'
myDNS[1].DNS1 = '130.207.24.4'
myDNS[1].DNS2 = '128.61.1.2'
myDNS[1].DNS3 = '130.207.24.4'


WAIT 250
{

    SET_IP_ADDRESS(dvMaster,myIPSet[1])
    SET_DNS_LIST (dvMaster, myDNS[1])
}