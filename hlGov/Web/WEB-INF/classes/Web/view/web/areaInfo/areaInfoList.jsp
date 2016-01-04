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
    
    	<div class="side">
    
			<%@include file="../../web/leftCatalog.jsp" %>
        </div>
		
        <div class="main">
		      <input type="hidden" id="type" value="${leftTitle }"/>
			    <input type="hidden" id="catalogID" value="${catalog.theID}"/>
               
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > 
        	<c:if test="${leftTitle=='news'}">
        		<a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
    				新闻资讯
    			</a>
    			> <b>${catalog.title}</b>
    		</c:if>
    		<c:if test="${leftTitle=='contents'}">
    			<a href="${ctx}/web/areaInfoPage.action">
    				走进惠来
    			</a>
    			> <b>${catalog.title}</b>
    		</c:if>
    		<c:if test="${leftTitle=='announcement'}">
    			<a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
    				通知公告
				</a>
    		</c:if> </div>
            <div class="list">
                <h3><span>${catalog.title}</span></h3>                	
                <ul>
                <c:if test="${catalog.catalogType=='t_contents' }">
                    <c:forEach items="${contentsList.list}" var="item">
                   
                            <li><a href="${ctx}/web/contentsShow.action?type=${leftTitle }&contentsID=${item.theID}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em></li>
                       
                    </c:forEach>
                </c:if>
                <c:if test="${catalog.catalogType=='t_video' }">
                    <c:forEach items="${videoList}" var="item">
                     
                            <li><a href="${ctx}/web/videoShow.action?type=${leftTitle }&videoID=${item.theID}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em></li>
                     
                    </c:forEach>
                </c:if>
                <c:if test="${catalog.catalogType=='t_files' }">
                    <c:forEach items="${fileInfoList}" var="item">
                      
                            <li><a href="${ctx}/web/download.action?theID=${item.theID}">${item.title}</a><em>${fn:substring(item.releaseDate,0,10) }</em></li>
                  
                    </c:forEach>
                </c:if>
                </ul>
            </div> 
               
           <div id="layPage"></div>
               <script>  
				laypage({
			        cont: 'layPage', //容器id
			        pages: '${contentsList.pages}', //总页数
			        curr: '${contentsList.pageNum}',
			        jump: function (e, first) { //触发分页后的回调
			            if (!first) { //一定要加此判断，否则初始时会无限刷新
			            	window.location.href="${ctx}/web/areaInfoList.action?pageNum=" + e.curr + "&pageSize=${contentsList.pageSize}&type="+'${leftTitle}'+"&catalogID="+'${catalog.theID}';
			            }
			        },
			
			        skin: 'molv', //皮肤
			        first: '首页', //若不显示，设置false即可
			        last: '尾页', //若不显示，设置false即可
			        prev: '<', //若不显示，设置false即可
			        next: '>', //若不显示，设置false即可
			        skip: true //是否开启跳页
			    }); 
			</script>
		   
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>



