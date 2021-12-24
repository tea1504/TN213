using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website.EF;

namespace Website.DAO
{
    public class AnhNhaTroDAO
    {
        NhaTroDBContext db = null;
        public AnhNhaTroDAO()
        {
            db = new NhaTroDBContext();
        }
        public List<AnhNhaTro> GetAnhNhaTroTheoMaNhaTro(int ma_nt)
        {
            var res = db.AnhNhaTroes.Where(anh => anh.ma_nt == ma_nt).ToList();
            return res;
        }
        public AnhNhaTro AddAnhNhaTro(AnhNhaTro anh)
        {
            anh.STT = GetSoLuongAnhTheoNhaTro(anh.ma_nt) + 1;
            var res = db.AnhNhaTroes.Add(anh);
            db.SaveChanges();
            return res;
        }
        public int GetSoLuongAnhTheoNhaTro(int ma_nt)
        {
            var res = db.AnhNhaTroes.Where(anh => anh.ma_nt == ma_nt).Count();
            return res;
        }
        public void DeleteTheoNhaTro(int ma_nt)
        {
            var list = GetAnhNhaTroTheoMaNhaTro(ma_nt);
            if (list != null)
            {
                foreach (var item in list)
                {
                    db.AnhNhaTroes.Remove(item);
                    db.SaveChanges();
                }
            }
        }
        public List<AnhNhaTro> GetAll()
        {
            var res = db.AnhNhaTroes.ToList();
            return res;
        }
        public AnhNhaTro Edit(AnhNhaTro anh)
        {
            var res = db.AnhNhaTroes.Where(a => a.ma_nt == anh.ma_nt && a.STT == anh.STT).SingleOrDefault();
            res.mota_anh = anh.mota_anh;
            db.SaveChanges();
            return res;
        }
        public void Delete(int ma_nt, int STT)
        {
            var res = db.AnhNhaTroes.Where(a => a.ma_nt == ma_nt && a.STT == STT).SingleOrDefault();
            db.AnhNhaTroes.Remove(res);
            db.SaveChanges();
        }
    }
}