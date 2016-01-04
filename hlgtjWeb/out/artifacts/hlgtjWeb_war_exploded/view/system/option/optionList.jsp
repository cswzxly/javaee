<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">

    <title>栏目管理</title>
    <script type="text/javascript" src="${ctx}/resources/system/js/ajaxfileupload.js"></script>
</head>
<body>
<script>
    function onClickRow(index){
        $("#theID_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#item_edit").val($('#dg').datagrid('getRows')[index]['item']);
        $("#content_edit").val($('#dg').datagrid('getRows')[index]['content']);
        $("#code_edit").val($('#dg').datagrid('getRows')[index]['code']);
        $("#mark_edit").val($('#dg').datagrid('getRows')[index]['mark']);
        $("#theID_delete").val($('#dg').datagrid('getRows')[index]['theID']);
    }


    var option_page = {
        //设置新建用户
        initNewOptionWin:function () {
            $('#newOptionWin').window({
                title: '新建基础设置',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable:false
            });
        },
        initEditOptionWin:function () {
            $('#editOptionWin').window({
                title: '编辑基础设置',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable:false
            });
        },

        initDeleteOptionWin:function () {
            $('#deleteOptionWin').window({
                title: '删除基础设置',
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

        //关闭新建用户
        closeNewOptionWin:function () {
            $('#newOptionWin').window('close');
        },

        closeEditOptionWin:function () {
            $('#editOptionWin').window('close');
        },

        closeDeleteOptionWin:function () {
            $('#deleteOptionWin').window('close');
        },

        closeInfoTipWin:function () {
            $('#infoTipWin').window('close');
        },

        saveNewOption:function (){
            var flag = true;
            var item = $("#item").val();
            var content = $("#content").val();
            var code = $("#code").val();
            var mark = $("#mark").val();
            if(item==""){
            	flag=false;
            	alert("基础设置编码不能为空");
            	return false;
            }
            if(flag){
                var url = "${ctx}/option/saveNewOption.action";
                var param = {};
                param.item = item;
                param.content = content;
                param.code = code;
                param.mark = mark;
                $.post(url,param,function(data){
                    if(data=="success"){
                        option_page.closeNewOptionWin();
                        $("#item").val("");
                        $("#code").val("");
                        $("#content").val("");
                        $("#mark").val("");
                        var url = "${ctx}/option/optionList.action";
                        var param = {};
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                    }
                },"text");
            }
        },
        saveEditOption:function (){
        	 var flag = true;
        	 var item = $("#item_edit").val();
             var content = $("#content_edit").val();
             var code = $("#code_edit").val();
             var mark = $("#mark_edit").val();
             if(item==""){
             	flag=false;
             	alert("基础设置编码不能为空");
             	return false;
             }         
             if(flag){
                var url = "${ctx}/option/saveEditOption.action";
                var param = {};
                param.theID = $("#theID_edit").val();
                param.item = item;
                param.content = content;
                param.code = code;
                param.mark = mark;
                $.post(url,param,function(data){
                    if(data=="success"){
                        option_page.closeEditOptionWin();
                        var url = "${ctx}/option/optionList.action";
                        var param = {};
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                    }
                },"text");
        	}
        },
        
        deleteOption:function (){
        	 if($("#theID_delete").val()==""){
                 return;
             }
            var url = "${ctx}/option/deleteOption.action";
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    option_page.closeDeleteOptionWin();
                    var url = "${ctx}/option/optionList.action";
                    var param = {};
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

        var url = "${ctx}/option/optionList.action";
        var param = {};
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
        },"json");


        //初始化新建窗口
        option_page.initNewOptionWin();
        //绑定事件
        $('#addOptionBtn').click(function() {
            $('#newOptionWin').window('open');
        });

        option_page.initEditOptionWin();
        $('#editOptionBtn').click(function() {
            if($("#theID_edit").val()==""){
                return;
            }
            $('#editOptionWin').window('open');
        });


        option_page.initDeleteOptionWin();
        $('#deleteOptionBtn').click(function() {
            if($("#theID_delete").val()==""){
                return;
            }
            $('#deleteOptionWin').window('open');
        });

        option_page.initInfoTipWin();
    });
    
    
</script>
<table width="100%">
<tr>
<td valign="top" width="90%">
<table id="dg" title="基础设置列表" style="width:auto;height:600px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: onClickRow">
    <thead>
    <tr>
    	<th field="item" width="100"><input type="hidden" field="theID">基础设置编码</th>
        <th field="content" width="125">基础设置名称</th>
        <th field="code" width="100">基础设置值</th>
        <th field="createTime" width="140">创建时间</th>
        <th field="mark" width="420">描述</th>
    </tr>
    </thead>
    
    <div id="tb" style="height:auto">
<!--     <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addOptionBtn">新建</a> -->
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editOptionBtn">编辑</a>
<!--     <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteOptionBtn">删除</a> -->
    </div>
</td>
</tr>
</table>




<div id="newOptionWin" class="easyui-window" title="新建基础设置" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newCatalogForm" method="post">
                <table cellpadding=3>
                	<input id="parentID" type="hidden" value="0"/>
                    <tr>
                        <td>基础设置编码：</td>
                        <td><input id="item" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>基础设置名称：</td>
                        <td>
                        	<input id="content" type="text" class="easyui-validatebox" data-options="required:true"/>
                        </td>
                    </tr>
                    <tr>
                        <td>基础设置值：</td>
                        <td>
                        	<input id="code" type="text" class="easyui-validatebox" data-options="required:true"/>
                        </td>
                    </tr>
                    <tr>
                        <td>描述：</td>
                        <td><input id="mark" type="text" size="50" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="option_page.saveNewOption()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="option_page.closeNewOptionWin()">取消</a>
        </div>
    </div>
</div>


<div id="editOptionWin" class="easyui-window" title="编辑基础设置" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editOptionForm" method="post">
                <table cellpadding=3>                
                    <tr>
                        <td>基础设置编码：</td>
                        <td>
                        	<input id="item_edit" type="text" class="easyui-validatebox" data-options="required:true"/>
                        	<input id="theID_edit" type="hidden"/>
                        </td>
                    </tr>
                    <tr>
                        <td>基础设置名称：</td>
                        <td>
                        	<input id="content_edit" type="text" class="easyui-validatebox" data-options="required:true"/>
                        </td>
                    </tr>
                    <tr>
                        <td>基础设置值：</td>
                        <td><input id="code_edit" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>描述：</td>
                        <td><input id="mark_edit" type="text" size="50" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="option_page.saveEditOption()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="option_page.closeEditOptionWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteOptionWin" class="easyui-window" title="删除基础设置" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="theID_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="option_page.deleteOption()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="option_page.closeDeleteOptionWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="option_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>