<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>惠来国土资源局</title>
</head>

<body>
<%@include file="../web/head.jsp" %>
<div class="wrapper">
    <div class="inner">
        <div class="content">
            <div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > <b>搜索结果</b></div>
            <div class="list">
                <h3><span>搜索结果</span></h3>
                <ul>
                    <c:choose>
                        <c:when test="${size eq '0'}">
                            <li>
                                查无数据
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${resultList.list}" var="item">
                                <li>
                                    <a href="${ctx}/web/searchShow.action?tableName=${item.tableName }&id=${item.theID}">${item.title }</a><em>${fn:substring(item.releaseDate,0,10) }</em>
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div id="layPage"></div>
        </div>
    </div>
</div>
<%@include file="../web/foot.jsp" %>
</body>
<script>
    laypage({
        cont: 'layPage', //容器id
        pages: '${resultList.pages}', //总页数
        curr: '${resultList.pageNum}',
        jump: function (e, first) { //触发分页后的回调
            if (!first) { //一定要加此判断，否则初始时会无限刷新
                window.location.href = "${ctx}/web/searchList.action?pageNum=" + e.curr + "&pageSize=${resultList.pageSize}&title=" + '${title}';
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
</html>



