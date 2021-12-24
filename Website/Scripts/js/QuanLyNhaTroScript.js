$(document).ready(function () {
    Fancybox.bind("[data-fancybox]", {

    });
    $('[data-toggle="tooltip"]').tooltip()
    $('#btnaddimg').click(e => {
        $('#modaladdimg').show();
        $('#ten_anh').val('');
        $('#mota_anh').val('');
        $('#img-temp').attr('src', '');
    })
    $('#btn-chonanh').click(e => {
        var finder = new CKFinder();
        finder.selectActionFunction = function (fileUrl) {
            $('#ten_anh').val(fileUrl);
            $('#img-temp').attr('src', fileUrl);
        }
        finder.popup();
    })
    $('#btn-themanh').click(e => {
        var data = {
            'ma_nt': $('#ma_nt').val(),
            'ten_anh': $('#ten_anh').val(),
            'mota_anh': $('#mota_anh').val(),
        }
        if (!data.ten_anh) {
            Swal.fire({
                title: 'Cảnh báo',
                html: 'Bạn chưa chọn ảnh',
                icon: 'warning',
            })
        }
        else if (!data.mota_anh) {
            Swal.fire({
                title: 'Cảnh báo',
                html: 'Bạn chưa nhập mô tả ảnh',
                icon: 'warning',
            })
        }
        else {
            $.ajax({
                url: '/Anh/Add',
                data: data,
                type: 'post',
                success: res => {
                    $('#containerImg').append(
                        `<li data-src="${res.ten_anh}" data-fancybox="gallery" data-caption="${res.mota_anh}">
                                    <img src="${res.ten_anh}" class="img-thumbnail" style="height: 64px; width: 95px;" />
                                </li>`
                    )
                },
                error: res => {
                    Swal.fire({
                        title: 'Lỗi',
                        html: 'Lỗi server. Hiện tại không thể thực hiện thao tác',
                        icon: 'error',
                    })
                }
            })
            $('#modaladdimg').hide();
        }
    })
    $('.btn-dong').click(e => {
        $('#modaladdimg').hide();
    })
    $('.btn-delete').click(e => {
        Swal.fire({
            title: 'Bạn chắc chắn muốn xóa dữ liệu nhà trọ?',
            showCancelButton: true,
            confirmButtonText: 'Xóa',
            showCancelButton: `Hủy`,
        }).then(res => {
            if (res.isConfirmed) {
                window.location.href = "/QuanLy/Delete/" + $('.btn-delete').data('id');
            }
        })
    })

    var lat = $('#_lat').val();
    var lng = $('#_lng').val();
    var map = L.map("map", { center: [lat, lng], zoom: 18 });

    L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        {
            attribution: '&copy; <a href="http://' +
                'www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
    ).addTo(map);

    var nhaTroMarker = L.marker([lat, lng]).addTo(map);
    nhaTroMarker.bindPopup(lat + ', ' + lng);

    $('#tableDienNuoc').DataTable();
    $('#tableGiaPhong').DataTable();

    const ctx = document.getElementById('myChart').getContext('2d');
    $.ajax({
        url: '/DanhGia/ChartData',
        data: {
            'ma_nt': $('#ma_nt').val()
        },
        type: 'post',
        success: res => {
            const myChart = new Chart(ctx, {
                type: 'horizontalBar',
                data: {
                    labels: ['⭐', '⭐⭐', '⭐⭐⭐', '⭐⭐⭐⭐', '⭐⭐⭐⭐⭐'],
                    datasets: [{
                        label: '# of Votes',
                        data: res,
                        backgroundColor: 'rgba(255, 206, 86, 0.2)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        borderWidth: 1
                    }]
                }
            });
        }
    })
    const ctx2 = document.getElementById('myChart2').getContext('2d');
    $.ajax({
        url: '/DanhGia/ChartData2',
        data: {
            'ma_nt': $('#ma_nt').val()
        },
        type: 'post',
        success: res => {
            res.data.push(0);
            const myChart = new Chart(ctx2, {
                type: 'line',
                data: {
                    labels: res.label,
                    datasets: [{
                        label: 'Đánh giá trung bình',
                        data: res.data,
                        backgroundColor: 'rgba(255, 206, 86, 0.2)',
                        borderColor: 'rgba(255, 206, 86, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    elements: {
                        line: {
                            tension: 0
                        }
                    }
                }
            });
        }
    })
})