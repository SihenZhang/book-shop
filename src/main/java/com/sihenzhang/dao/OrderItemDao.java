package com.sihenzhang.dao;

import com.sihenzhang.pojo.OrderItem;

import java.util.List;

public interface OrderItemDao {
    int saveOrderItem(OrderItem orderItem);

    List<OrderItem> queryOrderItemsByOrderId(String orderId);
}
