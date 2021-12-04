namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("NhaTro")]
    public partial class NhaTro
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NhaTro()
        {
            AnhNhaTroes = new HashSet<AnhNhaTro>();
            BaoCaoNhaTroes = new HashSet<BaoCaoNhaTro>();
            CoGias = new HashSet<CoGia>();
            CoTienDienNuocs = new HashSet<CoTienDienNuoc>();
            DanhGias = new HashSet<DanhGia>();
        }

        [Key]
        [Display(Name = "Mã nhà trọ")]
        public int ma_nt { get; set; }

        [Display(Name = "Chủ trọ")]
        public int ma_nd { get; set; }

        [Display(Name = "Khu vực")]
        public int ma_kv { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập tên nhà trọ")]
        [StringLength(50, ErrorMessage = "Tên nhà trọ chỉ chứa 50 ký tự")]
        [Display(Name = "Tên nhà trọ")]
        public string ten_nt { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập địa chỉ trọ")]
        [StringLength(200, ErrorMessage = "Địa chỉ chứa tối đa 200 ký tự")]
        [Display(Name = "Địa chỉ")]
        public string diachi_nt { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập số điện thoại")]
        [StringLength(10)]
        [RegularExpression("[0-9]{10}", ErrorMessage = "Bạn phải nhập số điện thoại")]
        [Display(Name = "Điện thoại")]
        public string sdt_nt { get; set; }

        [Required]
        [Display(Name = "Tọa độ")]
        public DbGeometry toado_nt { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AnhNhaTro> AnhNhaTroes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BaoCaoNhaTro> BaoCaoNhaTroes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CoGia> CoGias { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CoTienDienNuoc> CoTienDienNuocs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DanhGia> DanhGias { get; set; }

        public virtual KhuVuc KhuVuc { get; set; }

        public virtual NguoiDung NguoiDung { get; set; }
    }
}
