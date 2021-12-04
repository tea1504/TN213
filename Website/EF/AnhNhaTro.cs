namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("AnhNhaTro")]
    public partial class AnhNhaTro
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ma_nt { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int STT { get; set; }

        [Required(ErrorMessage = "Bạn phải nhập tên ảnh")]
        [StringLength(200, ErrorMessage = "Tên ảnh chỉ chứa 200 ký tự")]
        [Display(Name = "Tên ảnh")]
        public string ten_anh { get; set; }

        [Column(TypeName = "nvarchar")]
        [Display(Name = "Mô tả ảnh")]
        public string mota_anh { get; set; }

        public virtual NhaTro NhaTro { get; set; }
    }
}
