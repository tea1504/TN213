const reader = new FileReader();
const fileInput = document.getElementById("anh");
const img = document.getElementById("preview-img");
reader.onload = e => {
    img.src = e.target.result;
}
fileInput.addEventListener('change', e => {
    const f = e.target.files[0];
    reader.readAsDataURL(f);
})

function removeAccents(str) {
    var AccentsMap = [
        "aàảãáạăằẳẵắặâầẩẫấậ",
        "AÀẢÃÁẠĂẰẲẴẮẶÂẦẨẪẤẬ",
        "dđ", "DĐ",
        "eèẻẽéẹêềểễếệ",
        "EÈẺẼÉẸÊỀỂỄẾỆ",
        "iìỉĩíị",
        "IÌỈĨÍỊ",
        "oòỏõóọôồổỗốộơờởỡớợ",
        "OÒỎÕÓỌÔỒỔỖỐỘƠỜỞỠỚỢ",
        "uùủũúụưừửữứự",
        "UÙỦŨÚỤƯỪỬỮỨỰ",
        "yỳỷỹýỵ",
        "YỲỶỸÝỴ"
    ];
    for (var i = 0; i < AccentsMap.length; i++) {
        var re = new RegExp('[' + AccentsMap[i].substr(1) + ']', 'g');
        var char = AccentsMap[i][0];
        str = str.replace(re, char);
    }
    return str;
}

var randomstring = Math.random().toString(36).slice(-8);

$('#matkhau').val(randomstring);

$('#ten_nd').change(e => {
    var ten = $('#ten_nd').val().toLowerCase().replace(/\s/g, '');
    var ho = $('#holot_nd').val().toLowerCase().split(' ');
    var code = $('#code').val();
    var tk = removeAccents(ten);
    ho.map(e => {
        if (e)
            tk += removeAccents(e)[0];
    })
    tk += code;
    $('#taikhoan').val(tk);
})

$('#holot_nd').change(e => {
    var ten = $('#ten_nd').val().toLowerCase().replace(/\s/g, '');
    var ho = $('#holot_nd').val().toLowerCase().split(' ');
    var code = $('#code').val();
    var tk = removeAccents(ten);
    ho.map(e => {
        if (e)
            tk += removeAccents(e)[0];
    })
    tk += code;
    $('#taikhoan').val(tk);
})