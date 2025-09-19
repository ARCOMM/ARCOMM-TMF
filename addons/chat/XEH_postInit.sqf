#include "script_component.hpp"
player createDiarySubject ["Chat Commands","Chat Commands"];

private _ARCOMM_Chat_Commands = ["Chat Commands", ["ARCOMM Default Commands","
<br/><font color='#70db70' size='16'>1. Heal</font>
<br/>Syntax 1 - <font color='#FF8C00'>#heal</font>
<br/>Will heal the local player.
<br/>
<br/>Syntax 2 - <font color='#FF8C00'>#heal &lt;player_name&gt;</font>
<br/>Will heal the given player.
<br/>
<br/><font color='#70db70' size='16'>2. Loadout</font>
<br/>Syntax 1 - <font color='#FF8C00'>#loadout &lt;role&gt;</font>
<br/>Applies the given role loadout to the local player. Roles are the names of loadouts in the player's faction's loadout file. Eg. #loadout aar for assistant automatic rifleman.
<br/>
<br/>Syntax 2 - <font color='#FF8C00'>#loadout &lt;target_name&gt;</font>
<br/>Target name is a name of a connected player and will apply their loadout to the local player. Eg. #loadout bob.
<br/>
<br/>Syntax 3 - <font color='#FF8C00'>#loadout &lt;target_name&gt; &lt;recipient_name&gt;</font>
<br/>
<br/>Both target name and recipient name are names of connected players. The loadout of target name will be applied to the recipient.
<br/>
<br/><font color='#70db70' size='16'>3. Radio</font>
<br/>Syntax - <font color='#FF8C00'>#radio &lt;type&gt;</font>
<br/>Will add the given radio to the local player. Eg. #radio 343, #radio 148 or #radio 152
<br/>
<br/><font color='#70db70' size='16'>4. Refuel</font>
<br/>Syntax - <font color='#FF8C00'>#refuel</font>
<br/>Refuels the player's vehicle or, if the player is not in a vehicle, the vehicle centered in their screen.
<br/>
<br/><font color='#70db70' size='16'>5. Repair</font>
<br/>Syntax 1 - <font color='#FF8C00'>#repair</font>
<br/>Repairs the player's vehicle or, if the player is not in a vehicle, the vehicle centered in their screen
<br/>
<br/>Syntax 2 - <font color='#FF8C00'>#repair all</font>
<br/>Repairs the player's vehicle or, if the player is not in a vehicle, the vehicle centered in their screen
<br/>
<br/>Syntax 3 - <font color='#FF8C00'>#repair find</font>
<br/>Finds all damaged hitpoints and displays them as a hint.
<br/>
<br/>Syntax 4 - <font color='#FF8C00'>#repair &lt;hitpoint&gt;</font>
<br/>Repairs the specified hitpoint.
<br/>
<br/><font color='#70db70' size='16'>6. RP</font>
<br/>Syntax - <font color='#FF8C00'>#rp</font>
<br/>Will reset the local player's position to the nearest safe position.
<br/>
<br/><font color='#70db70' size='16'>7. Spec</font>
<br/>Syntax - <font color='#FF8C00'>#spec</font>
<br/>Will open the spectator interface.
<br/>
<br/><font color='#70db70' size='16'>8. TP</font>
<br/>Syntax1 - <font color='#FF8C00'>#tp &lt;player_name&gt;</font>
<br/>Teleports you to the target player.
<br/>
<br/>Syntax 2 - <font color='#FF8C00'>#tp &lt;group&gt;</font>
<br/>Teleports you to the target group.
<br/>
<br/><font color='#70db70' size='16'>9. Whisper</font>
<br/>Syntax - <font color='#FF8C00'>#whisper &lt;player_name&gt; &lt;message&gt;</font>
<br/>Will whisper the given player with the given message. Whisper will show a hint to the recipient and will show who sent the whisper. Eg. #whisper bob can you teleport me i fell into the sun
"]];

player createDiaryRecord _ARCOMM_Chat_Commands;
