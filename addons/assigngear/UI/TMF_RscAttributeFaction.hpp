class GVARMAIN(RscAttributeFaction): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE([ARR_3(_this,'GVARMAIN(RscAttributeFaction)','ADDON')] call (uinamespace getvariable 'BIS_fnc_initCuratorAttribute'));
    idc = IDC_RSCATTRIBUTEFACTION_RSCATTRIBUTEFACTION;
    x = QUOTE(7 * GUI_GRID_W + GUI_GRID_X);
    y = QUOTE(10 * GUI_GRID_H + GUI_GRID_Y);
    w = QUOTE(26 * GUI_GRID_W);
    h = GUI_GRID_H;
    class controls {
        class Title: RscText {
            idc = IDC_RSCATTRIBUTEFACTION_TITLE;
            text = "Faction";
            x = QUOTE(0 * GUI_GRID_W);
            y = QUOTE(0 * GUI_GRID_H);
            w = QUOTE(10 * GUI_GRID_W);
            h = GUI_GRID_H;
            colorBackground[] = GUI_TEXT_SHADOW;
        };
        class Faction: RscCombo {
            font = GUI_FONT_MONO;
            idc = IDC_RSCATTRIBUTEFACTION_COMBO;
            x = QUOTE(10 * GUI_GRID_W);
            y = QUOTE(0 * GUI_GRID_H);
            w = QUOTE(16 * GUI_GRID_W);
            h = GUI_GRID_H;
            sizeEx = GUI_TEXT_SIZE_SMALL;
        };
    };
};
