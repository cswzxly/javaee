<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>揭阳市发展和改革局</title>

</head>

<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
    <div class="inner">


		<div class="content">
        <div class="side">
            <%@include file="../../web/leftCatalog.jsp" %>
        </div>

        <div class="main">
            <div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> >
                <c:if test="${leftTitle=='news'}">
                    <a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
                        新闻资讯
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='contents'}">
                    <a href="${ctx}/web/areaInfoPage.action">
                        走进空港
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='announcement'}">
                    <a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
                        通知公告
                    </a>
                </c:if>
            </div>
            <c:forEach items="${thirdCatalogList}" var="catalog">
                <div class="list">
                    <h3><span>${catalog.title}</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=${catalog.theID}">更多</a></h3>
                    <ul>
                        <c:forEach items="${contentsList}" var="contents">
                            <c:if test="${contents.catalogID == catalog.theID }">
                                 <li><a href="${ctx}/web/contentsShow.action?type=${leftTitle }&contentsID=${contents.theID}">${contents.title }</a><em>${fn:substring(contents.releaseDate,0,10) }</em></li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>