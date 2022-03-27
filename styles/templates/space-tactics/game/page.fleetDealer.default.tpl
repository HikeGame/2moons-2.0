{block name="title" prepend}{$LNG.lm_fleettrader}{/block}
{block name="content"}
<form action="game.php?page=fleetDealer" method="post">
	<input type="hidden" name="mode" value="send">

	<div class="content_page">
		<div class="title">
			{$LNG.ft_head}
		</div>

		<div>
			<table style="width:100%;">
		        <tr>
					<td>
						<div class="transparent" style="text-align:left;float:left;"><img id="img" alt="" data-src="{$dpath}gebaeude/"></div>
						<div class="transparent" style="text-align:right;float:right;padding:5px">
							<select name="shipID" id="shipID" onchange="updateVars()">
								{foreach $shipIDs as $shipID}
								<option value="{$shipID}">{$LNG.tech.$shipID}</option>
								{/foreach}
							</select>
						</div>
						<div style="clear:right;margin-top:20px;margin-left:125px;">
							<h2 id="traderHead"></h2>
							<p>{$LNG.ft_count}: <input type="text" id="count" name="count" onkeyup="Total();"><button onclick="MaxShips();return false;">{$LNG.ft_max}</button></p>
							<p>{$LNG.tech.901}: <span class="res_901_text" id="metal" style="font-weight:800;"></span> &bull; {$LNG.tech.902}: <span class="res_902_text" id="crystal" style="font-weight:800;"></span> &bull; {$LNG.tech.903}: <span class="res_903_text" id="deuterium" style="font-weight:800;"></span> &bull; {$LNG.tech.921}: <span class="res_921_text" id="darkmatter" style="font-weight:800;"></span></p>
							<p>{$LNG.ft_total}: {$LNG.tech.901}: <span class="res_901_text" id="total_metal" style="font-weight:800;"></span> &bull; {$LNG.tech.902}: <span class="res_902_text" id="total_crystal" style="font-weight:800;"></span> &bull; {$LNG.tech.903} <span class="res_903_text" id="total_deuterium" style="font-weight:800;"></span> &bull; {$LNG.tech.921}: <span class="res_921_text" id="total_darkmatter" style="font-weight:800;"></span></�>
							<p><input type="submit" value="{$LNG.ft_absenden}"></p>
							<p>{$LNG.ft_charge}: {$Charge}%</p>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
{/block}
{block name="script" append}
<script src="scripts/game/fleettrader.js"></script>
<script>
var CostInfo = {$CostInfos|json};
var Charge = {$Charge};
$(function(){
    updateVars();
});
</script>
{/block}