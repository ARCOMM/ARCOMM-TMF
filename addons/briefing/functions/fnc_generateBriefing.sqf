#include "\x\tmf\addons\briefing\script_component.hpp"
params [["_unit", player]];

//Check if player meets conditions and call script if so.

//We always assume gear is assigned at init and that this script is run post init.

if (GVAR(addLoadoutNotes)) then {
    [_unit] call FUNC(generateLoadoutPage);
};


// Create credits page here, so it ends up at the end.
[] call FUNC(createCreditsPage);

private _briefingArray = getMissionConfigValue ["TMF_Briefing","[]"];
if (_briefingArray isEqualTo "[]") exitWith {};
if (_briefingArray isEqualType "") then { _briefingArray = call compile _briefingArray;};

private _unitGroup = group _unit;

//Determine which languages we should speak
//Check Side/Faction conditions

private _indexesToTrigger = [];
{
    _x params ["","_conditions"];
    if ([_unit, _conditions] call EFUNC(common,evaluateCondArray)) then {
        _indexesToTrigger pushBack _forEachIndex;
    };
} forEach _briefingArray;

//Check group/unit conditions
private _groupCond = _unitGroup getVariable ["TMF_Briefinglist", []];
if (_groupCond isEqualType "") then { _groupCond = call compile _groupCond; };
private _unitCond = _unit getVariable ["TMF_Briefinglist", []];
if (_unitCond isEqualType "") then { _unitCond = call compile _unitCond; };

{
    _indexesToTrigger pushBackUnique _x;
} forEach (_groupCond + _unitCond);


//Process scripts.
{
    private _scriptName = (_briefingArray select _x) select 2;
    if FILE_EXISTS(_scriptName) then {
        call compile preprocessFileLineNumbers _scriptName;
    } else {
        [_scriptName] spawn {
            params ["_scriptName"];
            uiSleep 5;
            systemChat format["[TMF-Briefing] Missing file: %1 ", _scriptName];
        };
    };
} forEach _indexesToTrigger;

//Do Admin briefing.
if ([] call tmf_common_fnc_isAdmin) then {
    if FILE_EXISTS("briefing\admin.sqf") then {
        call compile preprocessFileLineNumbers "briefing\admin.sqf";
    } else {
        [] spawn {
            uiSleep 5;
            systemChat "[TMF-Briefing] Warning admin briefing not found. Expected: MISSION_ROOT\briefing\admin.sqf";
        };
    };
};
