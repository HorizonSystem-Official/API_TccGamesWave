using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Models
{
    public class Carrinho
    {
        public int CodCarrinho { get; set; }
        public decimal ValorTotal { get; set; }
        public string Cupom { get; set; }

    }
}