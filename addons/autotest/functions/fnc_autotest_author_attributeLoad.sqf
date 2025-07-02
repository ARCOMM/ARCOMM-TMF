#include "\x\tmf\addons\autotest\script_component.hpp"

private _value = getMissionConfigValue "author";

if (isNil "_value" || {!(_value isEqualType "")}) then {
    _value = "Scenario" get3DENMissionAttribute "Author";
};

(_this controlsGroupCtrl 100) ctrlSetText _value;

if (((toLower _value) find (toLower profileName)) == -1) then {
    if (_value == "") then {
        (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\plus_small_ca.paa);
    };
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(autotest,UI\warning.paa);
} else {
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\check_small_ca.paa);
};
