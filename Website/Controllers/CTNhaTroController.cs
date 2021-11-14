using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Website.Controllers
{
    public class CTNhaTroController : Controller
    {
        // GET: CTNhaTro
        public ActionResult Index(int ma_nt)
        {
            return View();
        }
    }
}