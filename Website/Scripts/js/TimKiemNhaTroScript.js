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

$(document).ready(() => {
    $('.pageheader-section').hide();
    $('.news-footer-wrap').hide();
    $('header').hide();
    $('footer').hide();

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