<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
	<title>注册成功 - 书城</title>
	<%@ include file="../common/head.jsp" %>
</head>
<body class="d-flex flex-column h-100">
	<%@ include file="../common/header_with_cart.jsp" %>
	<main class="container-fluid bg-light">
		<div id="welcome" class="container py-4">
			<h3 class="text-red">注册成功</h3>
			<p>3 秒钟后将自动跳转至登录页，如果没有跳转请<a href="user/login.jsp">点击此处</a></p>
		</div>
	</main>
	<%@ include file="../common/footer.jsp" %>
	<script>
		setTimeout(function () {
			location.replace('user/login.jsp')
		}, 3000)
	</script>
</body>
</html>