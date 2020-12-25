package com.sihenzhang.web;

import cn.hutool.core.convert.Convert;
import com.sihenzhang.pojo.*;
import com.sihenzhang.service.OrderService;
import com.sihenzhang.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClientOrderServlet", urlPatterns = "/client/orderServlet")
public class ClientOrderServlet extends BaseServlet {
    private final OrderService orderService = new OrderServiceImpl();

    protected void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/user/login.jsp");
            return;
        }
        Long userId = user.getId();
        String orderId = orderService.createOrder(cart, userId);
        req.setAttribute("orderId", orderId);
        req.getSession().setAttribute("orderId", orderId);
        resp.sendRedirect(req.getContextPath() + "/cart/checkout.jsp");
    }

    protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/user/login.jsp");
            return;
        }
        Long userId = user.getId();
        List<Order> myOrders = orderService.queryOrdersByUserId(userId);
        req.setAttribute("orders", myOrders);
        req.getRequestDispatcher("/order/order.jsp").forward(req, resp);
    }

    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/user/login.jsp");
            return;
        }
        Long userId = user.getId();
        long current = Convert.toLong(req.getParameter("current"), 1L);
        long size = Convert.toLong(req.getParameter("size"), 4L);
        Page<Order> page = orderService.pageByUserId(userId, current, size);
        page.setUrl("client/orderServlet?action=page");
        req.setAttribute("page", page);
        req.getRequestDispatcher("/order/order.jsp").forward(req, resp);
    }

    protected void listDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("orderId");
        List<OrderItem> orderItems = orderService.queryOrderDetails(orderId);
        req.setAttribute("orderItems", orderItems);
        Order order = orderService.queryOrderById(orderId);
        req.setAttribute("order", order);
        req.getRequestDispatcher("/order/order_details.jsp").forward(req, resp);
    }

    protected void receive(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("orderId");
        if (orderId != null) {
            orderService.receiveOrder(orderId);
        }
        resp.sendRedirect(req.getHeader("Referer"));
    }
}
