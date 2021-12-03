function getLatLng(arr) {
    let res = [];
    arr.map((item, ind) => {
        ind % 2 == 0 && res.push([item]);
        ind % 2 == 1 && res[res.length - 1].unshift(item);
    });
    return res;
}

$(document).ready(function () {

    var map = L.map("map", { center: [10.032778, 105.759444], zoom: 14 });

    L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        {
            attribution: '&copy; <a href="http://' +
                'www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
    ).addTo(map);

    var khuVucLayer = L.layerGroup().addTo(map);

    $('.show-map').click(e => {
        setTimeout(function () {
            map.invalidateSize();
        }, 50);
        var element = e.delegateTarget;
        var id = element.getAttribute('data-id');
        khuVucLayer.clearLayers();
        $.ajax({
            url: '/Admin/KhuVuc/GetKhuVuc/' + id,
            type: 'post',
            success: res => {
                var coors = res.polygon.match(/[0-9]+\.*[0-9]*/ig);
                var layer = L.polygon(getLatLng(coors)).addTo(khuVucLayer);
                layer.setStyle({
                    color: '#' + res.mau,
                    fillColor: '#' + res.mau,
                })
                coors = res.latlng.match(/[0-9]+\.*[0-9]*/ig);
                map.setView([coors[1], coors[0]], 15);
            },
            error: err => {

            }
        })
    })

    $('#myTable').DataTable();
    $('[data-toggle="tooltip"]').tooltip()
})