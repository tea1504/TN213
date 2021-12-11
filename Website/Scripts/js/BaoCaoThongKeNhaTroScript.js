const khuvuc = document.getElementById('khuVucChart').getContext('2d');
const trungbinh = document.getElementById('trungbinh').getContext('2d');
const chatluong = document.getElementById('chatluong').getContext('2d');
const vipham = document.getElementById('vipham').getContext('2d');

$.ajax({
    url: '/Admin/BaoCaoThongKe/NhaTroKhuVuc',
    type: 'get',
    success: res => {
        console.log(res)
        new Chart(khuvuc, {
            type: 'doughnut',
            data: {
                labels: res.label,
                datasets: [
                    {
                        label: 'Số người',
                        data: res.data,
                        borderColor: res.color,
                        backgroundColor: res.color.map(el => { return el + '55'; }),
                    }
                ]
            },
            options: {

            },
        });
    }
})

$.ajax({
    url: '/Admin/BaoCaoThongKe/NhaTroDanhGiaTrungBinh',
    type: 'get',
    success: res => {
        console.log(res)
        new Chart(trungbinh, {
            type: 'radar',
            data: {
                labels: ['từ 0 đến 1', 'trên 1 đến 2', 'trên 2 đến 3', 'trên 3 đến 4', 'trên 4 đến 5'],
                datasets: [
                    {
                        label: 'Đánh giá',
                        data: res,
                        borderColor: '#f1c40f',
                        backgroundColor: '#f1c40f55',
                    }
                ]
            },
            options: {

            },
        });
    }
})

$.ajax({
    url: '/Admin/BaoCaoThongKe/NhaTroDanhGia',
    type: 'get',
    success: res => {
        var l = 5;
        res.sort((a, b) => {
            return b.soluong - a.soluong;
        })
        if (res.length > l) {
            res = Array.from(res.slice(0, l));
        }
        console.log(res);
        var data = [], label = [];
        $('#cvp').html("")
        res.map(el => {
            data.push(el.soluong);
            label.push(el.ten);
            $('#cvp').append(
                `
                    <li class="list-group-item d-flex align-items-center">
                        <div class="media align-items-center">
                            <div class="widgets-social bg-light-warning rounded-circle text-warning">
                                <i class='bx bx-home'></i>
                            </div>
                            <div class="media-body ml-2">
                                <h6 class="mb-0"><a href="/Admin/NhaTro/Detail/${el.ma}">${el.ten}</a></h6>
                            </div>
                        </div>
                        <div class="ml-auto">${Math.round(el.soluong * 100) / 100} / 5</div>
                    </li>
                `
            )
        });
        data.push(0);
        new Chart(chatluong, {
            type: 'bar',
            data: {
                labels: label,
                datasets: [
                    {
                        label: 'Số sao',
                        data: data,
                        borderColor: '#f1c40f',
                        backgroundColor: '#f1c40f55',
                    }
                ]
            },
            options: {

            },
        });
    }
})

$.ajax({
    url: '/Admin/BaoCaoThongKe/NhaTroViPham',
    type: 'get',
    success: res => {
        var l = 5;
        var datasets = [];
        var label = [];
        console.log(res);
        data = res.data
        data.sort((a, b) => {
            return b.soluong - a.soluong;
        })
        if (data.length > l) {
            data = Array.from(data.slice(0, l));
        }
        console.log('data', data);
        $('#cdg').html("")
        data.map(el => {
            label.push(el.ten);
            $('#cdg').append(
                `
                    <li class="list-group-item d-flex align-items-center">
                        <div class="media align-items-center">
                            <div class="widgets-social bg-light-danger rounded-circle text-danger">
                                <i class='bx bx-home'></i>
                            </div>
                            <div class="media-body ml-2">
                                <h6 class="mb-0"><a href="/Admin/NhaTro/Detail/${el.ma}">${el.ten}</a></h6>
                            </div>
                        </div>
                        <div class="ml-auto">${el.soluong} lần</div>
                    </li>
                `
            );
        });
        var ind = 0;
        var color = Math.random() * 11777215;
        res.label.map(el => {
            var tempdata = [];
            data.map(ele => {
                tempdata.push(ele.data[ind])
            });
            ind++;
            datasets.push({
                label: el,
                data: tempdata,
                borderColor: '#' + Math.floor(color).toString(16),
                backgroundColor: '#' + Math.floor(color).toString(16) + '55',
            });
            color += 1000000;
        })
        new Chart(vipham, {
            type: 'bar',
            data: {
                labels: label,
                datasets: datasets
            },
            options: {
                scales: {
                    xAxes: [{
                        stacked: true,
                        gridLines: {
                            display: false,
                        }
                    }],
                    yAxes: [{
                        stacked: true,
                        ticks: {
                            beginAtZero: true,
                        },
                        type: 'linear',
                    }]
                },
            },
        });
    }
})
