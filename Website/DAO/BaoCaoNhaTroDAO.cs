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
        public List<BaoCaoNhaTro> GetTheoNhaTro(int ma_nt)
        {
            var res = db.BaoCaoNhaTroes.Where(bc => bc.ma_nt == ma_nt).ToList();
            return res;
        }
        public void DeleteTheoNhaTro(int ma_nt)
        {
            var list = GetTheoNhaTro(ma_nt);
            if (list != null)
            {
                foreach(var item in list)
                {
                    db.BaoCaoNhaTroes.Remove(item);
                    db.SaveChanges();
                }
            }
        }
    }
}