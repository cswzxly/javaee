<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>用户角色配置</title>
</head>
<body>
<script>

var userRole_page = {

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

    closeInfoTipWin:function () {
        $('#infoTipWin').window('close');
    },

    loadRoleLeft:function(){
        var url = "${ctx}/role/roleList.action";
        var param = {};
        $.post(url,param,function(data){
            $("#userRoleLeft").empty();
            for(var i=0;i<data.rows.length;i++){
                $("#userRoleLeft").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].roleName+"</option>");
            }
        },"json");
    },

    loadRoleRight:function(){
        var url = "${ctx}/userRole/userRoleList.action";
        var param = {};
        param.userId = $("#userId").val();
        $.post(url,param,function(data){
            $("#userRoleRight").empty();
            for(var i=0;i<data.rows.length;i++){
                $("#userRoleRight").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].roleName+"</option>");
            }
        },"json");
    },

    addMainModule:function(){
        var arr1 = new Array();
        var userRoleLeftLength = $("#userRoleLeft option:selected").length;
        if(userRoleLeftLength>0){
            for(var i=0;i<userRoleLeftLength;i++){
                arr1.push($("#userRoleLeft option:selected")[i].value)
            }
        }
        var arr2 = new Array();
        var userRoleRightLength = $("#userRoleRight option").length;
        if(userRoleRightLength>0){
            for(var i=0;i<userRoleRightLength;i++){
                arr2.push($("#userRoleRight option")[i].value)
            }
        }
        var roleIdStr = userRole_page.quCha(arr1,arr2).toString();
        if(roleIdStr!=""){
            var url = "${ctx}/userRole/addUserRole.action";
            var param = {};
            param.userId = $("#userId").val();
            param.roleIdStr = userRole_page.quCha(arr1,arr2).toString();
            $.post(url,param,function(data){
                if(data=="success"){
                    userRole_page.loadRoleRight();
                }
            },'text');
        }

    },


    removeUserRole:function(){
        var arr2 = new Array();
        var userRoleRightLength = $("#userRoleRight option:selected").length;
        if(userRoleRightLength>0){
            for(var i=0;i<userRoleRightLength;i++){
                arr2.push($("#userRoleRight option:selected")[i].value)
            }
        }
        var roleIdStr = arr2.toString();
        if(roleIdStr!=""){
            var url = "${ctx}/userRole/removeUserRole.action";
            var param = {};
            param.userId = $("#userId").val();
            param.roleIdStr = arr2.toString();
            $.post(url,param,function(data){
                if(data=="success"){
                    userRole_page.loadRoleRight();
                }
            },'text');
        }
    },


    //数组取差集合
    quCha:function(arr1,arr2){
        var arr3 = new Array();
        for(var i=0; i < arr1.length; i++){
            var flag = true;
            for(var j=0; j < arr2.length; j++){
                if(arr1[i] == arr2[j]){
                    flag = false;
                }
            }
            if(flag){
                arr3.push(arr1[i]);
            }
        }
        return arr3;
    }
}


$(function(){

    userRole_page.loadRoleLeft();
    userRole_page.loadRoleRight();

    userRole_page.initInfoTipWin();

    $('#backUserBtn').click(function() {
        window.location.href = "${ctx}/user/userPage.action";
    });
});
</script>


<div class="easyui-panel" title="角色权限配置" style="width:700px;height:640px" data-options="toolbar: '#tb'">
    <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backUserBtn">返回</a>
    </div>
    <div style="padding:10px 10px 10px 10px">
            <table cellpadding="3" >
                <tr>
                    <td>
                        <input type="hidden" id="userId" value="${userId}">
                        <select multiple size="20" style="width: 150" id="userRoleLeft">

                        </select>
                    </td>
                    <td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="userRole_page.addMainModule();">添加</a><br><br>
                        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="userRole_page.removeUserRole();">删除</a></td>
                    <td>
                        <select multiple size="20" style="width: 150" id="userRoleRight" onchange="">

                        </select>
                    </td>
                </tr>
            </table>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="userRole_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>