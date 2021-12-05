using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class DanhGiaNhaTroController : CheckAdminController
    {
        // GET: Admin/DanhGiaNHa
        public ActionResult Index()
        {
            var model = new DanhGiaDAO().GetAll();
            return View(model);
        }
        public ActionResult Delete(int nt, int nd, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            new DanhGiaDAO().Delete(nt, nd, d);
            return RedirectToAction("Index");
        }
    }
}