<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容新建</title>
</head>
<body>
<script>


$(function(){
// 	newContents_page.initInfoTipWin();

    $('#backContentsBtn').click(function() {
    	
        window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+$("#catalogID").val();
    });
    
});

function checkVideo(){
    var title = $("#title").val();
    var releaseDate = $("#releaseDate").val();
    var upload = $("#upload").val();
    
    if(title==""){
    	alert("标题不能为空！");
    	return false;
    }
    if(releaseDate == ""){
    	alert("发布时间不能为空！");
    	return false;
    }
    if(upload == ""){
    	alert("上传视频不能为空！");
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
     maximizable="true" icon="icon-save"  style="width: auto; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post" action="${ctx}/video/saveVideo.action" enctype="multipart/form-data" onSubmit="return checkVideo();">
                <table class="formtable">
                    <tr>
                        <td>所属栏目：</td>
                        <td>
                        	<span>${catalog.title}</span>
                        	<input type="hidden" id="catalogID" name="video.catalogID" value="${catalog.theID}"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span style="color:red">*</span>标题：</td>
                        <td><input id="title" name="video.title" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[3,40]'"/></td>
                    </tr>
                    <tr>
                        <td><span style="color:red">*</span>发布日期：</td>
                        <td>
                        	<input id="releaseDate" name="video.releaseDate" type="text" width="100" readonly="readonly"/>
							<img onclick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <td>来源：</td>
                        <td><input id="source" name="video.source" type="text" /></td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status" name="video.status">
                        		<option value="1">启用</option>
                        		<option value="0">停用</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                        <td>是否首页视频：</td>
                        <td>
                        	<select id="isindex" name="video.isindex" onchange="checkIndex();">
                        		<option value="0">否</option>
                        		<option value="1">是</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                    	<td><span style="color:red">*</span>上传视频:</td>
                    	<td>
                    		<input type="file" id="upload" name="upload" size="50"/>
                    		<br/>（视频格式只能是.flv）
                    	</td>
                    </tr>
                </table>
                <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
                	<input type="submit" icon="icon-ok" class="easy-linkbutton" value="保存"/>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- <div id="infoTipWin" class="easyui-window" title="提示信息" collapsible="false" minimizable="false" -->
<!--      maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px; -->
<!--         background: #fafafa;" data-options="left:'250px',top:'200px'"> -->
<!--     <div class="easyui-layout" fit="true"> -->
<!--         <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;"> -->
<!--             <label id="info_tip"></label> -->
<!--         </div> -->
<!--         <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;"> -->
<!--             <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="newContents_page.closeInfoTipWin()"> -->
<!--                 确认</a> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->
</body>
</html>