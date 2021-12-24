const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 1000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
    }
});

var schoolIcon = L.icon({
    iconUrl: '/Content/img/icon/school.png',
    iconSize: [72, 72],
    iconAnchor: [36, 60],
    popupAnchor: [0, -60],
});

$(document).ready(() => {
    $('[data-toggle="tooltip"]').tooltip()
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

    var control1 = L.control({ position: "topleft" });
    control1.onAdd = function (map) {
        var div = L.DomUtil.create("div", "div1");
        div.innerHTML = '<select id="combobox" style="background-color: white; border: solid 2px #ccc; border-radius: 5px;"></select>';
        return div;
    };
    control1.addTo(map);

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

    $('.ranking i').click(e => {
        var rank = e.target.getAttribute('data-rank');
        $('#sosao').val(rank);
        $('.ranking i').each((i, e) => {
            e.style.color = '#808080';
            if (i < rank)
                e.style.color = '#f16126';
        });
    })

    Fancybox.bind("[data-fancybox]", {

    });

    $('#comment').click(e => {
        e.preventDefault();
        if (form_cmt.danhgia1.value) {
            var data = {
                'ma_nd': form_cmt.ma_nd.value,
                'ma_nt': form_cmt.ma_nt.value,
                'sosao': form_cmt.sosao.value,
                'danhgia1': form_cmt.danhgia1.value,
            };

            $.ajax({
                url: '/DanhGia/GuiDanhGia',
                type: 'POST',
                data: data,
                success: res => {

                    var rank = 5;
                    $('#sosao').val(rank);
                    $('.ranking i').each((i, e) => {
                        e.style.color = '#808080';
                        if (i < rank)
                            e.style.color = '#f16126';
                    });
                    form_cmt.danhgia1.value = "";
                    var total = $('#tong_dg').data('total') + 1;
                    console.log(total, $('#tong_dg').data('total'));
                    $('#tong_dg').html(total + ' đánh giá');
                    $('.ratting-count').html(total + ' đánh giá');

                    var rank = "";

                    for (var i = 1; i <= res.sosao; i++)
                        rank += '<i class="icofont-ui-rating"></i> ';
                    for (var i = 1; i <= 5 - res.sosao; i++)
                        rank += '<i class="icofont-ui-rating" style="color:#808080"></i> ';
                    var id = res.ma_nd + "_" + res.ma_nt + "_" + res.ngayiso;
                    $('.comment-list').prepend(
                        `
                        <li class="comment" id="${id}">
                            <div class="com-thumb">
                                <img alt="${res.hoten}" src="${res.anh}">
                            </div>
                            <div class="com-content">
                                <div class="com-title">
                                    <div class="com-title-meta">
                                        <h6>${res.hoten}</h6>
                                        <span> ${res.ngay} </span>
                                    </div>
                                    <span class="ratting">
                                        ${rank}
                                    </span>
                                </div>
                                <p>${res.danhgia}</p>
                                <button class="btn btn-sm btn-danger" onClick="deletecmt(${res.ma_nd}, ${res.ma_nt}, '${res.ngayiso}', '${res.danhgia}', ${res.sosao})" data-toggle="tooltip" title="Xóa đánh giá này" data-ma_nd="${res.ma_nd}" data-ma_nt="${res.ma_nt}" data-ngay="${res.ngayiso}" data-danhgia="${res.danhgia}" data-sosao="${res.sosao}"><i class="icofont-ui-delete"></i></button>
                                <hr />
                            </div>
                        </li>
                    `
                    )
                }
            });

            Toast.fire({
                icon: 'success',
                title: 'Đánh giá thành công'
            })
        }
        else {
            Swal.fire({
                icon: 'error',
                title: 'Bạn chưa nhập nội dung đánh giá',
                showConfirmButton: false,
                timer: 1000
            })
        }

    });

    $.getJSON('/School/GetSchool?ma_th=0').done(data => {
        var menu = $('#combobox');
        menu.append('<option></option>');
        $.each(data, function (key, value) {
            menu.append('<option value=' + value.ma_th + '>' + value.ten_th + '</option>');
        });
    })

    var layer = L.layerGroup().addTo(map);

    $('#combobox').change(e => {
        layer.clearLayers();
        var data = {
            'ma_th': $('#combobox').val(),
            'lat': lat,
            'lng': lng,
        };
        $.ajax({
            url: '/School/GetSchoolDistand',
            type: 'post',
            data: data,
            success: res => {
                console.log(res)
                var coors = res.toado.match(/[0-9]+\.*[0-9]*/ig);
                var truongHocMarker = L.marker([coors[1], coors[0]], { icon: schoolIcon }).addTo(layer);
                truongHocMarker.bindPopup("<h5>" + res.ten_th + "</h5><br/>" + res.diachi);
                var line = L.polyline([[lat, lng], [coors[1], coors[0]]]).addTo(layer);
                line.bindPopup(Number.parseFloat((eval(res.khoancach) * 111).toFixed(2)) + " km");
                line.bindTooltip(Number.parseFloat((eval(res.khoancach) * 111).toFixed(2)) + " km");
                var x = (eval(lng) + eval(coors[0])) / 2;
                var y = (eval(lat) + eval(coors[1])) / 2;
                map.setView([y, x], 13);
            }
        })
    })

    $('.del-cmt').click(e => {
        var el = e.delegateTarget;
        var data = {
            'ma_nd': el.getAttribute('data-ma_nd'),
            'ma_nt': el.getAttribute('data-ma_nt'),
            'ngay': el.getAttribute('data-ngay'),
            'danhgia': el.getAttribute('data-danhgia'),
            'sosao': el.getAttribute('data-sosao'),
        };
        $.ajax({
            url: '/DanhGia/XoaDanhGia',
            type: 'post',
            data: data,
            success: res => {
                console.log(res);
                var selector = data.ma_nd + "_" + data.ma_nt + "_" + data.ngay;
                console.log(selector)
                var li = document.getElementById(selector)
                li.remove();
                var total = $('#tong_dg').data('total') - 1;
                console.log(total, $('#tong_dg').data('total'));
                $('#tong_dg').html(total + ' đánh giá');
                $('.ratting-count').html(total + ' đánh giá');
                Toast.fire({
                    icon: 'success',
                    title: 'Xóa đánh giá thành công'
                })
            }
        })
    })

    $('.modal-close').click(e => {
        $('#baocaonguoidung').modal('hide');
        $('#baocaonhatro').modal('hide');
        $('#lydobaocaonguoidung').val("")
        $('#lydobaocaonhatro').val("")
    })

})


