#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_assignGear
 * Author = Nick, Freddo
 *
 * Arguments:
 * 0: Object. Unit to assign loadout to
 * 1: String (optional). Which faction to use. Defaults to current unit faction
 * 2: String (optional). Which role to use. Defaults to current unit loadout
 *
 * Return:
 * None
 *
 * Description:
 * Assigns a loadout defined in CfgLoadouts to a unit.
 */

params [["_unit", player]];

if !(local _unit) exitWith {};

_this params [
    "",
    ["_faction", _unit getVariable [QGVAR(faction), toLower faction _unit]],
    ["_role", _unit getVariable [QGVAR(role), "r"]]
];

// Sometimes in editor this function is run before preInit, this should make sure that the namespace exists
private _namespace = missionNamespace getVariable QGVAR(namespace);
ISNILS(_namespace,[FUNC(initNamespace)] call CBA_fnc_directCall);
private _loadout = format ["loadout_%1_%2", _faction, _role];

// Check if loadout if cached, if not then cache it
private _loadoutArray = _namespace getVariable _loadout;
ISNILS(_loadoutArray,[ARR_2(_faction,_role)] call FUNC(cacheAssignGear));

_unit setUnitLoadout (configFile >> 'EmptyLoadout');

// Each index is tied to a specific type of item
{
    if (!isNil "_x" && {_x isNotEqualTo []} && {_x isNotEqualTo ""}) then {
        switch _forEachIndex do {
            case 0: {}; // displayName
            case 1: { // uniform
                private _uniform = selectRandom _x;
                if (_uniform != "") then {
                    _unit forceAddUniform _uniform;
                };
            };
            case 2: { // vest
                private _vest = selectRandom _x;
                if (_vest != "") then {
                    _unit addVest _vest;
                };
            };
            case 3: { // backpack
                private _backpack = selectRandom _x;
                if (_backpack != "") then {
                    _unit addBackpack _backpack;
                };
            };
            case 4: { // headgear
                private _headgear = selectRandom _x;
                if (_headgear != "") then {
                    _unit addHeadgear _headgear;
                };
            };
            case 5: { // goggles
                [_unit, _x] call FUNC(setGoggles);
            };
            case 6: { // hmd
                private _hmd = selectRandom _x;
                if (_hmd != "") then {_unit linkItem _hmd};
            };
            case 7: { // faces
                [_unit, _x] call FUNC(setFace);
            };
            case 8: { // insignias
                [_unit, selectRandom _x] call FUNC(setInsignia);
            };
            case 9: { // backpackItems
                {_unit addItemToBackpack _x} forEach _x;
                /*
                {
                    switch true do { // try to fill backpack first
                        case ([_unit, _x, 1, false, false, true] call CBA_fnc_canAddItem): {_unit addItemToBackpack _x};
                        case ([_unit, _x, 1, false, true, false] call CBA_fnc_canAddItem): {_unit addItemToVest _x};
                        default {_unit addItemToUniform _x};
                    };
                } forEach _x;
                */
            };
            case 10: { // items
                {
                    switch true do { // try to fill uniform first
                        case ([_unit, _x, 1, true, false, false] call CBA_fnc_canAddItem): {_unit addItemToUniform _x};
                        case ([_unit, _x, 1, false, true, false] call CBA_fnc_canAddItem): {_unit addItemToVest _x};
                        default {_unit addItemToBackpack _x};
                    };
                } forEach _x;
            };
            case 11: { // primarymagazines
                private _count = count _x;
                private _mags = _x;
                if (_count > 0 && {_x select 0 isEqualType []}) then {
                    private _index = _x select (round random (_count - 1);
                    _unit setVariable ["TMF_assignGear_randomPrimaryIndex", _index];
                    _mags = _x select _index;
                };
                {
                    switch true do { // try to fill vest first
                        case ([_unit, _x, 1, false, true, false] call CBA_fnc_canAddItem): {_unit addItemToVest _x};
                        case ([_unit, _x, 1, true, false, false] call CBA_fnc_canAddItem): {_unit addItemToUniform _x};
                        default {_unit addItemToBackpack _x};
                    };
                } forEach _mags;
            };
            case 12: { // secondarymagazines
                private _count = count _x;
                private _mags = _x;
                if (_count > 0 && {_x select 0 isEqualType []}) then {
                    private _index = _x select (round random (_count - 1);
                    _unit setVariable ["TMF_assignGear_randomSecondaryIndex", _index];
                    _mags = _x select _index;
                };
                {
                    switch true do { // try to fill backpack first
                        case ([_unit, _x, 1, false, false, true] call CBA_fnc_canAddItem): {_unit addItemToBackpack _x};
                        case ([_unit, _x, 1, false, true, false] call CBA_fnc_canAddItem): {_unit addItemToVest _x};
                        default {_unit addItemToUniform _x};
                    };
                } forEach _mags;
            };
            case 13: { // sidearmmagazines
                private _count = count _x;
                private _mags = _x;
                if (_count > 0 && {_x select 0 isEqualType []}) then {
                    private _index = _x select (round random (_count - 1);
                    _unit setVariable ["TMF_assignGear_randomSidearmIndex", _index];
                    _mags = _x select _index;
                };
                {
                    switch true do { // try to fill vest first
                        case ([_unit, _x, 1, false, true, false] call CBA_fnc_canAddItem): {_unit addItemToVest _x};
                        case ([_unit, _x, 1, true, false, false] call CBA_fnc_canAddItem): {_unit addItemToUniform _x};
                        default {_unit addItemToBackpack _x};
                    };
                } forEach _mags;
            };
            case 14: { // magazines
                {
                    switch true do { // try to fill vest first
                        case ([_unit, _x, 1, false, true, false] call CBA_fnc_canAddItem): {_unit addItemToVest _x};
                        case ([_unit, _x, 1, true, false, false] call CBA_fnc_canAddItem): {_unit addItemToUniform _x};
                        default {_unit addItemToBackpack _x};
                    };
                } forEach _x;
            };
            case 15: { // linkedItems
                {_unit addWeapon _x} forEach _x;
            };
            case 16: { // primaryWeapon
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomPrimaryIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    private _weapon = _x select _selectionIndex;
                } else {
                    private _weapon = selectRandom _x;
                    if (_weapon isEqualType "" && {_weapon != ""}) then {_unit addWeapon _weapon};
                };
            };
            case 17: { // scope
                private _scope = "";
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomPrimaryIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    _scope = selectRandom (_x select _selectionIndex);
                } else {
                    _scope = selectRandom _x;
                };
                if (_scope isEqualType "" && {_scope != ""}) then {_unit addPrimaryWeaponItem _scope};
            };
            case 18: { // bipod
                private _bipod = "";
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomPrimaryIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    _bipod = selectRandom (_x select _selectionIndex);
                } else {
                    _bipod = selectRandom _x;
                };
                if (_bipod isEqualType "" && {_bipod != ""}) then {_unit addPrimaryWeaponItem _bipod};
            };
            case 19: { // attachment
                private _attachment = "";
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomPrimaryIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    _attachment = selectRandom (_x select _selectionIndex);
                } else {
                    _attachment = selectRandom _x;
                };
                if (_attachment isEqualType "" && {_attachment != ""}) then {_unit addPrimaryWeaponItem _attachment};
            };
            case 20: { // silencer
                private _silencer = "";
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomPrimaryIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    _silencer = selectRandom (_x select _selectionIndex);
                } else {
                    _silencer = selectRandom _x;
                };
                if (_silencer isEqualType "" && {_silencer != ""}) then {_unit addPrimaryWeaponItem _silencer};
            };
            case 21: { // secondaryWeapon
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomSecondaryIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    private _weapon = _x select _selectionIndex;
                } else {
                    private _weapon = selectRandom _x;
                    if (_weapon isEqualType "" && {_weapon != ""}) then {_unit addWeapon _weapon};
                };
            };
            case 22: { // secondaryAttachments
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomSecondaryIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    {_unit addSecondaryWeaponItem _x} forEach (_x select _selectionIndex);
                } else {
                    {_unit addSecondaryWeaponItem _x} forEach _x;
                };
            };
            case 23: { // sidearmweapon
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomSidearmIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    private _weapon = _x select _selectionIndex;
                } else {
                    private _weapon = selectRandom _x;
                    if (_weapon isEqualType "" && {_weapon != ""}) then {_unit addWeapon _weapon};
                };
            };
            case 24: { // sidearmattachments
                private _selectionIndex = _unit getVariable ["TMF_assignGear_randomSidearmIndex", -1];
                if (_selectionIndex > -1 && {_selectionIndex < count _x} && {_x select _selectionIndex isEqualType []}) then {
                    {_unit addHandgunItem _x} forEach (_x select _selectionIndex);
                } else {
                    {_unit addHandgunItem _x} forEach _x;
                };
            };
            case 25: { // Unit traits
                {
                    [_unit, _x] call FUNC(setUnitTrait);
                } forEach _x;
            };
            case 26: { // code
                _unit call compile _x;
            };
        };
    };
} forEach _loadoutArray;

_unit setVariable [QGVAR(faction), _faction,true];
_unit setVariable [QGVAR(role), _role,true];

LOG_3("Assigned loadout to unit",_unit,_faction,_loadout);

[QGVAR(done),[_unit,_faction,_role]] call CBA_fnc_localEvent;
_unit setVariable [QGVAR(done),true,true];
