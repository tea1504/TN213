$(document).ready(function () {
    $('.btndong').click(e => {
        e.preventDefault();
        $('#createmodal').hide('slow');
        $('#editmodal').hide('slow');
    })

    $('.btncreate').click(e => {
        e.preventDefault();
        $('#createmodal').show('slow');
    })

    $('.btnedit').click(e => {
        e.preventDefault();
        var el = e.delegateTarget;
        var anh = el.getAttribute('data-anh');
        var nt = el.getAttribute('data-nt');
        var stt = el.getAttribute('data-STT');
        $('#editmodal').show('slow');
        $('#containerImgEdit').attr('src', anh);
    })

    $('[data-toggle="tooltip"]').tooltip();
    $('#myTable').DataTable();
});