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

var letter_page = {

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
	var flag = $('#_flag').val();
	var isOpen = $('#_isOpen').val();
	var status = $('#_status').val();
    var url = "${ctx}/letter/queryLetterList.action";
    var param = {};
    if((flag!=null)&&(flag!="")){
    	param.flag=flag;        
    }   
    if((isOpen!=null)&&(isOpen!="")){
    	param.isOpen = isOpen;
    }
    if((status!=null)&&(status!="")){
    	param.status = status;
    }
    $.post(url,param,function(data){
        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
    },"json");
    
    $('#letterDetailBtn').click(function() {
        if($("#theID").val()==""){
            return;
        }
        window.location.href = "${ctx}/letter/queryLetterByBean.action?theID="+$("#theID").val();
    });
    
});



</script>
<div>
<input type="hidden" id="_flag" value=${flag }>
<input type="hidden" id="_isOpen" value=${isOpen }>
<input type="hidden" id="_status" value=${status }>
	<form action="${ctx}/letter/queryLetterByLike.action" method="post">
	<c:choose>
		<c:when test="${flag=='1'}">
		请选择信箱类型：<select name="flag" id="flag"><option></option><option value="1" selected="selected">领导信箱</option><option value="2">建言献策</option><option value="3">投诉举报</option></select>
		</c:when>
		<c:when test="${flag=='2'}">
		请选择信箱类型：<select name="flag" id="flag"><option></option><option value="1">领导信箱</option><option value="2" selected="selected">建言献策</option><option value="3">投诉举报</option></select> 
		</c:when>
		<c:when test="${flag=='3'}">
		请选择信箱类型：<select name="flag" id="flag"><option></option><option value="1">领导信箱</option><option value="2">建言献策</option><option value="3" selected="selected">投诉举报</option></select> 
		</c:when>
		<c:otherwise>
		请选择信箱类型：<select name="flag" id="flag"><option></option><option value="1">领导信箱</option><option value="2">建言献策</option><option value="3">投诉举报</option></select> 
		</c:otherwise>
	</c:choose>
	
	<c:choose>
	<c:when test="${isOpen =='1'}">
		是否公开：<select name="isOpen" id="isOpen"><option></option><option value="1" selected="selected">公开</option><option value="0">不公开</option></select> &nbsp;&nbsp;
	</c:when>
	<c:when test="${isOpen =='0'}">
		是否公开：<select name="isOpen" id="isOpen"><option></option><option value="1">公开</option><option value="0" selected="selected">不公开</option></select> &nbsp;&nbsp;
	</c:when>
	<c:otherwise>
		是否公开：<select name="isOpen" id="isOpen"><option></option><option value="1">公开</option><option value="0">不公开</option></select> &nbsp;&nbsp;
	</c:otherwise>
	</c:choose>
	
	<c:choose>
	<c:when test="${status =='1'}">
		回复状态：<select name="status" id="status"><option></option><option value="1" selected="selected">已回复</option><option value="0">未回复</option></select> &nbsp;&nbsp;
	</c:when>
	<c:when test="${status =='0'}">
		回复状态：<select name="status" id="status"><option></option><option value="1">已回复</option><option value="0" selected="selected">未回复</option></select> &nbsp;&nbsp;
	</c:when>
	<c:otherwise>
		回复状态：<select name="status" id="status"><option></option><option value="1">已回复</option><option value="0">未回复</option></select> &nbsp;&nbsp;
	</c:otherwise>
	</c:choose>
	
	<input type="submit" value="查询">
	</form>
</div>
<table id="dg" title="列表" style="width:auto;height:640px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: letter_page.onClickRow">
    <thead>
    <tr>
        <input type="hidden" id="theID" />
        <th field="name" width="150">姓名</th>
        <th field="theme" width="200">主题</th>
        <th field="flagName" width="80"><input type="hidden" field="flag">信箱类型</th>
        <th field="status" width="50">状态</th>
        <th field="isOpen" width="60">是否公开</th>
    </tr>
    </thead>
</table>
<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="letterDetailBtn">查看详情</a>
</div>

<!-- <div id="letterDetailWin" class="easyui-window" title="详情" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    
</div> -->

</body>
</html>