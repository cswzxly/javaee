<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<div class="submenu">
    <h3>
    	<span>
<c:if test="${leftTitle=='zcfg'}">
   政策发规
</c:if>
			<c:if test="${leftTitle=='zwgk'}">
                政务公开
            </c:if>
            	<c:if test="${leftTitle=='zwdt'}">
                    政务动态
                </c:if>
			<c:if test="${leftTitle=='xxgk'}">
                信息公开
            </c:if>
    		<c:if test="${leftTitle=='ywgg'}">
                业务公告
            </c:if>
    		<c:if test="${leftTitle=='tzgk'}">
                政务公开
            </c:if>
            <c:if test="${leftTitle=='zlxz'}">
                资料下载
            </c:if>
              <c:if test="${leftTitle=='contents'}">
                  政策发规
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

