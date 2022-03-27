{block name="title" prepend}{$LNG.lm_overview}{/block}
{block name="script" append}{/block}
{block name="content"}
    <div class="container">
        <div class="col-lg-12 buildings_headline">
            {if $authlevel >= 3}
                <div class="overview_player_admin center">
                    <div class="row">
                        <div class="col-lg-4">
                            <i class="fas fa-user"></i> {$LNG.ov_online_user} : <span
                                    style="font-weight: bold; color: lime;">{$onlineUser|number}</span>
                        </div>
                        <div class="col-lg-5">
                            {*<i class="fas fa-users"></i> {$LNG.ov_admins_online}
                            {foreach $AdminsOnline as $ID => $Name}{if !$Name@first}&nbsp;&bull;&nbsp;{/if}
                                <a href="#" onclick="return Dialog.PM({$ID})">{$Name}</a>
                                {foreachelse}{$LNG.ov_no_admins_online}
                           {/foreach}*}
                        </div>
                        <div class="col-lg-3">
                            {if $AdminsOnline|number > 0}
                                <a href="game.php?page=ticket"><i class="fas fa-ticket-alt green"></i> {$LNG.ov_ticket}
                                </a>
                            {else}
                                <a href="game.php?page=ticket"><i class="fas fa-ticket-alt red"></i> {$LNG.ov_ticket}
                                </a>
                            {/if}
                        </div>
                    </div>
                </div>
            {/if}

            <div class="col-lg-12 fleet_slot" style="position: relative;">
                {if $authlevel > 0}

                {/if}

                {foreach $fleets as $index => $fleet}
                    <div class="row ">
                        <div id="fleettime_{$index}" class="col-lg-2 fleets" data-fleet-end-time="{$fleet.returntime}"
                             data-fleet-time="{$fleet.resttime}">
                            {pretty_fly_time({$fleet.resttime})}
                        </div>
                        <div class="col-lg-10">{$fleet.text}</div>
                    </div>
                {/foreach}

            </div>

            <div class="" style="">
                <div id="contentPlanet"
                     style="background: url({$dpath}planeten/{$planetimage}.jpg) no-repeat; background-size: cover; margin-top: 10px;">

                    <div id="namePlanet">
                        <a href="#" onclick="return Dialog.PlanetAction();"
                           title="{$LNG.ov_planetmenu}">{$LNG["type_planet_{$planet_type}"]} "<span
                                    class="planetname">{$planetname}</span>"</a>
                    </div>

                    {if $planet_type == 1}
                        <div id="lunePlanet">
                            {if $Moon}<a href="game.php?page=overview&amp;cp={$Moon.id}&amp;re=0" title="{$Moon.name}">
                                <i
                                        class="fas fa-moon"></i> {$Moon.name} ({$LNG.fcm_moon})</a>{else}
                                <i class="far fa-moon"></i>
                                {$LNG.ov_create_moon}{/if}
                        </div>
                    {/if}

                    <div id="listDetailPlanet">
                        <table>
                            <tbody>
                            <tr>
                                <td class="desc">{$LNG.ov_diameter}</td>
                                <td class="data">{$planet_diameter} {$LNG.ov_distance_unit} (<a
                                            title="{$LNG.ov_developed_fields}">{$planet_field_current}</a> / <a
                                            title="{$LNG.ov_max_developed_fields}">{$planet_field_max}</a> {$LNG.ov_fields}
                                    )
                                </td>
                            </tr>
                            <tr>
                                <td class="desc">{$LNG.ov_temperature}</td>
                                <td class="data">{$LNG.ov_aprox} {$planet_temp_min}{$LNG.ov_temp_unit} {$LNG.ov_to} {$planet_temp_max}{$LNG.ov_temp_unit}</td>
                            </tr>
                            <tr>
                                <td class="desc">{$LNG.ov_position}</td>
                                <td class="data"><a
                                            href="game.php?page=galaxy&amp;galaxy={$galaxy}&amp;system={$system}">[{$galaxy}
                                        :{$system}:{$planet}]</a></td>
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
                        <i class="fas fa-hashtag"></i> {if $buildInfo.buildings}{$LNG.tech[$buildInfo.buildings['id']]}
                            <span class="level">({$buildInfo.buildings['level']})</span>
                            <br>
                            <div class="timer"
                                 data-time="{$buildInfo.buildings['timeleft']}">{$buildInfo.buildings['starttime']}</div>{else}{$LNG.ov_free}{/if}
                    </div>
                    <div class="listRech">
                        <div class="title">{$LNG.ov_list_title_tech}</div>
                        <i class="fas fa-hashtag"></i> {if $buildInfo.tech}{$LNG.tech[$buildInfo.tech['id']]}
                            <span class="level">({$buildInfo.tech['level']})</span>
                            <br>
                            <div class="timer"
                                 data-time="{$buildInfo.tech['timeleft']}">{$buildInfo.tech['starttime']}</div>{else}{$LNG.ov_free}{/if}
                    </div>
                    <div class="listFleet">
                        <div class="title">{$LNG.ov_list_title_fleet}</div>
                        <i class="fas fa-hashtag"></i> {if $buildInfo.fleet}{$LNG.tech[$buildInfo.fleet['id']]}
                            <span class="level">({$buildInfo.fleet['level']})</span>
                            <br>
                            <div class="timer"
                                 data-time="{$buildInfo.fleet['timeleft']}">{$buildInfo.fleet['starttime']}</div>{else}{$LNG.ov_free}{/if}
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
                        <div><input id="referral" type="text" value="{$path}index.php?ref={$userid}" readonly="readonly"
                                    style="width:450px;"/></div>

                        <table style="width: 100%;">
                            {foreach $RefLinks as $RefID => $RefLink}
                                <tr>
                                    <td colspan="2">
                                        <a href="#"
                                           onclick="return Dialog.Playercard({$RefID}, '{$RefLink.username}');">
                                            {$RefLink.username}
                                        </a>
                                    </td>
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
    </div>
{/block}
{block name="script" append}
    <script src="scripts/game/overview.js"></script>
    <script>
        $(document).ready(function () {

            $('.ttip').hover(function () {

                let id = $(this).attr('id');
                let text = $(this).data('tooltip-content');

                $('#' + id).append('<div class="' + id + '">' + text + '</div>');

                $('.' + id).css({
                    'background': '#343a40',
                    'position': 'absolute',
                    'width': '30rem',
                    'height': 'auto',
                    'border': '1px solid #000000',
                    'box-shadow': '5px 5px 21px 8px #000000',
                    '-webkit-box-shadow': '5px 5px 21px 8px #000000',
                    'z-index': '999',
                    'filter': 'Alpha(opacity=100)',
                    'opacity': '.9',
                    'moz-opacity': '1',
                    'padding': '15px',
                    'top': '5px',
                    'left': '30px',
                    'font-size': '1em',
                    'color': '#FFFFFF',
                })
            }, function () {
                let id = $(this).attr('id');
                $('.' + id).remove();
            });

        });
    </script>
{/block}