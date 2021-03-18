["ace_unconscious", 
    {
		params ["_unit", "_state"];
        _unit = (_this select 0);
        _state = (_this select 1);
	
        if (_state == true && isPlayer _unit) then
		{
			if (!(_unit getVariable ["ACE_isUnconscious",false])) exitWith { systemChat "failsafe exit"}; // failsafe
		  	//_timeFuture = serverTime + 5;
		 	//waitUntil {serverTime >= _timeFuture};
			sleep 3;
			[true, true, false] call ace_spectator_fnc_setSpectator;
			[false] call ace_common_fnc_disableUserInput;
			[false, 1] call ace_medical_feedback_fnc_effectUnconscious;
			[[], [east,independent,civilian]] call ace_spectator_fnc_updateSides;
			[[player], [allplayers]] call ace_spectator_fnc_updateUnits;
			[[1,2], [0]] call ace_spectator_fnc_updateCameraModes; //Allowed[1=First, 2=Third],Not Allowed[0=Free]
			[[-1,-2], [0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes //Allowed[-1=Normal, -2=Night],Not Allowed[thermal]
			
        } else
		{
	
			[false] call ace_spectator_fnc_setSpectator;
			systemChat "normal exit"
			
		};
    }
] call CBA_fnc_addEventHandler;