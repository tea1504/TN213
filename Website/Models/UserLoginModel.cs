using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Website.Models
{
    public class UserLoginModel
    {
        public int ma_nd { get; set; }

        public int ma_vt { get; set; }

        [Required]
        [StringLength(15)]
        public string ten_nd { get; set; }

        [Required]
        [StringLength(35)]
        public string holot_nd { get; set; }

        [Required]
        [StringLength(50)]
        public string anh_nd { get; set; }

        [Required]
        [StringLength(50)]
        public string taikhoan { get; set; }
    }
}