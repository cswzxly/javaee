<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content="揭阳空港经济区；广东揭阳空港经济区；揭阳空港经济区揭阳空港；广东揭阳空港经济区门户网站；揭阳空港经济区门户网站；揭阳空港门户网站；揭阳市空港经济区门户网站"/>
    <meta content="广东揭阳空港经济区；揭阳空港经济区揭阳空港；揭阳市空港经济区；广东揭阳空港经济区门户网站；揭阳空港经济区门户网站；揭阳空港门户网站；揭阳市空港经济区门户网站" name="description"/>
    <title>揭阳空港经济区</title>
</head>
<body class="index">
<%@include file="../web/head.jsp" %>

  
<div class="wrapper">
    <div class="inner">

		

        <!-- <div class="banner"><a href="javascript:void(0)" onclick="openwindow(9);"><img src="${ctx}/uploads/system/titlepic/7.jpg"/></a></div>    
        <div class="banner"><a href="javascript:void(0)" onclick="openwindow(10);"><img src="${ctx}/uploads/system/titlepic/10.jpg"/></a></div>
        <div class="banner"><a href="javascript:void(0)" onclick="openwindow(7);"><img src="${ctx}/uploads/system/titlepic/7.jpg"/></a></div-->
        <div class="news">        
            <div class="left">
                <div id="barNews">
                    <ul>
                        <c:forEach items="${focusList}" var="e">
                            <li><a href="${ctx}/web/contentsShow.action?type=news&contentsID=${e.desId}" title="${e.title}">${e.title}</a></li>
                        </c:forEach>
                    </ul>
                </div>          
                <script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.scroll.js"></script>
                <script type="text/javascript">
                    $(function () {
                        $("#barNews").Scroll({line: 1, speed: 500, timer: 4000, up: "btn_up", down: "btn_down"});
                    });
                </script>              
                <table>
                <tr>
                    <th>
                    <div id="focus">  
                        <ul id="pic">  
                            <c:forEach items="${picIndexList}" var="item" varStatus="status">
                                <li>
                                    <a target="_blank" href="${ctx}/web/contentsShow.action?type=news&contentsID=${item.desId}"><img src="${ctx}/${item.fileUrl}" title="${item.title}"/></a>
                                    <span>${fn:substring(item.title, 0, 14)}</span>
                                </li>
                            </c:forEach>         
                        </ul>
                        <div id="num">  
                            <c:forEach items="${picIndexList}" var="item" varStatus="status">
                            <a href="javascript:void(0)" hidefocus="true" target="_self">${status.count}</a>
                            </c:forEach>                    
                        </div>    
                    </div>  
                    <script type="text/javascript">
                    Qfast(false, 'widgets', function () {
                        K.tabs({
                            id: 'focus',   //焦点图包裹id  
                            conId: "pic",  //** 大图域包裹id  
                            conTn:"li", 						
                            tabId:"num",  
                            tabTn:"a",
                            auto: 1,   //自动播放 1或0
                            effect: 'fade',   //效果配置
                            eType: 'mouseover', //** 鼠标事件
                            pageBt:'false'//是否有按钮切换页码
                        }) 
                    })  
                    </script>                                 
                    </th>
                    <td>
                    <div class="tab newstab">
                        <ul class="tab_menu">
                            <li class="current"><a href="${ctx}/web/areaInfoList.action?type=news&catalogID=10">${catalog10.title}</a></li>
                            <li><a href="${ctx}/web/areaInfoList.action?type=news&catalogID=43">${catalog43.title}</a></li>
                            <li><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=49">${catalogVideo.title}</a></li>
                        </ul>
                        <div class="tab_content">
                            <ul>
                                <c:if test="${contents10 != null }">
                                    <li class="topic">
                                        <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents10.theID}" title="${contents10.title}">
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
                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}" title="${contents.title}">
                                                <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                                <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                            </a>
                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                        </li>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${contents10==null }">
                                    <c:forEach items="${contents10List }" var="contents" varStatus="status">
                                        <li>
                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}" title="${contents.title}">
                                                <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                                <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                            </a>
                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                        </li>
                                    </c:forEach>
                                </c:if>
                            </ul>
                            
                            <ul class="hide">
                                <c:if test="${contents43 != null }">
                                     <li class="topic">
                                        <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents43.desId}" title="${contents43.title}">
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
                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}" title="${contents.title}">
                                                <c:if test="${fn:length(contents.title)>22}">${fn:substring(contents.title,0,22)}...</c:if>
                                                <c:if test="${fn:length(contents.title)<=22}">${contents.title}</c:if>
                                            </a>
                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                        </li>
                                    </c:forEach>                           
    
                                </c:if>
                                <c:if test="${contents43 == null }">
                                    <c:forEach items="${contents43List }" var="contents" varStatus="status">	 
                                        <li>
                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.desId}" title="${contents.title}">
                                                <c:if test="${fn:length(contents.title)>21}">${fn:substring(contents.title,0,21)}...</c:if>
                                                <c:if test="${fn:length(contents.title)<=21}">${contents.title}</c:if>
                                            </a>
                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                        </li>
                                    </c:forEach>
                                </c:if>
                            </ul>
                            <ul class="hide">
                                <c:forEach items="${videoList }" var="video" varStatus="status">
                                    <li>
                                        <a href="${ctx}/web/videoShow.action?type=news&videoID=${video.desId}" title="${video.title}">
                                            <c:if test="${fn:length(video.title)>21}">${fn:substring(video.title,0,21)}...</c:if>
                                            <c:if test="${fn:length(video.title)<=21}">${video.title}</c:if>
                                        </a>
                                        <em>${fn:substring(video.releaseDate,0,10)}</em>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>                    
                    </td>
                </tr>
                </table>
                
                <div class="banner"><a href="javascript:void(0)" onclick="openwindow(7);"><img src="${ctx}/uploads/system/titlepic/7.jpg"/></a></div>
                <table>
                <tr>
                	<td style="padding:0; width:380px"><div class="banner"><a href="javascript:void(0)" onclick="openwindow(8);"><img src="${ctx}/uploads/system/titlepic/8.jpg" style="height:60px;"/></a></div></td>
                    <td style="padding:0;"><div class="banner"><a href="javascript:void(0)" onclick="openwindow(9);"><img src="${ctx}/uploads/system/titlepic/9.jpg" style="height:60px;"/></a></div></td>
                </tr>
                </table>
            </div>
            
            
            <div class="right">   
                <div class="banner" style="margin:0;"><a href="http://wsbs.jykgjjq.gov.cn/" target="_blank"><img src="${ctx}/resources/web/image/pic.jpg" width="240" height="80"/></a></div>
                <div class="twocode">
                    <div class="banner"><img src="${ctx}/resources/web/image/twocode.jpg" width="243" height="78"/></div>
                </div>
                <div class="notice">
                    <h3><span>通知公告</span><a href="${ctx}/web/areaInfoList.action?type=announcement&catalogID=68">更多 >></a></h3>
                    <ul>
                        <c:forEach items="${contents68List }" var="item">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.desId}" title="${item.title }">
                                    <c:if test="${fn:length(item.title)>15}">
                                        ${fn:substring(item.title,0,15)}...
                                    </c:if>
                                    <c:if test="${fn:length(item.title)<=15}">
                                        ${item.title}
                                    </c:if>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
		


        <div class="left">
            <table>
            <tr>
                <th>
                <div class="box xxgk">
                    <h3><span>政府信息公开专栏</span></h3>
                    <ul>
                        <li>
                            <a href="http://zwgk.jykgjjq.gov.cn" target="_blank">政府信息公开目录</a>
                        </li>
                        <li>
                            <a href="http://ysq.jykgjjq.gov.cn/xxgk/showDeptType.action?flag=1" target="_blank">政府信息依申请公开</a>
                        </li>
                        <li>
                            <a href="http://yjx.jykgjjq.gov.cn/xxgk/jsp/front/front_suggest_main.jsp" target="_blank">政府信息公开意见箱</a>
                        </li>
                        <li>
                            <a href="http://zwgk.jykgjjq.gov.cn/xxgk/jsp/front/front_ysqgklc.jsp" target="_blank">依申请公开流程</a>
                        </li>
                    </ul>
                </div>     
                <div class="box zdly">
                    <h3><span>重点领域</span></h3>
                    <ul>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=xzsp">行政审批</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=czys">财政信息</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=czsj">财政审批</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=bzxzf">住房保障</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=spypaq">食品药品</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=hjbh">安全环境保护</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=scaq">生产安全</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=zd">征地拆迁</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=jgysf">价格和收费</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=fwzsbc">房屋征收补偿</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=ylwsjg">医疗卫生机构</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=kjgl">科技和项目经费</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=whjg">文化机构</a></li>
                        <li><a href="http://zdly.jykgjjq.gov.cn/zdly/openInfo.action?depFlag=gyqy">国有企业</a></li>
                    </ul>
                </div>             
                </th>
                <td>
                <div class="tab tab1">
                    <ul class="tab_menu">
                        <%--<li>政府公报</li>--%>
                        <li class="current"><a href="${ctx}/web/areaInfoList.action?type=&catalogID=171">重大项目</a></li>
                        <li><a href="${ctx}/web/areaInfoList.action?type=&catalogID=172">人事信息</a></li>
                    </ul>
                    <div class="tab_content">
                    <%--<ul class="hide">--%>
                        <%--<c:forEach items="${zfgbContents }" var="list">--%>
                            <%--<li>--%>
                                <%--<a href="${ctx }/web/frontOpenCatalogPage.action?theID=${list.theID}&flag=1" title="${list.title}">--%>
                                    <%--<c:if test="${fn:length(list.title)>21 }">${fn:substring(list.title,0,21)}...</c:if>--%>
                                    <%--<c:if test="${fn:length(list.title)<=21 }">${list.title}</c:if>--%>
                                <%--</a>--%>
    <%----%>
                            <%--</li>--%>
                        <%--</c:forEach>--%>
                    <%--</ul>--%>
                    <ul>
                        <c:forEach items="${content171List }" var="list">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?contentsID=${list.desId}" title="${list.title}">
                                    <c:if test="${fn:length(list.title)>30 }">${fn:substring(list.title,0,28)}...</c:if>
                                    <c:if test="${fn:length(list.title)<=30 }">${list.title}</c:if>
                                </a>
                                <em>${fn:substring(list.releaseDate,0,10)}</em>
                            </li>
                        </c:forEach>
                    </ul>
                    <ul class="hide">
                        <c:forEach items="${content172List }" var="list">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?contentsID=${list.desId}" title="${list.title}">
                                    <c:if test="${fn:length(list.title)>30 }">${fn:substring(list.title,0,28)}...</c:if>
                                    <c:if test="${fn:length(list.title)<=30 }">${list.title}</c:if>
                                </a>
                                <em>${fn:substring(list.releaseDate,0,10)}</em>
                            </li>
                        </c:forEach>
                    </ul>
                    </div>
                </div>                   
                          
                </td>
            </tr>
            <tr>
            	<th colspan="2">
            	<%@include file="../web/frontArea/front_area.jsp" %>    
				</th>
            </tr>
            <tr>
            	<th>
                 <div class="tab tab2">
                    <ul class="tab_menu">
                        <li class="current"><a href="http://xf.jykgjjq.gov.cn/web/messList.jsp?knowType=consultation&knowValue=%u54A8%u8BE2%u670D%u52A1" target="_blank">咨询服务</a></li>
