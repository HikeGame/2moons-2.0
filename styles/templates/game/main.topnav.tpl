<div id="header">

	{foreach $resourceTable as $resourceID => $resourceData}
	{if $resourceID != 921}
	<div id="bar-1" class="bar-main-container">
	    <div class="wrap">
	      <div class="bar-percentage"><img src="{$dpath}images/{$resourceData.name}.gif" alt=""></div>
	      <div class="bar-container">
	        <div class="bar bar_{$resourceID}" style="width: 0%;"></div>
	        <div class="bar-text">
		        {if $shortlyNumber}
					{if !isset($resourceData.current)}
					{$resourceData.current = $resourceData.max + $resourceData.used}
						<span class="res_current tooltip" data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number}&nbsp;/&nbsp;{$resourceData.max|number}"><span{if $resourceData.current < 0} style="color:red"{/if}>{shortly_number($resourceData.current)}&nbsp;/&nbsp;{shortly_number($resourceData.max)}</span></span>
					{else}
						<span class="res_current tooltip" id="current_{$resourceData.name}" data-real="{$resourceData.current}" data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number} <br> {if !isset($resourceData.current) || !isset($resourceData.max)}
						{else}
						<span class='res_max' id='max_{$resourceData.name}' data-real='{$resourceData.max}'>{shortly_number($resourceData.max)}</span>
						{/if}">{shortly_number($resourceData.current)}</span>
					{/if}
		        {else}
					{if !isset($resourceData.current)}
					{$resourceData.current = $resourceData.max + $resourceData.used}
						<span class="res_current tooltip" data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number}&nbsp;/&nbsp;{$resourceData.max|number}"><span{if $resourceData.current < 0} style="color:red"{/if}>{$resourceData.current|number}&nbsp;/&nbsp;{$resourceData.max|number}</span></span>
					{else}
						<span class="res_current tooltip" id="current_{$resourceData.name}" data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number} <br> {if !isset($resourceData.current) || !isset($resourceData.max)}
						{else}
						<span class='res_max' id='max_{$resourceData.name}' data-real='{$resourceData.max}'>{shortly_number($resourceData.max)}</span>
						{/if}" id="current_{$resourceData.name}" data-real="{$resourceData.current}">{$resourceData.current|number} (X%)</span>
					{/if}
		        {/if}
	        </div>
	      </div>
	      {if $resourceID != 911 && $resourceID != 921}
	      {if isModuleAvailable($smarty.const.MODULE_TRADER)}
	      <div class="bar-change">
	      	<a href="game.php?page=trader&mode=trade&resource={$resourceID}"><i class="fas fa-arrows-alt-h"></i></a>
	      </div>
	      {/if}
	      {/if}
	    </div>
	</div>
	{else}
	<div class="heder_res_921 res_921_text">
		<img src="{$dpath}images/{$resourceData.name}.gif" alt="">
		<span class="res_current tooltip" id="current_{$resourceData.name}" data-real="{$resourceData.current}" data-tooltip-content="{$LNG.tech.$resourceID} <br> {$resourceData.current|number} <br> {if !isset($resourceData.current) || !isset($resourceData.max)}
		{else}
		<span class='res_max' id='max_{$resourceData.name}' data-real='{$resourceData.max}'>{shortly_number($resourceData.max)}</span>
		{/if}">{shortly_number($resourceData.current)}</span>
	</div>
	{/if}
	{/foreach}
	<div class="clear"></div>

		{if !$vmode}
		<script type="text/javascript">
		var viewShortlyNumber	= {$shortlyNumber|json};
		var vacation			= {$vmode};
        $(function() {
		{foreach $resourceTable as $resourceID => $resourceData}
		{if isset($resourceData.production)}
            resourceTicker({
                available: {$resourceData.current|json},
                limit: [0, {$resourceData.max|json}],
                production: {$resourceData.production|json},
                valueElem: "current_{$resourceData.name}",
                valuePoursent: "bar_{$resourceID}"
            }, true);
		{/if}
		{/foreach}
        });
		</script>
        <script src="scripts/game/topnav.js"></script>
        {if $hasGate}<script src="scripts/game/gate.js"></script>{/if}
		{/if}
</div>
	{if $closed}
	<div class="infobox">{$LNG.ov_closed}</div>
	{elseif $delete}
	<div class="infobox">{$delete}</div>
	{elseif $vacation}
	<div class="infobox">{$LNG.tn_vacation_mode} {$vacation}</div>
	{/if}