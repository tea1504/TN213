namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BaoCaoNhaTro")]
    public partial class BaoCaoNhaTro
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ma_nd { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ma_nt { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ma_lbc { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime ngay { get; set; }

        [Column(TypeName = "nvarchar")]
        public string lydobaocao { get; set; }

        public byte? trangthaibaocao { get; set; }

        public virtual NguoiDung NguoiDung { get; set; }

        public virtual NhaTro NhaTro { get; set; }

        public virtual LoaiBaoCao LoaiBaoCao { get; set; }

        public virtual Ngay Ngay1 { get; set; }
    }
}
