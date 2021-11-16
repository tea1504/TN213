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
            var res = db.DanhGias.Where(dg=>dg.ma_nt == ma_nt).Select(dg=>dg.sosao).DefaultIfEmpty(0).Average();
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
        public DanhGia XoaDanhGia(int ma_nt, int ma_nd, string ngay)
        {
            string ngayTemp = ngay.Substring(0, ngay.Length - 4);
            var danhGia = db.DanhGias.Where(dg => dg.ma_nt == ma_nt && dg.ma_nd == ma_nd && (dg.ngay.ToString("yyyy-MM-ddTHH:mm:ss")).Equals(ngayTemp)).SingleOrDefault();
            var res = db.DanhGias.Remove(danhGia);
            db.SaveChanges();
            return res;
        }
    }
}