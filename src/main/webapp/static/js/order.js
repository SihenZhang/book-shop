const $receiveModal = $('#receiveOrderModal')

$receiveModal.on('show.bs.modal', function (event) {
    const $btn = $(event.relatedTarget)
    const orderId = $btn.data('order-id')
    $receiveModal.find('#receiveOrderBtn').attr('href', 'client/orderServlet?action=receive&orderId=' + orderId)
})