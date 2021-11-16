using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
            return Json(1, JsonRequestBehavior.AllowGet);
        }
    }
}