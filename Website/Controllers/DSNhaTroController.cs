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
            KhuVucDAO khuVucDAO = new KhuVucDAO();
            var khuVuc = khuVucDAO.GetAllKhuVuc();
            SelectList khuVucList = new SelectList(khuVuc, "ma_kv", "ten_kv");
            ViewBag.khuVucList = khuVucList;
            var res = nhaTroDAO.FilterNhaTro(f);
            return View(res);
        }
    }
}