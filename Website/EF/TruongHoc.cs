namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TruongHoc")]
    public partial class TruongHoc
    {
        [Key]
        [Display(Name = "Mã trường")]
        public int ma_th { get; set; }

        [Display(Name = "Mã khu vực")]
        public int ma_kv { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập tên trường")]
        [StringLength(100, ErrorMessage = "Tên trường chỉ chứa 100 kỳ tự. Bạn có thể viết tắt nếu tên trường quá dài.")]
        [Display(Name = "Tên trường")]
        public string ten_th { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập địa chỉ")]
        [StringLength(200, ErrorMessage = "Địa chỉ chỉ chứa tối đa 200 ký tự")]
        [Display(Name = "Địa chỉ trường")]
        public string diachi_th { get; set; }

        [Required]
        [Display(Name = "Tọa độ")]
        public DbGeometry toado_th { get; set; }

        public virtual KhuVuc KhuVuc { get; set; }
    }
}
