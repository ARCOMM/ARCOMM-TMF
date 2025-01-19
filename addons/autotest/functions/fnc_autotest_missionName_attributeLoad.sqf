#include "\x\tmf\addons\autotest\script_component.hpp"

private _value = "Scenario" get3DENMissionAttribute "IntelBriefingName";

(_this controlsGroupCtrl 100) ctrlSetText _value;

if (_value == "") then {
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\plus_small_ca.paa);
} else {
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\check_small_ca.paa);
};