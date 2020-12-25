<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>图书管理 - 书城</title>
    <%@ include file="../common/head.jsp" %>
    <link rel="stylesheet" href="static/css/manager.css">
</head>
<body class="d-flex flex-column h-100">
    <c:set var="title" value="图书管理系统" />
    <%@ include file="../common/shortcut.jsp" %>
    <%@ include file="../common/header_with_manager_nav.jsp" %>
    <main class="container-fluid bg-light">
        <div class="container py-4">
            <div class="row mb-3">
                <form id="searchBar" class="row col-lg-5 col-md-7 col-sm-8" action="manager/bookServlet" method="get">
                    <input type="hidden" name="action" value="pageBySearch">
                    <div class="col-4">
                        <label for="inputSearchOption" class="sr-only">搜索方式</label>
                        <select id="inputSearchOption" name="searchOption" class="form-control">
                            <option value="name"${empty param.searchOption or param.searchOption eq 'author' ? " selected" : ""}>书名</option>
                            <option value="author"${param.searchOption eq 'author' ? " selected" : ""}>作者</option>
                        </select>
                    </div>
                    <div class="input-group col-8 pl-0">
                        <label for="inputSearchContent" class="sr-only">搜索内容</label>
                        <input type="text" id="inputSearchContent" name="searchContent" class="form-control" value="${param.searchContent}">
                        <div class="input-group-append">
                            <button type="submit" class="btn btn-outline-secondary">
                                <svg class="anticon anticon-search-outlined">
                                    <use xlink:href="static/ant-design-icons.svg#anticon-search-outlined"></use>
                                </svg>
                            </button>
                        </div>
                    </div>
                </form>
                <div class="col-lg-2 col-md-3 col-sm-4">
                    <a class="btn btn-success btn-icon" href="manager/book_edit.jsp?current=${requestScope.page.newPages}">
                        <svg class="anticon anticon-plus-outlined">
                            <use xlink:href="static/ant-design-icons.svg#anticon-plus-outlined"></use>
                        </svg>
                        <span>添加图书</span>
                    </a>
                </div>
            </div>
            <table id="bookList" class="table table-striped">
                <thead>
                    <tr>
                        <th>名称</th>
                        <th>价格</th>
                        <th>作者</th>
                        <th>销量</th>
                        <th>库存</th>
                        <th class="operation">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${requestScope.page.records}">
                        <tr>
                            <td>${book.name}</td>
                            <td>￥${book.price}</td>
                            <td>${book.author}</td>
                            <td>${book.sales}</td>
                            <td>${book.stock}</td>
                            <td class="operation">
                                <a class="btn btn-primary btn-icon btn-sm" href="manager/bookServlet?action=get&id=${book.id}&current=${requestScope.page.current}">
                                    <svg class="anticon anticon-edit-outlined"><use xlink:href="static/ant-design-icons.svg#anticon-edit-outlined"></use></svg>
                                    <span>修改</span>
                                </a>
                                <button type="button" class="btn btn-danger btn-icon btn-sm" data-toggle="modal" data-target="#deleteModal" data-book-id="${book.id}">
                                    <svg class="anticon anticon-delete-outlined"><use xlink:href="static/ant-design-icons.svg#anticon-delete-outlined"></use></svg>
                                    <span>删除</span>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <%@ include file="../common/pagination.jsp" %>
    </main>
    <%@ include file="../common/footer.jsp" %>
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom-0">
                    <h5 class="modal-title" id="deleteModalLabel">提示</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body py-1">
                    <svg class="anticon anticon-exclamation-circle-filled text-warning"><use xlink:href="static/ant-design-icons.svg#anticon-exclamation-circle-filled"></use></svg>
                    <p>此操作将永久删除该书籍, 是否继续？</p>
                </div>
                <div class="modal-footer border-top-0">
                    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">取消</button>
                    <a id="deleteBtn" class="btn btn-primary btn-sm" href="javascript:void(0);">确定</a>
                </div>
            </div>
        </div>
    </div>
    <script src="static/js/manager_modal.js"></script>
</body>
</html>
