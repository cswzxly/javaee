<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>惠来县人民政府门户网站</title>
</head>
<body>
<%@include file="../../web/head.jsp" %>	
<div class="wrapper">
	<div class="inner">		
        <div class="side">
			<%@include file="../frontSurvey/front_survey_left.jsp" %>	
        </div>
    	<div class="main">
        
            <div class="article">
                <div class="tit">${survey.title }</div>
                <div class="data">${survey.theDate }</div>
                <div class="cont">
                    <p><strong>${survey.title}</strong></p>
                    <c:forEach items="${list }" var="list">
                        ${list.content }
                        &nbsp;&nbsp;<font color="red"><b> ${list.count } </b></font>票<br/>
                    </c:forEach>	
                    <br/>
                </div>
            </div>

    	</div>
	</div>
</div> 
<%@include file="../../web/foot.jsp" %>		
</body>

</html>