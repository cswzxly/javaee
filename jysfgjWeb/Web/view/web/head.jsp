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
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.tabs.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/jquery.global.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/layPage/laypage.js"></script>

<div class="header">
	<div class="clear">
        <table>
        <tr>
        <td>
            <span id="www_zzjs_net">2015-06-11 17:17:26  星期四</span>
            <script type="text/javascript">
            function showLocale(objD)
            {
            var str,colorhead,colorfoot;
            var yy = objD.getYear();
            if(yy<1900) yy = yy+1900;
            var MM = objD.getMonth()+1;
            if(MM<10) MM = '0' + MM;
            var dd = objD.getDate();
            if(dd<10) dd = '0' + dd;
            var hh = objD.getHours();
            if(hh<10) hh = '0' + hh;
            var mm = objD.getMinutes();
            if(mm<10) mm = '0' + mm;
            var ss = objD.getSeconds();
            if(ss<10) ss = '0' + ss;
            var ww = objD.getDay();
            
            if  (ww==0)  ww="星期日";
            if  (ww==1)  ww="星期一";
            if  (ww==2)  ww="星期二";
            if  (ww==3)  ww="星期三";
            if  (ww==4)  ww="星期四";
            if  (ww==5)  ww="星期五";
            if  (ww==6)  ww="星期六";
            colorfoot="</font>"
            str = yy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss + "  " + ww;
            return(str);
            }
            function tick()
            {
            var today;
            today = new Date();
            document.getElementById("www_zzjs_net").innerHTML = showLocale(today);
            window.setTimeout("tick()", 1000);
            }
            tick();
            </script>    
        </td>
        <td align="right">
          <img src="${ctx}/resources/web/image/home.png" height="17px"><a href="#" onclick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.gd-jygt.gov.cn');" style="CURSOR: hand;text-align:left; color: #000000; font-size:12px">设为首页</a>&nbsp;&nbsp;
      <img src="${ctx}/resources/web/image/book.png" height="17px"><a href="#" style="CURSOR: hand;text-align:left; color:  #000000; font-size:12px" onclick="window.external.addFavorite('http://www.gd-jygt.gov.cn','揭阳市国土资源局')" title="揭阳市国土资源局">收藏本站</a>
        </td>
        </tr>
        </table>
    	
    </div>
    <div class="inner">
        <div class="logo"><img src="${ctx}/resources/web/image/head.jpg"/></div>
        <div class="nav">
            <ul id="nav">
                <li class="hover"><a href="${ctx}/" target="_blank">网站首页</a>
                    <ul>
                        <li>欢迎光揭阳市发展和改革委员会门户网站</li>
                    </ul>
                </li>
                <li>
                    <span><a href="${ctx}/web/govpubPage.action" target="_blank">政务公开</a></span>
                    <ul>
<!--                         <li><a href="http://zwgk.jykgjjq.gov.cn/" target="_blank">信息公开</a>|</li> -->
<!--                         <li><a href="http://zwgk.jykgjjq.gov.cn/xxgk/jsp/front/front_ysqgklc.jsp" -->
<!--                                target="_blank">公开流程</a>| -->
<!--                         </li> -->
<!--                         <li><a href="http://ysq.jykgjjq.gov.cn/" target="_blank">申请公开</a>|</li> -->
<!--                         <li><a href="http://yjx.jykgjjq.gov.cn/" target="_blank">公开意见</a>|</li> -->
<!--                         <li><a href="http://zdly.jykgjjq.gov.cn/zdly/index.action" target="_blank">重点领域</a>|</li> -->
<!--                         <li><a href="http://xxgk.jieyang.gov.cn/index.shtml?level=2&regionID=9" target="_blank">工程公开</a> -->
<!--                         </li> -->
						<c:forEach items="${sessionScope.catalogList }" var="item">
                            <c:if test="${item.isFirstCatalog!=1 && item.parentID==174}">
                            	<c:if test="${item.catalogType=='t_links' }">
                                	<li><a href="${item.url }" target="_blank">${item.title }</a>|</li>
                                </c:if>
                                <c:if test="${item.catalogType!='t_links' }">
                                	<li><a href="${ctx}${item.url}">${item.title }</a>|</li>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </ul>
                </li>
                <li>
                    <span><a href="${ctx}/web/workPage.action" target="_blank">发展改革工作</a></span>
                    <ul>
                        <c:forEach items="${sessionScope.catalogList }" var="item">
                            <c:if test="${item.isFirstCatalog!=1 && item.parentID==1}">
                                <li><a href="${ctx}${item.url}">${item.title }</a>|</li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </li>
                <li>
                    <span><a href="http://wsbs.jieyang.gov.cn/wsdt/service?deptID=007026393&zone=jy&pid=0000" target="_blank">网上办事</a></span>
                    
                </li>
                <li>
                    <span><a href="${ctx }/web/frontContentsPage.action" target="_blank">政民互动</a></span>
                    <ul>
                        <li><a href="${ctx}/web/front_letterRight.action?flag=1" target="_blank">局长信箱</a>|</li>
                        <li><a href="${ctx}/web/front_letterRight.action?flag=2" target="_blank">业务咨询</a>|</li>
                        <li><a href="${ctx}/web/front_letterRight.action?flag=3" target="_blank">监督投诉</a>|</li>
                        <li><a href="${ctx}/web/front_queryContentsList.action">建言献策</a>|</li>
                        <li>&nbsp;价格服务热线12358&nbsp;|</li>
                        <!-- 	            <li><a id=StranLink href="" name=StranLink>繁体中文</a></li> -->
                    </ul>
                </li>
                <li>
                    <span><a href="${ctx }/web/areaInfoList.action?type=contents&catalogID=128" target="_blank">资料下载</a></span>
                    
                </li>
            </ul>
            <div class="search">
                <form>
                    <input type="text" class="search_text" placeholder="请输入关键字"/>
                    <input type="submit" class="search_btn" value="搜索"/>
                </form>
            </div>
        </div>


    </div>
</div>

<!--script type="text/javascript">
    // 设置为主页
    function SetHome(obj, vrl) {
        try {
            obj.style.behavior = 'url(#default#homepage)';
            obj.setHomePage(vrl);
        }
        catch (e) {
            if (window.netscape) {
                try {
                    netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                }
                catch (e) {
                    alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
                }
                var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                prefs.setCharPref('browser.startup.homepage', vrl);
            } else {
                alert("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入：" + vrl + "点击确定。");
            }
        }
    }
    // 加入收藏 兼容360和IE6
    function shoucang(sTitle, sURL) {
        try {
            window.external.addFavorite(sURL, sTitle);
        }
        catch (e) {
            try {
                window.sidebar.addPanel(sTitle, sURL, "");
            }
            catch (e) {
                alert("加入收藏失败，请使用Ctrl+D进行添加");
            }
        }
    }
</script--> 
