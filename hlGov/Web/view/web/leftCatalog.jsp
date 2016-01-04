<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<div class="submenu">
    <h3>
    	<span>
			<c:if test="${leftTitle=='news'}">
    			新闻资讯
    		</c:if>
    		<c:if test="${leftTitle=='contents'}">
    			${contentTitle}
    		</c:if>
    		<c:if test="${leftTitle=='announcement'}">
    			通知公告
    		</c:if>
    	</span>
    </h3>
    <ul>
        <c:forEach items="${leftCatalogList }" var="item">
<%--             <li><a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${item.theID}">${item.title}</a></li> --%>
            <li><a href="${ctx}${item.url}">${item.title}</a></li>
        </c:forEach>
    </ul>
</div>

