<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>揭阳市发展和改革局</title>
</head>
<body onLoad="docheck()">
</body>
<script type="text/javascript">
	function docheck(){
		var is =confirm("提交成功！请记住您的受理编号："+${acceptNum});
		 if(is){
			 window.location.href="${ctx}/web/front_letterRight.action?flag=${flag}";
		 }
	}
</script>
</html>