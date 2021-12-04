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
        [Display(Name = "Người báo cáo")]
        public int ma_nd { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        [Display(Name = "Nhà trọ bị báo cáo")]
        public int ma_nt { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        [Display(Name = "Loại báo cáo")]
        public int ma_lbc { get; set; }

        [Key]
        [Column(Order = 3)]
        [Display(Name = "Ngày báo cáo")]
        public DateTime ngay { get; set; }

        [Column(TypeName = "nvarchar")]
        [Display(Name = "Lý do báo cáo")]
        public string lydobaocao { get; set; }

        [Display(Name = "Trạng thái")]
        public byte? trangthaibaocao { get; set; }

        public virtual NguoiDung NguoiDung { get; set; }

        public virtual NhaTro NhaTro { get; set; }

        public virtual LoaiBaoCao LoaiBaoCao { get; set; }

        public virtual Ngay Ngay1 { get; set; }
    }
}
