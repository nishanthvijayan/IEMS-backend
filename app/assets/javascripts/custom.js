$(document).ready(function(){
	$('.input-daterange').datepicker({
	    orientation: "bottom auto",
	    format: 'dd/mm/yyyy',
	    todayBtn: "linked",
	    clearBtn: true
	});

	$('.datepicker').datepicker({
	    orientation: "bottom auto",
	    format: 'yyyy-mm-dd',
	    todayBtn: "linked",
	    clearBtn: true
	});

	$.fn.bootstrapSwitch.defaults.onText = 'Yes';
	$.fn.bootstrapSwitch.defaults.offText = 'No';
	$.fn.bootstrapSwitch.defaults.onColor = 'success';
	$.fn.bootstrapSwitch.defaults.offColor = 'danger';
	$('.switch-checkbox').bootstrapSwitch();
});

$(function (){
	$('.minimize-filters').click(function(){
		$('.filters').toggle();
		if ($('.minimize-filters').hasClass('glyphicon-minus')) {
			$('.minimize-filters').removeClass('glyphicon-minus')
			$('.minimize-filters').addClass('glyphicon-plus')
		} else {
			$('.minimize-filters').removeClass('glyphicon-plus')
			$('.minimize-filters').addClass('glyphicon-minus')
		}
	});

	$('.minimize-stats').click(function(){
		$('.stats').toggle();
		if ($('.minimize-stats').hasClass('glyphicon-minus')) {
			$('.minimize-stats').removeClass('glyphicon-minus')
			$('.minimize-stats').addClass('glyphicon-plus')
		} else {
			$('.minimize-stats').removeClass('glyphicon-plus')
			$('.minimize-stats').addClass('glyphicon-minus')
		}
	});

	$('.add-name').click(function(){
		$('.name-list > #guest_user_name').first().clone().appendTo( ".name-list" );
	})

});
