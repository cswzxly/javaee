<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>惠来县人民政府门户网站</title>
</head>
<body onLoad="dosubmit()">
<input type="hidden" value="${error }" id="error">
	
	
</body>
<script type="text/javascript">
	function dosubmit(){
		var error = $('#error').val();
		if(error!=null&&!"".equals(error)){
			alert("投票失败，请选择内容");
		}else{
			alert("投票成功");
			window.location.href="<%=request.getContextPath()%>/view/web/frontSurvey/front_survey_page.jsp";
		}
		
	}
</script> 
</html>