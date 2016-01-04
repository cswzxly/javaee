<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>角色权限配置</title>
</head>
<body>
<script>

var roleModule_page = {

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

    loadMainLeft:function(){
        var url = "${ctx}/module/moduleList.action";
        var param = {};
        param.moduleLevel = "1";
        $.post(url,param,function(data){
            $("#mainModuleLeft").empty();
            for(var i=0;i<data.rows.length;i++){
                $("#mainModuleLeft").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].moduleName+"</option>");
            }
        },"json");
    },
    loadMainRight:function(){
        var url = "${ctx}/roleModule/roleModuleList.action";
        var param = {};
        param.roleId = $("#roleId").val();
        param.moduleLevel = "1";
        $.post(url,param,function(data){
            $("#mainModuleRight").empty();
            for(var i=0;i<data.rows.length;i++){
                $("#mainModuleRight").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].moduleName+"</option>");
            }
            roleModule_page.loadSubLeft();
            roleModule_page.loadSubRight();
        },"json");
    },
    addMainModule:function(){
        var arr1 = new Array();
        var mainModuleLeftLength = $("#mainModuleLeft option:selected").length;
        if(mainModuleLeftLength>0){
            for(var i=0;i<mainModuleLeftLength;i++){
                arr1.push($("#mainModuleLeft option:selected")[i].value)
            }
        }
        var arr2 = new Array();
        var mainModuleRightLength = $("#mainModuleRight option").length;
        if(mainModuleRightLength>0){
            for(var i=0;i<mainModuleRightLength;i++){
                arr2.push($("#mainModuleRight option")[i].value)
            }
        }
        var moduleIdStr = roleModule_page.quCha(arr1,arr2).toString();

        if(moduleIdStr!=""){
            var url = "${ctx}/roleModule/addRoleModule.action";
            var param = {};
            param.roleId = $("#roleId").val();
            param.moduleIdStr = roleModule_page.quCha(arr1,arr2).toString();
            $.post(url,param,function(data){
                if(data=="success"){
                    roleModule_page.loadMainRight();
                }
            },'text');
        }

    },


    removeMainModule:function(){
        var arr2 = new Array();
        var mainModuleRightLength = $("#mainModuleRight option:selected").length;
        if(mainModuleRightLength>0){
            for(var i=0;i<mainModuleRightLength;i++){
                arr2.push($("#mainModuleRight option:selected")[i].value)
            }
        }
        var moduleIdStr = arr2.toString();
        if(moduleIdStr!=""){
            var url = "${ctx}/roleModule/removeRoleModule.action";
            var param = {};
            param.roleId = $("#roleId").val();
            param.moduleIdStr = arr2.toString();
            $.post(url,param,function(data){
                if(data=="success"){
                    roleModule_page.loadMainRight();
                }
            },'text');
        }
    },

    loadSubLeft:function(){
        $("#subModuleLeft").empty();
        if($("#mainModuleRight option:selected").length>0){
            var url = "${ctx}/module/moduleList.action";
            var param = {};
            param.pid = $("#mainModuleRight option:selected")[0].value;
            param.moduleLevel = "2";
            $.post(url,param,function(data){
                for(var i=0;i<data.rows.length;i++){
                    $("#subModuleLeft").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].moduleName+"</option>");
                }
                roleModule_page.loadSubRight();
            },"json");
        }
    },

    loadSubRight:function(){
        $("#subModuleRight").empty();
        if($("#mainModuleRight option:selected").length>0){
            var url = "${ctx}/roleModule/roleModuleList.action";
            var param = {};
            param.roleId = $("#roleId").val();
            param.pid = $("#mainModuleRight option:selected")[0].value;
            param.moduleLevel = "2";
            $.post(url,param,function(data){
                for(var i=0;i<data.rows.length;i++){
                    $("#subModuleRight").append("<option value='"+data.rows[i].id+"'>"+data.rows[i].moduleName+"</option>");
                }
            },"json");
        }
    },


    addSubModule:function(){
        var arr1 = new Array();
        var subModuleLeftLength = $("#subModuleLeft option:selected").length;
        if(subModuleLeftLength>0){
            for(var i=0;i<subModuleLeftLength;i++){
                arr1.push($("#subModuleLeft option:selected")[i].value)
            }
        }
        var arr2 = new Array();
        var subModuleRightLength = $("#subModuleRight option").length;
        if(subModuleRightLength>0){
            for(var i=0;i<subModuleRightLength;i++){
                arr2.push($("#subModuleRight option")[i].value)
            }
        }
        var moduleIdStr = roleModule_page.quCha(arr1,arr2).toString();

        if(moduleIdStr!=""){
            var url = "${ctx}/roleModule/addRoleModule.action";
            var param = {};
            param.roleId = $("#roleId").val();
            param.moduleIdStr = roleModule_page.quCha(arr1,arr2).toString();
            $.post(url,param,function(data){
                if(data=="success"){
                    roleModule_page.loadSubRight();
                }
            },'text');
        }

    },


    removeSubModule:function(){
        var arr2 = new Array();
        var subModuleRightLength = $("#subModuleRight option:selected").length;
        if(subModuleRightLength>0){
            for(var i=0;i<subModuleRightLength;i++){
                arr2.push($("#subModuleRight option:selected")[i].value)
            }
        }
        var moduleIdStr = arr2.toString();
        if(moduleIdStr!=""){
            var url = "${ctx}/roleModule/removeRoleModule.action";
            var param = {};
            param.roleId = $("#roleId").val();
            param.moduleIdStr = arr2.toString();
            $.post(url,param,function(data){
                if(data=="success"){
                    roleModule_page.loadSubRight();
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

    roleModule_page.loadMainLeft();
    roleModule_page.loadMainRight();

    roleModule_page.initInfoTipWin();

    $('#backRoleBtn').click(function() {
        window.location.href = "${ctx}/role/rolePage.action";
    });
});
</script>


<div class="easyui-panel" title="角色权限配置" style="width:700px;height:640px" data-options="toolbar: '#tb'">
    <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backRoleBtn">返回</a>
    </div>
    <div style="padding:10px 10px 10px 10px">
            <table cellpadding="4" >
                <tr>
                    <td>主权限</td>
                    <td>
                        <input type="hidden" id="roleId" value="${roleId}">
                        <select multiple size="15" style="width: 150" id="mainModuleLeft">

                        </select>
                    </td>
                    <td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="roleModule_page.addMainModule();">添加</a><br><br>
                        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="roleModule_page.removeMainModule();">删除</a></td>
                    <td>
                        <select multiple size="15" style="width: 150" id="mainModuleRight" onchange="roleModule_page.loadSubLeft();">

                        </select>
                    </td>
                </tr>

                <tr>
                    <td>子权限</td>
                    <td>
                        <select multiple size="15" style="width: 150" id="subModuleLeft">
                        </select>
                    </td>
                    <td><a href="javascript:void(0)" class="easyui-linkbutton" onclick="roleModule_page.addSubModule();">添加</a><br><br>
                        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="roleModule_page.removeSubModule();">删除</a></td>
                    <td>
                        <select multiple size="15" style="width: 150" id="subModuleRight">
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="roleModule_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>