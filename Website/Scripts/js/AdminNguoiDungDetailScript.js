﻿$('.btndelete').click(e => {
    var el = e.delegateTarget;
    var id = el.getAttribute('data-id');
    var name = el.getAttribute('data-name');
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
})