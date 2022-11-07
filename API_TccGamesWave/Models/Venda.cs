using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Models
{
    public class Venda
    {
        public string CodVenda { get; set; }
        public string FormaPag { get; set; }
        public string Parcela { get; set; }
        public string Total { get; set; }
        public string CodCarrinho { get; set; }
        public string Clinte_CPF { get; set; }
    }
}