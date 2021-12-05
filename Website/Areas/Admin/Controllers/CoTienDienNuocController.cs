using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class CoTienDienNuocController : CheckAdminController
    {
        // GET: Admin/CoTienDienNuoc
        public ActionResult Index()
        {
            var model = new CoTienDienNuocDAO().GetAll();
            return View(model);
        }
        public JsonResult GetTheoNhaTro(int id)
        {
            var res = new CoTienDienNuocDAO().GetTheoNhaTro(id);
            var data = new List<object>();
            foreach(var item in res.OrderByDescending(d=>d.ngay).Take(5))
            {
                var temp = new
                {
                    ngay = item.ngay.ToString("dd/MM/yyyy"),
                    dien = item.tiendien,
                    nuoc = item.tiennuoc
                };
                data.Add(temp);
            }
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}