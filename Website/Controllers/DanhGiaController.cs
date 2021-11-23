using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;

namespace Website.Controllers
{
    public class DanhGiaController : Controller
    {
        public JsonResult GuiDanhGia(DanhGia dg)
        {
            dg.ngay = DateTime.Now;
            var res = new DanhGiaDAO().AddDanhGia(dg);
            var nd = new NguoiDungDAO().LayNguoiDung(res.ma_nd);
            var data = new {
                ngay = res.ngay.ToString("dd/MM/yyyy h:mm:ss tt"),
                ngayiso = res.ngay.ToString("yyyy-MM-ddTHH:mm:ss.fff"),
                sosao = res.sosao,
                danhgia = res.danhgia1,
                anh = nd.anh_nd,
                hoten = nd.holot_nd + " " + nd.ten_nd,
                ma_nt = res.ma_nt,
                ma_nd = res.ma_nd,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult XoaDanhGia(int ma_nd, int ma_nt, string ngay, string danhgia, int? sosao)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            var res = new DanhGiaDAO().XoaDanhGia(ma_nt, ma_nd, d, danhgia, sosao);
            var nd = new NguoiDungDAO().LayNguoiDung(res.ma_nd);
            var data = new
            {
                ngay = res.ngay.ToString("dd/MM/yyyy h:mm:ss tt"),
                ngayiso = res.ngay.ToString("yyyy-MM-ddTHH:mm:ss.fff"),
                sosao = res.sosao,
                danhgia = res.danhgia1,
                anh = nd.anh_nd,
                hoten = nd.holot_nd + " " + nd.ten_nd,
                ma_nt = res.ma_nt,
                ma_nd = res.ma_nd,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult ChartData(int ma_nt)
        {
            object[] data =
            {
                new DanhGiaDAO().CountStar(ma_nt, 1),
                new DanhGiaDAO().CountStar(ma_nt, 2),
                new DanhGiaDAO().CountStar(ma_nt, 3),
                new DanhGiaDAO().CountStar(ma_nt, 4),
                new DanhGiaDAO().CountStar(ma_nt, 5),
                0
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}