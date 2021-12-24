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
        DanhGiaDAO danhGiaDAO = null;
        public DanhGiaNhaTroController()
        {
            danhGiaDAO = new DanhGiaDAO();
        }
        // GET: Admin/DanhGiaNHa
        public ActionResult Index()
        {
            var model = danhGiaDAO.GetAll();
            return View(model);
        }
        public ActionResult Delete(int nt, int nd, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            danhGiaDAO.Delete(nt, nd, d);
            return RedirectToAction("Index");
        }
    }
}