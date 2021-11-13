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
            var khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList khuVucList = new SelectList(khuVuc, "ma_kv", "ten_kv");
            ViewBag.khuVucList = khuVucList;
            var res = new NhaTroDAO().FilterNhaTro(f);
            return View(res);
        }
    }
}