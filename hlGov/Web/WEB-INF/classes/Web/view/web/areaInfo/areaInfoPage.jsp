<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>惠来县人民政府门户网站</title>

</head>
<body class="about">
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
	<div class="inner">
    
    

        <div class="intro">
            <p>惠来位于粤东沿海，东连汕头市，西接陆丰市，北邻普宁市，南濒南中国海，是揭阳市重要的沿海县和海上交通门户。境内地势北高南低，属滨海丘陵地形，大南山横贯县境北部。全境地处北回归线以南，属亚热带季风气候，高温湿润，四季如春，日照充足，雨量充沛，年平均气温22℃左右，年平均降雨量1800多毫米。</p>
            <p>惠来置县于明嘉靖三年（1524年），因县治设于惠来都，故名。城处葵岭东南，故雅称葵阳。置县以来，一直为潮汕政区辖县。1992年后，隶属揭阳市。全县陆地面积1253平方公里，海域面积7689平方公里，海岸线长109.5公里。现辖14个镇、3个农林场，设揭阳（惠来）沿海经济开发试验区。</p>
            <p>全县现有户籍总人口133万人，旅居国外侨胞和港澳台同胞20多万人。先后获得“全国水产品百强县”、“国家商品粮生产基地县”、“中国荔枝之乡”、“中国能源工业大县”等荣誉称号。 </p>

       </div>
       <script type="text/javascript" language="javascript" src="${ctx}/resources/web/js/jquery.innerfade.js"></script>
       <script>
		$(document).ready( function(){
			$('.intro').innerfade({
				speed: 500,
				timeout: 5000,
				type: 'sequence',
				containerheight: '220px'
			});
		}); 
	   </script>

        
        <div class="area">
            <ul>
            <c:forEach items="${areaCatalogList }" var="item">
                <li><a href="${ctx}${item.url}">${item.title }</a></li>
            </c:forEach>
            </ul>	
        </div>
        
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="arealist">
        <tr>
            <td>
				<%@include file="../areaInfo/contentsUpLeft.jsp" %>
            </td>
            <td>
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
            <td>
            	<%@include file="../areaInfo/contentsDownMid.jsp" %>
            </td>
            <td>
            	<%@include file="../areaInfo/contentsDownRight.jsp" %>
            </td>            
        </tr>        
        </table> 
	</div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>