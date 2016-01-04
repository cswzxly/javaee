/**
 * Main Script for http://www.net.cn/jianzhan/sucheng.html
 * User: zhuzhe
 * Date: 6/29/13
 * Time: 9:01 AM
 * Desc: include focus switch and view list function
 */

$(function(){
    

    //轮播效果
    $.fn.extend({
        "nav": function (con) {
            var $this = $(this), $nav = $this.find('.switch-tab'), t = (con && con.t) || 3000, a = (con && con.a) || 500, i = 0, autoChange = function () {
                $nav.find('a:eq(' + (i + 1 === 3 ? 0 : i + 1) + ')').addClass('current').siblings().removeClass('current');
                $this.find('.event-item:eq(' + i + ')').css('display', 'none').end().find('.event-item:eq(' + (i + 1 === 3 ? 0 : i + 1) + ')').css({
                    display: 'block',
                    opacity: 0
                }).animate({
                        opacity: 1
                    }, a, function () {
                        i = i + 1 === 3 ? 0 : i + 1;
                    }).siblings('.event-item').css({
                        display: 'none',
                        opacity: 0
                    });
            }, st = setInterval(autoChange, t);
            $this.hover(function () {
                clearInterval(st);
                return false;
            }, function () {
                st = setInterval(autoChange, t);
                return false;
            }).find('.switch-nav>a').bind('click', function () {
                    var current = $nav.find('.current').index();
                    i = $(this).attr('class') === 'prev' ? current - 2 : current;
                    autoChange();
                    return false;
                }).end().find('.switch-tab>a').bind('click', function () {
                    i = $(this).index() - 1;
                    autoChange();
                    return false;
                });
            return $this;
        }
    });
    $('#inner').nav({ t: 5000, a: 1000 });

    // api related
    (function(){
        var container = $('#mould_list');
        var pager = $(".page_list_right");
        var btn_color = $('#btn_colors a');
        var select_industry = $('.search_main select');
        var btn_pop = $('.hot_mould');

        var page_size = 12;
        var api_industry = "http://mynetsvc.proxy.mynet.cn/api/getcategorys?contenttype=json&servername=suchengmeizhan&jsonp=?";
        var api_templates = "http://mynetsvc.proxy.mynet.cn/api/gettemplates?contenttype=json&servername=suchengmeizhan&jsonp=?";

        var init_data = window['arr_templates'];

        container.delegate('li','mouseenter',function(event){
            container.find('li.show_time').removeClass('show_time');
            $(this).addClass('show_time');
        });
            container.bind('load_industry',function(){

                $.ajax({type:"GET",
                    url:api_industry,
                    dataType: 'jsonp',
                    scriptCharset:'utf-8',
                    success:function(info){
                        var code = info.code;
                        if(code<0){
                            alert(info.message);
                        }else{
                            var categorys = info.data.categorys;
                            var arr_options = [];
                            var arr_categoryid = [];
                            $(categorys).each(function(i,o){
                                var categoryid = o['categoryid'];
                                var categoryname = o['categoryname'];
                                arr_options.push('<option value="'+categoryid+'">'+categoryname+'</option>');
                                arr_categoryid.push(categoryid);
                            });
                            var html_options = arr_options.join();
                            select_industry.html("<option value='"+arr_categoryid.join(',')+"'>所有行业</option>"+html_options).change();
                        }
                    }
            });


            }).trigger('load_industry');

        function pager_html(index,count,callback){
            //console.log([index,count,callback]);
            var num_start = 1;
            var num_current = index;
            var num_end = count;
            var num_mid_start = num_current - 3;
            var num_mid_end = num_current + 3;

            var html = '<a href="#" class="last">&lt;&lt; 上一页</a> \
                <a href="#" class="page_num" pid="'+num_start+'">'+num_start+'</a>';

            if( num_mid_start > num_start + 1 ){
                html += '<span>...</span>';
            }

            for(var i = Math.max(num_start+1,num_mid_start);i <= Math.min(num_end - 1,num_mid_end);i++){
                html += '<a href="#" class="page_num" pid="'+i+'">'+i+'</a>';
            }

            if(num_mid_end < num_end - 1){
                html += '<span>...</span>';
            }

            html += '<a href="#" class="page_num" pid="'+num_end+'">' + num_end + '</a> \
                <a href="#" class="next">下一页 &gt;&gt;</a>';

            pager.html(html);

            pager.find('a[pid="'+num_current+'"]').addClass('active');

            if(num_current == num_start){
                pager.find('a:first').addClass('no_click');
            }

            if(num_current == num_end){
                pager.find('a:last').addClass('no_click');
            }

            pager.find('a').click(function(event){
                event.preventDefault();
            }).not(pager.find('a.no_click,a.active')).click(function(event){
                var obj = $(this);
                if(obj.hasClass('last')){
                    callback(num_current-1);
                }else if(obj.hasClass('next')){
                    callback(num_current+1);
                }else{
                    var num = parseInt(obj.text());
                    if(num > 0){
                        callback(num);
                    }
                }
                event.preventDefault();
            });
        }

        function render(type, value, pageindex){
            var height_current = parseInt(container.height());
            container.html('<div style="width:100%;height:'+height_current+'px;text-align:center;padding-top:90px;">数据载入中，请稍后...</div>');
            var url_patch = '';
            url_patch = url_patch + '&' + type + '=' + value;
            url_patch = url_patch + '&pageindex=' + pageindex + '&pagesize=' + page_size;
            var url = api_templates + url_patch;
            //console.log([url_patch,url]);
            $.ajax({type:"GET",
                url:url,
                dataType: 'jsonp',
                scriptCharset:'utf-8',
                success:function(info){
                    var code = info.code;
                    if(code < 0){
                        alert(info.message);
                    }else{
                        var templates = info.data.templates;
                        var pagecount = Math.ceil(info.data.pagecount/page_size);

                        if(pagecount <= 1 ){
                            pager.empty().hide();
                        }else{
                            pager_html(pageindex, pagecount,function(num){
                                render(type,value,num,pagecount);
                            });
                            pager.show();
                        }
                        var li = $('<li> \
                            <div class="mould_list_main"> \
                                <div class="mould_list_li"><a href="#" target="_blank"><img alt=""></a></div> \
                                <div class="mould_list_title clear"> \
                                    <span class="span_line">地产行业001</span> \
                                    <a href="#" target="_blank" class="a_view">预览</a> \
                                </div> \
                            </div> \
                            <div class="shadrow"></div> \
                        </li>');

                        var fragment = $('<div></div>');
                        $(templates).each(function(i,o){
                            // pagecount,id,name,largeimageurl,previewimageurl,smallimageurl,demourl
                            var id = o['id'];
                            var name = o['name'];
                            var previewimageurl = o['previewimageurl'];
                            var demourl = o['demourl'];
                            //console.log([id,name,previewimageurl,demourl]);
                            var insert = li.clone();
                            insert.find('img').attr('src',previewimageurl);
                            insert.find('span').html(name);
                            insert.find('a').attr('href',"sucheng_preview.html#"+id+"|"+name+"|"+demourl);
                            $(fragment).append(insert);
                        });
                        if($(fragment).find('li').length == 0){
                            container.html('<div style="width:100%;height:100px;text-align:center;padding-top:90px;">没有符合搜索条件的模板</div>');
                        }else{
                            container.html($(fragment).html());
                        }
                    }
                }
            });
        }

        //trigger
        select_industry.change(function(){
            var value = $(this).val();
            render('categoryids',value,1,page_size);
        });

        btn_color.click(function(e){
            e.preventDefault();
            btn_color.removeClass('color_btn_click');
            $(this).addClass('color_btn_click');
            var color = $(this).attr('color');
            render('colorids',color,1,page_size);
        });

        btn_pop.click(function(e){
            e.preventDefault();
            render('ids',init_data.join(','),1,page_size);
        });
    })();
});