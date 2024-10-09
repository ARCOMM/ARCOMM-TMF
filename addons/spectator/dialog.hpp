
class RscText;
class RscMapControl;
class RscTree;
class RscControlsGroup;
class IGUIBack;
class RscButtonMenuOK;
class RscTitle;
class RscStructuredText;
class RscDebugConsole;
class RscPicture;
class RscXSliderH;
class ctrlControlsGroupNoScrollbars;
class RscControlsGroupNoScrollbars;

class RscSpectatorText : RscText {
    type = 0;
    style = 0x02;
    shadow = 1;
};
class RscSpectatorShortcutButton : RscPicture {
    type = 1;
    shadow = 0;
    colorBorder[] = {0,0,0,1};
    borderSize = 0;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    colorText[] = {1,1,1,1};
    colorFocused[] = {1,1,1,1};
    colorShadow[] = {1,1,1,1};
    colorDisabled[] = {0,0,0,1};
    colorBackground[] = {0,0,0,1};
    colorBackgroundDisabled[] = {0,0,0,1};
    colorBackgroundActive[] = {0,0,0,1};

    soundEnter[] = { "", 0, 1 };  // no sound
    soundPush[] = { "buttonpushed.ogg", 0.1, 1 };
    soundClick[] = { "", 0, 1 };  // no sound
    soundEscape[] = { "", 0, 1 };  // no sound
};

//--- Spectator
#define BUTTON_WIDTH 0.02 * safeZoneW
#define BUTTON_HEIGHT 0.031 * safeZoneH
#define COLUMN(V) (0.002 * safeZoneW + safeZoneX)+((0.0215 * safeZoneW)  * V)

