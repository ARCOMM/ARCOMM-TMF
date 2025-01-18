#include "\x\tmf\addons\adminmenu\script_component.hpp"
/*
 * Name = TMF_adminmenu_fnc_checkAdminDebriefingLogPresent
 * Author =
 *
 * Parameters:
 * None
 *
 * Return:
 * 0: Nested Return values <ARRAY>
 * - 0: Nested return values <ARRAY>
 *  - 0: 1 for not present, -1 for present <NUMBER>
 *  - 1: Message <STRING>
 *
 * Description:
 * Checks if CfgDebriefingSections has the TMF Admin Log
 */

[
    [
        [1, "Admin log debriefing section not present"]
    ],
    [
        [-1, "Admin log debriefing section present"]
    ]
] select (isClass (missionConfigFile >> "CfgDebriefingSections" >> "DOUBLES(PREFIX,adminlog)"));
