<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>惠来县人民政府门户网站</title>
</head>
<body class="letter">
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">

		<div class="side">	
		<%@include file="front_letter_page.jsp" %>
		</div>
        
        <div class="main">
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b><c:if test="${flag eq '1'}">县长信箱</c:if><c:if test="${flag eq '2'}">我要写信</c:if><c:if test="${flag eq '3'}">我要建议</c:if>答复选登</b></div>            

			<div class="so">
            <form action="front_queryLetterByNum.action?index=1" method="post">
            请输入受理编号：<input type="text" name="acceptNum" class="text"> <input type="submit" value="查询" class="submit">
            </form>
            </div>
            <table class="csstable">
            <tr class="tbg">
                <td>主题</td>
                <td width="10%">联名人数</td>
                <td width="10%">回复状态</td>
            </tr>
            <c:forEach items="${list }" var="list">
            <tr>
                <td>
                <c:if test="${index==null }">
                <a href="${ctx }/web/front_queryLetterDetail.action?theID=${list.theID}">
                </c:if>
                <c:if test="${index!=null }">
                <a href="${ctx }/web/front_queryLetterDetail.action?theID=${list.theID}&index=1">
                </c:if>
                ${list.theme }</a></td>
                <td>${list.joinNum }</td>
                <td>
                    <c:if test="${list.status eq '1'}">
                        <font color="green">已回复</font>
                    </c:if>
                    <c:if test="${list.status eq '0'}">
                        <font color="red">未回复</font>
                    </c:if>
                </td>
            </tr>
            </c:forEach>
            </table>
        </div>
	</div>
</div>    
<%@include file="../../web/foot.jsp" %>    	
</body>
</html>