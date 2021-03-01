/*
File: fn_findRoadPos.sqf
Author:

	BroBeans
	

Description:

	Testing
__________________________________________________*/

private ['_randomPos', '_blackListedAreas','_debug','_roadLoc', '_connectedRoad'];

_blackListedAreas = [];
_debug = true;
_roads = false;

for '_i' from 0 to 1 do {
	_randomPos = [nil, _blackListedAreas] call BIS_fnc_randomPos;

	_roadLoc = [_randomPos, 500] call BIS_fnc_nearestRoad;

	hint format ["%1", _roadLoc];
	_roadConnectedTo = roadsConnectedTo _roadLoc;
	_connectedRoad = _roadConnectedTo select 0;
	_RoadDir = [_roadLoc,_connectedRoad] call BIS_fnc_dirTo;
	if (isOnRoad _roadLoc) exitWith {};
};
hint "exited";
_vehType = selectRandom BB_ArmedVehicles;
_veh1 = createVehicle [_veh1Type,_roadLoc,[],0,'NONE'];
_veh1 setDir _BB_connectedRoadDir;
_POI_safePos = getPosATL _veh1;
_veh1 lock 2;
_veh1 setfuel 0;

_vehType selectRandom BB_UnarmedVehicles;
_veh2_safePos = (_veh1 modelToWorld [0,30,0]) findEmptyPosition [0,5,_VehType];
if (!(isOnRoad _veh2_safePos)) then {
		_onRoadPos = [_veh2_safePos,0,50,5,0,0.1,0] call BIS_fnc_findSafePos;
		if (isOnRoad _onRoadPos) exitWith {
			_veh2_safePos = _onRoadPos;
		};
	};
};
_veh2 = createVehicle [_vehType,_veh2_safePos,[],0,'NONE'];*/

// Debug Marker
if (_debug) then {
	_dbMarker = createMarker ["Debug Marker", _roadLoc];
	_dbMarker setMarkerType "hd_dot";
};