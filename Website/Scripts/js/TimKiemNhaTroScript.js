function getLatLng(arr) {
    let res = [];
    arr.map((item, ind) => {
        ind % 2 == 0 && res.push([item]);
        ind % 2 == 1 && res[res.length - 1].unshift(item);
    });
    return res;
}

var schoolIcon = L.icon({
    iconUrl: '/Content/img/icon/school.png',
    iconSize: [72, 72],
    iconAnchor: [36, 60],
    popupAnchor: [0, -72],
});

var arr = [];

$(document).ready(() => {
    $('.pageheader-section').hide();
    $('.news-footer-wrap').hide();
    $('header').hide();
    $('footer').hide();

    Fancybox.bind('[data-fancybox]', {
    });

    var map = L.map("map", { center: [10.032778, 105.759444], zoom: 14 });
    var troLayer = L.layerGroup().addTo(map);
    var khuVucLayer = L.layerGroup().addTo(map);
    var truongLayer = L.layerGroup().addTo(map);

    L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        {
            attribution: '&copy; <a href="http://' +
                'www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
    ).addTo(map);

    $('#sreach').click(e => {
        troLayer.clearLayers();
        khuVucLayer.clearLayers();
        truongLayer.clearLayers();
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
                if (res.dsnhatro.length == 0) {
                    map.setView([10.032778, 105.759444], 14);
                    Swal.fire({
                        title: '404',
                        icon: 'warning',
                        html: 'Không tìm thấy kết quả phù hợp',
                    });
                }
                else {
                    if (res.dskhuvuc.length == 1) {
                        map.setView([res.dskhuvuc[0][3], res.dskhuvuc[0][2]], 15);
                    } else {
                        map.setView([10.032778, 105.759444], 14);
                    }
                    if (res.dsnhatro.length == 1) {
                        map.setView([res.dsnhatro[0][4], res.dsnhatro[0][3]], 15);
                    }
                    res.dsnhatro.map((e, i) => {
                        var m = L.marker([e[4], e[3]]).addTo(troLayer);
                        m.bindPopup(
                            `
                                <h3>${e[5]}</h3>
                                ${e[6]}
                            `
                        );
                        m.myID = e[2];
                        arr.push(m);
                    });

                }
                res.dskhuvuc.map((e, i) => {
                    var coors = e[4].match(/[0-9]+\.*[0-9]*/ig);
                    var layer = L.polygon(getLatLng(coors)).addTo(khuVucLayer);
                    layer.bindTooltip(e[1]);
                    layer.setStyle({
                        color: '#' + e[5],
                        fillColor: '#' + e[5] + '55',
                    })
                });
                if (res.truonghoc !== "") {
                    e = res.truonghoc;
                    var m = L.marker([e[3], e[2]], { icon: schoolIcon }).addTo(truongLayer);
                    m.bindPopup(
                        `
                                <h3>${e[1]}</h3>
                                ${e[4]}
                            `
                    );
                    L.circle([e[3], e[2]], { radius: data.khoancach * 1000 }).setStyle({ fillOpacity: 0, color: 'black', weight: 1, }).addTo(truongLayer);
                }
                arr.map((e, i) => {
                    var id = e.myID;
                    e.on('click', el => {
                        $.ajax({
                            url: '/DsNhaTro/ThongTinNhaTro',
                            type: 'post',
                            data: {
                                'ma_nt': id
                            },
                            success: res => {
                                var anhbia = '/Content/user/assets/images/course/01.jpg'
                                if (res.anh.length > 0) {
                                    anhbia = res.anh[0].ten_anh;
                                }

                                $('#anhbia').attr('data-src', anhbia);
                                $('#anhbia img').attr('src', anhbia);
                                $('#ten_nha_tro a').html(res.nhatro.ten_nt);
                                $('#ten_nha_tro a').attr('href', '/DSNhaTro/NhaTro/' + res.nhatro.ma_nt);

                                var sosaohtml = '';
                                for (var i = 1; i <= parseInt(res.nhatro.sosao); i++) {
                                    sosaohtml += '<i class="icofont-ui-rating"></i> ';
                                }
                                for (var i = 1; i <= 5 - parseInt(res.nhatro.sosao); i++) {
                                    sosaohtml += '<i class="icofont-ui-rate-blank"></i> ';
                                }
                                $('#sosao').html(sosaohtml);
                                $('#sodg').html(res.danhgia.length);
                                $('#chutro').html(`
                                    <div data-src="${res.chutro.anh}" data-fancybox="avatar-user" data-caption="${res.chutro.holot} ${res.chutro.ten}">
                                        <img src="${res.chutro.anh}" alt="${res.chutro.holot} ${res.chutro.ten}" />
                                    </div>
                                    <span>${res.chutro.holot} ${res.chutro.ten}</span>
`);
                                $('#diachinhatro').html(`<i class="icofont-google-map icofont-2x"></i> ${res.nhatro.diachi_nt}`);
                                $('#sdt').html(`<i class="icofont-phone icofont-2x"></i> ${res.nhatro.sdt_nt}`);

                                var cmthtml = '';
                                res.danhgia.map((dg, i) => {
                                    var sao = '';
                                    for (var i = 1; i <= dg.sosao; i++) {
                                        sao += '<i class="icofont-ui-rating"></i> ';
                                    }
                                    for (var i = 1; i <= 5 - dg.sosao; i++) {
                                        sao += '<i class="icofont-ui-rate-blank"></i> ';
                                    }
                                    cmthtml += `
                                        <div class="mt-3">
                                            <img src="${dg.user.anh}" alt="${dg.user.holot} ${dg.user.ten}" /> ${dg.user.holot} ${dg.user.ten}
                                            <div>
                                                ${sao}
                                                <span>${dg.ngay}</span>
                                            </div>
                                            <div>${dg.danhgia}</div>
                                            <hr />
                                        </div>
`;
                                })
                                $('#cmt').html(cmthtml);

                                var imghtml = '';
                                res.anh.map((img, i) => {
                                    imghtml += `
                                        <div data-src="${img.ten_anh}" data-fancybox="anh" data-caption="${img.mota}">
                                            <img src="${img.ten_anh}" alt="${img.mota}" />
                                        </div>`;
                                })
                                $('#image').html(imghtml);

                                $('#container-info').addClass('col-md-3 h-75');
                                $('#container-info').show('fast');
                                $('#container-map').addClass('col-md-9');
                                $('#container-map').removeClass('col-md-12');
                            }
                        })
                        setTimeout(function () {
                            map.invalidateSize();
                        }, 1000);
                        map.panTo([e.getLatLng().lat, e.getLatLng().lng])
                    })
                })
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

    $('.btn-close').click(e => {
        e.preventDefault();
        $('#container-info').hide('fast', () => {
            $('#container-info').removeClass('col-md-3 h-75');
            $('#container-map').removeClass('col-md-9');
            $('#container-map').addClass('col-md-12');
            setTimeout(function () {
                map.invalidateSize();
            }, 1000);
        });
    })

});