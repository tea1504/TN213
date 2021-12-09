$(document).ready(function () {
    var coorPoly = [];
    $('#getLatLng').click(e => {
        e.preventDefault();
        $('#modalLatLng').show("slow");
        setTimeout(function () {
            map.invalidateSize();
        }, 1000);
    })

    $('.btn-dong').click(e => {
        $('#modalLatLng').hide("slow");
        $('#modalAddImg').hide("slow");
    })

    var map = L.map("map", { center: [10.032778, 105.759444], zoom: 14 });

    L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        {
            attribution: '&copy; <a href="http://' +
                'www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
    ).addTo(map);

    var marker = L.marker([10.032778, 105.759444]).addTo(map);
    map.on("click", e => {
        console.log(e)
        var polygon = L.polygon(getLatLng(coorPoly));
        var tempMarker = L.marker([e.latlng.lat, e.latlng.lng]);
        if (isMarkerInsidePolygon(tempMarker, polygon)) {
            $("span#tempLng").html(e.latlng.lng);
            $("span#tempLat").html(e.latlng.lat);
            marker.setLatLng([e.latlng.lat, e.latlng.lng])
            marker.bindPopup(e.latlng.lat + ", " + e.latlng.lng).openPopup();
        }
        else {
            Swal.fire({
                icon: 'warning',
                title: 'Cảnh báo',
                html: 'Bạn không thể chọn tọa độ ngoài khu vực đã chọn'
            })
        }
    });

    $('#getLatLngcur').click(e => {
        e.preventDefault();
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(getLocationCallback, errorCallback);
        }
        else {
            Swal.fire({
                icon: 'error',
                title: 'Lỗi',
                html: 'Trình duyệt không hỗ trợ truy cập vị trí'
            });
        }
        function getLocationCallback(location) {
            var latcur = location.coords.latitude;
            var lngcur = location.coords.longitude;
            var check = false;
            console.log(latcur, lngcur);
            $.ajax({
                url: '/QuanLy/GetAllKhuVuc',
                type: 'post',
                success: res => {
                    res.map(el => {
                        var coors = el.polygon.match(/[0-9]+\.*[0-9]*/ig);
                        var polygon = L.polygon(getLatLng(coors));
                        var tempMarker = L.marker([latcur, lngcur]);
                        if (isMarkerInsidePolygon(tempMarker, polygon)) {
                            check = true;
                            $('#ma_kv').val(el.ma_kv);
                        }
                    });
                    if (check) {
                        Swal.fire({
                            icon: 'warning',
                            title: 'Cảnh báo',
                            html: 'Vị trí của bạn không thuộc quận Ninh Kiều'
                        });
                    }
                    else {
                        $('#lat').val(latcur);
                        $('#lng').val(lngcur);
                        marker.setLatLng([latcur, lngcur]);
                        map.panTo([latcur, lngcur]);
                    }
                },
                error: res => {

                }
            })
        }
        function errorCallback(error) {
            Swal.fire({
                icon: 'warning',
                title: 'Cảnh báo',
                html: 'Bạn phải cho phép website truy cập vị trí.'
            })
        }
    })

    $('#getCoor').on('click', e => {
        var lng = $("span#tempLng").html();
        var lat = $("span#tempLat").html();
        $("#lng").val(lng);
        $("#lat").val(lat);
        $('#modalLatLng').hide("slow");
    })

    var khuVucLayer = L.layerGroup().addTo(map);

    $.ajax({
        url: '/QuanLy/GetKhuVuc',
        type: 'post',
        data: {
            'ma_kv': 1
        },
        success: res => {
            khuVucLayer.clearLayers();
            var coors = res.polygon.match(/[0-9]+\.*[0-9]*/ig);
            coorPoly = coors;
            L.polygon(getLatLng(coors)).addTo(khuVucLayer);
            coors = res.toado.match(/[0-9]+\.*[0-9]*/ig);
            marker.setLatLng([coors[1], coors[0]]);
            map.panTo([coors[1], coors[0]]);
        },
        error: res => {
            console.log(res);
        }
    })

    $('#ma_kv').change(e => {
        console.log($('#ma_kv').val());
        $.ajax({
            url: '/QuanLy/GetKhuVuc',
            type: 'post',
            data: {
                'ma_kv': $('#ma_kv').val()
            },
            success: res => {
                console.log(res)
                khuVucLayer.clearLayers();
                var coors = res.polygon.match(/[0-9]+\.*[0-9]*/ig);
                coorPoly = coors;
                L.polygon(getLatLng(coors)).addTo(khuVucLayer);
                coors = res.toado.match(/[0-9]+\.*[0-9]*/ig);
                marker.setLatLng([coors[1], coors[0]]);
                map.panTo([coors[1], coors[0]]);
            },
            error: res => {
                console.log(res);
            }
        })
    })

    $('#btnAddImg').click(e => {
        e.preventDefault();
        $('#modalAddImg').show("slow");
        $('#ten_anh').val('');
        $('#img-temp').attr('src', '');
        $('#mota_anh').val('');
    })

    $('#btn-chonanh').click(e => {
        e.preventDefault();
        var finder = new CKFinder();
        finder.selectActionFunction = function (fileUrl) {
            $('#ten_anh').val(fileUrl);
            $('#img-temp').attr('src', fileUrl);
        }
        finder.popup();
    })

    $('#addImg').click(e => {
        e.preventDefault();
        var ten_anh = $('#ten_anh').val();
        var mota_anh = $('#mota_anh').val();
        if (!ten_anh) {
            Swal.fire({
                icon: 'warning',
                title: 'Cảnh báo',
                html: 'Bạn chưa chọn ảnh'
            })
        }
        else if (!mota_anh) {
            Swal.fire({
                icon: 'warning',
                title: 'Cảnh báo',
                html: 'Bạn chưa mô tả ảnh'
            })
        }
        else {
            var id = $('#containerImg table tbody tr').length;
            $('#containerImg table tbody').append(`
                                <tr id="r${id}">
                                    <td width="200px"><img src="${ten_anh}" class="img-fluid" /></td>
                                    <td class="text-center">${ten_anh} <input type="hidden" name="a[${id}].ten_anh" value="${ten_anh}"></td>
                                    <td class="text-center">${mota_anh} <input type="hidden" name="a[${id}].mota_anh" value="${mota_anh}"></td>
                                    <td class="text-center"><a class="btn btn-danger" onclick=" deleterow('r${id}')">Xóa</a></td>
                                </tr>
            `);
            $('#modalAddImg').hide('slow');
        }
    })

    $('#addLP').click(e => {
        e.preventDefault();
        var ma_lp = $('#ma_lp').val();
        var ten_lp = $('#ma_lp option[value="' + ma_lp + '"]').html();
        var giaphong = $('#giaphong').val();
        if (!giaphong) {
            Swal.fire({
                icon: 'warning',
                title: 'Cảnh báo',
                html: 'Bạn chưa nhập số tiền'
            })
        } else {
            var id = $('#containerLoaiPhong tbody tr').length;
            $('#containerLoaiPhong tbody').append(`
                                <tr id="l${id}">
                                        <td class="text-center">${ten_lp} <input type="hidden" name="l[${id}].ma_lp" value="${ma_lp}" /></td>
                                        <td class="text-center">${new Intl.NumberFormat('vi-VN').format(giaphong)} <input type="hidden" name="l[${id}].giaphong" value="${giaphong}" /></td>
                                        <td class="text-center"><a class="btn btn-danger" onclick="xoadong('l${id}')">Xóa</a></td>
                                    </tr>
            `)
            $('#ma_lp').val(1);
            $('#giaphong').val('');
        }
    })

});

