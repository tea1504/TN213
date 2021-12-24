using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Website.Models
{
    public class RegisterModel
    {
        [Display(Name = "Vai trò")]
        public int ma_vt { get; set; }

        [Required]
        [StringLength(15)]
        [Display(Name = "Tên")]
        public string ten_nd { get; set; }

        [Required]
        [StringLength(35)]
        [Display(Name = "Họ lót")]
        public string holot_nd { get; set; }

        [Display(Name = "Giới tính")]
        public byte gioitinh_nd { get; set; }

        [Required]
        [StringLength(50)]
        [Display(Name = "Tài khoản")]
        public string taikhoan { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Mật khẩu")]
        public string matkhau { get; set; }

        [Required]
        [Compare("matkhau", ErrorMessage = "Confirm password doesn't match, Type again !")]
        [DataType(DataType.Password)]
        public string Confirmpwd { get; set; }
    }
}