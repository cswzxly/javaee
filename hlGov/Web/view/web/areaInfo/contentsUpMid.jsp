<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script>
    $(function(){
    	contentsUpMid.loadData();
    });
    var contentsUpMid = {
        loadData:function(){
            var url = "${ctx}/web/areaInfoContents.action?catalogID=50";
            $.post(url,function(result){
                var lis = "";
                if(result!=null){
                    for(var i=0;i<result.length;i++){
                    	lis+="<li title="+result[i].allTitle+"><a href='${ctx}/web/contentsShow.action?type=contents&contentsID="+result[i].theID+"'>"+result[i].title+"</a>"+"<em>"+(result[i].releaseDate).substring(0,10)+"</em></li>"
                    }
                }
                var ul = $("#contentsUpMid");
                ul.append(lis);
            },'json');
        }
    }
</script>
<div>
	<h3><span>名胜古迹</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=50">更多 >></a></h3>
	<ul id="contentsUpMid"></ul>
</div>
