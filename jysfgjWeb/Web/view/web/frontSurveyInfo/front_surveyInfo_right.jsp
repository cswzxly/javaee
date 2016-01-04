<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>揭阳市发展和改革局</title>
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
                <div class="tit">${title }</div>
                <div class="data">${theDate }</div>
                <div class="cont">
                    <p><strong>${title}</strong></p>
                    <form action="${ctx }/web/front_updateSurveyInfo.action" method="post" onsubmit="return check(this);" name="fff">
                    <c:forEach items="${list }" var="list">
                        <input type="radio" name="theID" value="${list.theID }">${list.content }
                        <br/>
                    </c:forEach>	
                   <input type="submit" name="submit" value="投票"/>
                    </form>
                </div>
            </div>

    	</div>
	</div>
</div> 

<%@include file="../../web/foot.jsp" %>		
</body>
</html>