<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容管理</title>
</head>
<body>
<script>
    function onClickRow(index){
//         $("#theID_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#theID_delete").val($('#dg').datagrid('getRows')[index]['theID']);      
        $("#opinionID").val($('#dg').datagrid('getRows')[index]['opinionID']);   
    }


    var opinionPollInfo_page = {     

        initDeleteInfoWin:function () {
            $('#deleteInfoWin').window({
                title: '删除内容',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable:false
            });
        },

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
     

        closeDeleteInfoWin:function () {
        	 if($("#theID_delete").val()==""){
        		 alert("请选择要删除的数据");
                 return;
             }
            $('#deleteInfoWin').window('close');
        },

        closeInfoTipWin:function () {
            $('#infoTipWin').window('close');
        },

        
        deleteInfo:function (){
        	var url = "${ctx}/opinionPoll/deleteOpinionPollInfo.action";
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    opinionPollInfo_page.closeDeleteInfoWin();
                    var url = "${ctx}/opinionPollInfo/opinionPollInfoList.action";
                    var param = {};
                    param.opinionID = $("#opinionID").val();
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
        
    };




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
    	
        var url = "${ctx}/opinionPollInfo/opinionPollInfoList.action";
        var param = {};
        var opinionID='${opinionPoll.theID}';
        param.opinionID=opinionID;
        $("#opinionID").val(opinionID);
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
        },"json");
        
        opinionPollInfo_page.initDeleteInfoWin();
        $('#deleteInfoBtn').click(function() {
            if($("#theID_delete").val()==""){
                return;
            }
            $('#deleteInfoWin').window('open');
        });

        opinionPollInfo_page.initInfoTipWin();
        
        $('#backOpinionPollBtn').click(function() {
            window.location.href = "${ctx}/contents/contentsPage.action?catalogID=${opinionPoll.catalogID}";
        });
        
        $('#showInfoBtn').click(function(){
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	window.location.href = "${ctx}/opinionPollInfo/showOpinionPollInfo.action?theID="+$('#theID_delete').val();
        });
        
    });
    
</script>
<table width="100%">
<tr>
<td valign="top" width="90%">
<table id="dg" title="内容列表" style="width:auto;height:600px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: onClickRow">
    <thead>
		<tr>
		   	<th field="name" width="100"><input type="hidden" field="theID">姓名</th>
		    <th field="createDate" width="100"><input type="hidden" field="opinionID">时间</th>
		    <th field="phone" width="100">电话</th>
		    <th field="email" width="100">邮箱</th>
		</tr>
    </thead>
    <div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backOpinionPollBtn">返回</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="showInfoBtn">查看</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteInfoBtn">删除</a>
</div>

</table>
</td>
</tr>
</table>




<div id="deleteInfoWin" class="easyui-window" title="删除内容" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="theID_delete">
            
            <input type="hidden" id="opinionID">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="opinionPollInfo_page.deleteInfo()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="opinionPollInfo_page.closeDeleteInfoWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="opinionPollInfo_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>