$(document).ready(function () {
    $('select').selectize({
        sortField: 'text'
    });

    $('#btn-reset').click(e => {
        var tk = $('#ma_nd').val();
        if (!tk) {
            Swal.fire({
                icon: 'warning',
                title: 'Cảnh báo',
                html: 'Bạn chưa chọn tài khoản'
            })
        }
        else {
            Swal.fire({
                title: 'Cấp lại mật khẩu cho tài khoản ' + tk + ' ?',
                html: `<p style="text-align: justify">
    Việc cấp lại mật khẩu phải được sự <strong style="color: blue; text-transform: uppercase;">ủy quyền</strong> của chủ tài khoản. Bạn <strong style="color: red; text-transform: uppercase;">không được phép</strong> tự ý thay đổi nếu không bạn phải <strong style="color: red; text-transform: uppercase;">chịu hoàn toàn</strong> trách nhiệm nếu hậu quả xảy ra.
</p>`,
                showCancelButton: true,
                confirmButtonText: 'Cấp mật khẩu',
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '/Admin/NguoiDung/Pass/' + tk,
                        type: 'post',
                        success: res => {
                            Swal.fire({
                                title: 'Mật khẩu đã được cấp lại',
                                html: `<table border="1" width="100%" cellpadding="5" cellspacing="0">
    <tr>
        <th>Tài khoản </th>
        <td>${tk}</td>
    </tr>
    <tr>
        <th>Mật khẩu mới </th>
        <td>${res}</td>
    </tr>
</table>`
                            })
                        },
                        error: err => {

                        }
                    })
                } else if (result.isDenied) {
                    Swal.fire('Đã hủy thao tác', '', 'info');
                }
            });
        }
    })
});