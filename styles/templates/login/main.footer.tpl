<div class="container">
	<footer>
		<p class="pull-right"><a href="#">Back to top</a></p>
		<p>© 2018 {$gameName}, Inc. · <a href="http://2moons.de">by 2moons.de</a> · <a href="https://github.com/HikeGame/2moons-2.0">github</a></p>
	</footer>
</div>
<div id="dialog" style="display:none;"></div>
<script>
var LoginConfig = {
    'isMultiUniverse': {$isMultiUniverse|json},
	'unisWildcast': {$unisWildcast|json},
	'referralEnable' : {$referralEnable|json},
	'basePath' : {$basepath|json}
};
</script>
{if $analyticsEnable}

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


{/if}
</body>
</html>