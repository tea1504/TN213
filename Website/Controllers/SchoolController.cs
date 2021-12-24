using System;
using System.Collections.Generic;
using System.Data.Entity.Spatial;
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
                var d = new TruongHocDAO().GetAllTruongHocJson();
                return Json(d, JsonRequestBehavior.AllowGet);
            }
            var data = new TruongHocDAO().GetTruongHocJson(ma_th ?? 1);
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        [System.Web.Services.WebMethod]
        public JsonResult GetSchoolDistand(int ma_th, float lat, float lng)
        {
            NhaTroDBContext db = new NhaTroDBContext();
            var data = db.TruongHocs.Where(th => th.ma_th == ma_th).Select(th => new { ma_th = th.ma_th, ten_th = th.ten_th, diachi = th.diachi_th, toado = th.toado_th.AsText(), khoancach = th.toado_th.Distance(DbGeometry.PointFromText("POINT(" + lng + " " + lat + ")", 0)) }).SingleOrDefault();
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}