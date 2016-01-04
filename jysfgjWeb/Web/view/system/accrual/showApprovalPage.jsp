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
   
    var showApprovalPage = {

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
        	var newTitle="<tr id='tr_title"+length+"'><th><a href='javascript:void(0)' onClick='showApprovalPage.deleteChildAccrual("+length+")'>【删除】</a>子项名称：</th><td colspan='3'><input type='hidden' name='length' id='length' value=''><input name='accrualList["+length+"].title' id='accrualList["+length+"].title' type='text' class='easyui-validatebox' /></td></tr>";
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
        deleteChildAccrual:function(id,theID){
        	
        	if (confirm("确认要删除？")) {
                $("#tr_title"+id).remove();
            	$("#tr_dateStatus"+id).remove();
            	$("#tr_objectDept"+id).remove();
            	$("#tr_contentsRemark"+id).remove();
            	var url = "${ctx}/accrual/deleteAccrual.action";
            	var param = {};
            	
            	alert(theID);
            	param.theID = theID;
            	$.post(url, param, function (data) {
					alert("删除成功！");
                }, "json");
            }
        }
    }
    $(function () {

        $('#backContentsBtn').click(function () {
            window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+$("#catalogID").val();
        });

    });

</script>


<div id="showApprovalPage" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
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
                        </td>
                        <th>权责清单类型：</th>
                        <td>
                        	<c:if test="${accrual.accrualType=='1'}">行政许可</c:if>
                        	<c:if test="${accrual.accrualType=='2'}">非行政许可审批</c:if>
                        	<c:if test="${accrual.accrualType=='3'}">行政处罚</c:if>
                        	<c:if test="${accrual.accrualType=='4'}">行政强制</c:if>
                        	<c:if test="${accrual.accrualType=='5'}">行政征收</c:if>
                        	<c:if test="${accrual.accrualType=='6'}">行政给付</c:if>
                        	<c:if test="${accrual.accrualType=='7'}">行政检查</c:if>
                        	<c:if test="${accrual.accrualType=='8'}">行政指导</c:if>
                        	<c:if test="${accrual.accrualType=='9'}">行政确认</c:if>
                        	<c:if test="${accrual.accrualType=='10'}">其他</c:if>
                        	<input type="hidden" name="accrual.accrualType" id="accrual.accrualType" value="${accrual.accrualType}"/>
                        	<input type="hidden" name="accrual.theID" id="accrual.theID" value="${accrual.theID}"/>
						</td>
                    </tr>
                    <tr>
                        <th>项目名称：</th>
                        <td colspan="3"><input name="accrual.title" id="accrual.title" type="text" value="${accrual.title }" class="easyui-validatebox" /></td>
                    </tr>
                    
                    <c:forEach items="${accrualList }" var="item" varStatus="status">
                    	<tr id="tr_title${status.index}">
	                    	<th>
	                    		<c:if test="${status.index!=0 }">
			                    	<a href="javascript:void(0)" onClick="showApprovalPage.deleteChildAccrual(${status.index},${item.theID})">【删除】</a>
			                    </c:if>
								子项名称：
							</th>
	                        <td colspan="3">
	                        	<input type="hidden" name="length" id="length" value="0">
	                        	<input type="hidden" name="accrualList[${status.index}].theID" id="accrualList[${status.index}].theID" value="${item.theID}">
	                            <input name="accrualList[${status.index}].title" id="accrualList[${status.index}].title" value="${item.title }" type="text" class="easyui-validatebox" />
	                        </td>
	                    </tr>
	                    <tr id="tr_dateStatus${status.index}">
	                        <th>发布日期：</th>
	                        <td>
	                            <input name="accrualList[${status.index}].releaseDate" id="accrualList[${status.index}].releaseDate" type="text" width="100" readonly="readonly" value="${item.releaseDate }"/>
	                            <img onClick="WdatePicker({el:'accrualList[${status.index}].releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	                        </td>
	                        <th>状态：</th>
	                        <td>
	                            <select name="accrualList[${status.index}].status" id="accrualList[${status.index}].status">
	                                <option value="1" <c:if test="${item.status=='1' }">selected</c:if>>启用</option>
	                                <option value="0" <c:if test="${item.status=='0' }">selected</c:if>>停用</option>
	                            </select>
	                        </td>
	                    </tr>
	                    
	                    <tr id="tr_objectDept${status.index}">
	                    	<th>审批对象：</th>
	                        <td>
	                            <input name="accrualList[${status.index}].approvalObject" id="accrualList[${status.index}].approvalObject" type="text" value="${item.approvalObject }" class="easyui-validatebox" />
	                        </td>
	                        <th>其他公共审批部门：</th>
	                        <td>
	                            <input name="accrualList[${status.index}].approvalDept" id="accrualList[${status.index}].approvalDept" type="text" value="${item.approvalObject }" class="easyui-validatebox" />
	                        </td>
	                    </tr>
	                    <tr id="tr_contentsRemark${status.index}">
	                    	<th>实施依据：</th>
	                        <td>
	                            <textarea name="accrualList[${status.index}].contents" id="accrualList[${status.index}].contents" cols="50" rows="10">${item.contents }</textarea>
	                        </td>
	                        <th>备注：</th>
	                        <td>
	                            <textarea name="accrualList[${status.index}].remark" id="accrualList[${status.index}].remark" cols="50" rows="10">${item.remark }</textarea>
	                        </td>
	                    </tr>
                    </c:forEach>
                </table>
            	<div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
            		<a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="showApprovalPage.addChildAccrual()">
                	添加子项</a>
            		<a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="showApprovalPage.submitAccrual()">
                	保存</a>
        		</div>
            </form>
        </div>
       
    </div>
</div>


</body>
</html>