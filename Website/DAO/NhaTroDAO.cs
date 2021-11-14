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
        public List<DSNhaTroModel> FilterNhaTro(FilterNhaTroModel f, int page, ref int total)
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
            total = list.Count;
            var dsnt = list.Skip(6 * (page - 1)).Take(6);
            foreach (NhaTro nt in dsnt)
            {
                KhuVuc kv = new KhuVucDAO().LayKhuVuc(nt.ma_kv);
                NguoiDung nd = new NguoiDungDAO().LayNguoiDung(nt.ma_nd);
                List<AnhNhaTro> anh = new AnhNhaTroDAO().GetAnhNhaTroTheoMaNhaTro(nt.ma_nt);
                float ss = new DanhGiaDAO().TBSoSaoTheoNhaTro(nt.ma_nt);
                int dg = new DanhGiaDAO().DemSoDanhGiaTheoNhaTro(nt.ma_nt);
                DSNhaTroModel temp = new DSNhaTroModel(nt, nd, kv, anh, ss, dg);
                res.Add(temp);
            }
            return res;
        }
        public NhaTro GetNhaTro(int ma_nt)
        {
            var res = db.NhaTroes.Find(ma_nt);
            return res;
        }
    }
}