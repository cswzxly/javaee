$(function(){



	var $menu = $('#nav');
	$menu.children('li').each(function () {
		var $this = $(this);
		$this.bind('mouseenter', function () {
			$menu.find('ul').stop(true, true).hide();
			$this.find('ul').show();
			$menu.children('li').removeClass("hover");
			$this.addClass("hover");
		}).bind('mouseleave', function () {
			$menu.find('ul').stop(true, true).hide();
			$this.find('ul').show();
			$menu.children('li').removeClass("hover");
			$this.addClass("hover");
		});
	});

	$('.tab').each(function(){
		$(this).tabs({event:'mouseover'})
	});

	$('.csstable tr:even').each(function(){
		$(this).addClass("trbg")
	});	

});



