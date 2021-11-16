using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Website.Controllers
{
    public class BaoCaoController : Controller
    {
        public JsonResult NguoiDung(int malbc, int nguoi_bao_cao, int nguoi_bi_bao_cao, string lydo)
        {
            return Json(1, JsonRequestBehavior.AllowGet);
        }
    }
}