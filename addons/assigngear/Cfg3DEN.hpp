#include "\a3\3DEN\UI\macros.inc"
#include "\a3\3DEN\UI\resincl.inc"
class ctrlCombo;
class ctrlStatic;
class ctrlToolboxPictureKeepAspect;
class ctrlListNBox;
class ctrlButton;
class Cfg3DEN
{
    class Object
    {
        class AttributeCategories
        {
            class TMF_assignGear
            {
                displayName = "TMF: Assign Gear";
                collapsed = 0;
                class Attributes
                {
                    class TMF_assignGear_enabled
                    {
                        property = "TMF_assignGear_enabled";
                        displayName = "Enabled";
                        tooltip = "Toggle assignGear.";
                        condition = "objectBrain";
                        control = "Checkbox";
                        defaultValue = "false";
                        wikiType = "[[Bool]]";
                    };
                    class TMF_assignGear_Side
                    {
                        property = "TMF_assignGear_side";
                        displayName = "Category";
                        tooltip = "Select a faction category.";
                        condition = "objectBrain";
                        control = "TMF_Side";
                        defaultValue = "-1"; /* (side _this) call BIS_fnc_sideID;*/
                        wikiType = "[[Number]]";
                    };
                    class TMF_assignGear_faction
                    {
                        property = "TMF_assignGear_faction";
                        displayName = "Faction";
                        tooltip = "Select a faction.";
                        condition = "objectBrain";
                        control = "TMF_Faction";
                        defaultValue = "toLower(faction _this)";
                        wikiType = "[[String]]";
                    };
                    class TMF_assignGear_role
                    {
                        property = "TMF_assignGear_role";
                        displayName = "Role";
                        tooltip = "Select a role.";
                        condition = "objectBrain";
                        control = "TMF_Role";
                        defaultValue = "'r'";
                        value = "''";
                        wikiType = "[[String]]";
                    };
                    class TMF_assignGear_full
                    {
                        property = "TMF_assignGear_full";
                        condition = "objectBrain";
                        control = "None";
                        expression = QUOTE([ARR_2(_this,_value)] call FUNC(helper));
                        defaultValue = "['r','',false]";
                    };
                };
            };
            class GVAR(vehicleGear) {
                displayName = "TMF: Vehicle Gear";
                collapsed = 0;
                class Attributes
                {
                    class GVAR(vehicle)
                    {
                        property = QGVAR(vehicleContents);
                        condition = "objectHasInventoryCargo";
                        defaultValue = "['', '', createHashMap]";
                        expression = QUOTE([ARR_2(_this,_value)] call FUNC(vehicleGear_init));
                        control = QGVAR(AmmoBox);
                    };
                };
            };
        };
    };
    class Attributes
    {
        class Default;
        class Title: Default {
            class Controls {
                class Title;
            };
        };
        class Combo: Title {
           class Controls: Controls {
               class Title: Title {};
               class Value;
           };
        };
        class Value;
        class TitleWide;
        class Controls;

        // AI Gear module controls
        class GVARMAIN(DOUBLES(aigear,faction)) : Combo {
            //INIT_CONTROL(GVARMAIN(AttributesFaction),ADDON)
             //I can't get this ^ macro to work with HEMTT so it's been replaced with the next 4 lines
            scriptName = "TMF_AttributesFaction";
            scriptPath = "TMF_assignGear";
            onLoad = "['onLoad',_this,'TMF_AttributesFaction','TMF_assignGear',0] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";
            onUnload = "['onUnload',_this,'TMF_AttributesFaction','TMF_assignGear',0] call (uiNamespace getVariable 'BIS_fnc_initDisplay')";
        };

        class GVARMAIN(loadout) : Combo {
            class Controls: Controls {
                class Title: Title {};
                class Value: Value {
                    delete Items;
                    class ItemsConfig {
                        path[] = {"CfgLoadouts"};
                        localConfig = 1;
                        propertyText = "displayName";
                        sort = 1;
                    };
                };
            };
        };

