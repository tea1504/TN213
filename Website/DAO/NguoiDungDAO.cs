using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class NguoiDungDAO
    {
        NhaTroDBContext db = null;
        public NguoiDungDAO()
        {
            db = new NhaTroDBContext();
        }
        public NguoiDung LayNguoiDungTheoTaiKhoan(string taikhoan)
        {
            object[] sqlParams =
            {
                new SqlParameter("@taikhoan", taikhoan)
            };
            var res = db.Database.SqlQuery<NguoiDung>("sp_get_nguoi_dung @taikhoan", sqlParams).SingleOrDefault();
            return res;
        }
    }
}