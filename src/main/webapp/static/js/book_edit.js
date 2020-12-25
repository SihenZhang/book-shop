const $name = $('#inputName')
const nameValidator = new Validator($name, [
    {
        strategy: 'isEmpty',
        errorMsg: '图书名称不能为空'
    },
    {
        strategy: 'maxLength',
        paramList: [100],
        errorMsg: '图书名称最多为100位字符'
    }
])
const $price = $('#inputPrice')
const priceValidator = new Validator($price, [
    {
        strategy: 'isEmpty',
        errorMsg: '图书价格不能为空'
    },
    {
        strategy: 'isMoney',
        errorMsg: '图书价格应为一个合法的金额'
    }
])
const $author = $('#inputAuthor')
const authorValidator = new Validator($author, [
    {
        strategy: 'isEmpty',
        errorMsg: '图书作者不能为空'
    },
    {
        strategy: 'maxLength',
        paramList: [100],
        errorMsg: '图书作者名最多为100位字符'
    }
])
const $sales = $('#inputSales')
const salesValidator = new Validator($sales, [
    {
        strategy: 'isEmpty',
        errorMsg: '图书销量不能为空'
    },
    {
        strategy: 'isNumbers',
        errorMsg: '图书销量应为一个非负整数'
    }
])
const $stock = $('#inputStock')
const stockValidator = new Validator($stock, [
    {
        strategy: 'isEmpty',
        errorMsg: '图书库存不能为空'
    },
    {
        strategy: 'isNumbers',
        errorMsg: '图书库存应为一个非负整数'
    }
])
const $editForm = $('#editBookForm')
const $editBtn = $('#editBookBtn')

nameValidation = function () {
    return $name.validation(nameValidator)
}
$name.blur(nameValidation)

priceValidation = function () {
    return $price.validation(priceValidator)
}
$price.blur(priceValidation)

authorValidation = function () {
    return $author.validation(authorValidator)
}
$author.blur(authorValidation)

salesValidation = function () {
    return $sales.validation(salesValidator)
}
$sales.blur(salesValidation)

stockValidation = function () {
    return $stock.validation(stockValidator)
}
$stock.blur(stockValidation)

$editForm.submit(function () {
    if ($editBtn.hasClass('disabled')) {
        return false
    }
    const validation = !!(nameValidation() & priceValidation() & authorValidation() & salesValidation() & stockValidation())
    if (!validation) {
        return false
    }
    $editBtn.addClass('disabled')
    $editBtn.val('正在提交...')
    return true
})