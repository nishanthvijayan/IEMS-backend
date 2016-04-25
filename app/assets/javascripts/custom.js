$(document).on('page:change', function () {
	$('.input-daterange, .datepicker').datepicker({
	    orientation: "bottom auto",
	    format: 'dd/mm/yyyy',
	    todayBtn: "linked",
	    clearBtn: true
	});

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
	});

	$('.show-changeset').click(function(){
		if ($(this).text() == "View Changes"){
			$(this).text("Hide Changes");
		}else {
			$(this).text("View Changes");
		}
		$('.changeset-' + this.id).toggle();
	});

});
