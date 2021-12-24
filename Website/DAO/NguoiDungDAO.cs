using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;
using Website.Models;

namespace Website.DAO
{
    public class NguoiDungDAO
    {
        NhaTroDBContext db = null;
        public NguoiDungDAO()
        {
            db = new NhaTroDBContext();
        }
        public NguoiDung LayNguoiDungTheoTaiKhoan(string taikhoan)
        {
            object[] sqlParams =
            {
                new SqlParameter("@taikhoan", taikhoan)
            };
            var res = db.Database.SqlQuery<NguoiDung>("sp_get_nguoi_dung @taikhoan", sqlParams).SingleOrDefault();
            return res;
        }
        public NguoiDung LayNguoiDung(int ma_nd)
        {
            var res = db.NguoiDungs.Find(ma_nd);
            return res;
        }
        public List<NguoiDung> LayTheoGioiTinh(int gioitinh)
        {
            var res = db.NguoiDungs.Where(nd => nd.gioitinh_nd == gioitinh).ToList();
            return res;
        }
        public List<NguoiDung> LayTheoVaiTro(int ma_vt)
        {
            var res = db.NguoiDungs.Where(nd => nd.ma_vt == ma_vt).ToList();
            return res;
        }
        public int LaySoLuongNguoiDung()
        {
            int res = db.NguoiDungs.Count();
            return res;
        }
        public NguoiDung AddFromRegister(RegisterModel m)
        {
            NguoiDung temp = new NguoiDung();
            temp.holot_nd = m.holot_nd;
            temp.ten_nd = m.ten_nd;
            temp.gioitinh_nd = m.gioitinh_nd;
            temp.taikhoan = m.taikhoan;
            temp.matkhau = m.matkhau;
            temp.ma_vt = m.ma_vt;
            temp.anh_nd = "/Content/avatar.jpg";
            var res = db.NguoiDungs.Add(temp);
            db.SaveChanges();
            return res;
        }
        public NguoiDung EditInfo(NguoiDung n)
        {
            var t = LayNguoiDung(n.ma_nd);
            t.holot_nd = n.holot_nd;
            t.ten_nd = n.ten_nd;
            t.gioitinh_nd = n.gioitinh_nd;
            t.sdt_nd = n.sdt_nd;
            t.email = n.email;
            t.diachi = n.diachi;
            if (n.anh_nd != null)
                t.anh_nd = n.anh_nd;
            db.SaveChanges();
            return t;
        }
        public List<NguoiDung> GetAll()
        {
            var res = db.NguoiDungs.ToList();
            return res;
        }
        public NguoiDung Add(NguoiDung nd)
        {
            var res = db.NguoiDungs.Add(nd);
            db.SaveChanges();
            return res;
        }
        public NguoiDung Edit(NguoiDung nd)
        {
            var res = db.NguoiDungs.Find(nd.ma_nd);
            res.holot_nd = nd.holot_nd;
            res.ten_nd = nd.ten_nd;
            res.gioitinh_nd = nd.gioitinh_nd;
            res.sdt_nd = nd.sdt_nd;
            res.email = nd.email;
            res.diachi = nd.diachi;
            res.ma_vt = nd.ma_vt;
            if (nd.anh_nd != null)
                res.anh_nd = nd.anh_nd;
            db.SaveChanges();
            return res;
        }
        public void Delete(int ma_nd)
        {
            new NhaTroDAO().DeleteTheoNguoiDung(ma_nd);
            new BaoCaoNguoiDungDAO().DeleteTheoNguoiDung(ma_nd);
            new BaoCaoNhaTroDAO().DeleteTheoNguoiBaoCao(ma_nd);
            new DanhGiaDAO().DeleteTheoNguoiDung(ma_nd);
            var nd = LayNguoiDung(ma_nd);
            db.NguoiDungs.Remove(nd);
            db.SaveChanges();
        }
        public NguoiDung DoiTaiKhoan(int ma_nd, string taikhoan, string matkhaumoi)
        {
            var res = LayNguoiDung(ma_nd);
            res.taikhoan = taikhoan;
            res.matkhau = matkhaumoi;
            db.SaveChanges();
            return res;
        }
        public NguoiDung DoiMatKhau(string taikhoan, string matkhau)
        {
            var res = db.NguoiDungs.Where(nd => nd.taikhoan == taikhoan).SingleOrDefault(); ;
            res.matkhau = matkhau;
            db.SaveChanges();
            return res;
        }
    }
}