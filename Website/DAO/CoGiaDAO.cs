﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class CoGiaDAO
    {
        NhaTroDBContext db = null;
        public CoGiaDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<CoGia> GetGiaPhongGanDayTheoNhaTro(int ma_nt)
        {
            object[] sqlParams =
            {
                new SqlParameter("@ma_nt", ma_nt),
            };
            var res = db.Database.SqlQuery<CoGia>("sp_get_gia_phong_hien_tai @ma_nt", sqlParams).ToList();
            for(var i=0; i< res.Count; i++)
            {
                res[i].LoaiPhong = new Loa
            }
            return res;
        }
    }
}