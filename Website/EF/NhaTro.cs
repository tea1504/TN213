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
        public int ma_nt { get; set; }

        public int ma_nd { get; set; }

        public int ma_kv { get; set; }

        [Required]
        [StringLength(50)]
        public string ten_nt { get; set; }

        [Required]
        [StringLength(200)]
        public string diachi_nt { get; set; }

        [Required]
        [StringLength(10)]
        public string sdt_nt { get; set; }

        [Required]
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
