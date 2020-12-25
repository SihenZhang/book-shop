<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>欢迎登录 - 书城</title>
    <%@ include file="../common/head.jsp" %>
    <link rel="stylesheet" href="static/css/user.css">
</head>
<body class="d-flex flex-column h-100">
    <c:set var="title" value="欢迎登录" />
    <%@ include file="../common/header.jsp" %>
    <main class="banner-container container-fluid">
        <div class="login-banner container row mx-auto py-4">
            <div class="col-lg-4 col-md-6 ml-auto">
                <div class="card">
                    <div class="card-body">
                        <h3 class="h5 mb-0">账户登录</h3>
                        <div class="msg-wrap">
                            <div class="msg-error alert alert-danger${ empty requestScope.msg ? " d-none" : "" }">
                                <svg class="anticon anticon-minus-circle-filled">
                                    <use xlink:href="static/ant-design-icons.svg#anticon-minus-circle-filled"></use>
                                </svg>
                                <span>${ requestScope.msg }</span>
                            </div>
                        </div>
                        <form id="loginForm" class="m-0" action="userServlet" method="post">
                            <input type="hidden" name="action" value="login">
                            <div class="input-group mb-4">
                                <label for="inputUsername" class="input-group-prepend mb-0">
                                    <span class="input-group-text px-2">
                                        <svg class="anticon anticon-user-outlined"><use xlink:href="static/ant-design-icons.svg#anticon-user-outlined"></use></svg>
                                    </span>
                                </label>
                                <input type="text" id="inputUsername" name="username" class="form-control rounded-right" placeholder="用户名" value="${ requestScope.username }">
                                <div class="invalid-feedback"></div>
                            </div>
                            <div class="input-group mb-4">
                                <label for="inputPassword" class="input-group-prepend mb-0">
                                    <span class="input-group-text px-2">
                                        <svg class="anticon anticon-unlock-outlined">
                                            <use xlink:href="static/ant-design-icons.svg#anticon-unlock-outlined"></use>
                                        </svg>
                                    </span>
                                </label>
                                <input type="password" id="inputPassword" name="password" class="form-control rounded-right${ empty requestScope.msg ? "" : " is-invalid" }" placeholder="密码">
                                <div class="invalid-feedback"></div>
                            </div>
                            <input type="submit" id="loginBtn" class="btn btn-danger btn-block" value="登录">
                        </form>
                    </div>
                    <div class="card-footer clearfix">
                        <a class="btn btn-link btn-icon btn-sm float-right" href="user/register.jsp">
                            <svg class="anticon anticon-right-circle-outlined">
                                <use xlink:href="static/ant-design-icons.svg#anticon-right-circle-outlined"></use>
                            </svg>
                            <span>立即注册</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="../common/footer.jsp" %>
    <script src="static/js/login.js"></script>
</body>
</html>
