package com.example.shopping;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "loginServlet", value = "/loginServlet")
public class LoginServlet extends HttpServlet {
    private String message;
    private DB_Bean db_bean;//数据库

    public void init() {
        message = "Hello World!";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        //连接数据库
        String sqlCon = "jdbc:sqlserver://139.224.221.148;database=JavaEE_Shopping";
        String sqlUserName = "QANstar";
        String sqlPassword = "Fa473184520403";
        db_bean = new DB_Bean(sqlCon,sqlUserName,sqlPassword);

        //登录检测
        String userName = request.getParameter("email");
        String userPassword = request.getParameter("password");
        boolean login_right = false;
        String sqlSearch = "SELECT * FROM dbo.ShoppingUser where name='" + userName + "' and Password='" + userPassword + "'";
        login_right = db_bean.searchDB(sqlSearch);
        db_bean.closeConnect();

        int maxAge;

        Cookie emailCookie = null;
        Cookie passwordCookie = null;
        Cookie[] cookies = request.getCookies();

        if (login_right) {
            //加入登录会话
            //获取会话
            HttpSession session = request.getSession();

            //存入登入会话
            session.setAttribute("login", request.getParameter("email"));
            session.setMaxInactiveInterval(2);
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
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    public void destroy() {
    }
}