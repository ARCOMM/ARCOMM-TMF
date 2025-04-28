/*
 * Name: TMF_common_fnc_numToTexture
 * Author: Snippers
 *
 * Arguments:
 * scalar
 *
 * Return:
 * string: path to texture
 *
 * Description:
 * Will return the path to a texture that has the number.
 */

params [["_num", 0, [0]]];

_num = round (0 max _num min 10);

format ["x\tmf\addons\common\UI\numbers\%1.paa", _num];
