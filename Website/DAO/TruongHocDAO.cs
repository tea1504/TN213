using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

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
    }
}