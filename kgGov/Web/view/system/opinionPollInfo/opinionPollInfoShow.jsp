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

var opinionPollInfoShow = {

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
	    
	    


}
$(function(){
	opinionPollInfoShow.initInfoTipWin();

    $('#backInfoListBtn').click(function() {
        window.location.href = "${ctx}/opinionPoll/opinionPollInfoPage.action?opinionID="+$('#opinionID').val();
    });
    
});

</script>



<div id="newContentsWin" class="easyui-panel" title="民意征集内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save"  style="width: auto; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backInfoListBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post">
                <table class="formtable">
                    <tr>
                        <th>民意征集标题：</th>
                        <td>
                        	<span>${opinionPoll.title}</span>
                        	<input type="hidden" id="opinionID" value="${opinionPollInfo.opinionID}"/>
                        	<input type="hidden" id="theID" value="${opinionPollInfo.theID }" />
                        </td>
                    </tr>
                    <tr>
                        <th>姓名：</th>
                        <td>
                        	${opinionPollInfo.name }
                        </td>
                    </tr>
                    <tr>
                        <th>收到意见时间：</th>
                        <td>
                        	${opinionPollInfo.createDate }
                        </td>
                    </tr>
                    <tr>
                        <th>电话：</th>
                        <td>
                        	${opinionPollInfo.phone }
                        </td>
                    </tr>
                    <tr>
                        <th>邮箱：</th>
                        <td>
                        	${opinionPollInfo.email }
                        </td>
                    </tr>
                    <tr>
                        <th>ip地址：</th>
                        <td>
                        	${opinionPollInfo.ip }
                        </td>
                    </tr>
                    <tr>
                    	<th>征集意见内容：</th>
                    	<td>
                    		<textarea id="contents" rows="20px" cols="100px" readonly="true">${opinionPollInfo.contents}</textarea>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="opinionPollInfoShow.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>
</body>
</html>