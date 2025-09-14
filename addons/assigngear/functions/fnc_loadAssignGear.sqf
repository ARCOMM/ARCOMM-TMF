#include "\x\tmf\addons\assignGear\script_component.hpp"
/*
 * Name = TMF_assignGear_fnc_loadAssignGear
 * Author = Freddo
 *
 * Arguments:
 * 0: String. CfgLoadouts faction
 * 1: String. CfgLoadouts role
 * 2: configFile (optional). configFile to check, can be either missionConfigFile or configFile
 *
 * Return:
 * Array. Loadout array
 *
 * Description:
 * Loads assigngear from config
 */
#define CFGROLE (_cfg >> "CfgLoadouts" >> _faction >> _role)
#define CFGPARSE (configFile >> "CfgLoadoutsParser")

params [
    "_faction",
    "_role",
    "_cfg"
];

if (isNil "_cfg") then {
    // Check if loadout is in configFile or missionConfigFile
    _cfg = if (isClass (missionConfigFile >> "CfgLoadouts" >> _faction >> _role)) then
    [
        {missionConfigFile},
        {configFile}
    ];
};

ASSERT_TRUE(isClass CFGROLE,format [ARR_3("Loadout not present: %1 %2",_faction,_role)]);

private _loadout = format ["loadout_%1_%2", _faction, _role];
private _loadoutArray = [];

// Create an array where each index is tied to a specific type of item
#define CASE(_type,_index) case _type: {_loadoutArray set [_index, _x call BIS_fnc_getCfgData]}
; // Travis doesn't like defines without ;
{
    switch (toLower configName _x) do {
        // Equipment/appearance
        CASE("displayname",0);
        CASE("uniform",1);
        CASE("vest",2);
        CASE("backpack",3);
        CASE("headgear",4);
        case "goggles": {
            private _goggles = _x call BIS_fnc_getCfgData;
            if (_goggles isEqualTo []) then {
                _goggles pushBack ""; // an empty array would mean goggles being skipped in main assignGear function
            };
            _loadoutArray set [5, _goggles];
        };
        CASE("hmd",6);
        CASE("faces",7);
        CASE("insignias",8);

        // Items/magazines
        CASE("uniformItems",9);
        CASE("vestItems",10);
        CASE("backpackitems",11);
        CASE("items",12);
        CASE("primarymagazines",13);
        CASE("secondarymagazines",14);
        CASE("sidearmmagazines",15);
        CASE("magazines",16);
        CASE("linkeditems",17);

        // Weapons
        CASE("primaryweapon",18);
        CASE("scope",19);
        CASE("bipod",20);
        CASE("attachment",21);
        CASE("silencer",22);
        CASE("secondaryweapon",23);
        CASE("secondaryattachments",24);
        CASE("sidearmweapon",25);
        CASE("sidearmattachments",26);

        CASE("traits",27);
        CASE("code",28);
    };
} forEach configProperties [CFGROLE];

TRACE_3("Loaded loadout from config",_cfg,_faction,_loadout);

_loadoutArray
