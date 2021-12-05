using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class VaiTroController : Controller
    {
        // GET: Admin/VaiTro
        public ActionResult Index()
        {
            var model = new VaiTroDAO().GetAll();
            return View(model);
        }
    }
}