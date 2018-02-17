<div id="main_header">
	<div class="main_list_left">
		<ul>
			<li><a href="game.php?page=changelog" style="color: lime; font-weight: bold;">V{$VERSION|replace:'.git':''}</a></li>
			<li><a href="game.php?page=overview"><i class="fas fa-home"></i></a></li>
			{if isModuleAvailable($smarty.const.MODULE_IMPERIUM)}<li><a href="game.php?page=imperium"><i class="fas fa-globe"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_STATISTICS)}<li><a href="game.php?page=statistics"><i class="fas fa-chart-pie"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_BATTLEHALL)}<li><a href="game.php?page=battleHall"><i class="fas fa-crosshairs"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_RECORDS)}<li><a href="game.php?page=records"><i class="fas fa-chess-queen"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_SEARCH)}<li><a href="game.php?page=search"><i class="fas fa-search"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_MESSAGES)}<li><a href="game.php?page=messages"><i class="fas fa-envelope"></i>{nocache}{if $new_message > 0}<span id="newmes"> <span id="newmesnum">{if $new_message > 99}99+{else}{$new_message}{/if}</span></span>{/if}{/nocache}</a></li>{/if}
		</ul>
	</div>

	<a href="?cp={$previousPlanet}"><i class="fas fa-caret-left" style="font-size: 20px; margin: 5px; vertical-align: sub;"></i></a>
	<span id="planetSelectorWrapper">
        <label for="planetSelector"></label>
		<select id="planetSelector">
			{html_options options=$PlanetSelect selected=$current_pid}
		</select>
	</span>
	<a href="?cp={$nextPlanet}"><i class="fas fa-caret-right" style="font-size: 20px; margin: 5px; vertical-align: sub;"></i></a>

	<div class="main_list_right">
		<ul>
			{if isModuleAvailable($smarty.const.MODULE_TECHTREE)}<li><a href="game.php?page=techtree"><i class="fas fa-flask"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_BUDDYLIST)}<li><a href="game.php?page=buddyList"><i class="fas fa-user-circle"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_BANLIST)}<li><a href="game.php?page=banList"><i class="fas fa-user-times"></i></a></li>{/if}
			{if !empty($hasBoard)}<li><a href="game.php?page=board" target="forum"><i class="fas fa-comment-alt"></i></a></li>{/if}
			{if isModuleAvailable($smarty.const.MODULE_CHAT)}<li><a href="game.php?page=chat"><i class="fas fa-comments"></i></a></li>{/if}
			<li><a href="game.php?page=questions"><i class="fas fa-book"></i></a></li>
			<li><a href="game.php?page=settings"><i class="fas fa-wrench"></i></a></li>
			<li><a href="game.php?page=logout" style="color: red;"><i class="fas fa-power-off"></i></a></li>
		</ul>
	</div>
	<div class="clear"></div>
</div>