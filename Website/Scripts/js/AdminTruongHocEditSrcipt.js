function zoom() {
    var el = document.getElementById('map');
    var check = el.classList.contains('zoom');
    var btn = document.getElementById('zoom');
    if (check) {
        el.classList.remove('zoom');
        btn.innerHTML = '<i class="bx bxs-zoom-in bx-tada"></i>'
    }
    else {
        el.classList.add('zoom');
        btn.innerHTML = '<i class="bx bxs-zoom-out bx-tada"></i>'
    }
    setTimeout(function () {
        map.invalidateSize();
    }, 50);
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

var lat = $('[name="_lat"]').val();
var lng = $('[name="_lng"]').val();
$('#latlng').val('POINT (' + lng + ' ' + lat + ')')

var map = L.map("map", { center: [lat, lng], zoom: 14 });

L.tileLayer(
    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    {
        attribution: '&copy; <a href="http://' +
            'www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }
).addTo(map);

$(document).ready(function () {
    var coorPoly = [];

    var control = L.control({ position: "topright" });
    control.onAdd = function (map) {
        var div = L.DomUtil.create("div", "divsave");
        div.innerHTML = '<a href="#" id="zoom" onclick="zoom()" class="btn btn-white btn-outline-primary"><i class="bx bxs-zoom-in bx-tada"></i></a>';
        return div;
    };
    control.addTo(map);

    var khuVucLayer = L.layerGroup().addTo(map);

    $.ajax({
        url: '/Admin/KhuVuc/GetKhuVuc',
        type: 'post',
        data: {
            'id': $('#ma_kv').val()
        },
        success: res => {
            khuVucLayer.clearLayers();
            var coors = res.polygon.match(/[0-9]+\.*[0-9]*/ig);
            coorPoly = coors;
            L.polygon(getLatLng(coors)).addTo(khuVucLayer);
            coors = res.latlng.match(/[0-9]+\.*[0-9]*/ig);
        },
        error: res => {
            console.log(res);
        }
    })

    $('#ma_kv').change(e => {
        $.ajax({
            url: '/Admin/KhuVuc/GetKhuVuc',
            type: 'post',
            data: {
                'id': $('#ma_kv').val()
            },
            success: res => {
                khuVucLayer.clearLayers();
                var coors = res.polygon.match(/[0-9]+\.*[0-9]*/ig);
                coorPoly = coors;
                L.polygon(getLatLng(coors)).addTo(khuVucLayer);
                coors = res.latlng.match(/[0-9]+\.*[0-9]*/ig);
                marker.setLatLng([coors[1], coors[0]]);
                map.panTo([coors[1], coors[0]]);
            },
            error: res => {
                console.log(res);
            }
        })
    })

    var marker = L.marker([lat, lng]).addTo(map);
    map.on("click", e => {
        var polygon = L.polygon(getLatLng(coorPoly));
        var tempMarker = L.marker([e.latlng.lat, e.latlng.lng]);
        if (isMarkerInsidePolygon(tempMarker, polygon)) {
            $('#latlng').val('POINT (' + e.latlng.lng + ' ' + e.latlng.lat + ')')
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
});