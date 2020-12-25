package com.sihenzhang.web;

import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public abstract class BaseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        // 从表单中获取业务字段 action
        String action = req.getParameter("action");
        if (StrUtil.isBlank(action)) {
            log.error("Required String parameter 'action' is not present");
            throw new NullPointerException("Required String parameter 'action' is not present");
        } else {
            // 获取相应的业务方法反射对象并执行
            ReflectUtil.invoke(this, action, req, resp);
        }
    }
}
