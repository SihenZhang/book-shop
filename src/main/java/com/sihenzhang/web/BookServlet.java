package com.sihenzhang.web;

import cn.hutool.core.convert.Convert;
import cn.hutool.extra.servlet.ServletUtil;
import com.sihenzhang.pojo.Book;
import com.sihenzhang.pojo.Page;
import com.sihenzhang.service.BookService;
import com.sihenzhang.service.impl.BookServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "BookServlet", urlPatterns = "/manager/bookServlet")
public class BookServlet extends BaseServlet {
    private final BookService bookService = new BookServiceImpl();

    protected void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Book book = ServletUtil.fillBean(req, new Book(), true);
        long current = Convert.toLong(req.getParameter("current"), 1L);
        bookService.addBook(book);
        resp.sendRedirect(req.getContextPath() + "/manager/bookServlet?action=page&current=" + current);
    }

    protected void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Convert.toLong(req.getParameter("id"), 0L);
        bookService.deleteBookById(id);
        resp.sendRedirect(req.getHeader("Referer"));
    }

    protected void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Book book = ServletUtil.fillBean(req, new Book(), true);
        long current = Convert.toLong(req.getParameter("current"), 1L);
        bookService.updateBook(book);
        resp.sendRedirect(req.getContextPath() + "/manager/bookServlet?action=page&current=" + current);
    }

    protected void get(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Convert.toLong(req.getParameter("id"), 0L);
        Book book = bookService.queryBookById(id);
        req.setAttribute("book", book);
        req.getRequestDispatcher("/manager/book_edit.jsp").forward(req, resp);
    }

    protected void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> books = bookService.queryBooks();
        req.setAttribute("books", books);
        req.getRequestDispatcher("/manager/book_manager.jsp").forward(req, resp);
    }

    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long current = Convert.toLong(req.getParameter("current"), 1L);
        long size = Convert.toLong(req.getParameter("size"), 5L);
        Page<Book> page = bookService.page(current, size);
        page.setUrl("manager/bookServlet?action=page");
        req.setAttribute("page", page);
        req.getRequestDispatcher("/manager/book_manager.jsp").forward(req, resp);
    }

    protected void pageBySearch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long current = Convert.toLong(req.getParameter("current"), 1L);
        long size = Convert.toLong(req.getParameter("size"), 5L);
        String searchOption = Optional.ofNullable(req.getParameter("searchOption")).orElse("name");
        String searchContent = Optional.ofNullable(req.getParameter("searchContent")).orElse("").trim();
        Page<Book> page = bookService.pageBySearch(current, size, searchOption, searchContent);
        StringBuilder url = new StringBuilder("manager/bookServlet?action=pageBySearch");
        if (req.getParameter("searchOption") != null) {
            url.append("searchOption").append(searchOption);
        }
        if (req.getParameter("searchContent") != null) {
            url.append("searchContent").append(searchContent);
        }
        page.setUrl(url.toString());
        req.setAttribute("page", page);
        req.getRequestDispatcher("/manager/book_manager.jsp").forward(req, resp);
    }
}
