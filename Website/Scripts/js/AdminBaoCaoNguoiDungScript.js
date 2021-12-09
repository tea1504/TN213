function edit(bbc, bc, lbc, ngay) {
    var data = {
        'nguoibibaocao': bbc,
        'nguoibaocao': bc,
        'ma_lbc': lbc,
        'ngay': ngay
    };
    $.ajax({
        url: '/Admin/BaoCaoNguoiDung/Edit',
        type: 'post',
        data: data,
        success: res => {
            window.location.href = '/Admin/BaoCaoNguoiDung/Index';
        },
        error: err => {
            Swal.fire({
                title: 'Lỗi',
                html: 'Lỗi server. Hiện tại không thể thực hiện thao tác',
                icon: 'error',
            })
        }
    })
}

$(document).ready(function () {
    $('.btndetail').click(e => {
        var el = e.delegateTarget;
        var bc = el.getAttribute('data-bc');
        var bbc = el.getAttribute('data-bbc');
        var lbc = el.getAttribute('data-lbc');
        var ngay = el.getAttribute('data-ngay');
        var data = {
            'nguoibibaocao': bbc,
            'nguoibaocao': bc,
            'ma_lbc': lbc,
            'ngay': ngay
        };
        $.ajax({
            url: '/Admin/BaoCaoNguoiDung/Detail',
            type: 'post',
            data: data,
            success: res => {
                $('#_tennd').html(res.nguoibaocao.ten);
                $('#_vaitro').html(res.nguoibaocao.vaitro);
                $('#_idnd').attr('href', '/Admin/NguoiDung/Detail/' + res.nguoibaocao.ma);
                $('#_anhnd').attr('src', res.nguoibaocao.anh);
                $('#_tennd2').html(res.nguoibibaocao.ten);
                $('#_vaitro2').html(res.nguoibibaocao.vaitro);
                $('#_idnd2').attr('href', '/Admin/NguoiDung/Detail/' + res.nguoibibaocao.ma);
                $('#_anhnd2').attr('src', res.nguoibibaocao.anh);
                $('#_ngay').html(res.ngay);
                $('#_tenlbc').html(res.loai);
                $('#_lydo').html(res.lydo);
                if (res.trangthai == 1) {
                    $('#_trangthai').html(`<span class="badge badge-pill badge-secondary">Chưa xử lý</span>`);
                    $('.modal-footer').html(`<button class="btn btn-light-success" onclick="edit(${bbc}, ${bc}, ${lbc}, '${ngay}')">Đã xử lý</button>`);
                }
                else {
                    $('#_trangthai').html(`<span class="badge badge-pill badge-success">Đã xử lý</span>`);
                    $('.modal-footer').html('');
                }
            },
            error: err => {
                Swal.fire({
                    title: 'Lỗi',
                    html: 'Lỗi server. Hiện tại không thể thực hiện thao tác',
                    icon: 'error',
                })
            }
        })
    })

    $('.btndelete').click(e => {
        var el = e.delegateTarget;
        var bc = el.getAttribute('data-bc');
        var bbc = el.getAttribute('data-bbc');
        var lbc = el.getAttribute('data-lbc');
        var ngay = el.getAttribute('data-ngay');
        var data = {
            'nguoibibaocao': bbc,
            'nguoibaocao': bc,
            'ma_lbc': lbc,
            'ngay': ngay
        };
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa ?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Xóa',
            denyButtonText: `Không xóa`,
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/Admin/BaoCaoNguoiDung/Delete',
                    type: 'post',
                    data: data,
                    success: res => {
                        window.location.href = '/Admin/BaoCaoNguoiDung/Index';
                    },
                    error: err => {
                        Swal.fire({
                            title: 'Lỗi',
                            html: 'Lỗi server. Hiện tại không thể thực hiện thao tác',
                            icon: 'error',
                        })
                    }
                })
            } else if (result.isDenied) {
                Swal.fire('Đã hủy thao tác', '', 'info');
            }
        });
    })

    $('[data-toggle="tooltip"]').tooltip();
    $('#myTable').DataTable();
});