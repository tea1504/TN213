using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class CoTienDienNuocDAO
    {
        NhaTroDBContext db = null;
        public CoTienDienNuocDAO()
        {
            db = new NhaTroDBContext();
        }

    }
}