<%--                         <li><a href="${ctx }/web/front_queryContentsList.action">民意征集</a></li> --%>
                    </ul>
                    <div class="tab_content">
        				<iframe scrolling="no" height="208px" width="280px" frameborder="0" allowtransparency="true" src="http://121.11.161.159/web/messList-new.jsp?knowType=consultation&knowValue=%u54A8%u8BE2%u670D%u52A1"></iframe>
<!--                         <ul> -->
<%--                             <c:forEach items="${list }" var="list" begin="0" end="4"> --%>
<!--                                 <li> -->
<%--                                     <a href="${ctx}/web/front_querySurveyInfo.action?theID=${list.desId}&index=D572057B768D17EA" title="${list.title }"> --%>
<%--                                         <c:if test="${fn:length(list.title)>22}"> --%>
<%--                                             ${fn:substring(list.title,0,20) }... --%>
<%--                                         </c:if> --%>
<%--                                         <c:if test="${fn:length(list.title)<=22}"> --%>
<%--                                             ${list.title} --%>
<%--                                         </c:if> --%>
<!--                                     </a> -->
<!--                                 </li> -->
<%--                             </c:forEach> --%>
<!--                         </ul> -->
<!--                         <ul class="hide"> -->
<%--                             <c:forEach items="${contents45List }" var="list" begin="0" end="4"> --%>
<!--                                 <li> -->
<%--                                     <a href="${ctx}/web/front_queryContentsDetail.action?theID=${list.desId}&flag=now" title="${list.title }"> --%>
<%--                                         <c:if test="${fn:length(list.title)>22}"> --%>
<%--                                             ${fn:substring(list.title,0,20) }... --%>
<%--                                         </c:if> --%>
<%--                                         <c:if test="${fn:length(list.title)<=22}"> --%>
<%--                                             ${list.title} --%>
<%--                                         </c:if> --%>
<!--                                     </a> -->
<!--                                 </li> -->
<%--                             </c:forEach> --%>
<!--                         </ul> -->
                    </div>
                </div>                                  
                </th>
                <td>
                <div class="tab tab2">
                    <ul class="tab_menu">
                        <li class="current"><a href="http://xf.jykgjjq.gov.cn/web/visitSearch.jsp">最新来信</a></li>
