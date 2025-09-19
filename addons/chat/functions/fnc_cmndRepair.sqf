#include "\x\tmf\addons\chat\script_component.hpp"
/*
 * Name = TMF_chat_fnc_cmndHeal
 * Author = drofseh
 *
 * Syntaxes:
 * #repair            - Repairs all hitpoints on the vehicle
 * #repair all        - Repairs all hitpoints on the vehicle
 * #repair find       - Finds all damaged hitpoints and prints them as an ingame hint.
 * #repair <hitpoint> - Repairs the specified hitpoint.
 *
 * Return Value:
 * Void
 *
 * Description:
 * Repairs the player's vehicle or, if the player is not in a vehicle their cursorObject
 */

IS_CMND_AVAILABLE(GVAR(repairUsage),"#repair");

params [["_hitPoint", ""]];

private _vehicle = vehicle ace_player;

if (_vehicle == ace_player) then {
    _vehicle = cursorObject;
};

if (_hitPoint == "find") exitWith {
    private _allDamage = getAllHitPointsDamage _vehicle;
    private _hitpointsNames = _allDamage#0;
    private _damageValues = _allDamage#2;
    private _message = "";
    {
        if (_x > 0) then {
            _message = composeText [_message, lineBreak, str (_hitpointsNames select _forEachIndex)];
        };
    } forEach _damageValues;

    "Damaged Hitpoints" hintC [_message];

    /*
    private _message = [["Damaged Hitpoints"]];
    {
        if (_x > 0) then {
            _message pushBack [_hitpointsNames select _forEachIndex];
        };
    } forEach _damageValues;
    _message pushBack true;
    _message call CBA_fnc_notify;
    */
};

if (_hitPoint == "" || {_hitPoint == "all"}) then {
    [["All hitpoints repaired on"], [str _vehicle], true] call CBA_fnc_notify;
    [_vehicle,
        {
            params ["_vehicle"];
            private _allDamage = getAllHitPointsDamage _vehicle;
            private _hitpointsNames = _allDamage#0;
            private _damageValues = _allDamage#2;
            {
                if (_x > 0) then {
                    _vehicle setHitPointDamage [_hitpointsNames select _forEachIndex, 0, false];
                };
            } forEach _damageValues;
        }
    ] remoteExec ["call", _vehicle];
} else {
    if !(_hitPoint in getAllHitPointsDamage _vehicle) then {
        [
            ["Hitpoint " + _hitPoint + " does not match any hitpoints on the vehicle"],
            ["Use '#repair find' to display all damaged hitpoints"],
            true
        ] call CBA_fnc_notify;
    };
    [["Hitpoint " + _hitPoint + " repaired"], true] call CBA_fnc_notify;
    [_vehicle, [_hitPoint,0,false]] remoteExec ["setHitPointDamage", _vehicle];
};
