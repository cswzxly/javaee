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
			<%@include file="front_survey_left.jsp" %>	
        </div>
    	<div class="main">
       
    		<pg:pager url="${ctx}/web/front_querySurveyListDetail.action" maxPageItems="5" maxIndexPages="10" export="offset,currentPageNumber=pageNumber" isOffset="false" index="half-full">
        		<pg:param name="index" value="${index }" />
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b>网上调查</b></div>
            <c:if test="${list1!=null}">
            <div class="list">
                <h3><span>正在调查</span></h3>
                <c:forEach items="${list1 }" var="list">
                <pg:item>
                <table>
                <tr>
                    <th>调查主题：</th>
                    <td colspan="3"><a href="${ctx }/web/front_querySurveyInfo.action?theID=${list.theID}">${list.title }</a></td>
                </tr>
                <tr>                    
                    <th>开始日期：</th>
                    <td><font color="green">${list.beginDate}</font></td>
                    <th>结束日期：</th>
                    <td><font color="green">${list.endDate}</font></td>
                </tr>
                <tr>
                    <th>主题摘要：</th>
                    <td colspan="3">${list.summary }</td>
                </tr>
                </table>
                 </pg:item>
                </c:forEach>
            </div>
            </c:if>
            
            <c:if test="${list0!=null}">
            <div class="list">
                <h3><span>往期调查</span></h3>
                <c:forEach items="${list0 }" var="list">
                <pg:item>	
                <table>
                <tr>
                    <th>调查主题：</th>                   
                    <td colspan="3"><a href="${ctx }/web/front_querySurveyInfo.action?theID=${list.theID}&count=1">${list.title }</a></td>              		
                </tr>
                <tr>
                    <th>开始日期：</th>
                    <td><font color="green">${list.beginDate }</font></td>
                    <th>结束日期：</th>
                    <td><font color="green">${list.endDate }</font></td>
                </tr>
                <tr>
                    <th>主题摘要：</th>
                    <td colspan="3">${list.summary }</td>
                </tr>
                </table>	
                </pg:item>
                </c:forEach>
            </div>    
            </c:if>
         
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