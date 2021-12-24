$(document).ready(function () {
    $('#nhatro').change(e => {
        var id = $('#nhatro').val();
        $('.hinhanh').hide('slow');
        if (!id) {
            $('.hinhanh').show('slow');
        }
        else {
            $('.nt_' + id).show('slow');
        }
    });

    $('.manager').click(e => {
        var finder = new CKFinder();
        finder.selectActionFunction = function (fileUrl) {
            $('#ten_anh').val(fileUrl);
            $('#img-temp').attr('src', fileUrl);
        }
        finder.popup();
    })

    Fancybox.bind("[data-fancybox]", {
        // Your options go here
    });
});