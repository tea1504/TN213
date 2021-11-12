using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
        [HttpPost, ActionName("Index")]
        public ActionResult DangNhap(LoginModel login)
        {
            ModelState.AddModelError("", "Lỗi");
            return View("Index", login);
        }
    }
}