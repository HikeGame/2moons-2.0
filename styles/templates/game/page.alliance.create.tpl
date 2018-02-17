{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.al_make_alliance}
	</div>

	<div>
		<form action="game.php?page=alliance&amp;mode=create&amp;action=send" method="POST">
			<table style="width: 100%;">
				<tr>
					<td>{$LNG.al_make_ally_tag_required}</td>
					<td><input type="text" name="atag" size="8" maxlength="8" value=""></td>
				</tr>
				<tr>
					<td>{$LNG.al_make_ally_name_required}</th>
					<td><input type="text" name="aname" size="20" maxlength="30" value=""></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="{$LNG.al_make_submit}"></td>
				</tr>
			</table>
		</form>
	</div>
</div>

{/block}