<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="惠来,山海兼备,人文荟萃,景色秀丽,可谓“踏浪有海,登高有山”:寺庙古迹风格迥异,滨海地貌神态各异,新型工业绚丽多彩,...惠来位于粤东沿海,是粤东地区陆上交通枢纽,海岸线长82公里,是广东省著名侨乡。"/>
<meta content="“中国．惠来”网站（www.huilai.gov.cn）是惠来县人民政府公众网，是宣传惠来风土人情、资源环境和沟通海内外的窗口。网站作为惠来县政府门户网站，以“公开政务、倾听民声、宣传惠来、服务社会”的原则对网站进行规划设计，通过“走进惠来”、“领导致词”、“政务公开”、“招商引资”、“发展规划”、“法规文件”、“旅游天地”、“民俗风情”、“镇场信息”、“地方要闻”、“国内外信息”等栏目，为公众提供了惠来县的政治、经济、社会、文化、旅游、招商引资等方面的基本信息。网站还在首页显要位置公开了县长信箱和县主要部门的服务、投诉电话。对国内大型门户网站包括中央、国家部委、省、市和县市区政府网站、县内网站等进行了链接，方便浏览。我们将继续以构建“方便、实用、为民”的政府网站为目标，进一步加强网站建设，不断开拓创新，使本网站成为服务群众、服务经济发展的平台与桥梁，为推动惠来经济、社会全面发展做出应有贡献。“中国．惠来”网站由惠来县人民政府网络中心制作维护，该中心为惠来县人民政府办公室属下机构，负责网站的信息发布和运行管理工作，负责县直各部门和乡镇政府、街道子网站的业务联系、指导和协调。地址：惠来县人民政府办公楼二楼；电话：0663-6696181；E-Mail：huilaixx@163.com;" name="description"/>
<title>惠来县人民政府门户网站</title>

</head>
<body class="index">
<%@include file="../web/head.jsp" %>
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/jwplayer/jwplayer.js"></script>


