<%@ page import="java.util.List" %>
<%@ page import="com.example.shopping.Item_Bean" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: 14353
  Date: 2021/12/1
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<jsp:useBean id="db" class="com.example.shopping.DB_Bean" scope="request"/>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    //连接数据库
    db.connectDB();

    //获取数据库数据
    String getDataSql = "SELECT * FROM itemTable";
    List<Item_Bean> itemList = new ArrayList<Item_Bean>();
    db.getDataDB(getDataSql, itemList);
    db.closeConnect();

%>
<html>
<head>
    <title>509购物站</title>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>/static/css/style.css">
</head>
<body>
<%--模态--%>
<div class="modal fade" id="shoppingCarModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel" style="font-weight: bold">购物车</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="shoppingCarList" class="itemList">

                </div>
            </div>
            <div class="modal-footer">
                <div  style="color: #fa83a7">总价：￥<span id="allNum"></span></div>
            </div>
        </div>
    </div>
</div>


<div class="header">
    <div style="margin-left: 50px;">
        509 | <span style="font-size: 1rem;font-weight: 600;">购物站</span>
    </div>
    <div class="headerTool">
        <div id="shoppingCar">
            <img src="<%=basePath%>/static/img/icon/shoppingCar.svg">
        </div>
        <div>
            <a href="logout_Deal.jsp">登出</a>
        </div>
    </div>

</div>
<div class="content">
    <div class="itemList">
        <%
            for (int i = 0; i < itemList.size(); i++) {
        %>
        <div class="item">
            <img class="showImg" src="<%=basePath%>/static/img/itemImg/<%=itemList.get(i).getItemId()%>.jpg">
            <div class="detail">
                <div class="itemName"><%=itemList.get(i).getItemName()%>
                </div>
                <div class="itemPrice">￥<%=itemList.get(i).getItemPrice()%>
                </div>
                <div class="itemNum">
                    <div itemId="<%=itemList.get(i).getItemId()%>" class="itemChange itemReduce"><img
                            src="<%=basePath%>/static/img/icon/reduce.svg">
                    </div>
                    <div id="itemNum<%=itemList.get(i).getItemId()%>" class="num">0</div>
                    <div itemId="<%=itemList.get(i).getItemId()%>" class="itemChange itemPlus"><img
                            src="<%=basePath%>/static/img/icon/plus.svg"></div>
                </div>
                <div itemId="<%=itemList.get(i).getItemId()%>" class="itemAdd">
                    <button class="fcButtonPink">加入购物车</button>
                </div>
            </div>

        </div>
        <%
            }
        %>

    </div>
</div>

<script src="<%=basePath%>/static/js/jquery-3.6.0.js"></script>
<script src="<%=basePath%>/static/js/bootstrap.bundle.min.js"></script>

<script>
    $(".itemPlus").click(function () {
        let itemId = $(this).attr("itemId");
        let num = $("#itemNum" + itemId).html();
        num++;
        $("#itemNum" + itemId).html(num);
    })

    $(".itemReduce").click(function () {
        let itemId = $(this).attr("itemId");
        let num = $("#itemNum" + itemId).html();
        if (num > 0) {
            num--;

        }
        $("#itemNum" + itemId).html(num);
    })

    $(".itemAdd").click(function () {
        let itemId = $(this).attr("itemId");
        let num = $("#itemNum" + itemId).html();
        if (num <= 0) {
            alert("请选择数量");
        } else {
            $.ajax({
                type: "POST",
                url: "addShoppingCar.jsp",
                data: {itemId: itemId, itemNum: num},
                // dataType: "json",
                dataType: "text",
                success: function (data) {
                    alert("添加成功")
                },
                error: function (e) {
                    alert("错误");
                }

            })
        }

    })

    $("#shoppingCar").click(function () {
        $.ajax({
            type: "POST",
            url: "returnShoppingCar.jsp",
            data: {},
            // dataType: "json",
            dataType: "text",
            success: function (data) {
                data = data.replace(" ", "");
                data = data.replace(/[\r\n]/g, "");
                let allNum = data.split("?")[0];
                let list = data.split("?")[1].split(";");

                let html = '';
                for (let i = 0; i < list.length; i++) {
                    let listData = list[i].split(",");
                    let cot = '<div class="litteItem">' +
                        '<img class="showImg" src="<%=basePath%>/static/img/itemImg/' + listData[0] + '.jpg">' +
                        '<div class="itemData">' +
                        '<div>' + listData[2] + '</div>' +
                        '<div>价格：￥' + listData[1] + '</div>' +
                        '<div>数量：' + listData[3] + '</div>' +
                        '</div>' +
                        '</div>';
                    html += cot;

                }
                $("#shoppingCarList").html(html);
                $("#allNum").html(allNum);
            }
            ,
            error: function (e) {
                $("#allNum").html(0);
            }

        })
        $("#shoppingCarModal").modal("show");
    })
</script>
</body>
</html>
