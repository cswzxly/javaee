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

var opinionPoll_page = {

    onClickRow:function (index){
        $("#theID_delete").val($('#dg').datagrid('getRows')[index]['theID']);
    }, 
    
	initDeleteOpinionPollWin:function () {
	    $('#deleteOpinionPollWin').window({
	        title: '删除内容',
	        width: 200,
	        modal: true,
	        shadow: true,
	        closed: true,
	        height: 150,
	        resizable:false
	    });
	},
	closeDeleteOpinionPollWin:function () {
		if($("#theID_delete").val()==""){
			alert("请选择要删除的数据");
            return;
        }
        $('#deleteOpinionPollWin').window('close');
    },
    deleteOpinionPoll:function (){
    	var url="";
        var param = {};
        param.theID = $("#theID_delete").val();
        $.post(url,param,function(data){
            if(data=="success"){
            	opinionPoll_page.closeDeleteOpinionPollWin();
            	var url = "${ctx}/opinionPoll/opinionPollList.action";
                var param = {};
                $.post(url,param,function(data){
                    $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                },"json");
            }else if(data=="other"){
            	opinionPoll_page.closeDeleteOpinionPollWin();
            	alert("该数据存在关联数据，无法删除！");
            }
        },"text");
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
	
    var url = "${ctx}/opinionPoll/opinionPollList.action";
    var param = {};
   
    $.post(url,param,function(data){
        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
    },"json");
    $('#addOpinionPollBtn').click(function() {  
    	window.location.href = "${ctx}/opinionPoll/newOpinionPollPage.action";
    });

    $("#editOpinionPollBtn").click(function(){
    	if($("#theID_delete").val()==""){
    		return;
    	}
    	window.location.href = "${ctx}/opinionPoll/showOpinionPollEdit.action?theID="+$("#theID_delete").val();
    });
    opinionPoll_page.initDeleteOpinionPollWin();
    $('#deleteOpinionPollBtn').click(function() {
        if($("#theID_delete").val()==""){
            return;
        }
        $('#deleteOpinionPollWin').window('open');
    });

    $('#opinionPollInfoBtn').click(function(){
    	if($("#theID_delete").val()==""){
    		return;
    	}
    	window.location.href="${ctx}/opinionPoll/opinionPollInfoPage.action?opinionID="+$("#theID_delete").val();
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
				onClickRow: opinionPoll_page.onClickRow">
    <thead>
    <tr>
        <th field="title" width="150"><input type="hidden" id="theID" />标题</th>
        <th field="releaseDate" width="150">发布时间</th>
        <th field="statusName" width="45"><input type="hidden" field="status">状态</th>
        <th field="beginDate" width="150">开始时间</th>
        <th field="endDate" width="150">结束时间</th>
        <th field="isCollectName" width="100"><input type="hidden" field="isCollect">是否本站征集</th>
    </tr>
    </thead>
</table>
<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addOpinionPollBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editOpinionPollBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteOpinionPollBtn">删除</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="opinionPollInfoBtn">查看征集</a>
</div>

<!-- <div id="letterDetailWin" class="easyui-window" title="详情" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    
</div> -->
<div id="deleteOpinionPollWin" class="easyui-window" title="删除内容" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="theID_delete">
            
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="contents_page.deleteContents()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="contents_page.closeDeleteContentsWin()">取消</a>
        </div>
    </div>
</div>

</body>
</html>