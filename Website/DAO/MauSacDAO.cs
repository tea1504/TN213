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
    }
}