function fbaocaonhatro(ma_nt, ma_nd) {
    $('#baocaonhatro').modal('show');
    $('#nguoi_bao_cao_nha_tro').val(ma_nd);
    $('#ma_nha_tro_bi_bao_cao').val(ma_nt);
}
function fbaocaonguoidung(baocao, bibaocao, ten) {
    $('#baocaonguoidung').modal('show');
    $('#ten_nguoi_dung').html(ten);
    $('#nguoi_bao_cao').val(baocao);
    $('#nguoi_bi_bao_cao').val(bibaocao);
}

function guibaocaonguoidung() {
    var data = {
        'nguoi_bao_cao': $('#nguoi_bao_cao').val(),
        'nguoi_bi_bao_cao': $('#nguoi_bi_bao_cao').val(),
        'malbc': $('#ma_lbc').val(),
        'lydo': $('#lydobaocaonguoidung').val(),
    }
    if (data.lydo) {
        $.ajax({
            url: '/BaoCao/NguoiDung',
            type: 'post',
            data: data,
            success: res => {
                Swal.fire({
                    icon: 'success',
                    title: 'Đã báo cáo cho quản trị viên',
                    showConfirmButton: false,
                    timer: 1000
                });
                $('#lydobaocaonguoidung').val("")
            }
        })
    }
    else {
        Swal.fire({
            icon: 'error',
            title: 'Bạn chưa nhập lý do báo cáo',
            showConfirmButton: false,
            timer: 1000
        })
    }
}

function guibaocaonhatro() {
    var data = {
        'ma_nd': $('#nguoi_bao_cao_nha_tro').val(),
        'ma_nt': $('#ma_nha_tro_bi_bao_cao').val(),
        'malbc': $('#ma_lbc_nt').val(),
        'lydo': $('#lydobaocaonhatro').val(),
    }
    console.log(data);
    if (data.lydo) {
        $.ajax({
            url: '/BaoCao/NhaTro',
            type: 'post',
            data: data,
            success: res => {
                Swal.fire({
                    icon: 'success',
                    title: 'Đã báo cáo cho quản trị viên',
                    showConfirmButton: false,
                    timer: 1000
                });
                $('#lydobaocaonhatro').val("")
            }
        })
    }
    else {
        Swal.fire({
            icon: 'error',
            title: 'Bạn chưa nhập lý do báo cáo',
            showConfirmButton: false,
            timer: 1000
        })
    }
}

function deletecmt(ma_nd, ma_nt, ngayiso, danhgia, sosao) {
    console.log(1);
    var data = {
        'ma_nd': ma_nd,
        'ma_nt': ma_nt,
        'ngay': ngayiso,
        'danhgia': danhgia,
        'sosao': sosao,
    };
    $.ajax({
        url: '/DanhGia/XoaDanhGia',
        type: 'post',
        data: data,
        success: res => {
            console.log(res);
            var selector = data.ma_nd + "_" + data.ma_nt + "_" + data.ngay;
            var li = document.getElementById(selector)
            li.remove();
            var total = $('#tong_dg').data('total') - 1;
            console.log(total, $('#tong_dg').data('total'));
            $('#tong_dg').html(total + ' đánh giá');
            $('.ratting-count').html(total + ' đánh giá');
            Toast.fire({
                icon: 'success',
                title: 'Xóa đánh giá thành công'
            })
        }
    })
}
