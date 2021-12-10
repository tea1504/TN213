using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class BaoCaoNguoiDungDAO
    {
        NhaTroDBContext db = null;
        public BaoCaoNguoiDungDAO()
        {
            db = new NhaTroDBContext();
        }
        public BaoCaoNguoiDung AddBaoCaoNguoiDung(BaoCaoNguoiDung bc)
        {
            var res = db.BaoCaoNguoiDungs.Add(bc);
            db.SaveChanges();
            return res;
        }
        public List<BaoCaoNguoiDung> GetTheoNguoiBaoCao(int ma_nd)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.nguoi_bao_cao == ma_nd).ToList();
            return res;
        }
        public List<BaoCaoNguoiDung> GetTheoNguoiBiBaoCao(int ma_nd)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.nguoi_bi_bao_cao == ma_nd).ToList();
            return res;
        }
        public List<BaoCaoNguoiDung> GetTheoLoai(int ma_lbc)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.ma_lbc == ma_lbc).ToList();
            return res;
        }
        public List<BaoCaoNguoiDung> GetTheoTrangThai(int trangthai)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.trangthai == trangthai).ToList();
            return res;
        }
        public void Delete(BaoCaoNguoiDung bc)
        {
            db.BaoCaoNguoiDungs.Remove(bc);
            db.SaveChanges();
        }
        public void DeleteTheoNguoiDung(int ma_nd)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.nguoi_bao_cao == ma_nd || bc.nguoi_bi_bao_cao == ma_nd).ToList();
            foreach(var item in res)
            {
                Delete(item);
            }
        }
        public void DeleteTheoLoai(int ma_lbc)
        {
            var res = GetTheoLoai(ma_lbc);
            foreach (var item in res)
            {
                Delete(item);
            }
        }
        public List<BaoCaoNguoiDung> GetAll()
        {
            var res = db.BaoCaoNguoiDungs.ToList();
            return res;
        }
        public BaoCaoNguoiDung Get(int ma_lbc, int nguoibaocao, int nguoibibaocao, DateTime ngay)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.ma_lbc == ma_lbc && bc.nguoi_bao_cao == nguoibaocao && bc.nguoi_bi_bao_cao == nguoibibaocao && bc.ngay == ngay).SingleOrDefault();
            return res;
        }
        public BaoCaoNguoiDung Edit(int ma_lbc, int nguoibaocao, int nguoibibaocao, DateTime ngay)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.ma_lbc == ma_lbc && bc.nguoi_bao_cao == nguoibaocao && bc.nguoi_bi_bao_cao == nguoibibaocao && bc.ngay == ngay).SingleOrDefault();
            res.trangthai = 2;
            db.SaveChanges();
            return res;
        }
        public void Delete(int ma_lbc, int nguoibaocao, int nguoibibaocao, DateTime ngay)
        {
            var res = db.BaoCaoNguoiDungs.Where(bc => bc.ma_lbc == ma_lbc && bc.nguoi_bao_cao == nguoibaocao && bc.nguoi_bi_bao_cao == nguoibibaocao && bc.ngay == ngay).SingleOrDefault();
            db.BaoCaoNguoiDungs.Remove(res);
            db.SaveChanges();
        }
    }
}