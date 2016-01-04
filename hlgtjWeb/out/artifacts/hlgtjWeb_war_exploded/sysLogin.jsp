<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>登录界面</title>
    <style>
        body {
            font-size: 12px;
            font-family: Arial, Helvetica, sans-serif;
            background: #F0F0F0 url(${ctx}/resources/system/images/bg.jpg) 0 -40px repeat-x;
            padding-top: 100px;
            text-align: center;
        }

        .login {
            background: url(${ctx}/resources/system/images/loginbg.jpg) center top no-repeat;
            padding-top: 31px;
        }

        .login div {
            margin-bottom: 10px;
        }

        .login table {
            width: 420px;
            margin: 0 auto 120px;
        }

        .login table th {
            padding: 5px 0;
            text-align: right;
            width: 135px;
            font-size: 14px;
            color: #555;
        }

        .login table td {
            padding: 5px 0;
        }

        .login table td input.text {
            padding: 5px;
            width: 220px;
            height: 25px;
            border: 1px solid #aaa;
        }

        .login table td input.submit {
            width: 80px;
            height: 25px;
            cursor: pointer;
        }

        .login table img {
			vertical-align:middle;
        }

        .login p {
            text-align: center;
            color: #666;
        }
    </style>
</head>

<body>
<div class="login">
    <div><img src="${ctx}/resources/system/images/login.jpg"/></div>
    <form action="${ctx}/login/login.action" method="post">
        <table>
            <tr>
                <th>用户名称：</th>
                <td><input type="text" id="userName" name="userName" value="" class="text"></td>
            </tr>
            <tr>
                <th>用户密码：</th>
                <td><input type="password" id="password" name="password" value="" class="text"></td>
            </tr>
            <tr>
                <th>验&nbsp;&nbsp;证&nbsp;&nbsp;码：</th>
                <td>
                    <input type="text" id="validCode" name="validCode" value="" size="10"><img id="validationCode" alt="验证码图片" title="验证码图片" src="${ctx}/validationCodeServlet.png" onClick="refreshCode(this)"/>
                </td>
            </tr>
            <tr>

                <th>&nbsp;</th>
                <td><input type="submit" value="登录" class="submit"></td>
            </tr>
        </table>
    </form>
    <p>技术支持：广东信航信息技术有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系电话：0663-8763222</p>
</div>

</body>
</html>
<script type="text/javascript">
    function refreshCode(imgObj) {
        if (!imgObj) {
            imgObj = document.getElementById("validationCode");
        }
        var index = imgObj.src.indexOf("?");
        if (index != -1) {
            var url = imgObj.src.substring(0, index + 1);
            imgObj.src = url + Math.random();
        } else {
            imgObj.src = imgObj.src + "?" + Math.random();
        }
    }
</script>