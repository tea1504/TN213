$(document).ready(function () {
    get_color.addEventListener("change", watchColorPicker, false);

    function watchColorPicker(e) {
        var color = e.target.value;
        $('#ma_ms').val(color.substring(1));
        $('#ten_ms').val(color);
    }

    $('.btnedit').click(e => {
        var el = e.delegateTarget;
        var ma = el.getAttribute('data-id');
        var name = el.getAttribute('data-name');
        $('#exampleModalLabel2').html('Chỉnh sửa màu ' + name);
        $('#ma_ms_edit').val(ma);
        $('#ma_ms_edit').css('background', '#' + ma);
        $('#ten_ms_edit').val(name);
    })

    $('.btndelete').click(e => {
        var el = e.delegateTarget;
        var ma = el.getAttribute('data-id');
        var name = el.getAttribute('data-name');
        var sl = el.getAttribute('data-sl');
        if (sl > 0) {
            Swal.fire('Không thể xóa', 'Màu ' + name + ' đang được dùng bạn không thể xóa', 'info');
        }
        else {
            Swal.fire({
                title: 'Bạn có chắc chắn muốn xóa màu ' + name + '?',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Xóa',
                denyButtonText: `Không xóa`,
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '/Admin/MauSac/Delete/' + ma;
                } else if (result.isDenied) {
                    Swal.fire('Đã hủy thao tác', '', 'info');
                }
            });
        }
    })

    $('[data-toggle="tooltip"]').tooltip();
    $('#myTable').DataTable();
});