{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="script" append}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		<div class="onligne">
			<i class="fas fa-user"></i> {$LNG.ov_online_user} : <span style="font-weight: bold; color: lime;">{$onlineUser|number}</span>
		</div>
		<span><i class="fas fa-users"></i> {$LNG.ov_admins_online} : {foreach $AdminsOnline as $ID => $Name}{if !$Name@first}&nbsp;&bull;&nbsp;{/if}<a href="#" onclick="return Dialog.PM({$ID})">{$Name}</a>{foreachelse}{$LNG.ov_no_admins_online}{/foreach}</span>
		<div class="ticket">
			<a href="game.php?page=ticket"><i class="fas fa-ticket-alt"></i> {$LNG.ov_ticket}</a>
		</div>
	</div>

	<div>
		<table style="width: 100%;">
			{foreach $fleets as $index => $fleet}
			<tr>
				<td id="fleettime_{$index}" class="fleets" data-fleet-end-time="{$fleet.returntime}" data-fleet-time="{$fleet.resttime}">{pretty_fly_time({$fleet.resttime})}</td>
				<td colspan="2">{$fleet.text}</td>
			</tr>
			{/foreach}
		</table>
	</div>

	<div>
		<div id="contentPlanet" style="background: url({$dpath}planeten/{$planetimage}.jpg) no-repeat; background-size: cover; margin-top: 10px;">

			<div id="namePlanet">
				<a href="#" onclick="return Dialog.PlanetAction();" title="{$LNG.ov_planetmenu}">{$LNG["type_planet_{$planet_type}"]} "<span class="planetname">{$planetname}</span>"</a>
			</div>

			{if $planet_type == 1}
			<div id="lunePlanet">
				{if $Moon}<a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0" title="{$Moon.name}"><i class="fas fa-moon"></i> {$Moon.name} ({$LNG.fcm_moon})</a>{else}<i class="far fa-moon"></i> {$LNG.ov_create_moon}{/if}
			</div>
			{/if}

			<div id="listDetailPlanet">
				<table>
					<tbody>
						<tr>
							<td class="desc">{$LNG.ov_diameter}</td>
							<td class="data">{$planet_diameter} {$LNG.ov_distance_unit} (<a title="{$LNG.ov_developed_fields}">{$planet_field_current}</a> / <a title="{$LNG.ov_max_developed_fields}">{$planet_field_max}</a> {$LNG.ov_fields})</td>
						</tr>
						<tr>
							<td class="desc">{$LNG.ov_temperature}</td>
							<td class="data">{$LNG.ov_aprox} {$planet_temp_min}{$LNG.ov_temp_unit} {$LNG.ov_to} {$planet_temp_max}{$LNG.ov_temp_unit}</td>
						</tr>
						<tr>
							<td class="desc">{$LNG.ov_position}</td>
							<td class="data"><a href="game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}:{$system}:{$planet}]</a></td>
						</tr>
						<tr>
							<td class="desc">{$LNG.ov_points}</td>
							<td class="data">{$rankInfo}</td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>

		<div>
			<div class="listBat">
				<div class="title">{$LNG.ov_list_title_build}</div>
				<i class="fas fa-hashtag"></i> {if $buildInfo.buildings}{$LNG.tech[$buildInfo.buildings['id']]} <span class="level">({$buildInfo.buildings['level']})</span><br><div class="timer" data-time="{$buildInfo.buildings['timeleft']}">{$buildInfo.buildings['starttime']}</div>{else}{$LNG.ov_free}{/if}
			</div>
			<div class="listRech">
				<div class="title">{$LNG.ov_list_title_tech}</div>
				<i class="fas fa-hashtag"></i> {if $buildInfo.tech}{$LNG.tech[$buildInfo.tech['id']]} <span class="level">({$buildInfo.tech['level']})</span><br><div class="timer" data-time="{$buildInfo.tech['timeleft']}">{$buildInfo.tech['starttime']}</div>{else}{$LNG.ov_free}{/if}
			</div>
			<div class="listFleet">
				<div class="title">{$LNG.ov_list_title_fleet}</div>
				<i class="fas fa-hashtag"></i> {if $buildInfo.fleet}{$LNG.tech[$buildInfo.fleet['id']]} <span class="level">({$buildInfo.fleet['level']})</span><br><div class="timer" data-time="{$buildInfo.fleet['timeleft']}">{$buildInfo.fleet['starttime']}</div>{else}{$LNG.ov_free}{/if}
			</div>
			<div class="clear"></div>
		</div>

		{if $is_news}
		<div>
			<div class="title">{$LNG.ov_news}</div>
			<div>{$news}</div>
		</div>
		{/if}

		{if $ref_active}
		<div style="margin-top: 10px; text-align: center;">
			<div class="title">{$LNG.ov_reflink}</div>
			<div><input id="referral" type="text" value="{$path}index.php?ref={$userid}" readonly="readonly" style="width:450px;" /></div>

			<table style="width: 100%;">
				{foreach $RefLinks as $RefID => $RefLink}
				<tr>
					<td colspan="2"><a href="#" onclick="return Dialog.Playercard({$RefID}, '{$RefLink.username}');">{$RefLink.username}</a></td>
					<td>{{$RefLink.points|number}} / {$ref_minpoints|number}</td>
				</tr>
				{foreachelse}
				<tr>
					<td colspan="3">{$LNG.ov_noreflink}</td>
				</tr>
				{/foreach}
			</table>
		</div>
		{/if}
	</div>
</div>
{/block}
{block name="script" append}
    <script src="scripts/game/overview.js"></script>
{/block}