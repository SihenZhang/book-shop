$('[data-toggle="popover"]').popover()

let oldCount
const $inputCount = $('.input-count')
const $subBtn = $('.btn-sub')
const $incBtn = $('.btn-inc')
const $updateCountModal = $('#updateCountModal')
const $cartTotalCount = $('#cartTotalCount')
const $totalCount = $('#totalCount')
const $totalPrice = $('#totalPrice')
const $deleteModal = $('#deleteModal')

$inputCount.each(function () {
    const $elem = $(this)
    const $subBtn = $elem.parent().find('.btn-sub')
    if ($elem.val() <= 1) {
        $subBtn.attr('disabled', 'disabled')
    }
})

changeCount = function ($elem, id, count) {
    const $sub = $elem.prev().children('.btn-sub')
    $.getJSON(location.origin + '/bookshop/cartServlet', { action: 'ajaxUpdateCount', id: id, count: count })
        .done(function (data) {
            $elem.val(data.count)
            if (data.count <= 1) {
                $sub.attr('disabled', 'disabled')
            } else {
                $sub.removeAttr('disabled')
            }
            $cartTotalCount.text(data.totalCount)
            $totalCount.text(data.totalCount)
            $totalPrice.text(data.totalPrice.toFixed(2))
        })
        .fail(function () {
            $updateCountModal.find('.modal-body p').text('修改商品数量失败')
            $updateCountModal.modal('show')
            $elem.val(oldCount)
        })
}

$inputCount.focus(function () {
    oldCount = $(this).val()
})

$inputCount.change(function () {
    const $elem = $(this)
    const $sub = $elem.prev().children('.btn-sub')
    const id = $elem.parent().data('id')
    const count = $elem.val() - 0
    if (count <= 0) {
        $updateCountModal.find('.modal-body p').text('商品数量必须大于0')
        $updateCountModal.modal('show')
        $elem.val(oldCount)
        return
    }
    if (count <= 1) {
        $sub.attr('disabled', 'disabled')
    } else {
        $sub.removeAttr('disabled')
    }
    changeCount($elem, id, count)
})

$inputCount.keydown(function (event) {
    const $elem = $(this)
    if (event.which === 13) {
        $elem.blur()
    }
    return true
})

$subBtn.click(function () {
    const $elem = $(this)
    const $input = $elem.parent().parent().children('.input-count')
    const id = $input.parent().data('id')
    oldCount = $input.val()
    const count = $input.val() - 0
    if (count <= 1) {
        $updateCountModal.find('.modal-body p').text('商品数量必须大于0')
        $updateCountModal.modal('show')
        return
    }
    $input.val(count - 1)
    if ($input.val() <= 1) {
        $elem.attr('disabled', 'disabled')
    }
    changeCount($input, id, count - 1)
})

$incBtn.click(function () {
    const $elem = $(this)
    const $input = $elem.parent().parent().children('.input-count')
    const id = $input.parent().data('id')
    oldCount = $input.val()
    const count = $input.val() - 0
    $input.val(count + 1)
    if ($input.val() > 1) {
        $elem.removeAttr('disabled')
    }
    changeCount($input, id, count + 1)
})

$deleteModal.on('show.bs.modal', function (event) {
    const $btn = $(event.relatedTarget)
    const itemId = $btn.data('item-id')
    $deleteModal.find('#deleteBtn').attr('href', 'cartServlet?action=deleteItem&id=' + itemId)
})