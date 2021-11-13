using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class DanhGiaDAO
    {
        NhaTroDBContext db = null;
        public DanhGiaDAO()
        {
            db = new NhaTroDBContext();
        }

    }
}