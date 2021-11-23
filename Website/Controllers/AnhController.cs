using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Website.DAO;
using Website.EF;

namespace Website.Controllers
{
    public class AnhController : Controller
    {
        public JsonResult Add(int ma_nt, string ten_anh, string mota_anh)
        {
            AnhNhaTro anh = new AnhNhaTro();
            anh.ma_nt = ma_nt;
            anh.ten_anh = ten_anh;
            anh.mota_anh = mota_anh;
            var res = new AnhNhaTroDAO().AddAnhNhaTro(anh);
            var data = new
            {
                ma_nt = res.ma_nt,
                ten_anh = res.ten_anh,
                mota_anh = res.mota_anh,
                STT = res.STT
            };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}