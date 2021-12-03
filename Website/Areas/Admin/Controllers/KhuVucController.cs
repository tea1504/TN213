using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;

namespace Website.Areas.Admin.Controllers
{
    public class KhuVucController : CheckAdminController
    {
        // GET: Admin/KhuVuc
        public ActionResult Index()
        {
            return View();
        }
    }
}