namespace Website.EF
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

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
        [Display(Name = "Mã người dùng")]
        public int ma_nd { get; set; }

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

        [StringLength(10)]
        [Display(Name = "Điện thoại")]
        public string sdt_nd { get; set; }

        [StringLength(50)]
        [Display(Name = "Email")]
        public string email { get; set; }

        [StringLength(200)]
        [Display(Name = "Địa chỉ")]
        public string diachi { get; set; }

        [Required]
        [StringLength(200)]
        [Display(Name = "Ảnh đại diện")]
        public string anh_nd { get; set; }

        [Required]
        [StringLength(50)]
        [Display(Name = "Tài khoản")]
        public string taikhoan { get; set; }

        [Required]
        [StringLength(100)]
        [Display(Name = "Mật khẩu")]
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
