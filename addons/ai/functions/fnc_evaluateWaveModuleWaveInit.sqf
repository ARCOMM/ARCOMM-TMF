#include "\x\tmf\addons\ai\script_component.hpp"
/*
 * Name = TMF_ai_fnc_evaluateWaveModule
 * Author =
 *
 * Parameters:
 * 0: Wave init code <STRING>
 *
 * Return:
 * None
 *
 * Description:
 * Evaluates the wave init code of the TMF Wavespawner module
 */

params ["_value"];

if (_value != '' && _value != 'params ["_wave", "_spawnedGroups", "_spawnedUnits", "_spawnedVehicles", "_spawnedObjects", "_logic", "_wavehandlerID"];') then {
    [_this, compile _value, True] call TMF_ai_fnc_addWaveHandler;
};
