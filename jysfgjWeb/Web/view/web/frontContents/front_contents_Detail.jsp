<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>揭阳市发展和改革局</title>
</head>
<script type="text/javascript">
	function checkNull(){
		var name=$.trim($("#name").val());
		var email=$.trim($("#email").val());
		var phone=$.trim($("#phone").val());
		var contents=$.trim($("#contents").val());
		var reg=/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
		if(name==''){
			alert("请填写姓名！");
			$("#name").focus();
			return false;
		}
		if(email==''){
			alert("请填写邮箱！");
			$("#email").focus();
			return false;
		}else if(!reg.test(email)){
			alert("请填写正确的邮箱！");
			$("#email").focus();
			return false;
		}
		if(phone==''){
			alert("请填写联系电话！");
			$("#phone").focus();
			return false;
		}
		if(contents==''){
			alert("请填写意见！");
			$("#contents").focus();
			return false;
		}
		
		
		return true;
	}

</script>
<body>
<%@include file="../../web/head.jsp" %>	
<div class="wrapper">
	<div class="inner">
    
    	<div class="content">
        <div class="side">
            <div class="submenu">
			    <h3><span>民意征集</span></h3>
			    <ul>
				    <li><a href="${ctx }/web/front_queryContentsList.action?flag=B0FCF46E529BF3DD">正在征集</a></li>
				    <li><a href="${ctx }/web/front_queryContentsList.action?flag=A1EA1DEBCBDD43C7">往期征集</a></li>
			    </ul>
			</div>
        </div>
        
        <div class="main">	
        <div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b><a href="${ctx }/web/front_queryContentsList.action?flag=${flag}">民意征集</a></b> > <b>征集内容</b></div>
            <div class="article">
<%--                 <div class="tit">${contents.title}</div> --%>
<%--                 <div class="data">${contents.releaseDate }</div> --%>
<%--                 <div class="cont">${contents.contents }</div> --%>
                
                <div class="tit">${opinionPoll.title}</div>
                <div class="data">发布日期：${opinionPoll.releaseDate}</div>
                <div class="cont">${opinionPoll.summary}</div>
                <div class="add">开始日期：${fn:substring(opinionPoll.beginDate,0,10)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结束时间：${fn:substring(opinionPoll.endDate,0,10)}</div>
                <c:choose>
                <c:when test="${opinionPoll.isCollect==1 && flag=='B0FCF46E529BF3DD' }">
                	<form action="${ctx }/web/front_saveOpinionPollInfo.action" method="post" id="save" onsubmit="return checkNull();">
                		<input type="hidden" id="opinionID" name="opinionID" value="${opinionPoll.theID}" />
		                <div class="">
		                	<table class="formtable">
						        <tr class="tbg">
						            <td colspan="4">您的宝贵意见</td>
						        </tr>
						        <tr>	
						        	<td colspan="4" align="center">(注意带有<font color="red">*</font>号必须填写；请填写电子邮箱，以方便我们向您反馈处理信息)</td>
						        </tr>
						        <tr>
						            <th><font color="red">*</font>姓名：</th>
						            <td><input type="text" name="name" id="name"/></td>
						        </tr>
						        <tr>
						            <th><font color="red">*</font>联系电话：</th>
						            <td><input type="text" name="phone" id="phone"/></td>
						        </tr>
						        <tr>
						            <th><font color="red">*</font>邮件：</th>
						            <td>
						               <input type="text" name="email" id="email"/>
						            </td>
						        </tr>
						        <tr>
						            <th><font color="red">*</font>意见：</th>
						            <td colspan="3">
						                <textarea id="contents" rows="10px" cols="50px" name="contents"></textarea>
						            </td>
						        </tr>
						        <tr>
						            <td colspan="4" align="center">
						                <input type="submit"  value="提交">
						            </td>
						        </tr>
					        </table>
		                </div>
                	</form>
                </c:when>
                </c:choose>
                
            
<%--                 <c:choose> --%>
<%--                 <c:when test="${fileInfoList!=null }"> --%>
<!--                 <div class="add"> -->
<%--                 <c:forEach items="${fileInfoList }" var="list"> --%>
<%--                     <a href="${ctx }/web/fileInfoDownLoad.action?downPath=${list.fileUrl }">${list.title }</a><br/> --%>
<%--                 </c:forEach> --%>
<!--                 </div> -->
<%--                 </c:when> --%>
<%--                 </c:choose> --%>
            </div>
        </div>
        </div>
	</div>
</div> 
<%@include file="../../web/foot.jsp" %>	
</body>
</html>