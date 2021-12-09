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
        // GET: Admin/BaoCaoNguoiDung
        public ActionResult Index()
        {
            var model = new BaoCaoNguoiDungDAO().GetAll();
            return View(model);
        }
        public JsonResult Detail(int ma_lbc, int nguoibaocao, int nguoibibaocao, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            var res = new BaoCaoNguoiDungDAO().Get(ma_lbc, nguoibaocao, nguoibibaocao, d);
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
            var res = new BaoCaoNguoiDungDAO().Edit(ma_lbc, nguoibaocao, nguoibibaocao, d);
            return Json("OK", JsonRequestBehavior.AllowGet);
        }
        public JsonResult Delete(int ma_lbc, int nguoibaocao, int nguoibibaocao, string ngay)
        {
            var d = new DateTime();
            d = DateTime.Parse(ngay, null, System.Globalization.DateTimeStyles.RoundtripKind);
            new BaoCaoNguoiDungDAO().Delete(ma_lbc, nguoibaocao, nguoibibaocao, d);
            return Json("OK", JsonRequestBehavior.AllowGet);
        }
    }
}