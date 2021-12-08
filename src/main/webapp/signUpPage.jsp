<%@ page import="javax.naming.Context" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>注册</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>/static/css/style.css">
    <link rel="stylesheet" href="<%=basePath%>/static/css/signStyle.css">
    <style>
        body {
            margin: 0 !important;
            background: url("<%=basePath%>/static/img/signUpBackground.png");
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
        }

    </style>
</head>

<body>

<div class="row bigBox">
    <div class="col-md-6 leftText">
        <div>
            <span style="font-size: 32px">509</span><span>&nbsp购物站</span>
            <div>
                Sign in and buy what you want
            </div>
        </div>
    </div>
    <div class="col-md-6 signMain" style="height: 100%">
        <div class="signBox">
            <div style="margin-bottom: 20px">
                <h1>注册</h1>
                <span style="color: #959595">已有账号？<a href="index.jsp">登录</a></span>
            </div>
            <div class="fc">
                <input id="nameInput" type="text" value="" required/>
                <label>姓名</label>
            </div>
            <div class="fc">
                <input id="passwordInput" type="password" value="" required/>
                <label>学号</label>
            </div>
            <div class="fc">
                <input id="passwordSureInput" type="password" value="" required/>
                <label>再次确认学号</label>
            </div>
            <div style="margin: 18px 0;">
                <input id="checkInput" type="checkbox"> 我已同意《509购物站用户使用协议》和《509隐私政策》
            </div>
            <div class="fc">
                <button onclick="signIn()">注册</button>
            </div>

        </div>
    </div>

</div>

<script src="<%=basePath%>/static/js/jquery-3.6.0.js"></script>
<script>
    function signIn() {
        if (!$("#checkInput").prop('checked')) {
            alert("请同意协议")
        } else if ($("#passwordInput").val() == "" || $("#nameInput").val() == "") {
            alert("请输入注册姓名和学号")
        } else if($("#passwordInput").val() != $("#passwordSureInput").val()) {
            alert("两次输入学号不相同")
        }
        else{
            let userName = $("#nameInput").val();
            let password = $("#passwordInput").val();
            $.ajax({
                type: "POST",
                url: "signUpJsp.jsp",
                data: {name: userName, password: password},
                // dataType: "json",
                dataType: "text",
                success: function (data) {
                    data = data.replace(" ", "");
                    data = data.replace(/[\r\n]/g,"")
                    if (data == "repeat"){
                        alert("用户已注册");
                    }
                    else {
                        window.location.href = "signUpSuccess.jsp";
                    }
                },
                error: function (e) {
                    alert("错误");
                }

            })
        }
    }
</script>
</body>
</html>