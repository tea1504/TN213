using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class LoaiBaoCaoDAO
    {
        NhaTroDBContext db = null;
        public LoaiBaoCaoDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<LoaiBaoCao> GetAllLoaiBaoCao()
        {
            var res = db.LoaiBaoCaos.ToList();
            return res;
        }
    }
}