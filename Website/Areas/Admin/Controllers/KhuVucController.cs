using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

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
    }
}