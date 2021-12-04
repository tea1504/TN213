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
    public class KhuVucController : Controller
    {
        // GET: Admin/KhuVuc
        public ActionResult Index()
        {
            var data = new KhuVucDAO().GetAllKhuVuc();
            return View(data);
        }
        public JsonResult GetKhuVuc(int id)
        {
            KhuVuc kv = new KhuVucDAO().LayKhuVuc(id);
            var data = new
            {
                latlng = kv.toado_kv.AsText(),
                polygon = kv.polygon_kv.AsText(),
                mau = kv.ma_ms,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Create()
        {
            List<MauSac> mauSac = new MauSacDAO().GetAll();
            SelectList listMauSac = new SelectList(mauSac, "ma_ms", "ten_ms");
            ViewBag.listMauSac = listMauSac;
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(KhuVuc kv, string polygon, string latlng)
        {
            if (String.IsNullOrEmpty(polygon))
            {
                List<MauSac> mauSac = new MauSacDAO().GetAll();
                SelectList listMauSac = new SelectList(mauSac, "ma_ms", "ten_ms");
                ViewBag.listMauSac = listMauSac;
                ModelState.AddModelError("", "Bạn chưa chọn tọa độ trên bản đồ");
                return View("Create", kv);
            }
            kv.polygon_kv = DbGeometry.FromText(polygon);
            kv.toado_kv = DbGeometry.FromText(latlng);
            var res = new KhuVucDAO().Add(kv);
            return RedirectToAction("Index");
        }
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return RedirectToAction("Index");
            }
            KhuVuc kv = new KhuVucDAO().LayKhuVuc(id??1);
            if (kv == null)
            {
                return RedirectToAction("Index");
            }
            List<MauSac> mauSac = new MauSacDAO().GetAll();
            SelectList listMauSac = new SelectList(mauSac, "ma_ms", "ten_ms", kv.ma_ms);
            ViewBag.listMauSac = listMauSac;
            return View(kv);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(KhuVuc kv, string polygon, string latlng)
        {
            if (String.IsNullOrEmpty(polygon))
            {
                List<MauSac> mauSac = new MauSacDAO().GetAll();
                SelectList listMauSac = new SelectList(mauSac, "ma_ms", "ten_ms");
                ViewBag.listMauSac = listMauSac;
                ModelState.AddModelError("", "Bạn chưa chọn tọa độ trên bản đồ");
                return View("Create", kv);
            }
            kv.polygon_kv = DbGeometry.FromText(polygon);
            kv.toado_kv = DbGeometry.FromText(latlng);
            var res = new KhuVucDAO().Edit(kv);
            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            new KhuVucDAO().Delete(id);
            return RedirectToAction("Index");
        }
    }
}