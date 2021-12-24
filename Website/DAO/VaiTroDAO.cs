using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class VaiTroDAO
    {
        NhaTroDBContext db = null;
        public VaiTroDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<VaiTro> GetAll()
        {
            var res = db.VaiTroes.ToList();
            return res;
        }
    }
}