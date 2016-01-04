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
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > 专题报道 > <b>${catalog.title}</b></div>
        	<div class="list">
        		
            	<h3><span>${catalog.title}</span></h3>
            	<ul>
	            	<c:forEach items="${contentsList}" var="item">
	            		<li><a href="${ctx}/web/specialTopicShow.action?contentID=${item.theID}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em></li>
	            	</c:forEach>
                </ul>
            </div>
        	                               
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>



