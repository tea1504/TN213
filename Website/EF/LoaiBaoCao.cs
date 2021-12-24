namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LoaiBaoCao")]
    public partial class LoaiBaoCao
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LoaiBaoCao()
        {
            BaoCaoNguoiDungs = new HashSet<BaoCaoNguoiDung>();
            BaoCaoNhaTroes = new HashSet<BaoCaoNhaTro>();
        }

        [Key]
        [Display(Name = "Mã loại báo cáo")]
        public int ma_lbc { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập tên loại báo cáo")]
        [StringLength(50, ErrorMessage = "Tên loại báo cáo chỉ chứa 50 ký tự")]
        [Display(Name = "Tên loại báo cáo")]
        public string ten_lbc { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BaoCaoNguoiDung> BaoCaoNguoiDungs { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<BaoCaoNhaTro> BaoCaoNhaTroes { get; set; }
    }
}
