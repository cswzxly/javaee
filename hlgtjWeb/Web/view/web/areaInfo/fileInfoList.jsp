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
                <c:if test="${leftTitle=='zlxz'}">
                    <a href="${ctx}/web/fileInfoMainList.action?type=zlxz&catalogID=236">
                        资料下载
                    </a>
                    > <b>${catalog.title}</b>
                </c:if>

            </div>




            <div class="list">
                <h3><span>${catalog.title}</span></h3>
                <ul>
                    <c:if test="${catalog.catalogType=='t_fileinfo' }">
                        <table class="csstable">
                            <tr>
                                <th>文件名称</th>
                                <th>文件类型</th>
                                <th>上传日期</th>
                                <th>操作</th>
                            </tr>
                            <c:forEach items="${fileInfoList.list}" var="item">
                                <tr>
                                    <td class="tdl">${item.title}</td>
                                    <td>${item.fileUrl}</td>
                                    <td>${fn:substring(item.create_date,0,10) }</td>
                                    <td><a href="${ctx}/web/download.action?theID=${item.theID}">下载文件</a></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:if>
                </ul>
            </div>
            <div id="layPage"></div>
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
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
</html>



