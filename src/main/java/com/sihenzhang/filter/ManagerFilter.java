package com.sihenzhang.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "ManagerFilter", urlPatterns = "/manager/*")
public class ManagerFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        Object user = req.getSession().getAttribute("user");
        if (user == null) {
            HttpServletResponse resp = (HttpServletResponse) response;
            resp.sendRedirect(req.getContextPath() + "/user/login.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }
}
