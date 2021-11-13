using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;
using Website.Models;

namespace Website.DAO
{
    public class NhaTroDAO
    {
        NhaTroDBContext db = null;
        public NhaTroDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<NhaTro> FilterNhaTro(FilterNhaTroModel f)
        {
            object[] sqlParams =
            {
                new SqlParameter("@ma_kv", f.ma_kv),
                new SqlParameter("@tiendien", f.tiendien),
                new SqlParameter("@tiennuoc", f.tiennuoc),
                new SqlParameter("@giaphong", f.giaphong),
            };
            var res = db.Database.SqlQuery<NhaTro>("sp_filter_nha_tro @ma_kv, @tiendien, @tiennuoc, @giaphong", sqlParams).ToList();
            return res;
        }
    }
}