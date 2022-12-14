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
    public class ClienteController : ApiController
    {
        //mostra dados do cliente
        [HttpGet]
        [ActionName("DadosCli")]
        public Cliente DadosCliente(string CpfCli)
        {
            //tenta conectar ao banco
            try
            {
                BdConector db = new BdConector();
                var cli = db.DadosCliente(CpfCli);
                db.FecharBd();
                return cli;
            }
            catch (Exception e)
            {
                //se der erado o banco retorna erro de desautorizado 
                var resp = new HttpResponseMessage(HttpStatusCode.Unauthorized);
                throw new HttpResponseException(resp);
            }
        }

        //mostra dados do cliente
        [HttpGet]
        [ActionName("LoginCliente")]
        public Cliente LoginCliente(string Emailcli, string senhaCli)
        {
            //tenta conectar ao banco
            try
            {
                BdConector db = new BdConector();
                var cli = db.LoginCliente(Emailcli, senhaCli);
                db.FecharBd();
                return cli;
            }
            catch (Exception e)
            {
                //se der erado o banco retorna erro de desautorizado 
                var resp = new HttpResponseMessage(HttpStatusCode.Unauthorized);
                throw new HttpResponseException(resp);
            }
        }

        //add cliente
        [HttpPost]
        [ActionName("addCliente")]
        public HttpResponseMessage Post([FromBody] Cliente itens)
        {
            if (itens == null)
            {
                return new HttpResponseMessage(HttpStatusCode.NotModified);
            }
            BdConector db = new BdConector();
            db.addCliente(itens);
            db.FecharBd();

            //retorna mensagem de sucesso
            var response = new HttpResponseMessage(HttpStatusCode.Created);
            return response;
        }
    }
}
