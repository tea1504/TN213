$(document).ready(function () {
    $('.btndong').click(e => {
        e.preventDefault();
        $('#edit').hide('slow');
    });
    $('#btnedit').click(e => {
        e.preventDefault();
        $('#edit').show('slow');
    });
});