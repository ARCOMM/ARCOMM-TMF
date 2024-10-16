class ORBATSettings : Toolbox
{
    scriptName = "ORBATSettings";
    scriptPath = "TMF_orbat";
    onLoad = "['onLoad',_this,'ORBATSettings','TMF_orbat',false] call (uiNamespace getVariable 'BIS_fnc_initDisplay');"; // 3rd param is the path PATH\scriptName.sqf
    onUnload = "['onUnload',_this,'ORBATSettings','TMF_orbat',false] call (uiNamespace getVariable 'BIS_fnc_initDisplay');";

    attributeLoad = "['attributeLoad',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
    attributeSave = "['attributeSave',_this] call (uiNamespace getVariable 'ORBATSettings_script');";

    w = QUOTE((ATTRIBUTE_TITLE_W + ATTRIBUTE_CONTENT_W) * GRID_W);
    h = QUOTE(25 * SIZE_M * GRID_H);
    class Controls
    {
        class LangTitle : ctrlStatic
        {
            text = "Split ORBATs by:";
            style = ST_RIGHT;
            w = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            y = 0;
            x = 0;
            colorBackground[] = {0,0,0,0};
            tooltip = "Use this to control whether group markers are shared with everyone on the same faction or instead on the same side. Changing this system will erase the previous heirarchy.";
        };
        class Value: ctrlToolBox
        {
            idc = 100;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            style = ST_CENTER + ST_KEEP_ASPECT_RATIO; //ST_PICTURE +
            y = 0;
            h = QUOTE(SIZE_M * GRID_H);
            rows = 1;
            columns = 2;
            strings[] = {"Side", "Faction"};
            tooltips[] = {"Side", "Faction"};
            values[] = {0, 1};

            onToolboxSelChanged = "['orbatBinChanged',_this] call (uiNamespace getVariable 'ORBATSettings_script');"; // missionnamespace setVariable ['Rank_value',_this select 1];
        };
        class orbatToggleButton : RscButtonMenu
        {
            idc = 101;
            class Attributes {
                align = "center";
            };
            text = "&lt; Configure X &gt;";
            h = QUOTE(SIZE_M * GRID_H);
            x = QUOTE(SIZE_M * GRID_W);
            w = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W));
            y = QUOTE(2 * SIZE_M * GRID_H);
            action = "['orbatToggleButton',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Toggle through the various sides/factions (Only toggles through sides/factions with playable units)";
        };
        class OrbatTitle : LangTitle
        {
            idc = 103;
            text = "Orbat hierarchy:";
            x = QUOTE(SIZE_M * GRID_W);
            style = ST_LEFT;
            y = QUOTE(3 * SIZE_M * GRID_H);
            tooltip = "Hierarchy tree of ORBAT";
        };

        /*class OrbatTreeBackground: ctrlStatic
        {
            x = QUOTE(SIZE_M * GRID_W);
            y = 5 * SIZE_M * GRID_H;
            w = (ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) * GRID_W;
            h = 14 * SIZE_M * GRID_H;
            colorBackground[] = {0,0,0,0.1};
        };*/
        class TreeMove : RscButtonMenu
        {
            idc = 104;
            text = "Move";
            h = QUOTE(SIZE_M * GRID_H);
            x = QUOTE(SIZE_M * GRID_W);
            w = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W)/4);
            y = QUOTE(4 * SIZE_M * GRID_H);
            action = "['treeMoveClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Move the selected element";
        };
        class TreeAdd : TreeMove
        {
            idc = 105;
            text = "Add";
            x = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W)/4 + SIZE_M * GRID_W);
            action = "['treeAddClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Add a new virtual element as a child of the selected element. You can not create a virtual element on a real group.";
        };
        class TreeEdit : TreeMove
        {
            idc = 106;
            text = "Edit";
            x = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W)/4 *2 + SIZE_M * GRID_W);
            action = "['treeEditClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Edit the orbat settings for the selected element";
        };
        class TreeDel : TreeMove
        {
            idc = 107;
            text = "Delete";
            x = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W)/4 *3 + SIZE_M * GRID_W);
            action = "['treeDelClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Delete the virtual element. This will not delete real groups";
        };
        class OrbatTree : ctrlTree
        {
            idc = 102;
            x = QUOTE(SIZE_M * GRID_W);
            w = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (3.5*SIZE_M)) * GRID_W);
            y = QUOTE(5 * SIZE_M * GRID_H);
            h = QUOTE(19 * SIZE_M * GRID_H);
            multiselectEnabled = 1;
            disableKeyboardSearch = 1;
            colorDisabled[] = {1,1,1,0.25};
            action = "['treeClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            onTreeDblClick = "['treeDoubleClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            colorBackground[] = {0,0,0,0.3};
        };

        class TreeTop : RscButtonMenu
        {
            idc = 124;
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;

            animTextureNormal = "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
            animTextureDisabled =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
            animTextureOver =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
            animTextureFocused =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
            animTexturePressed =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";
            animTextureDefault =  "\x\tmf\addons\orbat\ui\arrow_top_ca.paa";

            color[] = {0,0,0,0.6};
            color2[] = {0,0,0,1};
            colorDisabled[] = {0,0,0,0.3};
            colorBackground[] = {1,1,1,1};
            colorBackground2[] = {1,1,1,0.5};

            text = "";
            h = QUOTE(1*SIZE_M * GRID_H);
            x = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W - (2.5*SIZE_M)) * GRID_W);
            w = QUOTE(2.5*SIZE_M * GRID_W);
            y = QUOTE(8.3 * SIZE_M * GRID_H);
            action = "['moveTop',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Move the current entry to the top.";
        };
        class TreeUp : TreeTop
        {
            idc = 125;
            y = QUOTE(0.45* SIZE_M * GRID_H);

            animTextureNormal = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
            animTextureDisabled = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
            animTextureOver = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
            animTextureFocused = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
            animTexturePressed = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";
            animTextureDefault = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_up_ca.paa";

            action = "['moveUp',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Move the current entry up.";
        };
        class TreeDown : TreeTop
        {
            idc = 126;
            animTextureNormal = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
            animTextureDisabled = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
            animTextureOver = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
            animTextureFocused = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
            animTexturePressed = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
            animTextureDefault = "\a3\ui_f\data\gui\Rsc\RscDisplayMultiplayer\arrow_down_ca.paa";
            y = QUOTE(12.6 * SIZE_M * GRID_H);
            action = "['moveDown',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Move the current entry down.";
        };
        class TreeBottom : TreeDown
        {
            animTextureNormal = "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
            animTextureDisabled =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
            animTextureOver =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
            animTextureFocused =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
            animTexturePressed =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";
            animTextureDefault =  "\x\tmf\addons\orbat\ui\arrow_bottom_ca.paa";

            idc = 127;
            y = QUOTE(14.75 * SIZE_M * GRID_H);
            action = "['moveBottom',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Move the current entry to the bottom.";
        };

        //Move GUI
        class MoveTitle : LangTitle
        {
            idc = 120;
            text = "Select the new parent (double click)";
            w = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W-SIZE_M) * GRID_W);
            x = QUOTE(SIZE_M * GRID_W);
            style = ST_LEFT;
            y = QUOTE(3.25 * SIZE_M * GRID_H);
            tooltip = "Hierarchy tree of ORBAT";
        };

        class MoveTree : ctrlTree
        {
            idc = 108;
            x = QUOTE(SIZE_M * GRID_W);
            w = QUOTE((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W-SIZE_M) * GRID_W);
            y = QUOTE(4.5 * SIZE_M * GRID_H);
            h = QUOTE(19 * SIZE_M * GRID_H);
            multiselectEnabled = 1;
            disableKeyboardSearch = 1;
            colorDisabled[] = {1,1,1,0.25};
            //action = "['treeClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            onTreeDblClick = "['moveTreeDoubleClick',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            colorBackground[] = {0,0,0,0.3};
        };
        class moveOrbatCancel : TreeMove
        {
            idc = 121;
            text = "Cancel";
            y = QUOTE(24 * SIZE_M * GRID_H);
            x = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W / 8)*4.5 + SIZE_M * GRID_W);
            action = "['editOrbatEntryClickCancel',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
            tooltip = "Cancel moving the element.";
        };

        //Edit/Add GUI
        class EditTitle : LangTitle
        {
            idc = 109;
            text = "Add/Edit heirarchy piece:";
            x = QUOTE(SIZE_M * GRID_W);
            style = ST_LEFT;
            y = QUOTE(3 * SIZE_M * GRID_H);
            tooltip = "Hierarchy tree of ORBAT";
        };
        class GmTitle: ctrlStatic
        {
            idc = 110;
            x = 0;
            w = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            y = QUOTE(4 * SIZE_M * GRID_H);
            colorBackground[] = {0,0,0,0};
            style = ST_RIGHT;
            text = "Marker icon";
            tooltip = "Choose icon to use for this group. Use the empty icon to not use an icon";
        };
        class Icon: ctrlToolBox
        {
            idc = 111;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            h = QUOTE(12.25 * SIZE_M * GRID_H);
            y = QUOTE(4 * SIZE_M * GRID_H);
            rows = 7;
            columns = 7;
            strings[] = {GROUP_MARKER_PREVIEW};
            tooltips[] = {GROUP_MARKER_DESCRIPTIONS};
            values[] = {GROUP_MARKER_POSTFIX};

            onToolboxSelChanged = ""; // missionnamespace setVariable ['Rank_value',_this select 1];
        };


        // Colours
        class ColourTitle: GmTitle
        {
            idc = 112;
            y = QUOTE((4+12.25+0.15) * SIZE_M * GRID_H);
            text = "Marker colour";
            tooltip = "Select the colour to use for the marker";
        };
        class ColourValue: ctrlToolBox
        {
            idc = 113;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            y = QUOTE((4+12.25+0.15) * SIZE_M * GRID_H);
            h = QUOTE(1.75 * SIZE_M * GRID_H);

            rows = 1;
            columns = 7;
            strings[] = {
                "x\tmf\addons\orbat\textures\yellow_blank.paa",
                "x\tmf\addons\orbat\textures\blue_blank.paa",
                "x\tmf\addons\orbat\textures\green_blank.paa",
                "x\tmf\addons\orbat\textures\red_blank.paa",
                "x\tmf\addons\orbat\textures\orange_blank.paa",
                "x\tmf\addons\orbat\textures\gray_blank.paa",
                "x\tmf\addons\orbat\textures\purple_blank.paa"
            };
            tooltips[] = {
                "Yellow",
                "Blue",
                "Green",
                "Red",
                "Orange",
                "Gray",
                "Purple"
            };
            values[] = {
                "yellow",
                "blue",
                "green",
                "red",
                "orange",
                "gray",
                "purple"
            };

            onToolboxSelChanged = ""; // missionnamespace setVariable ['Rank_value',_this select 1];
        };
        // MARKER TEXT
        class MarkerTitle: GmTitle
        {
            idc = 114;
            y = QUOTE((4+14+0.3) * SIZE_M * GRID_H);
            text = "Marker text";
            tooltip = "Text to display alongside the marker. This should ideally be a short string e.g. 'A'";
        };
        class EditMarkerTitleValue : ctrlEdit
        {
            y = QUOTE((4+14+0.3) * SIZE_M * GRID_H);
            idc = 115;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
        };
        class FullTitle: MarkerTitle
        {
            idc = 122;
            y = QUOTE((4+15+0.45) * SIZE_M * GRID_H);
            text = "Briefing text";
            tooltip = "Text to display for this entry in the briefing. E.g. 'Alpha Squad', '1st Platoon'";
        };
        class EditFullTitleValue : EditMarkerTitleValue
        {
            y = QUOTE((4+15+0.45) * SIZE_M * GRID_H);
            idc = 123;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
        };
        // Size
        class sizeTitle: GmTitle
        {
            idc = 116;
            y = QUOTE((4+16+0.6) * SIZE_M * GRID_H);
            text = "Marker size modifier";
            tooltip = "Size modifier";
        };
        class sizeValue: ctrlToolBox
        {
            idc = 117;
            x = QUOTE(ATTRIBUTE_TITLE_W * GRID_W);
            w = QUOTE(ATTRIBUTE_CONTENT_W * GRID_W);
            style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
            y = QUOTE((4+16+0.6) * SIZE_M * GRID_H);
            h = QUOTE(1.75 * SIZE_M * GRID_H);
            colorBackground[] = {1,1,1,0.3};

            rows = 1;
            columns = 6;
            strings[] = {
                "x\tmf\addons\orbat\textures\empty.paa",
                "x\tmf\addons\orbat\textures\modif_o.paa",
                "x\tmf\addons\orbat\textures\modif_dot.paa",
                "x\tmf\addons\orbat\textures\modif_2dot.paa",
                "x\tmf\addons\orbat\textures\modif_3dot.paa",
                "x\tmf\addons\orbat\textures\modif_company.paa"
            };
            tooltips[] = {"None",
                "Fireteam (~3-6 soldiers)",
                "Squad (~7-14 soldiers)",
                "Half Platoon (US Section) (~14-21 soldiers)",
                "Platoon (~22-50 soldiers)",
                "Company (~60-150 soldiers)"
            };
            values[] = {
                "",
                "x\tmf\addons\orbat\textures\modif_o.paa",
                "x\tmf\addons\orbat\textures\modif_dot.paa",
                "x\tmf\addons\orbat\textures\modif_2dot.paa",
                "x\tmf\addons\orbat\textures\modif_3dot.paa",
                "x\tmf\addons\orbat\textures\modif_company.paa"
            };

            onToolboxSelChanged = ""; // missionnamespace setVariable ['Rank_value',_this select 1];
        };

        class EditOrbatEntryOk : RscButtonMenu
        {
            idc = 118;
            text = "Ok";
            y = QUOTE(23.5 * SIZE_M * GRID_H);
            w = QUOTE(((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W / 6);
            x = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W / 6)*1.5 + SIZE_M * GRID_W);
            h = QUOTE(SIZE_M * GRID_H);
            action = "['editOrbatEntryClickOkay',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
        };
        class EditOrbatEntryCancel : EditOrbatEntryOk
        {
            idc = 119;
            text = "Cancel";
            x = QUOTE((((ATTRIBUTE_TITLE_W+ATTRIBUTE_CONTENT_W) - SIZE_M) * GRID_W / 6)*3.5 + SIZE_M * GRID_W);
            action = "['editOrbatEntryClickCancel',_this] call (uiNamespace getVariable 'ORBATSettings_script');";
        };

    };
};
