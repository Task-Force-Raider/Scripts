/*
File: fn_ConvoyMedevac.sqf
Author:

	BroBeans
	

Description:

	Spawn convoy with patient for aircrew to rescue
__________________________________________________*/

private ['_randomPos', '_blackListedAreas','_debug','_roadLoc', '_roadConnectedTo', '_RoadDir', '_connectedRoad', '_POIonRoad', '_BB_ArmedVehicles','_veh2_safePos'];

_blackListedAreas = [];
_debug = true;
_roads = false;
_POIonRoad = false;
_BB_ArmedVehicles = [
	"B_MRAP_01_hmg_F",
	"B_LSV_01_AT_F",
	"B_LSV_01_armed_F"
];

_findLoc = while {!(_POIonRoad)} do {
	_randomPos = [nil, _blackListedAreas] call BIS_fnc_randomPos;

	_roadLoc = [_randomPos, 500] call BIS_fnc_nearestRoad;
	sleep 2;
	if (isOnRoad _roadLoc) exitWith {
		_POIonRoad = true;
		hint "exited";
	};
};


_roadConnectedTo = roadsConnectedTo _roadLoc;
_connectedRoad = _roadConnectedTo select 0;
_RoadDir = [_roadLoc,_connectedRoad] call BIS_fnc_dirTo;
_vehType = selectRandom _BB_ArmedVehicles;
_veh1 = createVehicle [_vehType,_roadLoc,[],0,'NONE'];
_veh1 setDir _RoadDir;
_POI_safePos = getPosATL _veh1;
_veh1 lock 2;
_veh1 setfuel 0;

_vehType = selectRandom _BB_ArmedVehicles;
_veh2_safePos = (_veh1 modelToWorld [0,30,0]) findEmptyPosition [0,5,_VehType];
if (!(isOnRoad _veh2_safePos)) then {
		_onRoadPos = [_veh2_safePos,0,50,5,0,0.1,0] call BIS_fnc_findSafePos;
		if (isOnRoad _onRoadPos) exitWith {
			_veh2_safePos = _onRoadPos;
		};
};
_veh2 = createVehicle [_vehType,_veh2_safePos,[],0,'NONE'];

// Debug Marker
if (_debug) then {
	_dbMarker = createMarker ["Debug Marker", _roadLoc];
	_dbMarker setMarkerType "hd_dot";
	hint format ["RandomPos: %1 onRoad: %2, RoadDir: %3", _randomPos, _POIonRoad, _RoadDir];
};