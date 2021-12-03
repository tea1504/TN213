using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;
using Website.EF;

namespace Website.Areas.Admin.Controllers
{
    public class KhuVucController : Controller
    {
        // GET: Admin/KhuVuc
        public ActionResult Index()
        {
            var data = new KhuVucDAO().GetAllKhuVuc();
            return View(data);
        }
        public JsonResult GetKhuVuc(int id)
        {
            KhuVuc kv = new KhuVucDAO().LayKhuVuc(id);
            var data = new
            {
                latlng = kv.toado_kv.AsText(),
                polygon = kv.polygon_kv.AsText(),
                mau = kv.ma_ms,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Create()
        {
            return View();
        }
    }
}