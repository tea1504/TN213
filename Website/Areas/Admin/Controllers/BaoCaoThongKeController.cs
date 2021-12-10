using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class BaoCaoThongKeController : Controller
    {
        NguoiDungDAO nguoiDungDAO = null;
        NhaTroDAO nhaTroDAO = null;
        VaiTroDAO vaiTroDAO = null;
        BaoCaoNguoiDungDAO baoCaoNguoiDungDAO = null;
        BaoCaoNhaTroDAO baoCaoNhaTroDAO = null;
        DanhGiaDAO danhGiaDAO = null;
        public BaoCaoThongKeController()
        {
            nguoiDungDAO = new NguoiDungDAO();
            nhaTroDAO = new NhaTroDAO();
            vaiTroDAO = new VaiTroDAO();
            baoCaoNguoiDungDAO = new BaoCaoNguoiDungDAO();
            baoCaoNhaTroDAO = new BaoCaoNhaTroDAO();
            danhGiaDAO = new DanhGiaDAO();
        }
        // GET: Admin/BaoCaoThongKe
        public ActionResult NguoiDung()
        {
            return View();
        }
        public JsonResult NguoiDungGioiTinh()
        {
            var nu = nguoiDungDAO.LayTheoGioiTinh(0);
            var nam = nguoiDungDAO.LayTheoGioiTinh(1);
            var data = new
            {
                nam = nam.Count,
                nu = nu.Count,
                total = nam.Count + nu.Count,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult NguoiDungVaiTro()
        {
            var listVaiTro = vaiTroDAO.GetAll();
            var data = new List<object>();
            var label = new List<object>();
            int total = 0;
            foreach (var item in listVaiTro)
            {
                var temp = nguoiDungDAO.LayTheoVaiTro(item.ma_vt);
                data.Add(temp.Count);
                total += temp.Count;
                label.Add(item.ten_vt);
            }
            var res = new
            {
                data = data,
                label = label,
                total = total,
            };
            return Json(res, JsonRequestBehavior.AllowGet);
        }
        public JsonResult NguoiDungViPham()
        {
            var nguoidung = nguoiDungDAO.GetAll();
            var data = new List<object>();
            foreach(var item in nguoidung)
            {
                var baocao = baoCaoNguoiDungDAO.GetTheoNguoiBiBaoCao(item.ma_nd);
                if(baocao.Count > 0)
                {
                    var temp = new
                    {
                        ma = item.ma_nd,
                        ten = item.holot_nd + " " + item.ten_nd,
                        soluong = baocao.Count,
                    };
                    data.Add(temp);
                }
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult NguoiDungDongGop()
        {
            var nguoidung = nguoiDungDAO.GetAll();
            var data = new List<object>();
            foreach (var item in nguoidung)
            {
                var baocaonguoi = baoCaoNguoiDungDAO.GetTheoNguoiBaoCao(item.ma_nd);
                var baocaonhatro = baoCaoNhaTroDAO.GetTheoNguoiBaoCao(item.ma_nd);
                var danhgia = danhGiaDAO.GetTheoNguoiDung(item.ma_nd);
                if (baocaonguoi.Count + baocaonhatro.Count + danhgia.Count > 0)
                {
                    var temp = new
                    {
                        ma = item.ma_nd,
                        ten = item.holot_nd + " " + item.ten_nd,
                        soluong = baocaonguoi.Count + baocaonhatro.Count + danhgia.Count,
                        baocaonguoi = baocaonguoi.Count,
                        baocaonhatro = baocaonhatro.Count,
                        danhgia = danhgia.Count,
                    };
                    data.Add(temp);
                }
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}