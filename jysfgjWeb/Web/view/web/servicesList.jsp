<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>揭阳市发展和改革局</title>

</head>

<body>
<%@include file="../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">
    
    	<div class="side">
    
			<div class="submenu">
			    <a href="http://www.hlwb.gov.cn/wsdt/" target="_blank"><img src="${ctx}/resources/web/image/pic.jpg" width="240" height="80" /></a>
			</div>
			<div class="so">
                <form action="${ctx}/web/searchList.action" method="post">
                <input type="text" name="title" class="text"/>
                <input type="submit" class="submit" />
                </form>        
            </div> 
        </div>
		
        <div class="main">
			<pg:pager url="${ctx}/web/servicesList.action" maxPageItems="10" maxIndexPages="10" export="offset,currentPageNumber=pageNumber" isOffset="false" index="half-full">
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <a href="${ctx}/web/servicesList.action">便民服务</div>
            <div class="list">
                <h3><span>${catalog.title}</span></h3>                	
                <ul>
                
                   <c:forEach items="${servicesList}" var="item">
                       <pg:item>
                           <li><a href="${item.link_url}" target="_blank"><img src="${ctx}/${item.pic_url}" alt="">&nbsp;${item.title }</a></li>
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
<%@include file="../web/foot.jsp" %>
</body>
</html>



