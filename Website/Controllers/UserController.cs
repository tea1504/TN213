using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;
using Website.Models;

namespace Website.Controllers
{
    public class UserController : CheckLoginController
    {
        // GET: User
        public ActionResult Index()
        {
            var user = (UserLoginModel)Session["USER_LOGIN"];
            NguoiDung nguoiDung = new NguoiDungDAO().LayNguoiDung(user.ma_nd);
            return View(nguoiDung);
        }
        public ActionResult Edit()
        {
            var user = (UserLoginModel)Session["USER_LOGIN"];
            NguoiDung nguoiDung = new NguoiDungDAO().LayNguoiDung(user.ma_nd);
            return View(nguoiDung);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(NguoiDung nguoi, HttpPostedFileBase imgInput)
        {
            if (imgInput != null)
            {
                string pic = System.IO.Path.GetFileName(imgInput.FileName);
                string path = System.IO.Path.Combine(
                                       Server.MapPath("~/Content/ckfinder/userfiles/images"), pic);

                imgInput.SaveAs(path);

                nguoi.anh_nd = "/Content/ckfinder/userfiles/images/" + imgInput.FileName;
            }
            var res = new NguoiDungDAO().EditInfo(nguoi);
            return RedirectToAction("Index");
        }
    }
}