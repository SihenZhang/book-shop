<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<header class="container">
    <div id="logo" class="my-2 d-flex align-items-end">
        <h1 class="my-0">
            <a href="" title="书城">书城</a>
        </h1>
        <h2 class="ml-3 my-0 text-muted">${title}</h2>
    </div>
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link${fn:contains(title, "后台") ? " active" : ""}" href="manager/manager.jsp">欢迎</a>
        </li>
        <li class="nav-item">
            <a class="nav-link${fn:contains(title, "图书") ? " active" : ""}" href="manager/bookServlet?action=page">图书管理</a>
        </li>
        <li class="nav-item">
            <a class="nav-link${fn:contains(title, "订单") ? " active" : ""}" href="manager/orderServlet?action=page">订单管理</a>
        </li>
    </ul>
</header>
