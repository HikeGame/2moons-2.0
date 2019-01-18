<?php

/**
 *  2Moons
 *  Copyright (C) 2011  Slaver
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @package 2Moons
 * @author Slaver <slaver7@gmail.com>
 * @copyright 2009 Lucky <lucky@xgproyect.net> (XGProyecto)
 * @copyright 2011 Slaver <slaver7@gmail.com> (Fork/2Moons)
 * @license http://www.gnu.org/licenses/gpl.html GNU GPLv3 License
 * @version 1.5 (2011-07-31)
 * @info $Id: CUSTOM.php 2095 2011-12-21 19:39:40Z slaver7 $
 * @link http://code.google.com/p/2moons/
 */
 
// If you have custom lang vars, you can include them here. The file ll be not overwrite by updatemanager
// Also you can overwrite exists var, too. You use the same key.

/**
 * main.navigation.tpl
**/
$LNG['mn_username']			= "Pseudo";

/**
 * page.overview.default.tpl
**/
$LNG['ov_online_user']			= "Joueurs en ligne";
$LNG['ov_ticket']				= "Ticket";
$LNG['ov_create_moon']			= "Créer une lune";
$LNG['ov_list_title_build']		= "Bâtiment";
$LNG['ov_list_title_tech']		= "Recherche";
$LNG['ov_list_title_fleet']		= "Flotte/Défense";

/**
 * Admin
 */
// ShowMenuPage.tpl
$LNG['mu_mods_settings'] = "Configurer les Mods";
// ConfigModsBody.tpl
$LNG['msg_expedition'] = "Configuration Expédition";
$LNG['msg_expedition_active'] = "Système de limite";
$LNG['msg_expedition_active_desc'] = "Lors de l'activation de ce système vous pouvez mettre une limite sur les ressource trouver lors d'une expédition par les joueurs";
$LNG['msg_expedition_active_price'] = "Montant des ressources maximum";
$LNG['msg_expedition_active_price_desc'] = "Montant maximum que le joueur peut trouver lors d'une expédition même si la capacité est supérieur";