        class TMF_Side : Combo
        {
            /* TMF_Side is a faction category chooser - name renames for backwards compatabiliy */
            onLoad = "uiNamespace setVariable ['AttributeTMF_Side',(_this select 0) controlsGroupCtrl 100]; [(_this select 0) controlsGroupCtrl 100] call TMF_assignGear_fnc_loadFactionCategories;";
            attributeLoad = "";
            attributeSave = "-1";
            class Controls : Controls
            {
                class Title : Title {};
                class ValueSide : Value
                {
                    idc = 100;
                    onLBSelChanged = "\
                        _ctrlFaction = (uiNamespace getVariable ['AttributeTMF_Faction',controlNull]) controlsGroupCtrl 100;\
                        [_ctrlFaction,(_this select 0) lbData (_this select 1)] call TMF_assignGear_fnc_loadFactions;\
                    ";
                };
            };
        };
        class TMF_Faction: Combo
        {
            onLoad = "uiNamespace setVariable ['AttributeTMF_Faction',_this select 0]; [(_this select 0) controlsGroupCtrl 100] call TMF_assignGear_fnc_loadFactions;";
            attributeLoad = "";
            attributeSave = "\
                _ctrlFaction = _this controlsGroupCtrl 100;\
                private _output = _ctrlFaction lbData lbCurSel _ctrlFaction;\
                private _objects = get3DENSelected 'object'; \
                { \
                    private _array = [(_x get3DENAttribute 'TMF_assignGear_role') select 0, \
                    _output, \
                    (_x get3DENAttribute 'TMF_assignGear_enabled') select 0]; \
                    _x set3DENAttribute ['TMF_assignGear_full',(str _array)]; \
                } forEach _objects; \
                _output; \
            ";
            class Controls : Controls
            {
                class Title : Title {};
                class ValueFaction: Value
                {
                    idc = 100;
                    // TYPE
                    onLBSelChanged = "\
                        _ctrlRole = uiNamespace getVariable ['AttributeTMF_Role',controlNull];\
                        [\
                            _ctrlRole,\
                            _ctrlRole lbData (lbCurSel _ctrlRole),\
                            (_this select 0) lbData (_this select 1)\
                        ] call (missionNamespace getVariable 'TMF_assignGear_fnc_loadRoles');\
                    ";
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                };
            };
        };
        class TMF_Role: Combo
        {
            onLoad = "uiNamespace setVariable ['AttributeTMF_Role',(_this select 0) controlsGroupCtrl 100];";
            attributeLoad = "\
                _ctrlRole = _this controlsGroupCtrl 100 ;\
                [_ctrlRole,_value] call TMF_assignGear_fnc_loadRoles;\
            ";
            attributeSave = "\
                _ctrlRole = _this controlsGroupCtrl 100;\
                private _output = _ctrlRole lbData lbCurSel _ctrlRole;\
                private _objects = get3DENSelected 'object'; \
                { \
                    _array = [_output, \
                    (_x get3DENAttribute 'TMF_assignGear_faction') select 0, \
                    (_x get3DENAttribute 'TMF_assignGear_enabled') select 0]; \
                    _x set3DENAttribute ['TMF_assignGear_full',(str _array)]; \
                } forEach _objects;  \
                _output; \
            ";
            class Controls
            {
                class Title: ctrlStatic {
                    style = 0x01;
                    x = 0;
                    w = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    colorBackground[] = {0,0,0,0};
                };
                class ValueRole: ctrlCombo
                {
                    idc = 100;
                    onLoad = "uiNamespace setVariable ['AttributeTMF_Role',_this select 0];";
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                };
            };
        };
        class GVAR(AmmoBox): Default {
            onLoad = QUOTE([ARR_2(_this select 0,'onLoad')] call FUNC(gui_vehicleGear_selector));
            attributeLoad = QUOTE([ARR_2(_this,_value)] call FUNC(gui_vehicleGear_load));
            attributeSave = QUOTE([_this] call FUNC(gui_vehicleGear_save));
            h = QUOTE((22 * ATTRIBUTE_CONTENT_H + 1) * GRID_H);
            class Controls: Controls
            {
                class CategoryTitle: ctrlStatic {
                    x = 0;
                    y = 0;
                    w = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_XL * GRID_H);
                    text = "Category";
                    style = ST_RIGHT;
                    colorBackground[] = {0,0,0,0};
                };
                class CategoryValue: ctrlCombo
                {
                    idc = IDC_VEHICLEGEAR_CATEGORY;
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    y = 0;
                    w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    onLBSelChanged = " \
                        params [ARR_2('_control','_index')]; \
                        [ARR_3(ctrlParentControlsGroup _control,'categoryChanged',_control lbData _index)] call FUNC(gui_vehicleGear_selector); \
                    ";
                };
                class FactionTitle : ctrlStatic {
                    text = "Faction";
                    style = ST_RIGHT;
                    x = 0;
                    y = QUOTE(SIZE_XL * GRID_H);
                    w = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    h = QUOTE(SIZE_XL * GRID_H);
                    colorBackground[] = {0,0,0,0};
                };
                class FactionValue: ctrlCombo
                {
                    idc = IDC_VEHICLEGEAR_FACTION;
                    x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
                    y = QUOTE(SIZE_XL * GRID_H);
                    w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
                    h = QUOTE(SIZE_M * GRID_H);
                    onLBSelChanged = "\
                        params [ARR_2('_control','_index')]; \
                        [ARR_3(ctrlParentControlsGroup _control,'filterChanged',uiNamespace getVariable [ARR_2(QQGVAR(filter), FILTER_CONTENTS)])] call FUNC(gui_vehicleGear_selector); \
                    ";
                };
                class Title2: Title
                {
                    text = "$STR_3den_attributes_ammobox_title2_text";
                    y = QUOTE(2 * ATTRIBUTE_CONTENT_H * GRID_H);
                };
                class Filter: ctrlToolboxPictureKeepAspect
                {
                    idc = IDC_VEHICLEGEAR_FILTER;
                    x = QUOTE(ATTRIBUTE_CONTENT_H * GRID_W);
                    y = QUOTE(3 * ATTRIBUTE_CONTENT_H * GRID_H);
                    w = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - 5) * GRID_W);
                    h = QUOTE(2 * ATTRIBUTE_CONTENT_H * GRID_H);
                    rows = 1;
                    columns = 4;
                    onToolBoxSelChanged = " \
                        params [ARR_2('_ctrl','_idx')]; \
                        [ARR_3(ctrlParentControlsGroup _ctrl,'filterChanged',_idx)] call FUNC(gui_vehicleGear_selector); \
                    ";
                    strings[] = {
                        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_0_ca.paa",
                        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_1_ca.paa",
                        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_8_ca.paa",
                        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_12_ca.paa"
                    };
                };
                class ListSortBackground: ctrlStatic
                {
                    x = QUOTE(ATTRIBUTE_CONTENT_H * GRID_W);
                    y = QUOTE(5 * ATTRIBUTE_CONTENT_H * GRID_H);
                    w = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - ATTRIBUTE_CONTENT_H) * GRID_W);
                    h = QUOTE(ATTRIBUTE_CONTENT_H * GRID_H);
                    colorBackground[] = {0,0,0,1};
                };
                class ListSort: ctrlListNBox
                {
                    idc = IDC_VEHICLEGEAR_LISTSORT;
                    x = QUOTE(ATTRIBUTE_CONTENT_H * GRID_W);
                    y = QUOTE(5 * ATTRIBUTE_CONTENT_H * GRID_H);
                    w = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - 5) * GRID_W);
                    h = QUOTE(ATTRIBUTE_CONTENT_H * GRID_H);
                    disableOverflow = 1;
                    columns[] = {0,0.60,0.82,0.89,1};
                };
                class ListBackground: ctrlStatic
                {
                    x = QUOTE(ATTRIBUTE_CONTENT_H * GRID_W);
                    y = QUOTE(6 * ATTRIBUTE_CONTENT_H * GRID_H);
                    w = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - ATTRIBUTE_CONTENT_H) * GRID_W);
                    h = QUOTE(13 * ATTRIBUTE_CONTENT_H * GRID_H);
                    colorBackground[] = {1,1,1,0.1};
                };
                class List: ctrlListNBox
                {
                    idc = IDC_VEHICLEGEAR_LIST;
                    x = QUOTE(ATTRIBUTE_CONTENT_H * GRID_W);
                    y = QUOTE(6 * ATTRIBUTE_CONTENT_H * GRID_H);
                    w = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - 5) * GRID_W);
                    h = QUOTE(13 * ATTRIBUTE_CONTENT_H * GRID_H);
                    drawSideArrows = 1;
                    idcLeft = IDC_VEHICLEGEAR_SUBTRACT;
                    idcRight = IDC_VEHICLEGEAR_ADD;
                    columns[] = {0.03,0.10,0.60,0.82,0.89,1};
                    disableOverflow = 1;
                    tooltipPerColumn = 1;
                    period = 1e+011;
                };
                class ButtonClear: ctrlButton
                {
                    idc = IDC_VEHICLEGEAR_CLEAR;
                    text = "Clear";
                    x = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W - 25) * GRID_W);
                    y = QUOTE(19 * ATTRIBUTE_CONTENT_H * GRID_H);
                    w = QUOTE(25 * GRID_W);
                    h = QUOTE(ATTRIBUTE_CONTENT_H * GRID_H);
                    onButtonClick = " \
                        params ['_ctrlButton']; \
                        [ARR_2(ctrlParentControlsGroup _ctrlButton,'clear')] call FUNC(gui_vehicleGear_selector); \
                    ";
                };
                class ArrowLeft: ctrlButton
                {
                    idc = IDC_VEHICLEGEAR_SUBTRACT;
                    text = "-";
                    font = "RobotoCondensedBold";
                    x = -1;
                    y = -1;
                    w = QUOTE(ATTRIBUTE_CONTENT_H * GRID_W);
                    h = QUOTE(ATTRIBUTE_CONTENT_H * GRID_H);
                };
                class ArrowRight: ArrowLeft
                {
                    idc = IDC_VEHICLEGEAR_ADD;
                    text = "+";
                };
            };
        };
    };
    class EventHandlers
    {
        class ADDON
        {
            onMessage = QUOTE(_this call FUNC(onEdenMessageRecieved));
        };
    };
};
