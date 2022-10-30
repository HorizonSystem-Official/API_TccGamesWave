using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Models
{
    public class Comentarios
    {
        public int CodCometario { get; set; }
        public string TxtComentario { get; set; }
        public string NomeCliente { get; set; }

        public Comentarios()
        {
        }

        public Comentarios(int codCometario, string txtComentario, string nomeCliente)
        {
            CodCometario = codCometario;
            TxtComentario = txtComentario;
            NomeCliente = nomeCliente;
        }
    }
}