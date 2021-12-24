using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class KhuVucDAO
    {
        NhaTroDBContext db = null;
        public KhuVucDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<KhuVuc> GetAllKhuVuc()
        {
            var res = db.KhuVucs.ToList();
            return res;
        }
        public KhuVuc LayKhuVuc(int ma_kv)
        {
            KhuVuc res = db.KhuVucs.Find(ma_kv);
            return res;
        }
        public KhuVuc Add(KhuVuc kv)
        {
            var res = db.KhuVucs.Add(kv);
            db.SaveChanges();
            return res;
        }
        public KhuVuc Edit(KhuVuc kv)
        {
            var res = db.KhuVucs.Find(kv.ma_kv);
            res.ma_ms = kv.ma_ms;
            res.ten_kv = kv.ten_kv;
            res.polygon_kv = kv.polygon_kv;
            res.toado_kv = kv.toado_kv;
            db.SaveChanges();
            return res;
        }
        public void Delete(int ma_kv)
        {
            new TruongHocDAO().DeleteTheoKhuVuc(ma_kv);
            new NhaTroDAO().DeleteTheoKhuVuc(ma_kv);
            KhuVuc kv = LayKhuVuc(ma_kv);
            db.KhuVucs.Remove(kv);
            db.SaveChanges();
        }
    }
}