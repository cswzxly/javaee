<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>惠来国土资源局</title>
</head>
<body class="letter">
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">
		
        <div class="side">	
		<%@include file="front_letter_page.jsp" %>
        </div>
        
        <div class="main">
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b><c:if test="${flag eq '1'}">领导信箱</c:if><c:if test="${flag eq '2'}">建言献策</c:if><c:if test="${flag eq '3'}">投诉举报</c:if></b></div>        
       
       	<div style=" padding:10px; color:#666;">
       	<p><strong>使用须知</strong></p>
<p>1.本栏目仅受理向我委领导提出的意见、建议，非本委职能、非意见建议类信息不予受理。如您要咨询业务，请前往“业务咨询”栏目；如要投诉举报，请前往"监督投诉"栏目。</p>
<p>2.表单内带*项为必填项。请如实填写您的个人信息，以便我们与您联系。您的电话和电子邮件仅供联系使用，不对外公开。</p>
<p>3.请注意用语文明、准确，内容真实、有针对性，杜绝谩骂和人身攻击。若来信内容虚假或不文明，将不予答复。</p>
<p>4.请勿重复提交同一来信。若来信内容与其他已公开的来信相同或类似，我们将不再作答。</p>
<p>5.我们将选择有代表性的来信内容在本栏目公开，若您认为来信内容不适宜公开，请在“能否公开”栏中选择“否”。</p>
<p>6.每个受理的来信将生成查询号，您可凭该号查询答复内容。</p>
<p>7.所有答复信息仅供参考，不作为法律依据。</p>
<p>8.本栏目拥有发布、编辑、删除网上留言的权利。</p>
<p>9.如在本栏目留言，即表明您已阅读并接受上述各项条款。</p>
<p id="ppp">请仔细阅读使用须知（<span id="dd">20</span>秒）</p>
<p align="right"><a href="${ctx }/web/front_replayLetter.action?flag=${flag}" style="font-size:24px;font-weight:bold;color:#f00;">答复选登</a></p>        
        </div>
        <form action="${ctx }/web/front_saveLetter.action" method="post" enctype="multipart/form-data" id="save">
        <input type="hidden" name="flag" value="${flag }"/>
<!--         <input type="hidden" name="isOpen" value="0"/> -->
		<input type="hidden" name="visitePath" value="网上信访" />
        <input type="hidden" name="status" value="0"/>
        <table class="formtable">
        <tr class="tbg">
            <td colspan="4">建议人资料登记(注意带有*号必须填写；请填写电子邮箱，以方便我们向您反馈处理信息)</td>
        </tr>
<%--         <c:choose> --%>
<%--         <c:when test="${flag eq '3' }"> --%>
       
<%--         </c:when> --%>
<%--         <c:otherwise> --%>
<!--         <tr> -->
<!--             <th><font color="red">*</font>来访路径：</th> -->
<!--             <td colspan="3"><input type="text" name="visitePath" value="网上信访" readonly="readonly"/></td> -->
<!--         </tr> -->
<%--         </c:otherwise> --%>
<%--         </c:choose> --%>
        <tr>
            <th><font color="red">*</font>姓名：</th>
            <td><input type="text" name="name" id="name" disabled="disabled"/></td>
           
        </tr>
        <tr>
        	<th>是否公开：</th>
            <td>
                <input type="radio" id="isOpen1" name="isOpen" value="1" checked="checked" disabled="disabled">是 &nbsp;&nbsp;
                <input type="radio" id="isOpen0" name="isOpen" value="0" disabled="disabled">否
            </td>
        </tr>
