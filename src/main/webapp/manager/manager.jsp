<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>后台管理 - 书城</title>
    <%@ include file="../common/head.jsp" %>
    <link rel="stylesheet" href="static/css/manager.css">
</head>
<body class="d-flex flex-column h-100">
    <c:set var="title" value="后台管理系统" />
    <%@ include file="../common/shortcut.jsp" %>
    <%@ include file="../common/header_with_manager_nav.jsp" %>
    <main class="container-fluid bg-light">
        <div id="welcome" class="container py-4">
            <h3>欢迎管理员进入后台管理系统</h3>
        </div>
    </main>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
