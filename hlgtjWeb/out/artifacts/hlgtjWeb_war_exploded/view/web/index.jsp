<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <title>惠来国土资源局</title>
</head>
<body class="index">
<%@include file="../web/head.jsp" %>

<div class="wrapper">
    <div class="inner">

        <div class="left">

            <div class="news">
                <h3><span><strong>政务</strong>动态</span></h3>
                <table>
                    <tr>
                        <th style="padding-left:5px;">
                            <div id="slide">
                                <ul id="pic">
                                    <li><a href=""><img src="${ctx}/resources/web/image/slide1.jpg"/>

                                        <p>国家发展改革委地区司召开《促进泛珠三角...</p></a></li>
                                    <li><a href=""><img src="${ctx}/resources/web/image/slide2.jpg"/>

                                        <p>国家发展改革委地区司召开《促进泛珠三角...</p></a></li>
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
                        </th>
                        <td>
                            <ul>
                                <c:if test="${zwdtContents != null }">
                                    <li class="first">
                                        <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${zwdtContents.desId}"
                                           title="${zwdtContents.title}">
                                            <c:if test="${fn:length(zwdtContents.title)>16}">${fn:substring(zwdtContents.title,0,16)}...</c:if>
                                            <c:if test="${fn:length(zwdtContents.title)<=16}">${zwdtContents.title}</c:if>
                                        </a>

                                        <p>
                                            <c:if test="${fn:length(zwdtContents.contents)>60}">${fn:substring(zwdtContents.contents,0,55)}...</c:if>
                                            <c:if test="${fn:length(zwdtContents.contents)<=60}">${zwdtContents.contents}</c:if>
                                        </p>
                                    </li>
                                    <c:forEach items="${zwdtContentsList }" var="contents" varStatus="status">
                                        <li>
                                            <a href="${ctx}/web/contentsShow.action?type=zwdt&contentsID=${contents.desId}"
                                               title="${contents.title}">
                                                <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                                <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                            </a>
                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                        </li>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${zwdtContents==null }">
                                    <c:forEach items="${zwdtContentsList }" var="contents" varStatus="status">
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
                        </td>
                    </tr>
                </table>
            </div>

            <div class="clear">
                <a href=""><img src="${ctx}/resources/web/image/1.jpg"/></a>
                <a href=""><img src="${ctx}/resources/web/image/2.jpg"/></a>
                <a href=""><img src="${ctx}/resources/web/image/3.jpg"/></a>
            </div>

            <table>
                <tr>
                    <td style="padding-right:3px;">
                        <div class="border">
                            <h3><i class="ico1"></i><span><strong>政策</strong>法规</span><a href="">+ 更多</a></h3>
                            <ul>
                                <c:forEach items="${zcfgcontentsList}" var="item">
                                    <li>
                                        <a href="${ctx}/web/contentsShow.action?type=xxgk&contentsID=${item.desId}"
                                           title="${item.title }">
                                            <c:if test="${fn:length(item.title)>12}">
                                                ${fn:substring(item.title,0,11)}...
                                            </c:if>
                                            <c:if test="${fn:length(item.title)<=12}">
                                                ${item.title}
                                            </c:if>
                                        </a>
                                        <em>${fn:substring(item.releaseDate,0,10)}</em>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </td>
                    <td style="padding-left:3px;">
                        <div class="border">
                            <h3><i class="ico2"></i><span><strong>业务</strong>公告</span><a href="">+ 更多</a></h3>
                            <ul>
                                 <c:forEach items="${ywggcontentsList}" var="contents" varStatus="status">
                                        <li>
                                            <a href="${ctx}/web/contentsShow.action?type=zwgk&contentsID=${contents.desId}"
                                               title="${contents.title}">
                                                <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                                <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                            </a>
                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                        </li>
                                    </c:forEach>
                             
                           
                            </ul>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="banner"><img src="${ctx}/resources/web/image/adv1.jpg"/></div>
                    </td>
                </tr>
                <tr>

                    <td style="padding-right:3px;">
                        <div class="border">
                            <h3><i class="ico3"></i><span><strong>人事</strong>信息</span><a href="">+ 更多</a></h3>
                            <ul>
                                <c:forEach items="${rsxxcontentList }" var="contents" varStatus="status">
                                        <li>
                                            <a href="${ctx}/web/contentsShow.action?type=rsxx&contentsID=${contents.desId}"
                                               title="${contents.title}">
                                                <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                                <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                            </a>
                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                        </li>
                                    </c:forEach>
                             
                            </ul>
                        </div>
                    </td>
                    <td style="padding-left:3px;">
                        <div class="border">
                            <h3><i class="ico4"></i><span><strong>资料</strong>下载</span><a href="">+ 更多</a></h3>
                            <ul>
                                <li><a href="#">陈绿皮会见潘春青交流我市社会发展情况</a><em>2014-3-6</em></li>
                                <li><a href="#">国际绿色经济协会沙祖康一行来揭考察</a><em>2014-3-6</em></li>
                                <li><a href="#">陈定向：掀起揭阳中区新一化建设热潮</a><em>2014-3-6</em></li>
                                <li><a href="#">我市召开全是组织部长会议署今组织工作</a><em>2014-3-6</em></li>
                                <li><a href="#">朱晓芳高度重视揭阳重的金属生态城建设</a><em>2014-3-6</em></li>
                                <li><a href="#">汕头海关发布以人民币粤东地区外贸数据</a><em>2014-3-6</em></li>
                                <li><a href="#">市侨联向海内外乡亲展示揭阳发展成果</a><em>2014-3-6</em></li>
                                <li><a href="#">市领导空虚经济区调沿业"等高"出谋划策</a><em>2014-3-6</em></li>
                                <li><a href="#">市侨联向海内外乡亲展示揭阳发展成果</a><em>2014-3-6</em></li>
                            </ul>

                        </div>
                    </td>
                </tr>
            </table>

        </div>

        <div class="right">
            <div class="zwgk">
                <h3>政府信息公开</h3>

                <div>
                    <a href=""><img src="${ctx}/resources/web/image/gk1.jpg"/></a>
                    <a href=""><img src="${ctx}/resources/web/image/gk2.jpg"/></a>
                    <a href=""><img src="${ctx}/resources/web/image/gk3.jpg"/></a>
                    <a href=""><img src="${ctx}/resources/web/image/gk4.jpg"/></a>
                </div>
            </div>
            <div class="notice">
                <h3><span>通知公告</span></h3>
                <ul>
                    <c:forEach items="${tzggcontentsList}" var="item">
                        <li>
                            <a href="${ctx}/web/contentsShow.action?type=tzgg&contentsID=${item.desId}"
                               title="${item.title }">
                                <c:if test="${fn:length(item.title)>12}">
                                    ${fn:substring(item.title,0,11)}...
                                </c:if>
                                <c:if test="${fn:length(item.title)<=12}">
                                    ${item.title}
                                </c:if>
                            </a>
                            <em>${fn:substring(item.releaseDate,0,10)}</em>
                        </li>
                    </c:forEach>
                </ul>
            </div>


            <div class="link">
                <h3><span>友情链接</span></h3>

                <div id="marqueeImg">
                    <div id="marqueeBox">
                        <c:forEach items="${picLinksList}" var="item" varStatus="status">
                            <a href="${item.link_url}" target="_blank">
                                <img src="${ctx}/${item.pic_url}" width="195" height="60"/>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
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
        });
    }

    $(document).ready(function () {
//        zttp_dtxg();
//        yqlj_dtxg();
        zmhd_dtxg();
        tpxw_dtxg();
    });
</script>
