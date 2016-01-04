<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
</head>
<body>
<script>
    var role_page = {

        onClickRow: function (index) {
            $("#id_edit").val($('#dg').datagrid('getRows')[index]['id']);
            $("#roleName_edit").val($('#dg').datagrid('getRows')[index]['roleName']);
            $("#description_edit").val($('#dg').datagrid('getRows')[index]['description']);
            $("#id_delete").val($('#dg').datagrid('getRows')[index]['id']);
            $("#roleID").val($('#dg').datagrid('getRows')[index]['id']);
        },

        //设置新建角色
        initNewRoleWin: function () {
            $('#newRoleWin').window({
                title: '新建角色',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 250,
                resizable: false
            });
        },
        initEditRoleWin: function () {
            $('#editRoleWin').window({
                title: '编辑角色',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 250,
                resizable: false
            });
        },

        initDeleteRoleWin: function () {
            $('#deleteRoleWin').window({
                title: '删除角色',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable: false
            });
        },

        initInfoTipWin: function () {
            $('#infoTipWin').window({
                title: '提示信息',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable: false
            });
        },

        //关闭新建角色
        closeNewRoleWin: function () {
            $('#newRoleWin').window('close');
        },

        closeEditRoleWin: function () {
            $('#editRoleWin').window('close');
        },

        closeDeleteRoleWin: function () {
            $('#deleteRoleWin').window('close');
        },

        closeInfoTipWin: function () {
            $('#infoTipWin').window('close');
        },

        saveNewRole: function () {
            var flag = $("#newRoleForm").form('validate');
            if (flag) {
                var url = "${ctx}/role/saveNewRole.action";
                var param = {};
                param.roleName = $("#roleName").val();
                param.description = $("#description").val();
                $.post(url, param, function (data) {
                    if (data == "success") {
                        role_page.closeNewRoleWin();
                        $("#roleName").val("");
                        $("#description").val("");
                        var url = "${ctx}/role/roleList.action";
                        var param = {};
                        $.post(url, param, function (data) {
                            $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
                        }, "json");
                    }
                }, "text");
            }
        },

        saveEditRole: function () {
            var flag = $("#editRoleForm").form('validate');
            if (flag) {
                var url = "${ctx}/role/saveEditRole.action";
                var param = {};
                param.id = $("#id_edit").val();
                param.roleName = $("#roleName_edit").val();
                param.description = $("#description_edit").val();
                $.post(url, param, function (data) {
                    if (data == "success") {
                        role_page.closeEditRoleWin();
                        var url = "${ctx}/role/roleList.action";
                        var param = {};
                        $.post(url, param, function (data) {
                            $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
                        }, "json");
                    }
                }, "text");
            }
        },

        deleteRole: function () {
            var url = "${ctx}/role/deleteRole.action";
            var param = {};
            param.id = $("#id_delete").val();
            $.post(url, param, function (data) {
                if (data == "admin") {
                    alert("警告：禁止删除管理员角色！");
                    role_page.closeDeleteRoleWin();
                } else if (data == "isBind") {
                    alert("存在关联此角色的用户，不允许删除！");
                    role_page.closeDeleteRoleWin();
                } else if (data == "success") {
                    role_page.closeDeleteRoleWin();
                    var url = "${ctx}/role/roleList.action";
                    var param = {};
                    $.post(url, param, function (data) {
                        $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
                    }, "json");
                }
            }, "text");
        }
    }


    //加载数据
    function pagerFilter(data) {
        if (typeof data.length == 'number' && typeof data.splice == 'function') {	// is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage: function (pageNum, pageSize) {
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh', {
                    pageNumber: pageNum,
                    pageSize: pageSize
                });
                dg.datagrid('loadData', data);
            }
        });
        if (!data.originalRows) {
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }

    $(function () {

        var url = "${ctx}/role/roleList.action";
        var param = {};
        $.post(url, param, function (data) {
            $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
        }, "json");


        //初始化新建窗口
        role_page.initNewRoleWin();
        //绑定事件
        $('#addRoleBtn').click(function () {
            $('#newRoleWin').window('open');
        });

        role_page.initEditRoleWin();
        $('#editRoleBtn').click(function () {
            if ($("#id_edit").val() == "") {
                return;
            }
            $('#editRoleWin').window('open');
        });


        role_page.initDeleteRoleWin();
        $('#deleteRoleBtn').click(function () {
            if ($("#id_delete").val() == "") {
                return;
            }
            $('#deleteRoleWin').window('open');
        });

        role_page.initInfoTipWin();

        $('#roleModuleBtn').click(function () {
            if ($("#id_edit").val() == "") {
                return;
            }
            window.location.href = "${ctx}/roleModule/roleModulePage.action?roleId=" + $("#id_edit").val();
        });

        $('#roleCatalogBtn').click(function () {
            var roleID = $("#roleID").val();
            if (roleID == "") {
                return;
            }
            $.ajax({
                async: false,
                cache: false,
                type: 'post',
                dataType: "json",
                data: {'roleID': roleID},
                url: "${ctx}/permit/getFlag.action",
                error: function () {
                    alert("操作失败！");
                },
                success: function (data) {
                    if (data.code == "00") {
                        alert(data.message);
                    } else if (data.code == "01") {
                        alert(data.message);
                    } else if (data.code == "99") {
                        alert(data.message);
                    } else {
                        window.location.href = "${ctx}/permit/catalogEdit.action?roleID=" + roleID;
                    }
                }
            });
        });
    });
</script>

<input type="hidden" id="roleID"/>

<table id="dg" title="角色列表" style="width:700px;height:640px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: role_page.onClickRow">
    <thead>
    <tr>
        <th field="id" width="150">角色编号</th>
        <th field="roleName" width="150">角色名称</th>
        <th field="description" width="150">角色描述</th>
        <th field="createTime" width="200">创建时间</th>
    </tr>
    </thead>
</table>

<div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addRoleBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editRoleBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteRoleBtn">删除</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="roleModuleBtn">权限配置</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="roleCatalogBtn">栏目配置</a>
</div>


<div id="newRoleWin" class="easyui-window" title="新建角色" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post">
                <table cellpadding=3>
                    <tr>
                        <td>角色名称：</td>
                        <td><input id="roleName" type="text" class="easyui-validatebox" data-options="required:true,validType:'checkExist[3,10]'"/></td>
                    </tr>
                    <tr>
                        <td>角色描述：</td>
                        <td><input id="description" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[3,40]'"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="role_page.saveNewRole()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="role_page.closeNewRoleWin()">取消</a>
        </div>
    </div>
</div>


<div id="editRoleWin" class="easyui-window" title="编辑角色" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editRoleForm" method="post">
                <table cellpadding=3>
                    <tr>
                        <td>角色名称：</td>
                        <td><input id="roleName_edit" type="text" class="easyui-validatebox" data-options="required:true,validType:'checkExist[3,10]'"/>
                            <input id="id_edit" type="hidden"/></td>
                    </tr>
                    <tr>
                        <td>角色描述：</td>
                        <td><input id="description_edit" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[3,40]'"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="role_page.saveEditRole()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="role_page.closeEditRoleWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteRoleWin" class="easyui-window" title="删除角色" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="id_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="role_page.deleteRole()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="role_page.closeDeleteRoleWin()">取消</a>
        </div>
    </div>
</div>

<div id="infoTipWin" class="easyui-window" title="提示信息" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label id="info_tip"></label>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="role_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>

</body>
</html>