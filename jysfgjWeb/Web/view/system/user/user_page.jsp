<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
</head>
<body>
<script>
    $.extend($.fn.validatebox.defaults.rules, {
        checkExist: {
            // param 参数集合
            validator: function (value, param) {
                if (value.length < param[0]) {
                    $.fn.validatebox.defaults.rules.checkExist.message = '输入内容长度必须介于' + param[0] + '和' + param[1] +'之间';
                    return false;
                } else {
                    if (!/^[\w]+$/.test(value)) {
                        $.fn.validatebox.defaults.rules.checkExist.message = '登录账号只能英文字母、数字及下划线的组合';
                        return false;
                    } else {
                        var postdata = {};
                        var url = "${ctx}/user/checkExist.action";
                        var postdata = {};
                        postdata.userName = $("#userName").val();
                        var result = $.ajax({
                            url: url,
                            data: postdata,
                            type: 'post',
                            dataType: 'json',
                            async: false,
                            cache: false
                        }).responseText;
                        if (result == 'exist') {
                            $.fn.validatebox.defaults.rules.checkExist.message = '登录账号已存在';
                            return false;
                        } else {
                            return true;
                        }
                    }
                }
            },
            message: ''
        }
    });


    var user_page = {

        onClickRow:function (index){
            $("#id_edit").val($('#dg').datagrid('getRows')[index]['id']);
            $("#userName_edit").val($('#dg').datagrid('getRows')[index]['userName']);
            $("#password_edit").val($('#dg').datagrid('getRows')[index]['password']);
            $("#realName_edit").val($('#dg').datagrid('getRows')[index]['realName']);

            $("#id_delete").val($('#dg').datagrid('getRows')[index]['id']);
        },

        //设置新建用户
        initNewUserWin:function () {
            $('#newUserWin').window({
                title: '新建用户',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 250,
                resizable:false
            });
        },
        initEditUserWin:function () {
            $('#editUserWin').window({
                title: '编辑用户',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 250,
                resizable:false
            });
        },

        initDeleteUserWin:function () {
            $('#deleteUserWin').window({
                title: '删除用户',
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
        closeNewUserWin:function () {
            $('#newUserWin').window('close');
        },

        closeEditUserWin:function () {
            $('#editUserWin').window('close');
        },

        closeDeleteUserWin:function () {
            $('#deleteUserWin').window('close');
        },

        closeInfoTipWin:function () {
            $('#infoTipWin').window('close');
        },

        saveNewUser:function (){
            var flag = $("#newUserForm").form('validate');
            if(flag){
                var url = "${ctx}/user/saveNewUser.action";
                var param = {};
                param.userName = $("#userName").val();
                param.password = $("#password").val();
                param.realName = $("#realName").val();
                $.post(url,param,function(data){
                    if(data=="success"){
                        user_page.closeNewUserWin();
                        $("#userName").val("");
                        $("#password").val("");
                        $("#realName").val("");
                        var url = "${ctx}/user/userList.action";
                        var param = {};
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                    }
                },"text");
            }
        },
        saveEditUser:function (){
            var flag = $("#editUserForm").form('validate');
            if(flag){
                var url = "${ctx}/user/saveEditUser.action";
                var param = {};
                param.id = $("#id_edit").val();
                param.userName = $("#userName_edit").val();
                param.password = $("#password_edit").val();
                param.realName = $("#realName_edit").val();
                $.post(url,param,function(data){
                    if(data=="success"){
                        user_page.closeEditUserWin();
                        var url = "${ctx}/user/userList.action";
                        var param = {};
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                    }
                },"text");
            }
        },

        deleteUser:function (){
            var url = "${ctx}/user/deleteUser.action";
            var param = {};
            param.id = $("#id_delete").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    user_page.closeDeleteUserWin();
                    var url = "${ctx}/user/userList.action";
                    var param = {};
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }else if(data=="self"){
                    user_page.closeDeleteUserWin();
                    $("#info_tip").html("不能删除自己");
                    $('#infoTipWin').window('open');
                }else if(data=="admin"){
                    user_page.closeDeleteUserWin();
                    $("#info_tip").html("不能删除系统管理员");
                    $('#infoTipWin').window('open');
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

        var url = "${ctx}/user/userList.action";
        var param = {};
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
        },"json");


        //初始化新建窗口
        user_page.initNewUserWin();
        //绑定事件
        $('#addUserBtn').click(function() {
            $('#newUserWin').window('open');
        });

        user_page.initEditUserWin();
        $('#editUserBtn').click(function() {
            if($("#id_edit").val()==""){
                return;
            }
            $('#editUserWin').window('open');
        });


        user_page.initDeleteUserWin();
        $('#deleteUserBtn').click(function() {
            if($("#id_delete").val()==""){
                return;
            }
            $('#deleteUserWin').window('open');
        });

        $('#userRoleBtn').click(function() {
            if($("#id_edit").val()==""){
                return;
            }
            window.location.href = "${ctx}/userRole/userRolePage.action?userId="+$("#id_edit").val();
        });

        user_page.initInfoTipWin();
    });
</script>

<table id="dg" title="用户列表" style="width:700px;height:640px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: user_page.onClickRow">
    <thead>
    <tr>
       
        <th field="userName" width="150">登录账号<input type="hidden" field="password"><input field="id" type="hidden"></th>
        <th field="realName" width="150">用户名称</th>
        <th field="createTime" width="200">创建时间</th>
    </tr>
    </thead>
</table>

<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addUserBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editUserBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteUserBtn">删除</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="userRoleBtn">角色配置</a>
</div>


<div id="newUserWin" class="easyui-window" title="新建用户" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newUserForm" method="post">
                <table cellpadding=3>

                    <tr>
                        <td>登录账号：</td>
                        <td><input id="userName" type="text" class="easyui-validatebox" data-options="required:true,validType:'checkExist[3,10]'"/></td>
                    </tr>
                    <tr>
                        <td>登录密码：</td>
                        <td><input id="password" type="password" class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'"/></td>
                    </tr>
                    <tr>
                        <td>用户名称：</td>
                        <td><input id="realName" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="user_page.saveNewUser()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="user_page.closeNewUserWin()">取消</a>
        </div>
    </div>
</div>


<div id="editUserWin" class="easyui-window" title="编辑用户" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editUserForm" method="post">
                <table cellpadding=3>
                    <tr>
                        <td>登录账号：</td>
                        <td><input id="userName_edit" type="text" disabled="disabled"/>
                            <input id="id_edit" type="hidden"/></td>
                    </tr>
                    <tr>
                        <td>登录密码：</td>
                        <td><input id="password_edit" type="password" class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'"/></td>
                    </tr>
                    <tr>
                        <td>用户名称：</td>
                        <td><input id="realName_edit" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[3,10]'"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="user_page.saveEditUser()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="user_page.closeEditUserWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteUserWin" class="easyui-window" title="删除用户" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="id_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="user_page.deleteUser()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="user_page.closeDeleteUserWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="user_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>