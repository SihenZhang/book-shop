<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
	<title>我的订单 - 书城</title>
	<%@ include file="../common/head.jsp" %>
</head>
<body class="d-flex flex-column h-100">
	<c:set var="title" value="我的订单" />
	<%@ include file="../common/shortcut.jsp" %>
	<%@ include file="../common/header_with_cart.jsp" %>
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
								<a class="btn btn-info btn-icon btn-sm" href="client/orderServlet?action=listDetails&orderId=${order.orderId}">
									<svg class="anticon anticon-unordered-list-outlined"><use xlink:href="static/ant-design-icons.svg#anticon-unordered-list-outlined"></use></svg>
									<span>详情</span>
								</a>
								<c:if test="${order.status == 1}">
									<a class="btn btn-success btn-icon btn-sm" href="client/orderServlet?action=receive&orderId=${order.orderId}">
										<svg class="anticon" viewBox="0 0 1024 1024" width="200" height="200"><path d="M960.046 259.657l-81.875-157.44C857.943 63.406 807.817 32.96 764 32.96H260.617c-43.68 0-93.943 30.24-114.377 68.777L64.434 256.023c-17.691 33.394-31.543 89.074-31.543 126.788V901.28c0.069 49.577 40.32 89.829 89.898 89.829H901.28c49.577 0 89.76-40.252 89.829-89.829V386.514c0-37.714-13.715-93.394-31.063-126.857zM117.37 284l81.806-154.286c10.217-19.2 39.497-36.96 61.44-36.96H764.07c21.805 0 50.88 17.692 61.028 37.029l81.806 157.508c3.908 7.543 7.543 17.143 10.834 27.429H105.371a187.886 187.886 0 0 1 12-30.72z m813.806 617.28c0 16.457-13.371 29.966-29.966 29.966H122.79a29.966 29.966 0 0 1-29.966-29.966V382.811c0-2.4 0.48-5.554 0.686-8.228h836.777c0.343 3.977 0.96 8.434 0.96 11.931V901.28z"></path><path d="M763.726 539.429L612.869 700.57l-60.823-60.685a29.966 29.966 0 0 0-42.309 42.308l82.08 81.875a29.76 29.76 0 0 0 21.12 8.777 30.171 30.171 0 0 0 12.137-2.743 29.486 29.486 0 0 0 11.863-7.474l170.606-182.195a29.966 29.966 0 0 0-43.817-40.937zM422.72 583.246H242.994a29.966 29.966 0 0 0 0 59.931h179.657a29.966 29.966 0 0 0 0-59.931z m-90.857 127.748h-89.829a29.966 29.966 0 0 0 0 59.863h89.829a29.966 29.966 0 0 0 0-59.863z"></path></svg>
										<span>确认收货</span>
									</a>
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
</body>
</html>