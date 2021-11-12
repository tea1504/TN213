using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace Website.EF
{
    public partial class NhaTroDBContext : DbContext
    {
        public NhaTroDBContext()
            : base("name=NhaTroDBContext")
        {
        }

        public virtual DbSet<AnhNhaTro> AnhNhaTroes { get; set; }
        public virtual DbSet<BaoCaoNguoiDung> BaoCaoNguoiDungs { get; set; }
        public virtual DbSet<BaoCaoNhaTro> BaoCaoNhaTroes { get; set; }
        public virtual DbSet<CoGia> CoGias { get; set; }
        public virtual DbSet<CoTienDienNuoc> CoTienDienNuocs { get; set; }
        public virtual DbSet<DanhGia> DanhGias { get; set; }
        public virtual DbSet<KhuVuc> KhuVucs { get; set; }
        public virtual DbSet<LoaiBaoCao> LoaiBaoCaos { get; set; }
        public virtual DbSet<LoaiPhong> LoaiPhongs { get; set; }
        public virtual DbSet<MauSac> MauSacs { get; set; }
        public virtual DbSet<Ngay> Ngays { get; set; }
        public virtual DbSet<NguoiDung> NguoiDungs { get; set; }
        public virtual DbSet<NhaTro> NhaTroes { get; set; }
        public virtual DbSet<TruongHoc> TruongHocs { get; set; }
        public virtual DbSet<VaiTro> VaiTroes { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AnhNhaTro>()
                .Property(e => e.mota_anh)
                .IsUnicode(false);

            modelBuilder.Entity<BaoCaoNguoiDung>()
                .Property(e => e.lydo)
                .IsUnicode(false);

            modelBuilder.Entity<BaoCaoNhaTro>()
                .Property(e => e.lydobaocao)
                .IsUnicode(false);

            modelBuilder.Entity<DanhGia>()
                .Property(e => e.danhgia1)
                .IsUnicode(false);

            modelBuilder.Entity<KhuVuc>()
                .Property(e => e.ma_ms)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<KhuVuc>()
                .HasMany(e => e.NhaTroes)
                .WithRequired(e => e.KhuVuc)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<KhuVuc>()
                .HasMany(e => e.TruongHocs)
                .WithRequired(e => e.KhuVuc)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<LoaiBaoCao>()
                .HasMany(e => e.BaoCaoNguoiDungs)
                .WithRequired(e => e.LoaiBaoCao)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<LoaiBaoCao>()
                .HasMany(e => e.BaoCaoNhaTroes)
                .WithRequired(e => e.LoaiBaoCao)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<LoaiPhong>()
                .Property(e => e.mota_lp)
                .IsUnicode(false);

            modelBuilder.Entity<LoaiPhong>()
                .HasMany(e => e.CoGias)
                .WithRequired(e => e.LoaiPhong)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<MauSac>()
                .Property(e => e.ma_ms)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<MauSac>()
                .HasMany(e => e.KhuVucs)
                .WithRequired(e => e.MauSac)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Ngay>()
                .HasMany(e => e.BaoCaoNguoiDungs)
                .WithRequired(e => e.Ngay1)
                .HasForeignKey(e => e.ngay)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Ngay>()
                .HasMany(e => e.BaoCaoNhaTroes)
                .WithRequired(e => e.Ngay1)
                .HasForeignKey(e => e.ngay)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Ngay>()
                .HasMany(e => e.CoGias)
                .WithRequired(e => e.Ngay1)
                .HasForeignKey(e => e.ngay)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Ngay>()
                .HasMany(e => e.CoTienDienNuocs)
                .WithRequired(e => e.Ngay1)
                .HasForeignKey(e => e.ngay)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Ngay>()
                .HasMany(e => e.DanhGias)
                .WithRequired(e => e.Ngay1)
                .HasForeignKey(e => e.ngay)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NguoiDung>()
                .Property(e => e.sdt_nd)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<NguoiDung>()
                .Property(e => e.email)
                .IsFixedLength();

            modelBuilder.Entity<NguoiDung>()
                .Property(e => e.anh_nd)
                .IsFixedLength();

            modelBuilder.Entity<NguoiDung>()
                .Property(e => e.taikhoan)
                .IsFixedLength();

            modelBuilder.Entity<NguoiDung>()
                .Property(e => e.matkhau)
                .IsFixedLength();

            modelBuilder.Entity<NguoiDung>()
                .HasMany(e => e.BaoCaoNguoiDungs)
                .WithRequired(e => e.NguoiDung)
                .HasForeignKey(e => e.nguoi_bao_cao)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NguoiDung>()
                .HasMany(e => e.BaoCaoNguoiDungs1)
                .WithRequired(e => e.NguoiDung1)
                .HasForeignKey(e => e.nguoi_bi_bao_cao)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NguoiDung>()
                .HasMany(e => e.BaoCaoNhaTroes)
                .WithRequired(e => e.NguoiDung)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NguoiDung>()
                .HasMany(e => e.DanhGias)
                .WithRequired(e => e.NguoiDung)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NguoiDung>()
                .HasMany(e => e.NhaTroes)
                .WithRequired(e => e.NguoiDung)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhaTro>()
                .Property(e => e.sdt_nt)
                .IsFixedLength()
                .IsUnicode(false);

            modelBuilder.Entity<NhaTro>()
                .HasMany(e => e.AnhNhaTroes)
                .WithRequired(e => e.NhaTro)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhaTro>()
                .HasMany(e => e.BaoCaoNhaTroes)
                .WithRequired(e => e.NhaTro)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhaTro>()
                .HasMany(e => e.CoGias)
                .WithRequired(e => e.NhaTro)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhaTro>()
                .HasMany(e => e.CoTienDienNuocs)
                .WithRequired(e => e.NhaTro)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<NhaTro>()
                .HasMany(e => e.DanhGias)
                .WithRequired(e => e.NhaTro)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<VaiTro>()
                .HasMany(e => e.NguoiDungs)
                .WithRequired(e => e.VaiTro)
                .WillCascadeOnDelete(false);
        }
    }
}
