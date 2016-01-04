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
            <div class="position">当前位置>资料下载</div>
            <div class="list">
                <h3><span>${catalog.title}</span></h3>
                <ul>
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
                    pages: '${fileInfoList.pages}', //总页数
                    curr: '${fileInfoList.pageNum}',
                    jump: function (e, first) { //触发分页后的回调
                        if (!first) { //一定要加此判断，否则初始时会无限刷新
                            window.location.href = "${ctx}/web/areaInfoList.action?pageNum=" + e.curr + "&pageSize=${fileInfoList.pageSize}&type=" + '${leftTitle}' + "&catalogID=" + '${catalog.theID}';
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



