#include "\a3\3DEN\UI\resincl.inc"

_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {

	case "onLoad": {

		_display = _params select 0;

		_ctrlIslandBox = _display displayCtrl IDC_DISPLAY3DENNEW_LIST;
		_ctrlIslandBox ctrlAddEventHandler ["lbselchanged","with uiNamespace do {['lbselchanged',_this,''] call display3DENNew_script};"];
		['lbselchanged',[_ctrlIslandBox,lbCurSel _ctrlIslandBox],''] call display3DENNew_script;

	};
	case "lbselchanged": {
		_ctrlIslandBox = _params select 0;
		_cursel = _params select 1;

		//--- Init GUI
		_display = ctrlparent _ctrlIslandBox;
		_ctrlName = _display displayCtrl IDC_DISPLAY3DENNEW_NAME;
		_ctrlAuthor = _display displayCtrl IDC_DISPLAY3DENNEW_AUTHOR;
		_ctrlIslandPanorama = _display displayCtrl IDC_DISPLAY3DENNEW_ISLANDPANORAMA;
		_ctrlWorld = _display displayCtrl IDC_DISPLAY3DENNEW_WORLD;
		_ctrlWorldLng = _display displayCtrl IDC_DISPLAY3DENNEW_WORLDLNG;
		_ctrlWorldLat = _display displayCtrl IDC_DISPLAY3DENNEW_WORLDLAT;

		//--- Set name
		_world = _ctrlIslandBox lbdata _cursel;
		_worldConfig = configFile >> "cfgworlds" >> _world;
		_ctrlName ctrlSetText toupper (_ctrlIslandBox lbtext _cursel);

		//--- Set author
		_author = getText (_worldConfig >> "author");
		if (_author == "") then {_author = localize "STR_AUTHOR_UNKNOWN"};
		_author = if (_author == "") then {""} else {format [localize "STR_FORMAT_AUTHOR_SCRIPTED",_author]};
		_ctrlAuthor ctrlSetText _author;

		//--- Set picture
		_picture = getText (_worldConfig >> "pictureMap");
		if (_picture == "") then {_picture = getText (configFile >> "display3DENNew" >> "defaultPicture")};
		_ctrlIslandPanorama ctrlSetText _picture;

		//--- Set lng/lat
		if (_world != "vr") then {
			_lng = getNumber (_worldConfig >> "longitude");
			_lat = getNumber (_worldConfig >> "latitude");
			_ctrlWorldPos = ctrlposition _ctrlWorld;
			_posX = linearconversion [-180,180,_lng,_ctrlWorldPos select 0,(_ctrlWorldPos select 0) + (_ctrlWorldPos select 2)];
			_posY = linearconversion [-90,90,_lat,_ctrlWorldPos select 1,(_ctrlWorldPos select 1) + (_ctrlWorldPos select 3)];
			_ctrlWorldLngPos = ctrlposition _ctrlWorldLng;
			_ctrlWorldLatPos = ctrlposition _ctrlWorldLat;
			_ctrlWorldLngPos set [0,_posX];
			_ctrlWorldLatPos set [1,_posY];
			_ctrlWorldLng ctrlSetPosition _ctrlWorldLngPos;
			_ctrlWorldLat ctrlSetPosition _ctrlWorldLatPos;
			_ctrlWorldLng ctrlsetfade 0;
			_ctrlWorldLat ctrlsetfade 0;
		} else {
			_ctrlWorldLng ctrlsetfade 1;
			_ctrlWorldLat ctrlsetfade 1;
		};
		_commitTime = if (ctrltext _ctrlWorldLng == ".") then {0.1} else {_ctrlWorldLng ctrlSetText "."; 0};
		_ctrlWorldLng ctrlCommit _commitTime;
		_ctrlWorldLat ctrlCommit _commitTime;
	};
	default {};
};