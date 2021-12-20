PROGRAM_NAME='TimerShutdown'



DEFINE_DEVICE

#IF_NOT_DEFINED dvTP_Timer
dvTP_Timer =			10002:1:0
#END_IF



DEFINE_CONSTANT


BTN_SHUTDOWN			= 99
BTN_START_UP			= 98

TXT_SHUTDOWN			= 99


TL_SHUTDOWN			= 99
TL_ON_SEQUENCE			= 98
TL_OFF_SEQUENCE			= 100

//Set this time to how long system takes to shutdown
SET_COOL_TIME			= 30

DEFINE_VARIABLE

VOLATILE INTEGER nStarter_
VOLATILE INTEGER nLockOutStart;
VOLATILE INTEGER nPwrOn;

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

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

//([dvTP_Timer, BTN_START_UP], [dvTP_Timer, BTN_SHUTDOWN])


DEFINE_START

WAIT 200
{
    nPwrOn = FALSE;
    [dvTP_Timer, BTN_SHUTDOWN] = nPwrOn;
}


DEFINE_EVENT
BUTTON_EVENT [dvTP_Timer, BTN_START_UP]
{
    PUSH :
    {
	IF (nLockOutStart == TRUE)
	{
	    //Warning you gotta Wait
	}
	ELSE
	{
	    IF (!TIMELINE_ACTIVE (TL_ON_SEQUENCE)) //Lets avoid any accidental timeline runs first
	    {
		TIMELINE_CREATE (TL_ON_SEQUENCE, lTlOffSquence, LENGTH_ARRAY (lTlOffSquence), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
	    }
	}
    }
}
BUTTON_EVENT [dvTP_Timer, BTN_SHUTDOWN]
{
    PUSH :
    {
	IF (nLockOutStart == TRUE)
	{
	    //Warning you gotta Wait
	}
	ELSE
	{
	    IF (!TIMELINE_ACTIVE (TL_OFF_SEQUENCE)) //Lets avoid any accidental timeline runs first
	    {
		    TIMELINE_CREATE (TL_OFF_SEQUENCE, lTlOffSquence, LENGTH_ARRAY (lTlOffSquence), TIMELINE_ABSOLUTE, TIMELINE_ONCE);
	    }
	}
    }
}
TIMELINE_EVENT [TL_ON_SEQUENCE]
{
    SEND_STRING 0, "'timeline_event[TL_ON_SEQUENCE]: timeline.sequence = ', ITOA(TIMELINE.SEQUENCE)";
    
    SWITCH (TIMELINE.SEQUENCE)
    {
	CASE 1 : //Start timer
	{
	    nPwrOn = TRUE;
	    nStarter_ = TRUE;
	    nLockOutStart = TRUE;
	    SEND_COMMAND dvTP_Timer, "'^BMF-',ITOA(TXT_SHUTDOWN),',0,%OP255'"
		BREAK;
	}
	CASE 2 : 
	{
	    IF (!TIMELINE_ACTIVE (TL_SHUTDOWN)) //Lets avoid any accidental timeline runs first
	    {
		TIMELINE_CREATE (TL_SHUTDOWN, lTShutdown, LENGTH_ARRAY (lTShutdown), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		//Set timer box to top of time...
		SEND_COMMAND dvTP_Timer, "'^TXT-',ITOA(TXT_SHUTDOWN),',0,',FORMAT('%d Seconds',SET_COOL_TIME)"
		    //Show PopUp. Page...
			SEND_COMMAND dvTP_Timer, "'^PPN-TimerWarning'"
	    }
	    BREAK;
	}
	CASE 3 : 
	{
	    //screen Up..
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
	    nPwrOn = FALSE;
	    nStarter_ = FALSE;
	     nLockOutStart = TRUE;
		SEND_COMMAND dvTP_Timer, "'^BMF-',ITOA(TXT_SHUTDOWN),',0,%OP255'"
		BREAK;
	}
	CASE 2 : 
	{
	    IF (!TIMELINE_ACTIVE (TL_SHUTDOWN)) //Lets avoid any accidental timeline runs first
	    {
		TIMELINE_CREATE (TL_SHUTDOWN, lTShutdown, LENGTH_ARRAY (lTShutdown), TIMELINE_ABSOLUTE, TIMELINE_REPEAT);
		//Set timer box to top of time...
		SEND_COMMAND dvTP_Timer, "'^TXT-',ITOA(TXT_SHUTDOWN),',0,',FORMAT('%d Seconds',SET_COOL_TIME)"
		    //Show PopUp. Page...
			SEND_COMMAND dvTP_Timer, "'^PPN-TimerWarning'"
	    }
	    BREAK;
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
	    
	    SWITCH (nStarter_)
	    {
		CASE 1 : //On...
		{
		    [dvTP_Timer, BTN_START_UP] = ![dvTP_Timer, BTN_START_UP]
		    BREAK;
		}
		DEFAULT :
		{
		    [dvTP_Timer, BTN_SHUTDOWN] = ![dvTP_Timer, BTN_SHUTDOWN]
			BREAK;
		}
	    }
    }
    ELSE
    {
	TIMELINE_KILL (TL_SHUTDOWN)
	    SEND_COMMAND dvTP_Timer, "'^BMF-',ITOA(TXT_SHUTDOWN),',0,%OP0'"
	    nLockOutStart = FALSE;
	    
	    [dvTP_Timer, BTN_START_UP] = nPwrOn;
		 [dvTP_Timer, BTN_SHUTDOWN] = !nPwrOn;
		
    }
}
DATA_EVENT [dvTP_Timer]
{
    ONLINE :
    {
	SEND_COMMAND dvTP_Timer, "'^BMF-',ITOA(TXT_SHUTDOWN),',0,%OP0'"
    }
}

