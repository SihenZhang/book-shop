package com.sihenzhang.web;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.lang.Dict;
import cn.hutool.json.JSONUtil;
import com.sihenzhang.pojo.Book;
import com.sihenzhang.pojo.Cart;
import com.sihenzhang.pojo.CartItem;
import com.sihenzhang.service.BookService;
import com.sihenzhang.service.impl.BookServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CartServlet", urlPatterns = "/cartServlet")
public class CartServlet extends BaseServlet {
    private final BookService bookService = new BookServiceImpl();

    protected void ajaxAddItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Convert.toLong(req.getParameter("id"), 0L);
        Book book = bookService.queryBookById(id);
        CartItem cartItem = new CartItem(book.getId(), book.getName(), 1, book.getPrice());
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            req.getSession().setAttribute("cart", cart);
        }
        cart.addItem(cartItem);
        req.getSession().setAttribute("lastItemName", cartItem.getName());
        Dict result = Dict.create().set("totalCount", cart.getTotalCount()).set("lastItemName", cartItem.getName());
        String jsonStr = JSONUtil.toJsonStr(result);
        resp.getWriter().write(jsonStr);
    }

    protected void deleteItem(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Convert.toLong(req.getParameter("id"), 0L);
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        if (cart != null) {
            cart.deleteItem(id);
        }
        resp.sendRedirect(req.getHeader("Referer"));
    }

    protected void clear(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        if (cart != null) {
            cart.clear();
        }
        resp.sendRedirect(req.getHeader("Referer"));
    }

    protected void ajaxUpdateCount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Convert.toLong(req.getParameter("id"), 0L);
        int count = Convert.toInt(req.getParameter("count"), 1);
        Cart cart = (Cart) req.getSession().getAttribute("cart");
        Dict result = Dict.create();
        if (cart != null) {
            cart.updateCount(id, count);
            result.set("id", id).set("count", cart.getItems().get(id).getCount()).set("totalCount", cart.getTotalCount()).set("totalPrice", cart.getTotalPrice());
            String jsonStr = JSONUtil.toJsonStr(result);
            resp.getWriter().write(jsonStr);
        } else {
            throw new ServletException("Cart should not be null.");
        }
    }
}
