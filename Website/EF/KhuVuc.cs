namespace Website.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("KhuVuc")]
    public partial class KhuVuc
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public KhuVuc()
        {
            NhaTroes = new HashSet<NhaTro>();
            TruongHocs = new HashSet<TruongHoc>();
        }

        [Key]
        public int ma_kv { get; set; }

        [Required]
        [StringLength(6)]
        public string ma_ms { get; set; }

        [Required]
        [StringLength(50)]
        public string ten_kv { get; set; }

        [Required]
        public DbGeometry toado_kv { get; set; }

        [Required]
        public DbGeometry polygon_kv { get; set; }

        public virtual MauSac MauSac { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NhaTro> NhaTroes { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TruongHoc> TruongHocs { get; set; }
    }
}
