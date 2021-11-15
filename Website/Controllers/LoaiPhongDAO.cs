using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.Controllers
{
    public class LoaiPhongDAO
    {
        NhaTroDBContext db = null;
        public LoaiPhongDAO()
        {
            db = new NhaTroDBContext();
        }
        public LoaiPhong GetLoaiPhong(int ma_lp)
        {
            var res = db.LoaiPhongs.Find(ma_lp);
            return res;
        }
    }
}