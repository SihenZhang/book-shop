<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
	<title>订单结算 - 书城</title>
	<%@ include file="../common/head.jsp" %>
</head>
<body class="d-flex flex-column h-100">
	<%@ include file="../common/shortcut.jsp" %>
	<%@ include file="../common/header_with_cart.jsp" %>
	<main class="container-fluid bg-light">
		<div class="container py-4">
			<div id="welcome">
				<h3>你的订单已结算，订单号为：<span class="text-red">${sessionScope.orderId}</span></h3>
				<p>3 秒钟后将自动跳转至我的订单页，如果没有跳转请<a href="client/orderServlet?action=page">点击此处</a></p>
			</div>
		</div>
	</main>
	<%@ include file="../common/footer.jsp" %>
	<script>
		setTimeout(function () {
			location.replace('client/orderServlet?action=page')
		}, 3000)
	</script>
</body>
</html>