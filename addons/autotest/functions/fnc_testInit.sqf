#include "\x\tmf\addons\autotest\script_component.hpp"
/*
 * Name = TMF_autotest_fnc_testInit
 * Author = Nick
 *
 * Arguments:
 * None.
 *
 * Return:
 * 0: ARRAY. Array with nested arrays of warning messages.
 *
 * Description:
 * Check the init attribute for all placed units and
 * raises a warning if it contains a lot of code,
 * VA code or doesn't contain isServer.
 */
private _output = [];

{
    private _object = _x;
    private _init = toLower ((_object get3DENAttribute 'Init') param [0,""]);
    private _count = count _init;
    private _VA = (_init find "exported from arsenal") >= 0;
    private _isServer = (_init find "isserver") >= 0;
    private _isLocal = (_init find "local") >= 0;
    switch (true) do {
        case (_count < 50): {/* Nothing*/};
        case (_count < 150): {
            // check _isServer
            if (!_isServer && !_isLocal) then {
                _output pushBack [AUTOTEST_WARNING,format["Unit %1 (%2)",_object,(configFile >> "CfgVehicles">> typeOf _object) call BIS_fnc_displayName]];
                _output pushBack [AUTOTEST_MULTILINE,format["has large init field contents (%1) but no isServer or local check!",_count]];
            };
        };
        // >= 150
        default {
            // check _VA
            if _VA then {
                if (_isServer || _isLocal) then {
                    _output pushBack [AUTOTEST_WARNING,format["Unit %1 (%2) Virtual Arsenal code detected in init field",_object,(configFile >> "CfgVehicles">> typeOf _object) call BIS_fnc_displayName]];
                } else {
                    _output pushBack [AUTOTEST_ERROR,format["Unit %1 (%2)",_object,(configFile >> "CfgVehicles">> typeOf _object) call BIS_fnc_displayName]];
                    _output pushBack [AUTOTEST_MULTILINE,"Virtual Arsenal code detected in init field but no isServer or local check!"];
                };
            } else {
                // Check _isServer
                if (!_isServer && !_isLocal) then {
                    _output pushBack [AUTOTEST_WARNING,format["Unit %1 (%2)",_object,(configFile >> "CfgVehicles">> typeOf _object) call BIS_fnc_displayName]];
                    _output pushBack [AUTOTEST_MULTILINE,format["has very large init field contents (%1) but no isServer or local check!",_count]];
                };
            };
        };
    };

    if (!_isServer && !_isLocal) then {
        {
            if ((_init find _x) >= 0) exitWith {
                _output pushBack [AUTOTEST_ERROR,format["Unit %1 (%2)",_object,(configFile >> "CfgVehicles">> typeOf _object) call BIS_fnc_displayName]];
                _output pushBack [AUTOTEST_MULTILINE,format["has GLOBAL command, %1 in init field but no isServer or local check!",_x]];
            };
        } forEach GLOBAL_COMMANDS
    };
} forEach (all3DENEntities select 0);

_output pushBack [AUTOTEST_PASS,format["Init box checks complete, %1 issues detected",count _output]];

_output
