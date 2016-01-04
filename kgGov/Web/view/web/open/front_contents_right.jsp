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
<title>揭阳空港经济区</title>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/web/style/style.css" />
</head>
<body style="background:none;">
<pg:pager url="${ctx}/web/frontOpenContentsRight.action" maxPageItems="15" maxIndexPages="10" export="offset,currentPageNumber=pageNumber" isOffset="false" index="half-full">
<pg:param name="theID" value="${catalog.theID }" />
<div class="list">
    <h3><span>${catalog.title}</span></h3>
	<div style="padding:10px 0; text-align:right;">
        <form action="${ctx}/web/searchList.action" method="post">
        <input type="text" name="title" class="text" value="${title }"/>
        <input type="submit" class="submit" value="搜索" />
        </form>         
    </div>
	<table class="csstable">
	<tr class="tbg">
	    <td>题目</td>
	    <td width="20%">文号</td>
	    <td width="20%">发文时间</td>
	</tr>
	<c:forEach items="${list }" var="list">
	<tr>
		<pg:item>
	    <td class="tdl"><a href="${ctx}/web/frontOpenContentsDetail.action?theID=${list.theID}">${list.title }</a></td>
	    <td>${list.conCode }</td>
	    <td>${list.releaseDate }</td>
	    </pg:item>
	</tr>
	</c:forEach>
	</table>
	</div>
	
	<div class="page">
                <pg:index>
                    <pg:first>
                        <a href="${pageUrl}">首页</a>
                    </pg:first>
                    <pg:prev>
                        <a href="${pageUrl }">上一页</a>
                    </pg:prev>
                    <pg:pages>
                        <c:choose>
                            <c:when test="${currentPageNumber eq pageNumber}">
                                <font color="red">[${pageNumber}]</font>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageUrl}">[${pageNumber}]</a>
                            </c:otherwise>
                        </c:choose>
                    </pg:pages>
                    <pg:next>
                        <a href="${pageUrl}">下一页</a>
                    </pg:next>
                    <pg:last>
                        <a href="${pageUrl}">尾页</a>
                    </pg:last>
                </pg:index>
            </div>
			</pg:pager>  
</body>

</html>