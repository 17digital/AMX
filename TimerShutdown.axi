PROGRAM_NAME='TimerShutdown'



DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Timer
dvTP_Timer =			10002:1:0
#END_IF



DEFINE_CONSTANT


BTN_SHUTDOWN			= 99

TXT_SHUTDOWN			= 99


TL_SHUTDOWN			= 99
TL_OFF_SEQUENCE			= 100

//Set this time to how long system takes to shutdown
SET_COOL_TIME			= 30

DEFINE_VARIABLE

VOLATILE LONG lTlOffSquence[] = 
{
    0, //Set Projector to Default input & Start timer
    1000, //Wait 1 Second
    3000  //Raise Screen
}
VOLATILE LONG lTShutdown[] =
{
    1000 // 1-Second Interval 
}

DEFINE_START

DEFINE_EVENT
BUTTON_EVENT [dvTP_Timer, BTN_SHUTDOWN]
{
    PUSH :
    {
	IF (!TIMELINE_ACTIVE (TL_OFF_SEQUENCE)) //Lets avoid any accidental timeline runs first
	{
	    TIMELINE_CREATE (TL_OFF_SEQUENCE, lTlOffSquence, LENGTH_ARRAY (lTlOffSquence), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
	}
    }
}
TIMELINE_EVENT [TL_OFF_SEQUENCE]
{
    SEND_STRING 0, "'timeline_event[TL_OFF_SEQUENCE]: timeline.sequence = ', ITOA(TIMELINE.SEQUENCE)";
    
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 : //Start timer
	{
	    IF (!TIMELINE_ACTIVE (TL_SHUTDOWN)) //Lets avoid any accidental timeline runs first
	    {
		TIMELINE_CREATE (TL_SHUTDOWN, lTShutdown, LENGTH_ARRAY (lTShutdown), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		//Set timer box to top of time...
		SEND_COMMAND dvTP_Timer, "'^TXT-',ITOA(TXT_SHUTDOWN),',0,',FORMAT('%d Seconds',SET_COOL_TIME)"
		    //Show PopUp. Page...
			SEND_COMMAND dvTP_Timer, "'^PPN-TimerWarning'"
		    
	    }
	}
	CASE 2 : 
	{
	    //Projector Off
	}
	CASE 3 : 
	{
	    //screen Up..
	}
    }
}
TIMELINE_EVENT [TL_SHUTDOWN]
{
    IF (TIMELINE.REPETITION < SET_COOL_TIME)
    {
	//Decrement counter
	STACK_VAR INTEGER iTime;
	
	iTime = TYPE_CAST(SET_COOL_TIME - TIMELINE.REPETITION) -1; //Type Cast used to dumb down the converstions. Timeline.Rep - is a long variable, Set_Cool_time is an integer! 
	    SEND_COMMAND dvTP_Timer, "'^TXT-',ITOA(TXT_SHUTDOWN),',0,',FORMAT('%d Seconds ',iTime)"
    }
    ELSE
    {
	TIMELINE_KILL (TL_SHUTDOWN)
	    //Kill Pop Up if you Want
    }
}

