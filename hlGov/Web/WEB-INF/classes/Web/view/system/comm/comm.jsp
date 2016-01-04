<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path=request.getContextPath();
    String domain=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath=domain+path;
    pageContext.setAttribute("ctx",path);
%>

<link rel="stylesheet" type="text/css" href="${ctx}/resources/system/plugin/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${ctx}/resources/system/plugin/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${ctx}/resources/system/plugin/easyui/demo/demo.css">
<script type="text/javascript" src="${ctx}/resources/system/plugin/easyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/system/plugin/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/system/plugin/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/system/css/default.css">

