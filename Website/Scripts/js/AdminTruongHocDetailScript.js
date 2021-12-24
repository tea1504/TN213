$(document).ready(function () {
    const lat = $('#lat').val();
    const lng = $('#lng').val();

    var map = L.map("map", { center: [lat, lng], zoom: 18 });

    L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        {
            attribution: '&copy; <a href="http://' +
                'www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
    ).addTo(map);

    var marker = L.marker([lat, lng]).addTo(map);

    var control = L.control({ position: "topright" });
    control.onAdd = function (map) {
        var div = L.DomUtil.create("div", "divsave");
        div.innerHTML = '<button id="control" class="btn btn-white" style="font-size: 30px"><i class="bx bx-zoom-in bx-tada"></i></button>';
        return div;
    };
    control.addTo(map);

    $('#control').click(e => {
        $('#zoomcontrol').toggleClass('zoom');
        var check = $('#control i').hasClass('bx-zoom-in');
        if (check) {
            $('#control i').removeClass('bx-zoom-in');
            $('#control i').addClass('bx-zoom-out');
        }
        else {
            $('#control i').removeClass('bx-zoom-out');
            $('#control i').addClass('bx-zoom-in');
        }
        setTimeout(function () {
            map.invalidateSize();
            map.panTo([lat, lng])
        }, 400);
    })
});