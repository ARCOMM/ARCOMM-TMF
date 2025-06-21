#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_gui_vehicleGear_getLoad
 * Author = drofseh
 *
 * Arguments:
 * 1. Control
 *
 * Return:
 * Data to store
 *
 * Description:
 * Internal Use Only
 */
params ["_ctrl"];
//private _display = ctrlParent _control;
private _object = get3DENSelected "object" select 0;
private _load = loadAbs _object;
private _gear = _object getVariable [QGVAR(gear), createHashMap];

                                                                                                diag_log ["_this", _this];
                                                                                                diag_log ["_object", _object];
                                                                                                diag_log ["_load", _load];
                                                                                                diag_log ["_gear", _gear];
                                                                                                diag_log ["_gear is array?", _gear isEqualType []];
                                                                                                diag_log ["_gear is hashmap?", _gear isEqualType createHashMap];

if (count _gear > 0) then {
                                                                                                diag_log ["_gear", _gear];
    {
    
        private _item = _x;
        private _count = _y;
                                                                                                diag_log ["_x, _y", [_x, _y]];
                                                                                                diag_log ["_item, _count", [_item, _count]];
        private _config = _item call CBA_fnc_getItemConfig;
                                                                                                diag_log ["_config", _config];
        if (isNull _config) then {continue};
        private _weight = getNumber (_config >> "mass");
                                                                                                diag_log ["_weight from mass", _weight];
        if (_weight == 0) then {
            _weight = getNumber (_config >> "ItemInfo" >> "mass");
                                                                                                diag_log ["_weight from ItemInfo >> mass", _weight];
        };
        if (_weight == 0) then {
            _weight = getNumber (_config >> "WeaponSlotsInfo" >> "mass");
                                                                                                diag_log ["_weight from WeaponSlotsInfo >> mass", _weight];
        };
                                                                                                diag_log ["_weight final", _weight];
        _load = _load + _weight * _count;
                                                                                                diag_log ["_load", _load];
    } forEach _gear;
};

                                                                                                diag_log ["total _load", _load];

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

