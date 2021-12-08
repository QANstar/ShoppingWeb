<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.shopping.DB_Bean" %><%--
  Created by IntelliJ IDEA.
  User: 14353
  Date: 2021/12/2
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="com.example.shopping.DB_Bean" scope="request"/>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    String userName = request.getParameter("name");
    String userPassword = request.getParameter("password");

    //连接数据库
    db.connectDB();

    //检查是否有重复用户
    boolean login_right = false;
    String sqlSearch = "SELECT * FROM dbo.ShoppingUser where name='" + userName + "'";
    login_right = db.searchDB(sqlSearch);
    if (login_right) {
        out.println("repeat");
    } else {
        //添加用户
        String sql = "insert into ShoppingUser(Name,Password) values ('" + userName + "','" + userPassword + "');";
        db.insertDB(sql);
    }

%>