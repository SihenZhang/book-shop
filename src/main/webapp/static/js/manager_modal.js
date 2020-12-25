const $deleteModal = $('#deleteModal')

$deleteModal.on('show.bs.modal', function (event) {
    const $btn = $(event.relatedTarget)
    const bookId = $btn.data('book-id')
    const current = $.getUrlParam('current', '1')
    $deleteModal.find('#deleteBtn').attr('href', 'manager/bookServlet?action=delete&id=' + bookId + '&current=' + current)
})