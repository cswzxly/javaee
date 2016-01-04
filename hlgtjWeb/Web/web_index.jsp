<%-- <%@ page language="java" contentType="text/html; charset=utf-8" --%>
<%--     pageEncoding="utf-8"%> --%>
<!-- <script type="text/javascript"> -->
<!--  	window.location.href="${ctx}/web/index.action"; -->
<!-- </script> -->
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String path=request.getContextPath();
    String domain=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath=domain+path;
    String host=request.getScheme()+"://"+request.getServerName();
    pageContext.setAttribute("ctx",path);
    pageContext.setAttribute("host", host);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>惠来国土资源局</title>
</head>
<body>

</body>
<script type="text/javascript">

// 	if("http://www.puning.gov.cn"=='${host}' || "http://puning.gov.cn"=='${host}'){
// 		window.parent.location.href="http://www.puning.gov.cn/web/index.action";
// 	}else if("http://cww.puning.gov.cn"=='${host}'){
// 		window.parent.location.href="http://cww.puning.gov.cn/cww";
// 	}
	window.location.href="${ctx}/web/index.action";
</script>
</html>