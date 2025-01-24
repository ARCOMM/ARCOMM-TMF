#include "\x\tmf\addons\autotest\script_component.hpp"

private _value = "Multiplayer" get3DENMissionAttribute "IntelOverviewText";

if (_value == "") then {
    _value = getMissionConfigValue "overviewText";
};

(_this controlsGroupCtrl 100) ctrlSetText _value;

if (_value == "" || {_value == "*** Insert mission description here. ***"}) then {
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\plus_small_ca.paa);
} else {
    if !("slot" in _value) then {
        (_this controlsGroupCtrl 101) ctrlSetText QPATHTOF(UI\warning.paa);
    } else {
        (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\check_small_ca.paa);
    };
};