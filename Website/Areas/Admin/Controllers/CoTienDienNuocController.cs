using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class CoTienDienNuocController : Controller
    {
        // GET: Admin/CoTienDienNuoc
        public ActionResult Index()
        {
            var model = new CoTienDienNuocDAO().GetAll();
            return View(model);
        }
    }
}