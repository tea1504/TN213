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
        var mt = el.getAttribute('data-mota');
        $('#editmodal').show('slow');
        $('#containerImgEdit').attr('src', anh);
        $('#edit_STT').val(stt);
        $('#edit_ma_nt').val(nt);
        $('#edit_ten_anh').val(anh);
        $('#edit_mota').val(mt);
    })

    $('#btn-chonanh').click(e => {
        e.preventDefault();
        var finder = new CKFinder();
        finder.selectActionFunction = function (fileUrl) {
            $('#create_ten_anh').val(fileUrl);
            $('#containerImgCreate').attr('src', fileUrl);
        }
        finder.popup();
    })

    $('.btndelete').click(e => {
        e.preventDefault();
        var el = e.delegateTarget;
        var nt = el.getAttribute('data-nt');
        var stt = el.getAttribute('data-STT');
        var data = {
            'ma_nt': nt,
            'STT': stt,
        }
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa ảnh ?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Xóa',
            denyButtonText: `Không xóa`,
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/Anh/Delete',
                    type: 'post',
                    data: data,
                    success: res => {
                        window.location.href = '/QuanLy/Anh/' + nt;
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