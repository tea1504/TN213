using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class BaoCaoNhaTroDAO
    {
        NhaTroDBContext db = null;
        public BaoCaoNhaTroDAO()
        {
            db = new NhaTroDBContext();
        }
        public BaoCaoNhaTro AddBaoCaoNhaTro(BaoCaoNhaTro bc)
        {
            var res = db.BaoCaoNhaTroes.Add(bc);
            db.SaveChanges();
            return res;
        }
    }
}