function deleterow(id) {
    $('#' + id).remove();
    $('#containerImg table tbody tr').each((i, e) => {
        e.setAttribute('id', 'r' + i);
        var tr1 = e.children[1];
        var tr2 = e.children[2];
        var tr3 = e.children[3];
        tr1.children[0].setAttribute('name', 'a[' + i + '].ten_anh')
        tr2.children[0].setAttribute('name', 'a[' + i + '].mota_anh')
        tr3.children[0].setAttribute('onclick', "deleterow('r" + i + "')")
    });
}
function xoadong(id) {
    $('#' + id).remove();
    $('#containerLoaiPhong tbody tr').each((i, e) => {
        e.setAttribute('id', 'l' + i);
        var tr1 = e.children[0];
        var tr2 = e.children[1];
        var tr3 = e.children[2];
        tr1.children[0].setAttribute('name', 'l[' + i + '].ma_lp')
        tr2.children[0].setAttribute('name', 'l[' + i + '].giaphong')
        tr3.children[0].setAttribute('onclick', "xoadong('l" + i + "')")
    });
}

function isMarkerInsidePolygon(marker, poly) {
    var polyPoints = poly.getLatLngs()[0];
    var x = marker.getLatLng().lat, y = marker.getLatLng().lng;

    var inside = false;
    for (var i = 0, j = polyPoints.length - 1; i < polyPoints.length; j = i++) {
        var xi = polyPoints[i].lat, yi = polyPoints[i].lng;
        var xj = polyPoints[j].lat, yj = polyPoints[j].lng;

        var intersect = ((yi > y) != (yj > y))
            && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
        if (intersect) inside = !inside;
    }

    return inside;
};

function getLatLng(arr) {
    let res = [];
    arr.map((item, ind) => {
        ind % 2 == 0 && res.push([item]);
        ind % 2 == 1 && res[res.length - 1].unshift(item);
    });
    return res;
}