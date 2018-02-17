{block name="title" prepend}{$LNG.lm_officiers}{/block}
{block name="content"}

<div class="content_page" style="width: 95%;">
	{if !empty($darkmatterList)}
	<div class="title">
		{$of_dm_trade}
	</div>

	{foreach $darkmatterList as $ID => $Element}
		<div class="main_construct">
			
			<div class="block_construct">
				<div class="title" style="margin: 5px 0 0 -5px; text-align: left;">
					<a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" width="20" height="20"> {$LNG.tech.{$ID}}</a>
				</div>

				<div class="block_construct_desc">
					<div class="block_construct_desc_list">
						{foreach $Element.costResources as $RessID => $RessAmount}
							<div style="margin-bottom: 10px;">
								<img src="{$dpath}images/{$RessID}.gif" alt=""> <b><span {if $Element.costOverflow[$RessID] == 0}class="res_{$RessID}_text"{/if} style="color:{if $Element.costOverflow[$RessID] == 0}{else}red{/if}">{$RessAmount|number}</span></b>
							</div>
						{/foreach}

						<div style="margin-bottom: 10px;">
							{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus@iteration % 3 === 1}<p>{/if}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{$Bonus[0]}{/if} {$LNG.bonus.$BonusName}{if $Bonus@iteration % 3 === 0 || $Bonus@last}</p>{else}&nbsp;{/if}{/foreach}
						</div>

						{if $Element.timeLeft > 0}
						<div style="margin-bottom: 10px;">
							{$LNG.of_still} <span style="color: orange; font-weight: bold;" id="time_{$ID}">-</span> {$LNG.of_active}
						</div>
						{/if}

						<span style="font-weight: bold;"><i class="fas fa-tachometer-alt" style="font-size: 13px;"></i> <span style="color:lime">{$Element.time|time}</span></span>

					</div>

					<div>
						{if $Element.timeLeft > 0}
							{if $Element.buyable}
							<form action="game.php?page=officier" method="post" class="build_form">
								<input type="hidden" name="id" value="{$ID}">
								<button type="submit" class="build_submit construct_button">{$LNG.of_recruit}</button>
							</form>
							{/if}
						{elseif $Element.buyable}
						<form action="game.php?page=officier" method="post" class="build_form">
							<input type="hidden" name="id" value="{$ID}">
							<button type="submit" class="build_submit construct_button">{$LNG.of_recruit}</button>
						</form>
						{else}
						<div class="construct_button_lost">
							<span style="color:#FF0000">{$LNG.of_recruit}</span>
						</div>
						{/if}
					</div>
				</div>
			</div>
		</div>
	{/foreach}
	<div class="clear"></div>
	{/if}

	{if $officierList}
	<div class="title" {if !empty($darkmatterList)}style="margin: 5px 0 -5px 0;"{/if}>
		{$LNG.of_offi}
	</div>

	{foreach $officierList as $ID => $Element}
		<div class="main_construct">
			
			<div class="block_construct">
				<div class="title" style="margin: 5px 0 0 -5px; text-align: left;">
					<a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.jpg" alt="{$LNG.tech.{$ID}}" width="20" height="20"> {$LNG.tech.{$ID}} - {$LNG.of_lvl} {$Element.level}/{$Element.maxLevel}</a>
				</div>

				<div class="block_construct_desc">
					<div class="block_construct_desc_list">
						{foreach $Element.costResources as $RessID => $RessAmount}
							<div style="margin-bottom: 10px;">
								<img src="{$dpath}images/{$RessID}.gif" alt=""> <b><span {if $Element.costOverflow[$RessID] == 0}class="res_{$RessID}_text"{/if} style="color:{if $Element.costOverflow[$RessID] == 0}{else}red{/if}">{$RessAmount|number}</span></b>
							</div>
						{/foreach}

						<div style="margin-bottom: 10px;">
							{foreach $Element.elementBonus as $BonusName => $Bonus}{if $Bonus@iteration % 3 === 1}<p>{/if}{if $Bonus[0] < 0}-{else}+{/if}{if $Bonus[1] == 0}{abs($Bonus[0] * 100)}%{else}{$Bonus[0]}{/if} {$LNG.bonus.$BonusName}{if $Bonus@iteration % 3 === 0 || $Bonus@last}</p>{else}&nbsp;{/if}{/foreach}
						</div>

					</div>

					<div>
						{if $Element.maxLevel <= $Element.level}
						<div class="construct_button_lost">
							<span style="color:red">{$LNG.bd_maxlevel}</span>
						</div>
						{elseif $Element.buyable}
							<form action="game.php?page=officier" method="post" class="build_form">
								<input type="hidden" name="id" value="{$ID}">
								<button type="submit" class="build_submit construct_button">{$LNG.of_recruit}</button>
							</form>
						{else}
						<div class="construct_button_lost">
							<span style="color:red">{$LNG.of_recruit}</span>
						</div>
						{/if}
					</div>
				</div>
			</div>
		</div>
	{/foreach}
	<div class="clear"></div>
	{/if}

</div>

{/block}
{block name="script"}
<script src="scripts/game/officier.js"></script>
{/block}