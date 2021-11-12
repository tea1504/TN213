namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DanhGia")]
    public partial class DanhGia
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ma_nt { get; set; }

        [Key]
        [Column(Order = 1)]
        public DateTime ngay { get; set; }

        public int ma_nd { get; set; }

        [Column("danhgia", TypeName = "text")]
        public string danhgia1 { get; set; }

        public int sosao { get; set; }

        public virtual Ngay Ngay1 { get; set; }

        public virtual NguoiDung NguoiDung { get; set; }

        public virtual NhaTro NhaTro { get; set; }
    }
}
