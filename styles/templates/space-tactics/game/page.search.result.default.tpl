{block name="content"}
<table style="width:100%;" id="resulttable">
	<tr>
		<th>{$LNG.sh_name}</th>
		<th>&nbsp;</th>
		<th>{$LNG.sh_alliance}</th>
		<th>{$LNG.sh_planet}</th>
		<th>{$LNG.sh_coords}</th>
		<th>{$LNG.sh_position}</th>
	</tr>
	{foreach $searchList as $searchRow}
	<tr>
		<td><a href="#" onclick="return Dialog.Playercard({$searchRow.userid});">{$searchRow.username}</a></td>
		<td><a href="#" onclick="return Dialog.PM({$searchRow.userid});" title="{$LNG.sh_write_message}"><i class="far fa-envelope" title="Message privé" style="font-size: 15px;"></i></a>&nbsp;<a href="#" onclick="return Dialog.Buddy({$searchRow.userid});" title="{$LNG.sh_buddy_request}"><i class="far fa-handshake" style="font-size: 15px;"></i></a></td>
		<td>{if $searchRow.allyname}<a href="game.php?page=alliance&amp;mode=info&amp;id={$searchRow.allyid}">{$searchRow.allyname}</a>{else}-{/if}</td>
		<td>{$searchRow.planetname}</td>
		<td><a href="game.php?page=galaxy&amp;galaxy={$searchRow.galaxy}&amp;system={$searchRow.system}">[{$searchRow.galaxy}:{$searchRow.system}:{$searchRow.planet}]</a></td>
		<td>{$searchRow.rank}</td>
	</tr>
	{/foreach}
</table>
{/block}