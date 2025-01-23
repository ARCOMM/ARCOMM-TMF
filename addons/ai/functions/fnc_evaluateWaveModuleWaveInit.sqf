#include "\x\tmf\addons\ai\script_component.hpp"
/*
 * Name = TMF_ai_fnc_evaluateWaveModuleWaveInit
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

params ["_logic", "_value"];

if (_value != '' && _value != 'params ["_wave", "_spawnedGroups", "_spawnedUnits", "_spawnedVehicles", "_spawnedObjects", "_logic", "_wavehandlerID"];') then {
    [_logic, compile _value, true] call TMF_ai_fnc_addWaveHandler;
};
