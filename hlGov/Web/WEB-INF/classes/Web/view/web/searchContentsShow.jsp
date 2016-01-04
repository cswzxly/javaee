<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>惠来县人民政府门户网站</title>

</head>

<body>
<%@include file="../web/head.jsp" %>

<div class="wrapper">
	<div class="inner">
    	<div class="side">
			<div class="submenu">
			    <a href="http://www.hlwb.gov.cn/wsdt/" target="_blank"><img src="${ctx}/resources/web/image/pic.jpg" width="240" height="80" /></a>
			</div>
			<div class="so">
                <form action="${ctx}/web/searchList.action" method="post">
                <input type="text" name="title" class="text" value="${title }"/>
                <input type="submit" class="submit" />
                </form>        
            </div> 
		</div>
        <div class="main">
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b>搜索结果</b></div>
        	<div class="article">
            	<div class="tit">${contents.title }</div>
            	<c:if test="${tableName=='t_contents' }">
            		<div class="subtit">${contents.secTitle }</div>
            	</c:if>
            	<div class="data">来源：${contents.source }&nbsp;&nbsp;&nbsp;发布时间：${contents.releaseDate}</div>
            	
                <div class="pic">
                    <c:if test="${fn:length(picList)>0 }">
                    <script language="JavaScript" type="text/javascript">
                    var currentPicIndex = 0;
                    var maxPicIndex = ${fn:length(picList)-1};//${pm.total }-1
                    var urlArr = new Array();
                    <c:forEach items="${picList }" var="newsPicTmp" varStatus="itemTmp">
                        urlArr[${itemTmp.index }] = "${ctx}/${newsPicTmp.fileUrl }";
                    </c:forEach>
                    function showNextPic() {
                        currentPicIndex++;
                        showPage(currentPicIndex);
                    }
                    
                    function isIe() {
                        return (document.all)?true:false;
                    }
                    
                    function showPage(index) {
                        if(index<0 || index>(maxPicIndex+1)) {
                            return;
                        }
                        if(index==(maxPicIndex+1)) {
                            var obj = document.getElementById('news_pic');
                            var promptWidth = 250;
                            var promptHeight = 60;
                            var promptTop = parseInt((obj.clientHeight-promptHeight)/2);
                            var promptLeft = obj.offsetLeft+parseInt((obj.clientWidth-promptWidth)/2)-parseInt(obj.parentNode.style.paddingLeft);
                            var styleStr="border:3px solid #999;top:"+promptTop+"px;left:"+promptLeft+"px;position:relative;background:#FFF;width:"+promptWidth+"px;height:"+promptHeight+"px;";
                            styleStr+=(isIe())?"filter:alpha(opacity=80);":"opacity:80;";
                            document.getElementById('news_pic_last').style.display = "";
                            document.getElementById('news_pic_last').style.cssText=styleStr;
                            return;
                        }
                        currentPicIndex = index;
                        var obj = document.getElementById('news_pic');
                        obj.src = urlArr[currentPicIndex];
                        obj.style.display = "";
                        document.getElementById('news_pic_last').style.display = "none";
                        document.getElementById('news_pic_page').innerHTML = initPageUrl();
                    }
                    function initPageUrl() {
                        var showPageSize = 12;
                        var showPageTotal = parseInt(maxPicIndex/showPageSize);
                        var showPageIndex = parseInt(currentPicIndex/showPageSize);
                        var urlText = "";
                        urlText += "共${fn:length(picList)}页&nbsp;";
                        urlText += "<a href='javascript:void(0);' onclick='showPage(0)'>首页</a>&nbsp;";
                        urlText += "<a href='javascript:void(0);' onclick='showPage(" + (currentPicIndex-1) + ")'>上一页</a>&nbsp;";
                        for(var i=0; i<showPageSize; i++) {
                            var pageIndex = showPageIndex*showPageSize+i;
                            if(pageIndex>maxPicIndex) {
                                break;
                            }
                            if(pageIndex==currentPicIndex) {
                                urlText += "<font class='FB cRed' >" + (pageIndex+1) + "</font>&nbsp;";
                            } else {
                                urlText += "<a href='javascript:void(0);' onclick='showPage(" + pageIndex + ")'>" + (pageIndex+1) + "</a>&nbsp;";
                            }
                        }
                        urlText += "<a href='javascript:void(0);' onclick='showPage(" + (currentPicIndex+1) + ")'>下一页</a>&nbsp;";
                        urlText += "<a href='javascript:void(0);' onclick='showPage(" + maxPicIndex + ")'>末页</a>&nbsp;";
                        return urlText;
                    }
                    </script>
                    <div>点击图片进入下一页 </div>
                    <div style="width:256px; margin:0 auto; height:0px;">
                        <div id="news_pic_last" style="display:none;">
                            已经是<a href='javascript:void(0);' onclick='showPage(${fn:length(picList)-1 })'>最后一页</a> 
                            <a href='javascript:void(0);' onclick='showPage(0)'>重新浏览</a>
                        </div>
                    </div>
                    <div><img id="news_pic" src="${ctx}/${picList[0].fileUrl }" style="cursor:pointer;width:100%;height:auto" onclick="showNextPic()"></div>
                    <div id="news_pic_page">
						<script language="JavaScript" type="text/javascript">
                        document.write(initPageUrl());
                        </script>
                    </div>  
                    </c:if>
                </div>   
                
            	<div class="cont">${contents.contents }</div>
                <c:if test="${fn:length(fileList)>0}">
                	<div class="add">
                	<ul>
                    附件（点击下载）：<br/>
                    <c:forEach items="${fileList}" var="item" varStatus="status">
                        ${status.index+1 }、<a href="${ctx}/web/download.action?theID=${item.theID}">${item.title}</a><br/>
                    </c:forEach>
                	</ul>
                	</div>
                </c:if>
            </div>
        	                               
        </div>
    </div>
</div>
<%@include file="../web/foot.jsp" %>
</body>
</html>



