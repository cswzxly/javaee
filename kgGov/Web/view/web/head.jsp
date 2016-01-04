<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg"%>
<%
    String path=request.getContextPath();
    String domain=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath=domain+path;
    pageContext.setAttribute("ctx",path);
%>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/web/style/style.css" />
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.js"></script>
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.tabs.js"></script>
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.global.js"></script>
<script type="text/javascript" src="${ctx}/resources/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.focus.js"></script>
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.focus.min.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/layPage/laypage.js"></script>

<div class="header">


    <div class="inner" style=" overflow:visible;">
	<div class="clear">
            <div class="fl">
                <a id=StranLink href="" name=StranLink style="float:left;">简体中文</a>
                <script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/tran.js"></script>
                <span id="changbg">
                <i style="background:red;">red</i>
                <i style="background:green;">green</i>
                <i style="background:yellow;">yellow</i>
                <i style="background:#3155AB;">blue</i>
                </span>
            </div>
            <div class="fr"><a href="${ctx}/">网站首页</a>
            <a href="javascript:void(0)" onclick="SetHome(this,window.location)">设为首页</a>
            <a href="javascript:void(0)" onclick="shoucang(document.title,window.location)">加入收藏</a>
            </div>
    </div>    
    
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="1000" height="230" id="top" align="middle">
            <param name="allowScriptAccess" value="sameDomain" />
            <param name="allowFullScreen" value="false" />
            <param name="movie" value="${ctx}/resources/web/image/head.swf" />
            <param name="quality" value="high" />
            <param name="wmode" value="transparent" /><param name="bgcolor" value="#ffffff" />	
            <embed wmode="transparent" src="${ctx}/resources/web/image/head.swf" quality="high" bgcolor="#ffffff" width="1000" height="230" name="index_header" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer_cn" />
        </object>       
        <div class="nav">
        <ul id="menu">
        	<li><span><a href="${ctx}/" target="_blank">网站首页</a></span></li>
            <li>
                <span><a href="${ctx}/web/areaInfoPage.action" target="_blank">走进空港</a></span>
                <ul>
                <c:forEach items="${sessionScope.catalogList }" var="item">
                    <c:if test="${item.isFirstCatalog!=1 }" >
                        <li><a href="${ctx}${item.url}">${item.title }</a>|</li>
                    </c:if>
                </c:forEach>      
                </ul>             
            </li>
            <li>
                <span><a href="http://zwgk.jykgjjq.gov.cn/" target="_blank">政务公开</a></span>
                <ul>
	            <li><a href="http://zwgk.jykgjjq.gov.cn/" target="_blank">信息公开</a>|</li>
	            <li><a href="http://zwgk.jykgjjq.gov.cn/xxgk/jsp/front/front_ysqgklc.jsp" target="_blank">公开流程</a>|</li>
	            <li><a href="http://ysq.jykgjjq.gov.cn/" target="_blank">申请公开</a>|</li>
	            <li><a href="http://yjx.jykgjjq.gov.cn/" target="_blank">公开意见</a>|</li>
	            <li><a href="http://zdly.jykgjjq.gov.cn/zdly/index.action" target="_blank">重点领域</a>|</li>
	            <li><a href="http://xxgk.jieyang.gov.cn/index.shtml?level=2&regionID=9" target="_blank">工程公开</a></li>
                </ul>              
            </li>
            <li>
                <span><a href="http://wsbs.jykgjjq.gov.cn/wsdt/category" target="_blank">网上办事</a></span>
                <ul>
	            <li><a href="http://wsbs.jykgjjq.gov.cn/wsdt/byDept" target="_blank">部门服务</a>|</li>
	            <li><a href="http://wsbs.jykgjjq.gov.cn/wsdt/category?type1=2&type2=1" target="_blank">企业办事</a>|</li>
	            <li><a href="http://wsbs.jykgjjq.gov.cn/wsdt/category?type1=1&type2=1" target="_blank">个人办事</a>|</li>
	            <li><a href="http://wsbs.jykgjjq.gov.cn/wsdt/byStreet" target="_blank">街道办事</a>|</li>
	            <li><a href="http://wsbs.jykgjjq.gov.cn/wsdt/tzsp" target="_blank">投资审批</a>|</li>
	            <li><a href="http://wsbs.jykgjjq.gov.cn/wsdt/xnjc?type=1" target="_blank">效能监察</a></li>
                </ul>           
            </li>
            <li>
                <span><a href="${ctx }/web/frontContentsPage.action" target="_blank">政民互动</a></span>
                <ul>
	            <li><a href="http://xf.jykgjjq.gov.cn" target="_blank">网上信访</a>|</li>
	            <li><a href="http://xf.jykgjjq.gov.cn/web/notice.jsp?subtype=quzhang" target="_blank">区长信箱</a>|</li>
	            <li><a href="${ctx }/web/front_queryContentsList.action">民意征集</a>|</li>
	            <li><a href="http://xf.jykgjjq.gov.cn/web/notice.jsp" target="_blank">我要写信</a>|</li>
	            <li><a href="http://xf.jykgjjq.gov.cn/web/visitSearch.jsp" target="_blank">信访查询</a>|</li>
	            <li><a href="${ctx}/web/front_querySurveyListDetail.action?index=1">网上调查</a></li>
<!-- 	            <li><a id=StranLink href="" name=StranLink>繁体中文</a></li> -->
                </ul>          
            </li>
        </ul>
        </div>  

		<table class="other">
        <tr>
        <th>
        <iframe width="650" scrolling="no" height="18" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=1&icon=1&py=jieyang&wind=1&num=2"></iframe>
        </th>
        <td>
            <div class="so">
                <form action="${ctx}/web/searchList.action" method="post">
                <input type="text" name="title" class="text" value="${title }"/><input type="submit" class="submit" />
                </form>         
            </div>          
        </td>
        </tr>
        </table>
                       
    </div> 
</div>

<script>
$(function(){
	var $menu = $('#menu');
	$menu.children('li').each(function(){
		var $this = $(this);
		$this.bind('mouseenter',function(){
			$menu.find('ul').stop(true,true).hide();
			$this.find('ul').show();
		}).bind('mouseleave',function(){
			$this.find('ul').stop(true,true).hide();
		});
	});
	
	$("#changbg i").click(function(){
		$("body").css({"background-image": "url(${ctx}/resources/web/image/"+$(this).html()+"bg.jpg)" })
	})
})
</script>


<script type="text/javascript"> 
// 设置为主页 
function SetHome(obj,vrl){ 
try{ 
obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl); 
} 
catch(e){ 
if(window.netscape) { 
try { 
netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect"); 
} 
catch (e) { 
alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。"); 
} 
var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch); 
prefs.setCharPref('browser.startup.homepage',vrl); 
}else{ 
alert("您的浏览器不支持，请按照下面步骤操作：1.打开浏览器设置。2.点击设置网页。3.输入："+vrl+"点击确定。"); 
} 
} 
} 
// 加入收藏 兼容360和IE6 
function shoucang(sTitle,sURL) 
{ 
try 
{ 
window.external.addFavorite(sURL, sTitle); 
} 
catch (e) 
{ 
try 
{ 
window.sidebar.addPanel(sTitle, sURL, ""); 
} 
catch (e) 
{ 
alert("加入收藏失败，请使用Ctrl+D进行添加"); 
} 
} 
} 
</script> 
