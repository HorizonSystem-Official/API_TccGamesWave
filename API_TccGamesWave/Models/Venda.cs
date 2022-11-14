using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Models
{
    public class Venda
    {
        public int CodVenda { get; set; }
        public string FormaPag { get; set; }
        public int Parcela { get; set; }
        public float Total { get; set; }
        public int CodCarrinho { get; set; }
        public string Clinte_CPF { get; set; }
    }
}