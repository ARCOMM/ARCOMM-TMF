class GVARMAIN(RscDisplayAttributesModuleAIGear): RscDisplayAttributes {
    //INIT_DISPLAY(GVARMAIN(RscDisplayAttributesModuleAIGear),ADDON)
    //I can't get this ^ macro to work with HEMTT so it's been replaced with the next 4 lines
    scriptName = "TMF_RscDisplayAttributesModuleAIGear";
    scriptPath = "TMF_assignGear";
    onLoad = "['onLoad',_this,'TMF_RscDisplayAttributesModuleAIGear','TMF_assignGear'] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";
    onUnload = "['onUnload',_this,'TMF_RscDisplayAttributesModuleAIGear','TMF_assignGear'] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";

    curatorObjectAttributes = 1;
    class Controls: Controls {
        class Background: Background{};
        class Title: Title {};
        class Content: Content {
            class Controls: Controls {
                class Text: RscAttributeText {
                    class Controls: Controls {
                        class Title: Title {
                            text = "Bulk applies loadouts to AI units. Cannot be undone/disabled!";
                        };
                    };
                };
                class Faction: GVARMAIN(RscAttributeFaction) {};
                class Loadout: GVARMAIN(RscAttributeLoadout) {};
                class Retroactive: GVARMAIN(RscAttributeRetroactive) {};
            };
        };
        class ButtonOK: ButtonOK{};
        class ButtonCancel: ButtonCancel{};
    };
};
