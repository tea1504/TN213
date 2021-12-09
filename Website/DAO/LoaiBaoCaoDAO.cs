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
        public LoaiBaoCao Add(LoaiBaoCao lbc)
        {
            var res = db.LoaiBaoCaos.Add(lbc);
            db.SaveChanges();
            return res;
        }
        public LoaiBaoCao Edit(LoaiBaoCao lbc)
        {
            var res = db.LoaiBaoCaos.Find(lbc.ma_lbc);
            res.ten_lbc = lbc.ten_lbc;
            db.SaveChanges();
            return res;
        }
        public void Delete(int ma_lbc)
        {
            new BaoCaoNguoiDungDAO().DeleteTheoLoai(ma_lbc);
            new BaoCaoNhaTroDAO().DeleteTheoLoai(ma_lbc);
            var res = db.LoaiBaoCaos.Find(ma_lbc);
            db.LoaiBaoCaos.Remove(res);
            db.SaveChanges();
        }
    }
}