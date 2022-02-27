{block name="title" prepend}{$LNG.lm_galaxy}{/block}
{block name="content"}
    <div class="col-lg-12 col-sm-12 content_page">
        <div class="row mb-3">
            <div>
                <h2 class="buildings_headline">Händler</h2>
                <p class="buildings_headline">
                    Du brauchst Resourcen ? Dann bist du hier genau richtig. Hier ist einfach alles <strike>gut</strike>
                    ... teuer, ewig weit weg und von minderer Qualität.
                </p>
            </div>
        </div>

        <form name="sendResources" method="post" action="game.php?page=playertrader">
            <div class="row mt-2 mb-2">

                <div class="col-1">Versende:</div>
                <div class="col-1">
                    <input type="text" name="rescount" class="form-control" id="rescount" required autocomplete="false"
                           placeholder="Anzahl"/>
                </div>
                <div class="col-1">
                    <select name="res" class="form-control form-select form-select-sm" id="sendResource" required>
                        <option value="">Bitte wählen</option>
                        <option value="metal">Metall</option>
                        <option value="crystal">Kristall</option>
                        <option value="deuterium">Deuterium</option>
                    </select>
                    <input type="hidden" name="mode" value="sendResources"/>
                </div>

                <div class="col-2 center">und erhalte pro Resource:</div>
                <div class="col-1">
                    <input type="text" name="getrescount" class="form-control" id="getrescount" required
                           autocomplete="false" placeholder="Anzahl"/>
                </div>
                <div class="col-1">
                    <select name="sendres" class="form-control form-select form-select-sm" id="getResource" required>
                        <option value="">Bitte wählen</option>
                        <option value="metal">Metall</option>
                        <option value="crystal">Kristall</option>
                        <option value="deuterium">Deuterium</option>
                    </select>
                    <input type="hidden" name="mode" value="sendResources"/>
                </div>
                <div class="col-3">
                    <input type="submit" value="Versenden"/>
                </div>
            </div>
        </form>
    </div>
    <div class="col-lg-12 col-sm-12 content_page mt-3 trade-table" id="trade-table">
        <div class="row thead">
            <div class="col-2">Player</div>
            {*<div class="col-2">Aktiv seit</div>*}
            <div class="col-1">Menge</div>
            <div class="col-1">Resource</div>
            <div class="col-1">gegen</div>
            <div class="col-1">Resource</div>
            <div class="col-1">Kurs</div>
            <div class="col-3">Anzahl</div>
        </div>
        {foreach item=Trade from=$Trades}
            {assign var="tradeNumber" value="{"10"|mt_rand:99999}-{$Trade.id}-{"10"|mt_rand:99999}-{"10"|mt_rand:99}" }
            <div class="col-12 mb-2">
                <div class="row {cycle values="odd,even"} player_trade_{$Trade.id}">
                    <div class="col-2">{$Trade.username}</div>
                    <div class="col-1">{$Trade.resCount|number_format:0:",":"."}</div>
                    <div class="col-1">{$Trade.resType|ucfirst}</div>
                    <div class="col-1">{$Trade.changeAmount|number_format:0:",":"."}</div>
                    <div class="col-1">{$Trade.changeRes|ucfirst}</div>
                    {if $Trade.resType == "crystal" AND $Trade.changeRes == "deuterium"}
                        <div class="col-1">1:{$CourseCD|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "crystal" AND $Trade.changeRes == "metal"}
                        <div class="col-1">1:{$CourseCM|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "metal" AND $Trade.changeRes == "deuterium"}
                        <div class="col-1">1:{$CourseMD|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "metal" AND $Trade.changeRes == "crystal"}
                        <div class="col-1">1:{$CourseMC|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "deuterium" AND $Trade.changeRes == "crystal"}
                        <div class="col-1">1:{$CourseDC|number_format:2:',':'.'}</div>
                    {elseif $Trade.resType == "deuterium" AND $Trade.changeRes == "metal"}
                        <div class="col-1">1:{$CourseDM|number_format:2:',':'.'}</div>
                    {/if}
                    <div class="col-3 buyAmount">
                        <form name="letsTrade" method="post" action="game.php?page=playertrader">
                        <input type="text" name="buyAmount">
                            <input type="hidden" name="mode" value="tradeResources" />
                            <input type="hidden" name="honeypot" value="{$tradeNumber|base64_encode}" />
                        <input type="submit" class="trader-buy-button" value="Kaufen">
                        </form>
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
    {*<div class="col-12 mt-3 content_page">
        <div class="courses">
            <div class="col-1">Kurse:</div>
            <div class="col-2">Metall -> Deuterium: 1:{$CourseMD|number_format:2:',':'.'}</div>
            <div class="col-2">Metall -> Kristall: 1:{$CourseMC|number_format:2:',':'.'}</div>
            <div class="col-2">Kristall -> Deuterium: 1:{$CourseCD|number_format:2:',':'.'}</div>
            <div class="col-2">Kristall -> Metall: 1:{$CourseCM|number_format:2:',':'.'}</div>
            <div class="col-2">Deuterium -> Kristall: 1:{$CourseDC|number_format:2:',':'.'}</div>
            <div class="col-2">Deuterium -> Metall: 1:{$CourseDM|number_format:2:',':'.'}</div>
        </div>
    </div>*}
{/block}

<script>

    $(document).ready( function () {
        $('#trade-table').DataTable();
    } );


</script>