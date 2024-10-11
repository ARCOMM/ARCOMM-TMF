params ["_mode",["_params",[]]];

// with uiNamespace do { RadioChannels_script = compile preprocessFileLineNumbers "RadioChannels.sqf"; };  with uiNamespace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNamespace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };

//with uiNamespace do { BabelSettings_script = compile preprocessFileLineNumbers "BabelSettings.sqf"; };  with uiNamespace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };
// with uiNamespace do { AcreAddRadioActions_script = compile preprocessFileLineNumbers "AcreAddRadioActions.sqf"; };

#define ACRE_RADIO_CLASSNAME_ARRAY ["ACRE_PRC343","ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F","ACRE_PRC77","ACRE_SEM52SL"]

switch _mode do {
    case "onLoad": {
        //Add EH On touch

        _ctrlGroup = _params select 0;
        AcreAddRadioActions_ctrlGroup = _ctrlGroup;

        _ctrlGroup ctrlAddEventHandler ["SetFocus",{with uiNamespace do {AcreAddRadioActions_ctrlGroup = _this select 0;};}];
        _ctrlGroup ctrlAddEventHandler ["KillFocus",{with uiNamespace do {AcreAddRadioActions_ctrlGroup = nil;};}];

        _ctrlList = _ctrlGroup controlsGroupCtrl 101;
        _ctrlList ctrlAddEventHandler ["LBDblClick",{with uiNamespace do {["listModify",[ctrlParentControlsGroup (_this select 0),+1],objNull] call AcreAddRadioActions_script;};}];

        TMF_AcreAddRadioActions_Array = ("TMF_MissionAcre2Attributes" get3DENMissionAttribute "TMF_AcreAddRadioActions");
        if (TMF_AcreAddRadioActions_Array isEqualType "") then {
            TMF_AcreAddRadioActions_Array = call compile TMF_AcreAddRadioActions_Array;
        };

        lnbClear _ctrlList;
        _ctrlList lnbSetColumnsPos [0.1,0.2];
        {
            _weaponCfg = configFile >> "cfgWeapons" >> _x;
            _displayName = getText (_weaponCfg >> "displayName");
            _picture = getText (_weaponCfg >> "picture");
            _description = getText (_weaponCfg >> "descriptionShort");
            _lnbAdd = _ctrlList lnbAddRow ["",_displayName];
            _ctrlList lnbSetData [[_lnbAdd,0],_x];
            _ctrlList lnbSetPicture [[_lnbAdd,0],_picture];
            _alpha = [0.5, 1] select (_x in TMF_AcreAddRadioActions_Array);
            _ctrlList lnbSetColor [[_lnbAdd,1],[1,1,1,_alpha]];
        } forEach ACRE_RADIO_CLASSNAME_ARRAY;
    };
    case "attributeSave": {
        str (uiNamespace getVariable "TMF_AcreAddRadioActions_Array")
    };
    case "listModify": {
        private _ctrlList = AcreAddRadioActions_ctrlGroup controlsGroupCtrl 101;
        private _curSel = lnbCurSelRow _ctrlList;
        private _radio = (_ctrlList lnbData [_curSel,0]);

        if (_radio in TMF_AcreAddRadioActions_Array) then {
            TMF_AcreAddRadioActions_Array = TMF_AcreAddRadioActions_Array - [_radio];
        } else {
            TMF_AcreAddRadioActions_Array pushBackUnique _radio;
        };
        lnbClear _ctrlList;
        _ctrlList lnbSetColumnsPos [0.1,0.2];
        {
            _weaponCfg = configFile >> "cfgWeapons" >> _x;
            _displayName = getText (_weaponCfg >> "displayName");
            _picture = getText (_weaponCfg >> "picture");
            _description = getText (_weaponCfg >> "descriptionShort");
            _lnbAdd = _ctrlList lnbAddRow ["",_displayName];
            _ctrlList lnbSetData [[_lnbAdd,0],_x];
            _ctrlList lnbSetPicture [[_lnbAdd,0],_picture];
            _alpha = [0.5, 1] select (_x in TMF_AcreAddRadioActions_Array);
            _ctrlList lnbSetColor [[_lnbAdd,1],[1,1,1,_alpha]];
        } forEach ACRE_RADIO_CLASSNAME_ARRAY;
    };
    case "attributeLoad": {
    };
};
