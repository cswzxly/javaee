$(function(){

	$(".tab").each(function(){
		$(this).tabs({
			event:'mouseover'  					 
		})
	})	
	
	$(".submenu ul li").mouseover(function(){ $(this).addClass("hover");  })	   
	$(".submenu ul li").mouseout(function(){ $(this).removeClass("hover");  })	
	
	$(".csstable tr:even").addClass("trbg")
});




