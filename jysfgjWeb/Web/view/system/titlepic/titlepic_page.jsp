<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>标题图片管理</title>
</head>
<body>
<br/>
<script>

var titlepic_page = {

    onClickRow:function (index){
        $("#name").val($('#dg').datagrid('getRows')[index]['name']);
        $("#id_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#id_delete").val($('#dg').datagrid('getRows')[index]['theID']);
    },

    //设置新建角色
    initNewTitlepicWin:function () {
        $('#newTitlepicWin').window({
            title: '新建',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },
    initEditTitlepicWin:function () {
        $('#editTitlepicWin').window({
            title: '编辑',
            width: 300,
            modal: true,
            shadow: true,
            closed: true,
            height: 250,
            resizable:false
        });
    },

    initDeleteTitlepicWin:function () {
        $('#deleteTitlepicWin').window({
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
    closeNewTitlepicWin:function () {
        $('#newTitlepicWin').window('close');
    },

    closeEditTitlepicWin:function () {
        $('#editTitlepicWin').window('close');
    },

    closeDeleteTitlepicWin:function () {
        $('#deleteTitlepicWin').window('close');
    },

    closeInfoTipWin:function () {
        $('#infoTipWin').window('close');
    },

    /* saveNewTitlepic:function (){
        var flag = $("#newTitlepicForm").form('validate');
        if(flag){
            var url = "${ctx}/titlepic/saveNewTitlepic.action";
            var param = {};
            param.name = $("#name_save").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    titlepic_page.closeNewTitlepicWin();
                    $("#name_save").val("");
                    $("#url_save").val("");
                    var url = "${ctx}/titlepic/queryAllTitlepicList.action";
                    var param = {};
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
    }, */
    
    /* saveEditTitlepic:function (){
        var flag = $("#editTitlepicForm").form('validate');
        if(flag){
            var url = "${ctx}/titlepic/saveEditTitlepic.action";
            var param = {};
            param.theID = $("#id_edit").val();
            param.title = $("#title_edit").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    titlepic_page.closeEditTitlepicWin();
                    var url = "${ctx}/titlepic/queryAllTitlepicList.action";
                    var param = {};
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
    }, */

    deleteTitlepic:function (){
        var url = "${ctx}/titlepic/deleteTitlepic.action";
        var param = {};
        param.theID = $("#id_delete").val();
        $.post(url,param,function(data){
            if(data=="success"){
                titlepic_page.closeDeleteTitlepicWin();
                var url = "${ctx}/titlepic/queryAllTitlepicList.action";
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

	var url = "${ctx}/titlepic/queryAllTitlepicList.action";
    var param = {};
    $.post(url,param,function(data){
        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
    },"json");


    //初始化新建窗口
    titlepic_page.initNewTitlepicWin();
    //绑定事件
    $('#addTitlepicBtn').click(function() {
        $('#newTitlepicWin').window('open');
    });

    titlepic_page.initEditTitlepicWin();
    $('#editTitlepicBtn').click(function() {
        if($("#id_edit").val()==""){
            return;
        }
        $('#editTitlepicWin').window('open');
    });


    titlepic_page.initDeleteTitlepicWin();
    $('#deleteTitlepicBtn').click(function() {
        if($("#id_delete").val()==""){
            return;
        }
        $('#deleteTitlepicWin').window('open');
    });

    titlepic_page.initInfoTipWin();
    
});


</script>
<table id="dg" title="列表" style="width:700px;height:640px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: titlepic_page.onClickRow">
    <thead>
    <tr>
        <th field="name" width="200">位置</th>
        <th field="url" width="200">图片地址</th>
        <th field="linkUrl" width="200">链接地址</th>
    </tr>
    </thead>
</table>

<div id="tb" style="height:auto">
    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addTitlepicBtn">新建</a> -->
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editTitlepicBtn">编辑</a>
    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteTitlepicBtn">删除</a> -->
</div>


<div id="newTitlepicWin" class="easyui-window" title="新建" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newTitlepicForm" method="post" enctype="multipart/form-data" action="${ctx }/titlepic/saveNewTitlepic.action">
                <table cellpadding=3>
                    <tr>
                        <td>名称：</td>
                        <td><input name="name" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>上传图片：</td>
                        <td><input name="file" id="url_save" type="file" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>链接地址：</td>
                        <td><input name="linkUrl" id="linkUrl" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="saveNewTitlepic()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="titlepic_page.closeNewTitlepicWin()">取消</a>
        </div>
    </div>
</div>

<div id="editTitlepicWin" class="easyui-window" title="编辑" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editTitlepicForm" method="post" enctype="multipart/form-data" action="${ctx }/titlepic/saveEditTitlepic.action">
                <table cellpadding=3>
                    <tr>
                        <td>名称：</td>
                        <td><input id="name" type="text" class="easyui-validatebox" data-options="required:true" readonly="readonly"/>
                            <input id="id_edit" type="hidden" name="theID"/></td>
                    </tr>
                    <tr>
                        <td>上传图片：</td>
                        <td><input name="file" id="url_save" type="file" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>链接地址：</td>
                        <td><input name="linkUrl" id="linkUrl" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="saveEditTitlepic()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="titlepic_page.closeEditTitlepicWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteTitlepicWin" class="easyui-window" title="删除" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="id_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="titlepic_page.deleteTitlepic()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="titlepic_page.closeDeleteTitlepicWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="titlepic_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>
<script type="text/javascript">
	function saveNewTitlepic(){
		document.getElementById("newTitlepicForm").submit();
	}
	function saveEditTitlepic(){
		document.getElementById("editTitlepicForm").submit();
	}
</script>
</body>
</html>