<%--                         <li><a href="${ctx}/web/front_replayLetter.action?flag=2">最新建言</a></li> --%>
                    </ul>
                    <iframe scrolling="no" height="208px" width="428px" frameborder="0" allowtransparency="true" src="http://xf.jykgjjq.gov.cn/web/homeVisitList_min.jsp"></iframe>
<!--                     <div class="tab_content"> -->
<!--                         <table class="hdtable"> -->
<!--                         <tr class="tbg"> -->
<!--                             <td width="80">状态</td> -->
<!--                             <td>信件标题</td> -->
<!--                             <td width="80">来信日期</td> -->
<!--                         </tr> -->
<%--                             <c:forEach items="${letterList}" var="letter"> --%>
<!--                                 <tr> -->
<!--                                     <td><font color="red"> -->
<%--                                         <c:if test="${letter.status eq '1'}"> --%>
<!--                                             已回复 -->
<%--                                         </c:if> --%>
<!--                                     </font></td> -->
<%--                                     <td><a href="${ctx }/web/front_queryLetterDetail.action?theID=${letter.theID}">${fn:substring(letter.theme,0,30)}</a></td> --%>
<%--                                     <td>${fn:substring(letter.createDate,0,10)}</td> --%>
<!--                                 </tr> -->
<%--                             </c:forEach> --%>
<!--                         </table> -->
<!--                         <table class="hdtable hide"> -->
<!--                         <tr class="tbg"> -->
<!--                             <td width="80">状态</td> -->
<!--                             <td>信件标题</td> -->
<!--                             <td width="80">来信日期</td> -->
<!--                         </tr> -->
<%--                             <c:forEach items="${adviseList}" var="advise"> --%>
<!--                                 <tr> -->
<!--                                     <td><font color="red"> -->
<%--                                         <c:if test="${advise.status eq '1'}"> --%>
<!--                                             已回复 -->
<%--                                         </c:if> --%>
<!--                                     </font></td> -->
<%--                                     <td><a href="${ctx }/web/front_queryLetterDetail.action?theID=${advise.theID}">${advise.theme}</a></td> --%>
<%--                                     <td>${fn:substring(advise.createDate,0,10)}</td> --%>
<!--                                 </tr> -->
<%--                             </c:forEach> --%>
<!--                         </table> -->
<!--                     </div> -->
                </div>                                 
                </td>
            </tr>
            </table>
        </div>
        <div class="right">  
        	<div class="zt">
                <h3>专题</h3>
                <div id="marqueeBox" style="height:340px; overflow:hidden;">
                <div id="marqueeImg">                
                <c:forEach items="${ztCatalogList}" var="item">
                    <c:if test="${item.url == '' }">
                        <a href="${ctx}/web/specialTopicList.action?catalogID=${item.theID}">
                            <img src="${ctx}/uploads/zt/pic/${item.theID}.jpg" />
                        </a>
                    </c:if>
                    <c:if test="${item.url != '' }">
                        <a href="${item.url}" target="_blank">
                            <img src="${ctx}/uploads/zt/pic/${item.theID}.jpg" />
                        </a>
                    </c:if>
                </c:forEach>
                </div>
                </div>
            </div> 
        
            <div class="box bm">
                <h3><span>便民服务</span><a href="${ctx}/web/servicesList.action">更多>></a></h3>
                <ul>
                <c:forEach items="${sLinksList }" var="item">
                <li><a href="${item.link_url }" target="_blank"><img src="${ctx}/${item.pic_url}" align="absmiddle" />${item.title}</a></li>
                </c:forEach>
                </ul>
            </div>

                              
         	<div class="box hd">
                <h3><span>政民互动</span></h3>
                <p>
                <a href="http://xf.jykgjjq.gov.cn/web/notice.jsp?subtype=quzhang" target="_blank"><img src="${ctx}/resources/web/image/ico1.png" align="absmiddle"/>区长信箱</a>
                <a href="${ctx}/web/front_queryContentsList.action"><img src="${ctx}/resources/web/image/ico2.png" align="absmiddle"/>民意征集</a>
                <a href="http://xf.jykgjjq.gov.cn/web/notice.jsp" target="_blank"><img src="${ctx}/resources/web/image/ico3.png" align="absmiddle"/>我要写信</a>
                <a href="${ctx}/web/front_letterRight.action?flag=3"><img src="${ctx}/resources/web/image/ico4.png" align="absmiddle"/>投诉建议</a>
                <a href="${ctx}/web/front_querySurveyListDetail.action?index=1"><img src="${ctx}/resources/web/image/ico5.jpg" align="absmiddle"/>网上调查</a>
                </p>
            </div>    
                                            
        </div>


        <div id="banner">
            <ul id="img">
                <li><a href="javascript:void(0)" onclick="openwindow(13);"><img src="${ctx}/uploads/system/titlepic/13.jpg"/></a></li>
                <li><a href="javascript:void(0)" onclick="openwindow(14);"><img src="${ctx}/uploads/system/titlepic/14.jpg"/></a></li>
                <li><a href="javascript:void(0)" onclick="openwindow(15);"><img src="${ctx}/uploads/system/titlepic/15.jpg"/></a></li>
                <li><a href="javascript:void(0)" onclick="openwindow(16);"><img src="${ctx}/uploads/system/titlepic/16.jpg"/></a></li>
            </ul>
            <div id="btn">
                <a href="javascript:void(0)" hidefocus="true">1</a>
                <a href="javascript:void(0)" hidefocus="true">2</a>
                <a href="javascript:void(0)" hidefocus="true">3</a>
                <a href="javascript:void(0)" hidefocus="true">4</a>
            </div>
        </div>
        <script type="text/javascript">
            Qfast(false, 'widgets', function () {
                K.tabs({
                    id: 'banner',   //焦点图包裹id
                    conId: "img",  //** 大图域包裹id
                    tabId: "btn",
                    tabTn: "a",
                    conTn: "li",
                    auto: 1,   //自动播放 1或0
                    effect: 'fade',   //效果配置
                    eType: 'mouseover', //** 鼠标事件
                    pageBt: 'false'//是否有按钮切换页码
                })
            })
        </script>      

        <table class="boxlist">
            <tr>
                <td>
                    <div>
                        <h3><span>投资指南</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=87">更多 >></a></h3>
                        <ul>
                            <c:forEach items="${contents65List}" var="contents">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?type=contents&contentsID=${contents.desId}">
                                        <c:if test="${fn:length(contents.title)>16}">${fn:substring(contents.title,0,14)}...</c:if>
                                        <c:if test="${fn:length(contents.title)<=16}">${contents.title}</c:if>
                                    </a>
                                    <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </td>
                <td style="padding:0 10px;">
                    <div>
                        <h3><span>办事指南</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=169">更多 >></a></h3>
                        <ul>
                            <c:forEach items="${contents169List}" var="contents">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?type=contents&contentsID=${contents.desId}">
                                        <c:if test="${fn:length(contents.title)>16}">${fn:substring(contents.title,0,14)}...</c:if>
                                        <c:if test="${fn:length(contents.title)<=16}">${contents.title}</c:if>
                                    </a>
                                    <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </td>
                <td>
                    <div>
                        <h3><span>旅游服务</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=88">更多 >></a></h3>
                        <ul>
                            <c:forEach items="${contents51List}" var="contents">
                                <li>
                                    <a href="${ctx}/web/contentsShow.action?type=contents&contentsID=${contents.desId}">
                                        <c:if test="${fn:length(contents.title)>16}">${fn:substring(contents.title,0,14)}...</c:if>
                                        <c:if test="${fn:length(contents.title)<=16}">${contents.title}</c:if>
                                    </a>
                                    <em>${fn:substring(contents.releaseDate,0,10)}</em>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>

        <%--<div class="piclist">--%>
            <%--<div id="demo">--%>
            <%--<div style="float:left;width:800%;">--%>
            <%--<div id="demo1" style="float:left; margin-right:5px;">--%>
            	<%--<ul class="baguetteBoxOne gallery">--%>
                <%--<c:forEach items="${fileInfoList}" var="item">--%>
                    <%--<li><a href="${ctx}/${item.fileUrl}"><img src="${ctx}/${item.fileUrl}" width="150" height="150"/></a></li>--%>
                <%--</c:forEach>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <%--<div id="demo2" style="float:left;"></div>--%>
            <%--</div>--%>
            <%--</div> --%>
        <%--</div>--%>
        
        <div id="demo" style="overflow:hidden; zoom:1; clear:both; margin-bottom:10px;">
            <div style="float:left;width:800%;">
                <div id="demo1" style="float:left;">
                    <c:forEach items="${picLinksList}" var="item" varStatus="status">
                        <a href="${item.link_url}" target="_blank">
                            <img src="${ctx}/${item.pic_url}" width="195" height="44"/>
                        </a>
                    </c:forEach>
                </div>
                <div id="demo2" style="float:left;"></div>
            </div>
        </div>

        <div class="tab tab3">
            <ul class="tab_menu">
                <li class="current">中央各部门网站</li>
                <li>广东省、市政府网站</li>
                <li>市各部门网站</li>
                <li>各区政府网站</li>
                <li>区内网站</li>
                <%--<li>本站合作</li>--%>
            </ul>
            <div class="tab_content">
                <div>
                    <c:forEach items="${selectLinksList }" var="links">
                        <c:if test="${links.select_type==1 }">
                            <a href="${links.link_url }" target="_blank">${links.title}</a>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="hide">
                    <c:forEach items="${selectLinksList }" var="links">
                        <c:if test="${links.select_type==2 }">
                            <a href="${links.link_url }" target="_blank">${links.title}</a>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="hide">
                    <c:forEach items="${selectLinksList }" var="links">
                        <c:if test="${links.select_type==3 }">
                            <a href="${links.link_url }" target="_blank">${links.title}</a>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="hide">
                    <c:forEach items="${selectLinksList }" var="links">
                        <c:if test="${links.select_type==5 }">
                            <a href="${links.link_url }" target="_blank">${links.title}</a>
                        </c:if>
                    </c:forEach>
                </div>
                <div class="hide">
                    <c:forEach items="${selectLinksList }" var="links">
                        <c:if test="${links.select_type==4 }">
                            <a href="${links.link_url }" target="_blank">${links.title}</a>
                        </c:if>
                    </c:forEach>
                </div>
                <%--<div class="hide">--%>
                    <%--<c:forEach items="${selectLinksList }" var="links">--%>
                        <%--<c:if test="${links.select_type==5 }">--%>
                            <%--<a href="${links.link_url }" target="_blank">${links.title}</a>--%>
                        <%--</c:if>--%>
                    <%--</c:forEach>--%>
                <%--</div>--%>
            </div>
        </div>

    </div>
