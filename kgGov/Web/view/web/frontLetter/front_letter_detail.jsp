<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>揭阳空港经济区</title>
</head>
<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">

		<div class="side">	
		<%@include file="front_letter_page.jsp" %>
		</div>
        <div class="main">
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b><c:if test="${flag eq '1'}">领导信箱</c:if><c:if test="${flag eq '2'}">建言献策</c:if><c:if test="${flag eq '3'}">投诉举报</c:if>答复选登</b></div>                 
        	<c:if test="${letterDetail==null }">
            <table class="formtable">
            <tr>                     
                <th>来访路径：</th>
                <td>${letter.visitePath }</td>
                <th>受理编号：</th>
                <td>${letter.acceptNum }</td>
            </tr>
            <tr>                        
                <th>姓名：</th>
                <td>${letter.name }</td>
                <th>政治面貌：</th>
                <td>
                <c:if test="${letter.politicalType==1 }">
                    群众
                </c:if>
                <c:if test="${letter.politicalType==2 }">
                     团员
                </c:if>
                <c:if test="${letter.politicalType==3 }">
                    党员
                </c:if>
                <c:if test="${letter.politicalType==4 }">
                    其它
                </c:if>
                </td>
            </tr>
            <tr>                       
                <th>证件类型：</th>
                <td>
                <c:if test="${letter.certType==1 }">
                    身份证
                </c:if>
                <c:if test="${letter.certType==2 }">
                    学生证
                </c:if>
                <c:if test="${letter.certType==3 }">
                    驾驶证
                </c:if>
                </td>
                <th>证件号码：</th>
                <td>${letter.certNum }</td>
            </tr>
            <tr>                        
                <th>职业：</th>
                <td>
                <c:if test="${letter.occupType==1 }">
                    公务员
                </c:if>
                <c:if test="${letter.occupType==2 }">
                    学生
                </c:if>
                <c:if test="${letter.occupType==3 }">
                    教师
                </c:if>
                <c:if test="${letter.occupType==4 }">
                    农民
                </c:if>
                <c:if test="${letter.occupType==5 }">
                    工人
                </c:if>
                <c:if test="${letter.occupType==6 }">
                    个体经营
                </c:if>
                </td>
                <th>电子邮箱：</th>
                <td>${letter.email }</td>
            </tr>
            <tr>
                <th>主题：</th>
                <td>${letter.theme }</td>
                <th>问题类别：</th>  
                <td>                  
                <c:if test="${letter.questionType==1 }">
                    未选择
                </c:if>
                <c:if test="${letter.questionType==2 }">
                    城乡建设
                </c:if>
                <c:if test="${letter.questionType==3 }">
                    国土资源水利林业
                </c:if>
                <c:if test="${letter.questionType==4 }">
                    劳动社保
                </c:if>
                <c:if test="${letter.questionType==5 }">
                    农村农业
                </c:if>
                <c:if test="${letter.questionType==6 }">
                    政法
                </c:if>
                <c:if test="${letter.questionType==7 }">
                    纪检监察
                </c:if>
                <c:if test="${letter.questionType==8 }">
                    组织人事
                </c:if>
                <c:if test="${letter.questionType==9 }">
                    民政
                </c:if>
                <c:if test="${letter.questionType==10 }">
                    教育
                </c:if>
                <c:if test="${letter.questionType==11 }">
                    卫生计生
                </c:if>
                <c:if test="${letter.questionType==12 }">
                    经济综合
                </c:if>
                <c:if test="${letter.questionType==13 }">
                    政治综合
                </c:if>
                <c:if test="${letter.questionType==14 }">
                    交通能源环保
                </c:if>
                <c:if test="${letter.questionType==15 }">
                    商贸旅游
                </c:if>
                <c:if test="${letter.questionType==16 }">
                    宣传舆论
                </c:if>
                <c:if test="${letter.questionType==17 }">
                    信息产业
                </c:if>
                <c:if test="${letter.questionType==18 }">
                    科技文体
                </c:if>
                <c:if test="${letter.questionType==19 }">
                    其它
                </c:if>
                </td>
            </tr>
            <tr>
                <th>涉及单位：</th>
                <td>
                    <c:if test="${letter.referDept eq '0' }">
                        未选择
                    </c:if>
                    <c:if test="${letter.referDept eq '1' }">
                        区发改局
                    </c:if>
                    <c:if test="${letter.referDept eq '2' }">
                        空港公安分局
                    </c:if>
                    <c:if test="${letter.referDept eq '3' }">
                        区农业局(水利、民政)
                    </c:if>
                    <c:if test="${letter.referDept eq '4' }">
                        区财政局
                    </c:if>
                    <c:if test="${letter.referDept eq '5' }">
                        区社保局
                    </c:if>
                    <c:if test="${letter.referDept eq '6' }">
                        空港国土资源分局
                    </c:if>
                    <c:if test="${letter.referDept eq '7' }">
                        空港区卫计局
                    </c:if>
                    <c:if test="${letter.referDept eq '8' }">
                        空港地税
                    </c:if>
                    <c:if test="${letter.referDept eq '9' }">
                        揭阳市工商局空港经济区分局
                    </c:if>
                    <c:if test="${letter.referDept eq '10' }">
                        区国税局
                    </c:if>
                    <c:if test="${letter.referDept eq '11' }">
                        人事局
                    </c:if>
                    <c:if test="${letter.referDept eq '12' }">
                        空港消防大队
                    </c:if>
                </td>
                <th>联名人数：</th>
                <td>${letter.joinNum }</td>
            </tr>
            <tr>
                <th>问题发生详细地址：</th>
                <td colspan="3">${letter.detailAddress }</td>               
            </tr>
            <tr>
                <th>具体内容：</th>
                <td colspan="3">${letter.content }</td>
            </tr>
            <tr>
                <th>上传资料：</th>
                <td><a href="${ctx }/letter/downLoad.action?downPath=${letter.uploadFile }">${letter.uploadFile }</a></td>
                <td>是否曾向信访局来信来访：</td>
                <td>
                <c:if test="${letter.everDo==1 }">
                    是
                </c:if>
                <c:if test="${letter.everDo==0 }">
                    否
                </c:if>
            </tr>
            <tr>
                <th>信箱类型：</th>
                <td colspan="3">
                <c:if test="${letter.flag eq '1' }">
                    领导信箱
                </c:if>
                <c:if test="${letter.flag eq '2' }">
                    建言献策
                </c:if>
                <c:if test="${letter.flag eq '3' }">
                    投诉举报
                </c:if>
                </td>
            </tr>
            <c:if test="${letter.status eq '1'}">
            <tr>
            	<th>是否回复</th>
                <td colspan="3"><font color="green">已回复</font></td>
            </tr>
            <tr>
            	<th>回复内容：</th>
                <td colspan="3">${letter.replay }</td>
            </tr>
            </c:if>
            <c:if test="${letter.status eq '0'}">
            <tr>
            	<th>是否回复</th>
                <td colspan="3"><font color="red">未回复</font></td>
            </tr>            
            </c:if>             
            </table>
                  
        </c:if>
        <c:if test="${letterDetail!=null }">
        	<table class="formtable">
            <tr>
                <th>来访路径：</th>
                <td colspan="3">${letterDetail.visitePath }</td>
            </tr>
            <tr>
                <th>受理编号：</th>
                <td>${letterDetail.acceptNum }</td>
                <th>姓名：</th>
                <td>${letterDetail.name }</td>
            </tr>
            <tr>
                <th>性别：</th>
                <td>
                <c:if test="${letterDetail.sex==1 }">
                    男
                </c:if>
                <c:if test="${letterDetail.sex==0 }">
                    女
                </c:if>
                </td>
                <th>年龄：</th>
                <td>${letterDetail.age }</td>
            </tr>
            <tr>
                <th>政治面貌：</th>
                <td>
                <c:if test="${letterDetail.politicalType==1 }">
                    群众
                </c:if>
                <c:if test="${letterDetail.politicalType==2 }">
                     团员
                </c:if>
                <c:if test="${letterDetail.politicalType==3 }">
                    党员
                </c:if>
                <c:if test="${letterDetail.politicalType==4 }">
                    其它
                </c:if>
                </td>
                <th>证件类型：</th>
                <td>
                <c:if test="${letterDetail.certType==1 }">
                    身份证
                </c:if>
                <c:if test="${letterDetail.certType==2 }">
                    学生证
                </c:if>
                <c:if test="${letterDetail.certType==3 }">
                    驾驶证
                </c:if>
                </td>
            </tr>
            <tr>
                <th>证件号码：</th>
                <td>${letterDetail.certNum }</td>
                <th>职业：</th>
                <td>
                <c:if test="${letterDetail.occupType==1 }">
                    公务员
                </c:if>
                <c:if test="${letterDetail.occupType==2 }">
                    学生
                </c:if>
                <c:if test="${letterDetail.occupType==3 }">
                    教师：
                </c:if>
                <c:if test="${letterDetail.occupType==4 }">
                    农民：
                </c:if>
                <c:if test="${letterDetail.occupType==5 }">
                    工人：
                </c:if>
                <c:if test="${letterDetail.occupType==6 }">
                    个体经营：
                </c:if>
                </td>
            </tr>
            <tr>
                <th>工作单位：</th>
                <td>${letterDetail.workplace }</td>
                <th>联系电话：</th>
                <td>${letterDetail.phone }</td>
            </tr>
            <tr>
                <th>手机号码：</th>
                <td>${letterDetail.moblePhone }</td>
                <th>电子邮箱：</th>
                <td>${letterDetail.email }</td>
            </tr>
            <tr>
                <th>联系方式或住址：</th>
                <td>${letterDetail.address }</td>
                <th>邮编：</th>
                <td>${letterDetail.postcode }</td>
            </tr>
            <tr>
                <th>主题：</th>
                <td>${letterDetail.theme }</td>
                <th>问题类别：</th>  
                <td>                  
                <c:if test="${letterDetail.questionType==1 }">
                    未选择
                </c:if>
                <c:if test="${letterDetail.questionType==2 }">
                    城乡建设
                </c:if>
                <c:if test="${letterDetail.questionType==3 }">
                    国土资源水利林业
                </c:if>
                <c:if test="${letterDetail.questionType==4 }">
                    劳动社保
                </c:if>
                <c:if test="${letterDetail.questionType==5 }">
                    农村农业
                </c:if>
                <c:if test="${letterDetail.questionType==6 }">
                    政法
                </c:if>
                <c:if test="${letterDetail.questionType==7 }">
                    纪检监察
                </c:if>
                <c:if test="${letterDetail.questionType==8 }">
                    组织人事
                </c:if>
                <c:if test="${letterDetail.questionType==9 }">
                    民政
                </c:if>
                <c:if test="${letterDetail.questionType==10 }">
                    教育
                </c:if>
                <c:if test="${letterDetail.questionType==11 }">
                    卫生计生
                </c:if>
                <c:if test="${letterDetail.questionType==12 }">
                    经济综合
                </c:if>
                <c:if test="${letterDetail.questionType==13 }">
                    政治综合
                </c:if>
                <c:if test="${letterDetail.questionType==14 }">
                    交通能源环保
                </c:if>
                <c:if test="${letterDetail.questionType==15 }">
                    商贸旅游
                </c:if>
                <c:if test="${letterDetail.questionType==16 }">
                    宣传舆论
                </c:if>
                <c:if test="${letterDetail.questionType==17 }">
                    信息产业
                </c:if>
                <c:if test="${letterDetail.questionType==18 }">
                    科技文体
                </c:if>
                <c:if test="${letterDetail.questionType==19 }">
                    其它
                </c:if>
                </td>
            </tr>
            <tr>
                <th>涉及单位：</th>
                <td>
                    <c:if test="${letter.referDept eq '0' }">
                        未选择
                    </c:if>
                    <c:if test="${letter.referDept eq '1' }">
                        区发改局
                    </c:if>
                    <c:if test="${letter.referDept eq '2' }">
                        空港公安分局
                    </c:if>
                    <c:if test="${letter.referDept eq '3' }">
                        区农业局(水利、民政)
                    </c:if>
                    <c:if test="${letter.referDept eq '4' }">
                        区财政局
                    </c:if>
                    <c:if test="${letter.referDept eq '5' }">
                        区社保局
                    </c:if>
                    <c:if test="${letter.referDept eq '6' }">
                        空港国土资源分局
                    </c:if>
                    <c:if test="${letter.referDept eq '7' }">
                        空港区卫计局
                    </c:if>
                    <c:if test="${letter.referDept eq '8' }">
                        空港地税
                    </c:if>
                    <c:if test="${letter.referDept eq '9' }">
                        揭阳市工商局空港经济区分局
                    </c:if>
                    <c:if test="${letter.referDept eq '10' }">
                        区国税局
                    </c:if>
                    <c:if test="${letter.referDept eq '11' }">
                        人事局
                    </c:if>
                    <c:if test="${letter.referDept eq '12' }">
                        空港消防大队
                    </c:if>
                </td>
                <th>联名人数：</th>
                <td>${letterDetail.joinNum }</td>
            </tr>
            <tr>
                <th>问题发生详细地址：</th>
                <td colspan="3">${letterDetail.detailAddress }</td>                        
            </tr>
            <tr>
                <th>具体内容：</th>
                <td colspan="3">${letterDetail.content }</td>
            </tr>
            <tr>
                <th>上传资料：</th>
                <td><a href="${ctx }/letter/downLoad.action?downPath=${letterDetail.uploadFile }">${letterDetail.uploadFile }</a></td>
                <th>是否曾向信访局来信来访：</th>
                <td>
                <c:if test="${letterDetail.everDo==1 }">
                    是
                </c:if>
                <c:if test="${letterDetail.everDo==0 }">
                    否
                </c:if>
            </tr>
            <tr>
                <th>是否公开：</th>
                <td>
                <c:if test="${letterDetail.isOpen eq '1' }">
                    是
                </c:if>
                <c:if test="${letterDetail.isOpen eq '0' }">
                    否
                </c:if>
                <th>信箱类型：</th>
                <td>
                <c:if test="${letterDetail.flag eq '1' }">
                    领导信箱
                </c:if>
                <c:if test="${letterDetail.flag eq '2' }">
                    建言献策
                </c:if>
                <c:if test="${letterDetail.flag eq '3' }">
                    投诉举报
                </c:if>
                </td>
            </tr>
            <c:if test="${letterDetail.status eq '1'}">
            <tr>
            	<th>是否回复</th>
                <td colspan="3"><font color="green">已回复</font></td>
            </tr>
            <tr>
            	<th>回复内容：</th>
                <td colspan="3">${letterDetail.replay }</td>
            </tr>
            </c:if>
            <c:if test="${letterDetail.status eq '0'}">
            <tr>
            	<th>是否回复</th>
                <td colspan="3"><font color="red">未回复</font></td>
            </tr>            
            </c:if>            
            </table>
        </c:if>        
	</div>
</div>    
<%@include file="../../web/foot.jsp" %>    
</body>
</html>