using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;
using Website.Models;

namespace Website.Controllers
{
    public class DSNhaTroController : Controller
    {
        public ActionResult Index(int? ma_kv, float? tiendien, float? tiennuoc, float? giaphong, int page = 1)
        {
            FilterNhaTroModel f = new FilterNhaTroModel(ma_kv, tiendien, tiennuoc, giaphong);
            var khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList khuVucList = new SelectList(khuVuc, "ma_kv", "ten_kv");
            ViewBag.khuVucList = khuVucList;
            int total = 0;
            var res = new NhaTroDAO().FilterNhaTro(f, page, ref total);
            ViewBag.total = total;
            ViewBag.maxpage = (int)(total / 6) + ((total % 6 > 0) ? 1 : 0);
            ViewBag.page = page;
            return View(res);
        }
        public ActionResult NhaTro(int? id)
        {
            if (id == null)
            {
                return RedirectToAction("Index");
            }
            var res = new NhaTroDAO().GetNhaTro(id ?? 1);
            if (res == null)
            {
                return RedirectToAction("Index");
            }
            ViewBag.tiendien = new CoTienDienNuocDAO().GetTienDien(res.ma_nt);
            ViewBag.tiennuoc = new CoTienDienNuocDAO().GetTienNuoc(res.ma_nt);
            ViewBag.khuvuc = new KhuVucDAO().GetAllKhuVuc();
            var loaiBaoCao = new LoaiBaoCaoDAO().GetAllLoaiBaoCao();
            SelectList loaiBaoCaoList = new SelectList(loaiBaoCao, "ma_lbc", "ten_lbc");
            ViewBag.loaiBaoCaoList = loaiBaoCaoList;
            return View(res);
        }
        public ActionResult TimKiem()
        {
            List<KhuVuc> khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList listKhuVuc = new SelectList(khuVuc, "ma_kv", "ten_kv");
            ViewBag.listKhuVuc = listKhuVuc;
            List<TruongHoc> truongHoc = new TruongHocDAO().GetAllTruongHoc();
            SelectList listTruongHoc = new SelectList(truongHoc, "ma_th", "ten_th");
            ViewBag.listTruongHoc = listTruongHoc;
            return View();
        }
        public JsonResult KetQua(int? ma_kv, int? ma_th, string ten_nt, string diachi_nt, string ten_nd, int? khoancach)
        {
            List<NhaTro> resNT = new NhaTroDAO().GetKQTimNhaTro(ma_kv, ma_th, ten_nt, diachi_nt, ten_nd, khoancach);
            List<object[]> dataNT = new List<object[]>();
            List<object[]> dataKV = new List<object[]>();
            List<KhuVuc> resKV;
            if (ma_kv == null)
            {
                resKV = new KhuVucDAO().GetAllKhuVuc();
            }
            else
            {
                resKV = new List<KhuVuc>();
                resKV.Add(new KhuVucDAO().LayKhuVuc(ma_kv ?? 1));
            }
            foreach (var item in resNT)
            {
                object[] temp =
                {
                    item.ma_kv,
                    item.ma_nd,
                    item.ma_nt,
                    item.toado_nt.XCoordinate,
                    item.toado_nt.YCoordinate,
                    item.ten_nt,
                    item.diachi_nt,
                };
                dataNT.Add(temp);
            }
            foreach (var item in resKV)
            {
                object[] temp =
                {
                    item.ma_kv,
                    item.ten_kv,
                    item.toado_kv.XCoordinate,
                    item.toado_kv.YCoordinate,
                    item.polygon_kv.AsText(),
                    item.ma_ms,
                };
                dataKV.Add(temp);
            };
            if (ma_th != null)
            {
                TruongHoc resTH = new TruongHocDAO().GetTruongHoc(ma_th ?? 1);
                object[] dataTH =
                {
                    resTH.ma_th,
                    resTH.ten_th,
                    resTH.toado_th.XCoordinate,
                    resTH.toado_th.YCoordinate,
                    resTH.diachi_th,
                };
                var res = new
                {
                    dsnhatro = dataNT,
                    dskhuvuc = dataKV,
                    truonghoc = dataTH,
                };
                return Json(res, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var res = new
                {
                    dsnhatro = dataNT,
                    dskhuvuc = dataKV,
                    truonghoc = "",
                };
                return Json(res, JsonRequestBehavior.AllowGet);
            }
        }
        public JsonResult ThongTinNhaTro(int ma_nt)
        {
            var res = new NhaTroDAO().GetNhaTro(ma_nt);
            var sosao = new DanhGiaDAO().TBSoSaoTheoNhaTro(ma_nt);
            List<object> anh = new List<object>();
            List<object> danhgia = new List<object>();
            foreach (var item in res.AnhNhaTroes)
            {
                var temp = new
                {
                    ten_anh = item.ten_anh,
                    mota = item.mota_anh
                };
                anh.Add(temp);
            }
            foreach (var item in res.DanhGias)
            {
                var temp = new
                {
                    ngay = item.ngay.ToShortDateString(),
                    sosao = item.sosao,
                    danhgia = item.danhgia1,
                    user = new
                    {
                        ten = item.NguoiDung.ten_nd,
                        holot = item.NguoiDung.holot_nd,
                        anh = item.NguoiDung.anh_nd
                    }
                };
                danhgia.Add(temp);
            }
            var data = new
            {
                nhatro = new
                {
                    ma_nt = res.ma_nt,
                    ten_nt = res.ten_nt,
                    diachi_nt = res.diachi_nt,
                    sdt_nt = res.sdt_nt,
                    sosao = sosao
                },
                chutro = new
                {
                    ten = res.NguoiDung.ten_nd,
                    holot = res.NguoiDung.holot_nd,
                    anh = res.NguoiDung.anh_nd
                },
                anh = anh,
                danhgia = danhgia
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}