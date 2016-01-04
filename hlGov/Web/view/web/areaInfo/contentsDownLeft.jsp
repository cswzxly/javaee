<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<script>
    $(function(){
    	contentsDownLeft.loadData();
    });
    var contentsDownLeft = {
        loadData:function(){
            var url = "${ctx}/web/areaInfoContents.action?catalogID=64";
            $.post(url,function(result){
                var lis = "";
                if(result!=null){
                    for(var i=0;i<result.length;i++){
                    	lis+="<li title="+result[i].allTitle+"><a href='${ctx}/web/contentsShow.action?type=contents&contentsID="+result[i].theID+"'>"+result[i].title+"</a>"+"<em>"+(result[i].releaseDate).substring(0,10)+"</em></li>"
                    }
                }
                var ul = $("#contentsDownLeft");
                ul.append(lis);
            },'json');
        }
    }
</script>
<div>
	<h3><span>招商项目</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=64">更多 >></a></h3>
	<ul id="contentsDownLeft"></ul>
</div>
