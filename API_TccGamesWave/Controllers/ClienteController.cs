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
        public IEnumerable<Cliente> DadosCliente(string CpfCli)
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
        public IEnumerable<Cliente> LoginCliente(string Emailcli, string senhaCli)
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
    }
}
