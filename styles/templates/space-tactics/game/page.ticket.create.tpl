{block name="title" prepend}{$LNG.ti_create_head} - {$LNG.lm_support}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.ti_create_head}
	</div>

	<div>
		<form action="game.php?page=ticket&mode=send" method="post" id="form">
		<input type="hidden" name="id" value="0">
		<table style="width:100%;">
			<tr>
				<td colspan="2" class="left">{$LNG.ti_create_info}</td>
			</tr>
			<tr>
				<td style="width:30%"><label for="category">{$LNG.ti_category}</label></td>
				<td style="width:70%"><select id="category" name="category">{html_options options=$categoryList}</select></td>
			</tr>
			<tr>
				<td><label for="subject">{$LNG.ti_subject}</label></td>
				<td><input class="validate[required]" type="text" id="subject" name="subject" size="40" maxlength="255"></td>
			</tr>
			<tr>
				<td><label for="message">{$LNG.ti_message}</label></td>
				<td><textarea class="validate[required]" id="message" name="message" row="60" cols="8" style="height:100px;"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="{$LNG.ti_submit}"></td>
			</tr>
		</table>
		</form>
	</div>
</div>

{/block}
{block name="script" append}
<script>
$(document).ready(function() {
$("#form").validationEngine('attach');
});
</script>
{/block}