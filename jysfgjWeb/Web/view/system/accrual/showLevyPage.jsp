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
   
    var newLevyPage = {

        saveNewAccrual: function () {
            var flag = true;
            var title = $("#title").val();
            var catalogID = $("#catalogID").val();
            var accrualType = $("#accrualType").val();
            var releaseDate = $("#releaseDate").val();
            var status = $("#status").val();
            var levyStandard = $("#levyStandard").val();
            var contents = $("#contents").val();
            var remark = $("#remark").val();
            if (title == "") {
                flag = false;
                alert("征收项目不能为空");
                return false;
            }
            if (levyStandard == "") {
                flag = false;
                alert("征收标准不能为空");
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
                param.levyStandard = levyStandard;
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


<div id="newLevyPage" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save" style="width: auto; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newAccrualForm" method="post" action="${ctx}/accrual/saveEditAccrual.action">
                <table class="formtable">
                	<tr>
                		<th>所属栏目：</th>
                        <td>
                            <span>${catalog.title}</span>
                            <input type="hidden" name="accrual.catalogID" id="catalogID" value="${accrual.catalogID}"/>
                            <input type="hidden" name="accrual.theID" id="accrual.theID" value="${accrual.theID}"/>
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
                        	<input type="hidden" name="accrual.accrualType" id="accrual.accrualType" value="${accrual.accrualType}"/>
						</td>
                    </tr>
                    <tr>
                        <th>征收项目：</th>
                        <td colspan="3"><input name="accrual.title" id="accrual.title" type="text" value="${accrual.title }" class="easyui-validatebox" /></td>
                    </tr>
                    <tr>
                        <th>发布日期：</th>
                        <td>
                            <input id="accrual.releaseDate" name="releaseDate" type="text" width="100" readonly="readonly" value="${accrual.releaseDate }"/>
                            <img onClick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                        <th>状态：</th>
                        <td>
                            <select name="accrual.status" id="accrual.status">
                                <option value="1" <c:if test="${accrual.status=='1' }">selected</c:if>>启用</option>
                                <option value="0" <c:if test="${accrual.status=='0' }">selected</c:if>>停用</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                    	<th>征收标准：</th>
                        <td colspan="3">
                            <textarea name="accrual.levyStandard" id="accrual.levyStandard" cols="100" rows="10">${accrual.levyStandard}</textarea>
                        </td>
                    </tr>
                    <tr>
                    	<th>实施依据：</th>
                        <td colspan="3">
                            <textarea name="accrual.contents" id="accrual.contents" cols="100" rows="10">${accrual.contents}</textarea>
                        </td>
                    </tr>
                    <tr>
                    	<th>备注：</th>
                        <td colspan="3">
                            <textarea name="accrual.remark" id="accrual.remark" cols="100" rows="10">${accrual.remark }</textarea>
                        </td>
                    </tr>
                </table>
                <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
		            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="newLevyPage.submitAccrual()">
		                保存</a>
		        </div>
            </form>
        </div>
        
    </div>
</div>


</body>
</html>