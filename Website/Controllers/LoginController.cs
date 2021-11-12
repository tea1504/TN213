using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.Models;

namespace Website.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        [ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult DangNhap(LoginModel login)
        {
            LoginDAO dao = new LoginDAO();
            var res = dao.CheckLogin(login);
            if (res && ModelState.IsValid)
            {

                return RedirectToAction("Index", "Dashboard", new { Area = "Admin" });
            }
            ModelState.AddModelError("", "Sai tài khoản hoặc mật khẩu");
            return View("Index", login);
        }
    }
}