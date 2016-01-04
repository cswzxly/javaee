$(function(){

	$(".tab").each(function(){
		$(this).tabs({
			event:'mouseover'  					 
		})
	})		   

    $(function () {
        var $menu = $('#nav');
        $menu.children('li').each(function () {
            var $this = $(this);
            $this.bind('mouseenter', function () {
                $menu.find('ul').stop(true, true).hide();
                $this.find('ul').show();
				$menu.children('li').removeClass("hover");
				$menu.children('li').removeClass("hover1");
				$this.addClass("hover");
				if($this.index()==2){
					$this.addClass("hover1");
				}
            }).bind('mouseleave', function () {
                $menu.find('ul').stop(true, true).hide();
                $this.find('ul').show();
				$menu.children('li').removeClass("hover");
				$menu.children('li').removeClass("hover1");
				$this.addClass("hover");
				if($this.index()==2){
					$this.addClass("hover1");
				}
            });
        });

    })
	
	
	$(".csstable tr:even").addClass("tbg");
});




