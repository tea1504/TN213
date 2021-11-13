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
        public List<DSNhaTroModel> FilterNhaTro(FilterNhaTroModel f)
        {
            List<DSNhaTroModel> res = new List<DSNhaTroModel>();
            object[] sqlParams =
            {
                new SqlParameter("@ma_kv", (object)f.ma_kv??DBNull.Value),
                new SqlParameter("@tiendien", (object)f.tiendien??DBNull.Value),
                new SqlParameter("@tiennuoc", (object)f.tiennuoc??DBNull.Value),
                new SqlParameter("@giaphong", (object)f.giaphong??DBNull.Value),
            };
            var list = db.Database.SqlQuery<NhaTro>("sp_filter_nha_tro @ma_kv, @tiendien, @tiennuoc, @giaphong", sqlParams).ToList();
            foreach (NhaTro item in list)
            {
                KhuVuc kv = new KhuVucDAO().LayKhuVuc(item.ma_kv);
                NguoiDung nd = new NguoiDungDAO().LayNguoiDung(item.ma_nd);
                DSNhaTroModel temp = new DSNhaTroModel();
                temp.nhaTro = item;

                res.Add(temp);
            }
            return res;
        }
    }
}