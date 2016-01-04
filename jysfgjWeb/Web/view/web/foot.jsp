<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="footer">
	<div class="inner">
        <div class="footlink">
            <a href="">关于本站</a>|
            <a href="">网站地图</a>|
            <a href="">技术支持</a>|
            <a href="">联系我们</a>|
            <a href="">隐私保护</a>|
            <a href="">版权声明</a>
        </div>
        <p>主办单位：揭阳市发展和改革局 &nbsp;&nbsp;&nbsp;&nbsp; 承办单位：揭阳市发展和改革局</p>
        <p>Copyright &nbsp;&nbsp; © &nbsp;&nbsp; 2015 &nbsp;&nbsp; 揭阳市发展和改革局 &nbsp;&nbsp; 革版权所有 &nbsp;&nbsp; ICP备案编号：</p>
    </div>  
</div>
<script>
    $(function () {
        $(".footer select").change(function() {
            if (this.value != "") {
                window.open(this.value);
            }
        });
    });
</script>



 