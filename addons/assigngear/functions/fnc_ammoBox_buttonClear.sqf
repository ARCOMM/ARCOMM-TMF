#include "\x\tmf\addons\assigngear\script_component.hpp"

params ["_ctrlButton"];
[ctrlParentControlsGroup _ctrlButton, "clear"] call FUNC(gui_vehicleGear_selector);
