<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>惠来县人民政府门户网站</title>
</head>
<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">
    	<div class="side">
			<div class="hd">
			    <h3>政民互动</h3>
			    <ul>
				    <li><a href="${ctx }/web/front_queryContentsList.action?flag=now"><img src="${ctx}/resources/web/image/ico4.png" align="absmiddle" />民意征集</a></li>
					<li><a href="${ctx}/web/front_letterRight.action?flag=1"><img src="${ctx}/resources/web/image/ico1.png" align="absmiddle" />县长信箱</a></li>
					<li><a href="${ctx}/web/tsjyPage.action"><img src="${ctx}/resources/web/image/ico2.png" align="absmiddle" />举报电话</a></li>
					<li><a href="${ctx}/web/front_letterRight.action?flag=2"><img src="${ctx}/resources/web/image/ico3.png" align="absmiddle" />我要写信</a></li>
					<li><a href="${ctx}/web/front_letterRight.action?flag=3"><img src="${ctx}/resources/web/image/ico4.png" align="absmiddle" />我要建议</a></li>
					<li><a href="${ctx}/web/front_querySurveyListDetail.action?index=1"><img src="${ctx}/resources/web/image/ico4.png" align="absmiddle" />网上调查</a></li>
			    </ul>
			</div>
		</div> 
       	<div class="main">
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > 
        		<a href="${ctx}/web/tsjyPage.action">
    				举报电话
    			</a>
    		</div>
        	<div class="article">
            	<div class="tit">${contentsDetail.title }</div>
            	<div class="subtit">${contentsDetail.secTitle }</div>
            	<div class="data">
            		
            		来源：${contentsDetail.source }&nbsp;&nbsp;&nbsp;作者：${contentsDetail.author }&nbsp;&nbsp;&nbsp;发布者：${contentsDetail.userName}&nbsp;&nbsp;&nbsp;发布时间：${contentsDetail.releaseDate}
            	</div>
            	
            	<div class="cont">${contentsDetail.contents }</div>
<%--             	<div style="text-align:right; color:#999;">浏览次数：${contentsDetail.viewedNum }</div> --%>
<%--                 <c:if test="${fn:length(fileList)>0}"> --%>
<!--                 	<div class="add"> -->
<!--                 	<ul> -->
<!--                     附件（点击下载）：<br/> -->
<%--                     <c:forEach items="${fileList}" var="item" varStatus="status"> --%>
<%--                         ${status.index+1 }、<a href="${ctx}/web/download.action?theID=${item.theID}">${item.title}</a><br/> --%>
<%--                     </c:forEach> --%>
<!--                 	</ul> -->
<!--                 	</div> -->
<%--                 </c:if> --%>
            </div>
        	                               
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>    
</body>
</html>