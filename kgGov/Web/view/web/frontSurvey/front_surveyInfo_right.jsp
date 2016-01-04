<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>揭阳空港经济区</title>
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
                    <input type="hidden" name="pId" value="${pId }" />
                    <c:forEach items="${list }" var="list">
                        <c:choose>
                        <c:when test="${count!=null||Ccount!=null }">
                        	${list.content }
                        	&nbsp;&nbsp;<font color="red"><b> ${list.count } </b></font>票<br/>
                        </c:when>
                        <c:otherwise>
                        	<input type="radio" name="theID" value="${list.theID }">${list.content }     <br/>                  
                        </c:otherwise>
                        
                        </c:choose>
                    </c:forEach>	
                    <br/>
                    <c:if test="${!(count!=null||Ccount!=null) }">      
                   	<input type="submit" value="投票" class="submit">
                   </c:if>
                    </form>
                </div>
            </div>

    	</div>
	</div>
</div> 
<script type="text/javascript" >
function check(th){
    if(getRadioSelectValue(th.theID) == null ){
        alert('请选择');
        return false;
    }
}
function getRadioSelectValue(radObj){
    var raLenth = radObj.length;
    for(var i=0;i<raLenth;i++){   
         if(radObj[i].checked){
             return radObj[i].value;
         }
    }
    return null;
}
</script>
<%@include file="../../web/foot.jsp" %>		
</body>

</html>