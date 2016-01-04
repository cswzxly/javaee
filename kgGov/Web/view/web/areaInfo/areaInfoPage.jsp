<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>揭阳空港经济区</title>

</head>
<body>
<%@include file="../../web/head.jsp" %>

<link rel="stylesheet" type="text/css" href="${ctx}/resources/web/style/baguetteBox.css" />
<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/baguettebox.min.js"></script>
<div class="wrapper">
	<div class="inner">
  		<div class="pic">
            <ul class="img">
                <li><img src="${ctx}/resources/web/image/intro1.jpg" /></li>
                <li><img src="${ctx}/resources/web/image/intro2.jpg" /></li>
                <li><img src="${ctx}/resources/web/image/intro3.jpg" /></li>
            </ul>        
            <ul class="area">
                <c:forEach items="${areaCatalogList }" var="item">
                    <c:if test="${item.theID ne '129'}">
                    <li><a href="${ctx}${item.url}">${item.title }</a></li>
                    </c:if>
                </c:forEach>
            </ul>	                    
        </div>
        <div class="intro">
        	<h3><span>空港介绍</span></h3>
            <div>
            <p>揭阳空港经济区于2013年3月2日正式挂牌成立，总面积234平方公里，管辖砲台、地都、登岗、渔湖四个镇和溪南、凤美、京冈三个街道，户籍人口42.72万。区委、区管委实行大部制机构设置，综合设立职能部门14个。空港经济区作为揭阳市经济两大引擎之一，将紧紧围绕市委、市政府提出的把空港经济区建设成为“粤东国际化前沿平台、汕潮揭同城化先行区、推动揭阳转型升级集聚区，形成揭阳特色新城和总部经济基地”这一目标，加快开发建设步伐，全面推进经济社会的发展。</p>
            </div>
        </div>
        

		<script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.innerfade.js"></script>
        <script>
        $(document).ready( function(){
            $('.img').innerfade({
                speed: 500,
                timeout: 5000,
                type: 'sequence',
                containerheight: '250px'
            });
        }); 
        </script>

        <div class="piclist">
            <div id="demo">
            <div style="float:left;width:800%;">
            <div id="demo1" style="float:left; margin-right:5px;">
            	<ul class="baguetteBoxOne gallery">
                <c:forEach items="${fileInfoList}" var="item">
                    <li><a href="${ctx}/${item.fileUrl}"><img src="${ctx}/${item.fileUrl}" width="150" height="150"/></a></li>
                </c:forEach>
                </ul>
            </div>
            <div id="demo2" style="float:left;"></div>
            </div>
            </div> 
        </div>

        <table class="boxlist">
        <tr>
        <td>
            <%@include file="../areaInfo/contentsUpLeft.jsp" %>
        </td>
        <td style="padding:0 10px;">
            <%@include file="../areaInfo/contentsUpMid.jsp" %>
        </td>
        <td>
            <%@include file="../areaInfo/contentsUpRight.jsp" %>
        </td>            
        </tr>
        <tr>
        <td>
            <%@include file="../areaInfo/contentsDownLeft.jsp" %>
        </td>
        <td style="padding:0 10px;">
            <%@include file="../areaInfo/contentsDownMid.jsp" %>
        </td>
        <td>
            <%@include file="../areaInfo/contentsDownRight.jsp" %>
        </td>            
        </tr>        
        </table>        

        

        <script>
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


		baguetteBox.run('.baguetteBoxOne', {
			animation: 'fadeIn',
		});
		</script>
	</div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>