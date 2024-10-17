params ["_units"];

private _clusters = [];
private _checkedMen = [];
private _distanceMaX = 100;

{
    if(alive _x && {!(_x in _checkedMen)}) then
    {
        private _cluster = [_x];
        private _unit = _x;
        _checkedMen pushBack _x;
        {
            if(_x != _unit && {_x distance2D _unit < _distanceMaX} ) then
            {
                _cluster pushBack _x;
                _checkedMen pushBack _x;
            };
        } forEach _units;
        _clusters pushBack _cluster;
    };
} forEach _units;

private _outcluster = [];

{
    if(count _x > count _outcluster) then {_outcluster = _x};
} forEach _clusters;
_outcluster
