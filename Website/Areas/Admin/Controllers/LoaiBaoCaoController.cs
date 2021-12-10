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
    public class LoaiBaoCaoController : CheckAdminController
    {
        LoaiBaoCaoDAO loaiBaoCaoDAO = null;
        public LoaiBaoCaoController()
        {
            loaiBaoCaoDAO = new LoaiBaoCaoDAO();
        }
        // GET: Admin/LoaiBaoCao
        public ActionResult Index()
        {
            var model = loaiBaoCaoDAO.GetAllLoaiBaoCao();
            return View(model);
        }
        public ActionResult Create(LoaiBaoCao lbc)
        {
            var res = loaiBaoCaoDAO.Add(lbc);
            return RedirectToAction("Index");
        }
        public ActionResult Edit(LoaiBaoCao lbc)
        {
            var res = loaiBaoCaoDAO.Edit(lbc);
            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            loaiBaoCaoDAO.Delete(id);
            return RedirectToAction("Index");
        }
    }
}