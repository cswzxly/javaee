<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>惠来县人民政府门户网站</title>
</head>
<body class="chief">
<%@include file="../../web/head.jsp" %>


<div class="wrapper">
	<div class="inner">
        <div class="side">
            <div class="submenu"> 
                <h3><span>镇场信息</span></h3>         
            	<iframe frameborder="0" src="${ctx }/web/townCatalogLeft.action" name="leftFrame" scrolling="auto" width="100%" height="500px"></iframe>
            </div>	
        </div>
        <c:if test="${flag==null }">
	 	<div class="main">
			<iframe frameborder="0" src="${ctx }/web/townContentsList.action?theID=${theID}" name="rightFrame" id="rightFrame"  width="100%" height="510px"></iframe>
		</div>    
    	</c:if>
		<c:if test="${flag!=null }">
	 	<div class="main">
			<iframe frameborder="0" src="${ctx }/web/townContentsDetail.action?theID=${theID}" name="rightFrame" id="rightFrame"  width="100%" height="510px"></iframe>
		</div>    
    	</c:if>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>		 
</body>    
</html>