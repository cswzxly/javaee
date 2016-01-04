<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>惠来国土资源局</title>

</head>

<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
    <div class="inner">

        <div class="side">

            <%@include file="../../web/leftCatalog.jsp" %>
        </div>

        <div class="main">
            <div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> >
                <c:if test="${leftTitle=='zlxz'}">
                    <b>${catalog.title}</b>
                </c:if>
            </div>

            <c:forEach items="${thirdCatalogList}" var="catalog">
                <div class="list">
                    <c:if test="${leftTitle=='zlxz'}">
                        <h3><span>${catalog.title}</span><a
                                href="${ctx}/web/areaInfoList.action?type=zlxz&catalogID=${catalog.theID}">更多</a></h3>

                    </c:if>
                    <table class="csstable">
                        <tr>
                            <th>文件名称</th>
                            <th>文件类型</th>
                            <th>上传日期</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${fileInfoList}" var="item">
                            <c:if test="${item.catalogID == catalog.theID }">
                                <tr>
                                    <td class="tdl">${item.title}</td>
                                    <td>${item.fileUrl}</td>
                                    <td>${fn:substring(item.create_date,0,10) }</td>
                                    <td><a href="${ctx}/web/download.action?theID=${item.theID}">下载文件</a></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>