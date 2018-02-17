{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.al_name} {$LNG.al_change_title}
	</div>

	<div>
		<form action="game.php?page=alliance&amp;mode=admin&amp;action=changeName" method="post">
			<table style="width: 100%;">
				<tr>
					<td>{$LNG.al_new_name}</td>
					<td><input type="text" name="newname"> <input type="submit" value="{$LNG.al_change_submit}"></td>
				</tr>
				<tr>
					<th colspan="2"><a href="game.php?page=alliance&amp;mode=admin">{$LNG.al_back}</a></th>
				</tr>
			</table>
		</form>
	</div>
</div>
{/block}