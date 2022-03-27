{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$al_users_list}
	</div>

	<div>
		<table id="memberList" style="width:100%;" class="tablesorter">
			<thead>
				<tr>
					<th>{$LNG.al_num}</th>
					<th>{$LNG.al_member}</th>
					<th>{$LNG.al_message}</th>
					<th>{$LNG.al_position}</th>
					<th>{$LNG.al_points}</th>
					<th>{$LNG.al_coords}</th>
					<th>{$LNG.al_member_since}</th>
					<th>{$LNG.al_estate}</th>
				</tr>
			</thead>
			<tbody>
			{foreach $memberList as $userID => $memberListRow}
			<tr>
				<td>{$memberListRow@iteration}</td>
				<td><a href="#" onclick="return Dialog.Playercard({$userID}, '{$memberListRow.username}');">{$memberListRow.username}</a></td>
				<td>
					<a href="#" onclick="return Dialog.PM({$userID});">
						<i class="far fa-envelope" title="{$LNG.write_message}" style="font-size: 15px;"></i>
					</a>
				</td>
				<td>{$memberListRow.rankName}</td>
				<td data-points="{$memberListRow.points}">{$memberListRow.points|number}</td>
				<td><a href="game.php?page=galaxy&amp;galaxy={$memberListRow.galaxy}&amp;system={$memberListRow.system}" data-postion="{$memberListRow.galaxy}:{$memberListRow.system}:{$memberListRow.planet}">[{$memberListRow.galaxy}:{$memberListRow.system}:{$memberListRow.planet}]</a></td>
				<td>{$memberListRow.register_time}</td>
				<td>{if $rights.ONLINESTATE}{if $memberListRow.onlinetime < 4}<span style="color:lime">{$LNG.al_memberlist_on}</span>{elseif $memberListRow.onlinetime <= 15}<span style="color:yellow">{$memberListRow.onlinetime} {$LNG.al_memberlist_min}</span>{else}<span style="color:red">{$LNG.al_memberlist_off}</span>{/if}{else}-{/if}</td>
			</tr>
			{/foreach}
			</tbody>
			<tr>
				<th colspan="8"><a href="game.php?page=alliance">{$LNG.al_back}</a></th>
			</tr>
		</table>
	</div>
</div>

{/block}
{block name="script" append}
<script src="scripts/base/jquery.tablesorter.js"></script>
<script>$(function() {
    $("#memberList").tablesorter({
		headers: { 
			0: { sorter: false } ,
			3: { sorter: false } 
		},
		debug: false
	}); 
});</script>
{/block}