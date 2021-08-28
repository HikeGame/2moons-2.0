<!DOCTYPE html>

<head>
	<title>{block name="title"} - {$uni_name} - {$game_name}{/block}</title>
	<meta name="generator" content="Space-Tactics {$VERSION}">
	<!-- 
		This website is powered by Space-Taactics {$VERSION}
		Space-Tactics is forked by 2moons and copyright 2009-2018 of Jan Kröpke. Extensions are copyright of their respective owners.
	-->
	{if !empty($goto)}
	<meta http-equiv="refresh" content="{$gotoinsec};URL={$goto}">
	{/if}
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">

	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/boilerplate.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/ingame/main.css?v=">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/ingame/leftmenu.css?v=">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/jquery.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/jquery.fancybox.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="./styles/resource/css/base/validationEngine.jquery.css?v={$REV}">
	<link rel="stylesheet" type="text/css" href="{$dpath}ingame.css?v={$REV}">
	<link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
	<script type="text/javascript">
	var ServerTimezoneOffset = {$Offset};
	var serverTime 	= new Date({$date.0}, {$date.1 - 1}, {$date.2}, {$date.3}, {$date.4}, {$date.5});
	var startTime	= serverTime.getTime();
	var localTime 	= serverTime;
	var localTS 	= startTime;
	var Gamename	= document.title;
	var Ready		= "{$LNG.ready}";
	var Skin		= "{$dpath}";
	var Lang		= "{$lang}";
	var head_info	= "{$LNG.fcm_info}";
	var auth		= {$authlevel|default:'0'};
	var days 		= {$LNG.week_day|json|default:'[]'} 
	var months 		= {$LNG.months|json|default:'[]'} ;
	var tdformat	= "{$LNG.js_tdformat}";
	var queryString	= "{$queryString|escape:'javascript'}";
	var isPlayerCardActive	= "{$isPlayerCardActive|json}";

	setInterval(function() {
		serverTime.setSeconds(serverTime.getSeconds()+1);
	}, 1000);
	</script>
	<script type="text/javascript" src="./scripts/base/jquery.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.ui.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.cookie.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.fancybox.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/jquery.validationEngine.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/l18n/validationEngine/jquery.validationEngine-{$lang}.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/base/tooltip.js?v={$REV}"></script>
	<script type="text/javascript" src="./scripts/game/base.js?v={$REV}"></script>
	{foreach item=scriptname from=$scripts}
	<script type="text/javascript" src="./scripts/game/{$scriptname}.js?v={$REV}"></script>
	{/foreach}
	{block name="script"}{/block}
	<script type="text/javascript">
	$(function() {
		{$execscript}
	});
	</script>

	<!-- Start Open Web Analytics Tracker -->
	<script type="text/javascript">
		//<![CDATA[
		var owa_baseUrl = 'https://stat.nettronix.de/';
		var owa_cmds = owa_cmds || [];
		owa_cmds.push(['setSiteId', 'd249f9e1c4bd2e355dedb7d6121fed80']);
		owa_cmds.push(['trackPageView']);
		owa_cmds.push(['trackClicks']);
		owa_cmds.push(['trackDomStream']);

		(function() {
			var _owa = document.createElement('script'); _owa.type = 'text/javascript'; _owa.async = true;
			owa_baseUrl = ('https:' == document.location.protocol ? window.owa_baseSecUrl || owa_baseUrl.replace(/http:/, 'https:') : owa_baseUrl );
			_owa.src = owa_baseUrl + 'modules/base/js/owa.tracker-combined-min.js';
			var _owa_s = document.getElementsByTagName('script')[0]; _owa_s.parentNode.insertBefore(_owa, _owa_s);
		}());
		//]]>
	</script>
	<!-- End Open Web Analytics Code -->

</head>
<body id="{$smarty.get.page|htmlspecialchars|default:'overview'}" class="{$bodyclass}">
	<div id="tooltip" class="tip"></div>