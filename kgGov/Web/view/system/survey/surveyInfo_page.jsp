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



var surveyInfo_page = {

    onClickRow:function (index){
        $("#id_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#content_edit").val($('#dg').datagrid('getRows')[index]['content']);
        $("#status_edit").val($('#dg').datagrid('getRows')[index]['status']);
        $("#id_delete").val($('#dg').datagrid('getRows')[index]['theID']);
    },

    //设置新建子模块
    initNewSurveyInfoWin:function () {
        $('#newSurveyInfoWin').window({
            title: '新建选项内容',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },
    initEditSurveyInfoWin:function () {
        $('#editSurveyInfoWin').window({
            title: '编辑选项内容',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },

    initDeleteSurveyInfoWin:function () {
        $('#deleteSurveyInfoWin').window({
            title: '删除选项内容',
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

    //关闭新建子模块
    closeNewSurveyInfoWin:function () {
        $('#newSurveyInfoWin').window('close');
    },

    closeEditSurveyInfoWin:function () {
        $('#editSurveyInfoWin').window('close');
    },

    closeDeleteSurveyInfoWin:function () {
        $('#deleteSurveyInfoWin').window('close');
    },

    closeInfoTipWin:function () {
        $('#infoTipWin').window('close');
    },

    saveNewSurveyInfo:function (){
        var flag = $("#newSurveyInfoForm").form('validate');
        if(flag){
            var url = "${ctx}/survey/saveNewSurveyInfo.action";
            var param = {};
            param.pID = ${pID};
            param.content = $("#content_save").val();
            param.status = $("#status_save").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    surveyInfo_page.closeNewSurveyInfoWin();
                    var url = "${ctx}/survey/queryAllSurveyInfoList.action";
                    var param = {};
                    param.pID = ${pID};
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }

    },

    saveEditSurveyInfo:function (){
        var flag = $("#editSurveyInfoForm").form('validate');
        if(flag){
            var url = "${ctx}/survey/saveEditSurveyInfo.action";
            var param = {};
            param.pID = ${pID};
            param.theID = $("#id_edit").val();
            param.content = $("#content_edit").val();
            param.status = $("#status_edit").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    surveyInfo_page.closeEditSurveyInfoWin();
                    $("#content_edit").val("");
                    $("#status_edit").val("");
                    var url = "${ctx}/survey/queryAllSurveyInfoList.action";
                    var param = {};
                    param.pID = ${pID};
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
    },

    deleteSurveyInfo:function (){
        var url = "${ctx}/survey/deleteSurveyInfo.action";
        var param = {};
        param.theID = $("#id_delete").val();
        $.post(url,param,function(data){
            if(data=="success"){
                surveyInfo_page.closeDeleteSurveyInfoWin();
                var url = "${ctx}/survey/queryAllSurveyInfoList.action";
                var param = {};
                param.pID = ${pID};
                $.post(url,param,function(data){
                    $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                },"json");
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
    debugger
    var url = "${ctx}/survey/queryAllSurveyInfoList.action";
    var param = {};
    param.pID = ${pID};
    $.post(url,param,function(data){
        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
    },"json");


    //初始化新建窗口
    surveyInfo_page.initNewSurveyInfoWin();
    //绑定事件
    $('#addSurveyInfoBtn').click(function() {
        $('#newSurveyInfoWin').window('open');
    });

    surveyInfo_page.initEditSurveyInfoWin();
    $('#editSurveyInfoBtn').click(function() {
        if($("#id_edit").val()==""){
        	if($("#pID_edit").val()==""){
        		return;
        	}
            return;
        }
        $('#editSurveyInfoWin').window('open');
    });


    surveyInfo_page.initDeleteSurveyInfoWin();
    $('#deleteSurveyInfoBtn').click(function() {
        if($("#id_delete").val()==""){
            return;
        }
        $('#deleteSurveyInfoWin').window('open');
    });

    surveyInfo_page.initInfoTipWin();

    $('#backPSurveyInfoBtn').click(function() {
        window.location.href = "${ctx}/survey/surveyPage.action";
    });

});


</script>

<table id="dg" title="内容列表" style="width:auto;height:640px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: surveyInfo_page.onClickRow">
    <thead>
    <tr>
<!--         <th field="theID" width="100">编号</th> -->
        <th field="content" width="100">选项内容</th>
        <th field="count" width="100">点击次数</th>
        <th field="theDate" width="200">创建时间</th>
    </tr>
    </thead>
</table>

<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backPSurveyInfoBtn">返回</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addSurveyInfoBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editSurveyInfoBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteSurveyInfoBtn">删除</a>
</div>


<div id="newSurveyInfoWin" class="easyui-window" title="新建选项内容" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newSurveyInfoForm" method="post">
            <input type="hidden" value="1" id="status_save">
                <table cellpadding=3>
                    <tr>
                        <td>选项内容：</td>
                        <td>
                        <input type="hidden" id="pID_save">
                        <input id="content_save" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <!-- <tr>
                        <td>状态：</td>
                        <td>
                        <select id="status_save">
                        	<option value="1">启用</option>
                        	<option value="0">停用</option>
                        </select>
                        </td>
                    </tr> -->
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="surveyInfo_page.saveNewSurveyInfo()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="surveyInfo_page.closeNewSurveyInfoWin()">取消</a>
        </div>
    </div>
</div>


<div id="editSurveyInfoWin" class="easyui-window" title="编辑选项内容" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editSurveyInfoForm" method="post">
            <input type="hidden" value="1" id="status_save">
                <table cellpadding=3>
                    <tr>
                        <td>选项内容：</td>
                        <td>
                        	<input type="hidden" id="id_edit">
                        	<input type="hidden" id="pID_edit">
                            <input id="content_edit" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr><!-- 
                    <tr>
                        <td>状态：</td>
                        <td>
                        <select id="status_save">
                        	<option value="1" selected="selected">启用</option>
                        	<option value="0">停用</option>
                        </select>
                        </td>
                    </tr> -->
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="surveyInfo_page.saveEditSurveyInfo()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="surveyInfo_page.closeEditSurveyInfoWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteSurveyInfoWin" class="easyui-window" title="删除选项内容" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="id_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="surveyInfo_page.deleteSurveyInfo()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="surveyInfo_page.closeDeleteSurveyInfoWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="surveyInfo_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>

</body>
</html>