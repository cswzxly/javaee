<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容新建</title>
    <link rel="stylesheet" href="${ctx}/resources/kindeditor/themes/default/default.css"/>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/lang/zh_CN.js"></script>
</head>
<body>
<script>

$(function(){

    $('#backContentsBtn').click(function() {
        window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+$("#catalogID").val();
    });
    
});

function checkVideo(){
    var title = $("#title").val();
    var releaseDate = $("#releaseDate").val();
    
    if(title==""){
    	alert("标题不能为空！");
    	return false;
    }
    if(releaseDate == ""){
    	alert("发布时间不能为空！");
    	return false;
    }
    return true;
}

function checkIndex(){
	var isindex = $("#isindex").val();
	if(isindex == '1'){
		var status = $("#status").val();
		if(status == '1'){
			var url = "${ctx}/video/checkVideoIndex.action";
			var param = {};
		    $.post(url,param,function(data){
		    	if(data == '1'){
		    		alert("已有首页显示视频，不能重复选择");
		    		$("#isindex").val('0');
		    	}
		    },"json");
		}else{
			alert("该视频的状态必须为启用状态！");
			$("#isindex").val('0');
		}
	}
}
</script>



<div id="newContentsWin" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save"  style="width: 750px; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post" action="${ctx}/video/updateVideo.action" onSubmit="return checkVideo();">
                <table cellpadding=3>
                    <tr>
                        <td>所属栏目：</td>
                        <td>
                        	<span>${catalog.title}</span>
                        	<input type="hidden" id="theID" name="video.theID" value="${video.theID }"/>
                        	<input type="hidden" id="catalogID" name="video.catalogID" value="${catalog.theID}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>标题：</td>
                        <td>
                        	<input id="title" name="video.title" type="text" class="easyui-validatebox" value="${video.title}" data-options="required:true,validType:'length[3,40]'"/>
                        </td>
                    </tr>
                    <tr>
                        <td>发布日期：</td>
                        <td>
                        	<input id="releaseDate" name="video.releaseDate" type="text" width="100" readonly="readonly" value="${video.releaseDate}"/>
							<img onclick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <td>来源：</td>
                        <td>
                        	<input id="source" name="video.source" type="text" value="${video.source }" />
                        </td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status" name="video.status">
                        		<option value="1" <c:if test="${video.status==1}">selected</c:if>>启用</option>
                        		<option value="0" <c:if test="${video.status==0}">selected</c:if>>停用</option>
                        	</select>
                        </td>
                    </tr>
                    <%--<tr>--%>
                        <%--<td>是否首页视频：</td>--%>
                        <%--<td>--%>
                        	<%--<select id="isindex" name="video.isindex" onchange="checkIndex();">--%>
                        		<%--<option value="1" <c:if test="${video.isindex==1}">selected</c:if>>是</option>--%>
                        		<%--<option value="0" <c:if test="${video.isindex==0}">selected</c:if>>否</option>--%>
                        	<%--</select>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <tr>
                    	<td>上传视频</td>
                    	<td>
                    		${video.title }.flv
                    	</td>
                    </tr>
                </table>
                <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
                	<input type="submit" class="easy-linkbutton" value="保存"/>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>