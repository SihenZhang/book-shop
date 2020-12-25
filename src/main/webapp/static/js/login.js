const $username = $('#inputUsername')
const usernameValidator = new Validator($username, [
    {
        strategy: 'isEmpty',
        errorMsg: '请输入用户名'
    }
]);
const $password = $('#inputPassword')
const passwordValidator = new Validator($password, [
    {
        strategy: 'isEmpty',
        errorMsg: '请输入密码'
    }
]);

usernameValidation = function () {
    return $username.validation(usernameValidator, true)
}
$username.blur(usernameValidation)

passwordValidation = function () {
    return $password.validation(passwordValidator, true)
}
$password.blur(passwordValidation)

const $loginForm = $('#loginForm')
const $loginBtn = $('#loginBtn')
$loginForm.submit(function () {
    if ($loginBtn.hasClass('disabled')) {
        return false
    }
    const validation = !!(usernameValidation() & passwordValidation())
    if (!validation) {
        return false
    }
    $loginBtn.addClass('disabled')
    $loginBtn.val('正在登录...')
    return true
})