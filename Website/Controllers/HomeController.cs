using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;

namespace Website.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            List<KhuVuc> dsKhuVuc = new KhuVucDAO().GetAllKhuVuc();
            ViewBag.soNguoiDung = new NguoiDungDAO().LaySoLuongNguoiDung();
            ViewBag.soNhaTro = new NhaTroDAO().GetSoLuongNhaTro();
            return View(dsKhuVuc);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}