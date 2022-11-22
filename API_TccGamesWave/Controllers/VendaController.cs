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
    public class VendaController : ApiController
    {
        //criação de um item venda
        [HttpPost]
        [ActionName("EfetuaCompra")]
        public HttpResponseMessage Post([FromBody] Venda itensVenda)
        {
            if (itensVenda == null)
            {
                return new HttpResponseMessage(HttpStatusCode.NotModified);
            }
            BdConector db = new BdConector();
            db.ConcluiVenda(itensVenda);
            db.FecharBd();

            //retorna mensagem de sucesso
            var response = new HttpResponseMessage(HttpStatusCode.Created);
            return response;
        }


        //lista itens 
        [HttpGet]
        [ActionName("Recibo")]
        public Venda ReciboVenda(string cpf)
        {
            //tenta conectar ao banco
            try
            {
                BdConector db = new BdConector();
                var venda = db.ReciboCompra(cpf);
                db.FecharBd();
                return venda;
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
