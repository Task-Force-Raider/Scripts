/*
		fn_Purgatory.sqf
		Vers: Not working (maybe) :rofl:
		params: [Unit, State]

		Called from Event
		Preprocessed in description.ext

		_fn_purg = preprocessFileLineNumbers "fn/fn_Purgatory.sqf";
*/
private ['_SideF', '_unit', '_state'];
params ["_unit", "_state"];

_unit = (_this select 0);
_state = (_this select 1);
_sideF = side group _unit; 															//get side to allow spectating of

if (_state == true && isPlayer _unit) then
	{
	if (!(_unit getVariable ["ACE_isUnconscious",false])) exitWith 					//just incase lets check again
		{ 
			systemChat "failsafe exit";
		}; 
	//_timeFuture = serverTime + 5;
	//waitUntil {serverTime >= _timeFuture}; 										//shouldnt need this? this should be scheduled
	sleep 3; //please work 
	[true, true, false] call ace_spectator_fnc_setSpectator;
	[[],[west,east,independent,civilian]] call ace_spectator_fnc_updateSides; 		//hides all sides - explained below
	sleep 0.3;
	[[_sideF],[]] call ace_spectator_fnc_updateSides; 								//why you ask? pvp pre-empting, only allow spectating of player side
	[false] call ace_common_fnc_disableUserInput;									//Re-enable Userinput
	[false, 1] call ace_medical_feedback_fnc_effectUnconscious;						//Hopefully disables unco effect
	[[allplayers], [_unit]] call ace_spectator_fnc_updateUnits; 					//this was backwards? 
	[[1,2], [0]] call ace_spectator_fnc_updateCameraModes; 							//Allowed[1=First, 2=Third],Not Allowed[0=Free]
	[[-1,-2], [0,1,2,3,4,5,6,7]] call ace_spectator_fnc_updateVisionModes 			//Allowed[-1=Normal, -2=Night],Not Allowed[thermal]
    } else
		{
	
			[false] call ace_spectator_fnc_setSpectator;
			systemChat "normal exit"
			
		};