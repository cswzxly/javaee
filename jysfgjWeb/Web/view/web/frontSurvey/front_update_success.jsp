<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>揭阳市发展和改革局</title>
</head>
<body onLoad="dosubmit()">

	
	
</body>
<script type="text/javascript">
	function dosubmit(){
		alert("投票成功");
// 		window.location.href="${ctx}/web/front_querySurveyListDetail.action?index=1";
		window.location.href="${ctx}/web/front_querySurveyResult.action?id=${pId}";
	}
</script> 
</html>