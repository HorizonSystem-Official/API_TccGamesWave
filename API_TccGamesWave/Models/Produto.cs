using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Models
{
    public class Produto
    {
        public Produto(int codProd, string prodNome, string prodTipo, int prodQtnEstoque, string prodDesc, string prodAnoLanc, string prodFaixaEtaria, decimal prodValor, string imgCapa, int fkFunc)
        {
            CodProd = codProd;
            ProdNome = prodNome;
            ProdTipo = prodTipo;
            ProdQtnEstoque = prodQtnEstoque;
            ProdDesc = prodDesc;
            ProdAnoLanc = prodAnoLanc;
            ProdFaixaEtaria = prodFaixaEtaria;
            ProdValor = prodValor;
            ImgCapa = imgCapa;
            FkFunc = fkFunc;
        }

        public Produto(int codProd, string prodNome, string prodTipo, decimal prodValor, string imgCapa)
        {
            CodProd = codProd;
            ProdNome = prodNome;
            ProdTipo = prodTipo;
            ProdValor = prodValor;
            ImgCapa = imgCapa;
        }

        public Produto()
        {
        }

        public int CodProd { get; set; }
        public string ProdNome { get; set; }
        public string ProdTipo { get; set; }
        public int ProdQtnEstoque { get; set; }
        public string ProdDesc { get; set; }
        public string ProdAnoLanc { get; set; }
        public string ProdFaixaEtaria { get; set; }
        public decimal ProdValor { get; set; }
        public string ImgCapa { get; set; }
        public int FkFunc { get; set; }
    }
}
