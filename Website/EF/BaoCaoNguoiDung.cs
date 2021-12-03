namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("BaoCaoNguoiDung")]
    public partial class BaoCaoNguoiDung
    {
        [Key]
        [Column(Order = 0)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int nguoi_bao_cao { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int nguoi_bi_bao_cao { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ma_lbc { get; set; }

        [Key]
        [Column(Order = 3)]
        public DateTime ngay { get; set; }

        [Column(TypeName = "nvarchar")]
        public string lydo { get; set; }

        public byte? trangthai { get; set; }

        public virtual NguoiDung NguoiDung { get; set; }

        public virtual NguoiDung NguoiDung1 { get; set; }

        public virtual LoaiBaoCao LoaiBaoCao { get; set; }

        public virtual Ngay Ngay1 { get; set; }
    }
}