</div>
<%@include file="../web/foot.jsp" %>
</body>

</html>

<script>

	$(function () {
		$(".xxgk ul li").each(function (i) {
			$(this).addClass("gk" + i);
		})
	})
    window.onload = function () {

		//专题图片滚动
		var h1=document.getElementById("marqueeImg").offsetHeight;
		var h2=document.getElementById("marqueeBox").offsetHeight;
		if(h1>h2){
			function startmarquee(lh,speed,delay) {
				var p=false;
				var t;
				var o=document.getElementById("marqueeImg");
				o.innerHTML+=o.innerHTML;
				o.style.marginTop=0;
				o.onmouseover=function(){p=true;}
				o.onmouseout=function(){p=false;}
				function start(){
					t=setInterval(scrolling,speed);
					if(!p) o.style.marginTop=parseInt(o.style.marginTop)-1+"px";
				}
				function scrolling(){
				if(parseInt(o.style.marginTop)%lh!=0){
					o.style.marginTop=parseInt(o.style.marginTop)-1+"px";
					if(
						 Math.abs(parseInt(o.style.marginTop))>=o.scrollHeight/2) o.style.marginTop=0;
					}else{
						clearInterval(t);
						setTimeout(start,delay);
					}
				}
				setTimeout(start,delay);
			}
			startmarquee(20,50,0);
		}
		
		
        //友情链接图片滚动
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
    <%

    String isDlShow = (String)request.getAttribute("isDlShow");
    if(isDlShow.equals("1")){%>
    lastScrollY = 0;
    function heartBeat() {
        var diffY;
        if (document.documentElement && document.documentElement.scrollTop)
            diffY = document.documentElement.scrollTop;
        else if (document.body)
            diffY = document.body.scrollTop;
        else {/*Netscape stuff*/
        }

        percent = .1 * (diffY - lastScrollY);
        if (percent > 0)percent = Math.ceil(percent);
        else percent = Math.floor(percent);
        document.getElementById("lovexin12").style.top = parseInt(document.getElementById("lovexin12").style.top) + percent + "px";
        document.getElementById("lovexin14").style.top = parseInt(document.getElementById("lovexin14").style.top) + percent + "px";
        lastScrollY = lastScrollY + percent;

    }
    suspendcode12 = "<div id='lovexin12' style='left:2px;position:absolute;top:220px;'><div style='text-align:right;background:#ccc;' onclick='document.getElementById(\"lovexin12\").style.display=\"none\";document.getElementById(\"lovexin14\").style.display=\"none\";'>关闭</div><img src='${ctx}/uploads/system/titlepic/11.jpg' height='250px' width='120px'></div>";
    suspendcode14 = "<div id=\"lovexin14\" style='right:2px;position:absolute;top:220px;'><div style='text-align:right;background:#ccc;' onclick='document.getElementById(\"lovexin12\").style.display=\"none\";document.getElementById(\"lovexin14\").style.display=\"none\";'>关闭</div><img src='${ctx}/uploads/system/titlepic/11.jpg' height='250px' width='120px'></div>";
    document.write(suspendcode12);
    document.write(suspendcode14);
    window.setInterval("heartBeat()", 1);
    <%}%>

    function openwindow(theID) {
        $.ajax({
            type: "post",
            url: "${ctx}/web/queryUrlById.action",
            data: {id: theID},
            dataType: "text",
            success: function (data) {
            	if(data!=''){
               		window.open(data);
            	}
            }
        });

    }
</script>
