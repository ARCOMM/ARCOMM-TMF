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
                _output pushBack [AUTOTEST_WARNING,format["Unit %1 has large init field contents (%2)",_object,_count]];
                _output pushBack [AUTOTEST_MULTILINE,"but no isServer or local check!"];
            };
        };
        // >= 150
        default {
            // check _VA
            if _VA then {
                if (_isServer || _isLocal) then {
                    _output pushBack [AUTOTEST_WARNING,format["Virtual Arsenal code detected in init field of %1!",_object]];
                } else {
                    _output pushBack [AUTOTEST_ERROR,format["Virtual Arsenal code detected in init field of %1",_object]];
                    _output pushBack [AUTOTEST_MULTILINE,"but no isServer or local check!"];
                };
            } else {
                // Check _isServer
                if (!_isServer && !_isLocal) then {
                    _output pushBack [AUTOTEST_WARNING,format["Unit %1 has very large init field contents (%2)",_object,_count]];
                    _output pushBack [AUTOTEST_MULTILINE,"but no isServer or local check!"];
                };
            };
        };
    };

    if (!_isServer && !_isLocal) then {
        {
            if ((_init find _x) >= 0) exitWith {
                _output pushBack [AUTOTEST_ERROR,format["Unit %1 has GLOBAL command, %2, in init field",_object,_x]];
                _output pushBack [AUTOTEST_MULTILINE,"but no isServer or local check!"];
            };
        } forEach GLOBAL_COMMANDS
    };
} forEach (all3DENEntities select 0);

_output pushBack [AUTOTEST_PASS,format["Init box checks complete, %1 issues detected",count _output]];

_output
