package com.sihenzhang.web;

import cn.hutool.core.convert.Convert;
import com.sihenzhang.pojo.Book;
import com.sihenzhang.pojo.Page;
import com.sihenzhang.service.BookService;
import com.sihenzhang.service.impl.BookServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "ClientBookServlet", urlPatterns = "/client/bookServlet")
public class ClientBookServlet extends BaseServlet {
    private final BookService bookService = new BookServiceImpl();

    protected void page(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long current = Convert.toLong(req.getParameter("current"), 1L);
        long size = Convert.toLong(req.getParameter("size"), 4L);
        Page<Book> page = bookService.page(current, size);
        page.setUrl("client/bookServlet?action=page");
        req.setAttribute("page", page);
        req.getRequestDispatcher("/client/index.jsp").forward(req, resp);
    }

    protected void pageByPrice(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long current = Convert.toLong(req.getParameter("current"), 1L);
        long size = Convert.toLong(req.getParameter("size"), 4L);
        BigDecimal minPrice = Convert.toBigDecimal(req.getParameter("minPrice"), BigDecimal.ZERO);
        BigDecimal maxPrice = Convert.toBigDecimal(req.getParameter("maxPrice"), BigDecimal.valueOf(Integer.MAX_VALUE));
        Page<Book> page = bookService.pageByPrice(current, size, minPrice, maxPrice);
        StringBuilder url = new StringBuilder("client/bookServlet?action=pageByPrice");
        if (req.getParameter("minPrice") != null) {
            url.append("&minPrice=").append(minPrice);
        }
        if (req.getParameter("maxPrice") != null) {
            url.append("&maxPrice=").append(maxPrice);
        }
        page.setUrl(url.toString());
        req.setAttribute("page", page);
        req.getRequestDispatcher("/client/index.jsp").forward(req, resp);
    }
}
