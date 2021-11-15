using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Website.Controllers
{
    public class SchoolController : Controller
    {
        public JsonResult GetSchool(int? ma_th)
        {
            if (ma_th == null)
            {
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}