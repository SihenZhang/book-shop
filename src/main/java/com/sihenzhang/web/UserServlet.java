package com.sihenzhang.web;

import cn.hutool.captcha.ICaptcha;
import cn.hutool.core.lang.Dict;
import cn.hutool.extra.servlet.ServletUtil;
import cn.hutool.json.JSONUtil;
import com.sihenzhang.pojo.User;
import com.sihenzhang.service.UserService;
import com.sihenzhang.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserServlet", urlPatterns = "/userServlet")
public class UserServlet extends BaseServlet {
    private final UserService userService = new UserServiceImpl();

    protected void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User loginUser = userService.login(ServletUtil.fillBean(req, new User(), true));
        if (loginUser != null) {
            req.getSession().setAttribute("user", loginUser);
            req.getRequestDispatcher("/user/login_success.jsp").forward(req, resp);
        } else {
            req.setAttribute("msg", "用户名与密码不匹配，请重新输入");
            req.setAttribute("username", req.getParameter("username"));
            req.getRequestDispatcher("/user/login.jsp").forward(req, resp);
        }
    }

    protected void ajaxUsernameExists(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        boolean usernameExists = userService.existUsername(username);
        Dict result = Dict.create().set("usernameExists", usernameExists);
        String jsonStr = JSONUtil.toJsonStr(result);
        resp.getWriter().write(jsonStr);
    }

    protected void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        ICaptcha captcha = (ICaptcha) req.getSession().getAttribute("captcha");
        // 检查验证码是否正确
        if (captcha != null && captcha.verify(req.getParameter("captcha"))) {
            // 检查用户名是否存在
            if (!userService.existUsername(username)) {
                userService.registerUser(ServletUtil.fillBean(req, new User(), true));
                req.getRequestDispatcher("/user/register_success.jsp").forward(req, resp);
            } else {
                req.setAttribute("msg", "用户名已存在，请重新输入");
                req.setAttribute("username", username);
                req.setAttribute("email", email);
                req.setAttribute("password", password);
                req.getRequestDispatcher("/user/register.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("msg", "验证码错误，请重新输入");
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("password", password);
            req.getRequestDispatcher("/user/register.jsp").forward(req, resp);
        }
    }

    protected void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getSession().invalidate();
        resp.sendRedirect(req.getContextPath());
    }
}
