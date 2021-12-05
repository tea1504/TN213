using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class MauSacDAO
    {
        NhaTroDBContext db = null;
        public MauSacDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<MauSac> GetAll()
        {
            var res = db.MauSacs.ToList();
            return res;
        }
        public MauSac Get(string ma_ms)
        {
            var res = db.MauSacs.Find(ma_ms);
            return res;
        }
        public MauSac Add(MauSac ms)
        {
            var res = db.MauSacs.Add(ms);
            db.SaveChanges();
            return res;
        }
        public MauSac Edit(MauSac ms)
        {
            var res = db.MauSacs.Find(ms.ma_ms);
            res.ten_ms = ms.ten_ms;
            db.SaveChanges();
            return res;
        }
        public void Delete(string ma_ms)
        {
            var res = db.MauSacs.Find(ma_ms);
            db.MauSacs.Remove(res);
            db.SaveChanges();
        }
    }
}