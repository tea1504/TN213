﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.Models;

namespace Website.Controllers
{
    public class DSNhaTroController : Controller
    {
        public ActionResult Index(int? ma_kv, float? tiendien, float? tiennuoc, float? giaphong, int page = 1)
        {
            FilterNhaTroModel f = new FilterNhaTroModel(ma_kv, tiendien, tiennuoc, giaphong);
            var khuVuc = new KhuVucDAO().GetAllKhuVuc();
            SelectList khuVucList = new SelectList(khuVuc, "ma_kv", "ten_kv");
            ViewBag.khuVucList = khuVucList;
            int total = 0;
            var res = new NhaTroDAO().FilterNhaTro(f, page, ref total);
            ViewBag.total = total;
            ViewBag.maxpage = (int)(total / 6) + ((total % 6 > 0) ? 1 : 0);
            ViewBag.page = page;
            return View(res);
        }
        public ActionResult NhaTro(int? id)
        {
            if(id == null)
            {
                return RedirectToAction("Index");
            }
            var res = new NhaTroDAO().GetNhaTro(id ?? 1);
            res.KhuVuc = new KhuVucDAO().LayKhuVuc(res.ma_kv);
            ViewBag.tiendien;
            ViewBag.tiennuoc;
            return View(res);
        }
    }
}