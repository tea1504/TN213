using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class CoGiaController : Controller
    {
        // GET: Admin/CoGia
        public ActionResult Index()
        {
            var model = new CoGiaDAO().GetAll();
            return View(model);
        }
    }
}