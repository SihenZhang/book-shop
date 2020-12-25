<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav aria-label="Shortcut" id="shortcut" class="container-fluid small clearfix">
    <div class="container-lg">
        <div class="float-left">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="user/login.jsp">你好，请登录</a>&nbsp;&nbsp;<a class="text-red" href="user/register.jsp">免费注册</a>
                </c:when>
                <c:otherwise>
                    <span class="text-muted"><span class="text-red">${sessionScope.user.username}</span>，欢迎您</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="float-right">
            <c:if test="${not empty sessionScope.user}">
                <ul class="nav">
                    <li class="nav-item"><a class="nav-link py-0" href="client/orderServlet?action=page">我的订单</a></li>
                    <li class="nav-item spacer">|</li>
                    <li class="nav-item"><a class="nav-link py-0" href="manager/manager.jsp">后台管理</a></li>
                    <li class="nav-item spacer">|</li>
                    <li class="nav-item"><a class="nav-link text-red py-0" href="userServlet?action=logout">注销</a></li>
                </ul>
            </c:if>
        </div>
    </div>
</nav>
