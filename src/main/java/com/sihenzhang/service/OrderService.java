package com.sihenzhang.service;

import com.sihenzhang.pojo.Cart;
import com.sihenzhang.pojo.Order;
import com.sihenzhang.pojo.OrderItem;
import com.sihenzhang.pojo.Page;

import java.util.List;

public interface OrderService {
    String createOrder(Cart cart, Long userId);

    Order queryOrderById(String orderId);

    List<Order> queryOrders();

    Page<Order> page(long current, long size);

    List<Order> queryOrdersByUserId(Long userId);

    Page<Order> pageByUserId(Long userId, long current, long size);

    List<OrderItem> queryOrderDetails(String orderId);

    void sendOrder(String orderId);

    void receiveOrder(String orderId);
}
