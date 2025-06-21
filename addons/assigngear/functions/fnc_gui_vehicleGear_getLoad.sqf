#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_gui_vehicleGear_getLoad
 * Author = drofseh
 *
 * Arguments:
 * 0: Control
 *
 * Return:
 * Nothing
 *
 * Description:
 * Internal Use Only
 */
params ["_ctrl"];
private _object = get3DENSelected "object" select 0;
private _load = loadAbs _object;
private _gear = _object getVariable [QGVAR(gear), createHashMap];

if (count _gear > 0) then {
    {
    
        private _item = _x;
        private _count = _y;
        private _config = _item call CBA_fnc_getItemConfig;
        if (isNull _config) then {continue};
        private _weight = getNumber (_config >> "mass");
        if (_weight == 0) then {
            _weight = getNumber (_config >> "ItemInfo" >> "mass");
        };
        if (_weight == 0) then {
            _weight = getNumber (_config >> "WeaponSlotsInfo" >> "mass");
        };
        _load = _load + _weight * _count;
    } forEach _gear;
};

private _maxLoad = maxLoad _object;
if (_load > _maxLoad) then {
    _ctrl ctrlSetTextColor [1, 0, 0, 1];
} else {
    _ctrl ctrlSetTextColor [1, 1, 1, 1];
};

_load = _load / 10;
_maxLoad = _maxLoad / 10;

private _totalLoadLbs = _load toFixed 2;
private _maxLoadLbs = _maxLoad toFixed 2;
private _totalLoadKG = _load * 0.45359237 toFixed 2;
private _maxLoadKG = _maxLoad * 0.45359237 toFixed 2;

_ctrl ctrlSetText (format ["%1 / %2 lbs | %3 / %4 kg", _totalLoadLbs, _maxLoadLbs, _totalLoadKG, _maxLoadKG]);

