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
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b><c:if test="${flag eq '1'}">县长信箱</c:if><c:if test="${flag eq '2'}">我要写信</c:if><c:if test="${flag eq '3'}">我要建议</c:if></b></div>        
       
       	<div style=" padding:10px; color:#666;">
<p>　　为了进一步加强政府与人民群众的联系，不断改进工作作风，推进政务公开，促进依法行政，真诚地欢迎您对政府工作提出宝贵的意见和建议。 </p>
<p>　　<strong>警告:</strong> 县长信箱是沟通市民和政府之间关系的桥梁，禁止一切对县长信箱的攻击行为，例如利用Email发送网络病毒等，以及一切利用县长信箱进行造谣、诽谤、传播反动言论等种种非法行为，违者将依法追究其责任。 </p>
<p>&nbsp;</p>
<p align="right"><a href="${ctx }/web/front_replayLetter.action?flag=${flag}" style="font-size:24px;font-weight:bold;color:#f00;">答复选登</a></p>        
        </div>
        <form action="${ctx }/web/front_saveLetter.action" method="post" enctype="multipart/form-data" id="save">
        <input type="hidden" name="flag" value="${flag }"/>
        <input type="hidden" name="isOpen" value="0"/>
        <input type="hidden" name="status" value="0"/>
        <table class="formtable">
        <tr class="tbg">
            <td colspan="4">建议人资料登记(注意带有*号必须填写；请填写电子邮箱，以方便我们向您反馈处理信息)</td>
        </tr>
        <c:choose>
        <c:when test="${flag eq '3' }">
       
            <input type="hidden" name="visitePath" value="网上信访" readonly="readonly"/>
       
        </c:when>
        <c:otherwise>
        <tr>
            <th><font color="red">*</font>来访路径：</th>
            <td colspan="3"><input type="text" name="visitePath" value="网上信访" readonly="readonly"/></td>
        </tr>
        </c:otherwise>
        </c:choose>
        <tr>
            <th><font color="red">*</font>姓名：</th>
            <td><input type="text" name="name" id="name"/></td>
            <th>性别：</th>
            <td>
                <input type="radio" name="sex" value="1" checked="checked">男 &nbsp;&nbsp;
                <input type="radio" name="sex" value="0">女
            </td>
        </tr>
        <tr>
            <th>年龄：</th>
            <td><input type="text" name="age" id="age"/></td>
            <th>政治面貌：</th>
            <td>
                <select name="politicalType">
                    <option value="1">群众</option>
                    <option value="2">团员</option>
                    <option value="3">党员</option>
                    <option value="4">其它</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>证件类型：</th>
            <td>
                <select name="certType">
                    <option value="1">身份证</option>
                    <option value="2">学生证</option>
                    <option value="3">驾驶证</option>
                </select>
            </td>
            <th>证件号码：</th>
            <td><input type="text" name="certNum" id="certNum"/></td>
        </tr>
        <tr>
            <th>职业：</th>
            <td>
                <select name="occupType">
                    <option value="1">公务员</option>
                    <option value="2">学生</option>
                    <option value="3">教师</option>
                    <option value="4">农民</option>
                    <option value="5">工人</option>
                    <option value="6">个体经营</option>
                </select>
            </td>
            <th>工作单位：</th>
            <td><input type="text" name="workplace" id="workplace"/></td>
        </tr>
        <tr>
            <th>联系电话：</th>
            <td><input type="text" name="phone" id="phone"/></td>
            <th>手机号码：</th>
            <td><input type="text" name="moblePhone" id="moblePhone"/></td>
        </tr>
        <tr>
            <th>联系邮箱：</th>
            <td><input type="text" name="email" id="email"/></td>
            <th>邮编：</th>
            <td><input type="text" name="postcode" id="postcode"/></td>
        </tr>
        <tr>
            <th><font color="red">*</font>联系地址：</th>
            <td colspan="3"><input type="text" name="address" id="address"/></td>
        </tr>
        <tr class="tbg">
            <td colspan="4">建议信息登记(注意带有*号必须填写；信访事项信息)</td>
        </tr>
        <tr>
            <th><font color="red">*</font>主题：</th>
            <td colspan="3"><input type="text" name="theme" id="theme"></td>
        </tr>
        <tr>
            <th>问题类别：</th>
            <td>
                <select name="questionType">
                <option value="1">未选择</option>
                <option value="2">城乡建设</option>
                <option value="3">国土资源水利林业</option>
                <option value="4">劳动社保</option>
                <option value="5">农村农业</option>
                <option value="6">政法</option>
                <option value="7">纪检监察</option>
                <option value="8">组织人事</option>
                <option value="9">民政</option>
                <option value="10">教育</option>
                <option value="11">卫生计生</option>
                <option value="12">经济综合</option>
                <option value="13">政治综合</option>
                <option value="14">交通能源环保</option>
                <option value="15">商贸旅游</option>
                <option value="16">宣传舆论</option>
                <option value="17">信息产业</option>
                <option value="18">科技文体</option>
                <option value="19">其它</option>
                </select>
            </td>
            <th>联名人数：</th>
            <td><input type="text" name="joinNum" id="joinNum"></td>
        </tr>
        <tr>
            <th>涉及单位：</th>
            <td colspan="3">
                <select name="referDept">
                <option value="0">请选择</option>
                <option value="1">县交通局</option>
                <option value="2">县农业局</option>
                <option value="3">县住建局</option>
                <option value="4">县国土局</option>
                <option value="5">县人社局</option>
                <option value="6">县财政局</option>
                <option value="7">县民政局</option>
                <option value="8">县科技局</option>
                <option value="9">县教育局</option>
                <option value="10">县经信局</option>
                <option value="11">县编委办</option>
                <option value="12">县林业局</option>
                <option value="13">县人防办</option>
                <option value="14">县城规局</option>
                <option value="15">县水务局</option>
                <option value="16">县外侨局</option>
                <option value="17">惠来烟草专卖局</option>
                <option value="18">县气象局</option>
                <option value="19">惠来供电局</option>						
                </select>
            </td>
        </tr>
        <tr>
            <th><font color="red">*</font>问题发生详细地址：</th>
            <td colspan="3"><input type="text" name="detailAddress" id="detailAddress"></td>
        </tr>
        <tr>
            <th><font color="red">*</font>信息内容：</th>
            <td colspan="3">
            	<textarea name="content" id="content" cols="60" rows="5"></textarea>
            	<br/>（注：输入的内容请不要超过500个字符！）
            </td>
        </tr>
        <tr>
            <th>文件上传：</th>
            <td colspan="3"><input type="file" name="uploadFile"></td>
        </tr>
        <tr>
            <th>是否曾向信访局来信来访：</th>
            <td colspan="3">
                <input type="radio" name="everDo" value="1" checked="checked">是 &nbsp;&nbsp;
                <input type="radio" name="everDo" value="0">否
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <input type="button" onClick="dosubmit();return false;" value="提交">&nbsp;&nbsp;
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
		var age = $.trim($('#age').val());
		var certNum = $('#certNum').val();
		var phone = $('#phone').val();
		var moblePhone = $.trim($('#moblePhone').val());
		var email = $.trim($('#email').val());
		var postcode = $('#postcode').val();
		var joinNum  = $('#joinNum').val();
		var address = $.trim($('#address').val());
		var theme = $.trim($('#theme').val());
		var detailAddress = $.trim($('#detailAddress').val());
		var content = $.trim($('#content').val());
		if(name==""||name==null||name.length<2||name.length>10){
			alert("请正确输入姓名");
			$('#name').focus();
			return false;
		}else if(address==null||address==""||address.length>200){
			alert("请正确输入地址");
			$('#address').focus();
			return false;
		}else if(theme==null||theme==""||theme.length>200){
			alert("请正确输入主题");
			$('#theme').focus();
			return false;
		}else if(detailAddress==null||detailAddress==""||detailAddress.length>300){
			alert("请正确输入问题发生详细地址");
			$('#detailAddress').focus();
			return false;
		}else if(content==null||content==""){
			alert("内容不能为空");
			$('#content').focus();
			return false;
		}else if(content.length>500){
			alert("内容输入过长，请不要超过500个字符！");
			$('#content').focus();
			return false;
		}else if(!(moblePhone==null||moblePhone=="")){
			var patrn=/^1[3|4|5|8][0-9]\d{4,8}$/;
			if(!patrn.exec(moblePhone)){
				alert("请输入正确的手机号码");
				$('#moblePhone').focus();
				return false;			
			}if(!(email==null||email=="")){
				var patrn=/\w@\w*\.\w/;
				if(!patrn.exec(email)){
					alert("请输入正确的邮箱");
					$('#email').focus();
					return false;
				}
			}
		}else if(!(email==null||email=="")){
			var patrn=/^1[3|4|5|8][0-9]\d{4,8}$/;
			if(!patrn.exec(email)){
				alert("请输入正确的邮箱");
				$('#email').focus();
				return false;			
			}if(!(moblePhone==null||moblePhone=="")){
				var patrn=/\w@\w*\.\w/;
				if(!patrn.exec(moblePhone)){
					alert("请输入正确的手机号码");
					$('#moblePhone').focus();
					return false;
				}
			}
		}
		return true;
		}
		
	function dosubmit(){
		if(check()==true){
			document.getElementById("save").submit();
		}
	}
</script>
</html>