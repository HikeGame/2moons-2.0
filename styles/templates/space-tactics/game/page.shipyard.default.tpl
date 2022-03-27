{block name="title" prepend}{if $mode == "defense"}{$LNG.lm_defenses}{else}{$LNG.lm_shipshard}{/if}{/block}
{block name="content"}

<div class="content_page" style="width: 95%;">
	<div class="title">
		{if $mode == "defense"}{$LNG.lm_defenses}{else}{$LNG.lm_shipshard}{/if}
	</div>

	{if !$NotBuilding}
		<div width="99%" id="infobox" style="border: 2px solid red; text-align:center;background:transparent">{$LNG.bd_building_shipyard}</div>
	{/if}

	{if !empty($BuildList)}
		<table style="width: 100%;">
			<tr>
				<td class="transparent">
					<div id="bx" class="z"></div>
					<i class="fas fa-tachometer-alt" style="font-size: 13px;"></i> <span id="timeleft"></span>
					<br>
					<form action="game.php?page=shipyard&amp;mode={$mode}" method="post">
					<input type="hidden" name="action" value="delete">
					<table style="width: 100%;">
					<tr>
						<th>{$LNG.bd_cancel_warning}<br><input type="submit" value="{$LNG.bd_cancel_send}"></th>
					</tr>
					<tr>
						<td><select style="min-height: 150px;" name="auftr[]" id="auftr" size="10" multiple><option>&nbsp;</option></select></td>
					</tr>
					</table>
					</form>
				</td>
			</tr>
		</table>
		<br>
	{/if}

<form action="game.php?page=shipyard&amp;mode={$mode}" method="post">
{foreach $elementList as $ID => $Element}
	<div class="main_construct">
		
		<div class="block_construct">
			<div class="title" style="margin: 5px 0 0 -5px; text-align: left;">
				<a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" width="20" height="20"> {$LNG.tech.{$ID}} <span id="val_{$ID}">{if $Element.available != 0} ({$LNG.bd_available} {$Element.available|number}){/if}</a>
			</div>

			<div class="block_construct_desc">
				<div class="block_construct_desc_list">
					{foreach $Element.costResources as $RessID => $RessAmount}
						<div style="margin-bottom: 10px;">
							<img src="{$dpath}images/{$RessID}.gif" alt=""> <b><span {if $Element.costOverflow[$RessID] == 0}class="res_{$RessID}_text"{/if} style="color:{if $Element.costOverflow[$RessID] == 0}{else}red{/if}">{$RessAmount|number}</span></b>
						</div>
					{/foreach}

					<div style="margin-bottom: 5px;">
						{$LNG.bd_max_ships_long}: <span style="font-weight:700">{$Element.maxBuildable|number}</span>
					</div>

					<span style="font-weight: bold;"><i class="fas fa-tachometer-alt" style="font-size: 13px;"></i> {$Element.elementTime|time}</span>

				</div>

				<div>
					{if $Element.AlreadyBuild}<span style="color:red">{$LNG.bd_protection_shield_only_one}</span>{elseif $NotBuilding && $Element.buyable}<input style="width: 90%;" type="text" name="fmenge[{$ID}]" id="input_{$ID}" value="0" tabindex="{$smarty.foreach.FleetList.iteration}">
					<input style="padding: 8px; margin-left: -10px; border-left: none;" type="button" value="{$LNG.bd_max_ships}" onclick="$('#input_{$ID}').val('{$Element.maxBuildable}')"></p>
					{/if}
				</div>

				{if $NotBuilding}<div style="text-align:center"><input type="submit" value="{$LNG.bd_build_ships}"></div>{/if}
			</div>
		</div>
	</div>
	{/foreach}
	<div class="clear"></div>

</div>
</form>
{/block}
{block name="script" append}
<script type="text/javascript">
data			= {$BuildList|json};
bd_operating	= '{$LNG.bd_operating}';
bd_available	= '{$LNG.bd_available}';
</script>
{if !empty($BuildList)}
<script src="scripts/base/bcmath.js"></script>
<script src="scripts/game/shipyard.js"></script>
<script type="text/javascript">
$(function() {
    ShipyardInit();
});
</script>
{/if}
{/block}