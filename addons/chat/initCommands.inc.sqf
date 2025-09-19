#define CMND(COMMAND) cmnd##COMMAND
#define CHAT_FUNC(COMMAND) { _this call FUNC(CMND(COMMAND)); [format ["%1 executed #%2 %3",profileName,QUOTE(COMMAND),_this select 0],false,"Chat"] call EFUNC(adminmenu,log)}

[ // Heal
    "heal",
    CHAT_FUNC(Heal),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Refuel
    "refuel",
    CHAT_FUNC(Refuel),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Repair
    "repair",
    CHAT_FUNC(Repair),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Reset Position
    "rp",
    CHAT_FUNC(RP),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Teleport
    "tp",
    CHAT_FUNC(TP),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Spectate
    "spec",
    CHAT_FUNC(Spec),
    "all"
] call CBA_fnc_registerChatCommand;

[ // Whisper
    "whisper",
    CHAT_FUNC(Whisper),
    "all"
] call CBA_fnc_registerChatCommand;

if (isClass (configFile >> "CfgPatches" >> QUOTE(DOUBLES(PREFIX,assignGear)))) then {
    [ // Assign loadout
        "loadout",
        CHAT_FUNC(Loadout),
        "all"
    ] call CBA_fnc_registerChatCommand;
};

if (isClass (configFile >> "CfgPatches" >> QUOTE(DOUBLES(PREFIX,acre2)))) then {
    [ // Assign radio
        "radio",
        CHAT_FUNC(Radio),
        "all"
    ] call CBA_fnc_registerChatCommand;
};

