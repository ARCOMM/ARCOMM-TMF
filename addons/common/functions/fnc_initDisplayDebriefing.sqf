// Updates the text on the end mission screen.

#include "\x\tmf\addons\common\script_component.hpp"
disableSerialization;
params ["_display"];

if (!isNil QGVAR(EndMissionText)) then {
    [{
        disableSerialization;
        params ["_display"];
        GVAR(EndMissionText) params [["_titleText",""],["_subtitleText",""]];
        private _titleCtrl = _display displayCtrl 20600;
        private _subtitleCtrl = _display displayCtrl 20601;
        _titleCtrl ctrlSetText toUpper _titleText;

        if (_subtitleText != "") then {
            if (ctrlText _subtitleCtrl == "") then {
                // If Hidden we need to emulate the effect.
                private _subtitlePosFinal = ctrlPosition _subtitleCtrl;
                private _subtitlePosStart = +_subtitlePosFinal;
                _subtitlePosStart set [0,(_subtitlePosStart select 0) + (_subtitlePosStart select 2) / 2];
                _subtitlePosStart set [2,0];
                _subtitleCtrl ctrlSetPosition _subtitlePosStart;
                _subtitleCtrl ctrlSetFade 0;
                _subtitleCtrl ctrlCommit 0;
                _subtitleCtrl ctrlShow false;
                [_subtitleCtrl,_subtitlePosFinal] spawn {
                    disableSerialization;
                    params ["_subtitleCtrl","_subtitlePosFinal"];
                    sleep 2;
                    _subtitleCtrl ctrlShow true;
                    _subtitleCtrl ctrlSetPosition _subtitlePosFinal;
                    _subtitleCtrl ctrlCommit 0.4;
                };
            };
            // Update the text.
            _subtitleCtrl ctrlSetText toUpper _subtitleText;
        } else {
            _subtitleCtrl ctrlSetFade 1;
            _subtitleCtrl ctrlCommit 0;
            _subtitleCtrl ctrlShow false;
        };
    }, [_display]] call CBA_fnc_execNextFrame;
};
