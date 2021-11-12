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
        public int ma_nt { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime ngay { get; set; }

        public double? tiendien { get; set; }

        public double? tiennuoc { get; set; }

        public virtual NhaTro NhaTro { get; set; }

        public virtual Ngay Ngay1 { get; set; }
    }
}
