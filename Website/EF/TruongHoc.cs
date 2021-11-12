namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("TruongHoc")]
    public partial class TruongHoc
    {
        [Key]
        public int ma_th { get; set; }

        public int ma_kv { get; set; }

        [Required]
        [StringLength(100)]
        public string ten_th { get; set; }

        [Required]
        [StringLength(200)]
        public string diachi_th { get; set; }

        [Required]
        public DbGeometry toado_th { get; set; }

        public virtual KhuVuc KhuVuc { get; set; }
    }
}
