<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
</head>
<body>
<script>

var operationLog_page = {

    onClickRow:function (index){
        $("#theID").val($('#dg').datagrid('getRows')[index]['theID']);
    }
}


//加载数据
function pagerFilter(data){
    if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
        data = {
            total: data.length,
            rows: data
        }
    }
    var dg = $(this);
    var opts = dg.datagrid('options');
    var pager = dg.datagrid('getPager');
    pager.pagination({
        onSelectPage:function(pageNum, pageSize){
            opts.pageNumber = pageNum;
            opts.pageSize = pageSize;
            pager.pagination('refresh',{
                pageNumber:pageNum,
                pageSize:pageSize
            });
            dg.datagrid('loadData',data);
        }
    });
    if (!data.originalRows){
        data.originalRows = (data.rows);
    }
    var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
    var end = start + parseInt(opts.pageSize);
    data.rows = (data.originalRows.slice(start, end));
    return data;
}

$(function(){
	
    var url = "${ctx}/operationLog/operationLogList.action";
    var param = {};
   
    $.post(url,param,function(data){
        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
    },"json");

    $("#showOperationLogBtn").click(function(){
    	if($("#theID_delete").val()==""){
    		return;
    	}
    	window.location.href = "${ctx}/operationLog/showOperationLog.action?theID="+$("#theID").val();
    });

});



</script>

<table id="dg" title="列表" style="width:auto;height:640px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: operationLog_page.onClickRow">
    <thead>
    <tr>
        <th field="operatorID" width="80"><input type="hidden" id="theID" />登陆账号</th>
        <th field="operatorName" width="100">用户名</th>
        <th field="createDate" width="120">操作时间</th>
        <th field="ipAddress" width="100">IP地址</th>
        <th field="catalogName" width="100"><input type="hidden" field="catalogName">操作栏目</th>
        <th field="details" width="300">操作细节</th>
    </tr>
    </thead>
</table>
<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="showOperationLogBtn">查看日志</a>
</div>

</body>
</html>