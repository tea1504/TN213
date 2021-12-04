namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("MauSac")]
    public partial class MauSac
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public MauSac()
        {
            KhuVucs = new HashSet<KhuVuc>();
        }

        [Key]
        [StringLength(6, ErrorMessage = "Mã màu sắc chỉ chứa 6 ký tự")]
        [RegularExpression("([a-fA-F0-9]{6}|[a-fA-F0-9]{3})", ErrorMessage = "Bạn phải nhập đúng mã màu")]
        [Display(Name = "Mã màu sắc")]
        public string ma_ms { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập tên màu sắc")]
        [StringLength(50, ErrorMessage = "Tên màu sắc chỉ chứa tối đa 50 ký tự")]
        [Display(Name = "Tên màu sắc")]
        public string ten_ms { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<KhuVuc> KhuVucs { get; set; }
    }
}
