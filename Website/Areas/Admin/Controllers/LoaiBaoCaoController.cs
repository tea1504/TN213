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
        // GET: Admin/LoaiBaoCao
        public ActionResult Index()
        {
            var model = new LoaiBaoCaoDAO().GetAllLoaiBaoCao();
            return View(model);
        }
        public ActionResult Create(LoaiBaoCao lbc)
        {
            var res = new LoaiBaoCaoDAO().Add(lbc);
            return RedirectToAction("Index");
        }
        public ActionResult Edit(LoaiBaoCao lbc)
        {
            var res = new LoaiBaoCaoDAO().Edit(lbc);
            return RedirectToAction("Index");
        }
        public ActionResult Delete(int id)
        {
            new LoaiBaoCaoDAO().Delete(id);
            return RedirectToAction("Index");
        }
    }
}