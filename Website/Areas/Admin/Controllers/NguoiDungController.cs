using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;
using Website.Models;

namespace Website.Areas.Admin.Controllers
{
    public class NguoiDungController : Controller
    {
        // GET: Admin/NguoiDung
        public ActionResult Index()
        {
            var model = new NguoiDungDAO().GetAll();
            return View(model);
        }
        public ActionResult Detail(int id)
        {
            var model = new NguoiDungDAO().LayNguoiDung(id);
            if(model==null)
            {
                return RedirectToAction("Index");
            }
            var danhgia = new DanhGiaDAO().GetTheoNguoiDung(id);
            var baocao = new BaoCaoNguoiDungDAO().GetTheoNguoiBaoCao(id);
            var bibaocao = new BaoCaoNguoiDungDAO().GetTheoNguoiBiBaoCao(id);
            var baocaont = new BaoCaoNhaTroDAO().GetTheoNguoiBaoCao(id);
            var bibaocaont = new BaoCaoNhaTroDAO().GetTheoChuNhaTro(id);
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
            var vaitro = new VaiTroDAO().GetAll();
            SelectList listvaitro = new SelectList(vaitro, "ma_vt", "ten_vt");
            ViewBag.listvaitro = listvaitro;
            ViewBag.code = new NguoiDungDAO().GetAll().Last().ma_nd + 1;
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(NguoiDung nd, HttpPostedFileBase anh)
        {
            if (anh != null)
            {
                string pic = System.IO.Path.GetFileName(anh.FileName);
                string path = System.IO.Path.Combine(
                                       Server.MapPath("~/Content/ckfinder/userfiles/images"), pic);

                anh.SaveAs(path);

                nd.anh_nd = "/Content/ckfinder/userfiles/images/" + anh.FileName;
            }
            else
            {
                nd.anh_nd = "/Content/avatar.jpg";
            }
            var res = new NguoiDungDAO().Add(nd);
            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            new NguoiDungDAO().Delete(id);
            return RedirectToAction("Index");
        }
    }
}