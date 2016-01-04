<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>揭阳市发展和改革局</title>
</head>
<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">

			

        
        <table class="boxlist hdlist">
        <tr>
        <td style="padding-right:3px;">
            <div class="border">
                <h3><span>局长信箱</span><a href="${ctx }/web/front_letterRight.action?flag=1">我要写信</a></h3>
                <ul>
                    <c:forEach items="${jzxxList }" var="list">
                    <li>
                    <a href="${ctx}/web/front_queryLetterDetail.action?theID=${list.theID}&index=1">${list.theme }</a>
<%--                <em>${list.create_date }</em> --%>
                    </li>
                    </c:forEach>
                </ul>
            </div>  
        </td>
        <td style="padding-left:3px;">
            <div class="border">
                <h3><span>业务咨询</span><a href="${ctx }/web/front_letterRight.action?flag=2">我要咨询</a></h3>
                <ul>
                    <c:forEach items="${ywzxList }" var="list">
                    <li>
                    	<a href="${ctx}/web/front_queryLetterDetail.action?theID=${list.theID}&index=1">${list.theme }</a>
<%--                    <em>${list.create_date }</em> --%>
                    </li>
                    </c:forEach>
                </ul>
            </div>  
        </td>            
        </tr>   
        <tr>
        <td style="padding-right:3px;">
            <div class="border">
                <h3><span>监督投诉</span><a href="${ctx }/web/front_letterRight.action?flag=3">我要投诉</a></h3>
                <ul>
                    <c:forEach items="${jdtsList }" var="list">
                    <li>
                    <a href="${ctx}/web/front_queryLetterDetail.action?theID=${list.desId}&index=1">${list.theme }</a>
                    <em>${fn:substring(list.createDate,0 ,10 ) }</em>
                    </li>
                    </c:forEach>
                </ul>
            </div>            
        </td>
        <td style="padding-left:3px;">
            <div class="border">
                <h3><span>建言献策</span><a href="${ctx}/web/front_queryContentsList.action">我要建言</a></h3>
                <ul>
                    <c:forEach items="${opList }" var="list">
                    <li>
                    <a href="${ctx}/web/front_queryContentsDetail.action?theID=${list.desId}&flag=${list.flag}">${list.title }</a>
                    <em>${fn:substring(list.createDate,0 ,10 ) }</em>
                    </li>
                    </c:forEach>
                </ul>
            </div>       
        </td>
        </tr>                            
		</table>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>    
</body>
</html>