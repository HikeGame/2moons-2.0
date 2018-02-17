{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.al_transfer_alliance}
	</div>

	<div>
		<form action="game.php?page=alliance&amp;mode=admin&amp;action=transfer" method="post">
			<table class="table519">
				<tr>
					<td>{$LNG.al_transfer_to}:</td>
					<td>{html_options name=newleader options=$transferUserList}</td>
					<td><input type="submit" value="{$LNG.al_transfer_submit}"></td>
				</tr>
				<tr>
					<th colspan="3"><a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></th>
				</tr>
			</table>
		</form>
	</div>
</div>

{/block}