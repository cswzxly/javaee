<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
    <link rel="stylesheet" href="${ctx}/resources/kindeditor/themes/default/default.css"/>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/lang/zh_CN.js"></script>
</head>
<body>
<script>
var editor;
KindEditor.ready(function(K){
	editor = K.create('#contents',{
		uploadJson:'${ctx}/resources/kindeditor/jsp/upload_json.jsp',
		fileManagerJson:'${ctx}/resources/kindeditor/jsp/file_manager_json.jsp',
		allowFileManager:true,
		filterMode:false,
		afterCreate : function() { 
	         this.sync(); 
	    }, 
	    afterBlur:function(){ 
	         this.sync(); 
	    } 
	});
});
var editOpenContents_page = {

	    initInfoTipWin:function () {
	        $('#infoTipWin').window({
	            title: '提示信息',
	            width: 200,
	            modal: true,
	            shadow: true,
	            closed: true,
	            height: 150,
	            resizable:false
	        });
	    },

	    closeInfoTipWin:function () {
	        $('#infoTipWin').window('close');
	    },
	    
	    saveEditOpenContents:function(){
	    	var flag = true;
	    	var theID = $("#theID").val();
            var title = $("#title").val();
            var catalogID = $("#catalogID").val();
            var releaseDate = $("#releaseDate").val();
            var source = $("#source").val();
            var status = $("#status").val();
            var contents = $("#contents").val();
            var conCode = $("#conCode").val();
            if(title==""){
            	flag=false;
            	alert("标题不能为空");
            	return false;
            }           
            if(contents==""){
            	flag=false;
            	alert("内容不能为空");
            	return false;
            }
            if(flag){
               var url = "${ctx}/opencontents/saveEditOpenContents.action";
               var param = {};
               param.theID = theID;
               param.releaseDate = releaseDate;
               param.title = title;
               param.source = source;
               param.contents = contents;
               param.status = status; 
               param.conCode = conCode;
               $.post(url,param,function(data){
                   if(data=="success"){
                	   window.location.href = "${ctx}/opencontents/openContentsPage.action?catalogID="+catalogID;
                   }
                   if(data=="error"){
                	   alert("更新失败");
                   }
               },"text");
	    }
	    }


}
$(function(){
	editOpenContents_page.initInfoTipWin();

    $('#backContentsBtn').click(function() {
        window.location.href = "${ctx}/opencontents/openContentsPage.action";
    });
    
});
</script>



<div id="newOpenContentsWin" class="easyui-panel" title="内容修改" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save"  style="width: auto; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post">
                <table class="formtable">
                    <tr>
                        <th>所属栏目：</th>
                        <td>
                        	<span>${catalog.title}</span>
                        	<input type="hidden" id="theID" value="${contents.theID}"/>
                        	<input type="hidden" id="catalogID" value="${contents.catalogID}"/>
                        </td>
                    </tr>
                    <tr>
                        <th>标题：</th>
                        <td><input id="title" type="text" value="${contents.title }" class="easyui-validatebox" data-options="required:true,validType:'length[3,40]'"/></td>
                    </tr>
                    <tr>
                        <th>文号：</th>
                        <td><input id="conCode" type="text" value="${contents.conCode }" class="easyui-validatebox" /></td>
                    </tr>
                    <tr>
                        <th>发布日期：</th>
                        <td>
                        	<input id="releaseDate" value="${contents.releaseDate }" type="text" width="100" readonly="readonly" value="${now }"/>
							<img onClick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <th>来源：</th>
                        <td><input id="source" type="text" value="${contents.source }" /></td>
                    </tr>
                    <tr>
                        <th>状态：</th>
                        <td>
                        	<select id="status">
                        		<option value="1" <c:if test="${contents.status eq '1'}">selected</c:if>>启用</option>
                        		<option value="0" <c:if test="${contents.status eq '0'}">selected</c:if>>停用</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                    	<th>内容</th>
                    	<td>
                    		<textarea id="contents">${contents.contents}</textarea>
                    	</td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="editOpenContents_page.saveEditOpenContents()">
                保存</a> 
        </div>
    </div>
</div>

<div id="infoTipWin" class="easyui-window" title="提示信息" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label id="info_tip"></label>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="editContents_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>
</body>
</html>