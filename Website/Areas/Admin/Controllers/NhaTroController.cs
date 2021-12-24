using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.Controllers;
using Website.DAO;
using Website.EF;

namespace Website.Areas.Admin.Controllers
{
    public class NhaTroController : CheckAdminController
    {
        NhaTroDAO nhaTroDAO = null;
        public NhaTroController()
        {
            nhaTroDAO = new NhaTroDAO();
        }
        // GET: Admin/NhaTro
        public ActionResult Index()
        {
            List<NhaTro> model = nhaTroDAO.GetAllNhaTro();
            return View(model);
        }
        public ActionResult Detail(int id)
        {
            var model = nhaTroDAO.GetNhaTro(id);
            if (model == null)
            {
                return RedirectToAction("Index");
            }
            return View(model);
        }
        public ActionResult Delete(int id)
        {
            nhaTroDAO.Delete(id);
            return RedirectToAction("Index");
        }
    }
}