#include "\x\tmf\addons\assigngear\script_component.hpp"

params ["_control", "_index"];
[ctrlParentControlsGroup _control, "filterChanged", uiNamespace getVariable ["TMF_assignGear_filter",  0]] call FUNC(gui_vehicleGear_selector);
