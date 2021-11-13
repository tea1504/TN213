using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.Models
{
    public class DSNhaTroModel
    {
        public NhaTro nhaTro { set; get; }
        public NguoiDung nguoiDung { set; get; }
        public KhuVuc khuVuc { set; get; } 
        public float soSao { set; get; } 
        public int soDanhGia { set; get; }
        public DSNhaTroModel() { }
        public DSNhaTroModel(NhaTro nt, NguoiDung nd, KhuVuc kv, float ss, int dg)
        {
            nhaTro = nt;
            nguoiDung = nd;
            khuVuc = kv;
            soSao = ss;
            soDanhGia = dg;
        }
    }
}