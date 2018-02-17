//topnav.js
//RealTimeRessisanzeige for 2Moons
// @version 1.0
// @copyright 2010 by ShadoX

function resourceTicker(config, init) {
	if(typeof init !== "undefined" && init === true)
		window.setInterval(function(){resourceTicker(config)}, 1000);
		
	var element	= $('#'+config.valueElem);
	var elementPoursent	= $('.'+config.valuePoursent);

	if(element.hasClass('res_current_max'))
	{
		return false;
	}
	
	var nrResource = Math.max(0, Math.floor(parseFloat(config.available) + parseFloat(config.production) / 3600 * (serverTime.getTime() - startTime) / 1000));
	
	if (nrResource < config.limit[1]) 
	{
		pourcent = Math.max(0, parseFloat(nrResource / config.limit[1]) * 100).toFixed(0);

		if (!element.hasClass('res_current_warn') && nrResource >= config.limit[1] * 0.9)
		{
			element.addClass('res_current_warn');
		}
		if(viewShortlyNumber) {
			//element.attr('data-tooltip-content', NumberGetHumanReadable(nrResource));
			element.html(shortly_number(nrResource) + " ("+pourcent+"%) ");
			elementPoursent.css('width', pourcent+'%');

		} else {
			element.html(NumberGetHumanReadable(nrResource) + " ("+pourcent+"%) ");
			elementPoursent.css('width', pourcent+'%');

		}
	} else {
		elementPoursent.css('width', '100%');
		element.addClass('res_current_max');
		element.html(shortly_number(nrResource) + " (100%) ");
	}
}

function getRessource(name) {
	return parseInt($('#current_'+name).data('real'));
}