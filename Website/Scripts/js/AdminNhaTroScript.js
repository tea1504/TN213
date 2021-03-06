$(document).ready(function () {
    $('.btndelete').click(e => {
        var el = e.delegateTarget;
        var id = el.getAttribute('data-id');
        var name = el.getAttribute('data-name');
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa ' + name + '?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Xóa',
            denyButtonText: `Không xóa`,
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = '/Admin/NhaTro/Delete/' + id;
            } else if (result.isDenied) {
                Swal.fire('Đã hủy thao tác', '', 'info');
            }
        });
    })

    $('[data-toggle="tooltip"]').tooltip()
    $('#myTable').DataTable();
})