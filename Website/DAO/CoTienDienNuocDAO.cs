using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class CoTienDienNuocDAO
    {
        NhaTroDBContext db = null;
        public CoTienDienNuocDAO()
        {
            db = new NhaTroDBContext();
        }
        public float? GetTienDien(int ma_nt)
        {
            object[] sqpParams =
            {
                new SqlParameter("@ma_nt", ma_nt)
            };
            var res = db.Database.SqlQuery<double?>("SELECT dbo.fn_tim_tien_dien(@ma_nt)", sqpParams).SingleOrDefault();
            return (float?)res;
        }
        public float? GetTienNuoc(int ma_nt)
        {
            object[] sqpParams =
            {
                new SqlParameter("@ma_nt", ma_nt)
            };
            var res = db.Database.SqlQuery<double?>("SELECT dbo.fn_tim_tien_nuoc(@ma_nt)", sqpParams).SingleOrDefault();
            return (float?)res;
        }
        public CoTienDienNuoc Add(CoTienDienNuoc dn)
        {
            dn.ngay = DateTime.Now;
            var res = db.CoTienDienNuocs.Add(dn);
            db.SaveChanges();
            return res;
        }
        public List<CoTienDienNuoc> GetTheoNhaTro(int ma_nt)
        {
            var res = db.CoTienDienNuocs.Where(dn => dn.ma_nt == ma_nt).ToList();
            return res;
        }
        public void DeteleTheoNhaTro(int ma_nt)
        {
            var list = GetTheoNhaTro(ma_nt);
            if (list != null)
            {
                foreach(var item in list)
                {
                    db.CoTienDienNuocs.Remove(item);
                    db.SaveChanges();
                }
            }
        }
    }
}