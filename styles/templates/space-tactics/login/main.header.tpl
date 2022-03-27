<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="{$lang}" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="{$lang}" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="{$lang}" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="{$lang}" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="{$lang}" class="no-js"> <!--<![endif]-->
<head>
	<link rel="stylesheet" type="text/css" href="styles/resource/css/login/styles.css">
	<link rel="stylesheet" href="styles/resource/font-awesome/4.5.0/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="styles/resource/css/base/jquery.fancybox.css">
	<link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
	<title>{block name="title"} - {$gameName}{/block}</title>
	<meta name="generator" content="Space-Tactics {$VERSION}">

	<meta name="keywords" content="Weltraum Browsergame, Space-Tactics, XNova, 2Moons, Space, Private, Server, Speed">
	<meta name="description" content="Space-Tactics Browsergame powerd by https://github.com/ShaoKhan/2moons-2.0"> <!-- Noob Check :) -->
	<meta name="viewport" content="width=device-width" /> <!-- Responsive -->
	<!-- New code -->
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!--[if lt IE 9]>
	<script src="scripts/base/html5.js"></script>
	<![endif]-->
	<script src="scripts/base/jquery.js"></script>
	<script src="scripts/base/jquery.cookie.js"></script>
	<script src="scripts/base/jquery.fancybox.js?v={$REV}"></script>
	<script src="scripts/login/main.js"></script>
	<script>{if isset($code)}var loginError = {$code|json};{/if}</script>
	{block name="script"}{/block}	
</head>
<body id="{$smarty.get.page|htmlspecialchars|default:'overview'}" class="{$bodyclass}">