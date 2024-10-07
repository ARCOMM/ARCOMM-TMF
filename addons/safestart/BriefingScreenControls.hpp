class GVAR(safeStartText) : RscText
{
    idc = -1;
    text = ""; //--- ToDo: Localize;
    x = QUOTE((0.50-0.5/2) * safezoneW + safezoneX);
    y = QUOTE(safezoneY);
    w = QUOTE(0.5 * safezoneW);
    h = QUOTE(0.05 * safezoneH);
    style = 0x02;
    SizeEx = QUOTE((((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 2));
    colorText[] = {1,1,1,1};
    shadow = 2;
    font = "PuristaBold";

    onLoad = QUOTE(_this call FUNC(briefingText));
};
