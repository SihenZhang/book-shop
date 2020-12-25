<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>书城首页 - 书城</title>
    <%@ include file="../common/head.jsp" %>
    <link rel="stylesheet" href="static/css/index.css">
</head>
<body class="d-flex flex-column h-100">
    <%@ include file="../common/shortcut.jsp" %>
    <%@ include file="../common/header_with_cart.jsp" %>
    <main class="container-fluid bg-light">
        <div class="container d-flex flex-column align-items-center py-4">
            <form class="mb-2" action="client/bookServlet" method="get">
                <input type="hidden" name="action" value="pageByPrice">
                <span>价格：</span>
                <input type="number" id="inputMinPrice" name="minPrice" class="form-control form-control-sm d-inline-block price" step="0.01" value="${param.minPrice}">
                <label for="inputMinPrice">元</label>
                <span> - </span>
                <input type="number" id="inputMaxPrice" name="maxPrice" class="form-control form-control-sm d-inline-block price" step="0.01" value="${param.maxPrice}">
                <label for="inputMaxPrice">元</label>
                <input type="submit" class="btn btn-sm btn-outline-danger ml-2" value="查询">
            </form>
            <div class="mb-2${not empty sessionScope.lastItemName and sessionScope.cart.totalCount > 0 ? "" : " d-none"}">
                您刚刚将 <span id="cartLastItemName" class="text-important">${sessionScope.lastItemName}</span> 加入到了购物车中
            </div>
            <div class="row w-100">
                <c:forEach var="book" items="${requestScope.page.records}">
                    <div class="col-lg-3 col-md-4 col-6 mb-4">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body">
                                <img class="card-img mb-2" src="${book.imgPath}" alt="${book.name}">
                                <h5 class="card-title">${book.name}</h5>
                                <h6 class="card-subtitle small text-muted text-truncate">${book.author}</h6>
                                <div class="text-red">￥<span class="text-important">${book.price}</span></div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>销量：<span class="font-weight-bold">${book.sales}</span></div>
                                    <div>库存：<span class="font-weight-bold">${book.stock}</span></div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button type="button" class="btn btn-danger add-to-cart" data-book-id="${book.id}">加入购物车</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <%@ include file="../common/pagination.jsp" %>
    </main>
    <%@ include file="../common/footer.jsp" %>
    <script src="static/js/index.js"></script>
</body>
</html>
