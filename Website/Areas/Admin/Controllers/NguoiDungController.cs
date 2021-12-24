using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;
using Website.EF;
using Website.Models;

namespace Website.Areas.Admin.Controllers
{
    public class NguoiDungController : CheckAdminController
    {
        NguoiDungDAO nguoiDungDAO = null;
        DanhGiaDAO danhGiaDAO = null;
        BaoCaoNguoiDungDAO baoCaoNguoiDungDAO = null;
        BaoCaoNhaTroDAO baoCaoNhaTroDAO = null;
        VaiTroDAO vaiTroDAO = null;

        public NguoiDungController()
        {
            nguoiDungDAO = new NguoiDungDAO();
            danhGiaDAO = new DanhGiaDAO();
            baoCaoNguoiDungDAO = new BaoCaoNguoiDungDAO();
            baoCaoNhaTroDAO = new BaoCaoNhaTroDAO();
            vaiTroDAO = new VaiTroDAO();
        }
        // GET: Admin/NguoiDung
        public ActionResult Index()
        {
            var model = nguoiDungDAO.GetAll();
            return View(model);
        }
        public ActionResult Detail(int id)
        {
            var model = nguoiDungDAO.LayNguoiDung(id);
            if(model==null)
            {
                return RedirectToAction("Index");
            }
            var danhgia = danhGiaDAO.GetTheoNguoiDung(id);
            var baocao = baoCaoNguoiDungDAO.GetTheoNguoiBaoCao(id);
            var bibaocao = baoCaoNguoiDungDAO.GetTheoNguoiBiBaoCao(id);
            var baocaont = baoCaoNhaTroDAO.GetTheoNguoiBaoCao(id);
            var bibaocaont = baoCaoNhaTroDAO.GetTheoChuNhaTro(id);
            List<HoatDongModel> hoatdong = new List<HoatDongModel>();
            foreach(var item in danhgia)
            {
                HoatDongModel temp = new HoatDongModel();
                temp.TieuDe = "Đánh giá nhà trọ " + item.NhaTro.ten_nt;
                temp.NoiDung = item.danhgia1;
                temp.Ngay = item.ngay;
                temp.Type = 1;
                hoatdong.Add(temp);
            }
            foreach (var item in baocao)
            {
                HoatDongModel temp = new HoatDongModel();
                temp.TieuDe = "Báo cáo người dùng " + item.NguoiDung1.holot_nd + " " + item.NguoiDung1.ten_nd;
                temp.NoiDung = item.lydo;
                temp.Ngay = item.ngay;
                temp.Type = 2;
                hoatdong.Add(temp);
            }
            foreach (var item in bibaocao)
            {
                HoatDongModel temp = new HoatDongModel();
                temp.TieuDe = "Bị người dùng " + item.NguoiDung.holot_nd + " " + item.NguoiDung.ten_nd + " báo cáo";
                temp.NoiDung = item.lydo;
                temp.Ngay = item.ngay;
                temp.Type = 3;
                hoatdong.Add(temp);
            }
            foreach (var item in baocaont)
            {
                HoatDongModel temp = new HoatDongModel();
                temp.TieuDe = "Báo cáo nhà trọ " + item.NhaTro.ten_nt;
                temp.NoiDung = item.lydobaocao;
                temp.Ngay = item.ngay;
                temp.Type = 4;
                hoatdong.Add(temp);
            }
            foreach (var item in bibaocaont)
            {
                HoatDongModel temp = new HoatDongModel();
                temp.TieuDe = "Nhà trọ " + item.NhaTro.ten_nt + " bị người dùng " + item.NguoiDung.holot_nd + " " + item.NguoiDung.ten_nd + " báo cáo";
                temp.NoiDung = item.lydobaocao;
                temp.Ngay = item.ngay;
                temp.Type = 5;
                hoatdong.Add(temp);
            }
            ViewBag.hoatdong = hoatdong;
            return View(model);
        }
        public ActionResult Create()
        {
            var vaitro = vaiTroDAO.GetAll();
            SelectList listvaitro = new SelectList(vaitro, "ma_vt", "ten_vt");
            ViewBag.listvaitro = listvaitro;
            ViewBag.code = nguoiDungDAO.GetAll().Last().ma_nd + 1;
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(NguoiDung nd, HttpPostedFileBase anh)
        {
            if (anh != null)
            {
                string pic = System.IO.Path.GetFileName(anh.FileName);
                string path = System.IO.Path.Combine(Server.MapPath("~/Content/ckfinder/userfiles/images"), pic);

                anh.SaveAs(path);

                nd.anh_nd = "/Content/ckfinder/userfiles/images/" + anh.FileName;
            }
            else
            {
                nd.anh_nd = "/Content/avatar.jpg";
            }
            var res = nguoiDungDAO.Add(nd);
            return RedirectToAction("Index");
        }
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return RedirectToAction("Index");
            }
            var nd = nguoiDungDAO.LayNguoiDung(id ?? 1);
            if (nd == null)
            {
                return RedirectToAction("Index");
            }
            var vaitro = vaiTroDAO.GetAll();
            SelectList listvaitro = new SelectList(vaitro, "ma_vt", "ten_vt", nd.ma_vt);
            ViewBag.listvaitro = listvaitro;
            return View(nd);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(NguoiDung nd, HttpPostedFileBase anh)
        {
            if (anh != null)
            {
                string pic = System.IO.Path.GetFileName(anh.FileName);
                string path = System.IO.Path.Combine(Server.MapPath("~/Content/ckfinder/userfiles/images"), pic);

                anh.SaveAs(path);

                nd.anh_nd = "/Content/ckfinder/userfiles/images/" + anh.FileName;
            }
            var res = nguoiDungDAO.Edit(nd);
            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            var auth = (UserLoginModel)Session["USER_LOGIN"];
            if (auth.ma_nd != id)
            {
                nguoiDungDAO.Delete(id);
            }
            return RedirectToAction("Index");
        }
        public ActionResult CapMK()
        {
            var model = nguoiDungDAO.GetAll();
            return View(model);
        }
        public JsonResult Pass(string id)
        {
            string pass = System.Web.Security.Membership.GeneratePassword(10, 0);
            var res = nguoiDungDAO.DoiMatKhau(id, pass);
            return Json(res.matkhau, JsonRequestBehavior.AllowGet);
        }
    }
}