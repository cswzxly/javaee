<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>惠来国土资源局</title>
</head>
<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">
    	<div class="side">
			<div class="hdlist">
			    <h3>建言献策</h3>
			    <ul>
				    <li><a href="${ctx }/web/front_queryContentsList.action?flag=B0FCF46E529BF3DD"><img src="${ctx}/resources/web/image/ico4.png" align="absmiddle" />正在征集</a></li>
				    <li><a href="${ctx }/web/front_queryContentsList.action?flag=A1EA1DEBCBDD43C7"><img src="${ctx}/resources/web/image/ico4.png" align="absmiddle" />往期征集</a></li>
			    </ul>
			</div>
		</div> 
       
        <div class="main">
        	<pg:pager url="${ctx}/web/front_queryContentsList.action" maxPageItems="15" maxIndexPages="10" export="offset,currentPageNumber=pageNumber" isOffset="false" index="half-full">        
                <div class="list">
                    <h3>
                    	<span>
                    		<c:if test="${flag=='old' }">往期征集</c:if>
                    		<c:if test="${flag=='now' }">正在征集</c:if>
                    		<c:if test="${flag==null }">民意征集</c:if>
                    	</span>
                    </h3>
                    <ul>
                        <c:forEach items="${list }" var="list">
                        <pg:item>
                        <li>
                        <a href="${ctx}/web/front_queryContentsDetail.action?theID=${list.desId}&flag=${list.flag}">${list.title }</a>
                        <em>征集时间：${fn:substring(list.beginDate,0,10)}至${fn:substring(list.endDate,0,10)}</em>
                        </li>
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
</div>
<%@include file="../../web/foot.jsp" %>    
</body>
</html>