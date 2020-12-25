const $username = $('#inputUsername')
const usernameValidator = new Validator($username, [
    {
        strategy: 'isEmpty',
        errorMsg: '用户名不能为空'
    },
    {
        strategy: 'betweenLength',
        paramList: [5, 12],
        errorMsg: '用户名必须为5-12位字符'
    },
    {
        strategy: 'isGeneralWithChinese',
        errorMsg: '用户名应由中文、字母、数字或下划线组成'
    }
])
const $email = $('#inputEmail')
const emailValidator = new Validator($email, [
    {
        strategy: 'isEmpty',
        errorMsg: '邮箱不能为空'
    },
    {
        strategy: 'isEmail',
        errorMsg: '请输入合法的邮箱'
    }
])
const $password = $('#inputPassword')
const passwordRegex = /^[a-zA-Z0-9!@#$%^&*]{6,20}$/
const passwordValidator = new Validator($password, [
    {
        strategy: 'isEmpty',
        errorMsg: '密码不能为空'
    },
    {
        strategy: 'betweenLength',
        paramList: [6, 20],
        errorMsg: '密码必须为6-20位字符'
    },
    {
        strategy: 'matchRegex',
        paramList: [passwordRegex],
        errorMsg: '密码应由字母、数字或其它符号组成'
    }
])
const $confirmPassword = $('#inputConfirmPassword')
const confirmPasswordValidator = new Validator($confirmPassword, [
    {
        strategy: 'isEmpty',
        errorMsg: '密码不能为空'
    },
    {
        strategy: 'betweenLength',
        paramList: [6, 20],
        errorMsg: '密码必须为6-20位字符'
    },
    {
        strategy: 'matchRegex',
        paramList: [passwordRegex],
        errorMsg: '密码应由字母、数字或其它符号组成'
    },
    {
        strategy: 'notEqualToElem',
        paramList: [$password],
        errorMsg: '两次输入的密码不一致，请重新输入'
    }
])
const $captcha = $('#inputCaptcha')
const captchaValidator = new Validator($captcha, [
    {
        strategy: 'isEmpty',
        errorMsg: '请输入验证码'
    },
    {
        strategy: 'betweenLength',
        paramList: [5, 5],
        errorMsg: '验证码必须为5位字符'
    },
    {
        strategy: 'isAlnum',
        errorMsg: '验证码应由字母或数字组成'
    }
])
const $registerForm = $('#registerForm')
const $registerBtn = $('#registerBtn')

usernameValidation = function () {
    let validation = $username.validation(usernameValidator)
    if (validation) {
        const username = $username.val()
        $.getJSON(location.origin + '/book-shop/userServlet', { action: 'ajaxUsernameExists', username: username })
            .done(function (data) {
                validation = !data.usernameExists
                if (!validation) {
                    $username.addClass('is-invalid')
                    $username.removeClass('is-valid')
                    $username.siblings('.invalid-feedback').text('用户名已存在')
                }
            })
    }
    return validation
}
$username.blur(usernameValidation)

emailValidation = function () {
    return $email.validation(emailValidator)
}
$email.blur(emailValidation)

passwordValidation = function () {
    return $password.validation(passwordValidator)
}
$password.blur(passwordValidation)

confirmPasswordValidation = function () {
    return $confirmPassword.validation(confirmPasswordValidator)
}
$confirmPassword.blur(confirmPasswordValidation)

captchaValidation = function () {
    return $captcha.validation(captchaValidator)
}
$captcha.blur(captchaValidation)

$('#captchaImg').click(function () {
    this.src = 'captchaServlet?action=get&d=' + new Date().getTime()
})

$registerForm.submit(function () {
    if ($registerBtn.hasClass('disabled')) {
        return false
    }
    const validation = !!(usernameValidation() & emailValidation() & passwordValidation() & confirmPasswordValidation() & captchaValidation())
    if (!validation) {
        return false
    }
    $registerBtn.addClass('disabled')
    $registerBtn.val('正在注册...')
    return true
})