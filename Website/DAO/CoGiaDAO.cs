using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class CoGiaDAO
    {
        NhaTroDBContext db = null;
        public CoGiaDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<CoGia> GetGiaPhongGanDayTheoNhaTro(int ma_nt)
        {
            object[] sqlParams =
            {
                new SqlParameter("@ma_nt", ma_nt),
            };
            var res = db.Database.SqlQuery<CoGia>("sp_get_gia_phong_hien_tai @ma_nt", sqlParams).ToList();
            for(var i=0; i< res.Count; i++)
            {
                res[i].LoaiPhong = new LoaiPhongDAO().GetLoaiPhong(res[i].ma_lp);
                res[i].NhaTro = new NhaTroDAO().GetNhaTro(res[i].ma_nt);
            }
            return res;
        }
        public CoGia Add(CoGia cg)
        {
            cg.ngay = DateTime.Now;
            var res = db.CoGias.Add(cg);
            db.SaveChanges();
            return res;
        }
        public List<CoGia> GetTheoNhaTro(int ma_nt)
        {
            var res = db.CoGias.Where(cg => cg.ma_nt == ma_nt).ToList();
            return res;
        }
        public void DeleteTheoMaNT(int ma_nt)
        {
            var list = GetTheoNhaTro(ma_nt);
            if (list != null)
            {
                foreach (var item in list)
                {
                    db.CoGias.Remove(item);
                    db.SaveChanges();
                }
            }
        }
        public List<CoGia> GetAll()
        {
            var res = db.CoGias.ToList();
            return res;
        }
        public List<CoGia> GetTheoNhaTroVaLoaiPhong(int ma_nt, int ma_lp)
        {
            var res = db.CoGias.Where(cg => cg.ma_nt == ma_nt && cg.ma_lp == ma_lp).ToList();
            return res;
        }
    }
}