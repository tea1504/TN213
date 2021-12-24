$(document).ready(function () {
    const lat = $('#lat').val();
    const lng = $('#lng').val();
    const id_nt = $('#ma_nt').val();

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

    const ctx = document.getElementById('diennuocChart').getContext('2d');
    $.ajax({
        url: '/Admin/CoTienDienNuoc/GetTheoNhaTro/' + id_nt,
        type: 'post',
        success: res => {
            var labels = [];
            var datadien = [];
            var datanuoc = [];
            res.map((el, ind) => {
                labels.unshift(el.ngay);
                datadien.unshift(el.dien);
                datanuoc.unshift(el.nuoc);
            })
            datadien.push(0);
            datanuoc.push(0);
            const myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Tiền điện',
                            data: datadien,
                            borderColor: '#FFFF00',
                            backgroundColor: '#FFFF00',
                        }, {
                            label: 'Tiền nước',
                            data: datanuoc,
                            borderColor: '#00BFFF',
                            backgroundColor: '#00BFFF',
                        }
                    ]
                },
                options: {
                    responsive: true,
                    title: {
                        display: true,
                        text: 'Lịch sử cập nhật tiền điện nước trong 5 lần thay đổi gần đây'
                    },
                    interaction: {
                        intersect: false,
                    },
                    scales: {
                        x: {
                            display: true,
                            title: {
                                display: true
                            }
                        },
                        y: {
                            display: true,
                            title: {
                                display: true,
                                text: 'Value'
                            },
                        }
                    }
                },
            });
        }
    })

    $('#loaiphong').change(e => {
        var id_lp = $('#loaiphong').val();
        if (id_lp) {
            $.ajax({
                url: '/Admin/CoGia/GetTheoNhaTroVaLoaiPhong',
                type: 'post',
                data: {
                    'ma_nt': id_nt,
                    'ma_lp': id_lp
                },
                success: res => {
                    var labels = [];
                    var data = [];
                    res.map((el, ind) => {
                        labels.unshift(el.ngay);
                        data.unshift(el.gia);
                    })
                    data.push(0);
                    const ctx2 = document.getElementById('giaphongChart').getContext('2d');
                    const myChart = new Chart(ctx2, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [
                                {
                                    label: 'Giá phòng',
                                    data: data,
                                    borderColor: '#673ab7',
                                    backgroundColor: '#673ab7',
                                }
                            ]
                        },
                        options: {
                            responsive: true,
                            title: {
                                display: true,
                                text: 'Lịch sử cập nhật giá phòng trong 5 lần thay đổi gần đây'
                            },
                            interaction: {
                                intersect: false,
                            },
                            scales: {
                                x: {
                                    display: true,
                                    title: {
                                        display: true
                                    }
                                },
                                y: {
                                    display: true,
                                    title: {
                                        display: true,
                                        text: 'Value'
                                    },
                                }
                            }
                        },
                    });
                }
            })
        }
    })

    $('#diennuoc').DataTable();
    $('#giaphong').DataTable();
    $('#danhgiaTable').DataTable();
    $('#baocaoTable').DataTable();
    Fancybox.bind("[data-fancybox]", {

    });
});