class GVAR(dialog)
{
  idd = DISPLAY_ID;
  movingEnable = 1;
  enableSimulation = 1;
  enableDisplay = 1;
  fadein = 0;
  fadeout = 0;
  duration = 2147483647;
  type = 0;
  controlsBackground[] = {"TMF_SPECTATOR_MOUSE","TMF_SPECTATOR_UNITLABEL","TMF_SPECTATOR_Compass","TMF_SPECTATOR_CompassLeft","TMF_SPECTATOR_CompassRight"};
  onKeyDown = "[0,_this] call tmf_spectator_fnc_keyhandler";
  onKeyUp= "[1,_this] call tmf_spectator_fnc_keyhandler";
  onLoad = "_this call tmf_spectator_fnc_onLoad";
  onUnload = "TMF_spectator_camera cameraEffect ['TERMINATE','BACK']";
  class TMF_SPECTATOR_UNITLABEL: RscSpectatorText {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_UNITLABEL;
    text = ""; //--- ToDo: Localize;
    x = QUOTE((0.50-0.15/2) * safeZoneW + safeZoneX);
    y = QUOTE(0.025 * safeZoneH + safeZoneY);
    w = QUOTE(0.15 * safeZoneW);
    h = QUOTE(0.020 * safeZoneH);
    font = "PuristaSemiBold";
  };
  class TMF_SPECTATOR_Compass: RscSpectatorText {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASS;
    text = "NW"; //--- ToDo: Localize;
    x = QUOTE((0.5-(0.07/2)) * safeZoneW + safeZoneX);
    y = QUOTE(0.005* safeZoneH + safeZoneY);
    w = QUOTE(0.07 * safeZoneW);
    h = QUOTE(0.015 * safeZoneH);
    font = "PuristaBold";
  };
  class TMF_SPECTATOR_CompassLeft: RscSpectatorText {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASSLEFT;
    text = "NW"; //--- ToDo: Localize;
    x = QUOTE((0.5-(0.14)/2) * safeZoneW + safeZoneX);
    y = QUOTE(0.005 * safeZoneH + safeZoneY);
    w = QUOTE(0.07 * safeZoneW);
    h = QUOTE(0.015 * safeZoneH);
    SizeEx = "(((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 0.65)";
    colorText[] ={1,1,1,0.7};
    font = "PuristaBold";
  };
  class TMF_SPECTATOR_CompassRight: RscSpectatorText {
    idc = IDC_SPECTATOR_TMF_SPECTATOR_COMPASSRight;
    text = "NE"; //--- ToDo: Localize;
    x = QUOTE((0.5) * safeZoneW + safeZoneX);
    y = QUOTE(0.005 * safeZoneH + safeZoneY);
    w = QUOTE(0.07 * safeZoneW);
    h = QUOTE(0.015 * safeZoneH);
    SizeEx = "(((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 0.65)";
    colorText[] ={1,1,1,0.7};
    font = "PuristaBold";
  };
  class controls {
    class TMF_SPECTATOR_FILTER: RscSpectatorShortcutButton {
        idc = IDC_SPECTATOR_TMF_SPECTATOR_FILTER;
        x = QUOTE(COLUMN(1));
        y = QUOTE(0.002 * safeZoneH + safeZoneY);
        w = QUOTE(BUTTON_WIDTH);
        h = QUOTE(BUTTON_HEIGHT);
        onButtonDown = "['disableAI',_this] call tmf_spectator_fnc_menuhandler;";
        text = "\A3\ui_f\data\gui\Rsc\RscDisplayMultiplayerSetup\enabledai_ca.paa";
        tooltip = "PLAYERS + AI";
    };
    class TMF_SPECTATOR_BUTTON: RscSpectatorShortcutButton {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_BUTTON;
      x = QUOTE(COLUMN(0));
      y = QUOTE(0.002 * safeZoneH + safeZoneY);
      w = QUOTE(BUTTON_WIDTH);
      h = QUOTE(BUTTON_HEIGHT);
      text = "\x\tmf\addons\spectator\images\flag_civil_empty_ca_64.paa";
      onButtonDown = "['sidefilter',_this] call tmf_spectator_fnc_menuhandler;";
      tooltip = "SHOWING ALL SIDES";
    };
    class TMF_SPECTATOR_TAGS: RscSpectatorShortcutButton {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_TAGS;
      x = QUOTE(COLUMN(3));
      y = QUOTE(0.002 * safeZoneH + safeZoneY);
      w = QUOTE(BUTTON_WIDTH);
      h = QUOTE(BUTTON_HEIGHT);
      text = "\A3\ui_f\data\map\Diary\textures_ca.paa";
      onButtonDown = "['tags',_this] call tmf_spectator_fnc_menuhandler;";
      tooltip = "DISABLE TAGS";
    };
    class TMF_SPECTATOR_VISION: RscSpectatorShortcutButton {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_VISION;
      x = QUOTE(COLUMN(4));
      y = QUOTE(0.002 * safeZoneH + safeZoneY);
      w = QUOTE(BUTTON_WIDTH);
      h = QUOTE(BUTTON_HEIGHT);
      onButtonDown = "['vision',_this] call tmf_spectator_fnc_menuhandler;";
      text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\nvgs_ca.paa";
      tooltip = "CHANGE VISION MODE";
    };
    class TMF_SPECTATOR_VIEW: RscSpectatorShortcutButton {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_VIEW;
      onButtonDown = "['camera',_this] call tmf_spectator_fnc_menuhandler;";
      x = QUOTE(COLUMN(2));
      y = QUOTE(0.002 * safeZoneH + safeZoneY);
      w = QUOTE(BUTTON_WIDTH);
      h = QUOTE(BUTTON_HEIGHT);
      text = "\A3\ui_f\data\IGUI\Cfg\IslandMap\iconcamera_ca.paa";
      tooltip = "SWITCH TO FIRST PERSON";
    };
    class TMF_SPECTATOR_MUTE: RscSpectatorShortcutButton {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_MUTE;
      onButtonDown = "['mute',_this] call tmf_spectator_fnc_menuhandler;";
      x = QUOTE(COLUMN(5));
      y = QUOTE(0.002 * safeZoneH + safeZoneY);
      w = QUOTE(BUTTON_WIDTH);
      h = QUOTE(BUTTON_HEIGHT);
      text = "\A3\ui_f\data\gui\Rsc\RscDisplayArsenal\voice_ca.paa";
      tooltip = "MUTE SPECTATORS";
    };
    class TMF_SPECTATOR_RADIO: RscSpectatorShortcutButton {
        idc = IDC_SPECTATOR_TMF_SPECTATOR_RADIO;
        onButtonDown = QUOTE([ARR_2('radio',_this)] call FUNC(menuhandler));
        x = QUOTE(COLUMN(6));
        y = QUOTE(0.002 * safeZoneH + safeZoneY);
        w = QUOTE(BUTTON_WIDTH);
        h = QUOTE(BUTTON_HEIGHT);
        text = "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\call_ca.paa";
        tooltip = "SHOW RADIO MENU";
    };
    class TMF_SPECTATOR_MAP : RscMapControl {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_MAP;
      x = QUOTE(0 * safeZoneW + safeZoneX);
      y = QUOTE(0 * safeZoneH + safeZoneY);
      w = QUOTE(1 * safeZoneW);
      h = QUOTE(1 * safeZoneH);
      onDraw = "_this call tmf_spectator_fnc_drawMap";
      onMouseButtonDown = "_this call tmf_spectator_fnc_onMapClick;";
    };
    class TMF_SPECTATOR_UNITLIST: RscTree {
      idc = IDC_SPECTATOR_TMF_SPECTATOR_UNITLIST;
      x = QUOTE(0.002 * safeZoneW + safeZoneX);
      y = QUOTE(0.038 * safeZoneH + safeZoneY);
      w = QUOTE(0.13 * safeZoneW);
      h = QUOTE(0.940001 * safeZoneH);
      shadow = 2;
      colorBackground[] = {0,0,0,0};
      disableKeyboardSearch = 1;
      colorSelectText[] = {1,1,1,1}; // Selected text color (when multiselectEnabled is 0)
      onTreeSelChanged = "_this call tmf_spectator_fnc_onChange";
      multiselectEnabled = 0;
      //onMouseZChanged = "[""MouseZChanged"",_this] call tmf_spectator_fnc_mouseHandler";
      // Scrollbar configuration
      class ScrollBar {
        width = 0;
        height = 0;
        scrollSpeed = 0.01;

        arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
        arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
        border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";

        color[] = {1,1,1,0}; // Scrollbar color
      };
      maxHistoryDelay = 9999999; // Time since last keyboard type search to reset it
    };
    class TMF_SPECTATOR_KILLLIST : RscControlsGroupNoScrollbars {
        idc = 2300;
        x = QUOTE(0.763544 * safeZoneW + safeZoneX);
        y = QUOTE(0.005 * safeZoneH + safeZoneY);
        w = QUOTE(0.233576 * safeZoneW);
        h = QUOTE((0.020*6.5) * safeZoneH);
        style = 16;
        action = "";
        colorBackground[] = {1,0,0,1};
        onMouseButtonDown = "true";
        onMouseButtonUp = "true";
        class controls {
            class dummy : RscText {
                // REQUIRED
                idc = -1;
                x = QUOTE(0.0 * safeZoneW);
                y = QUOTE(-5.0 * safeZoneH);
            };
            class Label1: RscStructuredText {
                idc = 6;
                action = "";
                x = QUOTE(0.00352533 * safeZoneW);
                y = QUOTE(0.0 * safeZoneH);
                w = QUOTE(0.230 * safeZoneW);
                h = QUOTE(0.020 * safeZoneH);
                colorBackground[] = {0,0,0,0.0};
                text = "";
                style = 0x01;
                class Attributes {
                    align = "right";
                    valign = "middle";
                };
            };
            class Label2: Label1 {
                idc = 7;
                x = QUOTE(0.00352533 * safeZoneW);
                y = QUOTE((0.020*1) * safeZoneH);
                w = QUOTE(0.230 * safeZoneW);
                h = QUOTE(0.020 * safeZoneH);
                colorBackground[] = {0,0,0,0.0};
                action = "";
            };
            class Label3: Label1 {
                idc = 8;
                x = QUOTE(0.00352533 * safeZoneW);
                y = QUOTE((0.020*2) * safeZoneH);
                w = QUOTE(0.230 * safeZoneW);
                h = QUOTE(0.020 * safeZoneH);
                colorBackground[] = {0,0,0,0.0};
                action = "";
            };
            class Label4: Label1 {
                idc = 9;
                x = QUOTE(0.00352533 * safeZoneW);
                y = QUOTE((0.020*3) * safeZoneH);
                w = QUOTE(0.230 * safeZoneW);
                h = QUOTE(0.020 * safeZoneH);
                colorBackground[] = {0,0,0,0.0};
                action = "";
            };
            class Label5: Label1 {
                idc = 10;
                x = QUOTE(0.00352533 * safeZoneW);
                y = QUOTE((0.020*4) * safeZoneH);
                w = QUOTE(0.230 * safeZoneW);
                h = QUOTE(0.020 * safeZoneH);
                colorBackground[] = {0,0,0,0.0};
                action = "";
            };
            class Label6: Label1 {
                idc = 11;
                x = QUOTE(0.00352533 * safeZoneW);
                y = QUOTE((0.020*5) * safeZoneH);
                w = QUOTE(0.230 * safeZoneW);
                h = QUOTE(0.020 * safeZoneH);
                colorBackground[] = {0,0,0,0.0};
                action = "";
            };
        };
    };
  };
  class TMF_SPECTATOR_MOUSE: RscControlsGroup {
    class ListScrollBar {
        color[] = {1,1,1,0.6};
        colorActive[] = {1,1,1,1};
        colorDisabled[] = {1,1,1,0.0};
        thumb = "";
        arrowFull = "";
        arrowEmpty = "";
        border = "";
    };
    onMouseButtonDown = "[""MouseButtonDown"",_this] call tmf_spectator_fnc_mouseHandler";
    onMouseButtonUp = "[""MouseButtonUp"",_this] call tmf_spectator_fnc_mouseHandler";
    onMouseZChanged = "[""MouseZChanged"",_this] call tmf_spectator_fnc_mouseHandler";
    onMouseMoving = "['MouseMoving',_this] call tmf_spectator_fnc_mouseHandler";
    idc = 123;
    x = QUOTE(safeZoneX);
    y = QUOTE(safeZoneY);
    w = QUOTE(safeZoneW);
    h = QUOTE(safeZoneH);
    colorBackground[] = {0.2, 0.0, 0.0, 0.0};
  };
};
