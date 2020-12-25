package com.sihenzhang.web;

import cn.hutool.core.convert.Convert;
import com.sihenzhang.pojo.Order;
import com.sihenzhang.pojo.OrderItem;
import com.sihenzhang.pojo.Page;
import com.sihenzhang.service.OrderService;
import com.sihenzhang.service.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = "/manager/orderServlet")
public class OrderServlet extends BaseServlet {
    private final OrderService orderService = new OrderServiceImpl();

    protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Order> orders = orderService.queryOrders();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/manager/order_manager.jsp").forward(req, resp);
    }

    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long current = Convert.toLong(req.getParameter("current"), 1L);
        long size = Convert.toLong(req.getParameter("size"), 5L);
        Page<Order> page = orderService.page(current, size);
        page.setUrl("manager/orderServlet?action=page");
        req.setAttribute("page", page);
        req.getRequestDispatcher("/manager/order_manager.jsp").forward(req, resp);
    }

    protected void listDetails(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("orderId");
        List<OrderItem> orderItems = orderService.queryOrderDetails(orderId);
        req.setAttribute("orderItems", orderItems);
        Order order = orderService.queryOrderById(orderId);
        req.setAttribute("order", order);
        req.getRequestDispatcher("/manager/order_details.jsp").forward(req, resp);
    }

    protected void send(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String orderId = req.getParameter("orderId");
        if (orderId != null) {
            orderService.sendOrder(orderId);
        }
        resp.sendRedirect(req.getHeader("Referer"));
    }
}
