{block name="title" prepend}{$LNG.lm_statistics}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.st_statistics} ({$LNG.st_updated}: {$stat_date})
	</div>

	<div>
		<form name="stats" id="stats" method="post" action="">
			<table style="width: 100%; text-align: center;">
				<tr>
					<td style="padding: 10px;">
						<span style="margin-right: 10px;"><label for="who">{$LNG.st_show}</label> <select name="who" id="who" onchange="$('#stats').submit();">{html_options options=$Selectors.who selected=$who}</select></span>
						<span style="margin-right: 10px;"><label for="type">{$LNG.st_per}</label> <select name="type" id="type" onchange="$('#stats').submit();">{html_options options=$Selectors.type selected=$type}</select></span>
						<span><label for="range">{$LNG.st_in_the_positions}</label> <select name="range" id="range" onchange="$('#stats').submit();">{html_options options=$Selectors.range selected=$range}</select></span>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div>
		<table style="width: 100%;">
			{if $who == 1}
				{include file="shared.statistics.playerTable.tpl"}
			{elseif $who == 2}
				{include file="shared.statistics.allianceTable.tpl"}
			{/if}
		</table>
	</div>
</div>
{/block}