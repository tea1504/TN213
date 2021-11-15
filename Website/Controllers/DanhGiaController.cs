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
                sosao = res.sosao,
                danhgia = res.danhgia1,
                anh = nd.anh_nd,
                hoten = nd.holot_nd + " " + nd.ten_nd,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}