<div class="wrapper">
	<div class="inner">

        <div class="banner"><a href="javascript:void(0)" onclick="openwindow(7);"><img src="${ctx}/uploads/system/titlepic/7.jpg" onclick="openwindow(7);"/></a></div>

  		<div class="left">
             
            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-bottom:10px;">
            <tr>
                <td valign="top" width="320">
                    <script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.slide.js"></script>   
                    <div id="sliderDiv">
                    	<ul id="slider">
                        <c:forEach items="${picIndexList}" var="item" varStatus="status">
                        <li>
                        <p></p>
                        <span>${item.title}</span>
                        <a target="_blank" href="${ctx}/web/contentsShow.action?type=news&contentsID=${item.contentID}"><img src="${ctx}/${item.fileUrl}" title="${item.title}" /></a>
                        </li>
                        </c:forEach>                    
                    	</ul>
                    </div>                    
                    <ul id="sliderNum">
                        <c:forEach items="${picIndexList}" var="item" varStatus="status">
						<li><img src="${ctx}/${item.fileUrl}" title="${item.title }" /></li>
                        </c:forEach>                    
                    </ul>
                    <script language="javascript">
                    mytv("sliderNum","sliderDiv","slider",240,5,true,2000,5,true,"onmouseover");
                    </script>                      
                </td>
                <td valign="top" style="padding-left:10px;">
                    <div class="tab tab1 newstab">
                        <ul class="tab_menu">
                            <li class="current">惠来新闻</li>
                            <li>国内外新闻</li>
                            <li>视频新闻</li>
                        </ul>
                        <div class="tab_content">
                            <ul>
                            	<c:if test="${contents10 != null }">
	                            	<li class="topic">
										<a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents10.theID}" title="${contents10.title}">
											<c:if test="${fn:length(contents10.title)>14}">${fn:substring(contents10.title,0,14)}...</c:if>
											<c:if test="${fn:length(contents10.title)<=14}">${contents10.title}</c:if>
										</a>
									</li>
	                            	<c:forEach items="${contents10List }" var="contents" varStatus="status">
										<li>
											<a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.theID}" title="${contents.title}">
												<c:if test="${fn:length(contents.title)>20}">${fn:substring(contents.title,0,18)}...</c:if>
	                                            <c:if test="${fn:length(contents.title)<=20}">${contents.title}</c:if>
	                                        </a>
	                                        <em>${fn:substring(contents.releaseDate,0,10)}</em>
	                                    </li>
	                                </c:forEach>
                                </c:if>
                                <c:if test="${contents10==null }">
                                	<c:forEach items="${contents10List }" var="contents" varStatus="status">
	                                    <c:if test="${status.index==0 }">
	                                        <li class="topic">
	                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.theID}" title="${contents.title}">
	                                                <c:if test="${fn:length(contents.title)>14}">${fn:substring(contents.title,0,14)}...</c:if>
	                                                <c:if test="${fn:length(contents.title)<=14}">${contents.title}</c:if>
	                                            </a>
	                                        </li>
	                                    </c:if>                        	
	                                    <c:if test="${status.index!=0 }">
	                                        <li>
	                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.theID}" title="${contents.title}">
	                                                <c:if test="${fn:length(contents.title)>20}">${fn:substring(contents.title,0,18)}...</c:if>
	                                                <c:if test="${fn:length(contents.title)<=20}">${contents.title}</c:if>
	                                            </a>
	                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
	                                        </li>
	                                    </c:if>
	                                </c:forEach>
                                </c:if>
                            </ul>      
                            <ul class="hide">
                            	<c:if test="${contents43 != null }">
	                            	<li class="topic">
										<a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents43.theID}" title="${contents43.title}">
											<c:if test="${fn:length(contents43.title)>14}">${fn:substring(contents43.title,0,14)}...</c:if>
											<c:if test="${fn:length(contents43.title)<=14}">${contents43.title}</c:if>
										</a>
	                            	</li>
	                                <c:forEach items="${contents43List }" var="contents" varStatus="status">
										<li>
											<a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.theID}" title="${contents.title}">
												<c:if test="${fn:length(contents.title)>20}">${fn:substring(contents.title,0,18)}...</c:if>
	                                            <c:if test="${fn:length(contents.title)<=20}">${contents.title}</c:if>
	                                        </a>
	                                        <em>${fn:substring(contents.releaseDate,0,10)}</em>
	                                    </li>
	                                </c:forEach>
                                </c:if>
                                <c:if test="${contents43 == null }">
                                	<c:forEach items="${contents43List }" var="contents" varStatus="status">
	                                    <c:if test="${status.index==0 }">
	                                        <li class="topic">
	                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.theID}" title="${contents.title}">
	                                                <c:if test="${fn:length(contents.title)>14}">${fn:substring(contents.title,0,14)}...</c:if>
	                                                <c:if test="${fn:length(contents.title)<=14}">${contents.title}</c:if>
	                                            </a>
	                                        </li>
	                                    </c:if>                        	
	                                    <c:if test="${status.index!=0 }">
	                                        <li>
	                                            <a href="${ctx}/web/contentsShow.action?type=news&contentsID=${contents.theID}" title="${contents.title}">
	                                                <c:if test="${fn:length(contents.title)>20}">${fn:substring(contents.title,0,18)}...</c:if>
	                                                <c:if test="${fn:length(contents.title)<=20}">${contents.title}</c:if>
	                                            </a>
	                                            <em>${fn:substring(contents.releaseDate,0,10)}</em>
	                                        </li>
	                                    </c:if>
	                                </c:forEach>
                                </c:if>
                            </ul>
                            <ul class="hide">
                                <c:forEach items="${videoList }" var="video" varStatus="status">
                                    <c:if test="${status.index==0 }">
                                        <li class="topic">
                                            <a href="${ctx}/web/videoShow.action?type=news&videoID=${video.theID}" title="${video.title}">
                                                <c:if test="${fn:length(video.title)>14}">${fn:substring(video.title,0,14)}...</c:if>
                                                <c:if test="${fn:length(video.title)<=14}">${video.title}</c:if>
                                            </a>
                                        </li>
                                    </c:if>                        	
                                    <c:if test="${status.index!=0 }">
                                        <li>
                                            <a href="${ctx}/web/videoShow.action?type=news&videoID=${video.theID}" title="${video.title}">
                                                <c:if test="${fn:length(video.title)>20}">${fn:substring(video.title,0,18)}...</c:if>
                                                <c:if test="${fn:length(video.title)<=20}">${video.title}</c:if>
                                            </a>
                                            <em>${fn:substring(video.releaseDate,0,10)}</em>
                                        </li>
                                    </c:if>
                                </c:forEach>

                            </ul>                              
                        </div>
                    </div>     

                </td>
            </tr>
            </table>    
    		
            <table class="banners">
            <tr>
            	<td><a href="javascript:void(0)" onclick="openwindow(8);"><img src="${ctx}/uploads/system/titlepic/8.jpg" /></a></td>
                <td style="padding:0 5px;"><a href="javascript:void(0)" onclick="openwindow(9);"><img src="${ctx}/uploads/system/titlepic/9.jpg" /></a></td>
                <td><a href="javascript:void(0)" onclick="openwindow(10);"><img src="${ctx}/uploads/system/titlepic/10.jpg" /></a></td>
            </tr>
            </table>
            <div class="banner"><a href="javascript:void(0)" onclick="openwindow(12);"><img src="${ctx}/uploads/system/titlepic/12.jpg" /></a></div>

        	<div class="zw">
                <h2><span>政务公开</span></h2>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                <tr>
                    <td class="xxgk">
                        <h3><span><a href="${ctx }/web/frontOpenCatalogPage.action?theID=46">信息公开</a></span></h3>
                        <ul>
                        	<li><a href="" target="_blank">政府信息公开目录</a></li>
                        	<li><a href="" target="_blank">政府信息已申请公开</a></li>
                        	<li><a href="" target="_blank">政府信息公开意见箱</a></li>
                        	<li><a href="" target="_blank">依申请公开流程</a></li>
