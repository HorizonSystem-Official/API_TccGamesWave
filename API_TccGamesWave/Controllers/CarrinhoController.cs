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
    public class CarrinhoController : ApiController
    {

        //lista itens 
        [HttpGet]
        [ActionName("ItensCarrinho")]
        public List<ItemCarrinho> MostraItens(string cpf)
        {
            //tenta conectar ao banco
            try
            {
                BdConector db = new BdConector();
                var itens = db.MostraItens(cpf);
                db.FecharBd();
                return itens;
            }
            catch (Exception e)
            {
                //se der erado o banco retorna erro de desautorizado 
                var resp = new HttpResponseMessage(HttpStatusCode.Unauthorized);
                throw new HttpResponseException(resp);
            }
        }

        //lista itens 
        [HttpGet]
        [ActionName("TotalCarrinho")]
        public Carrinho TotalCarrinho(string cpf)
        {
            //tenta conectar ao banco
            try
            {
                BdConector db = new BdConector();
                var carrinho = db.TotalCarrinho(cpf);
                db.FecharBd();
                return carrinho;
            }
            catch (Exception e)
            {
                //se der erado o banco retorna erro de desautorizado 
                var resp = new HttpResponseMessage(HttpStatusCode.Unauthorized);
                throw new HttpResponseException(resp);
            }
        }

        //criação de um item venda
         [HttpPost]
         [ActionName("addItemCarrinho")]
         public HttpResponseMessage Post([FromBody] ItemCarrinho itens)
         {
             if (itens == null)
             {
                 return new HttpResponseMessage(HttpStatusCode.NotModified);
             }
             BdConector db = new BdConector();
             db.addItemCarrinho(itens);            
             db.FecharBd();

             //retorna mensagem de sucesso
             var response = new HttpResponseMessage(HttpStatusCode.Created);
             return response;
         }

        //remove item
        [HttpDelete]
        [ActionName("removeItem")]
        public HttpResponseMessage Delete(int codProd, string cpf)
        {
            BdConector db = new BdConector();
            db.RemoveItemCarrinho(codProd, cpf);
            db.FecharBd();

            return new HttpResponseMessage(HttpStatusCode.OK);
        }
    }
}
