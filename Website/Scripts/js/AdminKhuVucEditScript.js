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

function setPoint(t, a) {
    var coors = a.join('-').match(/[0-9]+\.*[0-9]*/ig)
    var res = "(";
    if (t === "Polygon")
        res += "(";
    coors.map((e, i) => {
        if (i % 2 == 0)
            res += " " + e
        else
            res += " " + e + ",";
    });
    res = res.substring(0, res.length - 1) + ")";
    if (t === "Polygon")
        res += ")";
    return res;
}

function getLatLng(arr) {
    let res = [];
    arr.map((item, ind) => {
        ind % 2 == 0 && res.push([item]);
        ind % 2 == 1 && res[res.length - 1].unshift(item);
    });
    return res;
}

var map = L.map("map", { center: [10.032778, 105.759444], zoom: 14 });

L.tileLayer(
    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    {
        attribution: '&copy; <a href="http://' +
            'www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }
).addTo(map);

$(document).ready(function () {
    $('#ma_ms').change(e => {
        var ma = $('#ma_ms').val();
        if (!ma)
            $('#preview-color').css('background', 'gray')
        else
            $('#preview-color').css('background', '#' + ma);
    });

    var options = {
        position: 'topleft',
        draw: {
            polygon: {
                shapeOptions: {
                    color: '#bada55'
                },
                showArea: true,
            },
        },
        edit: {
            featureGroup: drawn,
            edit: true,
            remove: true,
        }
    };

    var drawn = L.featureGroup().addTo(map);

    var options = {
        position: 'topleft',
        draw: {
            polyline: false,
            polygon: true,
            rectangle: false,
            marker: false,
            circle: false,
            circlemarker: false,
        },
        edit: {
            featureGroup: drawn,
            edit: true,
            remove: true,
        }
    };

    var drawnControl = new L.Control.Draw(options).addTo(map);

    var control = L.control({ position: "topright" });
    control.onAdd = function (map) {
        var div = L.DomUtil.create("div", "divsave");
        div.innerHTML = '<a href="#" id="zoom" onclick="zoom()" class="btn btn-white btn-outline-primary"><i class="bx bxs-zoom-in bx-tada"></i></a>';
        return div;
    };
    control.addTo(map);

    var layer = new L.Layer();

    $.ajax({
        url: '/Admin/KhuVuc/GetKhuVuc/' + $('#ma_kv').val(),
        type: 'post',
        success: res => {
            $('#polygon').val(res.polygon);
            $('#latlng').val(res.latlng);
            drawn.clearLayers();
            var coors = res.polygon.match(/[0-9]+\.*[0-9]*/ig);
            layer = L.polygon(getLatLng(coors));
            layer.addTo(drawn);
            var coors = res.latlng.match(/[0-9]+\.*[0-9]*/ig);
            map.setView([coors[1], coors[0]], 14)
        }
    })

    map.on("draw:created", function (e) {
        drawn.clearLayers();
        layer = e.layer;
        layer.addTo(drawn);
        var geo = layer.toGeoJSON();
        var centroid = layer.getBounds().getCenter();
        $('#polygon').val(geo.geometry.type.toUpperCase() + " " + setPoint(geo.geometry.type, geo.geometry.coordinates));
        $('#latlng').val("POINT (" + centroid.lng + " " + centroid.lat + ")");
    });

    map.on("draw:edited", function (e) {
        var geo = layer.toGeoJSON();
        var centroid = layer.getBounds().getCenter();
        $('#polygon').val(geo.geometry.type.toUpperCase() + " " + setPoint(geo.geometry.type, geo.geometry.coordinates));
        $('#latlng').val("POINT (" + centroid.lng + " " + centroid.lat + ")");
    })

    map.on("draw:deleted", function (e) {
        $('#polygon').val("");
        $('#latlng').val("");
    });

})