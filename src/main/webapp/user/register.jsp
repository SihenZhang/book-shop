<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="zh-CN">
<head>
    <title>新用户注册 - 书城</title>
    <%@ include file="../common/head.jsp" %>
    <link rel="stylesheet" href="static/css/user.css">
</head>
<body class="d-flex flex-column h-100">
    <c:set var="title" value="欢迎注册" />
    <%@ include file="../common/header.jsp" %>
    <main class="banner-container container-fluid">
        <div class="container row mx-auto py-4">
            <div class="col-lg-9 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <h1 class="h5 mb-4">新用户注册</h1>
                        <form id="registerForm" class="m-0" action="userServlet" method="post">
                            <input type="hidden" name="action" value="register">
                            <div class="form-group row mb-4">
                                <label for="inputUsername" class="col-2 col-form-label">用户名</label>
                                <div class="col-10">
                                    <input type="text" id="inputUsername" name="username" class="form-control${ fn:contains(requestScope.msg, "用户名") ? " is-invalid" : "" }" placeholder="请输入用户名" value="${ requestScope.username }" autocomplete="off">
                                    <div class="invalid-feedback position-absolute">${ fn:contains(requestScope.msg, "用户名") ? requestScope.msg : "" }</div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputEmail" class="col-2 col-form-label">电子邮箱</label>
                                <div class="col-10">
                                    <input type="email" id="inputEmail" name="email" class="form-control" placeholder="请输入电子邮箱" value="${ requestScope.email }" autocomplete="off">
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputPassword" class="col-2 col-form-label">登录密码</label>
                                <div class="col-10">
                                    <input type="password"id="inputPassword" name="password" class="form-control"  placeholder="请输入密码" value="${ requestScope.password }" autocomplete="off">
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputConfirmPassword" class="col-2 col-form-label">确认密码</label>
                                <div class="col-10">
                                    <input type="password" id="inputConfirmPassword" name="confirmPassword" class="form-control" placeholder="请再一次输入密码" value="${ requestScope.password }" autocomplete="off">
                                    <div class="invalid-feedback position-absolute"></div>
                                </div>
                            </div>
                            <div class="form-group row mb-4">
                                <label for="inputCaptcha" class="col-2 col-form-label">验证码</label>
                                <div class="col-md-8 col-sm-7 col-6">
                                    <input type="text" id="inputCaptcha" name="captcha" class="form-control${ fn:contains(requestScope.msg, "验证码") ? " is-invalid" : "" }" placeholder="请输入右侧图片中的验证码" autocomplete="off">
                                    <div class="invalid-feedback position-absolute">${ fn:contains(requestScope.msg, "验证码") ? requestScope.msg : "" }</div>
                                </div>
                                <div class="col-md-2 col-sm-3 col-4 d-flex justify-content-center align-items-start pl-0">
                                    <img id="captchaImg" src="captchaServlet?action=get" alt="验证码">
                                </div>
                            </div>
                            <input type="submit" id="registerBtn" class="btn btn-danger btn-block" value="立即注册">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%@ include file="../common/footer.jsp" %>
    <script src="static/js/register.js"></script>
</body>
</html>
