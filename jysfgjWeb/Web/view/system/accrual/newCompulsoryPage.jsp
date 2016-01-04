<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容新建</title>
    <link rel="stylesheet" href="${ctx}/resources/kindeditor/themes/default/default.css"/>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/lang/zh_CN.js"></script>
    <script type="text/javascript" src="${ctx}/resources/system/js/ajaxfileupload.js"></script>
</head>
<body>
<script>
   
    var newCompulsoryPage = {

        saveNewAccrual: function () {
            var flag = true;
            var title = $("#title").val();
            var catalogID = $("#catalogID").val();
            var accrualType = $("#accrualType").val();
            var releaseDate = $("#releaseDate").val();
            var status = $("#status").val();
            var compulsoryMeasures = $("#compulsoryMeasures").val();
            var contents = $("#contents").val();
            var remark = $("#remark").val();
            if (title == "") {
                flag = false;
                alert("行政强制对象不能为空");
                return false;
            }
            if (compulsoryMeasures == "") {
                flag = false;
                alert("行政强制措施不能为空");
                return false;
            }
            if (contents == "") {
                flag = false;
                alert("实施依据不能为空");
                return false;
            }
            
            if (releaseDate == "") {
                flag = false;
                alert("发布时间不能为空");
                return false;
            }
            
            if (flag) {
                var url = "${ctx}/accrual/saveNewAccrual.action";
                var param = {};
                param.catalogID = catalogID;
                param.accrualType = accrualType;
                param.releaseDate = releaseDate;
                param.title = title;
                param.compulsoryMeasures = compulsoryMeasures;
                param.contents = contents;
                param.status = status;
                param.remark = remark;
                $.post(url, param, function (data) {
					window.location.href = "${ctx}/contents/contentsPage.action?catalogID=" + catalogID;
                }, "json");
            }
        },
        submitAccrual:function(){
        	$("#newAccrualForm").submit();
        }
    }
    $(function () {

        $('#backContentsBtn').click(function () {
            window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+$("#catalogID").val();
        });

    });

</script>


<div id="newCompulsoryPage" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save" style="width: auto; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newAccrualForm" method="post" action="${ctx}/accrual/saveNewAccrual.action">
                <table class="formtable">
                	<tr>
                		<th>所属栏目：</th>
                        <td>
                            <span>${catalog.title}</span>
                            <input type="hidden" name="catalogID" id="catalogID" value="${catalog.theID}"/>
                        </td>
                        <th>权责清单类型：</th>
                        <td>
                        	<c:if test="${accrualType=='1'}">行政许可</c:if>
                        	<c:if test="${accrualType=='2'}">非行政许可审批</c:if>
                        	<c:if test="${accrualType=='3'}">行政处罚</c:if>
                        	<c:if test="${accrualType=='4'}">行政强制</c:if>
                        	<c:if test="${accrualType=='5'}">行政征收</c:if>
                        	<c:if test="${accrualType=='6'}">行政给付</c:if>
                        	<c:if test="${accrualType=='7'}">行政检查</c:if>
                        	<c:if test="${accrualType=='8'}">行政指导</c:if>
                        	<c:if test="${accrualType=='9'}">行政确认</c:if>
                        	<c:if test="${accrualType=='10'}">其他</c:if>
                        	<input type="hidden" name="accrualType" id="accrualType" value="${accrualType}"/>
						</td>
                    </tr>
                    <tr>
                        <th>行政强制对象：</th>
                        <td colspan="3"><input name="title" id="title" type="text" class="easyui-validatebox" /></td>
                    </tr>
                    <tr>
                        <th>发布日期：</th>
                        <td>
                            <input name="releaseDate" id="releaseDate" type="text" width="100" readonly="readonly" value="${now }"/>
                            <img onClick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                        <th>状态：</th>
                        <td>
                            <select name="status" id="status">
                                <option value="1">启用</option>
                                <option value="0">停用</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                    	<th>行政强制措施：</th>
                        <td colspan="3">
                            <textarea name="compulsoryMeasures" id="compulsoryMeasures" cols="100" rows="10"></textarea>
                        </td>
                    </tr>
                    <tr>
                    	<th>实施依据：</th>
                        <td colspan="3">
                            <textarea name="contents" id="contents" cols="100" rows="10"></textarea>
                        </td>
                    </tr>
                    <tr>
                    	<th>备注：</th>
                        <td colspan="3">
                            <textarea name="remark" id="remark" cols="100" rows="10"></textarea>
                        </td>
                    </tr>
                </table>
                <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
		            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="newCompulsoryPage.submitAccrual()">
		                保存</a>
		        </div>
            </form>
        </div>
        
    </div>
</div>


</body>
</html>