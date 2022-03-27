{block name="title" prepend}{$LNG.lm_technology}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.lm_technology}
	</div>

	<div id="result_search" style="text-align: center;">
		<table style="min-width:100%;width:100%;">
			{foreach $TechTreeList as $elementID => $requireList}
			{if !is_array($requireList)}
			<tr class="title">
				<th colspan="2">{$LNG.tech.$requireList}</th>
				<th>{$LNG.tt_requirements}</th>
			</tr>
			{else}
			<tr>
				<td><a href="#" onclick="return Dialog.info({$elementID})"><img src="{$dpath}gebaeude/{$elementID}.{if $elementID >=600 && $elementID <= 699}jpg{else}gif{/if}" width="50" height="50"></a></td>
				<td><a href="#" onclick="return Dialog.info({$elementID})">{$LNG.tech.$elementID}</a></td>
				<td>
				{if $requireList}
					{foreach $requireList as $requireID => $NeedLevel}
						<a href="#" onclick="return Dialog.info({$elementID})"><span style="color:{if $NeedLevel.own < $NeedLevel.count}red{else}lime{/if};">{$LNG.tech.$requireID} ({$LNG.tt_lvl} {min($NeedLevel.count, $NeedLevel.own)}/{$NeedLevel.count})</span></a>{if !$NeedLevel@last}<br>{/if}
					{/foreach}
				{/if}
				</td>
			</tr>
			{/if}
			{/foreach}
		</table>
	</div>
</div>
{/block}