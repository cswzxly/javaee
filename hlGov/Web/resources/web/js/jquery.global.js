$(function(){
	$('.tab').each(function(){
		$(this).tabs({event:'mouseover'})
	});

	$('.hdtab').each(function(){
		$(this).tabs({event:'mouseover'})
	});

	$('.csstable tr:even').each(function(){
		$(this).addClass("trbg")
	});	


	$('.submenu ul li').mouseover(function(){
		$(this).addClass("hover");
	});
	$('.submenu ul li').mouseout(function(){
		$(this).removeClass("hover");
	});

	
});



