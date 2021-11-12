namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("NguoiDung")]
    public partial class NguoiDung
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NguoiDung()
        {
            BaoCaoNguoiDungs = new HashSet<BaoCaoNguoiDung>();
            BaoCaoNguoiDungs1 = new HashSet<BaoCaoNguoiDung>();
            BaoCaoNhaTroes = new HashSet<BaoCaoNhaTro>();
            DanhGias = new HashSet<DanhGia>();
            NhaTroes = new HashSet<NhaTro>();
        }

        [Key]
        public int ma_nd { get; set; }

        public int ma_vt { get; set; }

        [Required]
        [StringLength(15)]
        public string ten_nd { get; set; }

        [Required]
        [StringLength(35)]
        public string holot_nd { get; set; }

        public byte gioitinh_nd { get; set; }

        [StringLength(10)]
        public string sdt_nd { get; set; }

        [StringLength(50)]
        public string email { get; set; }

        [StringLength(200)]
        public string diachi { get; set; }

        [Required]
        [StringLength(50)]
        public string anh_nd { get; set; }

        [Required]
        [StringLength(50)]
        public string taikhoan { get; set; }

        [Required]
        [StringLength(100)]
        public string matkhau { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BaoCaoNguoiDung> BaoCaoNguoiDungs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BaoCaoNguoiDung> BaoCaoNguoiDungs1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BaoCaoNhaTro> BaoCaoNhaTroes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DanhGia> DanhGias { get; set; }

        public virtual VaiTro VaiTro { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NhaTro> NhaTroes { get; set; }
    }
}
