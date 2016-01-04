<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>惠来国土资源局</title>

</head>

<body>
<%@include file="../../web/head.jsp" %>
<div class="wrapper">
    <div class="inner">

        <div class="side">
            <%@include file="../../web/leftCatalog.jsp" %>
        </div>

        <div class="main">
            <input type="hidden" id="type" value="${leftTitle }"/>
            <input type="hidden" id="catalogID" value="${catalog.theID}"/>

            <div class="position"><span>当前位置：</span>
            <a href="${ctx}/web/index.action">网站首页</a> >
                <!-- liny -->
                <c:if test="${leftTitle=='zcfg'}">
                    <a href="${ctx}/web/areaInfoMainList.action?type=zcfg&catalogID=1">
                        政策法规
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='xxgk'}">
                    <a href="${ctx}/web/areaInfoMainList.action?type=xxgk&catalogID=203">
                        信息公开
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='xssydwzf'}">
                    <a href="${ctx}/web/areaInfoMainList.action?type=xxgk&catalogID=203">
                        信息公开
                    </a>
                    >
                    <a href="${ctx}/web/areaInfoMainList.action?type=xssydwzf&catalogID=213">
                        辖属事业单位政府信息公开
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <!-- 人事 -->
                <c:if test="${leftTitle=='rsxx'}">
                    <a href="${ctx}/web/areaInfoList.action?type=zwgk&catalogID=183">
                        政务公开
                    </a>> <b>${catalog.title}</b>
                </c:if>

                <c:if test="${leftTitle=='zwgk'}">
                    <a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
                        政务公开
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='contents'}">
                    <a href="${ctx}/web/areaInfoMainList.action?type=zcfg&catalogID=1">
                        政策发规
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>
                <c:if test="${leftTitle=='ywgg'}">
                    <a href="${ctx}/web/areaInfoList.action?type=zwgk&catalogID=183">
                        政务公开
                    </a>
                    >
                    <a href="${ctx}/web/areaInfoMainList.action?type=ywgg&catalogID=180">
                        业务公告
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>

            </div>




            <div class="list">
                <h3><span>${catalog.title}</span></h3>
                <ul>
                    <c:if test="${catalog.catalogType=='t_contents' }">
                        <c:forEach items="${contentsList.list}" var="item">
                            <li>
                                <a href="${ctx}/web/contentsShow.action?type=${leftTitle }&contentsID=${item.desId}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${catalog.catalogType=='t_video' }">
                        <c:forEach items="${videoList}" var="item">
                            <li>
                                <a href="${ctx}/web/videoShow.action?type=${leftTitle }&videoID=${item.desId}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${catalog.catalogType=='t_fileinfo' }">
                        <c:forEach items="${fileInfoList.list}" var="item">
                            <li>
                                <a href="${ctx}/web/download.action?theID=${item.theID}">${item.title }</a><em>${fn:substring(item.create_date,0,10) }</em>
                            </li>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>


            <div id="layPage"></div>
            <script>
                laypage({
                    cont: 'layPage', //容器id
                    pages: '${contentsList.pages}', //总页数
                    curr: '${contentsList.pageNum}',
                    jump: function (e, first) { //触发分页后的回调
                        if (!first) { //一定要加此判断，否则初始时会无限刷新
                            window.location.href = "${ctx}/web/areaInfoList.action?pageNum=" + e.curr + "&pageSize=${contentsList.pageSize}&type=" + '${leftTitle}' + "&catalogID=" + '${catalog.theID}';
                        }
                    },

                    skin: 'molv', //皮肤
                    first: '首页', //若不显示，设置false即可
                    last: '尾页', //若不显示，设置false即可
                    prev: '<', //若不显示，设置false即可
                    next: '>', //若不显示，设置false即可
                    skip: true //是否开启跳页
                });
            </script>
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>



