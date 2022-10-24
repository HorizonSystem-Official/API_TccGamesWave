using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Models
{
    public class Cliente
    {
        public string CPF { get; set; }
        public string NomeCliente { get; set; }
        public DateTime DataNasc { get; set; }    
        public string Senha { get; set; }
        public string EmailCli { get; set; }
        public string CepCli { get; set; }
        public string NumEndCli { get; set; }
        public string TelCli { get; set; }
    }
}