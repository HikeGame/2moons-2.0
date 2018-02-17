{block name="title" prepend}{$LNG.lm_buildings}{/block}
{block name="content"}

<div class="content_page" style="width: 95%;">
	<div class="title">
		{$LNG.lm_buildings}
	</div>

	{if !empty($Queue)}
	<div id="buildlist" class="buildlist">
		<table style="width:100%;">
			{foreach $Queue as $List}
			{$ID = $List.element}
			<tr>
				<td style="width:70%;vertical-align:top;" class="left">
					{$List@iteration}.: 
					{if !($isBusy.research && ($ID == 6 || $ID == 31)) && !($isBusy.shipyard && ($ID == 15 || $ID == 21)) && $RoomIsOk && $CanBuildElement && $BuildInfoList[$ID].buyable}
					<form class="build_form" action="game.php?page=buildings" method="post">
						<input type="hidden" name="cmd" value="insert">
						<input type="hidden" name="building" value="{$ID}">
						<button type="submit" class="build_submit onlist">{$LNG.tech.{$ID}} {$List.level}{if $List.destroy} {$LNG.bd_dismantle}{/if}</button>
					</form>
					{else}{$LNG.tech.{$ID}} {$List.level} {if $List.destroy}{$LNG.bd_dismantle}{/if}{/if}
					{if $List@first}
					<br><br><div id="progressbar" data-time="{$List.resttime}"></div>
				</td>
				<td>
					<div id="time" data-time="{$List.time}"><br></div>
					<form action="game.php?page=buildings" method="post" class="build_form">
						<input type="hidden" name="cmd" value="cancel">
						<button type="submit" class="build_submit onlist">{$LNG.bd_cancel}</button>
					</form>
					{else}
				</td>
				<td>
					<form action="game.php?page=buildings" method="post" class="build_form">
						<input type="hidden" name="cmd" value="remove">
						<input type="hidden" name="listid" value="{$List@iteration}">
						<button type="submit" class="build_submit onlist">{$LNG.bd_cancel}</button>
					</form>
					{/if}
					<br><span style="color:lime" data-time="{$List.endtime}" class="timer">{$List.display}</span>
				</td>
			</tr>
		{/foreach}
		</table>
	</div>
	{/if}

{foreach $BuildInfoList as $ID => $Element}
	<div class="main_construct">
		
		<div class="block_construct">
			<div class="title" style="margin: 5px 0 0 -5px; text-align: left;">
				<a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" width="20" height="20"> {$LNG.tech.{$ID}} {if $Element.level > 0} - {$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}{/if}</a>
				<span style="float: right;">
					{if $Element.level > 0}
							{if $ID == 43}<a href="#" onclick="return Dialog.info({$ID})">{$LNG.bd_jump_gate_action}</a>{/if}
							{if ($ID == 44 && !$HaveMissiles) ||  $ID != 44}<a class="tooltip_sticky" data-tooltip-content="
								{* Start Destruction Popup *}
								<table style='width:300px'>
									<tr>
										<th colspan='2'>{$LNG.bd_price_for_destroy} {$LNG.tech.{$ID}} {$Element.level}</th>
									</tr>
									{foreach $Element.destroyResources as $ResType => $ResCount}
									<tr>
										<td>{$LNG.tech.{$ResType}}</td>
										<td><span style='color:lime'>{$ResCount|number}</span></td>
									</tr>
									{/foreach}
									<tr>
										<td>{$LNG.bd_destroy_time}</td>
										<td>{$Element.destroyTime|time}</td>
									</tr>
									<tr>
										<td colspan='2'>
											<form action='game.php?page=buildings' method='post' class='build_form'>
												<input type='hidden' name='cmd' value='destroy'>
												<input type='hidden' name='building' value='{$ID}'>
												<button type='submit' class='build_submit onlist'>{$LNG.bd_dismantle}</button>
											</form>
										</td>
									</tr>
								</table>
								{* End Destruction Popup *}
								"><i class="fas fa-trash-alt" style="color: red; font-size: 11px;"></i></a>{/if}
						{/if}
				</span>
				<div class="clear"></div>
			</div>
			<div class="block_construct_desc">
				<div class="block_construct_desc_list">
					{foreach $Element.costResources as $RessID => $RessAmount}
						<div style="margin-bottom: 10px;">
							<img src="{$dpath}images/{$RessID}.gif" alt=""> <b><span {if $Element.costOverflow[$RessID] == 0}class="res_{$RessID}_text"{/if} style="color:{if $Element.costOverflow[$RessID] == 0}{else}red{/if}">{$RessAmount|number}</span></b>
						</div>
					{/foreach}

					{if !empty($Element.infoEnergy)}
						{$LNG.bd_next_level}<br>
						{$Element.infoEnergy}<br>
						<br>
					{/if}

					<span style="font-weight: bold;"><i class="fas fa-tachometer-alt" style="font-size: 13px;"></i> {$Element.elementTime|time}</span>

				</div>

				<div>
					{if $Element.maxLevel == $Element.levelToBuild}
						<div class="construct_button_lost">
							<span style="color:red">{$LNG.bd_maxlevel}</span>
						</div>
					{elseif ($isBusy.research && ($ID == 6 || $ID == 31)) || ($isBusy.shipyard && ($ID == 15 || $ID == 21))}
						<div class="construct_button_lost">
							<span style="color:red">{$LNG.bd_working}</span>
						</div>
					{else}
						{if $RoomIsOk}
							{if $CanBuildElement && $Element.buyable}
							<form action="game.php?page=buildings" method="post" class="build_form">
								<input type="hidden" name="cmd" value="insert">
								<input type="hidden" name="building" value="{$ID}">
								<button type="submit" class="build_submit construct_button">{if $Element.level == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</button>
							</form>
							{else}
							<div class="construct_button_lost">
								<span style="color:red">{if $Element.level == 0}{$LNG.bd_build}{else}{$LNG.bd_build_next_level}{$Element.levelToBuild + 1}{/if}</span>
							</div>
							{/if}
						{else}
						<div class="construct_button_lost">
							<span style="color:red">{$LNG.bd_no_more_fields}</span>
						</div>
						{/if}
					{/if}
				</div>
			</div>
		</div>
	</div>
	{/foreach}
	<div class="clear"></div>

</div>

{/block}