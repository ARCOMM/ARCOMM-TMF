
XEH_PRESTART;
XEH_PREINIT;

class Extended_InitPost_EventHandlers {
    class GVAR(ambientVehicles) {
        class ADDON {
            init = " \
                params ['_logic']; \
                if (local _logic) then { \
                    [ARR_2('preInit', [_logic])] call FUNC(ambientVehicleInit); \
                }; \
            ";
        };
    };
};