<!--         <tr> -->
<!--             <th>年龄：</th> -->
<!--             <td><input type="text" name="age" id="age"/></td> -->
<!--             <th>政治面貌：</th> -->
<!--             <td> -->
<!--                 <select name="politicalType"> -->
<!--                     <option value="1">群众</option> -->
<!--                     <option value="2">团员</option> -->
<!--                     <option value="3">党员</option> -->
<!--                     <option value="4">其它</option> -->
<!--                 </select> -->
<!--             </td> -->
<!--         </tr> -->
<!--         <tr> -->
<!--             <th>证件类型：</th> -->
<!--             <td> -->
<!--                 <select name="certType"> -->
<!--                     <option value="1">身份证</option> -->
<!--                     <option value="2">学生证</option> -->
<!--                     <option value="3">驾驶证</option> -->
<!--                 </select> -->
<!--             </td> -->
<!--             <th>证件号码：</th> -->
<!--             <td><input type="text" name="certNum" id="certNum"/></td> -->
<!--         </tr> -->
<!--         <tr> -->
<!--             <th>职业：</th> -->
<!--             <td> -->
<!--                 <select name="occupType"> -->
<!--                     <option value="1">公务员</option> -->
<!--                     <option value="2">学生</option> -->
<!--                     <option value="3">教师</option> -->
<!--                     <option value="4">农民</option> -->
<!--                     <option value="5">工人</option> -->
<!--                     <option value="6">个体经营</option> -->
<!--                 </select> -->
<!--             </td> -->
<!--             <th>工作单位：</th> -->
<!--             <td><input type="text" name="workplace" id="workplace"/></td> -->
<!--         </tr> -->
        <tr>
            <th>联系电话：</th>
            <td><input type="text" name="phone" id="phone" disabled="disabled"/></td>
<!--             <th>手机号码：</th> -->
<!--             <td><input type="text" name="moblePhone" id="moblePhone"/></td> -->
        </tr>
        <tr>
            <th>联系邮箱：</th>
            <td><input type="text" name="email" id="email" disabled="disabled"/></td>
<!--             <th>邮编：</th> -->
<!--             <td><input type="text" name="postcode" id="postcode"/></td> -->
        </tr>
<!--         <tr> -->
<!--             <th><font color="red">*</font>联系地址：</th> -->
<!--             <td colspan="3"><input type="text" name="address" id="address"/></td> -->
<!--         </tr> -->
<!--         <tr class="tbg"> -->
<!--             <td colspan="4">建议信息登记(注意带有*号必须填写；信访事项信息)</td> -->
<!--         </tr> -->
        <tr>
            <th><font color="red">*</font>主题：</th>
            <td colspan="3"><input type="text" name="theme" id="theme" disabled="disabled"></td>
        </tr>
<!--         <tr> -->
<!--             <th>问题类别：</th> -->
<!--             <td> -->
<!--                 <select name="questionType"> -->
<!--                 <option value="1">未选择</option> -->
<!--                 <option value="2">城乡建设</option> -->
<!--                 <option value="3">国土资源水利林业</option> -->
<!--                 <option value="4">劳动社保</option> -->
<!--                 <option value="5">农村农业</option> -->
<!--                 <option value="6">政法</option> -->
<!--                 <option value="7">纪检监察</option> -->
<!--                 <option value="8">组织人事</option> -->
<!--                 <option value="9">民政</option> -->
<!--                 <option value="10">教育</option> -->
<!--                 <option value="11">卫生计生</option> -->
<!--                 <option value="12">经济综合</option> -->
<!--                 <option value="13">政治综合</option> -->
<!--                 <option value="14">交通能源环保</option> -->
<!--                 <option value="15">商贸旅游</option> -->
<!--                 <option value="16">宣传舆论</option> -->
<!--                 <option value="17">信息产业</option> -->
<!--                 <option value="18">科技文体</option> -->
<!--                 <option value="19">其它</option> -->
<!--                 </select> -->
<!--             </td> -->
<!--             <th>联名人数：</th> -->
<!--             <td><input type="text" name="joinNum" id="joinNum"></td> -->
<!--         </tr> -->
<!--         <tr> -->
<!--             <th>涉及单位：</th> -->
<!--             <td colspan="3"> -->
<!--                 <select name="referDept"> -->
<!--                 <option value="0">请选择</option> -->
<!--                 <option value="1">区发改局</option> -->
<!--                 <option value="2">空港公安分局</option> -->
<!--                 <option value="3">区农业局(水利、民政)</option> -->
<!--                 <option value="4">区财政局</option> -->
<!--                 <option value="5">区社保局</option> -->
<!--                 <option value="6">空港国土资源分局</option> -->
<!--                 <option value="7">空港区卫计局</option> -->
<!--                 <option value="8">空港地税</option> -->
<!--                 <option value="9">揭阳市工商局空港经济区分局</option> -->
<!--                 <option value="10">区国税局</option> -->
<!--                 <option value="11">人事局</option> -->
<!--                 <option value="12">空港消防大队</option> -->
<!--                 </select> -->
<!--             </td> -->
<!--         </tr> -->
<!--         <tr> -->
<!--             <th><font color="red">*</font>问题发生详细地址：</th> -->
<!--             <td colspan="3"><input type="text" name="detailAddress" id="detailAddress"></td> -->
<!--         </tr> -->
        <tr>
            <th><font color="red">*</font>信息内容：</th>
            <td colspan="3">
            	<textarea name="content" id="content" cols="60" rows="5" disabled="disabled"></textarea>
            	<br/>（注：输入的内容请不要超过500个字符！）
            </td>
        </tr>
