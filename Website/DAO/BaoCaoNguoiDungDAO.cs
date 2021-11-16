using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class BaoCaoNguoiDungDAO
    {
        NhaTroDBContext db = null;
        public BaoCaoNguoiDungDAO()
        {
            db = new NhaTroDBContext();
        }
        public BaoCaoNguoiDung AddBaoCaoNguoiDung(BaoCaoNguoiDung bc)
        {
            var res = db.BaoCaoNguoiDungs.Add(bc);
            db.SaveChanges();
            return res;
        }
    }
}