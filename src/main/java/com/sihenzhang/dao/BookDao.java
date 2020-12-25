package com.sihenzhang.dao;

import com.sihenzhang.pojo.Book;

import java.math.BigDecimal;
import java.util.List;

public interface BookDao {
    int addBook(Book book);

    int deleteBookById(Long id);

    int updateBook(Book book);

    Book queryBookById(Long id);

    List<Book> queryBooks();

    long queryBookCount();

    List<Book> queryBookPage(long begin, long size);

    long queryBookCountByPrice(BigDecimal minPrice, BigDecimal maxPrice);

    List<Book> queryBookPageByPrice(long begin, long size, BigDecimal minPrice, BigDecimal maxPrice);

    long queryBookCountByName(String searchContent);

    List<Book> queryBookPageByName(long begin, long size, String searchContent);

    long queryBookCountByAuthor(String searchContent);

    List<Book> queryBookPageByAuthor(long begin, long size, String searchContent);
}
