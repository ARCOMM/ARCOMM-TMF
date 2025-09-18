#include "script_component.hpp"
player createDiarySubject ["Chat Commands","Chat Commands"];

private _ARCOMM_Chat_Commands = ["Chat Commands", ["ARCOMM Default Commands","
<br/><font color='#70db70' size='16'>#heal</font>
<br/>Syntax 1
<br/><font color='#FF8C00'>#heal</font>
<br/>
<br/>Will heal the local player.
<br/>
<br/>Syntax 2
<br/><font color='#FF8C00'>#heal &lt;player_name&gt;</font>
<br/>
<br/>Will heal the given player.
<br/>
<br/><font color='#70db70' size='16'>#loadout</font>
<br/>Syntax 1
<br/><font color='#FF8C00'>#loadout &lt;role&gt;</font>
<br/>
<br/>Applies the given role loadout to the local player. Roles are the names of loadouts in the player's faction's loadout file. Eg. #loadout aar for assistant automatic rifleman.
<br/>
<br/>Syntax 2
<br/><font color='#FF8C00'>#loadout &lt;target_name&gt;</font>
<br/>
<br/>Target name is a name of a connected player and will apply their loadout to the local player. Eg. #loadout bob.
<br/>
<br/>Syntax 3
<br/><font color='#FF8C00'>#loadout &lt;target_name&gt; &lt;recipient_name&gt;</font>
<br/>
<br/>Both target name and recipient name are names of connected players. The loadout of target name will be applied to the recipient.
<br/>
<br/><font color='#70db70' size='16'>#radio</font>
<br/>Syntax
<br/><font color='#FF8C00'>#radio &lt;type&gt;</font>
<br/>
<br/>Will add the given radio to the local player. Eg. #radio 343, #radio 148 or #radio 152
<br/>
<br/><font color='#70db70' size='16'>#refuel</font>
<br/>Syntax
<br/><font color='#FF8C00'>#refuel</font>
<br/>
<br/>Refuels the player's vehicle or, if the player is not in a vehicle, their cursorObject.
<br/>
<br/><font color='#70db70' size='16'>#repair</font>
<br/>Syntax 1
<br/><font color='#FF8C00'>#repair</font>
<br/>
<br/>Repairs the player's vehicle or, if the player is not in a vehicle, their cursorObject
<br/>
<br/>Syntax 2
<br/><font color='#FF8C00'>#repair all</font>
<br/>
<br/>Repairs the player's vehicle or, if the player is not in a vehicle, their cursorObject
<br/>
<br/>Syntax 3
<br/><font color='#FF8C00'>#repair find</font>
<br/>
<br/>Finds all damaged hitpoints and prints them as an ingame hint.
<br/>
<br/>Syntax 4
<br/><font color='#FF8C00'>#repair &lt;hitpoint&gt;</font>
<br/>
<br/>Repairs the specified hitpoint.
<br/>
<br/><font color='#70db70' size='16'>#rp</font>
<br/>Syntax
<br/><font color='#FF8C00'>#rp</font>
<br/>
<br/>Will reset the local player's position to the nearest safe position.
<br/>
<br/><font color='#70db70' size='16'>#spec</font>
<br/>Syntax
<br/><font color='#FF8C00'>#spec</font>
<br/>
<br/>Will open the spectator interface.
<br/>
<br/><font color='#70db70' size='16'>#tp</font>
<br/>Syntax1
<br/><font color='#FF8C00'>#tp &lt;player_name&gt;</font>
<br/>
<br/>Teleports you to the target player.
<br/>
<br/>Syntax 2
<br/><font color='#FF8C00'>#tp &lt;group&gt;</font>
<br/>
<br/>Teleports you to the target group.
<br/>
<br/><font color='#70db70' size='16'>#whisper</font>
<br/>Syntax
<br/><font color='#FF8C00'>#whisper &lt;player_name&gt; &lt;message&gt;</font>
<br/>
<br/>Will whisper the given player with the given message. Whisper will show a hint to the recipient and will show who sent the whisper. Eg. #whisper bob can you teleport me i fell into the sun
"]];

player createDiaryRecord _ARCOMM_Chat_Commands;