{block name="title" prepend}{$LNG.lm_changelog}{/block}
{block name="content"}
<div class="content_page">
	<div class="title">
		{$LNG.lm_changelog}
	</div>

	<div>
		<table style="width: 100%;">
			<tr>
				<td class="left" style="padding: 0 10px">{$ChangelogList}</td>
			</tr>
		</table>
	</div>
</div>
{/block}