<%--                         <c:forEach items="${openTop8 }" var="list"> --%>
<!-- 	                        <li> -->
<%-- 	                        	<a href="${ctx }/web/frontOpenCatalogPage.action?theID=${list.theID}"> --%>
<%-- 	                        		${list.title} --%>
<!-- 	                        	</a> -->
<!-- 	                        </li> -->
<%--                         </c:forEach> --%>
                        </ul>    
                    </td>
                    <td class="zdly">
                        <h3><span><a href="http://zdly.huilai.gov.cn/front/index.action" target="_blank">重点领域</a></span></h3>
                        <ul>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=xzsp" target="_blank">行政审批</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=czys" target="_blank">财政信息</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=czsj" target="_blank">财政审批</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=bzxzf" target="_blank">住房保障</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=spypaq" target="_blank">食品药品安全</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=hjbh" target="_blank">环境保护</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=scaq" target="_blank">生产安全</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=zd" target="_blank">征地拆迁</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=jgysf" target="_blank">价格收费</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=fwzsbc" target="_blank">房屋征收补偿</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=ylwsjg" target="_blank">医疗卫生机构</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=kjgl" target="_blank">科技和项目经费</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=whjg" target="_blank">文化机构</a></li>
                        	<li><a href="http://zdly.huilai.gov.cn/openInfo.action?depFlag=gyqy" target="_blank">国有企业</a></li>
<%--                         <c:forEach items="${zlTop8 }" var="list" varStatus="stat"> --%>
<!-- 	                        <li> -->
<%-- 	                        	<a href="${ctx }/web/frontZlCatalogPage.action?theID=${list.theID}" > --%>
<%-- 	                        		${list.title} --%>
<!-- 	                        	</a> -->
<!-- 	                        </li> -->
<%--                         </c:forEach>       --%>
                        </ul>                   
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="">
                            <h3><span>信息公开</span><a href="${ctx }/web/frontOpenCatalogPage.action?theID=46">更多&nbsp;>></a></h3>
                            <ul>
                            	<iframe scrolling="no" height="168px" width="100%" frameborder="0" allowtransparency="true" src="http://zwgk.huilai.gov.cn/front/websiteOpenInfo.action?count=7"></iframe>
