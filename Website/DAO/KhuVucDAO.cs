using System;
using System.Collections.Generic;
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
    }
}