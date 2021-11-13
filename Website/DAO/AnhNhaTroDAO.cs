using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class AnhNhaTroDAO
    {
        NhaTroDBContext db = null;
        public AnhNhaTroDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<AnhNhaTro> GetAnhNhaTroTheoMaNhaTro(int ma_nt)
        {
            var res = db.AnhNhaTroes.Where(anh => anh.ma_nt == ma_nt).ToList();
            return res;
        }
    }
}