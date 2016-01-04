<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path=request.getContextPath();
    String domain=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath=domain+path;
    pageContext.setAttribute("ctx",path);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/system/js/zTree/css/demo.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/system/js/zTree/css/zTreeStyle/zTreeStyle.css">
    <script type="text/javascript" src="${ctx}/resources/system/plugin/easyui/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/system/js/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/resources/system/js/zTree/js/jquery.ztree.excheck-3.5.js"></script>
</head>
<body>
<script>
 var setting = {
    		data:{
    			simpleData:{
    				enable:true
    			}
    		},
    		callback:{
    			beforeClick:beforeClick,
    			onClick:onClick
    		}
    };
 	var catalogID = parent.document.getElementById("catalogID").value;

    $(document).ready(function(){
    	$(function(){
    		$.ajax({
    			async:false,
    			cache:false,
    			type:'post',
    			dataType:"json",
    			data:{'cid':catalogID},
    			url:"${ctx}/opencontents/showOpenTree.action",
    			error:function(){
    				alert("操作失败");
    			},
    			success:function(data){
    				$.fn.zTree.init($("#treeShow"),setting,data);
    			}
    		});
    	});
    });
    var log,className="dark";
    function beforeClick(treeId,treeNode,clickFlag){
    	className = (className =="dark"?"":"dark");
    	return (treeNode.click !=false);
    }
    function onClick(event,treeId,treeNode,clickFlag){
    	parent.showChilds(treeNode.id,treeNode.name);
    }
</script>
<div class="zTreeDemoBackgroud center">
<ul id="treeShow" class="ztree"></ul>
</div>
</body>
</html>