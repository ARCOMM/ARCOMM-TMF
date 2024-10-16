
#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"


class ctrlDefault;
class ctrlDefaultText;// : ctrlDefault;
class ctrlStatic;// : ctrlDefaultText;
class ctrlListNBox;// : ctrlDefaultText;
class ctrlTree;// : ctrlDefaultText;
class ctrlEdit;// : ctrlDefaultText;

class RscButtonMenu;
class RscText;
class RscPicture;

/*
class cfgScriptPaths
{
    TMF_briefing = "x\tmf\addons\briefing\ui_scripts\";
};
*/

class Cfg3DEN
{
    class Mission
    {
        class GVAR(Attributes) // Custom section class, everything inside will be opened in one window (MySection)
        {
            displayName = "TMF Autotest"; // Text visible in the window title as "Edit <displayName>"
            //display = "Display3DENEditAttributesPreview"; // Optional - display for attributes window. Must have the same structure and IDCs as the default Display3DENEditAttributes
            class AttributeCategories
            {
                class GVAR(FakeSettings)
                {
                    displayName = "TMF: Autotest settings"; // Category name visible in Edit Attributes window
                    collapsed = 0; // When 1, the category is collapsed by default
                    class Attributes
                    {
                        class GVAR(MissionName)
                        {
                            property = QGVAR(MissionName);
                            displayName = "Mission name";
                            //tooltip = "Create briefing section that contains a list of all equipment of everyone in the players group and theirself.";
                            control = QGVAR(missionName);
                            defaultValue = "true";
                        };
                        class GVAR(MissionSummary)
                        {
                            property = QGVAR(MissionSummary);
                            displayName = "Mission description";
                            tooltip = "Checks a mission description has been set. Throws a warning if it does not include the word slot, as you may have forgotten slotting instructions.";
                            control = QGVAR(missionSummary);
                            defaultValue = "true";
                        };
                        class GVAR(Author)
                        {
                            property = QGVAR(Author);
                            displayName = "Author";
                            tooltip = "Checks the author field has your arma profile in it.";
                            control = QGVAR(Author);
                            defaultValue = "true";
                        };
                        class GVAR(MinPlayer)
                        {
                            property = QGVAR(MinPlayer);
                            displayName = "Min Players";
                            //tooltip = "Create briefing section that contains a list of all equipment of everyone in the players group and theirself.";
                            control = QGVAR(minPlayer);
                            defaultValue = "true";
                        };
                        class GVAR(MaxPlayer)
                        {
                            property = QGVAR(MaxPlayer);
                            displayName = "Max Players";
                            //tooltip = "Create briefing section that contains a list of all equipment of everyone in the players group and theirself.";
                            control = QGVAR(maxPlayer);
                            defaultValue = "true";
                        };
                        class GVAR(Test)
                        {
                            property = QGVAR(Test);
                            displayName = "Max Players";
                            //tooltip = "Create briefing section that contains a list of all equipment of everyone in the players group and theirself.";
                            control = QGVAR(Test);
                            defaultValue = "true";
                        };
                    };
                };
            };
        };
    };

    //FULLPAGE -> https://community.bistudio.com/wiki/Eden_Editor:_Scenario_Attributes

    // "Multiplayer" get3DENMissionAttribute "maxplayers" // OR minplayers
    // "Multiplayer" get3DENMissionAttribute "gametype" // "DM" - https://community.bistudio.com/wiki/Multiplayer_Game_Types

    //"Multiplayer" get3DENMissionAttribute "IntelOverviewText" // Summary

   // "Scenario" get3DENMissionAttribute "Author"
    //"Scenario" get3DENMissionAttribute "IntelBriefingName"

    class Attributes
    {

        class Default;
        class Title : Default
        {
            class Controls
            {
                class Title;
            };
        };
        class GVAR(missionName) : Title
        {
            attributeLoad = QUOTE(                                                                        \
                _value = 'Scenario' get3DENMissionAttribute 'IntelBriefingName';                          \
                (_this controlsGroupCtrl 100) ctrlSetText _value;                                         \
                if (_value == '') then {                                                                  \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\plus_small_ca.paa)';  \
                } else {                                                                                  \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\check_small_ca.paa)'; \
                };                                                                                        \
            );
            attributeSave = "true";
            class Controls : Controls
            {
                class Title : Title {};
                class Value : ctrlEdit
                {
                    idc = 100;
                    type = CT_EDIT; // Type
                    colorBackground[] = {COLOR_OVERLAY_RGBA}; // Background color

