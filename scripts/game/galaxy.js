function doit(missionID, planetID) {
	$.getJSON("game.php?page=fleetAjax&ajax=1&mission="+missionID+"&planetID="+planetID, function(data)
	{
		$('#slots').text(data.slots);
		if(typeof data.ships !== "undefined")
		{
			$.each(data.ships, function(elementID, value) {
				$('#elementID'+elementID).text(number_format(value));
			});
		}
		
		var statustable	= $('#fleetstatusrow');
		var messages	= statustable.find("~tr");
		if(messages.length == MaxFleetSetting) {
			messages.filter(':last').remove();
		}
		var element		= $('<td />').attr('colspan', 8).attr('class', data.code == 600 ? "success" : "error").text(data.mess).wrap('<tr />').parent();
		statustable.removeAttr('style').after(element);
	});
}

function galaxy_submit(value) {
	$('#auto').attr('name', value);
	$('#galaxy_form').submit();
}


$( document ).ready(function() {

	$('.system-container .system').mouseenter(function(event){
		let data = $(this).attr('id');
		let system = data.split('-');
		let x = system[0];
		let y = system[1];
		let z = $(this).attr('data-name');

		console.warn(z);

		$.ajax({
			method: "POST",
			url: "getSystem.php",
			data: { x: y, y: x, z: z}
		})
			.done(function( msg ) {
				if(msg.length > 0) {
					$('.systemdata').remove();
					$('.system_' + x + '-' + y).append(msg);
				}else{
					$('.systemdata').remove();
				}
			});
	});

	/*$('.system-container .system').mouseleave(function(){
		let s = $(this).attr('id');
		$('[class*="systemdata_"]').remove();
	});*/

});






