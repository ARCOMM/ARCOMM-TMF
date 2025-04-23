#include "\x\tmf\addons\autotest\script_component.hpp"

private _value = getMissionConfigValue "overviewText";

if (
    isNil "_value"
    || {!(_value isEqualType "")}
    || {_value == "*** Insert mission description here. ***"}
    || {_value == "Scenario" get3DENMissionAttribute "OverviewText"}
    || {_value == ""}
) then {
    _value = "Multiplayer" get3DENMissionAttribute "IntelOverviewText";
};

(_this controlsGroupCtrl 100) ctrlSetText _value;

if (_value == "" || {_value == "*** Insert mission description here. ***"}) then {
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\plus_small_ca.paa);
} else {
    if !("slot" in (toLower _value)) then {
        (_this controlsGroupCtrl 101) ctrlSetText QPATHTOF(UI\warning.paa);
    } else {
        (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\check_small_ca.paa);
    };
};
