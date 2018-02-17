{block name="title" prepend}{$LNG.lm_faq}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.faq_overview}
	</div>

	<div>
		<table style="width: 100%;">
			<tr>
				<td class="left">{foreach $LNG.questions as $categoryID => $categoryRow}<h2>{$categoryRow.category}</h2>
				<ul>
				{foreach $categoryRow as $questionID => $questionRow}
				{if is_numeric($questionID)}
					<li><a href="game.php?page=questions&amp;mode=single&amp;categoryID={$categoryID}&amp;questionID={$questionID}">{$questionRow.title}</a></li>
				{/if}
				{/foreach}
				</ul>
				{/foreach}</td>
			</tr>
		</table>
	</div>
</div>
{/block}