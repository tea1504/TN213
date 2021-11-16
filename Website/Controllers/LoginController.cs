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
        public ActionResult DangNhap(LoginModel login, string path)
        {
            LoginDAO loginDAO = new LoginDAO();
            var res = loginDAO.CheckLogin(login);
            if (res && ModelState.IsValid)
            {
                NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
                var nguoiDung = nguoiDungDAO.LayNguoiDungTheoTaiKhoan(login.taikhoan);
                UserLoginModel userLoginModel = new UserLoginModel();
                userLoginModel.ma_nd = nguoiDung.ma_nd;
                userLoginModel.ma_vt = nguoiDung.ma_vt;
                userLoginModel.ten_nd = nguoiDung.ten_nd;
                userLoginModel.holot_nd = nguoiDung.holot_nd;
                userLoginModel.anh_nd = nguoiDung.anh_nd;
                userLoginModel.taikhoan = nguoiDung.taikhoan;
                Session.Add("USER_LOGIN", userLoginModel);
                if (!String.IsNullOrEmpty(path))
                {
                    return Redirect(Server.UrlDecode(path));
                }
                return RedirectToAction("Index", "Dashboard", new { Area = "Admin" });
            }
            ModelState.AddModelError("", "Sai tài khoản hoặc mật khẩu");
            return View("Index", login);
        }
        public ActionResult DangXuat(string path)
        {
            Session.Remove("USER_LOGIN");
            return RedirectToAction("Index", "Home", new { Area = "" });
        }
    }
}