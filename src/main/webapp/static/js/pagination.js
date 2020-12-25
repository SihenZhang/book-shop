$('#inputPageNum').change(function () {
    const val = $.trim($(this).val())
    if (val.length !== 0) {
        const valNum = Math.min(Math.max(parseInt(val), parseInt($(this).attr('min'))), parseInt($(this).attr('max')))
        const current = $.getUrlParam('current', '1')
        if (valNum !== parseInt(current)) {
            $.setUrlParam('current', valNum.toString())
        }
    }
})