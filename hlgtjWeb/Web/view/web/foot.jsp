<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="footer">
    <div class="inner">
        <table>
            <tr>
                <td>
                    <select>
                        <option value="">县（市、区）国土局网站链接</option>
                        <c:forEach items="${selectLinksList }" var="links">
                            <c:if test="${links.select_type==1 }">
                                <option value="${links.link_url }">${links.title}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select>
                        <option value="">市直单位网站链接</option>
                        <c:forEach items="${selectLinksList }" var="links">
                            <c:if test="${links.select_type==2 }">
                                <option value="${links.link_url }">${links.title}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <select>
                        <option value="">其它网站链接</option>
                        <c:forEach items="${selectLinksList }" var="links">
                            <c:if test="${links.select_type==3 }">
                                <option value="${links.link_url }">${links.title}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>

        <p>地址:惠来县惠城镇蓬莱新村国土局&nbsp;&nbsp;&nbsp;&nbsp;联系电话：0663-8612345 </p>

        <p>版权所有：惠来国土资源局&nbsp;&nbsp;&nbsp;&nbsp;｜&nbsp;&nbsp;&nbsp;&nbsp;Copyright 2015-2015 All Rights Reserved &nbsp;&nbsp;&nbsp;&nbsp;｜&nbsp;&nbsp;&nbsp;&nbsp;粤ICP备123456789号</p>

        <p>技术支持：广东信航信息技术有限公司0663-8763222</p>
    </div>
</div>
<script>
    $(function () {
        $(".footer select").change(function () {
            if (this.value != "") {
                window.open(this.value);
            }
        });
    });
</script>