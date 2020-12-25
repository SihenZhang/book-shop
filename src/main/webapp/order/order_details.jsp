<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
	<title>订单详情 - 书城</title>
	<%@ include file="../common/head.jsp" %>
</head>
<body class="d-flex flex-column h-100">
	<c:set var="title" value="订单详情" />
	<%@ include file="../common/shortcut.jsp" %>
	<%@ include file="../common/header_with_cart.jsp" %>
	<main class="container-fluid bg-light">
		<div class="container py-4">
			<table class="table table-striped">
				<thead>
				<tr>
					<th>商品名称</th>
					<th>单价</th>
					<th>数量</th>
					<th>小计</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="orderItem" items="${requestScope.orderItems}">
					<tr>
						<td>${orderItem.name}</td>
						<td>￥${orderItem.price}</td>
						<td>${orderItem.count}</td>
						<td class="font-weight-bold">￥${orderItem.totalPrice}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="d-flex justify-content-end align-items-center">
				<div>
					<span class="align-middle">总价： <span class="text-important">${requestScope.order.price}</span> 元</span>
					<span class="d-inline-block" data-toggle="popover" data-placement="top" data-trigger="hover" data-content="不含运费及送装服务费">
						<svg class="anticon anticon-bulb-outlined text-warning"><use xlink:href="static/ant-design-icons.svg#anticon-bulb-outlined"></use></svg>
					</span>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="../common/footer.jsp" %>
	<script>
		$('[data-toggle="popover"]').popover()
	</script>
</body>
</html>