<!--         <tr> -->
<!--             <th>文件上传：</th> -->
<!--             <td colspan="3"><input type="file" name="uploadFile"></td> -->
<!--         </tr> -->
<!--         <tr> -->
<!--             <th>是否曾向信访局来信来访：</th> -->
<!--             <td colspan="3"> -->
<!--                 <input type="radio" name="everDo" value="1" checked="checked">是 &nbsp;&nbsp; -->
<!--                 <input type="radio" name="everDo" value="0">否 -->
<!--             </td> -->
<!--         </tr> -->
        <tr>
            <td colspan="4" align="center">
                <input type="button" id="btn_submit" onClick="dosubmit();return false;" value="提交" disabled="disabled">&nbsp;&nbsp;
                <input type="reset" value="重置"/>
            </td>
        </tr>
        </table>
        </form>
        </div>
	</div>
</div>    
<%@include file="../../web/foot.jsp" %>    

</body>
<script type="text/javascript">
	function check(){
		var name = $.trim($('#name').val());
// 		var age = $.trim($('#age').val());
// 		var certNum = $.trim($('#certNum').val());
		var phone = $.trim($('#phone').val());
// 		var moblePhone = $.trim($('#moblePhone').val());
		var email = $.trim($('#email').val());
// 		var postcode = $.trim($('#postcode').val());
// 		var joinNum  = $.trim($('#joinNum').val());
// 		var address = $.trim($('#address').val());
		var theme = $.trim($('#theme').val());
// 		var detailAddress = $.trim($('#detailAddress').val());
		var content = $.trim($('#content').val());
		if(name==""||name==null||name.length<2||name.length>10){
			alert("请正确输入姓名");
			$('#name').focus();
			return false;
		}else if(theme==null||theme==""||theme.length>200){
			alert("请正确输入主题");
			$('#theme').focus();
			return false;
		}else if(content==null||content==""){
			alert("内容不能为空");
			$('#content').focus();
			return false;
		}else if(content.length>500){
			alert("内容输入过长，请不要超过500个字符！");
			$('#content').focus();
			return false;
		}else if(phone==null||phone==""){
			alert("电话不能为空！");
			$('#phone').focus();
			return false;
		}else if(email==null||email==""){
			alert("邮箱不能为空！");
			$('#email').focus();
			return false;
		}
		return true;
		}
		
	function dosubmit(){
		if(check()==true){
			document.getElementById("save").submit();
		}
	}
	function run(){
		var s = document.getElementById("dd");
		if(s.innerHTML == 0){
			$("#ppp").hide();
			$("#name").attr("disabled",false);
			$("#isOpen1").attr("disabled",false);
			$("#isOpen0").attr("disabled",false);
			$("#phone").attr("disabled",false);
			$("#email").attr("disabled",false);
			$("#theme").attr("disabled",false);
			$("#content").attr("disabled",false);
			$("#btn_submit").attr("disabled",false);
			window.clearInterval(sss);
			return false;
		}
		s.innerHTML = s.innerHTML * 1 - 1;
		
	}
 	var sss = window.setInterval("run();", 1000);
</script>
</html>