{include file="overall_header.tpl"}
<form action="" method="post">
<table width="45%">
<tr>
<td colspan="3" align="left"><a href="?page=accounteditor">
<img src="./styles/resource/images/admin/arrowright.png" width="16" height="10"> {$LNG.ad_back_to_menu}</a></td>
</tr><tr>
	<th colspan="7">{$LNG.ad_pla_title}</th>
</tr><tr>
	<td>{$LNG.input_id_p_m}</td>
	<td><input name="id" type="text" size="5" maxlength="5"></td>
</tr><tr>
	<td>{$LNG.ad_pla_edit_name}</td>
	<td><input name="name" type="text" size="20"></td>
</tr><tr>
	<td>{$LNG.ad_pla_edit_diameter}</td>
	<td><input name="diameter" type="text" size="5"></td>
</tr><tr>
	<td>{$LNG.ad_pla_edit_fields}</td>
	<td><input name="fields" type="text" size="5"></td>
</tr><tr>
	<td>{$LNG.ad_pla_delete_b}</td>
	<td><input name="0_buildings" type="checkbox"></td>
</tr><tr>
	<td>{$LNG.ad_pla_delete_s}</td>
	<td><input name="0_ships" type="checkbox"></td>
</tr><tr>
	<td>{$LNG.ad_pla_delete_d}</td>
	<td><input name="0_defenses" type="checkbox"></td>
</tr><tr>
	<td>{$LNG.ad_pla_delete_hd}</td>
	<td><input name="0_c_hangar" type="checkbox"></td>
</tr><tr>
	<td>{$LNG.ad_pla_delete_cb}</td>
	<td><input name="0_c_buildings" type="checkbox"></td>
</tr><tr>
	<td><a href="#" class="tooltip" data-tooltip-content="{$LNG.ad_pla_title_l}">{$LNG.ad_pla_change_p}</a></td>
	<td><input name="change_position" type="checkbox" title="{$LNG.ad_pla_change_pp}">
	<input name="g" type="text" size="1" maxlength="1"> : <input name="s" type="text" size="3" maxlength="3"> : <input name="p" type="text" size="2" maxlength="2"></td>
</tr><tr>
	<td colspan="3"><input type="submit" value="{$LNG.button_submit}">&nbsp;
	<input type="reset" value="{$LNG.button_reset}"></td>
</tr>
</table>
</form>
{include file="overall_footer.tpl"}