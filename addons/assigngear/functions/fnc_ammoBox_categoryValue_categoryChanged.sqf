#include "\x\tmf\addons\assigngear\script_component.hpp"

params ["_control", "_index"];
[ctrlParentControlsGroup _control, "categoryChanged" ,_control lbData _index] call FUNC(gui_vehicleGear_selector);
