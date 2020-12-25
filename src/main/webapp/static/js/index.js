$('button.add-to-cart').click(function () {
    const bookId = $(this).data('book-id')
    $.getJSON(location.origin + '/book-shop/cartServlet', { action: 'ajaxAddItem', id: bookId })
        .done(function (data) {
            const $count = $('#cartTotalCount')
            const $lastName = $('#cartLastItemName')
            $count.text(data.totalCount)
            $lastName.text(data.lastItemName)
            $lastName.parent().removeClass('d-none')
        })
})