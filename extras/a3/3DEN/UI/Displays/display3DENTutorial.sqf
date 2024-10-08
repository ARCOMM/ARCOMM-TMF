#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {
		_fnc_treeselchanged = {
			private ["_classCategory","_classSection"];
			_ctrlTree = _this select 0;
			_path = _this select 1;
			_cfg = if (count _path > 1) then {
				_classCategory = _ctrlTree tvdata [_path select 0];
				_classSection = _ctrlTree tvdata _path;
				configFile >> "Cfg3DEN" >> "Tutorials" >> _classCategory >> "Sections" >> _classSection;
			} else {
				_classCategory = _ctrlTree tvdata _path;
				configFile >> "Cfg3DEN" >> "Tutorials" >> _classCategory;
			};
			_display = ctrlparent _ctrlTree;
			_ctrlButtonOK = _display displayCtrl IDC_OK;
			_ctrlButtonOK ctrlShow (isclass (_cfg >> "Steps"));

			//--- Mark as completed after clicking
			if (count _path == 2) then {
				_pathData = [_classCategory,_classSection];
				_completed = profilenamespace getVariable ["display3DENTutorial_completed",[]];
				if !(_pathData in _completed) then {
					_completed pushBack _pathData;
					profilenamespace setVariable ["display3DENTutorial_completed",_completed];
					saveprofilenamespace;
				};
				_ctrlTree = _display displayCtrl IDC_DISPLAY3DENTUTORIAL_LIST;
				_ctrlTree tvsetpicture [_path,getText (configFile >> "display3DENTutorial" >> "pictureCompleted")];

				//--- Reset notification icon
				_count = 0;
				{
					_count = _count + count configproperties [_x >> "Sections","isclass _x"];
				} forEach configproperties [configFile >> "Cfg3DEN" >> "Tutorials","isclass _x"];
				if (count _completed >= _count) then {
					_display3DEN = finddisplay IDD_DISPLAY3DEN;
					_ctrlTutorials = _display3DEN displayCtrl IDC_DISPLAY3DEN_TOOLBAR_HELP_TUTORIAL;
					_ctrlTutorials ctrlSetText "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\help_tutorial_ca.paa";
					setstatvalue ["3DENModelStudent",1];
				};
			};
		};
		_fnc_buttonclick = {
			_display = ctrlparent (_this select 0);
			_ctrlTree = _display displayCtrl IDC_DISPLAY3DENTUTORIAL_LIST;
			_path = tvcursel _ctrlTree;
			if (count _path > 1) then {
				_classCategory = _ctrlTree tvdata [_path select 0];
				_classSection = _ctrlTree tvdata _path;
				_display closedisplay IDC_OK;
				[[_classCategory,_classSection]] call bis_fnc_3dentutorial;
			};
		};

		_display = _params select 0;
		_ctrlTree = _display displayCtrl IDC_DISPLAY3DENTUTORIAL_LIST;
		_ctrlTree ctrlAddEventHandler ["treeselchanged",_fnc_treeselchanged];
		_ctrlTree ctrlAddEventHandler ["treedblclick",_fnc_buttonclick];
		_select = uiNamespace getVariable ["display3DENTutorial_select",["",""]];
		_selectCategory = _select param [0,"",[""]];
		_selectClass = _select param [1,"",[""]];
		_selectPath = [0];
		_picture = getText (configFile >> "display3DENTutorial" >> "picture");
		_pictureCompleted = getText (configFile >> "display3DENTutorial" >> "pictureCompleted");
		_completed = profilenamespace getVariable ["display3DENTutorial_completed",[]];
		_count = 0;
		{
			_category = configname _x;
			_indexCategory = _ctrlTree tvadd [[],toupper getText (_x >> "displayName")];
			_ctrlTree tvsetpicture [[_indexCategory],getText (_x >> "icon")];
			_ctrlTree tvsetdata [[_indexCategory],_category];
			_isSelected = _category == _selectCategory;
			if (_isSelected) then {_selectPath set [0,_indexCategory];};
			{
				_section = configname _x;
				_indexSection = _ctrlTree tvadd [[_indexCategory],getText (_x >> "displayName")];
				_ctrlTree tvsetpicture [[_indexCategory,_indexSection],if ([_category,_section] in _completed) then {_pictureCompleted} else {_picture}];
				_ctrlTree tvsetdata [[_indexCategory,_indexSection],_section];
				if (_isSelected && {_section == _selectClass}) then {_selectPath set [1,_indexSection];};
				_count = _count + 1;
			} forEach configproperties [_x >> "Sections","isclass _x"];
			_ctrlTree tvexpand [_indexCategory];
		} forEach configproperties [configFile >> "Cfg3DEN" >> "Tutorials","isclass _x"];
		//_ctrlTree tvexpand [_selectPath select 0];
		_ctrlTree tvsetcursel _selectPath;
		[_ctrlTree,_selectPath] call _fnc_treeselchanged;

		_ctrlButtonOK = _display displayCtrl IDC_OK;
		_ctrlButtonOK ctrlAddEventHandler ["ButtonClick",_fnc_buttonclick];

		//--- Reset notification icon
		if (count _completed >= _count) then {
			_display3DEN = finddisplay IDD_DISPLAY3DEN;
			_ctrlTutorials = _display3DEN displayCtrl IDC_DISPLAY3DEN_TOOLBAR_HELP_TUTORIAL;
			_ctrlTutorials ctrlSetText "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\help_tutorial_ca.paa";
			setstatvalue ["3DENModelStudent",1];
		};

		//--- Terminate existing tutorial
		[] spawn bis_fnc_3dentutorial;
	};
	case "onUnload": {
		_display = _params select 0;
		_ctrlTree = _display displayCtrl IDC_DISPLAY3DENTUTORIAL_LIST;
		_path = tvcursel _ctrlTree;
		_pathClass = if (count _path > 1) then {
			[_ctrlTree tvdata [_path select 0],_ctrlTree tvdata _path]
		} else {
			[_ctrlTree tvdata _path]
		};
		uiNamespace setVariable ["display3DENTutorial_select",_pathClass];
	};
};