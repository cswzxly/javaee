<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容编辑</title>
    <link rel="stylesheet" href="${ctx}/resources/kindeditor/themes/default/default.css"/>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/lang/zh_CN.js"></script>
    <script type="text/javascript" src="${ctx}/resources/system/js/ajaxfileupload.js"></script>
</head>
<body>
<script>
var editor;
KindEditor.ready(function(K){
	editor = K.create('#summary',{
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
var editOpinionPoll_page = {

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
	    
	    saveNewOpinionPoll:function(){
	    	var flag = true;
	    	var theID = $("#theID").val();
            var title = $("#title").val();
            var catalogID = $("#catalogID").val();
            var beginDate = $("#beginDate").val();
            var endDate = $("#endDate").val();
            var summary = $("#summary").val();
            var status = $("#status").val();
            var isCollect = $("#isCollect").val();
            var releaseDate = $("#releaseDate").val();
            if(title==""){
            	flag=false;
            	alert("标题不能为空");
            	return false;
            } 
            if(releaseDate==""){
            	flag=false;
            	alert("发布日期不能为空");
            	return false;
            }
            if(summary==""){
            	flag=false;
            	alert("内容不能为空");
            	return false;
            }
            if(beginDate==""){
            	flag=false;
            	alert("开始时间不能为空");
            	return false;
            }
            if(endDate==""){
            	flag=false;
            	alert("结束时间不能为空");
            	return false;
            }
         
            if(flag){
               var url = "${ctx}/opinionPoll/saveEditOpinionPoll.action";
               var param = {};
               param.theID = theID;
               param.catalogID = catalogID;
               param.beginDate = beginDate;
               param.endDate = endDate;
               param.title = title;
               param.summary = summary;
               param.status = status;   
               param.isCollect = isCollect;
               param.releaseDate = releaseDate;
               $.post(url,param,function(data){
            	   if(data=="success"){
                	   window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+catalogID;
                   }
                   if(data=="error"){
                	   alert("更新失败");
                   }
               },"text");
	   		}
	    }


}
$(function(){
	editOpinionPoll_page.initInfoTipWin();

    $('#backContentsBtn').click(function() {
        window.location.href = "${ctx}/contents/contentsPage.action";
    });
    
});

</script>



<div id="newContentsWin" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
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
                        	<input type="hidden" id="catalogID" value="${opinionPoll.catalogID}"/>
                        	<input type="hidden" id="theID" value="${opinionPoll.theID }" />
                        </td>
                    </tr>
                    <tr>
                        <th>标题：</th>
                        <td>
                        	<input id="title" type="text" value="${opinionPoll.title }" class="easyui-validatebox" data-options="required:true,validType:'length[1,40]'"/>
                        </td>
                    </tr>
                    <tr>
                        <th>发布日期：</th>
                        <td>
                        	<input id="releaseDate" type="text" value="${opinionPoll.releaseDate }" width="100" readonly="readonly" />
							<img onClick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <th>开始日期：</th>
                        <td>
                        	<input id="beginDate" type="text" value="${opinionPoll.beginDate }" width="100" readonly="readonly" />
							<img onClick="WdatePicker({el:'beginDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <th>结束日期：</th>
                        <td>
                        	<input id="endDate" type="text" value="${opinionPoll.endDate }" width="100" readonly="readonly"/>
							<img onClick="WdatePicker({el:'endDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <th>状态：</th>
                        <td>
                        	<select id="status">
                        		<option value="1" <c:if test="${opinionPoll.status==1}">selected</c:if>>启用</option>
                        		<option value="0" <c:if test="${opinionPoll.status==0}">selected</c:if>>停用</option>
                        	</select>
                        </td>
                    </tr>
                   	<tr>
                        <th>是否本站征集：</th>
                        <td>
                        	<select id="isCollect">
                        		<option value="1" <c:if test="${opinionPoll.isCollect==1}">selected</c:if>>是</option>
                        		<option value="0" <c:if test="${opinionPoll.isCollect==0}">selected</c:if>>否</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                    	<th>内容</th>
                    	<td>
                    		<textarea id="summary">${opinionPoll.summary}</textarea>
                    	</td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="editOpinionPoll_page.saveNewOpinionPoll()">
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="editOpinionPoll_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>
</body>
</html>