                    text = ""; // Displayed text
                    colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
                    colorDisabled[] = {COLOR_TEXT_RGB,0.25}; // Disabled text and frame color
                    colorSelection[] = {COLOR_ACTIVE_RGBA}; // Text selection color
                    canModify = 0; // True (1) to allow text editing, 0 to disable it
                    autocomplete = ""; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)
                    y = QUOTE(0 * SIZE_M * GRID_H);
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    w = QUOTE((ATTRIBUTE_CONTENT_W -(1.5* SIZE_M)) * GRID_W);

                };
                class Picture : RscPicture
                {
                    text = QPATHTOEF(briefing,UI\check_small_ca.paa); // Default
                    idc = 101;
                    y = 0;
                    h = QUOTE(SIZE_M * GRID_H);
                    x = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (1.5*SIZE_M)) * GRID_W);
                    w = QUOTE(1.25*SIZE_M * GRID_W);
                };
            };
        };
        class GVAR(missionSummary) : Title
        {
            attributeLoad = QUOTE(                                                                            \
                _value = 'Multiplayer' get3DENMissionAttribute 'IntelOverviewText';                           \
                (_this controlsGroupCtrl 100) ctrlSetText _value;                                             \
                if (_value == '' || _value == '*** Insert mission description here. ***') then {              \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\plus_small_ca.paa)';      \
                } else {                                                                                      \
                    if (((toLower _value) find 'slot') == -1) then {                                          \
                        (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOF(UI\warning.paa)';                  \
                    } else {                                                                                  \
                        (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\check_small_ca.paa)'; \
                    };                                                                                        \
                };                                                                                            \
            );
            attributeSave = "true";
            class Controls : Controls
            {
                class Title : Title {};
                class Value : ctrlEdit
                {
                    idc = 100;
                    type = CT_EDIT; // Type
                    colorBackground[] = {COLOR_OVERLAY_RGBA}; // Background color

                    text = ""; // Displayed text
                    colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
                    colorDisabled[] = {COLOR_TEXT_RGB,0.25}; // Disabled text and frame color
                    colorSelection[] = {COLOR_ACTIVE_RGBA}; // Text selection color
                    canModify = 0; // True (1) to allow text editing, 0 to disable it
                    autocomplete = ""; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)
                    y = QUOTE(0 * SIZE_M * GRID_H);
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    w = QUOTE((ATTRIBUTE_CONTENT_W -(1.5* SIZE_M)) * GRID_W);

                };
                class Picture : RscPicture
                {
                    text = QPATHTOEF(briefing,UI\check_small_ca.paa); // Default
                    idc = 101;
                    y = 0;
                    h = QUOTE(SIZE_M * GRID_H);
                    x = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (1.5*SIZE_M)) * GRID_W);
                    w = QUOTE(1.25*SIZE_M * GRID_W);
                };
            };
        };
        class GVAR(Author) : Title
        {
            attributeLoad = QUOTE(                                                                        \
                _value = 'Scenario' get3DENMissionAttribute 'Author';                                     \
                (_this controlsGroupCtrl 100) ctrlSetText _value;                                         \
                if ((_value find profileName)  == -1) then {                                              \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\plus_small_ca.paa)';  \
                } else {                                                                                  \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\check_small_ca.paa)'; \
                };                                                                                        \
            );
            attributeSave = "true";
            class Controls : Controls
            {
                class Title : Title {};
                class Value : ctrlEdit
                {
                    idc = 100;
                    type = CT_EDIT; // Type
                    colorBackground[] = {COLOR_OVERLAY_RGBA}; // Background color

                    text = ""; // Displayed text
                    colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
                    colorDisabled[] = {COLOR_TEXT_RGB,0.25}; // Disabled text and frame color
                    colorSelection[] = {COLOR_ACTIVE_RGBA}; // Text selection color
                    canModify = 0; // True (1) to allow text editing, 0 to disable it
                    autocomplete = ""; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)
                    y = QUOTE(0 * SIZE_M * GRID_H);
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    w = QUOTE((ATTRIBUTE_CONTENT_W -(1.5* SIZE_M)) * GRID_W);
                };
                class Picture : RscPicture
                {
                    text = QPATHTOEF(briefing,UI\check_small_ca.paa); // Default
                    idc = 101;
                    x = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (1.5*SIZE_M)) * GRID_W);
                    w = QUOTE(1.25*SIZE_M * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    y = 0;
                };
            };
        };
        class GVAR(minPlayer) : Title
        {
            attributeLoad = QUOTE(                                                                        \
                _value = 'Multiplayer' get3DENMissionAttribute 'minplayers';                              \
                _playerCount = (playableUnits + switchableUnits + [player]) - [objNull];                  \
                _playerCount = count (_playerCount arrayIntersect _playerCount);                          \
                (_this controlsGroupCtrl 100) ctrlSetText (str _value);                                   \
                if (_value > 0 && _value <= _playerCount) then {                                         \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\check_small_ca.paa)'; \
                } else {                                                                                  \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\plus_small_ca.paa)';  \
                };                                                                                        \
            );
            attributeSave = "true";
            class Controls : Controls
            {
                class Title : Title {};
                class Value : ctrlEdit
                {
                    idc = 100;
                    type = CT_EDIT; // Type
                    colorBackground[] = {COLOR_OVERLAY_RGBA}; // Background color

                    text = ""; // Displayed text
                    colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
                    colorDisabled[] = {COLOR_TEXT_RGB,0.25}; // Disabled text and frame color
                    colorSelection[] = {COLOR_ACTIVE_RGBA}; // Text selection color
                    canModify = 0; // True (1) to allow text editing, 0 to disable it
                    autocomplete = ""; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)
                    y = QUOTE(0 * SIZE_M * GRID_H);
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    w = QUOTE((ATTRIBUTE_CONTENT_W -(1.5* SIZE_M)) * GRID_W);
                };
                class Picture : RscPicture
                {
                    text = QPATHTOEF(briefing,UI\check_small_ca.paa); // Default
                    idc = 101;
                    x = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (1.5*SIZE_M)) * GRID_W);
                    w = QUOTE(1.25*SIZE_M * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    y = 0;
                };
            };
        };
        class GVAR(maxPlayer) : Title
        {
            attributeLoad = QUOTE(                                                                                  \
                _value = 'Multiplayer' get3DENMissionAttribute 'maxplayers';                                        \
                _playerCount = (playableUnits + switchableUnits + [player]) - [objNull];                            \
                _playerCount = count (_playerCount arrayIntersect _playerCount);                                    \
                (_this controlsGroupCtrl 100) ctrlSetText (str _value);                                             \
                if (_value != _playerCount || _value == 0) then {                                                   \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\plus_small_ca.paa)';            \
                    (_this controlsGroupCtrl 100) ctrlSetText ((str _value) + ' should be: ' + (str _playerCount)); \
                } else {                                                                                            \
                    (_this controlsGroupCtrl 101) ctrlSetText 'PATHTOEF(briefing,UI\check_small_ca.paa)';           \
                };                                                                                                  \
            );
            attributeSave = "true";
            class Controls : Controls
            {
                class Title : Title {};
                class Value : ctrlEdit
                {
                    idc = 100;
                    type = CT_EDIT; // Type
                    colorBackground[] = {COLOR_OVERLAY_RGBA}; // Background color

                    text = ""; // Displayed text
                    colorText[] = {COLOR_TEXT_RGBA}; // Text and frame color
                    colorDisabled[] = {COLOR_TEXT_RGB,0.25}; // Disabled text and frame color
                    colorSelection[] = {COLOR_ACTIVE_RGBA}; // Text selection color
                    canModify = 0; // True (1) to allow text editing, 0 to disable it
                    autocomplete = ""; // Text autocomplete, can be "scripting" (scripting commands) or "general" (previously typed text)
                    y = QUOTE(0 * SIZE_M * GRID_H);
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    w = QUOTE((ATTRIBUTE_CONTENT_W -(1.5* SIZE_M)) * GRID_W);
                };
                class Picture : RscPicture
                {
                    text = QPATHTOEF(briefing,UI\check_small_ca.paa); // Default
                    idc = 101;
                    x = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (1.5*SIZE_M)) * GRID_W);
                    w = QUOTE(1.25*SIZE_M * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    y = 0;
                };
            };
        };

        class Toolbox; //class Toolbox: Title

        class GVAR(Test) : Toolbox {
            attributeLoad = QUOTE(_this call FUNC(autotest));
            attributeSave = "true";

            w = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W);
            h = QUOTE(24 * SIZE_M * GRID_H);
            class Controls
            {
                class ActionTitle : ctrlStatic
                {
                    text = "List of findings:";
                    style = ST_RIGHT;
                    w = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    x = 0;
                    h = QUOTE(1 * SIZE_M * GRID_H);
                    y = 0;
                    colorBackground[] = {0,0,0,0};
                    tooltip = "";
                };
                class ActionListBackground : ctrlStatic
                {
                    idc = -1;
                    x = QUOTE(SIZE_M * GRID_H);
                    y = QUOTE(1 * SIZE_M * GRID_H);
                    w = QUOTE(((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) - (2*SIZE_M)) * GRID_W);
                    h = QUOTE(23 * SIZE_M * GRID_H);
                    colorBackground[] = {0.33,0.33,0.33,1};
                };
                class ActionList: ctrlListNBox
                {
                    idc = 101;
                    x = QUOTE(SIZE_M * GRID_H);
                    y = QUOTE(1 * SIZE_M * GRID_H);
                    w = QUOTE(((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) - (2*SIZE_M) ) * GRID_W);
                    h = QUOTE(23 * SIZE_M * GRID_H);
                    drawSideArrows = 0;//1;
                    idcLeft = -1;
                    idcRight = -1;
                    columns[] = {0,0.05}; //0.05,0.15,0.85};
                    disableOverflow = 1;
                };

            };
        };

    };

};
