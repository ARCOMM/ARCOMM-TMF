#include "..\script_component.hpp"

params ["_mode",["_params",[]],["_value","[]"]];

switch _mode do {
    case "onLoad": {
       #include "GroupMarker_onLoad.inc.sqf"
    };
    case "attributeLoad": {
       #include "GroupMarker_attributeLoad.inc.sqf"
    };
    case "attributeSave": {
       #include "GroupMarker_attributeSave.inc.sqf"
    };
};
