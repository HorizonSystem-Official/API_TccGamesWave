using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Models
{
    public class ItemCarrinho
    {
        public string ProdNome { get; set; }
        public int QtnProd { get; set; }
        public int CodProd { get; set; }
        public string ValorUnit { get; set; }
        public string Cpf { get; set; }
        public string ValorTotal { get; set; }
        public string ImgCapa { get; set; }
    }
}