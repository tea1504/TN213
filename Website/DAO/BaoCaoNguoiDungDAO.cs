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
    }
}