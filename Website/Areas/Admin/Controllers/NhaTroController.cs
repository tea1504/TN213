using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;

namespace Website.Areas.Admin.Controllers
{
    public class NhaTroController : Controller
    {
        // GET: Admin/NhaTro
        public ActionResult Index()
        {
            List<NhaTro> model = new NhaTroDAO().GetAllNhaTro();
            return View(model);
        }
    }
}