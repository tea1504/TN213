using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;

namespace Website.Controllers
{
    public class BaoCaoController : Controller
    {
        public JsonResult NguoiDung(int malbc, int nguoi_bao_cao, int nguoi_bi_bao_cao, string lydo)
        {
            BaoCaoNguoiDung bc = new BaoCaoNguoiDung();
            bc.ma_lbc = malbc;
            bc.nguoi_bao_cao = nguoi_bao_cao;
            bc.nguoi_bi_bao_cao = nguoi_bi_bao_cao;
            bc.lydo = lydo;
            bc.ngay = DateTime.Now;
            bc.trangthai = 1;
            var res = new BaoCaoNguoiDungDAO().AddBaoCaoNguoiDung(bc);
            return Json(res, JsonRequestBehavior.AllowGet);
        }
        public JsonResult NhaTro(int malbc, int ma_nd, int ma_nt, string lydo)
        {
            BaoCaoNhaTro bc = new BaoCaoNhaTro();
            bc.ma_lbc = malbc;
            bc.ma_nd = ma_nd;
            bc.ma_nt = ma_nt;
            bc.lydobaocao = lydo;
            bc.ngay = DateTime.Now;
            bc.trangthaibaocao = 1;
            var res = new BaoCaoNhaTroDAO().AddBaoCaoNhaTro(bc);
            return Json(res, JsonRequestBehavior.AllowGet);
        }
    }
}