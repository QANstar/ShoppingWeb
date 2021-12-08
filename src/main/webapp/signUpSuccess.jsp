<%--
  Created by IntelliJ IDEA.
  User: 14353
  Date: 2021/12/2
  Time: 20:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>注册成功</title>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <style>
        *{
            transition: 0.2s;
        }
        html, body {
            width: 100%;
            height: 100%;
            background-color: #e4eaff;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .succContent{
            display: flex;
        }

        .button1 {
            padding: 0.8em 2em;
            letter-spacing: 0.1em;
            background: #FFCCCC;
            color: #ffffff;
            font-size: 12px;
            font-weight: 600;
            border: none;
            border-radius: 100px;
        }
        .button1:hover {
            background: #ffbbbb;
            color: #ffffff;
            font-weight: 700;
        }

        .button2 {
            padding: 0.8em 2em;
            letter-spacing: 0.1em;
            background: #3b8df6;
            color: #ffffff;
            font-size: 12px;
            font-weight: 600;
            border: none;
            border-radius: 100px;
        }
        .button2:hover {
            background: #086cec;
            color: #ffffff;
            font-weight: 700;
        }

        a:hover {
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="succContent">
    <img style="width: 20vw;margin-right: 30px" src="<%=basePath%>/static/img/successPageBG.png">
    <div style="margin-left: 30px">
        <div style="font-size: 3.5em;font-weight: bold;margin-top: 70px">
            注册成功
        </div>
        <div style="font-weight: bold">
            您已注册成功，请愉快的享受购物之旅吧。
        </div>
        <div style="margin-top: 100px">
            <a href="signUpPage.jsp" style="margin-right: 20px">
                <button class="button1">返回注册</button>
            </a>
            <a href="index.jsp">
                <button class="button2">登录</button>
            </a>
        </div>
    </div>
</div>

</body>
</html>
