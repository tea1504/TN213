namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("VaiTro")]
    public partial class VaiTro
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public VaiTro()
        {
            NguoiDungs = new HashSet<NguoiDung>();
        }

        [Key]
        [Display(Name = "Mã vai trò")]
        public int ma_vt { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập tên vai trò")]
        [StringLength(50, ErrorMessage = "Tên vai trò chỉ chứa tối đa 50 kỳ tự")]
        [Display(Name = "Tên vai trò")]
        public string ten_vt { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NguoiDung> NguoiDungs { get; set; }
    }
}
