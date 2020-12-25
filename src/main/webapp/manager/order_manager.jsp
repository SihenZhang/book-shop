<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>订单管理 - 书城</title>
    <%@ include file="../common/head.jsp" %>
    <link rel="stylesheet" href="static/css/manager.css">
</head>
<body class="d-flex flex-column h-100">
    <c:set var="title" value="订单管理系统" />
    <%@ include file="../common/shortcut.jsp" %>
    <%@ include file="../common/header_with_manager_nav.jsp" %>
    <main class="container-fluid bg-light">
        <div class="container py-4">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>订单号</th>
                        <th>日期</th>
                        <th>金额</th>
                        <th class="operation">状态</th>
                        <th class="operation">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${requestScope.page.records}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.createTime}</td>
                            <td>￥${order.price}</td>
                            <td class="operation">
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="badge badge-secondary badge-md">未发货</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="badge badge-primary badge-md">已发货</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-success badge-md">已签收</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="operation">
                                <a class="btn btn-info btn-icon btn-sm" href="manager/orderServlet?action=listDetails&orderId=${order.orderId}">
                                    <svg class="anticon anticon-unordered-list-outlined"><use xlink:href="static/ant-design-icons.svg#anticon-unordered-list-outlined"></use></svg>
                                    <span>详情</span>
                                </a>
                                <c:if test="${order.status == 0}">
                                    <button type="button" class="btn btn-primary btn-icon btn-sm" data-toggle="modal" data-target="#sendOrderModal" data-order-id="${order.orderId}">
                                        <svg class="anticon" viewBox="0 0 1024 1024" width="200" height="200"><path d="M960.046 259.657l-81.875-157.44C857.943 63.406 807.817 32.96 764 32.96H260.617c-43.68 0-93.943 30.24-114.377 68.777L64.434 256.023c-17.691 33.394-31.543 89.074-31.543 126.788V901.28c0.069 49.577 40.32 89.829 89.898 89.829H901.28c49.577 0 89.76-40.252 89.829-89.829V386.514c0-37.714-13.715-93.394-31.063-126.857zM117.37 284l81.806-154.286c10.217-19.2 39.497-36.96 61.44-36.96H764.07c21.805 0 50.88 17.692 61.028 37.029l81.806 157.508c3.908 7.543 7.543 17.143 10.834 27.429H105.371a187.886 187.886 0 0 1 12-30.72z m813.806 617.28c0 16.457-13.371 29.966-29.966 29.966H122.79a29.966 29.966 0 0 1-29.966-29.966V382.811c0-2.4 0.48-5.554 0.686-8.228h836.777c0.343 3.977 0.96 8.434 0.96 11.931V901.28z"></path><path d="M422.72 583.246H242.994a29.966 29.966 0 0 0 0 59.931h179.657a29.966 29.966 0 0 0 0-59.931z m-90.857 127.748h-89.829a29.966 29.966 0 0 0 0 59.863h89.829a29.966 29.966 0 0 0 0-59.863zM794.64 659.492a27.581 27.581 0 0 1-27.582 27.581l-240.425-0.01a27.571 27.571 0 0 1-27.571-27.581 27.571 27.571 0 0 1 27.571-27.582h240.435a27.581 27.581 0 0 1 27.571 27.592z"></path><path d="M786.55 678.979a27.556 27.556 0 0 1-38.989 0L638.034 569.457a27.566 27.566 0 0 1-0.005-38.99 27.561 27.561 0 0 1 38.999-0.01L786.56 639.98a27.55 27.55 0 0 1-0.01 38.999z"></path><path d="M638.034 789.381a27.571 27.571 0 0 0 38.994 0.01L786.56 679.86a27.556 27.556 0 0 0-0.005-38.989 27.566 27.566 0 0 0-38.994-0.01L638.029 750.392a27.546 27.546 0 0 0 0.005 38.99z"></path></svg>
                                        <span>发货</span>
                                    </button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <%@ include file="../common/pagination.jsp" %>
    </main>
    <%@ include file="../common/footer.jsp" %>
    <div class="modal fade" id="sendOrderModal" tabindex="-1" aria-labelledby="sendOrderModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom-0">
                    <h5 class="modal-title" id="sendOrderModalLabel">提示</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body py-1">
                    <svg class="anticon anticon-exclamation-circle-filled text-warning"><use xlink:href="static/ant-design-icons.svg#anticon-exclamation-circle-filled"></use></svg>
                    <p>是否要为此订单发货？</p>
                </div>
                <div class="modal-footer border-top-0">
                    <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">取消</button>
                    <a id="sendOrderBtn" class="btn btn-primary btn-sm" href="javascript:void(0);">确定</a>
                </div>
            </div>
        </div>
    </div>
    <script src="static/js/manager_modal.js"></script>
</body>
</html>
