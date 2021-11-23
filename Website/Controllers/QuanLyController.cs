using System;
using System.Collections.Generic;
using System.Data.Entity.Spatial;
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
            var user = (UserLoginModel)Session["USER_LOGIN"];
            if (res == null || user.ma_nd != res.ma_nd)
                return RedirectToAction("Index");
            return View(res);
        }
        public ActionResult Create()
        {
            List<KhuVuc> khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList listKhuVuc = new SelectList(khuVuc, "ma_kv", "ten_kv");
            ViewBag.listKhuVuc = listKhuVuc;
            List<LoaiPhong> loaiPhong = new LoaiPhongDAO().GetAllLoaiPhong();
            SelectList listLoaiPhong = new SelectList(loaiPhong, "ma_lp", "ten_lp");
            ViewBag.listLoaiPhong = listLoaiPhong;
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(NhaTro nt, float? lat, float? lng, List<AnhNhaTro> a, CoTienDienNuoc dn, List<CoGia> l)
        {
            if (lat != null && lng != null && dn.tiendien != null && dn.tiennuoc != null)
            {
                nt.toado_nt = DbGeometry.FromText("POINT(" + lng + " " + lat + ")");
                var nt_new = new NhaTroDAO().Add(nt);
                if (a != null)
                    foreach (var item in a)
                    {
                        item.ma_nt = nt_new.ma_nt;
                        var item_new = new AnhNhaTroDAO().AddAnhNhaTro(item);
                    }
                if (l != null)
                    foreach (var item in l)
                    {
                        item.ma_nt = nt_new.ma_nt;
                        var item_new = new CoGiaDAO().Add(item);
                    }
                dn.ma_nt = nt_new.ma_nt;
                var dn_new = new CoTienDienNuocDAO().Add(dn);
                return RedirectToAction("Index");
            }
            List<KhuVuc> khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList listKhuVuc = new SelectList(khuVuc, "ma_kv", "ten_kv", nt.ma_kv);
            ViewBag.listKhuVuc = listKhuVuc;
            List<LoaiPhong> loaiPhong = new LoaiPhongDAO().GetAllLoaiPhong();
            SelectList listLoaiPhong = new SelectList(loaiPhong, "ma_lp", "ten_lp");
            ViewBag.listLoaiPhong = listLoaiPhong;
            ModelState.AddModelError("", "Chưa chọn tọa độ");
            return View("Create", nt);
        }
        public JsonResult GetKhuVuc(int ma_kv)
        {
            var res = new KhuVucDAO().LayKhuVuc(ma_kv);
            var data = new
            {
                toado = res.toado_kv.AsText(),
                polygon = res.polygon_kv.AsText(),
                ten = res.ten_kv,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Delete(int id)
        {
            var nt = new NhaTroDAO();
            nt.Delete(id);
            return RedirectToAction("Index");
        }
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return RedirectToAction("Index");
            }
            var res = new NhaTroDAO().GetNhaTro(id??1);
            if (res == null)
            {
                return RedirectToAction("Index");
            }
            List<KhuVuc> khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList listKhuVuc = new SelectList(khuVuc, "ma_kv", "ten_kv", res.ma_kv);
            ViewBag.listKhuVuc = listKhuVuc;
            List<LoaiPhong> loaiPhong = new LoaiPhongDAO().GetAllLoaiPhong();
            SelectList listLoaiPhong = new SelectList(loaiPhong, "ma_lp", "ten_lp");
            ViewBag.listLoaiPhong = listLoaiPhong;
            return View(res);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(NhaTro nt, float? lat, float? lng, List<AnhNhaTro> a, CoTienDienNuoc dn, List<CoGia> l)
        {
            if (lat != null && lng != null && dn.tiendien != null && dn.tiennuoc != null)
            {
                nt.toado_nt = DbGeometry.FromText("POINT(" + lng + " " + lat + ")");
                var nt_new = new NhaTroDAO().Edit(nt);
                new AnhNhaTroDAO().DeleteTheoNhaTro(nt_new.ma_nt);
                if (a != null)
                    foreach (var item in a)
                    {
                        item.ma_nt = nt_new.ma_nt;
                        var item_new = new AnhNhaTroDAO().AddAnhNhaTro(item);
                    }
                if (l != null)
                    foreach (var item in l)
                    {
                        item.ma_nt = nt_new.ma_nt;
                        var item_new = new CoGiaDAO().Add(item);
                    }
                dn.ma_nt = nt_new.ma_nt;
                var dn_new = new CoTienDienNuocDAO().Add(dn);
                return RedirectToAction("Index");
            }
            List<KhuVuc> khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList listKhuVuc = new SelectList(khuVuc, "ma_kv", "ten_kv", nt.ma_kv);
            ViewBag.listKhuVuc = listKhuVuc;
            List<LoaiPhong> loaiPhong = new LoaiPhongDAO().GetAllLoaiPhong();
            SelectList listLoaiPhong = new SelectList(loaiPhong, "ma_lp", "ten_lp");
            ViewBag.listLoaiPhong = listLoaiPhong;
            ModelState.AddModelError("", "Chưa chọn tọa độ");
            return View("Edit", nt);
        }
    }
}