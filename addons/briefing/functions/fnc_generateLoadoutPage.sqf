#include "\x\tmf\addons\briefing\script_component.hpp"
/*
 *        Name: TMF_briefing_fnc_generateLoadoutPage
 *        Author: Nick, Snippers
 *
 *        Arguments:
 *            0: _unit (Default: player)
 *
 *        Return:
 *            None
 *
 *        Description:
 *            Add the Loadout entry to the diary
 */

if !(GVAR(addLoadoutNotes) || hasInterface) exitWith {};

params [["_unit", player]];

// Create the subject.
_unit createDiarySubject ["loadout","Equipment"];
private _units = (units (group _unit));
reverse _units; // Briefings get added in reverse order
private _vehicles = (_units select {!isNull objectParent _x}) apply {vehicle _x}; // Proud
_vehicles = _vehicles arrayIntersect _vehicles;

[_unit,_vehicles] call FUNC(vehiclePage);
[_unit,_units] call FUNC(unitPage);
