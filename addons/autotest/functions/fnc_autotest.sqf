#include "\x\tmf\addons\autotest\script_component.hpp"

private _ctrlListbox = (_this controlsGroupCtrl 101);
_ctrlListbox lnbSetColumnsPos [0,0.05];

private _output = [];

// Process the Config based auto-tests.
{
    private _test = _x;
    LOG_1("Running test: %1",configName _x);
    private _code = getText (_test >> "code");

    private _outputTest = call compile _code;
    if (_outputTest isEqualType []) then {
        if (GVAR(outputToRPT) && {_output isNotEqualTo []}) then {
            {
                if (count _x > 0 && {_x select 0 in [AUTOTEST_PASS, AUTOTEST_ERROR, AUTOTEST_WARNING, AUTOTEST_MULTILINE]}) then {
                    
                    INFO(str (_x select 1));
                } else {
                    INFO(str _x);
                };
            } forEach _outputTest
        };
        _output append _outputTest;
        TRACE_2("Appending to output",_output,_outputTest);
    };
} forEach ("true" configClasses (configFile >> 'ADDON'));


// Display them on the auto-test UI page in Eden.
{
    _x params ["_type","_message"];
    _lnbAdd = _ctrlListbox lnbAddRow ["",_message];

    if (_type == 0) then { // Cross
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],QPATHTOEF(briefing,UI\plus_small_ca.paa)];
    };
    if (_type == -1) then { // Tick
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],QPATHTOEF(briefing,UI\check_small_ca.paa)];
    };
    if (_type == 1) then { //Warning
        _ctrlListbox lnbSetPicture [[_lnbAdd,0],QPATHTOEF(autotest,UI\warning.paa)];
    };

    //Multiline, no icon so no need to actually set a picture for now.
    /*
    if (_type == 10) then {
    };
    */
} forEach _output;
