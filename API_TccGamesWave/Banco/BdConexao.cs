using API_TccGamesWave.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace API_TccGamesWave.Banco
{
    public class BdConexao
    {
        public class BdConector
        {
            MySqlConnection conexao;

            public BdConector()
            {
                //cria conexão
                conexao = new MySqlConnection(ConfigurationManager.ConnectionStrings["conexao"].ConnectionString);
                conexao.Open();

            }

            public void FecharBd()
            {
                conexao.Close();
            }


            //Selecet umn
            public List<Produto> SelecionaUmProdSimples(int idProd)
            {

                MySqlCommand cmd = new MySqlCommand("call spMostraProdSimples(@idProd)", conexao);
                cmd.Parameters.AddWithValue("@idProd", idProd);
                MySqlDataReader reader = cmd.ExecuteReader();
                List<Produto> prods = new List<Produto>();
                while (reader.Read())
                {
                    var TempProd = new Produto()
                    {
                        CodProd = int.Parse(reader["codProd"].ToString()),
                        ProdNome = reader["prodNome"].ToString(),
                        ProdTipo = reader["prodTipo"].ToString(),
                        ProdValor = decimal.Parse(reader["prodValor"].ToString()),
                        ImgCapa = reader["imgCapa"].ToString()
                    };

                    prods.Add(TempProd);
                }
                reader.Close();
                return prods;
            }
        }
    }
}