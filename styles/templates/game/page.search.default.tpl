{block name="title" prepend}{$LNG.lm_search}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.sh_search_in_the_universe} <span id="loading" style="display:none;">{$LNG.sh_loading}</span>
	</div>

	<div id="result_search" style="text-align: center;">
		<table style="width:100%;">
			<tr>
				<td>
					{html_options options=$modeSelector name="type" id="type"}
					<input type="text" name="searchtext" id="searchtext">
					<input type="button" value="{$LNG.sh_search}">
				</td>
			</tr>
		</table>
	</div>
</div>
{/block}