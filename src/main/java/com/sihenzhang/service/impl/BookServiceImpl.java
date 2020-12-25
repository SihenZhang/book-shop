package com.sihenzhang.service.impl;

import cn.hutool.core.util.StrUtil;
import com.sihenzhang.dao.BookDao;
import com.sihenzhang.dao.impl.BookDaoImpl;
import com.sihenzhang.pojo.Book;
import com.sihenzhang.pojo.Page;
import com.sihenzhang.service.BookService;

import java.math.BigDecimal;
import java.util.List;

public class BookServiceImpl implements BookService {
    private final BookDao bookDao = new BookDaoImpl();

    @Override
    public void addBook(Book book) {
        bookDao.addBook(book);
    }

    @Override
    public void deleteBookById(Long id) {
        bookDao.deleteBookById(id);
    }

    @Override
    public void updateBook(Book book) {
        bookDao.updateBook(book);
    }

    @Override
    public Book queryBookById(Long id) {
        return bookDao.queryBookById(id);
    }

    @Override
    public List<Book> queryBooks() {
        return bookDao.queryBooks();
    }

    @Override
    public Page<Book> page(long current, long size) {
        long total = bookDao.queryBookCount();
        Page<Book> page = new Page<>(current, size, total);
        long begin = (page.getCurrent() - 1) * page.getSize();
        List<Book> records = bookDao.queryBookPage(begin, page.getSize());
        page.setRecords(records);
        return page;
    }

    @Override
    public Page<Book> pageByPrice(long current, long size, BigDecimal minPrice, BigDecimal maxPrice) {
        long total = bookDao.queryBookCountByPrice(minPrice, maxPrice);
        Page<Book> page = new Page<>(current, size, total);
        long begin = (page.getCurrent() - 1) * page.getSize();
        List<Book> records = bookDao.queryBookPageByPrice(begin, page.getSize(), minPrice, maxPrice);
        page.setRecords(records);
        return page;
    }

    @Override
    public Page<Book> pageBySearch(long current, long size, String searchOption, String searchContent) {
        if (StrUtil.isNotBlank(searchContent)) {
            searchContent = "%" + searchContent + "%";
            if (StrUtil.equalsAny(searchOption, "name", "author")) {
                long total = bookDao.queryBookCountByName(searchContent);
                Page<Book> page = new Page<>(current, size, total);
                long begin = (page.getCurrent() - 1) * page.getSize();
                List<Book> records;
                if ("name".equals(searchOption)) {
                    records = bookDao.queryBookPageByName(begin, page.getSize(), searchContent);
                } else {
                    records = bookDao.queryBookPageByAuthor(begin, page.getSize(), searchContent);
                }
                page.setRecords(records);
                return page;
            } else {
                return page(current, size);
            }
        } else {
            return page(current, size);
        }
    }
}
