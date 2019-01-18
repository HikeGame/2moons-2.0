<?php
/**
 * 2moons-2.0
 * The project is reserved for its owner for any bug or question you can contact him
 * Created by 2moons-2.0.
 * User: Danter14 (danter14000@gmail.com)
 * Copyright: 2019 - Danter14
 * GitHub: https://github.com/HikeGame/Spaccon-1.0
 * Date: 17/01/2019
 * File: ShowConfigModsPage.php
 * Version: 1.0.0
 */
if (!allowedTo(str_replace(array(dirname(__FILE__), '\\', '/', '.php'), '', __FILE__))) throw new Exception("Permission error!");

function ShowConfigModsPage()
{
    global $LNG;
    $config = Config::get(Universe::getEmulated());

    if (!empty($_POST))
    {
        $config_before = array(
            'expedition_limit_res'				=> $config->expedition_limit_res,
            'expedition_limit_res_active'				=> $config->expedition_limit_res_active,
        );

        $expedition_limit_res_active 				= isset($_POST['expedition_limit_res_active']) && $_POST['expedition_limit_res_active'] == 'on' ? 1 : 0;

        $expedition_limit_res				= HTTP::_GP('expedition_limit_res', 0);

        $config_after = array(
            'expedition_limit_res'				=> $expedition_limit_res,
            'expedition_limit_res_active'				=> $expedition_limit_res_active,
        );

        foreach($config_after as $key => $value)
        {
            $config->$key	= $value;
        }
        $config->save();

        $LOG = new Log(3);
        $LOG->target = 0;
        $LOG->old = $config_before;
        $LOG->new = $config_after;
        $LOG->save();
    }

    $template	= new template();

    $template->assign_vars(array(
        'expedition_limit_res'					=> $config->expedition_limit_res,
        'expedition_limit_res_active'				=> $config->expedition_limit_res_active,
    ));

    $template->show('ConfigModsBody.tpl');
}