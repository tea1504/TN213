$(document).ready(() => {
    $('.pageheader-section').hide();
    $('.news-footer-wrap').hide();
    $('header').hide();
    $('footer').hide();

    var map = L.map("map", { center: [10.032778, 105.759444], zoom: 14 });

    L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        {
            attribution: '&copy; <a href="http://' +
                'www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
    ).addTo(map);

    $('#sreach').click(e => {
        var data = {
            'ma_kv': $('#ma_kv').val(),
            'ma_th': $('#ma_th').val(),
            'ten_nd': $('#ten_nd').val(),
            'ten_nt': $('#ten_nt').val(),
            'diachi_nt': $('#diachi_nt').val(),
            'khoancach': $('#khoancach').val(),
        };
        $.ajax({
            url: '/DSNhaTro/KetQua',
            type: 'post',
            data: data,
            success: res => {
                console.log(res)
                Swal.fire({
                    title: '404',
                    icon: 'warning',
                    html: 'Không tìm thấy kết quả phù hợp',
                });
            },
            error: res => {
                Swal.fire({
                    title: 'Lỗi',
                    icon: 'error',
                    html: 'Lỗi server',
                });
            }
        })
    })

});