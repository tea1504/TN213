$(document).ready(function () {
    $('.delete').click(e => {
        var el = e.delegateTarget;
        var nt = el.getAttribute('data-nt');
        var nd = el.getAttribute('data-nd');
        var ngay = el.getAttribute('data-ngay');
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa bình luận?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Xóa',
            denyButtonText: `Không xóa`,
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = '/Admin/DanhGiaNhaTro/Delete?nt=' + nt + '&nd=' + nd + '&ngay=' + ngay;
            } else if (result.isDenied) {
                Swal.fire('Đã hủy thao tác', '', 'info');
            }
        });
    })
    $('#myTable').DataTable();
});