#include "\A3\ui_f\hpp\defineCommonGrids.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

#include "\a3\ui_f\scripts\gui\RscDebugConsole.sqf"
#include "\a3\ui_f\scripts\gui\RscFeedback.sqf"

switch _mode do {

	case "onLoad": {
		_display = _params select 0;
		
		//if( getNumber(configFile >> "isDemo") != 1 ) then //test
		//{
			//--- E3 - Back to Hub button
			if (getNumber (missionConfigFile >> "replaceAbortButton") > 0) then
			{				
				//Maxwell button ON - move all buttons except Abort up ---------------------------------------
				//Title background
				_control = _display displayCtrl 1050;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (13.1 * GUI_GRID_H + GUI_GRID_Y)];																												
				_control ctrlCommit 0;
				
				//Title - same position as title background
				_control = _display displayCtrl 523;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (13.1 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Player's name - same position as title background
				_control = _display displayCtrl 109;
				_control ctrlSetPosition [(6 * GUI_GRID_W + GUI_GRID_X), (13.1 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Continue button
				_control = _display displayCtrl 2;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (14.2 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Save button
				_control = _display displayCtrl 103;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (15.3 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Skip button - same position as Save
				_control = _display displayCtrl 1002;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (15.3 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Revert
				_control = _display displayCtrl 119;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (16.4 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Again - same position as Revert
				_control = _display displayCtrl 1003;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (16.4 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Options button
				_control = _display displayCtrl 101;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (17.5 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				
				//Field Manual button
				_control = _display displayCtrl 122;
				_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), (18.6 * GUI_GRID_H + GUI_GRID_Y)];																													
				_control ctrlCommit 0;
				//Maxwell button ON - move all buttons except Abort up ---------------------------------------
				
				//Enable Maxwell button
				_buttonBack = _display displayCtrl 2408;
				_buttonBack ctrlenable true;
				_buttonBack ctrlsetfade 0;
				_buttonBack ctrlCommit 0;	
			}
			else
			{
				_buttonBack = _display displayCtrl 2408;
				_buttonBack ctrlenable false;
				_buttonBack ctrlsetfade 1;
				_buttonBack ctrlCommit 0;
			};
		//};
		
		_control = _display displayCtrl 104; //Abort/Suspend button (text is changed from code according to enabled/disabled save)
		if !(isnull finddisplay 313) then {
			_control ctrlSetText toupper localize "STR_3DEN_RscDisplayInterrupt_ButtonAbort_3DEN_text";
			_control ctrlSetTooltip localize "STR_3DEN_RscDisplayInterrupt_ButtonAbort_3DEN_tooltip";
		} else {
			if (str campaignconfigFile == "") then
			{
				//non campaign mission
				if (savingEnabled) then
				{
					_control ctrlSetTooltip (localize "STR_TOOLTIP_MAIN_SUSPEND");
				}
				else
				{
					_control ctrlSetTooltip (localize "STR_TOOLTIP_MAIN_ABORT");
				};
			}
			else
			{
				//campaign mission
				if (savingEnabled) then
				{
					_control ctrlSetTooltip (localize "STR_TOOLTIP_MAIN_SUSPEND_CAMPAIGN");
				}
				else
				{
					_control ctrlSetTooltip (localize "STR_TOOLTIP_MAIN_ABORT_CAMPAIGN");
				};
			};
		};

		//--- set player's name
		(_display displayCtrl 109) ctrlSetText profileName;
		[_display, 109] call (uiNamespace getVariable 'BIS_fnc_setIDCStreamFriendly');
		
		//Title
		_control = _display displayCtrl 523;
		_control ctrlSetText (toUpper (ctrlText _control));
		
		//--- toUpper all button texts
		//Continue
		// _control = _display displayCtrl 2;
		// _control ctrlSetText (toUpper (ctrlText _control));
		//Save
		// _control = _display displayCtrl 103;
		// _control ctrlSetText (toUpper (ctrlText _control));
		//Skip
		// _control = _display displayCtrl 1002;
		// _control ctrlSetText (toUpper (ctrlText _control));
		//Revert
		// _control = _display displayCtrl 119;
		// _control ctrlSetText (toUpper (ctrlText _control));
		//Again
		// _control = _display displayCtrl 1003;
		// _control ctrlSetText (toUpper (ctrlText _control));
		//Options
		// _control = _display displayCtrl 101;
		// _control ctrlSetText (toUpper (ctrlText _control));
		//Abort
		// _control = _display displayCtrl 104;
		// _control ctrlSetText (toUpper (ctrlText _control));
		
		
		//Sets all texts toUpper - TEST - switched off
		
		// _classInsideControls = configFile >> "RscDisplayInterrupt" >> "controls";
			
		// for "_i" from 0 to (count _classInsideControls - 1) do {   //go to all subclasses
			// _current = _classInsideControls select _i;
			// if ( (isclass _current) && ( configName(_current) != "PlayersName") ) then { //do not toUpper Player's name
			
				///search inside main controls class
				// _idc = getNumber (_current >> "idc");
				// _control = _display displayCtrl _idc;
				// _control ctrlSetText (toUpper (ctrlText _control));
				
			// };
		// };
		
		// if( getNumber(configFile >> "isDemo") == 1 ) then
		// {
			// uiNamespace setVariable ["BIS_isCheatOptions", false];
			
			// //disable options
			// if(profileNamespace getVariable ["BIS_E3", false]) then
			// {
				// (_display displayCtrl 101) ctrlEnable false;	//Options
			// }
		// };
		
		//Variable for tracking state of Options accordion (expanded/collapsed)
		uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", false];
		
		//--- Options button
		_button = _display displayCtrl 101;
		_button ctrlAddEventHandler ["ButtonClick","with uiNamespace do {['optionsButton',_this,''] spawn RscDisplayInterrupt_script};"];
		
		//TODO - implementovat promennou, ktera si bude pamatovat stav akordeonu (je potreba pri navratu z jineho dialogu do main menu)			
		(_display displayCtrl 301) ctrlSetFade 1;	//Video
		(_display displayCtrl 302) ctrlSetFade 1;	//Audio
		(_display displayCtrl 303) ctrlSetFade 1;	//Controls
		(_display displayCtrl 307) ctrlSetFade 1;	//Game Options
		
		(_display displayCtrl 301) ctrlCommit 0;
		(_display displayCtrl 302) ctrlCommit 0;
		(_display displayCtrl 303) ctrlCommit 0;
		(_display displayCtrl 307) ctrlCommit 0;
		
		//--- Hide all buttons from Options - must be here to enable proper focusing
		(_display displayCtrl 301) ctrlEnable false;	//Video
		(_display displayCtrl 302) ctrlEnable false;	//Audio
		(_display displayCtrl 303) ctrlEnable false;	//Controls
		(_display displayCtrl 307) ctrlEnable false;	//Game Options
		
		_versionCtrl = _display displayCtrl 1005;
		_trafficLightCtrl = _display displayCtrl 121;
		[_versionCtrl, _trafficLightCtrl] call bis_fnc_versionInfo;

		//--- Splendid camera
		if (!isNil {missionnamespace getVariable  "bis_fnc_camera_cam"}) then {
			{(_display displayCtrl _x) ctrlenable false;} forEach [103,119];
		};

		[_params,'onload'] call compile preprocessFile '\A3\ui_f\scripts\pauseCutScene.sqf';
		[] call compile preprocessFile '\A3\ui_f\scripts\uiPostEffectBlur.sqf';
		['Init', _params] call compile preprocessFileLineNumbers  '\A3\ui_f\scripts\pauseLoadinit.sqf';
		
		with missionNamespace do { [missionNamespace, "OnGameInterrupt", _params] call BIS_fnc_callScriptedEventHandler };
	};
	
	
	
	//--- Options button
	case "optionsButton": {

		_ctrl = _params select 0;
		_display = ctrlparent _ctrl;
		
		_offset = 0;
		if (getNumber (missionConfigFile >> "replaceAbortButton") > 0) then  //MUF-test-removed: (getNumber(configFile >> "isDemo") != 1) &&
		{
			_offset = 1.1;
		};
		
		//if options are expanded (Video Options button is shown), collapse it and vice versa
		//if(ctrlFade (_display displayCtrl 301) < 0.5) then
		_upperPartTime = 0.2; //0.05 for each button
		_buttonsTime = 0.05;
		
		//hide buttons and collapse accordion
		if(uiNamespace getVariable "BIS_DisplayInterrupt_isOptionsExpanded") then
		{
			//move down - background, title, player's name, play, editor, profile, options
			
			//Title background
			_control = _display displayCtrl 1050;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Title - same position as title background
			_control = _display displayCtrl 523;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Player's name - same position as title background
			_control = _display displayCtrl 109;
			_control ctrlSetPosition [(6 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Continue button
			_control = _display displayCtrl 2;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((15.3 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Save button
			_control = _display displayCtrl 103;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((16.4 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Skip button - same position as Save
			_control = _display displayCtrl 1002;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((16.4 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Revert
			_control = _display displayCtrl 119;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Again - same position as Revert
			_control = _display displayCtrl 1003;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Options button
			_control = _display displayCtrl 101;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((18.6 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			

			(_display displayCtrl 301) ctrlSetFade 1;		//Video
			(_display displayCtrl 302) ctrlSetFade 1;		//Audio
			(_display displayCtrl 303) ctrlSetFade 1;		//Controls
			(_display displayCtrl 307) ctrlSetFade 1;		//Game Options
			
			(_display displayCtrl 301) ctrlCommit _buttonsTime;	//Video
			uiSleep _buttonsTime;
			(_display displayCtrl 302) ctrlCommit _buttonsTime;	//Audio
			uiSleep _buttonsTime;
			(_display displayCtrl 303) ctrlCommit _buttonsTime;	//Controls
			uiSleep _buttonsTime;
			(_display displayCtrl 307) ctrlCommit _buttonsTime;	//Game
			
			(_display displayCtrl 301) ctrlEnable false;		//Video
			(_display displayCtrl 302) ctrlEnable false;		//Audio
			(_display displayCtrl 303) ctrlEnable false;		//Controls
			(_display displayCtrl 307) ctrlEnable false;		//Game Options
			
			
			uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", false];
			//set focus to Options button
			ctrlSetFocus (_display displayCtrl 101);	
		}
		else
		{
			//expand accordion and show buttons
				
			//Title background
			_control = _display displayCtrl 1050;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Title - same position as title background
			_control = _display displayCtrl 523;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Player's name - same position as title background
			_control = _display displayCtrl 109;
			_control ctrlSetPosition [(6 * GUI_GRID_W + GUI_GRID_X), ((9.8 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Continue button
			_control = _display displayCtrl 2;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((10.9 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Save button
			_control = _display displayCtrl 103;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((12.0 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Skip button - same position as Save
			_control = _display displayCtrl 1002;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((12.0 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Revert
			_control = _display displayCtrl 119;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((13.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Again - same position as Revert
			_control = _display displayCtrl 1003;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((13.1 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																													
			_control ctrlCommit _upperPartTime;
			
			//Options button
			_control = _display displayCtrl 101;
			_control ctrlSetPosition [(1 * GUI_GRID_W + GUI_GRID_X), ((14.2 - _offset) * GUI_GRID_H + GUI_GRID_Y)];																												
			_control ctrlCommit _upperPartTime;
			
			if (getNumber (missionConfigFile >> "replaceAbortButton") > 0) then
			{
				//Video button
				_control = _display displayCtrl 301;
				_control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((15.3 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
				
				//Audio button
				_control = _display displayCtrl 302;
				_control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((16.4 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
				
				//Controls button
				_control = _display displayCtrl 303;
				_control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((17.5 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
				
				//Game button
				_control = _display displayCtrl 307;
				_control ctrlSetPosition [(2 * GUI_GRID_W + GUI_GRID_X), ((18.6 - _offset) * GUI_GRID_H + GUI_GRID_Y)];
			};

			//Enable and show buttons
			(_display displayCtrl 301) ctrlEnable true;	//Video
			(_display displayCtrl 302) ctrlEnable true;	//Audio
			(_display displayCtrl 303) ctrlEnable true;	//Controls
			(_display displayCtrl 307) ctrlEnable true;	//Game Options
			
			//--- Show all buttons from Options
			(_display displayCtrl 301) ctrlSetFade 0;	//Video
			(_display displayCtrl 302) ctrlSetFade 0;	//Audio
			(_display displayCtrl 303) ctrlSetFade 0;	//Controls
			(_display displayCtrl 307) ctrlSetFade 0;	//Game Options
			
			uiSleep 0.05;
			
			//From bottom to top
			(_display displayCtrl 307) ctrlCommit 0.15;	//Game
			uiSleep _buttonsTime;
			(_display displayCtrl 303) ctrlCommit 0.15;	//Controls
			uiSleep _buttonsTime;
			(_display displayCtrl 302) ctrlCommit 0.15;	//Audio
			uiSleep _buttonsTime;
			(_display displayCtrl 301) ctrlCommit 0.15;	//Video
			
			uiNamespace setVariable ["BIS_DisplayInterrupt_isOptionsExpanded", true];
			//set focus to Options button
			ctrlSetFocus (_display displayCtrl 101);
		};
	};


	case "onUnload": {
		private ["_dummy"];
		_dummy = ['Unload', _params] call compile preprocessFile '\A3\ui_f\scripts\pauseOnUnload.sqf';
		_dummy = [_params,'unload'] call compile preprocessFile '\A3\ui_f\scripts\pauseCutScene.sqf';
	};

	case "KeyDown": {
		_display = _params select 0;
		_key = _params select 1;
		
		switch (_key) do {

			//--- F1 (open community debug console)
			case 59: {
				_display closedisplay 2;
				createdialog 'RscDisplayDebugPublic';
			};

			//--- H (Hide all elements and leave only effects overlay)
			case 35: {
				if (distributionregion == 0) then {
					_fade = ctrlfade (_display displayCtrl 2);
					_fade = round (_fade + 1) % 2;
					{
						if (_x < 100000) then {
							(_display displayCtrl _x) ctrlsetfade _fade;
							(_display displayCtrl _x) ctrlCommit 0.2;
						};
					} forEach ([configFile >> "RscDisplayInterrupt",0] call bis_fnc_displayControls);	
				};
			};
		};
		
		//Normal Interrupt uses accordion, so cheat has no sense there.
		// if( getNumber(configFile >> "isDemo") == 1 ) then
		// {
			// _shift = _params select 2;
			// _ctrl = _params select 3;
			// _alt = _params select 4;
		
		
			// if (_ctrl && _shift && _alt) then {
			
				// if (_key == 0x18) then 						//CTRL + SHIFT + ALT + O (as Options) was pressed
				// {	
					// //Show Options dialogue
					
					// //click on hidden Options button. If _DEMO is defined, in RscDisplayOptions.sqf Controls button will be clicked automatically
					// uiNamespace setVariable ["BIS_isCheatOptions", true];
					// ctrlactivate (_display displayCtrl 101);
				// };
			// };
		// };
	};

	default {};
};