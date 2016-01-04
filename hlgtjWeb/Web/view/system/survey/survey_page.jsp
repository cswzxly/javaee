<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
</head>
<body>
<br/>
<script>

var survey_page = {

    onClickRow:function (index){
        $("#title_edit").val($('#dg').datagrid('getRows')[index]['title']);
        $("#summary_edit").val($('#dg').datagrid('getRows')[index]['summary']);
        $("#beginDate_edit").val($('#dg').datagrid('getRows')[index]['beginDate']);
        $("#endDate_edit").val($('#dg').datagrid('getRows')[index]['endDate']);
        $("#status_edit").val($('#dg').datagrid('getRows')[index]['status']);
        $("#id_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#id_delete").val($('#dg').datagrid('getRows')[index]['theID']);
    },

    //设置新建角色
    initNewSurveyWin:function () {
        $('#newSurveyWin').window({
            title: '新建',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },
    initEditSurveyWin:function () {
        $('#editSurveyWin').window({
            title: '编辑',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },

    initDeleteSurveyWin:function () {
        $('#deleteSurveyWin').window({
            title: '删除',
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

    //关闭新建角色
    closeNewSurveyWin:function () {
        $('#newSurveyWin').window('close');
    },

    closeEditSurveyWin:function () {
        $('#editSurveyWin').window('close');
    },

    closeDeleteSurveyWin:function () {
        $('#deleteSurveyWin').window('close');
    },

    closeInfoTipWin:function () {
        $('#infoTipWin').window('close');
    },

    saveNewSurvey:function (){
        var flag = $("#newSurveyForm").form('validate');
        if(flag){
            var url = "${ctx}/survey/saveNewSurvey.action";
            var title = $("#title_save").val();
            var summary = $("#summary_save").val();
            var beginDate =  $("#beginDate_save").val();
            var endDate = $("#endDate_save").val();
            var param = {};
            param.title = title;
            param.summary = summary;
            param.beginDate = beginDate;
            param.endDate = endDate;
            param.status = $("#status_save").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    survey_page.closeNewSurveyWin();
                    $("#title_save").val("");
                    $("#summary_save").val("");
                    $("#beginDate_save").val("");
                    $("#endDate_save").val("");
                    $("#status_save").val("");
                    var url = "${ctx}/survey/queryAllSurveyList.action";
                    var param = {};
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
    },
    
    saveEditSurvey:function (){
        var flag = $("#editSurveyForm").form('validate');
        if(flag){
            var url = "${ctx}/survey/saveEditSurvey.action";
            var param = {};
            param.theID = $("#id_edit").val();
            param.title = $("#title_edit").val();
            param.summary = $("#summary_edit").val();
            param.beginDate = $("#beginDate_edit").val();
            param.endDate = $("#endDate_edit").val();
            param.status = $("#status_edit").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    survey_page.closeEditSurveyWin();
                    var url = "${ctx}/survey/queryAllSurveyList.action";
                    var param = {};
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
    },

    deleteSurvey:function (){
        var url = "${ctx}/survey/deleteSurvey.action";
        var param = {};
        param.theID = $("#id_delete").val();
        $.post(url,param,function(data){
            if(data=="success"){
                survey_page.closeDeleteSurveyWin();
                var url = "${ctx}/survey/queryAllSurveyList.action";
                var param = {};
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

	var url = "${ctx}/survey/queryAllSurveyList.action";
    var param = {};
    $.post(url,param,function(data){
        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
    },"json");


    //初始化新建窗口
    survey_page.initNewSurveyWin();
    //绑定事件
    $('#addSurveyBtn').click(function() {
        $('#newSurveyWin').window('open');
    });

    survey_page.initEditSurveyWin();
    $('#editSurveyBtn').click(function() {
        if($("#id_edit").val()==""){
            return;
        }
        $('#editSurveyWin').window('open');
    });


    survey_page.initDeleteSurveyWin();
    $('#deleteSurveyBtn').click(function() {
        if($("#id_delete").val()==""){
            return;
        }
        $('#deleteSurveyWin').window('open');
    });

    survey_page.initInfoTipWin();
    
    $('#editInfoBtn').click(function() {
        if($("#id_edit").val()==""){
            return;
        }
        window.location.href = "${ctx}/surveyInfo/surveyInfoPage.action?pID="+$("#id_edit").val();
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
				onClickRow: survey_page.onClickRow">
    <thead>
    <tr>
        <th field="title" width="200">调查主题</th>
        <th field="beginDate" width="150">开始时间</th>
        <th field="endDate" width="150">结束时间</th>
        <th field="status" width="150">状态</th>
    </tr>
    </thead>
</table>

<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addSurveyBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editSurveyBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteSurveyBtn">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editInfoBtn">查看内容</a>
</div>


<div id="newSurveyWin" class="easyui-window" title="新建" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newSurveyForm" method="post">
                <table cellpadding=3>
                    <tr>
                        <td>调查主题：</td>
                        <td><input id="title_save" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>主题摘要：</td>
                        <td><input id="summary_save" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>开始时间：</td>
                        <td>
                        	<input id="beginDate_save" type="text" class="easyui-validatebox" data-options="required:true" readonly/>
                        	<img onclick="WdatePicker({el:'beginDate_save',dateFmt:'yyyy-MM-dd'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <td>结束时间：</td>
                        <td>
                        	<input id="endDate_save" type="text" class="easyui-validatebox" data-options="required:true" readonly/>
                        	<img onclick="WdatePicker({el:'endDate_save',dateFmt:'yyyy-MM-dd'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status_save">
	                    		<option value="1">启用</option>
	                    		<option value="0">停用</option>
                    		</select>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="survey_page.saveNewSurvey()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="survey_page.closeNewSurveyWin()">取消</a>
        </div>
    </div>
</div>

<div id="editSurveyWin" class="easyui-window" title="编辑" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editSurveyForm" method="post">
                <table cellpadding=3>
                    <tr>
                        <td>调查主题：</td>
                        <td><input id="title_edit" type="text" class="easyui-validatebox" data-options="required:true"/>
                            <input id="id_edit" type="hidden"/></td>
                    </tr>
                    <tr>
                        <td>主题摘要：</td>
                        <td><input id="summary_edit" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>开始日期：</td>
                        <td>
                        	<input id="beginDate_edit" type="text" class="easyui-validatebox" data-options="required:true" readonly/>
                        	<img onclick="WdatePicker({el:'beginDate_edit',dateFmt:'yyyy-MM-dd'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <td>结束日期：</td>
                        <td>
                        	<input id="endDate_edit" type="text" class="easyui-validatebox" data-options="required:true" readonly/>
                            <img onclick="WdatePicker({el:'endDate_edit',dateFmt:'yyyy-MM-dd'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status_edit">
			                   	<option value="1" selected="selected">启用</option>
			                   	<option value="0">停用</option>
			                </select>                    	
                    	</td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="survey_page.saveEditSurvey()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="survey_page.closeEditSurveyWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteSurveyWin" class="easyui-window" title="删除" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="id_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="survey_page.deleteSurvey()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="survey_page.closeDeleteSurveyWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="survey_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>

</body>
</html>