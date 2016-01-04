<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content=""/>
    <meta name="description" content="" />
    <title>揭阳市发展和改革局</title>
</head>
<body class="index">
<%@include file="../../web/head.jsp" %>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.focus.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.focus.min.js"></script>

<div class="wrapper">
    <div class="inner">

            <div class="side">
            	<div class="jggk">
                	<h3><span>机构概况</span></h3>
                    <ul>
                    <li><a href="${ctx}/web/areaInfoList.action?catalogID=196">机构职能</a></li>
                    <li><a href="${ctx}/web/areaInfoList.action?catalogID=197">领导之窗</a></li>
                    <li><a href="${ctx}/web/areaInfoList.action?catalogID=198">内设机构</a></li>
                    <li><a href="${ctx}/web/areaInfoList.action?catalogID=199">直属行政单位</a></li>
                    <li><a href="${ctx}/web/areaInfoList.action?catalogID=200">直属事业单位</a></li>
                    </ul>
                </div>
                <div class="zdly">
                    <h3><span>政府信息公开</span></h3>
                    	<ul>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=213" target="_blank">组织机构</a></li>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=214" target="_blank">部门文件</a></li>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=215" target="_blank">工作动态</a></li>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=217" target="_blank">办事指南</a></li>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=218" target="_blank">财政预决算</a></li>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=219" target="_blank">政府信息公开年度报告</a></li>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=1044" target="_blank">政策法规</a></li>
		                    <li><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393&menuCat=220" target="_blank">其他</a></li>
		                    </ul>
<!--                     <div> -->
<!--                     <table cellpadding="0" cellspacing="0" border="0"> -->
<!--                         <tr> -->
<%--                             <td><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk1.jpg)">信息公开指南</a> --%>
<!--                             </td> -->
<%--                             <td><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk2.jpg)">信息公开目录</a> --%>
<!--                             </td> -->
<!--                         </tr> -->
<!--                         <tr> -->
<%--                             <td><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk3.jpg)">信息公开年报</a> --%>
<!--                             </td> -->
<%--                             <td><a href="http://ysq.jieyang.gov.cn/showDeptName.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk4.jpg)">依申请公开</a> --%>
<!--                             </td> -->
<!--                         </tr> -->
                        <!--tr>
                            <td><a href="http://113.107.43.7:8000/wjjzdly/"
                                   style="background-image:url(${ctx}/resources/web/image/gk5.jpg); padding-top:5px; height:45px; line-height:20px;" target="_blank">重点领域信息公开专栏</a>
                            </td>
                            <td><a href="http://xxgk.jieyang.gov.cn/index!department.shtml?level=3&regionID=1&departmentID=19"
                                   style="background-image:url(${ctx}/resources/web/image/gk6.jpg); padding-top:5px; height:45px; line-height:20px;" target="_blank">工程建设领域信息公开专栏</a>
                            </td>
                        </tr-->
<!--                     </table> -->
                    <!--p align="center"><a href="http://wsbs.jieyang.gov.cn" target="_blank"><img src="${ctx}/resources/web/image/pic.jpg"/></a></p-->