<%--                             <c:forEach items="${openTop8Contents }" var="list"> --%>
<!-- 	                            <li> -->
<%-- 	                            	<a href="${ctx }/web/frontOpenCatalogPage.action?theID=${list.theID}&flag=1" title="${list.title}"> --%>
<%-- 	                            		<c:if test="${fn:length(list.title)>26 }">${fn:substring(list.title,0,25)}...</c:if> --%>
<%-- 	                        			<c:if test="${fn:length(list.title)<=26 }">${list.title}</c:if> --%>
<!-- 	                            	</a> -->
<!-- 	                            </li> -->
<%--                             </c:forEach> --%>
                            </ul>                
                        </div>     
                    </td>      
                    <td>
                        <div class="">
                            <h3><span>重点领域</span><a href="http://zdly.huilai.gov.cn/front/index.action" target="_blank">更多&nbsp;>></a></h3>
                            <ul>
                            	<iframe scrolling="no" height="168px" frameborder="0" allowtransparency="true" src="http://zdly.huilai.gov.cn/front/openinfoList.action?counts=20"></iframe>
<%--                             <c:forEach items="${zlTop8Contents }" var="list"> --%>
<!-- 	                            <li> -->
<%-- 	                            	<a href="${ctx }/web/frontZlCatalogPage.action?theID=${list.theID}&flag=1" title="${list.title}"> --%>
<%-- 	                            		<c:if test="${fn:length(list.title)>26 }">${fn:substring(list.title,0,25)}...</c:if> --%>
<%-- 	                        			<c:if test="${fn:length(list.title)<=26 }">${list.title}</c:if> --%>
<!-- 	                            	</a> -->
<!-- 	                            </li> -->
<%--                             </c:forEach> --%>
                            </ul>                
                        </div>     
                    </td>                                     
                </tr>         
                </table>
			</div>
            
            
			<%@include file="../web/frontArea/front_area.jsp" %>

        </div>
        <div class="right">         
            
			<div class="banner"><a href="http://www.hlwb.gov.cn/wsdt/" target="_blank"><img src="${ctx}/resources/web/image/pic.jpg" width="240" height="80" /></a></div>           
        
            <div class="notice">
                <h3><span>通知公告</span></h3>
                <ul>
                	<c:forEach items="${contents68List }" var="item">
                		<li>
                			<a href="${ctx}/web/contentsShow.action?type=announcement&contentsID=${item.theID}">
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
                    

                
            <div class="zt">
                <div id="marqueeBox" style="height:340px; overflow:hidden;">
                <div id="marqueeImg">
                    <c:forEach items="${ztCatalogList}" var="item">
                        <a href="${ctx}/web/specialTopicList.action?catalogID=${item.theID}">
                            <img src="${ctx}/uploads/zt/pic/${item.theID}.jpg" />
                        </a>
                    </c:forEach>
                </div>
                </div>
           	</div>     	                                                        

            <div class="hd">
                <h3><span>政民互动</span></h3>
                <ul>
					<li><a href="${ctx}/web/front_letterRight.action?flag=1"><img src="${ctx}/resources/web/image/ico1.png" align="absmiddle" />县长信箱</a></li>
					<li><a href="${ctx}/web/tsjyPage.action"><img src="${ctx}/resources/web/image/ico2.png" align="absmiddle" />举报电话</a></li>
					<li><a href="${ctx}/web/front_letterRight.action?flag=2"><img src="${ctx}/resources/web/image/ico3.png" align="absmiddle" />我要写信</a></li>
					<li><a href="${ctx}/web/front_letterRight.action?flag=3" align="absmiddle"><img src="${ctx}/resources/web/image/ico4.png" />我要建议</a></li>
                </ul>
            </div>  

            <div class="vedio">   
            <h3><span>视频展示</span></h3>
	            <c:if test="${videoUrl != null && videoUrl!=''}">
	            	<div id="container"></div>
	            </c:if>
	            <c:if test="${videoUrl == null || videoUrl=='' }">
	            	<div>暂无视频播放</div>
	            </c:if>  
            </div>
            
 
        </div>


        <ul class="pic">  
            <li><a href="javascript:void(0)" onclick="openwindow(13);"><img src="${ctx}/uploads/system/titlepic/13.jpg"/></a></li>
            <li><a href="javascript:void(0)" onclick="openwindow(14);"><img src="${ctx}/uploads/system/titlepic/14.jpg"/></a></li> 
            <li><a href="javascript:void(0)" onclick="openwindow(15);"><img src="${ctx}/uploads/system/titlepic/15.jpg"/></a></li>
            <li><a href="javascript:void(0)" onclick="openwindow(16);"><img src="${ctx}/uploads/system/titlepic/16.jpg"/></a></li>                       
        </ul>



        <div class="left">
            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-bottom:10px; table-layout:fixed;">
            <tr>
                <td style="padding-right:5px;">
                	<div class="border">
                    <h3><span>投资服务</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=87">更多 >></a></h3>
                    <ul>
                    	<c:forEach items="${contents65List}" var="contents">
                    		<li>
								<a href="${ctx}/web/contentsShow.action?type=contents&contentsID=${contents.theID}">
									<c:if test="${fn:length(contents.title)>20}">${fn:substring(contents.title,0,18)}...</c:if>
	                                <c:if test="${fn:length(contents.title)<=20}">${contents.title}</c:if>
								</a>
								<em>${fn:substring(contents.releaseDate,0,10)}</em>
							</li>
                    	</c:forEach>
                    </ul>               
                    </div>            
                </td>
                <td style="padding-left:5px;">
                	<div class="border">
                    <h3><span>旅游天地</span><a href="${ctx}/web/areaInfoList.action?type=contents&catalogID=88">更多 >></a></h3>
                    <ul>
                    	<c:forEach items="${contents51List}" var="contents">
                    		<li>
								<a href="${ctx}/web/contentsShow.action?type=contents&contentsID=${contents.theID}">
									<c:if test="${fn:length(contents.title)>20}">${fn:substring(contents.title,0,18)}...</c:if>
	                                <c:if test="${fn:length(contents.title)<=20}">${contents.title}</c:if>
								</a>
								<em>${fn:substring(contents.releaseDate,0,10)}</em>
							</li>
                    	</c:forEach>
                    </ul>     
                    </div>                 
                </td>
            </tr>
            </table>  
            <div class="tab tab2 linktab">
                <ul class="tab_menu">
                    <li class="current">中央政府部门网站</li>
                    <li>省市政府部门网站</li>
                    <li>省级机关网站</li>
                    <li>公共服务单位网站</li>
                    <li>其他友情连接</li>
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
                        <c:if test="${links.select_type==4 }">
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
                </div>
            </div>    
        
        </div>
        
        <div class="right">
            <div class="bm">
                <h3><span>便民服务</span><a href="${ctx}/web/servicesList.action">更多>></a></h3>
                <ul>
                <c:forEach items="${sLinksList }" var="item">
                <li><a href="${item.link_url }" target="_blank"><img src="${ctx}/${item.pic_url}" align="absmiddle" />${item.title}</a></li>
                </c:forEach>
                </ul>
            </div>   

            <div class="tab tab1 hdtab">
                <ul class="tab_menu">
                    <li class="current"><a href="${ctx}/web/front_querySurveyListDetail.action?index=1">网上调查</a></li>
                    <li><a href="${ctx }/web/front_queryContentsList.action">民意征集</a></li>
                </ul>
                <div class="tab_content">
                    <ul>
                    
                        <c:forEach items="${list }" var="list" begin="0" end="4">
                        <li>
                        	<a href="${ctx}/web/front_querySurveyInfo.action?theID=${list.theID}&index=1" title="${list.title }">
                        		<c:if test="${fn:length(list.title)>15}">
                        			${fn:substring(list.title,0,15) }...
                        		</c:if>
                        		<c:if test="${fn:length(list.title)<=15}">
                        			${list.title}
                        		</c:if>
                        	</a>
                        </li>
                        </c:forEach>
                    </ul> 
                    <ul class="hide">
                        <c:forEach items="${contents45List }" var="list" begin="0" end="4">
                        <li>
                        	<a href="${ctx}/web/front_queryContentsDetail.action?theID=${list.theID}&flag=now" title="${list.title }">
								<c:if test="${fn:length(list.title)>15}">
                        			${fn:substring(list.title,0,15) }...
                        		</c:if>
                        		<c:if test="${fn:length(list.title)<=15}">
                        			${list.title}
                        		</c:if>
							</a>
						</li>
                        </c:forEach>               			
                    </ul>
                </div>
            </div>  
                               
        
        </div>
        
        <div id="demo" style="overflow:hidden; zoom:1; clear:both; width:1000px;">
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

    </div>
