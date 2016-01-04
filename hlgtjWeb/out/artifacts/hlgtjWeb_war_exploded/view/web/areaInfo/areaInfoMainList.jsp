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
                <c:if test="${leftTitle=='zwgk'}">
                    <a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
                        政务公开
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='ywgg'}">
                    <a href="${ctx}/web/areaInfoList.action?type=zwgk&catalogID=183">
                        政务公开
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>

                <c:if test="${leftTitle=='xxgk'}">
                    <a href="${ctx}/web/areaInfoMainList.action?type=xxgk&catalogID=203">
                        信息公开
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='xssydwzf'}">
                    <a href="${ctx}/web/areaInfoMainList.action?type=xxgk&catalogID=203">
                        信息公开
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
            </div>

            <c:forEach items="${thirdCatalogList}" var="catalog">
                <div class="list">
                    <c:if test="${leftTitle=='ywgg'}">
                        <h3><span>${catalog.title}</span><a
                                href="${ctx}/web/areaInfoList.action?type=ywgg&catalogID=${catalog.theID}">更多</a></h3>
                    </c:if>
                    <c:if test="${leftTitle=='xssydwzf'}">
                        <h3><span>${catalog.title}</span><a
                                href="${ctx}/web/areaInfoList.action?type=xssydwzf&catalogID=${catalog.theID}">更多</a>
                        </h3>
                    </c:if>
                    <c:if test="${leftTitle=='xxgk'}">
                        <h3><span>${catalog.title}</span><a
                                href="${ctx}/web/areaInfoList.action?type=xxgk&catalogID=${catalog.theID}">更多</a></h3>

                    </c:if>
                        <%--<h3><span>${catalog.title}</span><a href="${ctx}/web/areaInfoList.action?type=xssydwzf&catalogID=${catalog.theID}">更多</a></h3>--%>
                    <ul>
                        <c:forEach items="${contentsList}" var="contents">
                            <c:if test="${contents.catalogID == catalog.theID }">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?type=${leftTitle }&contentsID=${contents.desId}">${contents.title }</a><em>${fn:substring(contents.releaseDate,0,10) }</em>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>