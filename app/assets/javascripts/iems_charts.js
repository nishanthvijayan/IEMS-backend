var createUserTypeChart = function(){
	// Get context with jQuery - using jQuery's .get() method.
	var guest_ctx = $("#guestChart").get(0).getContext("2d");

	$.get( window.location.href.replace(window.location.pathname,window.location.pathname+'.json'), function( response ) {
		var guestCount = 0;
		var regularCount = 0;

		for (var i in response) {
			if (response[i].guest_transaction){
				guestCount += 1;
			}
			else{
				regularCount += 1;
			}
		}

		var doughnutData = [
			{
			  value: guestCount,
			  color:"#F7464A",
			  highlight: "#FF5A5E",
			  label: "Guests"
			},
			{
			  value: regularCount,
			  color: "#46BFBD",
			  highlight: "#5AD3D1",
			  label: "Regular"
			}
		];
		var myDoughnutChart = new Chart(guest_ctx).Doughnut(doughnutData);
		$("#legend-guest").append("Guest: "+guestCount);
		$("#legend-regular").append("Regular: "+regularCount);
	});
};

var createFoodTypeChart = function(){
	// Get context with jQuery - using jQuery's .get() method.
	var food_ctx = $("#foodChart").get(0).getContext("2d");

	$.get( window.location.href.replace(window.location.pathname,window.location.pathname+'.json'), function( response ) {
		var breakfastCount = 0;
		var lunchCount = 0;
		var dinnerCount = 0;
		var specialCount = 0;

		for (var i in response) {
			if (response[i].food_type == 'B'){
				breakfastCount += 1;
			} else if (response[i].food_type == 'L'){
				lunchCount += 1;
			} else if (response[i].food_type == 'D'){
				dinnerCount += 1;
			} else if (response[i].food_type == 'S'){
				specialCount += 1;
			}
		}

		var doughnutData = [
			{
			  value: breakfastCount,
			  color:"#8bc34a",
			  highlight: "#aed581",
			  label: "Breakfast"
			},
			{
			  value: lunchCount,
			  color: "#ff4081",
			  highlight: "#ff80ab",
			  label: "Lunch"
			},
			{
			  value: dinnerCount,
			  color: "#FDB45C",
			  highlight: "#FFC870",
			  label: "Dinner"
			},
			{
			  value: specialCount,
			  color: "#949FB1",
			  highlight: "#A8B3C5",
			  label: "Special"
			}
		];
		var myDoughnutChart = new Chart(food_ctx).Doughnut(doughnutData);
		 $("#legend-breakfast").append("Breakfast: "+ breakfastCount);
		 $("#legend-lunch").append("Lunch: "+ lunchCount);
		 $("#legend-dinner").append("Dinner: "+ dinnerCount);
		 $("#legend-special").append("Special: "+ specialCount);
	});
};
