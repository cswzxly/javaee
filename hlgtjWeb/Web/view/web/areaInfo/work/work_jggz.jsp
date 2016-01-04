<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script>
    $(function(){
    	work_jggz.loadData();
    });
    var work_jggz = {
        loadData:function(){
            var url = "${ctx}/web/areaInfoContents.action?catalogID=185";
            $.post(url,function(result){
                var lis = "";
                if(result!=null){
                    for(var i=0;i<result.length;i++){
                    	lis+="<li title="+result[i].allTitle+"><a href='${ctx}/web/contentsShow.action?type=contents&contentsID="+result[i].desId+"'>"+result[i].title+"</a>"+"<em>"+(result[i].releaseDate).substring(0,10)+"</em></li>"
                    }
                }
                var ul = $("#work_jggz");
                ul.append(lis);
            },'json');
        }
    }
</script>
<div>
	<h3><span>价格工作</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=185">更多 >></a></h3>
	<ul id="work_jggz"></ul>
</div>
