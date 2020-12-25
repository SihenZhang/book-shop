package com.sihenzhang.service.impl;

import cn.hutool.core.util.IdUtil;
import com.sihenzhang.dao.BookDao;
import com.sihenzhang.dao.OrderDao;
import com.sihenzhang.dao.OrderItemDao;
import com.sihenzhang.dao.impl.BookDaoImpl;
import com.sihenzhang.dao.impl.OrderDaoImpl;
import com.sihenzhang.dao.impl.OrderItemDaoImpl;
import com.sihenzhang.pojo.*;
import com.sihenzhang.service.OrderService;

import java.time.LocalDateTime;
import java.util.List;

public class OrderServiceImpl implements OrderService {
    private final BookDao bookDao = new BookDaoImpl();
    private final OrderDao orderDao = new OrderDaoImpl();
    private final OrderItemDao orderItemDao = new OrderItemDaoImpl();

    @Override
    public String createOrder(Cart cart, Long userId) {
        String orderId = IdUtil.getSnowflake(1, 1).nextIdStr();
        Order order = new Order(orderId, LocalDateTime.now(), cart.getTotalPrice(), 0, userId);
        orderDao.saveOrder(order);
        cart.getItems().values().forEach(cartItem -> {
            OrderItem orderItem = new OrderItem(null, cartItem.getName(), cartItem.getCount(), cartItem.getPrice(), orderId);
            orderItemDao.saveOrderItem(orderItem);
            Book book = bookDao.queryBookById(cartItem.getId());
            book.setSales(book.getSales() + cartItem.getCount());
            book.setStock(book.getStock() - cartItem.getCount());
            bookDao.updateBook(book);
        });
        cart.clear();
        return orderId;
    }

    @Override
    public Order queryOrderById(String orderId) {
        return orderDao.queryOrderById(orderId);
    }

    @Override
    public List<Order> queryOrders() {
        return orderDao.queryOrders();
    }

    @Override
    public Page<Order> page(long current, long size) {
        long total = orderDao.queryOrderCount();
        Page<Order> page = new Page<>(current, size, total);
        long begin = (page.getCurrent() - 1) * page.getSize();
        List<Order> records = orderDao.queryOrderPage(begin, page.getSize());
        page.setRecords(records);
        return page;
    }

    @Override
    public List<Order> queryOrdersByUserId(Long userId) {
        return orderDao.queryOrdersByUserId(userId);
    }

    @Override
    public Page<Order> pageByUserId(Long userId, long current, long size) {
        long total = orderDao.queryOrderCount();
        Page<Order> page = new Page<>(current, size, total);
        long begin = (page.getCurrent() - 1) * page.getSize();
        List<Order> records = orderDao.queryOrderPageByUserId(userId, begin, size);
        page.setRecords(records);
        return page;
    }

    @Override
    public List<OrderItem> queryOrderDetails(String orderId) {
        return orderItemDao.queryOrderItemsByOrderId(orderId);
    }

    @Override
    public void sendOrder(String orderId) {
        orderDao.changeOrderStatus(orderId, 1);
    }

    @Override
    public void receiveOrder(String orderId) {
        orderDao.changeOrderStatus(orderId, 2);
    }
}
