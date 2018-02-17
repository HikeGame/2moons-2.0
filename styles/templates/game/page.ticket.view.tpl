{block name="title" prepend}{$LNG.ti_read} - {$LNG.lm_support}{/block}
{block name="content"}

<form action="game.php?page=ticket&mode=send" method="post" id="form">
<input type="hidden" name="id" value="{$ticketID}">
	<div class="content_page">
		{foreach $answerList as $answerID => $answerRow}	
		{if $answerRow@first}
		<div class="title">
			{$LNG.ti_read} : {$answerRow.subject}
		</div>
		{/if}
		{/foreach}

		<div>
			<table style="width: 100%;">
			{foreach $answerList as $answerID => $answerRow}	
			<tr>
				<td class="left" colspan="2">
					{$LNG.ti_msgtime} <b>{$answerRow.time}</b> {$LNG.ti_from} <b>{$answerRow.ownerName}</b>
					{if $answerRow@first}
						<br>{$LNG.ti_category}: {$categoryList[$answerRow.categoryID]}
					{/if}
					<hr>
					<p>
						{$answerRow.message}
					</p>
				</td>
			</tr>
			{/foreach}
			{if $status < 2}
			<tr>
				<th colspan="2">{$LNG.ti_answer}</th>
			</tr>
			<tr>
				<td style="width:30%"><label for="message">{$LNG.ti_message}</label></td>
				<td style="width:70%"><textarea class="validate[required]" id="message" name="message" rows="60" cols="8" style="height:100px;"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="{$LNG.ti_submit}"></td>
			</tr>
			{/if}
		</table>
		</div>
	</div>
</form>

{/block}
{block name="script" append}
<script>
$(document).ready(function() {
	$("#form").validationEngine('attach');
});
</script>
{/block}