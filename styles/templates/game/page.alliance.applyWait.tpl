{block name="title" prepend}{$LNG.lm_research}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.al_your_request_title}
	</div>

	<div>
		<form action="game.php?page=alliance&amp;mode=cancelApply" method="post">
			<table style="width: 100%;">
				<tr>
					<td>{$request_text}</td>
				</tr>
				<tr>
					<td><input type="submit" value="{$LNG.al_continue}"></td>
				</tr>
			</table>
		</form>
	</div>
</div>
{/block}