using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;
using Website.Models;

namespace Website.Controllers
{
    public class RegisterController : Controller
    {
        // GET: Register
        public ActionResult Index()
        {
            return View();
        }
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult DangKy(RegisterModel m)
        {
            if (ModelState.IsValid)
            {
                if (m.ma_vt == 0)
                    m.ma_vt = 3;
                NguoiDung res = new NguoiDungDAO().AddFromRegister(m);
                if (m.ma_vt == 2)
                    Directory.CreateDirectory(Server.MapPath("~/Content/ckfinder/userfiles/images/" + res.taikhoan));
                LoginModel l = new LoginModel();
                l.taikhoan = res.taikhoan;
                l.matkhau = res.matkhau;
                return RedirectToAction("Index", "Login", new { Area="" });
            }
            ModelState.AddModelError("", "Lỗi");
            return View("Index", m);
        }
    }
}