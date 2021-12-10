const gioitinh = document.getElementById('gioiTinhChart').getContext('2d');
const vaitro = document.getElementById('vaiTroChart').getContext('2d');
const vipham = document.getElementById('viPhamChart').getContext('2d');
const donggop = document.getElementById('dongGopChart').getContext('2d');

$.ajax({
    url: '/Admin/BaoCaoThongKe/NguoiDungGioiTinh',
    type: 'get',
    success: res => {
        console.log(res)
        new Chart(gioitinh, {
            type: 'pie',
            data: {
                labels: ['Nữ', 'Nam'],
                datasets: [
                    {
                        label: 'Số người',
                        data: [res.nu, res.nam],
                        borderColor: ['#fcb2ef', '#a0d2ed'],
                        backgroundColor: ['#fcb2ef', '#a0d2ed'],
                    }
                ]
            },
            options: {
                
            },
        });
    }
})

$.ajax({
    url: '/Admin/BaoCaoThongKe/NguoiDungVaiTro',
    type: 'get',
    success: res => {
        console.log(res)
        new Chart(vaitro, {
            type: 'pie',
            data: {
                labels: res.label,
                datasets: [
                    {
                        label: 'Số người',
                        data: res.data,
                        borderColor: ['#1abc9c', '#e67e22', '#9b59b6'],
                        backgroundColor: ['#1abc9c', '#e67e22', '#9b59b6'],
                    }
                ]
            },
            options: {

            },
        });
    }
})

$.ajax({
    url: '/Admin/BaoCaoThongKe/NguoiDungViPham',
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
                            <div class="widgets-social bg-light-danger rounded-circle text-danger">
                                <i class='bx bx-user'></i>
                            </div>
                            <div class="media-body ml-2">
                                <h6 class="mb-0"><a href="/Admin/NguoiDung/Detail/${el.ma}">${el.ten}</a></h6>
                            </div>
                        </div>
                        <div class="ml-auto">${el.soluong} lần</div>
                    </li>
                `
            )
        });
        data.push(0);
        new Chart(vipham, {
            type: 'bar',
            data: {
                labels: label,
                datasets: [
                    {
                        label: 'Số lần bị báo cáo',
                        data: data,
                        borderColor: '#c0392b',
                        backgroundColor: '#c0392bcc',
                    }
                ]
            },
            options: {

            },
        });
    }
})

$.ajax({
    url: '/Admin/BaoCaoThongKe/NguoiDungDongGop',
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
        var data1 = [],
            data2 = [],
            data3 = [],
            label = [];
        $('#cdg').html("")
        res.map(el => {
            data1.push(el.baocaonguoi);
            data2.push(el.baocaonhatro);
            data3.push(el.danhgia);
            label.push(el.ten);
            $('#cdg').append(
                `
                    <li class="list-group-item d-flex align-items-center">
                        <div class="media align-items-center">
                            <div class="widgets-social bg-light-success rounded-circle text-success">
                                <i class='bx bx-user'></i>
                            </div>
                            <div class="media-body ml-2">
                                <h6 class="mb-0"><a href="/Admin/NguoiDung/Detail/${el.ma}">${el.ten}</a></h6>
                            </div>
                        </div>
                        <div class="ml-auto">${el.soluong} lần</div>
                    </li>
                `
            )
        });
        data1.push(0);
        data2.push(0);
        data3.push(0);
        new Chart(donggop, {
            type: 'bar',
            data: {
                labels: label,
                datasets: [
                    {
                        label: 'Báo cáo người dùng',
                        data: data1,
                        borderColor: '#27ae60',
                        backgroundColor: '#27ae60cc',
                    },
                    {
                        label: 'Báo cáo nhà trọ',
                        data: data2,
                        borderColor: '#2c3e50',
                        backgroundColor: '#2c3e50cc',
                    },
                    {
                        label: 'Đánh giá nhà trọ',
                        data: data3,
                        borderColor: '#f1c40f',
                        backgroundColor: '#f1c40fcc',
                    },
                ]
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
