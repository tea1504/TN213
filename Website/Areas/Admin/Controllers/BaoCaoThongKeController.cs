using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class BaoCaoThongKeController : CheckAdminController
    {
        NguoiDungDAO nguoiDungDAO = null;
        NhaTroDAO nhaTroDAO = null;
        VaiTroDAO vaiTroDAO = null;
        BaoCaoNguoiDungDAO baoCaoNguoiDungDAO = null;
        BaoCaoNhaTroDAO baoCaoNhaTroDAO = null;
        DanhGiaDAO danhGiaDAO = null;
        KhuVucDAO khuVucDAO = null;
        LoaiBaoCaoDAO loaiBaoCaoDAO = null;
        public BaoCaoThongKeController()
        {
            nguoiDungDAO = new NguoiDungDAO();
            nhaTroDAO = new NhaTroDAO();
            vaiTroDAO = new VaiTroDAO();
            baoCaoNguoiDungDAO = new BaoCaoNguoiDungDAO();
            baoCaoNhaTroDAO = new BaoCaoNhaTroDAO();
            danhGiaDAO = new DanhGiaDAO();
            khuVucDAO = new KhuVucDAO();
            loaiBaoCaoDAO = new LoaiBaoCaoDAO();
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
                data.Add(item.NguoiDungs.Count);
                total += item.NguoiDungs.Count;
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
            foreach (var item in nguoidung)
            {
                var baocao = baoCaoNguoiDungDAO.GetTheoNguoiBiBaoCao(item.ma_nd);
                if (baocao.Count > 0)
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
        public ActionResult NhaTro()
        {
            return View();
        }
        public JsonResult NhaTroKhuVuc()
        {
            var list = khuVucDAO.GetAllKhuVuc();
            var data = new List<object>();
            var label = new List<object>();
            var color = new List<object>();
            int total = 0;
            foreach (var item in list)
            {
                data.Add(item.NhaTroes.Count);
                label.Add(item.ten_kv);
                color.Add("#" + item.ma_ms);
                total += item.NhaTroes.Count;
            }
            var res = new
            {
                data,
                label,
                color,
                total
            };
            return Json(res, JsonRequestBehavior.AllowGet);
        }
        public JsonResult NhaTroDanhGiaTrungBinh()
        {
            var list = nhaTroDAO.GetAllNhaTro();
            var data = new List<int> { 0, 0, 0, 0, 0 };
            foreach (var item in list)
            {
                double sosao = item.DanhGias.Select(dg => dg.sosao).DefaultIfEmpty(0).Average();
                if (sosao <= 1)
                { 
                    data[0]++; 
                }
                else if (sosao <= 2)
                {
                    data[1]++;
                }
                else if (sosao <= 3)
                {
                    data[2]++;
                }
                else if (sosao <= 4)
                {
                    data[3]++;
                }
                else
                {
                    data[4]++;
                }
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult NhaTroDanhGia()
        {
            var list = nhaTroDAO.GetAllNhaTro();
            var data = new List<object>();
            foreach (var item in list)
            {
                double sosao = item.DanhGias.Select(dg => dg.sosao).DefaultIfEmpty(0).Average();
                if (sosao > 0)
                {
                    var temp = new
                    {
                        ma = item.ma_nt,
                        ten = item.ten_nt,
                        soluong = sosao,
                    };
                    data.Add(temp);
                }
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult NhaTroViPham()
        {
            var listLBC = loaiBaoCaoDAO.GetAllLoaiBaoCao();
            var listNT = nhaTroDAO.GetAllNhaTro();
            var label = new List<object>();
            foreach(var item in listLBC)
            {
                label.Add(item.ten_lbc);
            }
            var data = new List<object>();
            foreach (var item in listNT)
            {
                int baocao = item.BaoCaoNhaTroes.Count;
                if (baocao > 0)
                {
                    var lanbaocao = new List<int>();
                    foreach (var i in listLBC)
                    {
                        lanbaocao.Add(0);
                    }
                    foreach (var i in item.BaoCaoNhaTroes)
                    {
                        lanbaocao[listLBC.FindIndex(m => m.ma_lbc == i.ma_lbc)]++;
                    }
                    var temp = new
                    {
                        data = lanbaocao,
                        ma = item.ma_nt,
                        ten = item.ten_nt,
                        soluong = baocao,
                    };
                    data.Add(temp);
                }
            }
            var res = new
            {
                label,
                data,
            };
            return Json(res, JsonRequestBehavior.AllowGet);
        }
    }
}