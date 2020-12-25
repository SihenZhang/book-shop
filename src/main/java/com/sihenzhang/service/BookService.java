package com.sihenzhang.service;

import com.sihenzhang.pojo.Book;
import com.sihenzhang.pojo.Page;

import java.math.BigDecimal;
import java.util.List;

public interface BookService {
    void addBook(Book book);

    void deleteBookById(Long id);

    void updateBook(Book book);

    Book queryBookById(Long id);

    List<Book> queryBooks();

    Page<Book> page(long current, long size);

    Page<Book> pageByPrice(long current, long size, BigDecimal minPrice, BigDecimal maxPrice);

    Page<Book> pageBySearch(long current, long size, String searchOption, String searchContent);
}
