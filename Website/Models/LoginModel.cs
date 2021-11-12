using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Website.Models
{
    public class LoginModel
    {
        [Required(ErrorMessage = "Bạn phải nhận tài khoản")]
        [StringLength(50)]
        public string taikhoan { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập mật khẩu")]
        [StringLength(100)]
        public string matkhau { get; set; }
    }
}