package com.sihenzhang.filter;

import com.sihenzhang.utils.DbUtils;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

@Slf4j
@WebFilter(filterName = "TransactionFilter", urlPatterns = "/*")
public class TransactionFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        try {
            chain.doFilter(request, response);
            DbUtils.commitAndClose();
        } catch (Exception e) {
            log.error("Failed to execute action method in servlet; nested exception is " + e, e);
            DbUtils.rollbackAndClose();
            throw new ServletException(e);
        }
    }
}
