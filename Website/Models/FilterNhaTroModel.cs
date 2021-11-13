using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Website.Models
{
    public class FilterNhaTroModel
    {
        public int? ma_kv { set; get; }
        public float? tiendien { set; get; }
        public float? tiennuoc { set; get; }
        public float? giaphong { set; get; }
        public FilterNhaTroModel(int? a, float? b, float? c, float? d)
        {
            ma_kv = a;
            tiendien = b;
            tiennuoc = c;
            giaphong = d;
        }
    }
}