using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class BaoCaoNhaTroController : CheckAdminController
    {
        BaoCaoNhaTroDAO baoCaoNhaTroDAO = null;
        public BaoCaoNhaTroController()
        {
            baoCaoNhaTroDAO = new BaoCaoNhaTroDAO();
        }
        // GET: Admin/BaoCaoNhaTro
        public ActionResult Index()
        {
            var model = baoCaoNhaTroDAO.GetAll();
            return View(model);
        }
        public JsonResult Detail(int ma_lbc, int ma_nd, int ma_nt, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            var res = baoCaoNhaTroDAO.Get(ma_lbc, ma_nd, ma_nt, d);
            string anh = "/Content/user/assets/images/course/01.jpg";
            if (res.NhaTro.AnhNhaTroes.Count > 0)
            {
                anh = res.NhaTro.AnhNhaTroes.ElementAt(0).ten_anh;
            }
            var data = new
            {
                nguoi = new
                {
                    ma = res.NguoiDung.ma_nd,
                    ten = res.NguoiDung.holot_nd + " " + res.NguoiDung.ten_nd,
                    anh = res.NguoiDung.anh_nd,
                    vaitro = res.NguoiDung.VaiTro.ten_vt,
                },
                nhatro = new
                {
                    ma = res.NhaTro.ma_nt,
                    ten = res.NhaTro.ten_nt,
                    diachi = res.NhaTro.diachi_nt,
                    anh = anh,
                },
                loai = res.LoaiBaoCao.ten_lbc,
                ngay = res.ngay.ToString("dd/MM/yyyy hh:mm:ss tt"),
                lydo = res.lydobaocao,
                trangthai = res.trangthaibaocao,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Edit(int ma_lbc, int ma_nd, int ma_nt, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            var res = baoCaoNhaTroDAO.Edit(ma_lbc, ma_nd, ma_nt, d);
            return Json("OK", JsonRequestBehavior.AllowGet);
        }
        public JsonResult Delete(int ma_lbc, int ma_nd, int ma_nt, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            baoCaoNhaTroDAO.Delete(ma_lbc, ma_nd, ma_nt, d);
            return Json("OK", JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetBaoCao()
        {
            var res = baoCaoNhaTroDAO.GetTheoTrangThai(1);
            List<object> data = new List<object>();
            foreach (var item in res.OrderByDescending(bc => bc.ngay))
            {
                var temp = new
                {
                    title = item.NguoiDung.taikhoan + " báo cáo " + item.NhaTro.ten_nt,
                    nodung = item.lydobaocao,
                    ngay = item.ngay.ToString("yyyy-MM-ddTHH:mm:ss.fff"),
                    loai = item.LoaiBaoCao.ten_lbc,
                    ma = item.ma_lbc
                };
                data.Add(temp);
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}