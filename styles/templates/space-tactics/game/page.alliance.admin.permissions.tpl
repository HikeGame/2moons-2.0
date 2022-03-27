{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}
{$countRank = count($availableRanks)}

<div class="content_page">
	<div class="title" style="text-align: left;">
		{$LNG.al_configura_ranks} <span style="float:right;"><button id="create_new_alliance_rank">+</button></span>
	</div>

	<div>
		<form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
		<input type="hidden" value="1" name="send">
			<table style="width:100%;">
			<tr>
				<td>{$LNG.al_dlte}</td>
				<td>{$LNG.al_rank_name}</td>
				{foreach $availableRanks as $rankName}
				<td><img src="styles/resource/images/alliance/{$rankName}.png" alt="" width="16" height="16"></td>
				{/foreach}
			</tr>
			{foreach $rankList as $rowId => $rankRow}
			<tr>
				<td><a href="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend&amp;deleteRank={$rowId}"><img src="styles/resource/images/alliance/CLOSE.png" alt="" width="16" height="16"></a></td>
				<td><input type="text" name="rank[{$rowId}][rankName]" value="{$rankRow.rankName}"></td>
				{foreach $availableRanks as $rankId => $rankName}
				<td><input type="checkbox" name="rank[{$rowId}][{$rankId}]" value="1"{if $rankRow[$rankName]} checked{/if}{if !$ownRights[$rankName]} disabled{/if}></td>
				{/foreach}
			</tr>
			{foreachelse}
			<tr>
				<td colspan="{$countRank + 2}">{$LNG.al_no_ranks_defined}</td>
			</tr>
			{/foreach}
			<tr>
				<td colspan="{$countRank + 2}"><input type="submit" value="{$LNG.al_save}"></td>
			</tr>
			<tr class="title">
					<th colspan="{$countRank + 2}">{$LNG.gl_legend}</th>
			</tr>
				{foreach $availableRanks as $rankName}
			<tr>
					<td><img src="styles/resource/images/alliance/{$rankName}.png" alt="" width="16" height="16"></td>
					<td colspan="{$countRank + 1}">{$LNG.al_rank_desc[$rankName]}</td>
			</tr>
				{/foreach}
			<tr>
					<th colspan="{$countRank + 2}"><a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></th>
			</tr>
			</table>
		</form>
	</div>
</div>

<div id="new_alliance_rank" title="{$LNG.al_create_new_rank}" style="display:none;">
	<form action="game.php?page=alliance&amp;mode=admin&amp;action=permissionsSend" method="post">
		<table style="width:100%;">
	<tr>
				<td><label for="rankName">{$LNG.al_rank_name}</label></td>
				<td><input type="text" name="newrank[rankName]" size="20" maxlength="32" id="rankName" required></td>
	</tr>
			<tr>
				<th colspan="{$countRank + 2}">&nbsp;</th>
			</tr>
	{foreach $availableRanks as $rankId => $rankName}
	<tr>
		<td><img src="styles/resource/images/alliance/{$rankName}.png" alt="{$rankName}" width="16" height="16">&nbsp;<label for="rank_{$rankId}">{$LNG.al_rank_desc[$rankName]}</label></td>
		<td><input type="checkbox" name="newrank[{$rankId}]" value="1" id="rank_{$rankId}" title="{$LNG.al_rank_desc[$rankName]}"></td>
	</tr>
	{/foreach}
	<tr>
		<td colspan="{$countRank + 2}"><input type="submit" value="{$LNG.al_create}"></td>
	</tr>
	</table>
</form>
</div>
{/block}