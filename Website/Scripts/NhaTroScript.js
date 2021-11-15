$(document).ready(() => {
    $(".pageheader-section").hide();
    $(".pageheader-section.style-2").show();
    $('.money').each((i, e) => {
        var html = e.innerHTML;
        e.innerHTML = new Intl.NumberFormat('vi-VN', { maximumSignificantDigits: 3 }).format(html) + "đ / tháng";
    })
    var lat = $('#_lat').val();
    var lng = $('#_lng').val();
    var ten = $('#_ten').val();
    var diachi = $('#_diachi').val();
    var img = $('#_img').val();

    var map = L.map("map", { center: [lat, lng], zoom: 18 });

    L.tileLayer(
        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        {
            attribution: '&copy; <a href="http://' +
                'www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }
    ).addTo(map);

    var nhaTroMarker = L.marker([lat, lng]).addTo(map);
    nhaTroMarker.bindPopup(
    `
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <h5>${ten}</h5>
                </div>
                <div class="col-12">
                    <i>${diachi}</i>
                </div>
                <div class="col-12">
                    <img src="${img}" alt="${ten}"/>
                </div>
            </div>
            
        <div/>
    `
    );

    var control = L.control({ position: "topright" });
    control.onAdd = function (map) {
        var div = L.DomUtil.create("div", "divsave");
        div.innerHTML = '<button id="control"><i class="icofont-ui-zoom-in icofont-2x"></i></button>';
        return div;
    };
    control.addTo(map);

    $('#control').click(e => {
        $('#zoomcontrol').toggleClass('zoom');
        var check = $('#control i').hasClass('icofont-ui-zoom-in');
        if (check) {
            $('#control i').removeClass('icofont-ui-zoom-in');
            $('#control i').addClass('icofont-ui-zoom-out');
        }
        else {
            $('#control i').removeClass('icofont-ui-zoom-out');
            $('#control i').addClass('icofont-ui-zoom-in');
        }
        setTimeout(function () {
            map.invalidateSize();
            map.panTo([lat, lng])
        }, 400);
    })
})
