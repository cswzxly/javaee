<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
    		</c:if> </div>
        	<div class="article">
            	<div class="tit">${contents.title }</div>
            	<div class="subtit">${contents.secTitle }</div>
            	<div class="data">来源：${contents.source }&nbsp;&nbsp;&nbsp;发布者：${contents.userName}&nbsp;&nbsp;&nbsp;发布时间：${contents.releaseDate}</div>
            	
            	<div class="cont">${contents.contents }</div>
                <c:if test="${fn:length(fileList)>0}">
                	<div class="add">
                	<ul>
                    附件（点击下载）：<br/>
                    <c:forEach items="${fileList}" var="item" varStatus="status">
                        ${status.index+1 }、<a href="${ctx}/web/download.action?theID=${item.theID}">${item.title}</a><br/>
                    </c:forEach>
                	</ul>
                	</div>
                </c:if>
            </div>
           
<%--         	     <%@include file="../../../uploads/word2Html/html/bbb.html" %>                           --%>
        </div>
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>



