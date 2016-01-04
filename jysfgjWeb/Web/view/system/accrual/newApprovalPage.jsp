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
   
    var newApprovalPage = {

        saveNewAccrual: function () {
            var flag = true;
            var title = $("#title").val();
            var catalogID = $("#catalogID").val();
            var accrualType = $("#accrualType").val();
            var releaseDate = $("#releaseDate").val();
            var status = $("#status").val();
            var punishType = $("#punishType").val();
            var contents = $("#contents").val();
            var remark = $("#remark").val();
            if (title == "") {
                flag = false;
                alert("可予处罚的违法行为不能为空");
                return false;
            }
            if (punishType == "") {
                flag = false;
                alert("处罚种类不能为空");
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
                param.punishType = punishType;
                param.contents = contents;
                param.status = status;
                param.remark = remark;
                $.post(url, param, function (data) {
					window.location.href = "${ctx}/contents/contentsPage.action?catalogID=" + catalogID;
                }, "json");
            }
        },
        addChildAccrual:function(){
        	var length = $("input[name=length]").length;
        	var newTitle="<tr id='tr_title"+length+"'><th><a href='javascript:void(0)' onClick='newApprovalPage.deleteChildAccrual("+length+")'>【删除】</a>子项名称：</th><td colspan='3'><input type='hidden' name='length' id='length' value=''><input name='accrualList["+length+"].title' id='accrualList["+length+"].title' type='text' class='easyui-validatebox' /></td></tr>";
        	var newDateStatus="<tr id='tr_dateStatus"+length+"'><th>发布日期：</th><td><input name='accrualList["+length+"].releaseDate' id='accrualList["+length+"].releaseDate' type='text' width='100' readonly='readonly' value='${now }'/><img onClick='WdatePicker({el:\"accrualList["+length+"].releaseDate\",dateFmt:\"yyyy-MM-dd HH:mm:ss\"})' src='${ctx}/resources/My97DatePicker/skin/datePicker.gif' width='16' height='22' align='absmiddle'></td><th>状态：</th><td><select name='accrualList["+length+"].status' id='accrualList["+length+"].status'><option value='1'>启用</option><option value='0'>停用</option></select></td></tr>";
        	var newObjectDept="<tr id='tr_objectDept"+length+"'><th>审批对象：</th><td><input name='accrualList["+length+"].approvalObject' id='accrualList["+length+"].approvalObject' type='text' class='easyui-validatebox'/></td><th>其他公共审批部门：</th><td><input name='accrualList["+length+"].approvalDept' id='accrualList["+length+"].approvalDept' type='text' class='easyui-validatebox' /></td></tr>";
        	var newContentsRemark="<tr id='tr_contentsRemark"+length+"'><th>实施依据：</th><td><textarea name='accrualList["+length+"].contents' id='accrualList["+length+"].contents' cols='50' rows='10'></textarea></td><th>备注：</th><td><textarea name='accrualList["+length+"].remark' id='accrualList["+length+"].remark' cols='50' rows='10'></textarea></td></tr>";
        	var newHtml = newTitle+newDateStatus+newObjectDept+newContentsRemark;
        	var theLength = parseInt(length)-1;
        	$("#tr_contentsRemark"+theLength).after(newHtml);
    		$("#length").val(length);
        },
        submitAccrual:function(){
        	$("#newAccrualForm").submit();
        },
        deleteChildAccrual:function(id){
        	$("#tr_title"+id).remove();
        	$("#tr_dateStatus"+id).remove();
        	$("#tr_objectDept"+id).remove();
        	$("#tr_contentsRemark"+id).remove();
        }
    }
    $(function () {

        $('#backContentsBtn').click(function () {
            window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+$("#catalogID").val();
        });

    });

</script>


<div id="newApprovalPage" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
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
                        <th>项目名称：</th>
                        <td colspan="3"><input name="title" id="title" type="text" class="easyui-validatebox" /></td>
                    </tr>
                    <tr id="tr_title0">
                    	<th>&nbsp;子项名称：</th>
                        <td colspan="3">
                        	<input type="hidden" name="length" id="length" value="0">
                            <input name="accrualList[0].title" id="accrualList[0].title" type="text" class="easyui-validatebox" />
                        </td>
                    </tr>
                    <tr id="tr_dateStatus0">
                        <th>发布日期：</th>
                        <td>
                            <input name="accrualList[0].releaseDate" id="accrualList[0].releaseDate" type="text" width="100" readonly="readonly" value="${now }"/>
                            <img onClick="WdatePicker({el:'accrualList[0].releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                        <th>状态：</th>
                        <td>
                            <select name="accrualList[0].status" id="accrualList[0].status">
                                <option value="1">启用</option>
                                <option value="0">停用</option>
                            </select>
                        </td>
                    </tr>
                    
                    <tr id="tr_objectDept0">
                    	<th>审批对象：</th>
                        <td>
                            <input name="accrualList[0].approvalObject" id="accrualList[0].approvalObject" type="text" class="easyui-validatebox" />
                        </td>
                        <th>其他公共审批部门：</th>
                        <td>
                            <input name="accrualList[0].approvalDept" id="accrualList[0].approvalDept" type="text" class="easyui-validatebox" />
                        </td>
                    </tr>
                    <tr id="tr_contentsRemark0">
                    	<th>实施依据：</th>
                        <td>
                            <textarea name="accrualList[0].contents" id="accrualList[0].contents" cols="50" rows="10"></textarea>
                        </td>
                        <th>备注：</th>
                        <td>
                            <textarea name="accrualList[0].remark" id="accrualList[0].remark" cols="50" rows="10"></textarea>
                        </td>
                    </tr>
                    
                </table>
            	<div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
            		<a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="newApprovalPage.addChildAccrual()">
                	添加子项</a>
            		<a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="newApprovalPage.submitAccrual()">
                	保存</a>
        		</div>
            </form>
        </div>
       
    </div>
</div>


</body>
</html>