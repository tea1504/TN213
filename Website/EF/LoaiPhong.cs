namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LoaiPhong")]
    public partial class LoaiPhong
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public LoaiPhong()
        {
            CoGias = new HashSet<CoGia>();
        }

        [Key]
        [Display(Name = "Mã loại phòng")]
        public int ma_lp { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập tên loại phòng")]
        [StringLength(50, ErrorMessage = "Tên loại phòng chỉ chứa 50 ký tự")]
        [Display(Name = "Tên loại phòng")]
        public string ten_lp { get; set; }

        [Column(TypeName = "text")]
        [Display(Name = "Mô tả loại phòng")]
        public string mota_lp { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CoGia> CoGias { get; set; }
    }
}
