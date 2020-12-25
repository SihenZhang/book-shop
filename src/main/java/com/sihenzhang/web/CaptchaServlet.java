package com.sihenzhang.web;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.ICaptcha;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet(name = "CaptchaServlet", urlPatterns = "/captchaServlet")
public class CaptchaServlet extends BaseServlet {
    private static final ICaptcha CAPTCHA = CaptchaUtil.createShearCaptcha(240, 100);

    protected void get(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CAPTCHA.createCode();
        req.getSession().setAttribute("captcha", CAPTCHA);
        OutputStream outputStream = resp.getOutputStream();
        CAPTCHA.write(outputStream);
        outputStream.close();
    }
}
