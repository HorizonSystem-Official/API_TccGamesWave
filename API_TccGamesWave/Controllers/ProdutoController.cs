using API_TccGamesWave.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using static API_TccGamesWave.Banco.BdConexao;

namespace API_TccGamesWave.Controllers
{
    public class ProdutoController : ApiController
    {
        //Mostra Prod simples por cod
        [HttpGet]
        [ActionName("umProdSimples")]
        public IEnumerable<Produto> SelecionaUmProdSimples(int idProd)
        {
            //tenta conectar ao banco
            try
            {
                BdConector db = new BdConector();
                var cants = db.SelecionaUmProdSimples(idProd);
                db.FecharBd();
                return cants;
            }
            catch (Exception e)
            {
                //se der erado o banco retorna erro de desautorizado 
                var resp = new HttpResponseMessage(HttpStatusCode.Unauthorized);
                throw new HttpResponseException(resp);
            }
        }


        //Mostra Prod simples por categoria
        [HttpGet]
        [ActionName("prodCategoria")]
        public IEnumerable<Produto> ProdPorCategoria(string cat)
        {
            //tenta conectar ao banco
            try
            {
                BdConector db = new BdConector();
                var cants = db.ProdPorCategoria(cat);
                db.FecharBd();
                return cants;
            }
            catch (Exception e)
            {
                //se der erado o banco retorna erro de desautorizado 
                var resp = new HttpResponseMessage(HttpStatusCode.Unauthorized);
                throw new HttpResponseException(resp);
            }
        }
    }
}
