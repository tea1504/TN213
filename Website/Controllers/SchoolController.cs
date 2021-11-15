using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;

namespace Website.Controllers
{
    public class SchoolController : Controller
    {
        public JsonResult GetSchool(int? ma_th)
        {
            if (ma_th == null)
            {
                return Json("", JsonRequestBehavior.AllowGet);
            }
            if(ma_th == 0)
            {
                var d = new TruongHocDAO().GetAllTruongHoc();
                return Json(d, JsonRequestBehavior.AllowGet);
            }
            var data = new TruongHocDAO().GetTruongHoc(ma_th ?? 1);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}