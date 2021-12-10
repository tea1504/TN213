using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class BaoCaoNguoiDungController : CheckAdminController
    {
        BaoCaoNguoiDungDAO baoCaoNguoiDungDAO = null;
        public BaoCaoNguoiDungController()
        {
            baoCaoNguoiDungDAO = new BaoCaoNguoiDungDAO();
        }
        // GET: Admin/BaoCaoNguoiDung
        public ActionResult Index()
        {
            var model = baoCaoNguoiDungDAO.GetAll();
            return View(model);
        }
        public JsonResult Detail(int ma_lbc, int nguoibaocao, int nguoibibaocao, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            var res = baoCaoNguoiDungDAO.Get(ma_lbc, nguoibaocao, nguoibibaocao, d);
            var data = new
            {
                nguoibaocao = new
                {
                    ma = res.NguoiDung.ma_nd,
                    ten = res.NguoiDung.holot_nd + " " + res.NguoiDung.ten_nd,
                    anh = res.NguoiDung.anh_nd,
                    vaitro = res.NguoiDung.VaiTro.ten_vt,
                },
                nguoibibaocao = new
                {
                    ma = res.NguoiDung1.ma_nd,
                    ten = res.NguoiDung1.holot_nd + " " + res.NguoiDung1.ten_nd,
                    anh = res.NguoiDung1.anh_nd,
                    vaitro = res.NguoiDung1.VaiTro.ten_vt,
                },
                loai = res.LoaiBaoCao.ten_lbc,
                ngay = res.ngay.ToString("dd/MM/yyyy hh:mm:ss tt"),
                lydo = res.lydo,
                trangthai = res.trangthai,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Edit(int ma_lbc, int nguoibaocao, int nguoibibaocao, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            var res = baoCaoNguoiDungDAO.Edit(ma_lbc, nguoibaocao, nguoibibaocao, d);
            return Json("OK", JsonRequestBehavior.AllowGet);
        }
        public JsonResult Delete(int ma_lbc, int nguoibaocao, int nguoibibaocao, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            baoCaoNguoiDungDAO.Delete(ma_lbc, nguoibaocao, nguoibibaocao, d);
            return Json("OK", JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetBaoCao()
        {
            var res = baoCaoNguoiDungDAO.GetTheoTrangThai(1);
            List<object> data = new List<object>();
            foreach(var item in res.OrderByDescending(bc=>bc.ngay))
            {
                var temp = new
                {
                    title = item.NguoiDung.taikhoan + " báo cáo " + item.NguoiDung1.taikhoan,
                    nodung = item.lydo,
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