package com.sihenzhang.dao.impl;

import com.sihenzhang.dao.BookDao;
import com.sihenzhang.pojo.Book;

import java.math.BigDecimal;
import java.util.List;

public class BookDaoImpl extends BaseDao implements BookDao {
    @Override
    public int addBook(Book book) {
        String sql = "INSERT INTO `t_book`(`name`,`author`,`price`,`sales`,`stock`,`img_path`) VALUES (?,?,?,?,?,?)";
        return update(sql, book.getName(), book.getAuthor(), book.getPrice(), book.getSales(), book.getStock(), book.getImgPath());
    }

    @Override
    public int deleteBookById(Long id) {
        String sql = "DELETE FROM `t_book` WHERE `id`=?";
        return update(sql, id);
    }

    @Override
    public int updateBook(Book book) {
        String sql = "UPDATE `t_book` SET `name`=?,`author`=?,`price`=?,`sales`=?,`stock`=?,`img_path`=? WHERE `id`=?";
        return update(sql, book.getName(), book.getAuthor(), book.getPrice(), book.getSales(), book.getStock(), book.getImgPath(), book.getId());
    }

    @Override
    public Book queryBookById(Long id) {
        String sql = "SELECT `id`,`name`,`author`,`price`,`sales`,`stock`,`img_path` AS `imgPath` FROM `t_book` WHERE `id` = ?";
        return queryForOne(Book.class, sql, id);
    }

    @Override
    public List<Book> queryBooks() {
        String sql = "SELECT `id`,`name`,`author`,`price`,`sales`,`stock`,`img_path` AS `imgPath` FROM `t_book`";
        return queryForList(Book.class, sql);
    }

    @Override
    public long queryBookCount() {
        String sql = "SELECT COUNT(1) FROM `t_book`";
        Number count = queryForSingleNumber(sql);
        return count.longValue();
    }

    @Override
    public List<Book> queryBookPage(long begin, long size) {
        String sql = "SELECT `id`,`name`,`author`,`price`,`sales`,`stock`,`img_path` AS `imgPath` FROM `t_book` LIMIT ?,?";
        return queryForList(Book.class, sql, begin, size);
    }

    @Override
    public long queryBookCountByPrice(BigDecimal minPrice, BigDecimal maxPrice) {
        String sql = "SELECT COUNT(1) FROM `t_book` WHERE `price` BETWEEN ? AND ?";
        Number count = queryForSingleNumber(sql, minPrice, maxPrice);
        return count.longValue();
    }

    @Override
    public List<Book> queryBookPageByPrice(long begin, long size, BigDecimal minPrice, BigDecimal maxPrice) {
        String sql = "SELECT `id`,`name`,`author`,`price`,`sales`,`stock`,`img_path` AS `imgPath` FROM `t_book` WHERE `price` BETWEEN ? AND ? ORDER BY `price` LIMIT ?,?";
        return queryForList(Book.class, sql, minPrice, maxPrice, begin, size);
    }

    @Override
    public long queryBookCountByName(String searchContent) {
        String sql = "SELECT COUNT(1) FROM `t_book` WHERE `name` LIKE ?";
        Number count = queryForSingleNumber(sql, searchContent);
        return count.longValue();
    }

    @Override
    public List<Book> queryBookPageByName(long begin, long size, String searchContent) {
        String sql = "SELECT `id`,`name`,`author`,`price`,`sales`,`stock`,`img_path` AS `imgPath` FROM `t_book` WHERE `name` LIKE ? ORDER BY `name` LIMIT ?,?";
        return queryForList(Book.class, sql, searchContent, begin, size);
    }

    @Override
    public long queryBookCountByAuthor(String searchContent) {
        String sql = "SELECT COUNT(1) FROM `t_book` WHERE `author` LIKE ?";
        Number count = queryForSingleNumber(sql, searchContent);
        return count.longValue();
    }

    @Override
    public List<Book> queryBookPageByAuthor(long begin, long size, String searchContent) {
        String sql = "SELECT `id`,`name`,`author`,`price`,`sales`,`stock`,`img_path` AS `imgPath` FROM `t_book` WHERE `author` LIKE ? ORDER BY `author` LIMIT ?,?";
        return queryForList(Book.class, sql, searchContent, begin, size);
    }
}
