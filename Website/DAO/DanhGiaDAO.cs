using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class DanhGiaDAO
    {
        NhaTroDBContext db = null;
        public DanhGiaDAO()
        {
            db = new NhaTroDBContext();
        }
        public float TBSoSaoTheoNhaTro(int ma_nt)
        {
            var res = db.DanhGias.Where(dg => dg.ma_nt == ma_nt).Select(dg => dg.sosao).DefaultIfEmpty(0).Average();
            return (float)res;
        }
        public int DemSoDanhGiaTheoNhaTro(int ma_nt)
        {
            var res = db.DanhGias.Where(dg => dg.ma_nt == ma_nt).Count();
            return res;
        }
        public DanhGia AddDanhGia(DanhGia dg)
        {
            var res = db.DanhGias.Add(dg);
            db.SaveChanges();
            return res;
        }
        public DanhGia XoaDanhGia(int ma_nt, int ma_nd, DateTime ngay, string danhgia, int? sosao)
        {
            var danhGia = db.DanhGias.Where(dg => dg.ma_nt == ma_nt && dg.ma_nd == ma_nd && dg.ngay == ngay).SingleOrDefault();
            if (danhGia == null)
            {
                danhGia = db.DanhGias.Where(dg => dg.ma_nt == ma_nt && dg.ma_nd == ma_nd && dg.sosao == sosao && dg.danhgia1.Contains(danhgia)).OrderByDescending(dg => dg.ngay).Take(1).SingleOrDefault();
            }
            if (danhGia != null)
            {
                var res = db.DanhGias.Remove(danhGia);
                db.SaveChanges();
                return res;
            }
            return new DanhGia();
        }
        public void Delete(int ma_nt, int ma_nd, DateTime ngay)
        {
            var danhGia = db.DanhGias.Where(dg => dg.ma_nt == ma_nt && dg.ma_nd == ma_nd && dg.ngay == ngay).SingleOrDefault();
            var res = db.DanhGias.Remove(danhGia);
            db.SaveChanges();
        }
        public List<DanhGia> GetTheoNhaTro(int ma_nt)
        {
            var res = db.DanhGias.Where(dg => dg.ma_nt == ma_nt).ToList();
            return res;
        }
        public void DeleteTheoNhaTro(int ma_nt)
        {
            var list = GetTheoNhaTro(ma_nt);
            foreach (var item in list)
            {
                db.DanhGias.Remove(item);
                db.SaveChanges();
            }
        }
        public int CountStar(int ma_nt, int num)
        {
            var res = db.DanhGias.Where(dg => dg.ma_nt == ma_nt && dg.sosao == num).Count();
            return res;
        }
        public List<DanhGia> GetAll()
        {
            var res = db.DanhGias.ToList();
            return res;
        }
        public List<DanhGia> GetTheoNguoiDung(int ma_nd)
        {
            var res = db.DanhGias.Where(dg => dg.ma_nd == ma_nd).ToList();
            return res;
        }
        public void DeleteTheoNguoiDung(int ma_nd)
        {
            var list = GetTheoNguoiDung(ma_nd);
            foreach (var item in list)
            {
                db.DanhGias.Remove(item);
                db.SaveChanges();
            }
        }
    }
}