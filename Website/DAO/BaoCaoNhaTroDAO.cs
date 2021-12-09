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
        public List<BaoCaoNhaTro> GetTheoNguoiBaoCao(int ma_nd)
        {
            var res = db.BaoCaoNhaTroes.Where(bc => bc.ma_nd == ma_nd).ToList();
            return res;
        }
        public List<BaoCaoNhaTro> GetTheoChuNhaTro(int ma_nd)
        {
            List<BaoCaoNhaTro> res = new List<BaoCaoNhaTro>();
            var dsnt = new NhaTroDAO().GetNhaTroTheoChuTro(ma_nd);
            foreach (var nt in dsnt)
            {
                res.Concat(GetTheoNhaTro(nt.ma_nt));
            }
            return res;
        }
        public List<BaoCaoNhaTro> GetTheoLoai(int ma_lbc)
        {
            var res = db.BaoCaoNhaTroes.Where(bc => bc.ma_lbc == ma_lbc).ToList();
            return res;
        }
        public void DeleteTheoNhaTro(int ma_nt)
        {
            var list = GetTheoNhaTro(ma_nt);
            if (list != null)
            {
                foreach (var item in list)
                {
                    db.BaoCaoNhaTroes.Remove(item);
                    db.SaveChanges();
                }
            }
        }
        public void DeleteTheoNguoiBaoCao(int ma_nd)
        {
            var res = GetTheoNguoiBaoCao(ma_nd);
            foreach (var item in res)
            {
                db.BaoCaoNhaTroes.Remove(item);
                db.SaveChanges();
            }
        }
        public void DeleteTheoLoai(int ma_lbc)
        {
            var res = GetTheoLoai(ma_lbc);
            foreach (var item in res)
            {
                db.BaoCaoNhaTroes.Remove(item);
                db.SaveChanges();
            }
        }
        public List<BaoCaoNhaTro> GetAll()
        {
            var res = db.BaoCaoNhaTroes.ToList();
            return res;
        }
        public BaoCaoNhaTro Get(int ma_lbc, int ma_nd, int ma_nt, DateTime ngay)
        {
            var res = db.BaoCaoNhaTroes.Where(bc => bc.ma_lbc == ma_lbc && bc.ma_nd == ma_nd && bc.ngay == ngay && bc.ma_nt == ma_nt).SingleOrDefault();
            return res;
        }
        public BaoCaoNhaTro Edit(int ma_lbc, int ma_nd, int ma_nt, DateTime ngay)
        {
            var res = Get(ma_lbc, ma_nd, ma_nt, ngay);
            res.trangthaibaocao = 2;
            db.SaveChanges();
            return res;
        }
        public void Delete(int ma_lbc, int ma_nd, int ma_nt, DateTime ngay)
        {
            var res = Get(ma_lbc, ma_nd, ma_nt, ngay);
            db.BaoCaoNhaTroes.Remove(res);
            db.SaveChanges();
        }
    }
}