#include "\x\tmf\addons\assigngear\script_component.hpp"

params ["_ctrl", "_idx"];
[ctrlParentControlsGroup _ctrl, "filterChanged", _idx] call FUNC(gui_vehicleGear_selector);
