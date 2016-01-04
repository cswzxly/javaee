<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path=request.getContextPath();
    String domain=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath=domain+path;
    pageContext.setAttribute("ctx",path);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head id="Head1">
    <title>后台管理</title>
    <link href="${ctx}/resources/system/css/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/system/js/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/system/js/themes/icon.css" />
    <script type="text/javascript" src="${ctx}/resources/system/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/system/js/jquery.easyui.js"></script>
    <script type="text/javascript" src='${ctx}/resources/system/js/outlook.js'> </script>
    

    <script type="text/javascript">

        var _menus = ${result};
        var user_page = {
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
	        
	        closeEditUserWin:function () {
	            $('#editUserWin').window('close');
	        },
	        
	        saveEditUser:function (){
	           var url = "${ctx}/user/saveEditUser.action";
	           var param = {};
	           param.id = $("#id_edit").val();
	           param.userName = $("#userName_edit").val();
	           param.password = $("#password_edit").val();
	           param.realName = $("#realName_edit").val();
	           $.post(url,param,function(data){
	           		if(data=="success"){
	                    user_page.closeEditUserWin();
	                    alert("修改成功！");
	                }
	           },"text");
	        }
	        
        }


        $(function() {
            $('#loginOut').click(function() {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
                    if (r) {
                        location.href = '${ctx}/login/loginOut.action';
                    }
                });
            });
            user_page.initEditUserWin();
            $('#editpass').click(function(){
            	$('#id_edit').val('${sessionScope.userInSession.id}');
            	$('#userName_edit').val('${sessionScope.userInSession.userName}');
            	$('#realName_edit').val('${sessionScope.userInSession.realName}');
            	$('#editUserWin').window('open');
            });
        });



    </script>
	<style>
	body{ border-left:5px solid #2983CF !important; border-right:5px solid #2983CF !important; font-size:14px;} 
	a{ text-decoration:none !important; outline:0 !important;}
	.layout-panel-south .panel-body{ border:0 !important;}
    </style>
</head>
<body class="easyui-layout" scroll="no">


<noscript>
<div style="position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
    <img src="${ctx}/resources/system/images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div>
</noscript>



<div region="north" split="true" border="false" style="background:url(${ctx}/resources/system/images/topbg.jpg) bottom repeat-x; height:70px; ">
<div style="background:url(${ctx}/resources/system/images/picbg.jpg) right bottom no-repeat; overflow:hidden; zoom:1; clear:both;">
    <span style="float:left;"><img src="${ctx}/resources/system/images/logo.jpg" /></span>
    <span style="float:left; padding-left:50px; padding-top:30px; font-size:14px; color:#fff;" class="head">
<img src="${ctx}/resources/system/images/man.jpg" align="absmiddle" />&nbsp;&nbsp;
欢迎您，${userInSession.realName} &nbsp;&nbsp;&nbsp;&nbsp;
<a href="#" id="editpass"><img src="${ctx}/resources/system/images/pwd.jpg" align="absmiddle" /> 修改密码</a> &nbsp;&nbsp;&nbsp;&nbsp;
<a href="${ctx }" id="index" target="_blank"><img src="${ctx}/resources/system/images/pwd.jpg" align="absmiddle" /> 网站首页</a> &nbsp;&nbsp;&nbsp;&nbsp;
<a href="#" id="loginOut"><img src="${ctx}/resources/system/images/exit.jpg" align="absmiddle" /> 安全退出</a>
    </span>
</div>    
</div>


<div region="south" split="true" style="height:30px; background:#2983CF;">
    <div class="footer">技术支持：广东信航信息技术有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系电话：0663-8763222</div>
</div>


<div region="west" split="true" title="导航菜单" style="width:180px;" id="west">
    <div class="easyui-accordion" fit="true" border="false">
        <!--  导航内容 -->
    </div>
</div>


<div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
    <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
        <div title="欢迎使用" style="padding:20px;overflow:hidden;" id="home">
            <h1>欢迎登陆惠来县国土局网站后台管理系统！</h1>
        </div>
    </div>
</div>

<div id="mm" class="easyui-menu" style="width:150px;">
    <div id="mm-tabclose">关闭</div>
    <div id="mm-tabcloseall">全部关闭</div>
    <div id="mm-tabcloseother">除此之外全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-tabcloseright">当前页右侧全部关闭</div>
    <div id="mm-tabcloseleft">当前页左侧全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-exit">退出</div>
</div>

<div id="editUserWin" class="easyui-window" title="修改密碼" collapsible="false" minimizable="false"
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
</body>
</html>
