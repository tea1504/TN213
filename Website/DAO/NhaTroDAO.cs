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
            var res = db.NhaTroes.Where(nt=>nt.ma_nt == ma_nt).SingleOrDefault();
            return res;
        }
        public List<NhaTro> GetKQTimNhaTro(int? ma_kv, int? ma_th, string ten_nt, string diachi_nt, string ten_nd, int? khoancach)
        {
            List<NhaTro> res = null;
            if(ma_th!= null)
            {
                TruongHoc th = new TruongHocDAO().GetTruongHoc(ma_th??1);
                if (ma_kv != null)
                    res = db.NhaTroes.Where(nt => nt.ma_kv == ma_kv && nt.ten_nt.Contains(ten_nt) && nt.diachi_nt.Contains(diachi_nt) && nt.NguoiDung.ten_nd.Contains(ten_nd) && nt.toado_nt.Distance(th.toado_th)*111 <= khoancach).ToList();
                else
                    res = db.NhaTroes.Where(nt => nt.ten_nt.Contains(ten_nt) && nt.diachi_nt.Contains(diachi_nt) && nt.NguoiDung.ten_nd.Contains(ten_nd) && nt.toado_nt.Distance(th.toado_th) * 111 <= khoancach).ToList();
            }
            else
            {
                if (ma_kv != null)
                    res = db.NhaTroes.Where(nt => nt.ma_kv == ma_kv && nt.ten_nt.Contains(ten_nt) && nt.diachi_nt.Contains(diachi_nt) && nt.NguoiDung.ten_nd.Contains(ten_nd)).ToList();
                else
                    res = db.NhaTroes.Where(nt => nt.ten_nt.Contains(ten_nt) && nt.diachi_nt.Contains(diachi_nt) && nt.NguoiDung.ten_nd.Contains(ten_nd)).ToList();
            }
            return res;
        }
        public int GetSoLuongNhaTro()
        {
            int res = db.NhaTroes.Count();
            return res;
        }
        public List<NhaTro> GetAllNhaTro()
        {
            var res = db.NhaTroes.ToList();
            return res;
        }
        public List<NhaTro> GetNhaTroTheoChuTro(int ma_nd)
        {
            var res = db.NhaTroes.Where(nt => nt.ma_nd == ma_nd).ToList();
            return res;
        }
        public NhaTro Add(NhaTro nt)
        {
            var res = db.NhaTroes.Add(nt);
            db.SaveChanges();
            return res;
        }
        public NhaTro Edit(NhaTro nt)
        {
            var res = db.NhaTroes.Find(nt.ma_nt);
            res.ma_kv = nt.ma_kv;
            res.ma_nd = nt.ma_nd;
            res.ten_nt = nt.ten_nt;
            res.diachi_nt = nt.diachi_nt;
            res.sdt_nt = nt.sdt_nt;
            res.toado_nt = nt.toado_nt;
            db.SaveChanges();
            return res;
        }
        public void Delete(int ma_nt)
        {
            var cg = new CoGiaDAO();
            var dn = new CoTienDienNuocDAO();
            var anh = new AnhNhaTroDAO();
            var bc = new BaoCaoNhaTroDAO();
            var dg = new DanhGiaDAO();
            cg.DeleteTheoMaNT(ma_nt);
            dn.DeteleTheoNhaTro(ma_nt);
            anh.DeleteTheoNhaTro(ma_nt);
            bc.DeleteTheoNhaTro(ma_nt);
            dg.DeleteTheoNhaTro(ma_nt);
            var nt = GetNhaTro(ma_nt);
            db.NhaTroes.Remove(nt);
            db.SaveChanges();
        }
        public List<NhaTro> GetTheoKhuVuc(int ma_kv)
        {
            var res = db.NhaTroes.Where(nt => nt.ma_kv == ma_kv).ToList();
            return res;
        }
        public void DeleteTheoKhuVuc(int ma_kv)
        {
            var nt = GetTheoKhuVuc(ma_kv);
            foreach(var item in nt)
            {
                Delete(item.ma_nt);
            }
        }
    }
}