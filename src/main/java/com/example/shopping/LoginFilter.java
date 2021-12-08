package com.example.shopping;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class LoginFilter  implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        //判断是否存在登录用户session
        if (session.getAttribute("login") != null) {
            chain.doFilter(servletRequest, servletResponse);
        } else {
            //没有则跳转回登录
            response.sendRedirect("index.jsp");
        }

    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
