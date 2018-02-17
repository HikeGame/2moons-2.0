{block name="title" prepend}{$LNG.lm_research}{/block}
{block name="content"}

<div class="content_page" style="width: 95%;">
	<div class="title">
		{$LNG.lm_research}
	</div>

	{if $IsLabinBuild}
		<div width="99%" id="infobox" style="border: 2px solid red; text-align:center;background:transparent">{$LNG.bd_building_lab}</div>
	{/if}

	{if !empty($Queue)}
	<div id="buildlist" class="buildlist">
		<table style="width: 100%;">
			{foreach $Queue as $List}
			{$ID = $List.element}
			<tr>
				<td style="width:70%;vertical-align:top;" class="left">
					{if isset($ResearchList[$List.element])}
					{$CQueue = $ResearchList[$List.element]}
					{/if}
					{$List@iteration}.: 
					{if isset($CQueue) && $CQueue.maxLevel != $CQueue.level && !$IsFullQueue && $CQueue.buyable}
					<form action="game.php?page=research" method="post" class="build_form">
						<input type="hidden" name="cmd" value="insert">
						<input type="hidden" name="tech" value="{$ID}">
						<button type="submit" class="build_submit onlist">{$LNG.tech.{$ID}} {$List.level}{if !empty($List.planet)} @ {$List.planet}{/if}</button>
					</form>
					{else}
					{$LNG.tech.{$ID}} {$List.level}{if !empty($List.planet)} @ {$List.planet}{/if}
					{/if}
					{if $List@first}
					<br><br><div id="progressbar" data-time="{$List.resttime}"></div>
				</td>
				<td>
					<div id="time" data-time="{$List.time}"><br></div>
					<form action="game.php?page=research" method="post" class="build_form">
						<input type="hidden" name="cmd" value="cancel">
						<button type="submit" class="build_submit onlist">{$LNG.bd_cancel}</button>
					</form>
					{else}
				</td>
				<td>
					<form action="game.php?page=research" method="post" class="build_form">
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

{foreach $ResearchList as $ID => $Element}
	<div class="main_construct">
		
		<div class="block_construct">
			<div class="title" style="margin: 5px 0 0 -5px; text-align: left;">
				<a href="#" onclick="return Dialog.info({$ID})"><img src="{$dpath}gebaeude/{$ID}.gif" alt="{$LNG.tech.{$ID}}" width="20" height="20"> {$LNG.tech.{$ID}} {if $Element.level > 0} - {$LNG.bd_lvl} {$Element.level}{if $Element.maxLevel != 255}/{$Element.maxLevel}{/if}{/if}</a>
			</div>

			<div class="block_construct_desc">
				<div class="block_construct_desc_list">
					{foreach $Element.costResources as $RessID => $RessAmount}
						<div style="margin-bottom: 10px;">
							<img src="{$dpath}images/{$RessID}.gif" alt=""> <b><span {if $Element.costOverflow[$RessID] == 0}class="res_{$RessID}_text"{/if} style="color:{if $Element.costOverflow[$RessID] == 0}{else}red{/if}">{$RessAmount|number}</span></b>
						</div>
					{/foreach}

					<span style="font-weight: bold;"><i class="fas fa-tachometer-alt" style="font-size: 13px;"></i> {$Element.elementTime|time}</span>

				</div>

				<div>
					{if $Element.maxLevel == $Element.levelToBuild}
						<div class="construct_button_lost">
							<span style="color:red">{$LNG.bd_maxlevel}</span>
						</div>
					{elseif $IsLabinBuild || $IsFullQueue || !$Element.buyable}
						<div class="construct_button_lost">
							<span style="color:red">{if $Element.level == 0}{$LNG.bd_tech}{else}{$LNG.bd_tech_next_level}{$Element.levelToBuild + 1}{/if}</span>
						</div>
					{else}
						<form action="game.php?page=research" method="post" class="build_form">
							<input type="hidden" name="cmd" value="insert">
							<input type="hidden" name="tech" value="{$ID}">
							<button type="submit" class="build_submit construct_button">{if $Element.level == 0}{$LNG.bd_tech}{else}{$LNG.bd_tech_next_level}{$Element.levelToBuild + 1}{/if}</button>
						</form>
					{/if}
				</div>
			</div>
		</div>
	</div>
	{/foreach}
	<div class="clear"></div>

</div>
{/block}
{block name="script" append}
    {if !empty($Queue)}
        <script src="scripts/game/research.js"></script>
    {/if}
{/block}