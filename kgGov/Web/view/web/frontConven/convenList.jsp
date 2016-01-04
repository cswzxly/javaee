<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>揭阳空港经济区</title>

</head>

<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
    <div class="inner">

        <div class="side">

            <%@include file="../../web/leftCatalog.jsp" %>
        </div>

        <div class="main">
            <pg:pager url="${ctx}/web/areaInfoList.action" maxPageItems="15" maxIndexPages="10" export="offset,currentPageNumber=pageNumber" isOffset="false" index="half-full">
                <pg:param name="type" value="${leftTitle }"/>
                <pg:param name="catalogID" value="${catalog.theID}"/>
                <div class="position">
                    <span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b>${catalog.title}</b>
                </div>
                <div class="list">
                    <h3><span>${catalog.title}</span></h3>
                    <ul>
                        <c:if test="${catalog.catalogType=='t_contents' }">
                            <c:forEach items="${contentsList}" var="item">
                                <pg:item>
                                    <li><a href="${ctx}/web/contentsShows.action?type=${leftTitle }&contentsID=${item.theID}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em></li>
                                </pg:item>
                            </c:forEach>
                        </c:if>
                        <c:if test="${catalog.catalogType=='t_video' }">
                            <c:forEach items="${videoList}" var="item">
                                <pg:item>
                                    <li><a href="${ctx}/web/videoShow.action?type=${leftTitle }&videoID=${item.theID}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em></li>
                                </pg:item>
                            </c:forEach>
                        </c:if>
                    </ul>
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
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>



