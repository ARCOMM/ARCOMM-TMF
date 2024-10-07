class GVAR(EntityTag): ctrlControlsGroupNoScrollbars
{
    idc = -1;
    x = QUOTE(0 * safezoneW + safezoneX);
    y = QUOTE(0 * safezoneH + safezoneY);
    w = QUOTE(0.08 * safezoneW);
    h = QUOTE(0.06 * safezoneH);
    onMouseZChanged = "[""MouseZChanged"",_this] call tmf_spectator_fnc_mouseHandler";
    onMouseButtonDown = "[""MouseButtonDown"",_this] call tmf_spectator_fnc_mouseHandler";
    onMouseButtonUp = "[""MouseButtonUp"",_this] call tmf_spectator_fnc_mouseHandler";
    onMouseMoving = "['MouseMoving',_this] call tmf_spectator_fnc_mouseHandler";
    class controls
    {
        class GVAR(back) : IGUIBACK {
            idc = 4;
            x = QUOTE(0.3 * safezoneW);
            y = 0;
            w = QUOTE(0.05 * safezoneW);
            h = QUOTE(0.06 * safezoneH);
            colorBackground[] = {0,0,0,0.0};
        };
        class GVAR(Icon): RscPicture
        {
            idc = 1;
            text = "\A3\ui_f\data\map\markers\military\triangle_CA.paa";
            x = 0;
            y = 0;
            w = QUOTE(0.08 * safezoneW);
            h = QUOTE(0.02 * safezoneH);
            style = QUOTE(48 + 2048 + 0x02); // picture + no stretch + center (not sure if works) + 0x800
            sizeEx == safeZoneH;
        };
        class GVAR(Name): RscText
        {
            idc = 2;
            text = ""; //--- ToDo: Localize;
            style = 0x02; // single + center align
            colorBackground[] = { 1, 1, 1, 0 };
            colorText[] = { 1, 1, 1, 1 };
            x = 0;
            y = QUOTE(0.02 * safezoneH);
            w = QUOTE(0.08 * safezoneW);
            h = QUOTE(0.02 * safezoneH);
            sizeEx = QUOTE(0.018 * safezoneH);
            shadow = 2;
        };
        class GVAR(Detail): GVAR(Name)
        {
            idc = 3;
            text = ""; //--- ToDo: Localize;
            x = 0;
            y = QUOTE(0.04 * safezoneH);
            w = QUOTE(0.08 * safezoneW);
            h = QUOTE(0.02 * safezoneH);
            sizeEx = QUOTE(0.013 * safezoneH);
        };
    };
};
class GVAR(GroupTag) : GVAR(EntityTag) {
    class controls
        {
            class GVAR(back) : IGUIBACK {
                idc = 4;
                x = QUOTE(0.3 * safezoneW);
                y = 0;
                w = QUOTE(0.05 * safezoneW);
                h = QUOTE(0.06 * safezoneH);
                colorBackground[] = {0,0,0,0.0};
            };
            class GVAR(Icon): RscPicture
            {
                idc = 1;
                text = "\A3\ui_f\data\map\markers\military\triangle_CA.paa";
                x = 0;
                y = 0;
                w = QUOTE(0.08 * safezoneW);
                h = QUOTE(0.035 * safezoneH);
                style = QUOTE(48 + 2048 + 0x02); // picture + no stretch + center (not sure if works) + 0x800
                sizeEx == safeZoneH;
            };
            class GVAR(Name): RscText
            {
                idc = 2;
                text = ""; //--- ToDo: Localize;
                style = 0x02; // single + center align
                colorBackground[] = { 1, 1, 1, 0 };
                colorText[] = { 1, 1, 1, 1 };
                x = 0;
                y = QUOTE(0.04 * safezoneH);
                w = QUOTE(0.08 * safezoneW);
                h = QUOTE(0.02 * safezoneH);
                sizeEx = QUOTE(0.018 * safezoneH);
                shadow = 2;
            };
            class GVAR(Detail): GVAR(Name)
            {
                idc = 3;
                text = ""; //--- ToDo: Localize;
                x = 0;
                y = 0.08 * safezoneH;
                w = QUOTE(0.08 * safezoneW);
                h = QUOTE(0.02 * safezoneH);
                sizeEx = QUOTE(0.013 * safezoneH);
            };
        };
};