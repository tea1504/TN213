using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Website.Models
{
    public class TruongHocJsonModel
    {
        [Display(Name = "Mã trường")]
        public int ma_th { get; set; }

        [Display(Name = "Mã khu vực")]
        public int ma_kv { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Tên trường")]
        public string ten_th { get; set; }

        [Required]
        [StringLength(200)]
        [Display(Name = "Địa chỉ trường")]
        public string diachi_th { get; set; }

        [Required]
        [Display(Name = "Tọa độ")]
        public string toado_th { get; set; }
    }
}