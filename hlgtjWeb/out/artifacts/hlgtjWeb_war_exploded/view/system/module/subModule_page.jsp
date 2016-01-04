<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>子模块管理</title>

</head>
<body>
<script>



var subModule_page = {

    onClickRow:function (index){
        $("#id_edit").val($('#dg').datagrid('getRows')[index]['id']);
        $("#moduleName_edit").val($('#dg').datagrid('getRows')[index]['moduleName']);
        $("#moduleCode_edit").val($('#dg').datagrid('getRows')[index]['moduleCode']);
        $("#moduleUrl_edit").val($('#dg').datagrid('getRows')[index]['moduleUrl']);

        $("#id_delete").val($('#dg').datagrid('getRows')[index]['id']);
    },

    //设置新建子模块
    initNewModuleWin:function () {
        $('#newModuleWin').window({
            title: '新建子模块',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },
    initEditModuleWin:function () {
        $('#editModuleWin').window({
            title: '编辑子模块',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },

    initDeleteModuleWin:function () {
        $('#deleteModuleWin').window({
            title: '删除子模块',
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
    closeNewModuleWin:function () {
        $('#newModuleWin').window('close');
    },

    closeEditModuleWin:function () {
        $('#editModuleWin').window('close');
    },

    closeDeleteModuleWin:function () {
        $('#deleteModuleWin').window('close');
    },

    closeInfoTipWin:function () {
        $('#infoTipWin').window('close');
    },

    saveNewModule:function (){
        var flag = $("#newModuleForm").form('validate');
        if(flag){
            var url = "${ctx}/module/saveNewModule.action";
            var param = {};
            param.pid = ${pid};
            param.moduleName = $("#moduleName").val();
            param.moduleCode = $("#moduleCode").val();
            param.moduleUrl = $("#moduleUrl").val();
            param.moduleLevel = "2";
            $.post(url,param,function(data){
                if(data=="success"){
                    subModule_page.closeNewModuleWin();
                    $("#moduleName").val("");
                    $("#moduleCode").val("");
                    $("#moduleUrl").val("");
                    var url = "${ctx}/module/moduleList.action";
                    var param = {};
                    param.pid = ${pid};
                    param.moduleLevel = "2";
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }

    },

    saveEditModule:function (){
        var flag = $("#editModuleForm").form('validate');
        if(flag){
            var url = "${ctx}/module/saveEditModule.action";
            var param = {};
            param.id = $("#id_edit").val();
            param.moduleName = $("#moduleName_edit").val();
            param.moduleCode = $("#moduleCode_edit").val();
            param.moduleUrl = $("#moduleUrl_edit").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    subModule_page.closeEditModuleWin();
                    var url = "${ctx}/module/moduleList.action";
                    var param = {};
                    param.pid = ${pid};
                    param.moduleLevel = "2";
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
    },

    deleteModule:function (){
        var url = "${ctx}/module/deleteModule.action";
        var param = {};
        param.id = $("#id_delete").val();
        $.post(url,param,function(data){
            if(data=="success"){
                subModule_page.closeDeleteModuleWin();
                var url = "${ctx}/module/moduleList.action";
                var param = {};
                param.pid = ${pid};
                param.moduleLevel = "2";
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
    var url = "${ctx}/module/moduleList.action";
    var param = {};
    param.pid = ${pid};
    param.moduleLevel = "2";
    $.post(url,param,function(data){
        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
    },"json");


    //初始化新建窗口
    subModule_page.initNewModuleWin();
    //绑定事件
    $('#addModuleBtn').click(function() {
        $('#newModuleWin').window('open');
    });

    subModule_page.initEditModuleWin();
    $('#editModuleBtn').click(function() {
        if($("#id_edit").val()==""){
            return;
        }
        $('#editModuleWin').window('open');
    });


    subModule_page.initDeleteModuleWin();
    $('#deleteModuleBtn').click(function() {
        if($("#id_delete").val()==""){
            return;
        }
        $('#deleteModuleWin').window('open');
    });

    subModule_page.initInfoTipWin();

    $('#backPModuleBtn').click(function() {
        window.location.href = "${ctx}/module/modulePage.action";
    });

});


</script>

<table id="dg" title="子模块列表" style="width:700px;height:640px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: subModule_page.onClickRow">
    <thead>
    <tr>
        <th field="id" width="100">子模块编号</th>
        <th field="moduleName" width="100">子模块名称</th>
        <th field="moduleCode" width="100">子模块编码</th>
        <th field="moduleUrl" width="200">连接地址</th>
        <th field="createTime" width="150">创建时间</th>
    </tr>
    </thead>
</table>

<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backPModuleBtn">返回</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addModuleBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editModuleBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteModuleBtn">删除</a>
</div>


<div id="newModuleWin" class="easyui-window" title="新建子模块" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newModuleForm" method="post">
                <table cellpadding=3>
                    <tr>
                        <td>子模块名称：</td>
                        <td><input id="moduleName" type="text" class="easyui-validatebox" data-options="required:true,validType:'checkExist[1,10]'"/></td>
                    </tr>
                    <tr>
                        <td>子模块编码：</td>
                        <td><input id="moduleCode" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[1,10]'"/></td>
                    </tr>
                    <tr>
                        <td>连接地址：</td>
                        <td><input id="moduleUrl" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[1,100]'"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="subModule_page.saveNewModule()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="subModule_page.closeNewModuleWin()">取消</a>
        </div>
    </div>
</div>


<div id="editModuleWin" class="easyui-window" title="编辑子模块" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editModuleForm" method="post">
                <table cellpadding=3>
                    <tr>
                        <td>子模块名称：</td>
                        <td><input type="hidden" id="id_edit">
                            <input id="moduleName_edit" type="text" class="easyui-validatebox" data-options="required:true,validType:'checkExist[1,10]'"/></td>
                    </tr>
                    <tr>
                        <td>子模块编码：</td>
                        <td><input id="moduleCode_edit" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[1,10]'"/></td>
                    </tr>
                    <tr>
                        <td>连接地址：</td>
                        <td><input id="moduleUrl_edit" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[1,100]'"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="subModule_page.saveEditModule()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="subModule_page.closeEditModuleWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteModuleWin" class="easyui-window" title="删除子模块" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="id_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="subModule_page.deleteModule()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="subModule_page.closeDeleteModuleWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="subModule_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>

</body>
</html>