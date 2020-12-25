package com.sihenzhang.dao.impl;

import com.sihenzhang.dao.OrderDao;
import com.sihenzhang.pojo.Order;

import java.util.List;

public class OrderDaoImpl extends BaseDao implements OrderDao {
    @Override
    public int saveOrder(Order order) {
        String sql = "INSERT INTO `t_order`(`order_id`,`create_time`,`price`,`status`,`user_id`) VALUES (?,?,?,?,?)";
        return update(sql, order.getOrderId(), order.getCreateTime(), order.getPrice(), order.getStatus(), order.getUserId());
    }

    @Override
    public int changeOrderStatus(String orderId, Integer status) {
        String sql = "UPDATE `t_order` SET `status` = ? WHERE `order_id` = ?";
        return update(sql, status, orderId);
    }

    @Override
    public Order queryOrderById(String orderId) {
        String sql = "SELECT `order_id` AS `orderId`,`create_time` AS `createTime`,`price`,`status`,`user_id` FROM `t_order` WHERE `order_id` = ?";
        return queryForOne(Order.class, sql, orderId);
    }

    @Override
    public List<Order> queryOrders() {
        String sql = "SELECT `order_id` AS `orderId`,`create_time` AS `createTime`,`price`,`status`,`user_id` FROM `t_order`";
        return queryForList(Order.class, sql);
    }

    @Override
    public long queryOrderCount() {
        String sql = "SELECT COUNT(1) FROM `t_order`";
        Number count = queryForSingleNumber(sql);
        return count.longValue();
    }

    @Override
    public List<Order> queryOrdersByUserId(Long userId) {
        String sql = "SELECT `order_id` AS `orderId`,`create_time` AS `createTime`,`price`,`status`,`user_id` FROM `t_order` WHERE `user_id` = ?";
        return queryForList(Order.class, sql, userId);
    }

    @Override
    public List<Order> queryOrderPage(long begin, long size) {
        String sql = "SELECT `order_id` AS `orderId`,`create_time` AS `createTime`,`price`,`status`,`user_id` FROM `t_order` LIMIT ?,?";
        return queryForList(Order.class, sql, begin, size);
    }

    @Override
    public List<Order> queryOrderPageByUserId(Long userId, long begin, long size) {
        String sql = "SELECT `order_id` AS `orderId`,`create_time` AS `createTime`,`price`,`status`,`user_id` FROM `t_order` WHERE `user_id` = ? LIMIT ?,?";
        return queryForList(Order.class, sql, userId, begin, size);
    }
}
