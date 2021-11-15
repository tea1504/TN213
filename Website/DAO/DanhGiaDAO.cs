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
    }
}