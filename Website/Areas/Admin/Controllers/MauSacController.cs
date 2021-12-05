using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;
using Website.EF;

namespace Website.Areas.Admin.Controllers
{
    public class MauSacController : CheckAdminController
    {
        // GET: Admin/MauSac
        public ActionResult Index()
        {
            var model = new MauSacDAO().GetAll();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(MauSac ms)
        {
            var check = new MauSacDAO().Get(ms.ma_ms);
            if (check != null)
            {
                ViewData["error"] = "Màu" + ms.ten_ms + " đã tồn tại với tên " + check.ten_ms;
                var model = new MauSacDAO().GetAll();
                return View("Index", model);
            }
            var res = new MauSacDAO().Add(ms);
            return RedirectToAction("Index");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(MauSac c)
        {
            var res = new MauSacDAO().Edit(c);
            return RedirectToAction("Index");
        }
        public ActionResult Delete(string id)
        {
            new MauSacDAO().Delete(id);
            return RedirectToAction("Index");
        }
    }
}