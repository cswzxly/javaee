<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%
    String path = request.getContextPath();
    String domain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
    String basePath = domain + path;
    pageContext.setAttribute("ctx", path);
%>
<link type="text/css" rel="stylesheet" href="${ctx}/resources/web/style/style.css"/>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.focus.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.focus.min.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.tabs.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.global.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.corner.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.roundabout.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.roundabout-shapes.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/layPage/laypage.js"></script>


<div class="header">
    <div class="clear">
        <table>
            <tr>
                <td>
                    <span id="www_zzjs_net">2015-06-11 17:17:26  星期四</span>
                </td>
                <td align="right">
                    <img src="${ctx}/resources/web/image/home.png" height="17px">
                    <a href="#"
                       onclick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.gd-jygt.gov.cn');"
                       style="CURSOR: hand;text-align:left; color: #000000; font-size:12px">设为首页</a>&nbsp;&nbsp;
                    <img src="${ctx}/resources/web/image/book.png" height="17px">
                    <a href="#" style="CURSOR: hand;text-align:left; color:  #000000; font-size:12px"
                       onclick="window.external.addFavorite('http://www.gd-jygt.gov.cn','揭阳市国土资源局')"
                       title="揭阳市国土资源局">收藏本站</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="inner">
        <div class="logo"></div>
        <div class="nav">
            <ul>
                <li class="current"><a href="${ctx}">网站首页</a></li>
                <li><a href="${ctx}/web/areaInfoList.action?type=zwgk&catalogID=9">政务公开</a></li>
                <li><a href="${ctx}/web/areaInfoMainList.action?type=xxgk&catalogID=203">信息公开</a></li>
                <li><a href="${ctx}/web/areaInfoList.action?type=zwgk&catalogID=68">通知通报</a></li>
                <li><a href="${ctx}/web/areaInfoMainList.action?type=ywgg&catalogID=180">业务公告</a></li>
                <li><a href="">网上办事</a></li>
                <li><a href="areaInfoList.action?type=zlxz&catalogID=128">资料下载</a></li>
                <li><a href="${ctx}/web/areaInfoList.action?type=xxgk&catalogID=208">投诉监督</a></li>
            </ul>
        </div>
        <div class="date">
            <table>
                <tr>
                    <td width="600">
                        <marquee width="600px" height="20px" scrollamount="3" direction="left"
                                 style="font-size: 12px; color: rgb(0, 0, 0); height: 20px; width: 570px;"
                                 onmouseover="this.stop();" onmouseout="this.start();">
                            <a href="" title="珍惜土地资源  节约集约用地">珍惜土地资源节约集约用地</a></marquee>
                    </td>
                    <td class="search">
                        <form>
                            <input type="text" class="search_text" placeholder="请输入关键字"/>
                            <input type="submit" class="search_btn" value="搜索"/>
                        </form>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<script>
    //    时间日期
    function showLocale(objD) {
        var str, colorhead, colorfoot;
        var yy = objD.getYear();
        if (yy < 1900) yy = yy + 1900;
        var MM = objD.getMonth() + 1;
        if (MM < 10) MM = '0' + MM;
        var dd = objD.getDate();
        if (dd < 10) dd = '0' + dd;
        var hh = objD.getHours();
        if (hh < 10) hh = '0' + hh;
        var mm = objD.getMinutes();
        if (mm < 10) mm = '0' + mm;
        var ss = objD.getSeconds();
        if (ss < 10) ss = '0' + ss;
        var ww = objD.getDay();

        if (ww == 0)  ww = "星期日";
        if (ww == 1)  ww = "星期一";
        if (ww == 2)  ww = "星期二";
        if (ww == 3)  ww = "星期三";
        if (ww == 4)  ww = "星期四";
        if (ww == 5)  ww = "星期五";
        if (ww == 6)  ww = "星期六";
        colorfoot = "</font>"
        str = yy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss + "  " + ww;
        return (str);
    }
    function tick() {
        var today;
        today = new Date();
        document.getElementById("www_zzjs_net").innerHTML = showLocale(today);
        window.setTimeout("tick()", 1000);
    }
    tick();
</script>
