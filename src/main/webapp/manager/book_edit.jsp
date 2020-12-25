<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>编辑图书 - 书城</title>
    <%@ include file="../common/head.jsp" %>
    <link rel="stylesheet" href="static/css/manager.css">
</head>
<body class="d-flex flex-column h-100">
    <c:set var="title" value="编辑图书" />
    <%@ include file="../common/shortcut.jsp" %>
    <%@ include file="../common/header_with_manager_nav.jsp" %>
    <main class="container-fluid bg-light">
        <div class="container row mx-auto py-4">
            <div class="col-lg-9 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <h1 class="h5 mb-4">编辑图书</h1>
                        <form id="editBookForm" class="m-0" action="manager/bookServlet" method="post">
                            <input type="hidden" name="action" value="${empty requestScope.book ? "add" : "update"}">
                            <input type="hidden" name="id" value="${requestScope.book.id}">
                            <input type="hidden" name="current" value="${param.current}">
                            <div class="form-group row mb-4">
                                <label for="inputName" class="col-2 col-form-label">名称</label>
                                <div class="col-10">
                                    <input type="text" id="inputName" name="name" class="form-control" placeholder="请输入图书名称" value="${requestScope.book.name}" autocomplete="off">
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputPrice" class="col-2 col-form-label">价格</label>
                                <div class="col-10">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">￥</span>
                                        </div>
                                        <input type="number" id="inputPrice" name="price" class="form-control" placeholder="请输入图书价格" step="0.01" value="${requestScope.book.price}" autocomplete="off">
                                    </div>
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputAuthor" class="col-2 col-form-label">作者</label>
                                <div class="col-10">
                                    <input type="text" id="inputAuthor" name="author" class="form-control" placeholder="请输入图书作者" value="${requestScope.book.author}" autocomplete="off">
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputSales" class="col-2 col-form-label">销量</label>
                                <div class="col-10">
                                    <input type="number" id="inputSales" name="sales" class="form-control" placeholder="请输入图书销量" value="${requestScope.book.sales}" autocomplete="off">
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputStock" class="col-2 col-form-label">库存</label>
                                <div class="col-10">
                                    <input type="number" id="inputStock" name="stock" class="form-control" placeholder="请输入图书库存" value="${requestScope.book.stock}" autocomplete="off">
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <input type="submit" id="editBookBtn" class="btn btn-danger btn-block" value="提交">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
