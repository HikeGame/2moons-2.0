{include file="overall_header.tpl"}
<center>
    <form action="" method="post">
        <input type="hidden" name="opt_save" value="1">
        <table width="70%" cellpadding="2" cellspacing="2">
            <tr>
                <th colspan="2">{$LNG.msg_expedition}</th><th>&nbsp;</th>
            </tr
            <tr>
                <td>{$LNG.msg_expedition_active}<br></td>
                <td><input name="expedition_limit_res_active"{if $expedition_limit_res_active} checked="checked"{/if}  type="checkbox"></td>
                <td><img src="./styles/resource/images/admin/i.gif" width="16" height="16" alt="" class="tooltip" data-tooltip-content="{$LNG.msg_expedition_active_desc}"></td>
            </tr>
            <tr>
                <td>{$LNG.msg_expedition_active_price}</td>
                <td><input name="expedition_limit_res" maxlength="40" size="60" value="{$expedition_limit_res}" type="text"></td>
                <td><img src="./styles/resource/images/admin/i.gif" width="16" height="16" alt="" class="tooltip" data-tooltip-content="{$LNG.msg_expedition_active_price_desc}"></td>
            </tr>
            <tr>
                <td colspan="3"><input value="{$LNG.se_save_parameters}" type="submit"></td>
            </tr>
        </table>
    </form>
</center>
{include file="overall_footer.tpl"}