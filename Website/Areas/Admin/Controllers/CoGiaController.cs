using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class CoGiaController : CheckAdminController
    {
        CoGiaDAO coGiaDAO = null;
        public CoGiaController()
        {
            coGiaDAO = new CoGiaDAO();
        }
        // GET: Admin/CoGia
        public ActionResult Index()
        {
            var model = coGiaDAO.GetAll();
            return View(model);
        }
        public JsonResult GetTheoNhaTroVaLoaiPhong(int ma_nt, int ma_lp)
        {
            var res = coGiaDAO.GetTheoNhaTroVaLoaiPhong(ma_nt, ma_lp);
            var data = new List<object>();
            foreach(var item in res.OrderByDescending(cg=>cg.ngay).Take(5))
            {
                var temp = new
                {
                    ngay = item.ngay.ToString("dd/MM/yyyy"),
                    gia = item.giaphong,
                };
                data.Add(temp);
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}