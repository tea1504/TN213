using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class DashboardController : CheckAdminController
    {
        NhaTroDAO nhaTroDAO = null;
        NguoiDungDAO nguoiDungDAO = null;
        TruongHocDAO truongHocDAO = null;
        KhuVucDAO khuVucDAO = null;
        DanhGiaDAO danhGiaDAO = null;
        public DashboardController()
        {
            nhaTroDAO = new NhaTroDAO();
            nguoiDungDAO = new NguoiDungDAO();
            truongHocDAO = new TruongHocDAO();
            khuVucDAO = new KhuVucDAO();
            danhGiaDAO = new DanhGiaDAO();
        }
        // GET: Admin/Dashboard
        public ActionResult Index()
        {
            ViewBag.nhaTroCount = nhaTroDAO.GetAllNhaTro().Count;
            ViewBag.nguoiDungCount = nguoiDungDAO.GetAll().Count;
            ViewBag.truongHocCount = truongHocDAO.GetAllTruongHoc().Count;
            ViewBag.khuVucCount = khuVucDAO.GetAllKhuVuc().Count;
            return View();
        }
        public JsonResult GetDanhGia()
        {
            DateTime d = DateTime.Now;
            DateTime min = new DateTime(d.Year, d.Month, d.Day, 0, 0, 0);
            DateTime max = new DateTime(d.Year, d.Month, d.Day, 23, 59, 59);
            DateTime first = danhGiaDAO.GetFirstDate();
            var today = new List<int>
            {
                danhGiaDAO.CountStar(min, max, 1),
                danhGiaDAO.CountStar(min, max, 2),
                danhGiaDAO.CountStar(min, max, 3),
                danhGiaDAO.CountStar(min, max, 4),
                danhGiaDAO.CountStar(min, max, 5),
            };
            var tomorow = new List<int>
            {
                danhGiaDAO.CountStar(min.AddDays(-1), max.AddDays(-1), 1),
                danhGiaDAO.CountStar(min.AddDays(-1), max.AddDays(-1), 2),
                danhGiaDAO.CountStar(min.AddDays(-1), max.AddDays(-1), 3),
                danhGiaDAO.CountStar(min.AddDays(-1), max.AddDays(-1), 4),
                danhGiaDAO.CountStar(min.AddDays(-1), max.AddDays(-1), 5),
            };
            var dulieu = new List<object>();
            var labels = new List<object>();
            for (DateTime i = first; i <= max; i = i.AddDays(+1))
            {
                DateTime mi = new DateTime(i.Year, i.Month, i.Day, 0, 0, 0);
                DateTime ma = new DateTime(i.Year, i.Month, i.Day, 23, 59, 59);
                var temp = new List<int>
                {
                    danhGiaDAO.CountStar(mi, ma, 1),
                    danhGiaDAO.CountStar(mi, ma, 2),
                    danhGiaDAO.CountStar(mi, ma, 3),
                    danhGiaDAO.CountStar(mi, ma, 4),
                    danhGiaDAO.CountStar(mi, ma, 5),
                };
                labels.Add(i.ToString("dd/MM"));
                dulieu.Add(temp);
            }
            var data = new
            {
                today,
                tomorow,
                labels,
                dulieu,
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}