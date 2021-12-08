<%--
  Created by IntelliJ IDEA.
  User: 14353
  Date: 2021/12/4
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="com.example.shopping.DB_Bean" scope="request"/>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    //连接数据库
    db.connectDB();

    //获取用户信息与购物信息
    String userName = (String) session.getAttribute("login");
    String itemID = request.getParameter("itemId");
    String itemNum = request.getParameter("itemNum");

    //检查是否有重复购物
    boolean isRepeat = false;
    String sqlSearch = "SELECT * FROM dbo.UserShoppingCarTable where Name='" + userName + "' and itemId=" + itemID;
    isRepeat = db.searchDB(sqlSearch);
    if (isRepeat){
        int num = db.getItemNumDB(sqlSearch,"itemNum");
        num = num + Integer.parseInt(itemNum);
        String updateSql = "update UserShoppingCarTable set itemNum=" + num + " where Name='" + userName + "' and itemId = " + itemID;
        db.updateDB(updateSql);
    }
    else{
        //添加购物车
        String sql = "insert into UserShoppingCarTable(Name,itemId,itemNum) values('" + userName + "'," + itemID + "," + itemNum + ")";
        db.insertDB(sql);
    }


%>