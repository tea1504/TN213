using System;
using System.Collections.Generic;
using System.Data.Entity.Spatial;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;
using Website.EF;

namespace Website.Areas.Admin.Controllers
{
    public class TruongHocController : CheckAdminController
    {
        // GET: Admin/TruongHoc
        public ActionResult Index()
        {
            var model = new TruongHocDAO().GetAllTruongHoc();
            return View(model);
        }
        public ActionResult Detail(int id)
        {
            var model = new TruongHocDAO().GetTruongHoc(id);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }
        public ActionResult Create()
        {
            var khuvuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList list = new SelectList(khuvuc, "ma_kv", "ten_kv");
            ViewBag.list = list;
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(TruongHoc th, string latlng)
        {
            if (String.IsNullOrEmpty(latlng))
            {
                ModelState.AddModelError("", "Bạn chưa chọn tọa độ");
                var khuvuc = new KhuVucDAO().GetAllKhuVuc();
                SelectList list = new SelectList(khuvuc, "ma_kv", "ten_kv", th.ma_kv);
                ViewBag.list = list;
                return View("Create", th);
            }
            th.toado_th = DbGeometry.FromText(latlng);
            var res = new TruongHocDAO().Add(th);
            return RedirectToAction("Index");
        }
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return RedirectToAction("Index");
            }
            var th = new TruongHocDAO().GetTruongHoc(id ?? 1);
            if (th == null)
            {
                return RedirectToAction("Index");
            }
            var khuvuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList list = new SelectList(khuvuc, "ma_kv", "ten_kv", th.ma_kv);
            ViewBag.list = list;
            return View(th);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(TruongHoc th, string latlng)
        {
            if (String.IsNullOrEmpty(latlng))
            {
                ModelState.AddModelError("", "Bạn chưa chọn tọa độ");
                var khuvuc = new KhuVucDAO().GetAllKhuVuc();
                SelectList list = new SelectList(khuvuc, "ma_kv", "ten_kv", th.ma_kv);
                ViewBag.list = list;
                return View("Edit", th);
            }
            th.toado_th = DbGeometry.FromText(latlng);
            var res = new TruongHocDAO().Edit(th);
            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            new TruongHocDAO().Delete(id);
            return RedirectToAction("Index");
        }
    }
}