using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.EF;

namespace Website.Controllers
{
    public class DanhGiaController : Controller
    {
        public ActionResult GuiDanhGia(DanhGia dg)
        {
            return RedirectToAction("NhaTro", "DSNhaTro", new { Area = "", id = dg.ma_nt });
        }
    }
}