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

var operationLogShow = {

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
	    }
}
$(function(){
	operationLogShow.initInfoTipWin();

    $('#backListBtn').click(function() {
        window.location.href = "${ctx}/opinionPoll/operationLogPage.action";
    });
    
});

</script>



<div id="newContentsWin" class="easyui-panel" title="日志内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save"  style="width: auto; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backListBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post">
                <table class="formtable">
                    <tr>
                        <th>操作人账号：</th>
                        <td>
                        	<span>${operationLog.operatorID}</span>
                        	<input type="hidden" id="theID" value="${operationLog.theID }" />
                        </td>
                    </tr>
                    <tr>
                        <th>操作人姓名：</th>
                        <td>
                        	${operationLog.operatorName }
                        </td>
                    </tr>
                    <tr>
                        <th>操作时间：</th>
                        <td>
                        	${operationLog.createDate }
                        </td>
                    </tr>
                    <tr>
                        <th>IP地址：</th>
                        <td>
                        	${operationLog.ipAddress }
                        </td>
                    </tr>
                    <tr>
                        <th>操作栏目：</th>
                        <td>
                        	${operationLog.catalogName }
                        </td>
                    </tr>
                    <tr>
                    	<th>操作细节：</th>
                    	<td>
                    		<textarea id="details" rows="20px" cols="100px" readonly="true">${operationLog.details}</textarea>
                    	</td>
                    </tr>
                </table>
            </form>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="operationLogShow.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>
</body>
</html>