</div>
<%@include file="../web/foot.jsp" %>
</body>
</html>


<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.innerfade.js"></script>
<script>

$(function(){		
	$(".nav ul li span").eq(0).parent().addClass("now");
	$('.pic').innerfade({
		speed: 500,
		timeout: 5000,
		type: 'sequence',
		containerheight: '90px'
	});
}); 

window.onload = function(){
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
	var links_switch_speed=50;
	var demo=document.getElementById("demo");
	var demo1=document.getElementById("demo1");
	var demo2=document.getElementById("demo2");
	demo2.innerHTML=demo1.innerHTML;
	function linksMarquee() {
		if(demo2.offsetWidth-demo.scrollLeft<=0) {
			demo.scrollLeft-=demo1.offsetWidth;
		} else {
			demo.scrollLeft++;
		}
	}
	var linksMar=setInterval(linksMarquee,links_switch_speed);
	demo.onmouseover=function(){ clearInterval(linksMar)};
	demo.onmouseout=function(){ linksMar=setInterval(linksMarquee,links_switch_speed);}		   

}
<% 

String isDlShow = (String)request.getAttribute("isDlShow");
if(isDlShow.equals("1")){%>
lastScrollY=0;
function heartBeat(){
var diffY;
if (document.documentElement && document.documentElement.scrollTop)
diffY = document.documentElement.scrollTop;
else if (document.body)
diffY = document.body.scrollTop;
else
{/*Netscape stuff*/}

//alert(diffY);
percent=.1*(diffY-lastScrollY);
if(percent>0)percent=Math.ceil(percent);
else percent=Math.floor(percent);
document.getElementById("lovexin12").style.top=parseInt(document.getElementById("lovexin12").style.top)+percent+"px";
document.getElementById("lovexin14").style.top=parseInt(document.getElementById("lovexin14").style.top)+percent+"px";
lastScrollY=lastScrollY+percent;
//alert(lastScrollY);
}
suspendcode12="<div id='lovexin12' style='left:2px;position:absolute;top:220px;'><div onclick='document.getElementById(\"lovexin12\").style.display=\"none\";document.getElementById(\"lovexin14\").style.display=\"none\";'>关闭</div><img src='${ctx}/uploads/system/titlepic/11.jpg' height='250px' width='120px'></div>";
suspendcode14="<div id=\"lovexin14\" style='right:2px;position:absolute;top:220px;'><div style='text-align:right;' onclick='document.getElementById(\"lovexin12\").style.display=\"none\";document.getElementById(\"lovexin14\").style.display=\"none\";'>关闭</div><img src='${ctx}/uploads/system/titlepic/17.jpg' height='250px' width='120px'></div>";
document.write(suspendcode12);
document.write(suspendcode14);
window.setInterval("heartBeat()",1);
<%}%>

function openwindow(theID){
	$.ajax({
		type:"post",
		url:"${ctx}/web/queryUrlById.action",
		data:{id:theID},
		dataType:"text",
		success:function(data){
			window.open(data);
		}
	});
	
}
</script>
<%
	String url = (String)request.getAttribute("videoUrl");
	if(url != null && !"".equals(url)){
%>
<script type="text/javascript">  
jwplayer('container').setup({  
	flashplayer: '${ctx}/resources/web/jwplayer/jwplayer.flash.swf',  
	file: '${ctx}/${videoUrl}',  
	image:'${ctx}/resources/web/jwplayer/player.jpg',
	width: 240,  
	height: 182, 
	autostart:'${autostart}'
});  
</script> 
<%}%>