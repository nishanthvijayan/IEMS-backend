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