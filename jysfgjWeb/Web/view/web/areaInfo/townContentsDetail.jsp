<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%
    String path=request.getContextPath();
    String domain=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath=domain+path;
    pageContext.setAttribute("ctx",path);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>揭阳市发展和改革局</title>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/web/style/style.css" />
</head>
<body style="background:none;">
<div class="article">
<div class="tit">${contents.title }</div>
<div class="data">来源：${contents.source } &nbsp;&nbsp;发布者：${contents.userName}&nbsp;&nbsp;发布时间：${contents.releaseDate }</div>
<div class="cont">${contents.contents }</div>
</div>

</body>
</html>