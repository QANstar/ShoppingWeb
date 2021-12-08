<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: 14353
  Date: 2021/12/3
  Time: 16:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="com.example.shopping.DB_Bean" scope="request"/>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    //连接数据库
    db.connectDB();

    //登录检测
    String userName = request.getParameter("email");
    String userPassword = request.getParameter("password");
    boolean login_right = false;
    String sqlSearch = "SELECT * FROM dbo.ShoppingUser where name='" + userName + "' and Password='" + userPassword + "'";
    login_right = db.searchDB(sqlSearch);
    db.closeConnect();

    int maxAge;

    Cookie emailCookie = null;
    Cookie passwordCookie = null;
    Cookie[] cookies = request.getCookies();

    if (login_right) {
        //加入登录会话

        //存入登入会话
        session.setAttribute("login", request.getParameter("email"));
        //加入登录人
        String loginUser = (String) request.getServletContext().getAttribute("userName");
        if (loginUser == null) {
            loginUser = request.getParameter("email");
        } else {
            List<String> nameList = Arrays.asList(loginUser.split(","));
            if (!nameList.contains(request.getParameter("email"))) {
                loginUser += "," + request.getParameter("email");
            }
        }
        request.getServletContext().setAttribute("userName", loginUser);


        if (cookies != null) {
            for (int j = 0; j < cookies.length; j++) {
                if (cookies[j].getName().equals("email")) {
                    emailCookie = cookies[j];
                }
                if (cookies[j].getName().equals("password")) {
                    passwordCookie = cookies[j];
                }
            }
        }
        if (request.getParameter("remember") != null) {
            maxAge = 7 * 24 * 60 * 60 * 1000;//记录一个月
        } else {
            maxAge = 0;//删除
        }
        //判断cookie是否存在
        if (emailCookie == null) {
            emailCookie = new Cookie("email", request.getParameter("email"));
            emailCookie.setPath(request.getContextPath());
            emailCookie.setMaxAge(maxAge);
            response.addCookie(emailCookie);
        } else {
            emailCookie.setValue(request.getParameter("email"));
            emailCookie.setMaxAge(maxAge);
            response.addCookie(emailCookie);
        }

        //判断cookie是否存在
        if (passwordCookie == null) {
            passwordCookie = new Cookie("password", request.getParameter("password"));
            passwordCookie.setPath(request.getContextPath());
            passwordCookie.setMaxAge(maxAge);
            response.addCookie(passwordCookie);
        } else {
            passwordCookie.setValue(request.getParameter("password"));
            passwordCookie.setMaxAge(maxAge);
            response.addCookie(passwordCookie);
        }
        response.sendRedirect("shoppingPage.jsp");
    } else {
%>
<jsp:forward page="error.jsp"/>
<%
    }
%>
