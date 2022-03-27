{include file="overall_header.tpl"}
<table width="80%">
<tr>
	<th>{$LNG.cronjob_id}</th>
	<th>{$LNG.cronjob_name}</th>
	<th>{$LNG.cronjob_min}</th>
	<th>{$LNG.cronjob_hours}</th>
	<th>{$LNG.cronjob_dom}</th>
	<th>{$LNG.cronjob_month}</th>
	<th>{$LNG.cronjob_dow}</th>
	<th>{$LNG.cronjob_class}</th>
	<th>{$LNG.cronjob_nextTime}</th>
	<th>{$LNG.cronjob_inActive}</th>
	<th>{$LNG.cronjob_lock}</th>
	<th>{$LNG.cronjob_edit}</th>
	<th>{$LNG.cronjob_delete}</th>
</tr>
{foreach item=CronjobInfo from=$CronjobArray}
<tr>
	<td>{$CronjobInfo.id}</td>
	<td>{$LNG["cronName_{$CronjobInfo.name}"]}</td>
	<td>{$CronjobInfo.min}</td>
	<td>{$CronjobInfo.hours}</td>
	<td>{$CronjobInfo.dom}</td>
	<td>{if $CronjobInfo.month == '*'}{$CronjobInfo.month}{else}{foreach item=month from=$CronjobInfo.month}{$LNG.months.{$month-1}}{/foreach}{/if}</td>
	<td>{if $CronjobInfo.dow == '*'}{$CronjobInfo.dow}{else}{foreach item=d from=$CronjobInfo.dow}{$LNG.week_day.{$d}} {/foreach}{/if}</td>
	<td>{$CronjobInfo.class}</td>
	<td>{if $CronjobInfo.isActive}{date($LNG.php_tdformat, $CronjobInfo.nextTime)}{else}-{/if}</td>
	<td><a href="admin.php?page=cronjob&amp;action=enable&amp;id={$CronjobInfo.id}&amp;enable={if $CronjobInfo.isActive}0" style="color:lime">{$LNG.cronjob_inactive}{else}1" style="color:red">{$LNG.cronjob_active}{/if}</a></td>
	<td><a href="admin.php?page=cronjob&amp;id={$CronjobInfo.id}&amp;action={if $CronjobInfo.lock}unlock" style="color:red">{$LNG.cronjob_is_lock}{else}lock" style="color:lime">{$LNG.cronjob_is_unlock}{/if}</a></td>
	<td><a href="admin.php?page=cronjob&amp;action=detail&amp;id={$CronjobInfo.id}"><img src="./styles/resource/images/admin/GO.png"></a></td>
	<td><a href="admin.php?page=cronjob&amp;action=delete&amp;id={$CronjobInfo.id}"><img src="./styles/resource/images/false.png" width="16" height="16"></a></td>
</tr>
{/foreach}
<tr>
<td colspan="13"><a href="admin.php?page=cronjob&amp;action=detail">{$LNG.cronjob_new}</a></td>
</tr>
</table>
</body>
{include file="overall_footer.tpl"}