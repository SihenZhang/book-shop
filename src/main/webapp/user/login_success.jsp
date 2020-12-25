<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
	<title>登录成功 - 书城</title>
	<%@ include file="../common/head.jsp" %>
</head>
<body class="d-flex flex-column h-100">
	<%@ include file="../common/shortcut.jsp" %>
	<%@ include file="../common/header_with_cart.jsp" %>
	<main class="container-fluid bg-light">
		<div id="welcome" class="container py-4">
			<h3>欢迎 <span class="text-red">${sessionScope.user.username}</span> 光临书城</h3>
			<p>3 秒钟后将自动跳转至主页，如果没有跳转请<a href="">点击此处</a></p>
		</div>
	</main>
	<%@ include file="../common/footer.jsp" %>
	<script>
		setTimeout(function () {
			location.replace('')
		}, 3000)
	</script>
</body>
</html>