using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.Models;

namespace Website.Controllers
{
    public class DSNhaTroController : Controller
    {
        // GET: DSNhaTro
        public ActionResult Index(FilterNhaTroModel f)
        {
            NhaTroDAO nhaTroDAO = new NhaTroDAO();
            var res = nhaTroDAO.FilterNhaTro(f);
            return View(res);
        }
    }
}