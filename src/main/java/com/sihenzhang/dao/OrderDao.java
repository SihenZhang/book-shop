package com.sihenzhang.dao;

import com.sihenzhang.pojo.Order;

import java.util.List;

public interface OrderDao {
    int saveOrder(Order order);

    int changeOrderStatus(String orderId, Integer status);

    Order queryOrderById(String orderId);

    List<Order> queryOrders();

    long queryOrderCount();

    List<Order> queryOrdersByUserId(Long userId);

    List<Order> queryOrderPage(long begin, long size);

    List<Order> queryOrderPageByUserId(Long userId, long begin, long size);
}
