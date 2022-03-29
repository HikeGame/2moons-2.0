{block name="title" prepend}{$LNG.lm_galaxy}{/block}
{block name="content"}
    <div class="col-lg-12 col-sm-12 content_page">
        <div class="row mb-3">
            <div>
                <h2 class="buildings_headline">
                    <div class="trader-headline">{$LNG["trade_BetaTest"]}</div>
                    {$LNG['lm_trader']}
                </h2>
                <p class="buildings_headline">
                    {$LNG["trade_Intro"]}
                <div class="toggleinfo-open"><i class="fa fa-info-circle"></i></div>
                </p>
                <div class="toggleinfo">
                    <p>
                        {$LNG["trade_InfoText"]}
                    </p>
                </div>
            </div>
        </div>

        <form name="sendResources" method="post" action="game.php?page=playertrader">
            <div class="row mt-2 mb-2">

                <div class="col-1">Versende:</div>
                <div class="col-1">
                    <input type="text" name="rescount" class="form-control" id="rescount" required autocomplete="false"
                           placeholder="{$LNG['rs_amount']}"/>
                </div>
                <div class="col-1">
                    <select name="res" class="form-control form-select form-select-sm" id="sendResource" required>
                        <option value="">Bitte wählen</option>
                        <option value="metal">{$LNG['rs_metal']}</option>
                        <option value="crystal">{$LNG['rs_crystal']}</option>
                        <option value="deuterium">{$LNG['rs_deuterium']}</option>
                    </select>
                    <input type="hidden" name="mode" value="sendResources"/>
                </div>

                <div class="col-2 center">{$LNG["trade_getPerResource"]}</div>
                <div class="col-1">
                    <input type="text" name="getrescount" class="form-control" id="getrescount" required
                           autocomplete="false" placeholder="{$LNG['rs_amount']}"/>
                </div>
                <div class="col-1">
                    <select name="sendres" class="form-control form-select form-select-sm" id="getResource" required>
                        <option value="">Bitte wählen</option>
                        <option value="metal">{$LNG['rs_metal']}</option>
                        <option value="crystal">{$LNG['rs_crystal']}</option>
                        <option value="deuterium">{$LNG['rs_deuterium']}</option>
                    </select>
                    <input type="hidden" name="mode" value="sendResources"/>
                </div>
                <div class="col-3">
                    <input type="submit" value="{$LNG['tr_exchange']}"/>
                </div>
            </div>
        </form>
    </div>
    <div class="col-lg-12 col-sm-12 content_page mt-3 trade-table" id="trade-table">
        <div class="row thead">
            <div class="col-2">{$LNG['gl_player']}</div>
            {*<div class="col-2">Aktiv seit</div>*}
            <div class="col-1">{$LNG['tr_amount']}</div>
            <div class="col-1">{$LNG['tr_resource']}</div>
            <div class="col-1">{$LNG['trade_for']}</div>
            <div class="col-1">{$LNG['tr_resource']}</div>
            <div class="col-1">{$LNG['tr_quota_exchange']}</div>
            <div class="col-3">{$LNG['trade_AmountToTrade']}</div>
        </div>
        {foreach item=Trade from=$Trades}
            {assign var="tradeNumber" value="{"10"|mt_rand:99999}-{$Trade.id}-{"10"|mt_rand:99999}-{"10"|mt_rand:99}" }
            <div class="col-12 mb-2">
                <div class="row {cycle values="odd,even"} player_trade_{$Trade.id}">
                    {*<div class="col-2">{$Trade.username}</div>
                    <div class="col-1">{$Trade.resCount|number_format:0:",":"."}</div>
                    <div class="col-1">{$Trade.buyRes}</div>
                    <div class="col-1">{$Trade.changeAmount|number_format:0:",":"."}</div>
                    <div class="col-1">{$Trade.sellRes}</div>*}

                    <div class="col-6">
                        {$Trade.username} bietet {$Trade.resCount|number_format:0:",":"."} {$Trade.buyRes} gegen {$Trade.changeAmount|number_format:0:",":"."} {$Trade.sellRes}
                    </div>

                    {if $Trade.resType == "crystal" AND $Trade.changeRes == "deuterium"}
                        <div class="col-1 course">1:{$CourseCD|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "crystal" AND $Trade.changeRes == "metal"}
                        <div class="col-1 course">1:{$CourseCM|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "metal" AND $Trade.changeRes == "deuterium"}
                        <div class="col-1 course">1:{$CourseMD|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "metal" AND $Trade.changeRes == "crystal"}
                        <div class="col-1 course">1:{$CourseMC|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "deuterium" AND $Trade.changeRes == "crystal"}
                        <div class="col-1 course">1:{$CourseDC|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "deuterium" AND $Trade.changeRes == "metal"}
                        <div class="col-1 course">1:{$CourseDM|number_format:2:',':'.'}</div>
                    {/if}
                    <div class="col-5 buyAmount">
                        {*{if ! isset($Trade.aus) }*}
                            <form name="letsTrade" method="post" action="game.php?page=playertrader" class="form_{$Trade.id}">
                                <input type="text" name="buyAmount" class="buyAmount" id="{$Trade.id}"/>
                                <input type="hidden" name="mode" value="tradeResources"/>
                                <input type="hidden" name="honeypot" value="{$tradeNumber|base64_encode}"/>
                                <input type="submit" class="trader-buy-button"
                                       value="{$Trade.buyRes} {$LNG['trade_buy']} und {$Trade.sellRes} verkaufen">
                            </form>
                        Verkauft {$Trade.buyRes} gegen {$Trade.sellRes}
                        {*{else}
                            {$LNG["trade_ownTrade"]}
                        {/if}*}
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
{/block}

