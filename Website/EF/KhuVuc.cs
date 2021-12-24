namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("KhuVuc")]
    public partial class KhuVuc
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KhuVuc()
        {
            NhaTroes = new HashSet<NhaTro>();
            TruongHocs = new HashSet<TruongHoc>();
        }

        [Key]
        [Display(Name = "Mã khu vực")]
        public int ma_kv { get; set; }

        [Required(ErrorMessage = "Bạn phải chọn màu sắc")]
        [StringLength(6)]
        [Display(Name = "Màu sắc")]
        public string ma_ms { get; set; }

        [Required(ErrorMessage ="Bạn phải nhập tên khu vực")]
        [StringLength(50, ErrorMessage = "Tên khu vực chỉ chứa tối đa 50 ký tự")]
        [Display(Name = "Tên khu vực")]
        public string ten_kv { get; set; }

        [Required]
        public DbGeometry toado_kv { get; set; }

        [Required]
        public DbGeometry polygon_kv { get; set; }

        public virtual MauSac MauSac { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NhaTro> NhaTroes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TruongHoc> TruongHocs { get; set; }
    }
}
