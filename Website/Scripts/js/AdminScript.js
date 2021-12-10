function msToTime(ngay) {
    var time = Date.parse(ngay);
    var now = new Date();
    var duration = now - time;
    var milliseconds = Math.floor((duration % 1000) / 100),
        seconds = Math.floor((duration / 1000) % 60),
        minutes = Math.floor((duration / (1000 * 60)) % 60),
        hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

    if (hours == 0) {
        if (minutes == 0) {
            if (seconds == 0) {
                return 'bây giờ';
            }
            else {
                return seconds + ' giây trước';
            }
        }
        else {
            return minutes + ' phút trước';
        }
    }
    if (hours >= 24) {
        return time.getDay() + '/' + time.getMonth() + '/' + time.getFullYear();
    }
    else {
        return hours + ' giờ trước';
    }
}

function getBCND(){
    $.ajax({
        url: '/Admin/BaoCaoNguoiDung/GetBaoCao',
        type: 'get',
        success: res => {
            var count = res.length;
            $('.nd-count').html(count);
            $('.header-notifications-list').html("");
            res.map(el => {
                var noidung = "";
                var bg = "";
                if (el.nodung <= 40) {
                    noidung = el.nodung;
                }
                else {
                    noidung = el.nodung.substring(0, 20);
                    noidung += '...';
                    noidung += el.nodung.substring(el.nodung.length - 17);
                }
                switch (el.ma) {
                    case 1:
                        bg = "success";
                        break;
                    case 2:
                        bg = "danger";
                        break;
                    case 3:
                        bg = "secondary";
                        break;
                    case 4:
                        bg = "success";
                        break;
                    case 5:
                        bg = "warning";
                        break;
                    default:
                        bg = "primary";
                }
                $('.header-notifications-list').append(`
                            <a class="dropdown-item" href="javascript:;">
                                <div class="media align-items-center">
                                    <div class="notify bg-light-${bg} text-${bg}">
                                        <i class="bx bx-group"></i>
                                    </div>
                                    <div class="media-body">
                                        <h6 class="msg-name">
                                            ${el.title}<span class="msg-time float-right">
                                                ${msToTime(el.ngay)}
                                            </span>
                                        </h6>
                                        <p class="msg-info">${noidung}</p>
                                    </div>
                                </div>
                            </a>
            `);
            })
        },
        error: err => {

        }
    })
}

function getBCNT() {
    $.ajax({
        url: '/Admin/BaoCaoNhaTro/GetBaoCao',
        type: 'get',
        success: res => {
            var count = res.length;
            $('.nt-count').html(count);
            $('.header-message-list').html("");
            res.map(el => {
                var noidung = "";
                if (el.nodung <= 40) {
                    noidung = el.nodung;
                }
                else {
                    noidung = el.nodung.substring(0, 20);
                    noidung += '...';
                    noidung += el.nodung.substring(el.nodung.length - 17);
                }
                switch (el.ma) {
                    case 1:
                        bg = "success";
                        break;
                    case 2:
                        bg = "danger";
                        break;
                    case 3:
                        bg = "secondary";
                        break;
                    case 4:
                        bg = "success";
                        break;
                    case 5:
                        bg = "warning";
                        break;
                    default:
                        bg = "primary";
                }
                $('.header-message-list').append(`
                            <a class="dropdown-item" href="javascript:;">
                                <div class="media align-items-center">
                                    <div class="notify bg-light-${bg} text-${bg}">
                                        <i class="bx bx-home"></i>
                                    </div>
                                    <div class="media-body">
                                        <h6 class="msg-name">
                                            ${el.title}<span class="msg-time float-right">
                                                ${msToTime(el.ngay)}
                                            </span>
                                        </h6>
                                        <p class="msg-info">${noidung}</p>
                                    </div>
                                </div>
                            </a>
            `);
            })
        },
        error: err => {

        }
    })
}

getBCND();
getBCNT();

//setInterval(getBCND, 60000);
//setInterval(getBCNT, 60000);