namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CoGia")]
    public partial class CoGia
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        [Display(Name = "Nhà trọ")]
        public int ma_nt { get; set; }

        [Key]
        [Column(Order = 1)]
        [Display(Name = "Ngày")]
        public DateTime ngay { get; set; }

        [Display(Name = "Loại phòng")]
        public int ma_lp { get; set; }

        [Display(Name = "Giá phòng")]
        public double? giaphong { get; set; }

        public virtual NhaTro NhaTro { get; set; }

        public virtual Ngay Ngay1 { get; set; }

        public virtual LoaiPhong LoaiPhong { get; set; }
    }
}
