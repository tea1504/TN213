using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;

namespace Website.Areas.Admin.Controllers
{
    public class AnhNhaTroController : CheckAdminController
    {
        // GET: Admin/AnhNhaTro
        public ActionResult Index()
        {
            var nhatro = new NhaTroDAO().GetAllNhaTro();
            SelectList list = new SelectList(nhatro, "ma_nt", "ten_nt");
            ViewBag.list = list;
            var model = new AnhNhaTroDAO().GetAll();
            return View(model);
        }
    }
}