using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website.EF;
using Website.Models;

namespace Website.DAO
{
    public class LoginDAO
    {
        NhaTroDBContext db = null;
        public LoginDAO()
        {
            db = new NhaTroDBContext();
        }
        public bool CheckLogin(LoginModel login)
        {
            object[] sqlParams =
            {
                new SqlParameter("@taikhoan", login.taikhoan),
                new SqlParameter("@matkhau", login.matkhau),
            };
            var res = db.Database.SqlQuery<bool>("sp_login @taikhoan, @matkhau", sqlParams).SingleOrDefault();
            return res;
        }
    }
}