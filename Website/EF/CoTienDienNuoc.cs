namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CoTienDienNuoc")]
    public partial class CoTienDienNuoc
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

        [Display(Name = "Tiền điện")]
        public double? tiendien { get; set; }

        [Display(Name = "Tiền nước")]
        public double? tiennuoc { get; set; }

        public virtual NhaTro NhaTro { get; set; }

        public virtual Ngay Ngay1 { get; set; }
    }
}
