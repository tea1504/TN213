$(document).ready(function () {
    $('.btndelete').click(e => {
        var el = e.delegateTarget;
        var id = el.getAttribute('data-id');
        var name = el.getAttribute('data-name');
        var auth = $('#auth').val();
        if (auth !== id) {
            Swal.fire({
                title: 'Bạn có chắc chắn muốn xóa người dùng ' + name + '?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Xóa',
                denyButtonText: `Không xóa`,
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '/Admin/NguoiDung/Delete/' + id;
                } else if (result.isDenied) {
                    Swal.fire('Đã hủy thao tác', '', 'info');
                }
            });
        }
        else {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi...',
                    text: 'Bạn không thể tự xóa chính mình'
                })
        }
    })

    $('[data-toggle="tooltip"]').tooltip();
    Fancybox.bind("[data-fancybox]", {
    });
    $('#myTable').DataTable();
});