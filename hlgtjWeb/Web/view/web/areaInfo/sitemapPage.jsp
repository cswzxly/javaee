<%--
  Created by IntelliJ IDEA.
  User: LinK
  Date: 2014/11/13
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
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
        <div>
            <c:forEach items="${tempList1}" var="e1">
                <h3><a href="${ctx}${e1.url}">${e1.title }</a></h3>
                <c:forEach items="${tempList2}" var="e2">
                    <c:if test="${e1.theID eq e2.parentID}">
                        <a href="${ctx}${e2.url}">${e2.title }</a>
                        <c:forEach items="${tempList3}" var="e3">
                            <c:if test="${e2.theID eq e3.parentID}">
                                <a href="${ctx}${e3.url}">${e3.title }</a>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </c:forEach>
            <h3><a href="${ctx}frontOpenCatalogPage.action">政务公开</a></h3>
            <a href="${ctx}frontOpenCatalogPage.action">信息公开</a>
            <a href="${ctx}frontZlCatalogPage.action?theID=35">组织机构</a>
            <a href="${ctx}frontZlCatalogPage.action?theID=34">领导之窗</a>
            <a href="${ctx}frontZlCatalogPage.action?theID=36">政府文件</a>
            <a href="${ctx}frontZlCatalogPage.action?theID=36">政府公报</a>
            <a href="${ctx}frontZlCatalogPage.action?theID=46">招标信息</a>
            <h3><a href="http://www.hlwb.gov.cn/wsdt/">网上办事</a></h3>
            <a href="http://www.hlwb.gov.cn/wsdt/byDept">部门服务</a>
            <a href="http://www.hlwb.gov.cn/wsdt/category?type1=2&type2=1">企业办事</a>
            <a href="http://www.hlwb.gov.cn/wsdt/category?type1=1&type2=1">市民办事</a>
            <h3><a href="${ctx}front_queryContentsList.action">政民互动</a></h3>
            <a href="${ctx}front_queryContentsList.action">民意征集</a>
            <a href="${ctx}front_letterRight.action?flag=1">领导信箱</a>
            <a href="${ctx}front_letterRight.action?flag=2">建言献策</a>
            <a href="${ctx}front_letterRight.action?flag=3">投诉举报</a>
            <a href="${ctx}front_querySurveyListDetail.action?index=1">网上调查</a>
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>
