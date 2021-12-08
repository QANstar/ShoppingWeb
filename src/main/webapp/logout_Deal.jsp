<%--
  Created by IntelliJ IDEA.
  User: 14353
  Date: 2021/12/4
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //删除登录session
    session.removeAttribute("login");
    response.sendRedirect("index.jsp");
%>