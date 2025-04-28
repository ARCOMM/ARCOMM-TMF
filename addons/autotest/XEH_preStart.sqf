#include "script_component.hpp"

#include "XEH_PREP.inc.sqf"

// Store DLC hash
private _dlcClasses = "isNumber (_x >> 'appID')" configClasses (configFile >> "CfgMods");

private _dlcHash = _dlcClasses apply {[getNumber (_x >> "appID"), getText (_x >> "nameShort")]};

uiNamespace setVariable [QGVAR(dlcHash), createHashMapFromArray _dlcHash];
