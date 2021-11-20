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
    public class QuanLyController : CheckUserController
    {
        // GET: QuanLy
        public ActionResult Index(int page = 1)
        {
            UserLoginModel user = (UserLoginModel)Session["USER_LOGIN"];
            List<NhaTro> res = new NhaTroDAO().GetNhaTroTheoChuTro(user.ma_nd);
            ViewBag.page = page;
            ViewBag.max = (int)(res.Count() / 5) + ((res.Count() % 5 != 0) ? 1 : 0);
            return View(res.Skip(5 * (page - 1)).Take(5));
        }
        public ActionResult NhaTro(int id)
        {
            NhaTro res = new NhaTroDAO().GetNhaTro(id);
            return View(res);
        }
    }
}