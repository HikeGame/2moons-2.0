<div id="leftmenu">
	<div class="menu_header">
		{$LNG.mn_username} : <span style="color: cyan; font-weight: bold;">{$username}</span>
	</div>

	<div class="menu_content_left">
		{if isModuleAvailable($smarty.const.MODULE_BUILDING)}<a href="game.php?page=buildings">{$LNG.lm_buildings}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_RESEARCH)}<a href="game.php?page=research">{$LNG.lm_research}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_SHIPYARD_FLEET)}<a href="game.php?page=shipyard&amp;mode=fleet">{$LNG.lm_shipshard}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_SHIPYARD_DEFENSIVE)}<a href="game.php?page=shipyard&amp;mode=defense">{$LNG.lm_defenses}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_OFFICIER) || isModuleAvailable($smarty.const.MODULE_DMEXTRAS)}<a href="game.php?page=officier">{$LNG.lm_officiers}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_FLEET_TRADER)}<a href="game.php?page=fleetDealer">{$LNG.lm_fleettrader}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_TRADER)}<a href="game.php?page=fleetTable">{$LNG.lm_fleet}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_RESSOURCE_LIST)}<a href="game.php?page=resources">{$LNG.lm_resources}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_GALAXY)}<a href="game.php?page=galaxy">{$LNG.lm_galaxy}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_ALLIANCE)}<a href="game.php?page=alliance">{$LNG.lm_alliance}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_SUPPORT)}<a href="game.php?page=ticket">{$LNG.lm_support}</a>{/if}
		<a href="index.php?page=rules" target="rules">{$LNG.lm_rules}</a>
		{if isModuleAvailable($smarty.const.MODULE_SIMULATOR)}<a href="game.php?page=battleSimulator">{$LNG.lm_battlesim}</a>{/if}
		{if isModuleAvailable($smarty.const.MODULE_NOTICE)}<a href="javascript:OpenPopup('?page=notes', 'notes', 720, 300);">{$LNG.lm_notes}</a>{/if}
		<div class="clear"></div>
	</div>

	<div class="menu_content_full">
		{if $authlevel > 0}<a href="./admin.php" style="color:lime">{$LNG.lm_administration}</a>{/if}
	</div>

	<div class="menu_footer">
		<div><i class="fas fa-clock"></i> <span class="servertime">{$servertime}</span></div>
		<div><i class="far fa-copyright"></i> Copyright {$game_name} 2018</div>
	</div>
</div>