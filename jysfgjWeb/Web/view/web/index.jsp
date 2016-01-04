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
<%@include file="../web/head.jsp" %>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.focus.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.focus.min.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.corner.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.roundabout.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.roundabout-shapes.js"></script>

<div class="wrapper">
    <div class="inner">
        <div class="box1">
            <div class="left">
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
            </div>

            <div class="middle">
                <div class="tab newstab">
                    <ul class="tab_menu">
                        <li class="current">${catalog43.title}<a href="${ctx}/web/areaInfoList.action?type=news&catalogID=43">+ 更多</a></li>
                        <li>${catalog10.title}<a href="${ctx}/web/areaInfoList.action?type=news&catalogID=10">+ 更多</a></li>
                    </ul>
                    <div class="tab_content">
                        <ul>
                            <c:if test="${contents43 != null }">
                                <li class="topic">
                                    <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents43.desId}"
                                       title="${contents43.title}">
                                        <c:if test="${fn:length(contents43.title)>16}">${fn:substring(contents43.title,0,16)}...</c:if>
                                        <c:if test="${fn:length(contents43.title)<=16}">${contents43.title}</c:if>
                                    </a>

                                    <p>
                                        <c:if test="${fn:length(contents43.contents)>60}">${fn:substring(contents43.contents,0,55)}...</c:if>
                                        <c:if test="${fn:length(contents43.contents)<=60}">${contents43.contents}</c:if>
                                    </p>
                                </li>
                                <c:forEach items="${contents43List }" var="contents" varStatus="status">
                                    <li>
                                        <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}"
                                           title="${contents.title}">
                                            <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                            <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                        </a>
                                        <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <c:if test="${contents43==null }">
                                <c:forEach items="${contents43List }" var="contents" varStatus="status">
                                    <li>
                                        <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}"
                                           title="${contents.title}">
                                            <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                            <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                        </a>
                                        <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                        <ul class="hide">
                            <c:if test="${contents10 != null }">
                                <li class="topic">
                                    <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents10.desId}"
                                       title="${contents10.title}">
                                        <c:if test="${fn:length(contents10.title)>16}">${fn:substring(contents10.title,0,16)}...</c:if>
                                        <c:if test="${fn:length(contents10.title)<=16}">${contents10.title}</c:if>
                                    </a>

                                    <p>
                                        <c:if test="${fn:length(contents10.contents)>60}">${fn:substring(contents10.contents,0,55)}...</c:if>
                                        <c:if test="${fn:length(contents10.contents)<=60}">${contents10.contents}</c:if>
                                    </p>
                                </li>
                                <c:forEach items="${contents10List }" var="contents" varStatus="status">
                                    <li>
                                        <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}"
                                           title="${contents.title}">
                                            <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                            <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                        </a>
                                        <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                    </li>
                                </c:forEach>

                            </c:if>
                            <c:if test="${contents10 == null }">
                                <c:forEach items="${contents10List }" var="contents" varStatus="status">
                                    <li>
                                        <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}"
                                           title="${contents.title}">
                                            <c:if test="${fn:length(contents.title)>21}">${fn:substring(contents.title,0,21)}...</c:if>
                                            <c:if test="${fn:length(contents.title)<=21}">${contents.title}</c:if>
                                        </a>
                                        <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="right">
                <div class="tab notice">
                    <ul class="tab_menu">
                        <li class="current">通知公告</li>
                        <li>最新公示</li>
                    </ul>
                    <div class="tab_content">
                        <div id="marqueeBox" style="overflow:hidden; height:240px;">
                            <ul id="marqueeImg">
                                <c:forEach items="${content186List }" var="item">
                                    <li>
                                        <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}"
                                           title="${item.title }">
                                            <c:if test="${fn:length(item.title)>12}">
                                                ${fn:substring(item.title,0,11)}...
                                            </c:if>
                                            <c:if test="${fn:length(item.title)<=12}">
                                                ${item.title}
                                            </c:if>
                                            <em>${fn:substring(item.releaseDate,0,10)}</em>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                            <ul class="">
                                <c:forEach items="${contents180List }" var="item">
                                    <li>
                                        <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}"
                                           title="${item.title }">
                                            <c:if test="${fn:length(item.title)>12}">
                                                ${fn:substring(item.title,0,11)}...
                                            </c:if>
                                            <c:if test="${fn:length(item.title)<=12}">
                                                ${item.title}
                                            </c:if>
                                            <em>${fn:substring(item.releaseDate,0,10)}</em>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="box2">
            <div class="left">
                <div class="zwgk">
                    <h3><span>政府信息公开</span></h3>
                    <div>
                    <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk1.jpg)">信息公开指南</a>
                        </td>
                        <td><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk2.jpg)">信息公开目录</a>
                        </td>
                    </tr>
                    <tr>
                        <td><a href="http://zwgk.jieyang.gov.cn/openInfo.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk3.jpg)">信息公开年报</a>
                        </td>
                        <td><a href="http://ysq.jieyang.gov.cn/showDeptName.action?depCode=007026393" target="_blank" style="background-image:url(${ctx}/resources/web/image/gk4.jpg)">依申请公开</a>
                        </td>
                    </tr>
                    <tr>
                        <td><a href="http://113.107.43.7:8000/wjjzdly/"
                               style="background-image:url(${ctx}/resources/web/image/gk5.jpg); padding-top:5px; height:45px; line-height:20px;" target="_blank">重点领域信息公开专栏</a>
                        </td>
                        <td><a href="http://xxgk.jieyang.gov.cn/index!department.shtml?level=3&regionID=1&departmentID=19"
                               style="background-image:url(${ctx}/resources/web/image/gk6.jpg); padding-top:5px; height:45px; line-height:20px;" target="_blank">工程建设领域信息公开专栏</a>
                        </td>
                    </tr>
                    </table>
                    <p align="center"><a href="http://wsbs.jieyang.gov.cn" target="_blank"><img src="${ctx}/resources/web/image/pic.jpg"/></a></p>
                    </div>
                </div>                
            </div>
            <div class="middle">
                <div class="tab listab">
                    <ul class="tab_menu">
                        <%--对应重大项目--%>
                        <li class="current">发展规划<a href="${ctx}/web/areaInfoList.action?type=&catalogID=5">+ 更多</a>
                        </li>
                        <li>重点项目<a href="${ctx}/web/areaInfoList.action?type=&catalogID=171">+ 更多</a></li>
                        <li>价费标准<a href="${ctx}/web/areaInfoList.action?type=&catalogID=172">+ 更多</a></li>
                        <li>粮食工作<a href="${ctx}/web/areaInfoList.action?type=&catalogID=172">+ 更多</a></li>
                    </ul>
                    <div class="tab_content">
                        <ul>
                            <c:forEach items="${content5List }" var="list">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?contentsID=${list.desId}"
                                       title="${list.title}">
                                        <c:if test="${fn:length(list.title)>28 }">${fn:substring(list.title,0,26)}...</c:if>
                                        <c:if test="${fn:length(list.title)<=28 }">${list.title}</c:if>
                                    </a>
                                    <em>${fn:substring(list.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                        <ul class="hide">
                            <c:forEach items="${content171List }" var="list">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?contentsID=${list.desId}"
                                       title="${list.title}">
                                        <c:if test="${fn:length(list.title)>28 }">${fn:substring(list.title,0,26)}...</c:if>
                                        <c:if test="${fn:length(list.title)<=28 }">${list.title}</c:if>
                                    </a>
                                    <em>${fn:substring(list.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                        <ul class="hide">
                            <c:forEach items="${contents81List }" var="list">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?contentsID=${list.desId}"
                                       title="${list.title}">
                                        <c:if test="${fn:length(list.title)>28 }">${fn:substring(list.title,0,26)}...</c:if>
                                        <c:if test="${fn:length(list.title)<=28 }">${list.title}</c:if>
                                    </a>
                                    <em>${fn:substring(list.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                        <ul class="hide">
                            <c:forEach items="${content187List }" var="list">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?contentsID=${list.desId}"
                                       title="${list.title}">
                                        <c:if test="${fn:length(list.title)>28 }">${fn:substring(list.title,0,26)}...</c:if>
                                        <c:if test="${fn:length(list.title)<=28 }">${list.title}</c:if>
                                    </a>
                                    <em>${fn:substring(list.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="right">
                <div class="zcfb">
                    <h3><span>政策发布</span><a href="">+ 更多</a></h3>
                    <ul>
                        <c:forEach items="${contents80List }" var="item">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}"
                                   title="${item.title }">
                                    <c:if test="${fn:length(item.title)>12}">
                                        ${fn:substring(item.title,0,11)}...
                                    </c:if>
                                    <c:if test="${fn:length(item.title)<=12}">
                                        ${item.title}
                                    </c:if>
                                    <em>${fn:substring(item.releaseDate,0,10)}</em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <div class="box3">
            <div class="left">
                <div class="wsbs">
                    <h3><span>网上办事</span></h3>
                    <table>
                        <tr>
                            <th><img src="${ctx}/resources/web/image/wsbs_ckfw.jpg"/></th>
                            <td>
                                <a href="http://wsbs.jieyang.gov.cn/wsdt/doZixun?bumenID=007026393&zixunType=1" target="_blank"><img src="${ctx}/resources/web/image/wsbs_wyzx.jpg"/></a>
                                <a href="http://wsbs.jieyang.gov.cn/wsdt/spsxQuery" target="_blank"><img src="${ctx}/resources/web/image/wsbs_wycx.jpg"/></a><br/>
                                <a href="http://wsbs.jieyang.gov.cn/wsdt/doZixun?bumenID=007026393&zixunType=2" target="_blank"><img src="${ctx}/resources/web/image/wsbs_wyts.jpg"/></a>
                                <a href="http://61.145.61.49:3000/star/"  target="_blank"><img src="${ctx}/resources/web/image/wsbs_wypy.jpg"/></a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="right">

                <div class="zmhd">
                	<h3><span>政民互动</span></h3>
                    <div id="gla_box">
                        <span class="prev">&nbsp;</span>
                        <span class="next">&nbsp;</span>
                        <ul class="roundabout-holder">
                            <li class="roundabout-moveable-item">
                                <a target="_blank" href="${ctx}/web/front_letterRight.action?flag=1">
                                    <img src="${ctx}/resources/web/image/zmhd_jzxx.jpg"/>
                                    <span>局长信箱</span>
                                </a>
                            </li>
                            <li class="roundabout-moveable-item roundabout-in-focus">
                                <a target="_blank" href="${ctx}/web/front_letterRight.action?flag=2">
                                    <img src="${ctx}/resources/web/image/zmhd_ywzx.jpg"/>
                                    <span>业务咨询</span>
                                </a>
                            </li>
                            <li class="roundabout-moveable-item">
                                <a target="_blank" href="${ctx}/web/front_letterRight.action?flag=3">
                                    <img src="${ctx}/resources/web/image/zmhd_jdts.jpg"/>
                                    <span>监督投诉</span>
                                </a>
                            </li>
                            <li class="roundabout-moveable-item">
                                <a target="_blank" href="${ctx}/web/front_queryContentsList.action">
                                    <img src="${ctx}/resources/web/image/zmhd_jyxc.jpg"/>
                                    <span>建言献策</span>
                                </a>
                            </li>
                            <li class="roundabout-moveable-item">
                                <a href="#">
                                    <img src="${ctx}/resources/web/image/zmhd_jgfw.jpg"/>
                                    <span>价格服务热线</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
		
        <div class="box4">
        <div id="demo" style="overflow:hidden; zoom:1; clear:both;">
            <div style="float:left;width:800%;">
                <div id="demo1" style="float:left;">
                    <c:forEach items="${picLinksList}" var="item" varStatus="status">
                        <a href="${item.link_url}" target="_blank">
                            <img src="${ctx}/${item.pic_url}" width="195" height="60"/>
                        </a>
                    </c:forEach>
                </div>
                <div id="demo2" style="float:left;"></div>
            </div>
        </div>
        </div>

		<div class="link">
		<table>
            <tr>
                <td>
                    <select>
                        <option value="">县（市、区）发改局网站衔接</option>
                        <c:forEach items="${selectLinksList }" var="links">
                            <c:if test="${links.select_type==1 }">
                                <option value="${links.link_url }">${links.title}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select>
                        <option value="">市直单位网站衔接</option>
                        <c:forEach items="${selectLinksList }" var="links">
                            <c:if test="${links.select_type==2 }">
                                <option value="${links.link_url }">${links.title}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select>
                        <option value="">其它网站衔接</option>
                        <c:forEach items="${selectLinksList }" var="links">
                            <c:if test="${links.select_type==3 }">
                                <option value="${links.link_url }">${links.title}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>        
        </div>
    </div>
</div>

<%@include file="../web/foot.jsp" %>



</body>

</html>

<script>
    //专题图片动态效果
    function zttp_dtxg() {
        var h1 = document.getElementById("marqueeImg").offsetHeight;
        var h2 = document.getElementById("marqueeBox").offsetHeight;
        if (h1 > h2) {
            function startmarquee(lh, speed, delay) {
                var p = false;
                var t;
                var o = document.getElementById("marqueeImg");
                o.innerHTML += o.innerHTML;
                o.style.marginTop = 0;
                o.onmouseover = function () {
                    p = true;
                }
                o.onmouseout = function () {
                    p = false;
                }
                function start() {
                    t = setInterval(scrolling, speed);
                    if (!p) o.style.marginTop = parseInt(o.style.marginTop) - 1 + "px";
                }

                function scrolling() {
                    if (parseInt(o.style.marginTop) % lh != 0) {
                        o.style.marginTop = parseInt(o.style.marginTop) - 1 + "px";
                        if (Math.abs(parseInt(o.style.marginTop)) >= o.scrollHeight / 2) o.style.marginTop = 0;
                    } else {
                        clearInterval(t);
                        setTimeout(start, delay);
                    }
                }

                setTimeout(start, delay);
            }

            startmarquee(20, 60, 0);
        }
    }
    //友情链接动态效果
    function yqlj_dtxg() {
        var links_switch_speed = 50;
        var demo = document.getElementById("demo");
        var demo1 = document.getElementById("demo1");
        var demo2 = document.getElementById("demo2");
        demo2.innerHTML = demo1.innerHTML;
        function linksMarquee() {
            if (demo2.offsetWidth - demo.scrollLeft <= 0) {
                demo.scrollLeft -= demo1.offsetWidth;
            } else {
                demo.scrollLeft++;
            }
        }

        var linksMar = setInterval(linksMarquee, links_switch_speed);
        demo.onmouseover = function () {
            clearInterval(linksMar)
        };
        demo.onmouseout = function () {
            linksMar = setInterval(linksMarquee, links_switch_speed);
        }
    }

    //政民互动动态效果
    function zmhd_dtxg() {
        $('#gla_box ul li a').corner('8px');

        $('#gla_box>ul').roundabout({
            minOpacity: 2,
            duration: 1000,
            reflect: true,
            btnNext: ".next",
            btnPrev: '.prev',
            autoplay: true,
            autoplayDuration: 10000,
            tilt: 0,
            shape: 'figure8'
        });
    }

    //图片新闻动态效果
    function tpxw_dtxg() {
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
    }

    $(document).ready(function () {
//        zttp_dtxg();
        yqlj_dtxg();
        zmhd_dtxg();
        tpxw_dtxg();
    });
</script>
