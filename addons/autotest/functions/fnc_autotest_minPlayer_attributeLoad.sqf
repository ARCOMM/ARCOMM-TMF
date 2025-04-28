#include "\x\tmf\addons\autotest\script_component.hpp"

private _value = "Multiplayer" get3DENMissionAttribute "minplayers";
private _playerCount = (playableUnits + switchableUnits + [player]) - [objNull];
_playerCount = count (_playerCount arrayIntersect _playerCount);

(_this controlsGroupCtrl 100) ctrlSetText (str _value);

if (_value > 0 && {_value <= _playerCount}) then {
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\check_small_ca.paa);
} else {
    (_this controlsGroupCtrl 101) ctrlSetText QPATHTOEF(briefing,UI\plus_small_ca.paa);
};
