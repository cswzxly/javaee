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
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.time.js"></script>
<script type="text/javascript" src="${ctx}/resources/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="${ctx}/resources/web/js/layPage/laypage.js"></script>
<div class="header">
	<div class="inner">
	
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="1000" height="191" id="top" align="middle">
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="allowFullScreen" value="false" />
			<param name="movie" value="${ctx}/resources/web/image/top.swf" /><param name="quality" value="high" /><param name="wmode" value="transparent" /><param name="bgcolor" value="#ffffff" />	<embed wmode="transparent" src="${ctx}/resources/web/image/top.swf" quality="high" bgcolor="#ffffff" width="1000" height="191" name="index_header" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer_cn" />
		</object>

        <div class="nav" id="nav">
            <ul>
            <li><span><a href="${ctx}/web/index.action">网站首页</a></span>
            	<ul>
                <li><script>time()</script></li>
                </ul>
            </li>
            <li><span><a href="${ctx}/web/areaInfoPage.action" target="_blank">走进惠来</a></span>
                <ul>
                <c:forEach items="${sessionScope.catalogList }" var="item">
                    <c:if test="${item.isFirstCatalog!=1 }" >
                        <li><a href="${ctx}${item.url}" target="_blank">${item.title }</a>|</li>
                    </c:if>
                </c:forEach>      
                </ul>      
            </li>
            <li><span><a href="${ctx }/web/frontOpenCatalogPage.action" target="_blank">政务公开</a></span>
                <ul>
                <li><a href="${ctx }/web/frontOpenCatalogPage.action" target="_blank">信息公开</a>|</li>
                <li><a href="http://zdly.huilai.gov.cn/front/index.action" target="_blank">重点领域</a>|</li>
<%--                 <li><a href="${ctx }/web/frontZlCatalogPage.action?theID=34" target="_blank">领导之窗</a>|</li> --%>
<%--                 <li><a href="${ctx }/web/frontZlCatalogPage.action?theID=36" target="_blank">政府文件</a>|</li> --%>
<%--                 <li><a href="${ctx }/web/frontZlCatalogPage.action?theID=36" target="_blank">政府公报</a>|</li> --%>
<%--                 <li><a href="${ctx }/web/frontZlCatalogPage.action?theID=46" target="_blank">招标信息</a></li>  --%>
                
                </ul>                
            </li>
            <li><span><a href="http://www.hlwb.gov.cn/wsdt/" target="_blank">网上服务</a></span>
                <ul>
                <li><a href="http://www.hlwb.gov.cn/wsdt/byDept" target="_blank">部门服务</a>|</li>
                <li><a href="http://www.hlwb.gov.cn/wsdt/category?type1=2&type2=1" target="_blank">企业办事</a>|</li>
                <li><a href="http://www.hlwb.gov.cn/wsdt/category?type1=1&type2=1" target="_blank">市民办事</a></li>   
                </ul>            
            </li>
            <li><span><a href="${ctx }/web/front_queryContentsList.action?flag=now" target="_blank">政民互动</a></span>
                <ul>
                <li><a href="${ctx }/web/front_queryContentsList.action?flag=now" target="_blank">民意征集</a>|</li>
                <li><a href="${ctx}/web/front_letterRight.action?flag=1" target="_blank">县长信箱</a>|</li>
                <li><a href="${ctx}/web/front_letterRight.action?flag=2" target="_blank">我要写信</a>|</li>
                <li><a href="${ctx}/web/front_letterRight.action?flag=3" target="_blank">我要建议</a>|</li>
                <li><a href="${ctx}/web/front_querySurveyListDetail.action?index=1" target="_blank">网上调查</a></li>  
                </ul>          
            </li>
            </ul>
            <div class="weather">
            <iframe width="450" scrolling="no" height="18" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=1&color=%23000000&icon=1&py=huilai&wind=1&num=2"></iframe>
            </div>
        	<div class="so">
                <form action="${ctx}/web/searchList.action" method="post">
                <input type="text" name="title" class="text" value="${title }"/><input type="submit" class="submit" />
                </form>        
            </div>                         
        </div>    

		<script>
        function startList(id) {
            //if (window.ActiveXObject&&!window.XMLHttpRequest) {
                var navRoot = document.getElementById(id).getElementsByTagName('UL')[0];
                for (i=0; i<navRoot.childNodes.length; i++) {
                    var node = navRoot.childNodes[i];
                    if (node.nodeName=="LI") {
                        node.onmouseover=function(){this.className+=" now";}
                        node.onmouseout=function(){this.className=this.className.replace(" now", "");}
                    }
                }
            //}
        }
        startList("nav");

        </script>       
	</div>	
</div>

