    <div class="res_header">
        <div class="container-fluid">
            <div class="col-lg-12 center">
                <div class="row">

                    {foreach $resourceTable as $resourceID => $resourceData}

                        {if $resourceID != 921}

                        {if $resourceID != 911}{assign "resClass" "cont_{$resourceData.name}"}{else}{assign "resClass" ""}{/if}

                        <div class="col-lg-2">
                            {if $shortlyNumber}
                                {if !isset($resourceData.current)}
                                    {$resourceData.current = $resourceData.max + $resourceData.used}
                                    <img src="{$dpath}images/{$resourceData.name}.png" alt="{$resourceData.name}" title="{$resourceData.name}">
                                    {if $resourceID != 911}
                                        <span class="res_item {$resClass}" data-max="{$resourceData.max}" title="{$resourceData.production|number_format:0:",":"."} pro Stunde"> / {shortly_number($resourceData.max)}</span>
                                    {else} {*energy*}
                                        {if $resourceData.current < 0} {assign "posneg" 'style="color:red;"'} {else} {assign "posneg" 'style="color: lightgreen;"'}{/if}
                                        <span class="res_item" {$posneg}>{shortly_number($resourceData.current)}</span>
                                    {/if}


                                {else}
                                    <img src="{$dpath}images/{$resourceData.name}.png" alt="{$resourceData.name}" title="{$resourceData.name}">
                                    <span class="res_item {$resClass}"  data-max="{$resourceData.max}" data-current="{$resourceData.current}" data-production="{$resourceData.production}" title="{$resourceData.production|number_format:0:",":"."} pro Stunde">
                                        {$resourceData.current|number_format:0:",":"."}
                                    </span>
                                    {if $resourceID != 911}
                                        <span class="res_item"> / {shortly_number($resourceData.max)}</span>
                                    {else}
                                        {if $resourceData.current < 0} {assign "posneg" 'style="color:red;"'} {else} {assign "posneg" 'style="color:green;"'}{/if}
                                        <span class="res_item" {$posneg}>{shortly_number($resourceData.current)}</span>
                                    {/if}
                                    {if $resourceID != 911 && $resourceID != 921}
                                        {if isModuleAvailable($smarty.const.MODULE_TRADER)}
                                            <span class="res_change">
                                                <a href="game.php?page=trader&mode=trade&resource={$resourceID}" title="{$LNG.tr_call_trader}">
                                                    <i class="fas fa-arrows-alt-h"></i>
                                                </a>
                                            </span>
                                        {/if}
                                    {/if}
                                {/if}

                            {else} {*shortlynumber*}
                                {if !isset($resourceData.current)}
                                    {$resourceData.current = $resourceData.max + $resourceData.used}
                                    <span class="res_current tooltip"
                                          data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number}&nbsp;/&nbsp;{$resourceData.max|number}">
                                            <p{if $resourceData.current < 0} style="color:red"{/if}>{$resourceData.current|number}&nbsp;/&nbsp;{$resourceData.max|number}</p>
                                        </span>
                                {else}
                                    <span class="res_current tooltip" id="current_{$resourceData.name}"
                                          data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number} <br>
                                        {if !isset($resourceData.current) || !isset($resourceData.max)}
                                        {else}
                                            <p class='res_max' id='max_{$resourceData.name}' data-real='{$resourceData.max}'>{shortly_number($resourceData.max)}</p>
                                        {/if}" id="current_{$resourceData.name}"
                                          data-real="{$resourceData.current}">{$resourceData.current|number} (X%)
                                        </span>
                                {/if}
                            {/if}
                        </div>
                        {else}
                        <div class="col-lg-2">
                            <img src="{$dpath}images/{$resourceData.name}.gif" alt="">
                            <span class="res_item"
                                  id="current_{$resourceData.name}">{shortly_number($resourceData.current)}</span>
                        </div>
                    {/if}
                        <script>
                            $(document).ready(function () {
                                let src = $('.cont_' +{$resourceData.name|json});
                                let current = parseInt(src.attr('data-current'));
                                let add = parseInt(src.data('production'));
                                let max = parseInt(src.attr('data-max'));

                                add /= 3600;


                                if ({$vmode} == 0){ //kein U-mode

                                    if (max > (current += add)){
                                        setInterval(() => {
                                            current += add;
                                            src.text(Trenner(Number(current).toFixed()));
                                        }, 1000);
                                    }
                                }
                            });
                        </script>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
{* #################### OLD CODE ################################# *}
{*
<div class="res_header">
    <div class="container-fluid">
        <div class="col-lg-12">
            <div class="row">
                {foreach $resourceTable as $resourceID => $resourceData}
                    {if $resourceID != 921}
                        <div class="col-lg-2">
                            {if $shortlyNumber}
                                {if !isset($resourceData.current)}
                                    {$resourceData.current = $resourceData.max + $resourceData.used}
                                    <img src="{$dpath}images/{$resourceData.name}.png" alt="{$resourceData.name}"
                                         title="{$resourceData.name}">
                                    <span class="res_item green" {if $resourceData.current < 0} style="color:red"{/if}>{shortly_number($resourceData.current)}</span>
                                    <span class="res_item"> / {shortly_number($resourceData.max)}</span>
                                {else}
                                    <img src="{$dpath}images/{$resourceData.name}.png" alt="{$resourceData.name}"
                                         title="{$resourceData.name}">
                                    <span class="res_item">{shortly_number($resourceData.current)} / {shortly_number($resourceData.max)} / {$resourceData.production|number_format:0:',':'.'} {$LNG.perHour}</span>
                                    {if $resourceID != 911 && $resourceID != 921}
                                        {if isModuleAvailable($smarty.const.MODULE_TRADER)}
                                            <span class="res_change">
                                                    <a href="game.php?page=trader&mode=trade&resource={$resourceID}"
                                                       title="{$LNG.tr_call_trader}">
                                                        <i class="fas fa-arrows-alt-h"></i>
                                                    </a>
                                                </span>
                                        {/if}
                                    {/if}

                                {/if}
                            {else}
                                {if !isset($resourceData.current)}
                                    {$resourceData.current = $resourceData.max + $resourceData.used}
                                    <span class="res_current tooltip" data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number}&nbsp;/&nbsp;{$resourceData.max|number}">
                                        <p{if $resourceData.current < 0} style="color:red"{/if}>{$resourceData.current|number}&nbsp;/&nbsp;{$resourceData.max|number}</p>
                                    </span>
                                {else}
                                    <span class="res_current tooltip" id="current_{$resourceData.name}" data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number} <br>
                                    {if !isset($resourceData.current) || !isset($resourceData.max)}
                                    {else}
                                        <p class='res_max' id='max_{$resourceData.name}' data-real='{$resourceData.max}'>{shortly_number($resourceData.max)}</p>
                                    {/if}" id="current_{$resourceData.name}" data-real="{$resourceData.current}">{$resourceData.current|number} (X%)
                                    </span>
                                {/if}
                            {/if}
                        </div>
                    {else}
                        <div class="col-lg-2"></div>
                        <div class="col-lg-2">
                            <img src="{$dpath}images/{$resourceData.name}.gif" alt="">
                            <span class="res_item"
                                  id="current_{$resourceData.name}">{shortly_number($resourceData.current)}</span>
                        </div>
                    {/if}
                {/foreach}
            </div>
        </div>
    </div>
</div>
*}
{* ############################################################### *}


{if !$vmode}
    <script src="scripts/game/topnav.js"></script>
    {if $hasGate}
        <script src="scripts/game/gate.js"></script>
    {/if}
{/if}


{if $closed}
    <div class="infobox">{$LNG.ov_closed}</div>
{elseif $delete}
    <div class="infobox">{$delete}</div>
{elseif $vacation}
    <div class="infobox">{$LNG.tn_vacation_mode} {$vacation}</div>
{/if}