<!--                     </div> -->
                </div>
				<div class="zdly">
                	<h3><span>重点领域专栏</span></h3>
                    <ul>
                    <li><a href="http://113.107.43.7:8000/wjjzdly/djml/xxml/" target="_blank">定价目录</a></li>
                    <li><a href="http://113.107.43.7:8000/wjjzdly/jgbz/spjg/" target="_blank">价费标准</a></li>
                    <li><a href="http://113.107.43.7:8000/wjjzdly/jgzf/zfgz/" target="_blank">价格执法</a></li>
                    </ul>
                </div>
            </div>

            <div class="main">
            <div class="gkNews">
            <table>
            <tr>
            	<td>
                <div id="slide">
                    <ul id="pic">
                        <c:forEach items="${picIndexList}" var="item" varStatus="status">
                            <li>
                                <a target="_blank"
                                   href="${ctx}/web/contentsShow.action?type=news&contentsID=${item.contentID}">
                                    <img src="${ctx}/${item.fileUrl}" title="${item.title}"/>

                                    <p>${fn:substring(item.title, 0, 14)}</p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                    <div id="num">
                        <c:forEach items="${picIndexList}" var="item" varStatus="status">
                            <a href="javascript:void(0)" hidefocus="true" target="_self">${status.count}</a>
                        </c:forEach>
                    </div>
                    <span class="prev"></span>
                    <span class="next"></span>
                </div>             
                </td>
                <td>
                <div class="tab">
                    <ul class="tab_menu">
                        <li class="current">${catalog43.title}<a href="${ctx}/web/areaInfoList.action?type=news&catalogID=10">+ 更多</a></li>
                        <li>${catalog10.title}<a href="${ctx}/web/areaInfoList.action?type=news&catalogID=43">+ 更多</a></li>
                    </ul>
                    <div class="tab_content">
                        <ul>
							<c:forEach items="${contents43List }" var="contents" varStatus="status">
								<li>
									<a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}" title="${contents.title}">
										<c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                        <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                    </a>
                                    <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                        <ul class="hide">
							<c:forEach items="${contents10List }" var="contents" varStatus="status">
								<li>
									<a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}" title="${contents.title}">
                                    	<c:if test="${fn:length(contents.title)>21}">${fn:substring(contents.title,0,21)}...</c:if>
                                        <c:if test="${fn:length(contents.title)<=21}">${contents.title}</c:if>
                                    </a>
                                    <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                
                </td>
            </tr>
            </table>
            </div>
            
            <div class="gklist">
            <table>
            <tr>
            	<td style="padding-right:3px;">
                <div class="border">
                    <h3><span>最新公示</span><a href="">+ 更多</a></h3>
                    <ul>
                        <c:forEach items="${content180List }" var="item">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}"
                                   title="${item.title }">
                                    <c:if test="${fn:length(item.title)>22}">
                                        ${fn:substring(item.title,0,20)}...
                                    </c:if>
                                    <c:if test="${fn:length(item.title)<=22}">
                                        ${item.title}
                                    </c:if>
                                    <em>${fn:substring(item.releaseDate,0,10)}</em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>                  
                </td>
                <td style="padding-left:3px;">
                <div class="border">
                    <h3><span>通知公告</span><a href="">+ 更多</a></h3>
                    <ul>
                        <c:forEach items="${content186List }" var="item">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}"
                                   title="${item.title }">
                                    <c:if test="${fn:length(item.title)>22}">
                                        ${fn:substring(item.title,0,20)}...
                                    </c:if>
                                    <c:if test="${fn:length(item.title)<=22}">
                                        ${item.title}
                                    </c:if>
                                    <em>${fn:substring(item.releaseDate,0,10)}</em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>                
                </td>
            </tr>
            <tr>
            	<td style="padding-right:3px;">
                <div class="border">
                    <h3><span>政策发布</span><a href="">+ 更多</a></h3>
                    <ul>
                        <c:forEach items="${content183List }" var="item">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}"
                                   title="${item.title }">
                                    <c:if test="${fn:length(item.title)>22}">
                                        ${fn:substring(item.title,0,20)}...
                                    </c:if>
                                    <c:if test="${fn:length(item.title)<=22}">
                                        ${item.title}
                                    </c:if>
                                    <em>${fn:substring(item.releaseDate,0,10)}</em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>                  
                </td>
                <td style="padding-left:3px;">
                <div class="border">
                    <h3><span>党建专题</span><a href="">+ 更多</a></h3>
                    <ul>
                        <c:forEach items="${djztList }" var="item">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}"
                                   title="${item.title }">
                                    <c:if test="${fn:length(item.title)>22}">
                                        ${fn:substring(item.title,0,20)}...
                                    </c:if>
                                    <c:if test="${fn:length(item.title)<=22}">
                                        ${item.title}
                                    </c:if>
                                    <em>${fn:substring(item.releaseDate,0,10)}</em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>                
                </td>
            </tr>
            </table>
			</div>
            </div>

    </div>
</div>


<script>


    //图片新闻动态效果
    $(document).ready(function () {
        Qfast(false, 'widgets', function () {
            K.tabs({
                id: 'slide',   //焦点图包裹id
                conId: "pic",  //** 大图域包裹id
                tabId: "num",
                tabTn: "a",
                conTn: "li",
                auto: 1,   //自动播放 1或0
                effect: 'fade',   //效果配置
                eType: 'mouseover', //** 鼠标事件
                pageBt: 'true',//是否有按钮切换页码
                bns: ['.prev', '.next'],//** 前后按钮配置class
                interval: 3000  //** 停顿时间
            })
        })		

    });
</script>

<%@include file="../../web/foot.jsp" %>

</body>
</html>

