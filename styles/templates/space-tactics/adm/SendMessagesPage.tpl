{include file="overall_header.tpl"}
<script type="text/javascript">

function check(){
	if($('#text').val().length == 0) {
		Dialog.alert('{$LNG.mg_empty_text}');
		return false;
	} else {
		$.post('admin.php?page=globalmessage&action=send&ajax=1', $('#message').serialize(), function(data) {
			Dialog.alert(data, function() {
				location.reload();
			});
		});
		return true;
	}
}
</script>
<form name="message" id="message" action="admin.php?page=globalmessage&action=send&ajax=1">
<table class="table569">
		<tr>
            <th colspan="2">{$LNG.ma_send_global_message}</th>
        </tr>
        <tr>
            <td>{$LNG.ma_mode}</td>
            <td>{html_options name=mode options=$modes}</td>
		</tr>
        <tr>
            <td>{$LNG.se_lang}</td>
            <td>{html_options name=globalmessagelang options=$langSelector}</td>
        </tr>
        <tr>
            <td>{$LNG.ma_subject}</td>
            <td><input name="subject" id="subject" size="40" maxlength="40" value="{$LNG.ma_none}" type="text"></td>
        </tr>
		<tr>
            <td>{$LNG.ma_message} (<span id="cntChars">0</span> / 5000 {$LNG.ma_characters})</td>
            <td><textarea name="text" id="text" cols="40" rows="10" onkeyup="$('#cntChars').text($('#text').val().length);"></textarea></td>
        </tr>
        <tr>
            <td colspan="2"><input type="button" onclick="check();" value="{$LNG.button_submit}"></td>
        </tr>
    </table>
</form>
{include file="overall_footer.tpl"}
