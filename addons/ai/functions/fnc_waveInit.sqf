/*
 * Name: TMF_ai_fnc_waveInit
 * Author: Head, Snippers
 *
 * Arguments:
 * 0: TMF WaveSpawner logic
 * 1: _units
 * 2: _activated
 *
 * Return:
 * N/A
 *
 * Description:
 * Handles creation of wavespawner structure
 */
if(is3DEN) exitWith {};
#include "\x\tmf\addons\AI\script_component.hpp"
params ["_logic","_units","_activated"];

_headless = (synchronizedObjects _logic) select {!local _x && {_x isKindOf "HeadlessClient_F"}};

if(isServer && {count _headless > 0}) exitWith {
    _this remoteExec [QFUNC(waveInit), _headless select 0];
};

// check if we have done the setup.
if(!(_logic getVariable [QGVAR(init),false])) then {

    // Legacy support
    private _whenDead = _logic getVariable ["WhenDead",0];
    if (_whenDead isEqualType false) then {
        _logic setVariable ["WhenDead", parseNumber _whenDead, true];
    };

    private _waves = _logic getVariable ["Waves", 1];
    if (_waves isEqualType "") then {
        _waves = parseNumber _waves;
        _logic setVariable ["Waves", _waves, true];
    };

    private _synchronizedGroups = [];
    private _objects = synchronizedObjects _logic;
    {
        _x = getMissionLayerEntities _x;
        _x params [["_layerObjects",[]]];

        _objects append _layerObjects;
    } forEach parseSimpleArray ("[" + (_logic getVariable ["Layers",""]) + "]");
    {
        if(_x isEqualType grpNull && {side _x in [blufor,opfor,independent,civilian]}) then {
            _synchronizedGroups pushBack _x;
        };
        if(_x isEqualType objNull && {side _x in [blufor,opfor,independent,civilian]}) then {
           if(_x isKindOf 'Man') then {
               _synchronizedGroups pushBack (group _x);
           } else {
               {
                _synchronizedGroups pushBack (group _x);
               } forEach crew _x;
           };
        };
    } forEach _objects;
    _synchronizedGroups = _synchronizedGroups arrayIntersect _synchronizedGroups;

    private _allUnits = [];
    {_allUnits append (units _x)} forEach _synchronizedGroups;
    private _vehicles = (_allUnits) apply {objectParent _x} select {!isNull _x};
    _vehicles = _vehicles arrayIntersect _vehicles;
    private _groups = [];

    {
        private _grp = _x;
        private _units = (units _grp) apply {
            private _unit = _x;
            private _data = [
                typeOf _unit,
                getPosATL _unit,
                [vectorDir _x,vectorUp _x],
                getUnitLoadout _unit,
                -1,
                [],
                getDir _unit
            ];
            if(!isNull objectParent _x) then {
                _data set [4, _vehicles find (objectParent _x)];
                _data set [5, assignedVehicleRole _x]
            };
            _data
        };
        _groups pushBack [side _x, _units, [_x] call CFUNC(serializeWaypoints)];
    } forEach _synchronizedGroups;

    _objects = (_objects - _vehicles) - _allUnits;
    _objects = _objects select {side _x in [blufor,opfor,independent,civilian,sideUnknown] && {!(_x isKindOf "EmptyDetector")}};
    private _cachedObjects = _objects apply {[
        typeOf _x,
        if (isSimpleObject _x) then [{getPosWorld _x},{getPosATL _x}],
        getDir _x,
        [vectorDir _x,vectorUp _x],
        isSimpleObject _x,
        simulationEnabled _x
    ]};

    // store vehicle data
    _vehicles = _vehicles apply {[typeOf _x,getPosATL _x,[vectorDir _x,vectorUp _x],[_x] call BIS_fnc_getVehicleCustomization, getPylonMagazines _x, getDir _x]};

    _logic setVariable [QGVAR(waveData), [_groups, _vehicles, _cachedObjects]];

    // Clean up the template units.
    {
        _units = units _x; //TODO come back to this, _unit var in not private here, but it's also in params at the start of the function, is it getting reused below in the admin map?
        {
            if(!isNull objectParent _x) then {_units pushBackUnique vehicle _x};
            deleteVehicle _x;
        } forEach _units;
    } forEach _synchronizedGroups;
    {
        deleteVehicle _x;
    } forEach _objects;

    // Generate Admin Map data (Lite version of data for broadcast)
    // Array of [typeOf, pos, direction]
    private _adminData = _vehicles apply {[_x select 0, _x select 1, _x select 6]};
    {
        _x params ["", "_units"];
        _adminData append (_units apply {[_x select 0, _x select 1, _x select 6]});
    } forEach _groups;
    _logic setVariable [QGVAR(waveAdminData), _adminData, true];

    _logic setVariable [QGVAR(init), true, true];
};


if(_activated) then {
    private _delay = _logic getVariable ["Delay",0];
    [FUNC(spawnWave),[_logic],_delay] call CBA_fnc_waitAndExecute;
};
