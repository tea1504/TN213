function edit(nt, nd, lbc, ngay) {
    var data = {
        'ma_nt': nt,
        'ma_nd': nd,
        'ma_lbc': lbc,
        'ngay': ngay
    };
    $.ajax({
        url: '/Admin/BaoCaoNhaTro/Edit',
        type: 'post',
        data: data,
        success: res => {
            window.location.href = '/Admin/BaoCaoNhaTro/Index';
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
        var nd = el.getAttribute('data-nd');
        var nt = el.getAttribute('data-nt');
        var lbc = el.getAttribute('data-lbc');
        var ngay = el.getAttribute('data-ngay');
        var data = {
            'ma_nt': nt,
            'ma_nd': nd,
            'ma_lbc': lbc,
            'ngay': ngay
        };
        $.ajax({
            url: '/Admin/BaoCaoNhaTro/Detail',
            type: 'post',
            data: data,
            success: res => {
                $('#_tennd').html(res.nguoi.ten);
                $('#_vaitro').html(res.nguoi.vaitro);
                $('#_idnd').attr('href', '/Admin/NguoiDung/Detail/' + res.nguoi.ma);
                $('#_anhnd').attr('src', res.nguoi.anh);
                $('#_tennt').html(res.nhatro.ten);
                $('#_diachi').html(res.nhatro.diachi);
                $('#_idnt').attr('href', '/Admin/NhaTro/Detail/' + res.nhatro.ma);
                $('#_anhnt').attr('src', res.nhatro.anh);
                $('#_ngay').html(res.ngay);
                $('#_tenlbc').html(res.loai);
                $('#_lydo').html(res.lydo);
                if (res.trangthai == 1) {
                    $('#_trangthai').html(`<span class="badge badge-pill badge-secondary">Chưa xử lý</span>`);
                    $('.modal-footer').html(`<button class="btn btn-light-success" onclick="edit(${nt}, ${nd}, ${lbc}, '${ngay}')">Đã xử lý</button>`);
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
        var nd = el.getAttribute('data-nd');
        var nt = el.getAttribute('data-nt');
        var lbc = el.getAttribute('data-lbc');
        var ngay = el.getAttribute('data-ngay');
        var data = {
            'ma_nt': nt,
            'ma_nd': nd,
            'ma_lbc': lbc,
            'ngay': ngay
        };
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa khu vực ' + name + '?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Xóa',
            denyButtonText: `Không xóa`,
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/Admin/BaoCaoNhaTro/Delete',
                    type: 'post',
                    data: data,
                    success: res => {
                        window.location.href = '/Admin/BaoCaoNhaTro/Index';
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