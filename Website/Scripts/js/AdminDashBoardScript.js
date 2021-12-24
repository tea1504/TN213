var _label = [];
var _data = [];

$.ajax({
    url: '/Admin/DashBoard/GetDanhGia',
    type: 'get',
    success: res => {
        _label = res.labels.slice();
        _data = res.dulieu.slice();
        danhGiaAll(res.labels, res.dulieu);
        $('#danhgiatoday').html('');
        res.today.map((el, ind) => {
            var sosao = '';
            var percent = 0.0;
            var percent_html = '';
            var old = res.tomorow[ind];
            if (old == 0) {
                percent = el * 100;
            }
            else {
                percent = (el - old) * 100 / old;
            }
            percent = Math.round(percent * 100) / 100;
            for (var i = 0; i <= ind; i++) {
                sosao += `<i class="bx bx-star"></i>`;
            }
            for (var i = 0; i < 4 - ind; i++) {
                sosao += `<i class="bx bxs-star"></i>`;
            }
            if (percent >= 0) {
                percent_html = `<div class="ml-auto text-success">
                                        <span>${percent}%</span>
                                    </div>`;
            }
            else {
                percent_html = `<div class="ml-auto text-danger">
                                        <span>${percent}%</span>
                                    </div>`;
            }
            $('#danhgiatoday').append(
                `
                    <div class="col">
                        <div class="card radius-15 mx-0">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div>
                                        <p class="mb-0">${sosao}</p>
                                    </div>
                                    ${percent_html}
                                </div>
                                <h4 class="mb-0">${el}</h4>
                            </div>
                        </div>
                    </div>
                `
            );
        })
    }
})

$('#a').click(e => {
    danhGiaAll(_label, _data);
});
$('#m').click(e => {
    var l = _label.length;
    danhGiaAll(_label.slice(l - 30), _data.slice(l - 30));
});
$('#w').click(e => {
    var l = _label.length;
    danhGiaAll(_label.slice(l - 7), _data.slice(l - 7));
});

function danhGiaAll(label, dulieu) {
    var datasets = [];
    var data = [[], [], [], [], []];
    dulieu.map((el, ind) => {
        for (var i = 0; i < 5; i++) {
            data[i].push(el[i]);
        }
    });
    var color = Math.random() * 11777215;
    data.map((el, ind) => {
        datasets.push({
            label: (ind + 1) + ' sao',
            data: el,
            borderColor: '#' + Math.floor(color).toString(16),
            backgroundColor: '#' + Math.floor(color).toString(16) + '55',
        });
        color += 1000000;
    })
    danhGiaChart(label, datasets);
}

function danhGiaChart(label, datasets) {
    const danhgia = document.getElementById('danhGiaChart').getContext('2d');
    var char = new Chart(danhgia, {
        type: 'line',
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
            }
        },
    });
    console.log(char);
}
