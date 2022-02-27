{block name="content"}
<form action="game.php?page=messages" method="post">
<input type="hidden" name="mode" value="action">
<input type="hidden" name="ajax" value="1">
<input type="hidden" name="messcat" value="{$MessID}">
<input type="hidden" name="side" value="{$page}">

<div id="messagestable">
<div class="title" style="margin: 0 -5px 0 -5px;">
	{$LNG.mg_message_title}
</div>

<table style="width:100%;">
	{if $MessID != 999}
	<tr>
		<td colspan="4">
			<select name="actionTop">
				<option value="readmarked">{$LNG.mg_read_marked}</option>
				<option value="readtypeall">{$LNG.mg_read_type_all}</option>
				<option value="readall">{$LNG.mg_read_all}</option>
				<option value="deletemarked">{$LNG.mg_delete_marked}</option>
				<option value="deleteunmarked">{$LNG.mg_delete_unmarked}</option>
				<option value="deletetypeall">{$LNG.mg_delete_type_all}</option>
				<option value="deleteall">{$LNG.mg_delete_all}</option>
			</select>
			<input value="{$LNG.mg_confirm}" type="submit" name="submitTop">
		</td>
	</tr>
	{/if}
	<tr style="height: 20px;">
		<td class="right" colspan="4">{$LNG.mg_page}: {if $page != 1}<a href="#" onclick="Message.getMessages({$MessID}, {$page - 1});return false;">&laquo;</a>&nbsp;{/if}{for $site=1 to $maxPage}<a href="#" onclick="Message.getMessages({$MessID}, {$site});return false;">{if $site == $page}<b>[{$site}]</b>{else}[{$site}]{/if}</a>{if $site != $maxPage}&nbsp;{/if}{/for}{if $page != $maxPage}&nbsp;<a href="#" onclick="Message.getMessages({$MessID}, {$page + 1});return false;">&raquo;</a>{/if}</td>
	</tr>
	<tr style="height: 20px;">
		<td>{$LNG.mg_action}</td>
		<td>{$LNG.mg_date}</td>
		<td>
			{if $MessID != 999}{$LNG.mg_from}{else}{$LNG.mg_to}{/if}
		</td>
		<td>{$LNG.mg_subject}</td>
	</tr>
	{foreach $MessageList as $Message}
	<tr id="message_{$Message.id}" class="title message_head{if $MessID != 999 && $Message.unread == 1} mes_unread{/if}">
		<td style="width:40px;" rowspan="2">
		{if $MessID != 999}<input name="messageID[{$Message.id}]" value="1" type="checkbox">{/if}
		</td>
		<td>{$Message.time}</td>
		<td>{$Message.from}</td>
		<td>{$Message.subject}
		{if $Message.type == 1 && $MessID != 999}
		<a href="#" onclick="return Dialog.PM({$Message.sender}, Message.CreateAnswer('{$Message.subject}'));" title="{$LNG.mg_answer_to} {strip_tags($Message.from)}"><i class="far fa-envelope" title="{$LNG.Messages}" style="font-size: 15px;"></i></a>
		{/if}
		</td>
	</tr>
	<tr class="messages_body">
		<td colspan="3" class="left" style="padding: 10px; background: rgba(0,0,0,0.7);">
		{$Message.text}
		</td>
	</tr>
	{/foreach}
	<tr style="height: 20px;">
		<td class="right" colspan="4">{$LNG.mg_page}: {if $page != 1}<a href="#" onclick="Message.getMessages({$MessID}, 1);return false;">&laquo;</a>&nbsp;{/if}{for $site=1 to $maxPage}<a href="#" onclick="Message.getMessages({$MessID}, {$site});return false;">{if $site == $page}<b>[{$site}]</b>{else}[{$site}]{/if}</a>{if $site != $maxPage}&nbsp;{/if}{/for}{if $page != $maxPage}&nbsp;<a href="#" onclick="Message.getMessages({$MessID}, {$maxPage});return false;">&raquo;</a>{/if}</td>
	</tr>
	{if $MessID != 999}
	<tr>
		<td colspan="4">
			<select name="actionBottom">
				<option value="readmarked">{$LNG.mg_read_marked}</option>
				<option value="readtypeall">{$LNG.mg_read_type_all}</option>
				<option value="readall">{$LNG.mg_read_all}</option>
				<option value="deletemarked">{$LNG.mg_delete_marked}</option>
				<option value="deleteunmarked">{$LNG.mg_delete_unmarked}</option>
				<option value="deletetypeall">{$LNG.mg_delete_type_all}</option>
				<option value="deleteall">{$LNG.mg_delete_all}</option>
			</select>
			<input value="{$LNG.mg_confirm}" type="submit" name="submitBottom">
		</td>
	</tr>
	{/if}
</table>
</div>
</form>
{/block}