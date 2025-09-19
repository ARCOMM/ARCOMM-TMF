#include "\x\tmf\addons\chat\script_component.hpp"
/*
 * Name = TMF_chat_fnc_cmndHeal
 * Author = drofseh
 *
 * Syntaxes:
 * #refuel
 *
 * Return Value:
 * Void
 *
 * Description:
 * Refuels the player's vehicle or, if the player is not in a vehicle, their cursorObject.
 */

IS_CMND_AVAILABLE(GVAR(refuelUsage),"#refuel");

private _vehicle = vehicle ace_player;
if (_vehicle != ace_player) then {
    [_vehicle, 1] remoteExec ["setFuel", _vehicle];
} else {
    [cursorObject, 1] remoteExec ["setFuel", cursorObject];
};
