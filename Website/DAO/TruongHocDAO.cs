using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;
using Website.Models;

namespace Website.DAO
{
    public class TruongHocDAO
    {
        NhaTroDBContext db = null;
        public TruongHocDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<TruongHoc> GetAllTruongHoc()
        {
            var res = db.TruongHocs.ToList();
            return res;
        }
        public TruongHoc GetTruongHoc(int ma_th)
        {
            var res = db.TruongHocs.Find(ma_th);
            return res;
        }
        public List<TruongHocJsonModel> GetAllTruongHocJson()
        {
            var res = db.TruongHocs.Select(th => new TruongHocJsonModel { ma_th = th.ma_th, ma_kv = th.ma_kv, diachi_th = th.diachi_th, ten_th = th.ten_th, toado_th = th.toado_th.AsText() }).ToList();
            return res;
        }
        public TruongHocJsonModel GetTruongHocJson(int ma_th)
        {
            var res = db.TruongHocs.Where(th=>th.ma_th == ma_th).Select(th => new TruongHocJsonModel { ma_th = th.ma_th, ma_kv = th.ma_kv, diachi_th = th.diachi_th, ten_th = th.ten_th, toado_th = th.toado_th.AsText() }).SingleOrDefault();
            return res;
        }
    }
}