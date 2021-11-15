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
        public DbGeometry toado_th { get; set; }

        public virtual KhuVuc KhuVuc { get; set; }
    }
}
