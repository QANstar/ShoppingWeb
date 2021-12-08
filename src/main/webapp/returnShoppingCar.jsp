<%@ page import="com.example.shopping.ShoppingCar_Bean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: 14353
  Date: 2021/12/6
  Time: 0:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="com.example.shopping.DB_Bean" scope="request"/>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    //连接数据库
    db.connectDB();

    //获取用户信息
    String userName = (String) session.getAttribute("login");
    String sqlSearch = "select itemTable.itemId,itemTable.itemName,itemTable.itemPrice,UserShoppingCarTable.itemNum From itemTable,UserShoppingCarTable where itemTable.itemId = UserShoppingCarTable.itemId and Name='" + userName + "'";
    String sumSQl = "select SUM(itemPrice*itemNum) AS allNum From itemTable,UserShoppingCarTable where itemTable.itemId = UserShoppingCarTable.itemId and Name='" + userName + "'";

    //获取购物车信息
    List<ShoppingCar_Bean> itemList = new ArrayList<ShoppingCar_Bean>();
    db.getShopCarDataDB(sqlSearch, itemList);



    if (itemList != null)
    {
        //获取总价格
        int num = db.getItemNumDB(sumSQl,"allNum");
        String result = itemList.get(0).getItem().getItemId() + "," + itemList.get(0).getItem().getItemPrice() + "," + itemList.get(0).getItem().getItemName() + "," + itemList.get(0).getItemNum();
        for (int i = 1; i < itemList.size(); i++) {
            String res = "";
            res = itemList.get(i).getItem().getItemId() + "," + itemList.get(i).getItem().getItemPrice() + "," + itemList.get(i).getItem().getItemName() + "," + itemList.get(i).getItemNum();
            result += ";" + res;
        }
        result = num + "?" + result;
        out.println(result);
    }
    else {
        out.println("空");
    }
    db.closeConnect();


%>