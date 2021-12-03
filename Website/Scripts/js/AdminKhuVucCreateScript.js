$(document).ready(function () {
    $('#ma_ms').change(e => {
        var ma = $('#ma_ms').val();
        if (!ma)
            $('#preview-color').css('background', 'gray')
        else
            $('#preview-color').css('background', '#' + ma);
    })
})