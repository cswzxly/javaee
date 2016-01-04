<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>惠来县人民政府门户网站</title>

</head>

<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">
    	<!--div class="side">
   
        	<div class="zt">
                <ul>
                	<c:forEach items="${leftCatalogList }" var="item">
                		<li>
	                		<a href="${ctx}/web/specialTopicList.action?catalogID=${item.theID}">
	                			<img src="${ctx}/uploads/zt/pic/${item.theID}.jpg" />
	                		</a>
                		</li>
                	</c:forEach>
                </ul>
            </div>

        </div>
        <div class="main"-->
        <div class="banner"><img src="${ctx}/uploads/zt/pic/${catalog.theID}_banner.jpg" style="height:80px;" /></div>
        	<pg:pager url="${ctx}/web/specialTopicList.action" maxPageItems="20" maxIndexPages="10" export="offset,currentPageNumber=pageNumber" isOffset="false" index="half-full">
<%--         	<pg:param name="type" value="${leftTitle }" /> --%>
        	<pg:param name="catalogID" value="${catalog.theID}" />
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > 专题报道 > <b>${catalog.title}</b></div>
        	<div class="list">
        		
            	<h3><span>${catalog.title}</span></h3>
            	<ul>
	            	<c:forEach items="${contentsList}" var="item">
	            		<pg:item>
	            			<li><a href="${ctx}/web/specialTopicShow.action?contentID=${item.theID}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em></li>
	            		</pg:item>
	            	</c:forEach>
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
<%@include file="../../web/foot.jsp" %>
</body>
</html>



