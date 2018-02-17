{block name="title" prepend}{$LNG.lm_alliance}{/block}
{block name="content"}

<div class="content_page_popup">
	<div class="title_popup">
		{$LNG.al_circular_send_ciruclar}
	</div>

	<div class="content_popup">
		<form name="message" id="message">
			<table style="width:100%;">
				<tr>
					<td>{$LNG.al_receiver}</td>
					<td>
					{html_options name=rankID options=$RangeList}
					</td>
				</tr><tr>
				<td>{$LNG.mg_subject}</td>
				<td><input type="text" name="subject" id="subject" size="40" maxlength="40" value="{$LNG.mg_no_subject}"></td>
				</tr>
				<tr>
					<td>{$LNG.al_message} (<span id="cntChars">0</span> / 5000 {$LNG.al_characters})</td>
					<td>
						<textarea style="height: 169px;" name="text" cols="60" rows="10" onkeyup="$('#cntChars').text($(this).val().length);"></textarea>
					</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align:center;">
					<input type="reset" value="{$LNG.al_circular_reset}">
					<input type="button" onClick="return check();" name="button" value="{$LNG.al_circular_send_submit}">
					</th>
				</tr>
			</table>
		</form>
	</div>
</div>

{/block}
{block name="script" append}
<script type="text/javascript">
function check(){
	if(document.message.text.value == '') {
		alert('{$LNG.mg_empty_text}');
		return false;
	} else {
		$.post('game.php?page=alliance&mode=circular&action=send&ajax=1', $('#message').serialize(), function(data){
			data = $.parseJSON(data);
			alert(data.message);
			if(!data.error) {
				parent.$.fancybox.close();
			}
		});
		return true;
	}
}
</script>
{/block}