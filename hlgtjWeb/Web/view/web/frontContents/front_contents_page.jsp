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
			<%@include file="../frontLetter/front_letter_page.jsp" %>
		</div> 

        <div class="main" style="border:0;">
                              
            <div class="border">
                <h3><span>局长信箱</span></h3>
                <ul>
                    <c:forEach items="${jzxxList }" var="list">
                    <li>
                    <a href="${ctx}/web/front_queryLetterDetail.action?theID=${list.theID}&index=1">${list.theme }</a>
<%--                     <em>${list.create_date }</em> --%>
                    </li>
                    </c:forEach>
                </ul>
            </div>                      


            <div class="border">
                <h3><span>业务咨询</span></h3>
                <ul>
                    <c:forEach items="${ywzxList }" var="list">
                    <li>
                    	<a href="${ctx}/web/front_queryLetterDetail.action?theID=${list.theID}&index=1">${list.theme }</a>
<%--                     <em>${list.create_date }</em> --%>
                    </li>
                    </c:forEach>
                </ul>
            </div>                    

         
<!--             <div class="border"> -->
<!--                 <h3><span>网上调查</span></h3> -->
<!--                 <ul> -->
<%--                     <c:forEach items="${surveyList }" var="list"> --%>
<!--                     <li> -->
<%--                     <a href="${ctx}/web/front_querySurveyInfo.action?theID=${list.desId}&index=1">${list.title }</a> --%>
<%--                         <em>${fn:substring(list.theDate,0 ,10 ) }</em> --%>
<!--                     </li> -->
<%--                     </c:forEach> --%>
<!--                 </ul> -->
<!--             </div> -->

            <div class="border">
                <h3><span>监督投诉</span></h3>
                <ul>
                    <c:forEach items="${jdtsList }" var="list">
                    <li>
                    <a href="${ctx}/web/front_queryLetterDetail.action?theID=${list.desId}&index=1">${list.theme }</a>
                     <em>${fn:substring(list.createDate,0 ,10 ) }</em>
                    </li>
                    </c:forEach>
                </ul>
            </div>
            
            <div class="border">
                <h3><span>建言献策</span></h3>
                <ul>
                    <c:forEach items="${opList }" var="list">
                    <li>
                    <a href="${ctx}/web/front_queryContentsDetail.action?theID=${list.desId}&flag=${list.flag}">${list.title }</a>
                        <em>${fn:substring(list.createDate,0 ,10 ) }</em>
                    </li>
                    </c:forEach>
                </ul>
            </div>  
		</div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>    
</body>
</html>