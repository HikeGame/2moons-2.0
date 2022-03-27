{block name="title" prepend}{$LNG.lm_faq}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.faq_overview}
	</div>

	<div>
		<table style="width: 100%;">
			<tr class="title">
				<th>{$questionRow.title}</th>
			</tr>
			<tr>
				<td class="left">
				{$questionRow.body}
				</td>
			</tr>
			<tr><th><a href="game.php?page=questions">{$LNG.al_back}</a></th>
			</tr>
		</table>
	</div>
</div>
{/block}