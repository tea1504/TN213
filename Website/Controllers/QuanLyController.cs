using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;

namespace Website.Controllers
{
    public class QuanLyController : CheckUserController
    {
        // GET: QuanLy
        public ActionResult Index()
        {
            List<NhaTro> res = new NhaTroDAO()
            return View();
        }
    }
}